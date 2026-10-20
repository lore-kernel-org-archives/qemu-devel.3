Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7A606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SmOpnNHl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxZh-0006VC-Ef; Mon, 19 Oct 2026 20:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxZe-0006SF-HV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:19:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxZb-0003X1-Rk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:19:26 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261020001921epoutp03f894842fbf5a7aaef9ebec8051b047e7~gFNYVpxFv0886508865epoutp03W
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:19:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261020001921epoutp03f894842fbf5a7aaef9ebec8051b047e7~gFNYVpxFv0886508865epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792455561;
 bh=NiRK2C5NtVexQ5sqAwvpV1n1Y2GHtLzQr7iVLs4cYcA=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=SmOpnNHlyCsk+0wupXojq5tlO9UQXeHVrTQ4k5gMlmF0meRLLxIviXjdmaje6hv31
 A7p1QhcOwDVkvvN5eXfPYxZtPXFYb5P2LSi0+MOlz9sKL7aJEeyvKBh8wWEpBdgg2a
 5237SzaFsKkujwjAC9ju3ew7Vw45xg5OR95eMPEs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261020001920epcas2p40f0265121d4def15ee042a3fc2927a2e~gFNX7bz382222922229epcas2p4_;
 Tue, 20 Oct 2026 00:19:20 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.209]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j7tMD4MRyz2SSKd; Tue, 20 Oct
 2026 00:19:20 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 3/6] hw/ufs: Check the PRDT size against the transfer
 length of the CDB
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, Keoseong Park <keosung.park@samsung.com>, Daejun
 Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261020001920epcms2p4004ef6eaae9fd389e5fc91c104caf2c2@epcms2p4>
Date: Tue, 20 Oct 2026 09:19:20 +0900
X-CMS-MailID: 20261020001920epcms2p4004ef6eaae9fd389e5fc91c104caf2c2
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
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When the PRDT is smaller than the transfer length, scsi-hd moved what it
holds and the request completed without an error, for example a
two-block WRITE(10) with a 4 KiB PRDT. Such a request now fails with OCS
MISMATCH DATA BUFFER SIZE, as one without a PRDT does. As in
virtio-scsi, the PRDT is compared with the transfer length of the CDB,
which for commands that return data is the allocation length, and before
scsi-hd checks the CDB.

The new ufs_fit_data_buffer() in ufs.c, where the SG list is built from
the PRDT, cuts a longer list and reports a shorter one; ufs-lu passes it
the transfer length that scsi_req_new() parsed. The HID qtest wrote
eight blocks from a one-block buffer, so give it eight blocks. The new
long-prdt and short-prdt qtests failed before this change.

Fixes: 2a8b36a4967d ("hw/ufs: Support for UFS logical unit")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c            |  20 ++++---
 hw/ufs/trace-events    |   1 +
 hw/ufs/ufs.c           |  35 ++++++++++++
 hw/ufs/ufs.h           |   1 +
 tests/qtest/ufs-test.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 189 insertions(+), 9 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 1c4d34c1c0..0c0537cfee 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -412,15 +412,19 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
                             req);
 
     /*
-     * A command that moves data needs a PRDT. Without one there is no SG
-     * list, and the SCSI layer would call the transfer_data callback, which
-     * ufs-lu does not set. Fail the request with OCS MISMATCH DATA BUFFER
-     * SIZE, as virtio-scsi fails a buffer that does not match the command.
-     * A request that reports a pending unit attention instead moves no data;
-     * its sense is already set, so let it through and the guest sees the UA.
+     * scsi-hd moves as many bytes as the SG list holds, and without an SG
+     * list it would call the transfer_data callback, which ufs-lu does not
+     * set. A UFS device moves what the CDB asks for, so fit the PRDT to the
+     * transfer length, and fail a request whose PRDT describes less, a
+     * missing PRDT included, with OCS MISMATCH DATA BUFFER SIZE, as
+     * virtio-scsi fails a buffer that does not match the command. The
+     * response reports the rest of the Expected Data Transfer Length as a
+     * residual. A request that reports a pending unit attention moves no
+     * data; its sense is already set, so let it through and the guest sees
+     * the UA.
      */
-    if (scsi_req->cmd.mode != SCSI_XFER_NONE && !req->sg &&
-        !scsi_req->sense_len) {
+    if (!scsi_req->sense_len &&
+        !ufs_fit_data_buffer(req, scsi_req->cmd.xfer)) {
         scsi_req_unref(scsi_req);
         return UFS_REQUEST_MISMATCH_DATA_BUF;
     }
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 5e5a54a3fb..db9d172713 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -22,6 +22,7 @@ ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu. UTRLDBR slot %"PRIu32", request upiu addr %"PRIu64""
 ufs_err_dma_read_prdt(uint32_t slot, uint64_t addr) "failed to read prdt. UTRLDBR slot %"PRIu32", prdt addr %"PRIu64""
+ufs_err_mismatch_data_buf(uint32_t slot, uint8_t task_tag, uint64_t xfer, uint64_t prdt_size) "slot %"PRIu32", task tag %"PRIu8", transfer length %"PRIu64", PRDT %"PRIu64""
 ufs_err_dma_read_sq(uint8_t sqid, uint64_t addr) "failed to read sq entry. sqid %"PRIu8", hwaddr %"PRIu64""
 ufs_err_dma_write_utrd(uint32_t slot, uint64_t addr) "failed to write utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_write_rsp_upiu(uint32_t slot, uint64_t addr) "failed to write rsp upiu. UTRLDBR slot %"PRIu32", response upiu addr %"PRIu64""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index dda615da7c..cd28f97a12 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -227,6 +227,41 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
     return MEMTX_OK;
 }
 
+/*
+ * Fit the SG list built from the PRDT to the len bytes that the command of
+ * req moves: keep only the first len bytes of a longer list. Return false if
+ * the PRDT describes fewer than len bytes.
+ */
+bool ufs_fit_data_buffer(UfsRequest *req, uint64_t len)
+{
+    QEMUSGList *prdt_sg = req->sg;
+    uint64_t prdt_size = prdt_sg ? prdt_sg->size : 0;
+    QEMUSGList *sg;
+    int i;
+
+    if (prdt_size < len) {
+        trace_ufs_err_mismatch_data_buf(req->slot,
+                                        req->req_upiu.header.task_tag, len,
+                                        prdt_size);
+        return false;
+    }
+    if (prdt_size == len) {
+        return true;
+    }
+
+    sg = g_new0(QEMUSGList, 1);
+    qemu_sglist_init(sg, prdt_sg->dev, prdt_sg->nsg, prdt_sg->as);
+    for (i = 0; i < prdt_sg->nsg && sg->size < len; i++) {
+        qemu_sglist_add(sg, prdt_sg->sg[i].base,
+                        MIN(prdt_sg->sg[i].len, len - sg->size));
+    }
+    qemu_sglist_destroy(prdt_sg);
+    g_free(prdt_sg);
+    req->sg = sg;
+    req->data_len = sg->size;
+    return true;
+}
+
 static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
 {
     MemTxResult ret;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index adf74b6833..15b3a352f3 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -306,6 +306,7 @@ void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
                            uint16_t data_segment_length);
 void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
+bool ufs_fit_data_buffer(UfsRequest *req, uint64_t len);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 3c9e9e4032..e8993e8c24 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -859,6 +859,142 @@ static void ufstest_sync_cache(void *obj, void *data, QGuestAllocator *alloc)
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
+static void ufstest_short_prdt(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    /* Two blocks at LBA 2, and one */
+    const uint8_t write_2_cdb[UFS_CDB_SIZE] = {
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00,
+    };
+    const uint8_t read_2_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00,
+    };
+    const uint8_t write_1_cdb[UFS_CDB_SIZE] = {
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x01, 0x00,
+    };
+    const uint8_t read_1_cdb[UFS_CDB_SIZE] = {
+        READ_10, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x01, 0x00,
+    };
+    /* Allocation length 36 */
+    const uint8_t inquiry_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x00, 0x00, 0x00, 0x24, 0x00,
+    };
+    uint8_t buf[4096];
+    uint8_t zero_buf[4096] = { 0 };
+    uint8_t write_buf[4096];
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+
+    ufs_init(ufs, alloc);
+    ocs = ufs_send_scsi_command(ufs, 1, request_sense_cdb, NULL, 0, buf, 4096,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    memset(write_buf, 0x5a, sizeof(write_buf));
+
+    /* A PRDT that describes less than the command moves fails */
+    ocs = ufs_send_scsi_command(ufs, 1, write_2_cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    ocs = ufs_send_scsi_command(ufs, 1, read_2_cdb, NULL, 0, buf, sizeof(buf),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    ocs = ufs_send_scsi_command(ufs, 1, inquiry_cdb, NULL, 0, buf, 16,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    /* The failed WRITE wrote nothing */
+    ocs = ufs_send_scsi_command(ufs, 1, read_1_cdb, NULL, 0, buf, sizeof(buf),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpmem(buf, sizeof(buf), zero_buf, sizeof(zero_buf));
+
+    /* A matching PRDT still works */
+    ocs = ufs_send_scsi_command(ufs, 1, write_1_cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ocs = ufs_send_scsi_command(ufs, 1, read_1_cdb, NULL, 0, buf, sizeof(buf),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpmem(buf, sizeof(buf), write_buf, sizeof(write_buf));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void ufstest_mcq_cq_wraparound(void *obj, void *data,
                                       QGuestAllocator *alloc)
 {
@@ -1577,7 +1713,8 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
         /* WRITE(10) to LBA 0, transfer length 8 sectors = 1 fragment */
         WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00
     };
-    uint8_t write_buf[4096];
+    /* The PRDT must hold the eight blocks that the WRITE(10) moves */
+    uint8_t write_buf[8 * 4096];
     uint8_t read_buf[4096];
     int i;
 
@@ -1812,6 +1949,8 @@ static void ufs_register_nodes(void)
     qos_add_test("mcq-read-write", "ufs", ufstest_read_write, &mcq_test_opts);
     qos_add_test("no-prdt", "ufs", ufstest_no_prdt, &io_test_opts);
     qos_add_test("sync-cache", "ufs", ufstest_sync_cache, &io_test_opts);
+    qos_add_test("long-prdt", "ufs", ufstest_long_prdt, &io_test_opts);
+    qos_add_test("short-prdt", "ufs", ufstest_short_prdt, &io_test_opts);
     qos_add_test("mcq-cq-wraparound", "ufs", ufstest_mcq_cq_wraparound,
                  &mcq_test_opts);
     qos_add_test("query-flag", "ufs", ufstest_query_flag_request,

-- 
2.43.0

