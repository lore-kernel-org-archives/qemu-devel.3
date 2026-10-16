Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C118CCCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeCC-0006Ba-94; Fri, 16 Oct 2026 05:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeC6-000682-7b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:25:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeC3-0004pb-KP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:25:41 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20261016092534epoutp02ca7ed7a1a1974a187d3489fb71814eae~e_FJnk4Wk1336013360epoutp02H
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20261016092534epoutp02ca7ed7a1a1974a187d3489fb71814eae~e_FJnk4Wk1336013360epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792142734;
 bh=rNKDRC7J/oEq5whf0iU0ZDInkelcmeYhdHSXAt/Jhag=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=sbU9ozjhzQHBROeBWLA5olMN6H8zhmZhq12tDTbcf4Ts/vrEuEYih3l/LmDMa4ql4
 HH471T/FLm5ejQKBrBi31+F1E3NwbOT6cr3V0ZJ2bilR9WlqYHQPpBkkwCNF6p5Y9O
 0eNkJSdu0Vn/FCDgE67X148NR6LVJ4Dvplmv1iM4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20261016092534epcas2p2d4fb088400a59981610f121042021c11~e_FJVYhxR2464624646epcas2p2Z;
 Fri, 16 Oct 2026 09:25:34 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.201]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j5fgK6rzlz2SSKd; Fri, 16 Oct
 2026 09:25:33 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2 1/6] hw/ufs: Fail SCSI commands that move data without a
 PRDT
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261016092533epcms2p5d94645ba46656ca173090548261fc17b@epcms2p5>
Date: Fri, 16 Oct 2026 18:25:33 +0900
X-CMS-MailID: 20261016092533epcms2p5d94645ba46656ca173090548261fc17b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <CGME20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p5>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A command whose CDB transfers data, sent with a PRDT length of 0,
reaches scsi-hd without an SG list. The SCSI layer then calls the
transfer_data callback of the bus, which ufs_scsi_info does not set, and
QEMU dies with SIGSEGV. A guest triggers this with, for example, an
INQUIRY whose PRDT is empty; the new no-prdt qtest crashed QEMU before
this change.

Check the transfer direction that scsi_req_new() parsed, and fail such a
command with OCS INVALID COMMAND TABLE ATTRIBUTES before it reaches
scsi-hd. virtio-scsi likewise fails a command that has no matching
buffer (VIRTIO_SCSI_S_OVERRUN). A request that only reports a pending
unit attention moves no data and goes through, so that the guest still
sees the unit attention.

Handing scsi-hd an empty SG list instead is not enough: READ and WRITE
then complete synchronously in dma_blk_io() and trip the assertion in
scsi_dma_complete().

Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
Cc: qemu-stable@nongnu.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c            | 24 ++++++++++++++++++++----
 tests/qtest/ufs-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 5905c49fac..1853284acf 100644
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
+     * ufs-lu does not set. Fail the request, as virtio-scsi does when the
+     * buffer does not match the command. A request that reports a pending
+     * unit attention instead moves no data; its sense is already set, so let
+     * it through and the guest sees the UA.
+     */
+    if (scsi_req->cmd.mode != SCSI_XFER_NONE && !req->sg &&
+        !scsi_req->sense_len) {
+        scsi_req_unref(scsi_req);
+        return UFS_REQUEST_FAIL;
+    }
+
     req->sreq = scsi_req;
 
-    uint32_t len = scsi_req_enqueue(scsi_req);
+    len = scsi_req_enqueue(scsi_req);
     if (len) {
         scsi_req_continue(scsi_req);
     }
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9a9c5ca834..63f805419e 100644
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
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+
+    ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
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

