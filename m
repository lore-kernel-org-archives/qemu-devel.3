Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30234606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=vRHBh5kW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IX-0001DL-Hd; Mon, 16 Nov 2026 15:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IU-0000ud-0O; Mon, 16 Nov 2026 15:27:26 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IR-0001Ob-ID; Mon, 16 Nov 2026 15:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=VXKQzkmYGQ6L0Mi0TWERGS/qULzY3V+VcZx/TCFdTyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vRHBh5kWYSZYK+ejyMqqLQYDFTPZNwUjmY7PkCTFV1nflo4yV4hQBhZvfbX0QhhQ1
 V46bpZWWAR9RZB2WdpyOGK4ypjOeetl26VMnWCXVX0aAp71uW6PwbN/eiSpNckpKMi
 k1Twep0EREE/nXiLIID0Q+vzU7P0qM1tpKW9y1i3UvIEOV6LxrnpLtsA/Zz1GzovDa
 V839t2YBYYhMa7Idk5wCQolN7fD6aVoiEtMb4nQVPG5tk4GCTqsCbLyDseUNlPNGaL
 P1fYrPbJo7G6jcvLung0w64cxD+oGRxO82Cs337CM4gvPmXxxGAdRKljaYj9XTeOnZ
 kv7aveOliFEug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 147D91E71A8;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0FA5E45FBD4;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A05E3B8E6C; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daejun Park <daejun7.park@samsung.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 19/63] hw/ufs: Fail SCSI commands that move data
 without a PRDT
Date: Mon, 16 Nov 2026 23:24:58 +0300
Message-ID: <20261116202554.535325-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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
index 13f4a901454..2da5bb50fb0 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -368,6 +368,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    SCSIRequest *scsi_req;
+    uint32_t len;
 
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
@@ -379,11 +381,24 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
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
index 464fd465b3c..e302bccc954 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2118,10 +2118,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
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
index feb47f460d1..650e069f645 100644
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
index 9a9c5ca8346..ea7b9aa62a7 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -770,6 +770,50 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
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
@@ -1721,6 +1765,7 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("legacy-read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
+    qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,
-- 
2.47.3


