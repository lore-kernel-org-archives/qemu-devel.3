Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB878606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=XGhJjHXV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Bh-0006qr-Pv; Mon, 16 Nov 2026 15:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Bd-0006nf-0q; Mon, 16 Nov 2026 15:20:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ba-00069n-BW; Mon, 16 Nov 2026 15:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=QvbmtuxWQFX+6vBs5yY7YS7reS0fb2fEw5Ub2DYUXfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XGhJjHXVCescIsx7cAr3DVTTI+0HSXL3MoErMtBSmCszKx6wmAFTlyAjPdZGEh9fC
 aps3kR9JP0NqwnEG667DVKYNh+N4+Nd10QqqMNNuc6kJRJ0DKHZfFvP7hxS1dc4r4M
 3So9nMbwPA+PBTa+nkwLsp59at8GjI+b5/GR4z/7EK2NNuH0sv+5gte6BRHFGV7Dzd
 ftpmRn26wICmocQ5L3U/rUSEoo0/QKydka1KMNwxNrMr3edx2hpKINULk3Wlvzoc6U
 6M0RVmQ1dzUW0OS9UjbRWY22AZzJsrz7kKlCZbmw0/YWFQhVPy1EYTvnWhCSdqqWI0
 clHXAWffMJkWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9CEC71E7143;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9974745FB79;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 63B90B8DE8; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daejun Park <daejun7.park@samsung.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 13/59] hw/ufs: Fail SCSI commands that move data
 without a PRDT
Date: Mon, 16 Nov 2026 23:18:17 +0300
Message-ID: <20261116201922.534306-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

A command whose CDB transfers data, sent with a PRDT length of 0,
reaches scsi-hd without an SG list. The SCSI layer then calls the
transfer_data callback of the bus, which ufs_scsi_info does not set, and
QEMU dies with SIGSEGV. A guest triggers this with, for example, an
INQUIRY whose PRDT is empty; the new no-prdt qtest crashed QEMU before
this change.

Check the transfer direction that scsi_req_new() parsed, and fail such a
command with OCS MISMATCH DATA BUFFER SIZE before it reaches scsi-hd:
the PRDT describes less data than the command moves. virtio-scsi
likewise fails a command that has no matching buffer
(VIRTIO_SCSI_S_OVERRUN). A request that only reports a pending unit
attention moves no data and goes through, so that the guest still sees
the unit attention.

Handing scsi-hd an empty SG list instead is not enough: READ and WRITE
then complete synchronously in dma_blk_io() and trip the assertion in
scsi_dma_complete().

Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
Cc: qemu-stable@nongnu.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit 4992210c844592663e8f3265cd4ff47c0bf03d6f)
(Mjt: context fixup across missing v11.1.0-2246-gcd8fecdaefdf
 "hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 50549d35a0b..7d052c954e9 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -250,6 +250,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    SCSIRequest *scsi_req;
+    uint32_t len;
 
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
@@ -261,11 +263,24 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }
 
-    SCSIRequest *scsi_req =
-        scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
-                     UFS_CDB_SIZE, req);
+    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun,
+                            req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
 
-    uint32_t len = scsi_req_enqueue(scsi_req);
+    /*
+     * A command that moves data needs a PRDT. Without one there is no SG
+     * list, and the SCSI layer would call the transfer_data callback, which
+     * ufs-lu does not set. Fail the request with OCS MISMATCH DATA BUFFER
+     * SIZE, as virtio-scsi fails a buffer that does not match the command.
+     * A request that reports a pending unit attention instead moves no data;
+     * its sense is already set, so let it through and the guest sees the UA.
+     */
+    if (scsi_req->cmd.mode != SCSI_XFER_NONE && !req->sg &&
+        !scsi_req->sense_len) {
+        scsi_req_unref(scsi_req);
+        return UFS_REQUEST_MISMATCH_DATA_BUF;
+    }
+
+    len = scsi_req_enqueue(scsi_req);
     if (len) {
         scsi_req_continue(scsi_req);
     }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 6144e727dd4..f7de13f6972 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1649,10 +1649,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
     UfsHc *u = req->hc;
     assert(req->state == UFS_REQUEST_RUNNING);
 
-    if (req_result == UFS_REQUEST_SUCCESS) {
+    switch (req_result) {
+    case UFS_REQUEST_SUCCESS:
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_SUCCESS);
-    } else {
+        break;
+    case UFS_REQUEST_MISMATCH_DATA_BUF:
+        req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+        break;
+    default:
         req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
+        break;
     }
 
     req->state = UFS_REQUEST_COMPLETE;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 9e800cafacd..7cf30af00f3 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -44,6 +44,8 @@ typedef enum UfsReqResult {
     UFS_REQUEST_SUCCESS = 0,
     UFS_REQUEST_FAIL = 1,
     UFS_REQUEST_NO_COMPLETE = 2,
+    /* The PRDT describes less data than the command moves */
+    UFS_REQUEST_MISMATCH_DATA_BUF = 3,
 } UfsReqResult;
 
 #define UFS_INVALID_SLOT (-1)
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index eccf151c41a..12fd73ea882 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -769,6 +769,50 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_no_prdt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t buf[4096];
+    const uint8_t inquiry_cdb[UFS_CDB_SIZE] = {
+        /* INQUIRY, allocation length 36 */
+        INQUIRY, 0x00, 0x00, 0x00, 0x24
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 1 */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+
+    ufs_init(ufs, alloc);
+
+    /* A pending unit attention is reported even without a PRDT */
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0xf, ==, UNIT_ATTENTION);
+
+    /* Commands that move data but come without a PRDT fail */
+    ocs = ufs_send_scsi_command(ufs, test_lun, inquiry_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    /* The logical unit keeps working */
+    ocs = ufs_send_scsi_command(ufs, test_lun, inquiry_cdb, NULL, 0, buf, 0x24,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(buf[0] & 0x1f, ==, TYPE_DISK);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1272,6 +1316,7 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
-- 
2.47.3


