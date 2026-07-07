Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C10C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7lA-00080G-UO; Tue, 07 Jul 2026 11:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>)
 id 1wh7l7-0007uV-TY; Tue, 07 Jul 2026 11:30:54 -0400
Received: from [115.124.28.83] (helo=out28-83.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>)
 id 1wh7l3-0000Jm-0e; Tue, 07 Jul 2026 11:30:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0083374-0.00179887-0.989864;
 FP=11273465595276321241|1|1|1|0|-1|-1|-1;
 HT=maildocker-contentspam033037022039; MF=mail@jiesong.me; NM=1; PH=DS; RN=8;
 RT=8; SR=0; TI=SMTPD_---.iFWF8jx_1783437651; 
Received: from Moon.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.iFWF8jx_1783437651 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 07 Jul 2026 23:21:05 +0800
From: Jie Song <mail@jiesong.me>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com, farosas@suse.de,
 lvivier@redhat.com, qemu-stable@nongnu.org,
 Jie Song <songjie_yewu@cmss.chinamobile.com>
Subject: [PATCH] scsi-disk: Fix UNMAP drain race with migration
Date: Tue,  7 Jul 2026 23:20:37 +0800
Message-ID: <20260707152037.11352-1-mail@jiesong.me>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.83 (deferred)
Received-SPF: pass client-ip=115.124.28.83; envelope-from=mail@jiesong.me;
 helo=out28-83.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jie Song <songjie_yewu@cmss.chinamobile.com>

Windows guests can send SCSI UNMAP requests with many descriptors when
running ReTrim.  scsi-disk currently submits one blk_aio_pdiscard()
request per descriptor and chains the next descriptor from the completion
callback.

If migration stops the VM while this chain is running, the next discard
can enter blk_wait_while_drained() with flags == 0 and be queued as a new
BlockBackend request.  This can make the BlockBackend look drained before
the whole UNMAP command has completed.  The migration completion path can
then inactivate block nodes, and the queued discard later resumes and hits
this assertion in bdrv_co_write_req_prepare():

    qemu-system-x86_64: ../block/io.c:1986:
    bdrv_co_write_req_prepare: Assertion
    `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

The corresponding backtrace is:

    bdrv_co_write_req_prepare
    bdrv_co_pdiscard
    blk_co_do_pdiscard
    blk_aio_pdiscard_entry
    coroutine_trampoline

Process the whole UNMAP descriptor list as a single BlockBackend macro
request instead.  Use blk_co_start_request()/blk_end_request() around the
whole descriptor loop and submit the internal discards with
BDRV_REQ_NO_QUEUE.  This follows the same block-layer model used by commit
095c08a7ba68 ("ide: Minimal fix for deadlock between TRIM and drain"),
which fixed chained IDE TRIM discards by running them from a coroutine and
using BDRV_REQ_NO_QUEUE under blk_co_start_request().

Because blk_co_pdiscard() does not return a BlockAIOCB, keep an outer
UnmapAIOCB attached to the SCSI request while the coroutine is running.
This preserves SCSI reset/TMF cancellation semantics: cancellation marks
the outer AIOCB as canceled, and the coroutine completes cancellation at a
safe point instead of letting the SCSI layer complete the request early.

Add a virtio-scsi qtest that sends one UNMAP command with 64 descriptors,
matching the kind of batched request that triggers the migration race.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
---
 hw/scsi/scsi-disk.c            | 90 ++++++++++++++++++++--------------
 tests/qtest/virtio-scsi-test.c | 36 ++++++++++++++
 2 files changed, 89 insertions(+), 37 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5ba5b46c4f..6cf1f60957 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1736,70 +1736,82 @@ static inline bool check_lba_range(SCSIDiskState *s,
             sector_num + nb_sectors <= s->qdev.max_lba + 1);
 }
 
-typedef struct UnmapCBData {
+typedef struct UnmapAIOCB {
+    BlockAIOCB common;
     SCSIDiskReq *r;
     uint8_t *inbuf;
     int count;
-} UnmapCBData;
+    bool canceled;
+} UnmapAIOCB;
 
-static void scsi_unmap_complete(void *opaque, int ret);
+static void scsi_unmap_cancel(BlockAIOCB *acb)
+{
+    UnmapAIOCB *data = container_of(acb, UnmapAIOCB, common);
+
+    data->canceled = true;
+}
+
+static const AIOCBInfo scsi_unmap_aiocb_info = {
+    .aiocb_size = sizeof(UnmapAIOCB),
+    .cancel_async = scsi_unmap_cancel,
+};
 
-static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
+static void coroutine_fn scsi_unmap_co_entry(void *opaque)
 {
+    UnmapAIOCB *data = opaque;
     SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    BlockBackend *blk = s->qdev.conf.blk;
 
-    assert(r->req.aiocb == NULL);
+    /* Paired with blk_end_request() below. */
+    blk_co_start_request(blk);
 
-    if (data->count > 0) {
+    while (data->count > 0) {
         uint64_t sector_num = ldq_be_p(&data->inbuf[0]);
         uint32_t nb_sectors = ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
+        int ret;
+
+        if (data->canceled) {
+            r->req.aiocb = NULL;
+            scsi_req_cancel_complete(&r->req);
+            goto done;
+        }
+
         r->sector = sector_num * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         r->sector_count = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
 
         if (!check_lba_range(s, sector_num, nb_sectors)) {
-            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
-                               BLOCK_ACCT_UNMAP);
+            r->req.aiocb = NULL;
+            block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_UNMAP);
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
 
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+        block_acct_start(blk_get_stats(blk), &r->acct,
                          r->sector_count * BDRV_SECTOR_SIZE,
                          BLOCK_ACCT_UNMAP);
 
-        r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
-                                        r->sector * BDRV_SECTOR_SIZE,
-                                        r->sector_count * BDRV_SECTOR_SIZE,
-                                        scsi_unmap_complete, data);
+        ret = blk_co_pdiscard(blk, r->sector * BDRV_SECTOR_SIZE,
+                              r->sector_count * BDRV_SECTOR_SIZE,
+                              BDRV_REQ_NO_QUEUE);
+        r->req.aiocb = NULL;
+        if (scsi_disk_req_check_error(r, ret, true)) {
+            goto done;
+        }
+
+        block_acct_done(blk_get_stats(blk), &r->acct);
         data->count--;
         data->inbuf += 16;
-        return;
+        r->req.aiocb = &data->common;
     }
 
+    r->req.aiocb = NULL;
     scsi_req_complete(&r->req, GOOD);
 
 done:
+    qemu_aio_unref(data);
     scsi_req_unref(&r->req);
-    g_free(data);
-}
-
-static void scsi_unmap_complete(void *opaque, int ret)
-{
-    UnmapCBData *data = opaque;
-    SCSIDiskReq *r = data->r;
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-
-    if (scsi_disk_req_check_error(r, ret, true)) {
-        scsi_req_unref(&r->req);
-        g_free(data);
-    } else {
-        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
-        scsi_unmap_complete_noio(data, ret);
-    }
+    blk_end_request(blk);
 }
 
 static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
@@ -1807,7 +1819,8 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint8_t *p = inbuf;
     int len = r->req.cmd.xfer;
-    UnmapCBData *data;
+    UnmapAIOCB *data;
+    Coroutine *co;
 
     /* Reject ANCHOR=1.  */
     if (r->req.cmd.buf[1] & 0x1) {
@@ -1833,14 +1846,17 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
-    data = g_new0(UnmapCBData, 1);
+    data = blk_aio_get(&scsi_unmap_aiocb_info, s->qdev.conf.blk, NULL, NULL);
     data->r = r;
     data->inbuf = &p[8];
     data->count = lduw_be_p(&p[2]) >> 4;
+    data->canceled = false;
 
-    /* The matching unref is in scsi_unmap_complete, before data is freed.  */
+    /* The matching unref is in scsi_unmap_co_entry(). */
     scsi_req_ref(&r->req);
-    scsi_unmap_complete_noio(data, 0);
+    r->req.aiocb = &data->common;
+    co = qemu_coroutine_create(scsi_unmap_co_entry, data);
+    aio_co_enter(qemu_get_current_aio_context(), co);
     return;
 
 invalid_param_len:
diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index e2350c52f6..74616bf92d 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/module.h"
 #include "scsi/constants.h"
@@ -236,6 +237,37 @@ static void test_unmap_large_lba(void *obj, void *data,
     qvirtio_scsi_pci_free(vs);
 }
 
+static void test_unmap_multiple_descriptors(void *obj, void *data,
+                                            QGuestAllocator *t_alloc)
+{
+    enum { NUM_DESCRIPTORS = 64 };
+    QVirtioSCSI *scsi = obj;
+    QVirtioSCSIQueues *vs;
+    uint8_t unmap[VIRTIO_SCSI_CDB_SIZE] = { 0x42 };
+    uint8_t unmap_params[8 + NUM_DESCRIPTORS * 16] = { 0 };
+    struct virtio_scsi_cmd_resp resp;
+    int i;
+
+    stw_be_p(&unmap_params[0], sizeof(unmap_params) - 2);
+    stw_be_p(&unmap_params[2], NUM_DESCRIPTORS * 16);
+    for (i = 0; i < NUM_DESCRIPTORS; i++) {
+        stq_be_p(&unmap_params[8 + i * 16], i * 2);
+        stl_be_p(&unmap_params[16 + i * 16], 1);
+    }
+    unmap[7] = sizeof(unmap_params) >> 8;
+    unmap[8] = sizeof(unmap_params) & 0xff;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
+
+    virtio_scsi_do_command(vs, unmap, NULL, 0, unmap_params,
+                           sizeof(unmap_params), &resp);
+    g_assert_cmphex(resp.response, ==, 0);
+    g_assert_cmphex(resp.status, !=, CHECK_CONDITION);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
 static void test_write_to_cdrom(void *obj, void *data,
                                 QGuestAllocator *t_alloc)
 {
@@ -399,6 +431,10 @@ static void register_virtio_scsi_test(void)
     qos_add_test("large-lba-unmap", "virtio-scsi",
                  test_unmap_large_lba, &opts);
 
+    opts.before = virtio_scsi_setup;
+    qos_add_test("multiple-descriptor-unmap", "virtio-scsi",
+                 test_unmap_multiple_descriptors, &opts);
+
     opts.before = virtio_scsi_setup_cd;
     qos_add_test("write-to-cdrom", "virtio-scsi", test_write_to_cdrom, &opts);
 
-- 
2.48.1


