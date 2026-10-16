Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C26CCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeHb-0000zU-5T; Fri, 16 Oct 2026 05:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeHX-0000z6-79
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:31:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xHeHT-0005Oe-2H
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:31:18 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261016093111epoutp03545d075fa79dbe03ce5cc75991d4d3c9~e_KDIW7Ay0398403984epoutp03X
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261016093111epoutp03545d075fa79dbe03ce5cc75991d4d3c9~e_KDIW7Ay0398403984epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792143071;
 bh=qzs23J8Ek+xWmCIsXyDoe6aI3DHypACfRA2VUFrB5ug=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=GBjIpvUbMdlhneCqm3TULsAtUDxDKa1hmB6loDL4H+otoRIedyiG+mUXycOCs2vOx
 R+uukZpx/LQo37UDjgw5423lkBjHNebJNgtZpxRPyXEpHO4yUIj8f2aJ1W7eX9D8Mq
 GjAqm8L5skSioEoW+HoG7DK+2CVKurCm34PcPsEg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20261016093110epcas2p239fd52014abae3fe8c8f23e0865ca43b~e_KC1phr13025730257epcas2p2j;
 Fri, 16 Oct 2026 09:31:10 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.206]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4j5fnp3hJlz6B9m6; Fri, 16 Oct
 2026 09:31:10 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2 3/6] hw/ufs: Limit data transfers to the transfer length
 of the CDB
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5@epcms2p4>
Date: Fri, 16 Oct 2026 18:31:09 +0900
X-CMS-MailID: 20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5
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
 <CGME20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p4>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

scsi-hd moves as many bytes as the SG list of a request holds, and
ufs-lu builds that list from the whole PRDT. When the PRDT is larger
than the transfer length in the CDB, a WRITE writes more blocks than
the CDB names and a READ reads more. A one-block WRITE(10) at LBA 0
with an 8 KiB PRDT also wrote LBA 1, and its response reported no
residual. A UFS device transfers what the CDB asks for and reports the
rest of the Expected Data Transfer Length as a residual.

The commands that scsi-hd emulates had their residual computed against
the PRDT too: an INQUIRY with an allocation length of 36, a 4 KiB PRDT
and an Expected Data Transfer Length of 4096 reported an overflow of
4294959176 bytes. It now reports an underflow of 4060.

Cut the SG list to the transfer length of the parsed command before
the request reaches scsi-hd. The new long-prdt qtest failed before this
change.

Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c            | 28 ++++++++++++++++++++
 tests/qtest/ufs-test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index b812e1bef8..bebe4eaac2 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -379,6 +379,24 @@ static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
     return UFS_REQUEST_SUCCESS;
 }
 
+/* Keep only the first len bytes of the SG list built from the PRDT */
+static void ufs_limit_sg_list(UfsRequest *req, uint64_t len)
+{
+    QEMUSGList *prdt_sg = req->sg;
+    QEMUSGList *sg = g_new0(QEMUSGList, 1);
+    int i;
+
+    qemu_sglist_init(sg, prdt_sg->dev, prdt_sg->nsg, prdt_sg->as);
+    for (i = 0; i < prdt_sg->nsg && sg->size < len; i++) {
+        qemu_sglist_add(sg, prdt_sg->sg[i].base,
+                        MIN(prdt_sg->sg[i].len, len - sg->size));
+    }
+    qemu_sglist_destroy(prdt_sg);
+    g_free(prdt_sg);
+    req->sg = sg;
+    req->data_len = sg->size;
+}
+
 static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
@@ -425,6 +443,16 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
         return UFS_REQUEST_FAIL;
     }
 
+    /*
+     * scsi-hd moves as many bytes as the SG list holds, while a UFS device
+     * transfers what the CDB asks for. Cut a longer SG list to the transfer
+     * length; the response reports the rest of the Expected Data Transfer
+     * Length as a residual.
+     */
+    if (req->sg && req->sg->size > scsi_req->cmd.xfer) {
+        ufs_limit_sg_list(req, scsi_req->cmd.xfer);
+    }
+
     req->sreq = scsi_req;
 
     len = scsi_req_enqueue(scsi_req);
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 594b91706b..4e0c2aee5f 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -859,6 +859,76 @@ static void ufstest_sync_cache(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_long_prdt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    /* One block at LBA 0 and at LBA 1 */
+    const uint8_t write_lba0_cdb[UFS_CDB_SIZE] = {
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
+    };
+    const uint8_t read_lba0_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
+    };
+    const uint8_t read_lba1_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00,
+    };
+    /* Allocation length 36 */
+    const uint8_t inquiry_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x00, 0x00, 0x00, 0x24, 0x00,
+    };
+    uint8_t buf[2 * 4096];
+    uint8_t zero_buf[4096] = { 0 };
+    uint8_t write_buf[2 * 4096];
+    UtpUpiuRsp rsp_upiu, write_rsp_upiu;
+    enum UtpOcsCodes ocs;
+
+    ufs_init(ufs, alloc);
+    ocs = ufs_send_scsi_command(ufs, 1, request_sense_cdb, NULL, 0, buf, 4096,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    /* A one-block WRITE with a two-block PRDT writes one block */
+    memset(write_buf, 0xa5, sizeof(write_buf));
+    ocs = ufs_send_scsi_command(ufs, 1, write_lba0_cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &write_rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(write_rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ocs = ufs_send_scsi_command(ufs, 1, read_lba1_cdb, NULL, 0, buf, 4096,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpmem(buf, 4096, zero_buf, sizeof(zero_buf));
+
+    g_assert_cmpuint(write_rsp_upiu.header.flags, ==, UFS_UPIU_FLAG_UNDERFLOW);
+    g_assert_cmpuint(be32_to_cpu(write_rsp_upiu.sr.residual_transfer_count),
+                     ==, 4096);
+
+    /* A one-block READ with a two-block PRDT reads one block */
+    ocs = ufs_send_scsi_command(ufs, 1, read_lba0_cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(rsp_upiu.header.flags, ==, UFS_UPIU_FLAG_UNDERFLOW);
+    g_assert_cmpuint(be32_to_cpu(rsp_upiu.sr.residual_transfer_count), ==,
+                     4096);
+    g_assert_cmpmem(buf, 4096, write_buf, 4096);
+
+    /* A 36-byte INQUIRY with a 4 KiB PRDT reports the rest as a residual */
+    ocs = ufs_send_scsi_command(ufs, 1, inquiry_cdb, NULL, 0, buf, 4096,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(rsp_upiu.header.flags, ==, UFS_UPIU_FLAG_UNDERFLOW);
+    g_assert_cmpuint(be32_to_cpu(rsp_upiu.sr.residual_transfer_count), ==,
+                     4096 - 36);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1812,6 +1882,7 @@ static void ufs_register_nodes(void)
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
     qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
     qos_add_test("sync-cache", "ufs", ufstest_sync_cache, &io_test_opts);
+    qos_add_test("long-prdt", "ufs", ufstest_long_prdt, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,

-- 
2.43.0

