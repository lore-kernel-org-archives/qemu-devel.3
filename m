Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D72606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=eWRjQofZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxYC-0005K1-Hf; Mon, 19 Oct 2026 20:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxY3-0005FZ-LD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:17:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxY0-0003Or-Mu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:17:47 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261020001739epoutp033bc36f49c6ca4f83d4d41aa625551987~gFL5ohTsX0924909249epoutp03m
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:17:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261020001739epoutp033bc36f49c6ca4f83d4d41aa625551987~gFL5ohTsX0924909249epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792455459;
 bh=LrFeW/yEBp2dJ1K63CtmLTPigywhfDKuHTqi7GMDtIA=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=eWRjQofZQLJjJYTDMB9Ug+Ls+dkKRasuQd635sV6wc+Wl9GAGB5f36bjPo9czdTBR
 3bsa0o3dW+5Vb86g9tFHxGZ3mH4W89TUiB75RXpbG2tbpyvZlmfGmC+hQF1K0HPrGB
 sk5ylFTlMc/LsuRVAPIuphQ5pLrAx0HMjWTxCZIE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261020001739epcas2p4a8d8658b91e95dc97e86a5d653353e0c~gFL5XTIXi1254212542epcas2p4o;
 Tue, 20 Oct 2026 00:17:39 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.208]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4j7tKH1QgCz6B9mD; Tue, 20 Oct
 2026 00:17:39 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 1/6] hw/ufs: Fail SCSI commands that move data without a
 PRDT
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, Keoseong Park <keosung.park@samsung.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Daejun Park
 <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261020001738epcms2p44708febeb26b208e427c34883225650d@epcms2p4>
Date: Tue, 20 Oct 2026 09:17:38 +0900
X-CMS-MailID: 20261020001738epcms2p44708febeb26b208e427c34883225650d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8
References: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p4>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 hw/ufs/lu.c            | 24 ++++++++++++++++++++----
 hw/ufs/ufs.c           | 10 ++++++++--
 hw/ufs/ufs.h           |  2 ++
 tests/qtest/ufs-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 5905c49fac..fb72416fe1 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -382,6 +382,8 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
+    SCSIRequest *scsi_req;
+    uint32_t len;
 
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
@@ -393,12 +395,26 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return ufs_emulate_scsi_cmd(lu, req);
     }
 
-    SCSIRequest *scsi_req =
-        scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
-                     UFS_CDB_SIZE, req);
+    scsi_req = scsi_req_new(lu->scsi_dev, task_tag, lu->lun,
+                            req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
+
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
     req->sreq = scsi_req;
 
-    uint32_t len = scsi_req_enqueue(scsi_req);
+    len = scsi_req_enqueue(scsi_req);
     if (len) {
         scsi_req_continue(scsi_req);
     }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index f008af7467..dda615da7c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2451,10 +2451,16 @@ void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
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
index 265a43faaa..adf74b6833 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -47,6 +47,8 @@ typedef enum UfsReqResult {
     UFS_REQUEST_SUCCESS = 0,
     UFS_REQUEST_FAIL = 1,
     UFS_REQUEST_NO_COMPLETE = 2,
+    /* The PRDT describes less data than the command moves */
+    UFS_REQUEST_MISMATCH_DATA_BUF = 3,
 } UfsReqResult;
 
 #define UFS_INVALID_SLOT (-1)
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9a9c5ca834..ea7b9aa62a 100644
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
2.43.0

