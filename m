Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43137C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMOD-0000G9-TH; Mon, 27 Jul 2026 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>)
 id 1woMO3-0000FN-2L; Mon, 27 Jul 2026 10:32:59 -0400
Received: from [115.124.28.45] (helo=out28-45.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>)
 id 1woMNy-0001xA-RJ; Mon, 27 Jul 2026 10:32:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07183095|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00530952-0.00409479-0.990596;
 FP=11345540682718118353|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam011083013073; MF=mail@jiesong.me; NM=1; PH=DS; RN=7;
 RT=7; SR=0; TI=SMTPD_---.iWYIJgj_1785162500; 
Received: from Moon.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.iWYIJgj_1785162500 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 27 Jul 2026 22:28:26 +0800
From: Jie Song <mail@jiesong.me>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com, farosas@suse.de,
 qemu-stable@nongnu.org, songjie_yewu@cmss.chinamobile.com
Subject: [PATCH v2] scsi-disk: Fix UNMAP drain race with migration
Date: Mon, 27 Jul 2026 22:28:15 +0800
Message-ID: <20260727142815.6869-1-mail@jiesong.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260707152037.11352-1-mail@jiesong.me>
References: <20260707152037.11352-1-mail@jiesong.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.45 (deferred)
Received-SPF: pass client-ip=115.124.28.45; envelope-from=mail@jiesong.me;
 helo=out28-45.mail.aliyun.com
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

In two stress-test runs with Windows ReTrim active, unpatched QEMU crashed
on the 15th and 18th live migration.  With this change, corresponding runs
completed 100 and 50 consecutive migrations without a crash.  GDB analysis
of the QEMU core dump from current master showed that the crashing discard
AIO had scsi_unmap_complete registered as its completion callback, with 26
UNMAP descriptors still pending, while the block node receiving the discard
had already been marked BDRV_O_INACTIVE.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
---
Changes in v2:
- Drop the multiple-descriptor qtest because it did not exercise the
  drain/inactivation race.
- Add stress-test results and core dump evidence to the commit message.
- Rebase onto QEMU master at 6333226c2a.

v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02176.html

 hw/scsi/scsi-disk.c | 90 ++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c..e24b61f186 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1741,70 +1741,82 @@ static inline bool check_lba_range(SCSIDiskState *s,
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
@@ -1812,7 +1824,8 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint8_t *p = inbuf;
     int len = r->req.cmd.xfer;
-    UnmapCBData *data;
+    UnmapAIOCB *data;
+    Coroutine *co;
 
     /* Reject ANCHOR=1.  */
     if (r->req.cmd.buf[1] & 0x1) {
@@ -1838,14 +1851,17 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
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
-- 
2.48.1

