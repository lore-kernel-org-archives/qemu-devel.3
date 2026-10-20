Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482A606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=YVvlzf6o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxcb-0007rQ-Hh; Mon, 19 Oct 2026 20:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxcZ-0007r5-JG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:22:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxcT-0003vK-AH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:22:27 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20261020002218epoutp017069b403bb49aaf0db147836eaf27e0f~gFP89qk7s2992229922epoutp01v
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20261020002218epoutp017069b403bb49aaf0db147836eaf27e0f~gFP89qk7s2992229922epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792455738;
 bh=iHEnuGQ0vn0bxGkok6NKoLLsIpZlyUze0rBzoAAm+yg=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=YVvlzf6oDwMFtwLO6JW3615c2Xf932YCBle1HjsTJB+MrB2lxk3VJgTiGKxK6BxTJ
 weVtFoFhwQziJH+eNclT3s55Fdkt2vMpG66UcCt2TucTGPLEv5bf9flZfKWbHkyNGC
 pvr/7SzartlpxQJeuy0uWrTJpTz6L2R0oPnxYiJI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261020002217epcas2p42a673fecb3c91e95ae409f8d41a0a2e8~gFP8mNvs_2580125801epcas2p4j;
 Tue, 20 Oct 2026 00:22:17 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.199]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4j7tQd3CNzz6B9mF; Tue, 20 Oct
 2026 00:22:17 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 6/6] tests/qtest: Add tests for Zoned UFS
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
Message-ID: <20261020002216epcms2p4abf7ffd4848b322429dcb8e73b8da4eb@epcms2p4>
Date: Tue, 20 Oct 2026 09:22:16 +0900
X-CMS-MailID: 20261020002216epcms2p4abf7ffd4848b322429dcb8e73b8da4eb
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
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=daejun7.park@samsung.com; helo=mailout1.samsung.com
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

Add ten qtests for zoned logical units. They use four zoned logical
units: one with 2 MiB zones, one whose capacity is not a multiple of its
3 MiB zones, one on blkdebug with a single open zone, where the first
writes at LBA 0, to the last block of zone 2 and to the first block of
zone 3 fail with an I/O error, and one on null-co that is larger than
8 TiB.

zufs-init checks the INQUIRY device type, the supported VPD pages with
full and short allocation lengths, the ZBC device characteristics page,
that neither READ CAPACITY(16) nor the Block Limits and Logical Block
Provisioning VPD pages offer UNMAP and that the latter offers no WRITE
SAME, the caching mode page, REPORT ZONES, and INQUIRY requests without
a PRDT for the standard data, which scsi-hd builds, and for the ZBC
page.

zufs-write, also run with MCQ as zufs-mcq-write, checks write pointer
handling, SYNCHRONIZE CACHE(16), resets of open zones, finishing an
empty zone, writing to more zones than max_open allows, LBAs past the
end of the logical unit, and that a REPORT ZONES allocation length
larger than the data buffer fails with OCS MISMATCH DATA BUFFER SIZE.

zufs-write-cmds checks that WRITE(6) and WRITE(10) move the write
pointer, that WRITE SAME(10) and WRITE SAME(16) are rejected, the sense
codes for writes crossing a zone and writes to a full zone, and that a
WRITE(10) at an LBA above 2^31 is checked against the zone it addresses.

zufs-open-zones checks explicit opens up to the limit, closing an
implicitly open zone to make room, OPEN ALL with and without enough
resources, FINISH ALL and RESET ALL.

zufs-unit-attention checks that a zone operation is not performed while
a unit attention is pending. zufs-io-error checks that a write failed
by the drive moves the write pointer back.

zufs-write-in-flight, with MCQ, holds writes in flight with a blkdebug
breakpoint. It checks that a failed write moves the write pointer back
also when, in the meantime, scsi-hd rejected another write to its zone
or a write to another zone closed its zone implicitly, but not once a
later write to its zone has started, and that a zone stays full when
FINISH ZONE completed while a write that filled it was in flight and
then failed.

zufs-report-zones checks a start LBA inside a zone, PARTIAL, the
reporting options 3Eh, 06h and 3Fh, and the smaller last zone.

zufs-more-cmds checks WRITE(12), WRITE AND VERIFY(16), CLOSE ALL,
finishing a closed zone, ZONE COUNT with and without the ALL bit, zone
IDs that do not start a zone, and UNMAP. It also checks that writes
refused before they start change no zone: a write without a PRDT leaves
the write pointer alone; one with a shorter PRDT and one with a
WRPROTECT field, which scsi-hd rejects, leave the write pointer and the
condition of a closed or an explicitly open zone alone; the latter
closes no implicitly open zone when all open resources are in use, and
a read that follows does not start it.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 tests/qtest/ufs-test.c | 1136 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1136 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index e8993e8c24..e24caa2efc 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1899,6 +1899,1118 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+#define ZONE_SIZE (2 * 1024 * 1024)
+#define ZONE_BLOCKS (ZONE_SIZE / 4096)
+#define MAX_OPEN_ZONE 6
+#define NUM_ZONES (TEST_IMAGE_SIZE / ZONE_SIZE)
+#define REPORT_ZONES_DESC_SIZE 64
+#define ZONED_TEST_LUN 2
+/* A second zoned LU whose capacity is not a multiple of the zone size */
+#define ODD_ZONED_TEST_LUN 3
+#define ODD_ZONE_SIZE (3 * 1024 * 1024)
+#define ODD_NUM_ZONES DIV_ROUND_UP(TEST_IMAGE_SIZE, ODD_ZONE_SIZE)
+/*
+ * A zoned LU on blkdebug with one open zone: the first writes at LBA 0, to
+ * the last block of zone 2 and to the first block of zone 3 fail with an I/O
+ * error, and a breakpoint can hold a write in flight. It is a -drive with an
+ * id because qtest_qemu_io() needs a BlockBackend name: for a node name,
+ * x-qemu-io attaches a temporary BlockBackend, and detaching it drains the
+ * node, which never returns while a breakpoint holds a write.
+ */
+#define EIO_ZONED_TEST_LUN 4
+#define EIO_ZONED_TEST_DRIVE "drv4"
+/* The last block of zone 2 */
+#define EIO_ZONE2_SECTOR ((3 * ZONE_SIZE - 4096) / 512)
+/* The first block of zone 3 */
+#define EIO_ZONE3_SECTOR (3 * ZONE_SIZE / 512)
+/* A zoned LU of more than 8 TiB with 128 MiB zones, for LBAs of 2^31 and up */
+#define BIG_ZONED_TEST_LUN 5
+#define BIG_ZONED_TEST_SIZE ((8ULL << 40) + 128 * 1024 * 1024)
+
+static void ufs_zufs_build_write16(uint8_t *cdb, uint64_t lba, uint32_t blocks)
+{
+    memset(cdb, 0, UFS_CDB_SIZE);
+    cdb[0] = WRITE_16;
+    stq_be_p(&cdb[2], lba);
+    stl_be_p(&cdb[10], blocks);
+}
+
+static void ufs_zufs_build_zbc_out(uint8_t *cdb, uint8_t action, uint64_t lba,
+                                   bool all)
+{
+    memset(cdb, 0, UFS_CDB_SIZE);
+    cdb[0] = UFS_ZBC_OUT;
+    cdb[1] = action;
+    stq_be_p(&cdb[2], lba);
+    cdb[14] = all ? 0x01 : 0x00;
+}
+
+static void ufs_zufs_build_report_zones(uint8_t *cdb, uint8_t rep_opts,
+                                        uint32_t alloc_len)
+{
+    memset(cdb, 0, UFS_CDB_SIZE);
+    cdb[0] = UFS_ZBC_IN;
+    cdb[1] = UFS_ZBC_REPORT_ZONES;
+    stl_be_p(&cdb[10], alloc_len);
+    cdb[14] = rep_opts;
+}
+
+static void ufs_zufs_clear_unit_attention(QUfs *ufs)
+{
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    uint8_t buf[4096];
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+
+    ocs = ufs_send_scsi_command(ufs, ZONED_TEST_LUN, request_sense_cdb, NULL, 0,
+                                buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+}
+
+static uint8_t ufs_zufs_send(QUfs *ufs, const uint8_t *cdb,
+                             const uint8_t *data_in, size_t data_in_len,
+                             uint8_t *data_out, size_t data_out_len,
+                             UtpUpiuRsp *rsp_upiu)
+{
+    enum UtpOcsCodes ocs;
+
+    ocs = ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, data_in, data_in_len,
+                                data_out, data_out_len, rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    return rsp_upiu->header.scsi_status;
+}
+
+static void ufs_zufs_assert_sense(UtpUpiuRsp *rsp_upiu, uint8_t key,
+                                  uint8_t asc, uint8_t ascq)
+{
+    g_assert_cmpuint(rsp_upiu->header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu->sr.sense_data[2] & 0xf, ==, key);
+    g_assert_cmpuint(rsp_upiu->sr.sense_data[12], ==, asc);
+    g_assert_cmpuint(rsp_upiu->sr.sense_data[13], ==, ascq);
+}
+
+static uint32_t ufs_zufs_count_zones(QUfs *ufs, uint8_t rep_opts)
+{
+    uint8_t buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+
+    ufs_zufs_build_report_zones(cdb, rep_opts, sizeof(buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    return ldl_be_p(&buf[0]) / REPORT_ZONES_DESC_SIZE;
+}
+
+/* Condition and write pointer of the zone at zone_start */
+static uint8_t ufs_zufs_zone(QUfs *ufs, uint8_t lun, uint64_t zone_start,
+                             uint64_t *wp)
+{
+    uint8_t buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(buf));
+    stq_be_p(&cdb[2], zone_start);
+    ocs = ufs_send_scsi_command(ufs, lun, cdb, NULL, 0, buf, sizeof(buf),
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 16]), ==, zone_start);
+    *wp = ldq_be_p(&buf[64 + 24]);
+    return buf[64 + 1] >> 4;
+}
+
+static uint64_t ufs_zufs_write_pointer(QUfs *ufs, uint64_t zone_start)
+{
+    uint64_t wp;
+
+    ufs_zufs_zone(ufs, ZONED_TEST_LUN, zone_start, &wp);
+    return wp;
+}
+
+static uint8_t ufs_zufs_zone_cond(QUfs *ufs, uint64_t zone_start)
+{
+    uint64_t wp;
+
+    return ufs_zufs_zone(ufs, ZONED_TEST_LUN, zone_start, &wp);
+}
+
+static void ufstest_zufs_init(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t buf[4096] = { 0 };
+    const uint8_t inquiry_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x00, 0x00, 0x00, 0x60,
+    };
+    const uint8_t inquiry_vpd_00_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x01 /* EVPD */, 0x00 /* page code */, 0x00, 0x40,
+    };
+    const uint8_t inquiry_vpd_b6_cdb[UFS_CDB_SIZE] = {
+        INQUIRY, 0x01 /* EVPD */, 0xb6 /* page code */, 0x00, 0x40,
+    };
+    const uint8_t mode_sense_caching_cdb[UFS_CDB_SIZE] = {
+        MODE_SENSE_10, 0x08 /* DBD */, MODE_PAGE_CACHING, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0xff,
+    };
+    const uint8_t read_capacity_cdb[UFS_CDB_SIZE] = {
+        SERVICE_ACTION_IN_16, SAI_READ_CAPACITY_16, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
+    };
+    uint8_t report_zones_cdb[UFS_CDB_SIZE];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    uint32_t zone_list_len;
+    uint8_t vpd_00_len;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+
+    /* Standard INQUIRY: host-managed zoned block device */
+    g_assert_cmpuint(ufs_zufs_send(ufs, inquiry_cdb, NULL, 0, buf, 0x60,
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[0] & 0x1f, ==, TYPE_ZBC);
+
+    /* Supported VPD pages include the ZBC device characteristics page */
+    g_assert_cmpuint(ufs_zufs_send(ufs, inquiry_vpd_00_cdb, NULL, 0, buf, 0x40,
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    g_assert_nonnull(memchr(&buf[4], 0xb6, buf[3]));
+    g_assert_cmpuint(buf[4 + buf[3] - 1], ==, 0xb6);
+    vpd_00_len = buf[3];
+
+    /* ZBC device characteristics VPD page */
+    g_assert_cmpuint(ufs_zufs_send(ufs, inquiry_vpd_b6_cdb, NULL, 0, buf, 0x40,
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    g_assert_cmpuint(buf[1], ==, 0xb6);
+    g_assert_cmpuint(lduw_be_p(&buf[2]), ==, 0x3c);
+    /* URSWRZ */
+    g_assert_cmpuint(buf[4] & 0x1, ==, 1);
+    g_assert_cmpuint(ldl_be_p(&buf[16]), ==, MAX_OPEN_ZONE);
+
+    /* Allocation length 4: only the header, whose page length counts 0xb6 */
+    memset(cdb, 0, sizeof(cdb));
+    memcpy(cdb, inquiry_vpd_00_cdb, 5);
+    cdb[4] = 4;
+    memset(buf, 0, sizeof(buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    g_assert_cmpuint(buf[3], ==, vpd_00_len);
+    g_assert_cmpuint(buf[4], ==, 0);
+
+    /* Allocation length of the scsi-hd list: 0xb6 does not fit */
+    cdb[4] = 4 + vpd_00_len - 1;
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[3], ==, vpd_00_len);
+    g_assert_cmpuint(buf[4 + vpd_00_len - 2], !=, 0xb6);
+    g_assert_cmpuint(buf[4 + vpd_00_len - 2], !=, 0);
+    g_assert_cmpuint(buf[4 + vpd_00_len - 1], ==, 0);
+
+    /* UNMAP is not advertised in the Block Limits and LBP pages */
+    cdb[2] = 0xb0;
+    cdb[4] = 0x40;
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[0], ==, TYPE_ZBC);
+    g_assert_cmpuint(ldl_be_p(&buf[20]), ==, 0);
+    g_assert_cmpuint(ldl_be_p(&buf[24]), ==, 0);
+    cdb[2] = 0xb2;
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    /* LBPU, LBPWS and LBPWS10 */
+    g_assert_cmpuint(buf[5] & 0xe0, ==, 0);
+
+    /*
+     * An INQUIRY without a PRDT fails like on a regular LU, also for the page
+     * that ufs-lu answers itself
+     */
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, inquiry_cdb,
+                                           NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN,
+                                           inquiry_vpd_b6_cdb, NULL, 0, NULL,
+                                           0, &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    /* No logical block provisioning: the guest gets no UNMAP */
+    g_assert_cmpuint(ufs_zufs_send(ufs, read_capacity_cdb, NULL, 0, buf,
+                                   sizeof(buf), &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[14] & 0x80, ==, 0);
+
+    /* MODE SENSE takes the scsi-hd disk path: caching page, WCE and DPOFUA */
+    g_assert_cmpuint(ufs_zufs_send(ufs, mode_sense_caching_cdb, NULL, 0, buf,
+                                   0xff, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(buf[3] & 0x10, ==, 0x10);
+    g_assert_cmpuint(buf[8] & 0x3f, ==, MODE_PAGE_CACHING);
+    g_assert_cmpuint(buf[10] & 0x04, ==, 0x04);
+
+    /* Report zones */
+    ufs_zufs_build_report_zones(report_zones_cdb, 0x00, sizeof(buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, report_zones_cdb, NULL, 0, buf,
+                                   sizeof(buf), &rsp_upiu), ==, GOOD);
+    zone_list_len = ldl_be_p(&buf[0]);
+    g_assert_cmpuint(zone_list_len, ==, REPORT_ZONES_DESC_SIZE * NUM_ZONES);
+    g_assert_cmpuint(ldq_be_p(&buf[8]), ==, TEST_IMAGE_SIZE / 4096 - 1);
+    /* First zone: sequential write required, empty */
+    g_assert_cmpuint(buf[64] & 0xf, ==, 0x2);
+    g_assert_cmpuint(buf[65] >> 4, ==, 0x1);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 8]), ==, ZONE_BLOCKS);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096] = { 0 };
+    uint8_t write_buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    int i;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+    memset(write_buf, 0xab, sizeof(write_buf));
+
+    /* Write at the write pointer of zone 0 */
+    ufs_zufs_build_write16(cdb, 0, 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+
+    /* Unaligned write error */
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, CHECK_CONDITION);
+    g_assert_cmpint(rsp_upiu.sr.sense_data[12], ==, 0x21);
+    g_assert_cmpint(rsp_upiu.sr.sense_data[13], ==, 0x04);
+
+    /* Linux flushes zoned disks with SYNCHRONIZE CACHE(16) */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = SYNCHRONIZE_CACHE_16;
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+
+    /* Zone 0 is implicitly open */
+    ufs_zufs_build_report_zones(cdb, 0x02, sizeof(read_buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, read_buf,
+                                   sizeof(read_buf), &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&read_buf[0]), ==, REPORT_ZONES_DESC_SIZE);
+    g_assert_cmpuint(ldq_be_p(&read_buf[64 + 24]), ==, 1);
+
+    /* Resetting an open zone empties it */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_RESET_WRITE_POINTER, 0, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_write16(cdb, 0, 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+
+    /*
+     * Writing to one zone more than MAX_OPEN_ZONE closes an implicitly open
+     * zone instead of failing.
+     */
+    for (i = 1; i <= MAX_OPEN_ZONE; i++) {
+        ufs_zufs_build_write16(cdb, (uint64_t)i * ZONE_BLOCKS, 1);
+        g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                       NULL, 0, &rsp_upiu), ==, GOOD);
+    }
+    ufs_zufs_build_report_zones(cdb, 0x04, sizeof(read_buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, read_buf,
+                                   sizeof(read_buf), &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&read_buf[0]), ==, REPORT_ZONES_DESC_SIZE);
+
+    /* Finishing an empty zone makes it full */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE,
+                           (uint64_t)(NUM_ZONES - 1) * ZONE_BLOCKS, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_report_zones(cdb, 0x05, sizeof(read_buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, read_buf,
+                                   sizeof(read_buf), &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&read_buf[0]), ==, REPORT_ZONES_DESC_SIZE);
+
+    /* Write and zone management beyond the last LBA: LBA OUT OF RANGE */
+    ufs_zufs_build_write16(cdb, TEST_IMAGE_SIZE / 4096, 1);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x00);
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, TEST_IMAGE_SIZE / 4096,
+                           false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x00);
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_RESET_WRITE_POINTER,
+                           TEST_IMAGE_SIZE / 4096, false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x00);
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(read_buf));
+    stq_be_p(&cdb[2], TEST_IMAGE_SIZE / 4096);
+    ufs_zufs_send(ufs, cdb, NULL, 0, read_buf, sizeof(read_buf), &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x00);
+
+    /* Unknown reporting option and zone operation: INVALID FIELD IN CDB */
+    ufs_zufs_build_report_zones(cdb, 0x08, sizeof(read_buf));
+    ufs_zufs_send(ufs, cdb, NULL, 0, read_buf, sizeof(read_buf), &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+    ufs_zufs_build_zbc_out(cdb, 0x05, 0, false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+
+    /* An allocation length above the data buffer fails like a short PRDT */
+    ufs_zufs_build_report_zones(cdb, 0x00, 1024 * 1024);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, NULL, 0,
+                                           read_buf, 256, &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+
+    /* Reset all zones */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_RESET_WRITE_POINTER, 0, true);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_report_zones(cdb, 0x01, sizeof(read_buf));
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, read_buf,
+                                   sizeof(read_buf), &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&read_buf[0]), ==,
+                     REPORT_ZONES_DESC_SIZE * NUM_ZONES);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_write_cmds(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096];
+    uint8_t write_buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    const uint64_t zone1 = ZONE_BLOCKS, zone2 = 2 * ZONE_BLOCKS,
+                   zone3 = 3 * ZONE_BLOCKS;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+    memset(write_buf, 0xcd, sizeof(write_buf));
+
+    /* WRITE(10) and WRITE(6) move the write pointer like WRITE(16) */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_10;
+    stl_be_p(&cdb[2], 0);
+    stw_be_p(&cdb[7], 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, 0), ==, 1);
+
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_6;
+    cdb[1] = (zone3 >> 16) & 0x1f;
+    cdb[2] = (zone3 >> 8) & 0xff;
+    cdb[3] = zone3 & 0xff;
+    cdb[4] = 1;
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone3), ==, zone3 + 1);
+
+    /* WRITE SAME at the write pointer: INVALID COMMAND OPERATION CODE */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_SAME_16;
+    stq_be_p(&cdb[2], 1);
+    stl_be_p(&cdb[10], 2);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x20, 0x00);
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_SAME_10;
+    stl_be_p(&cdb[2], 1);
+    stw_be_p(&cdb[7], 2);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x20, 0x00);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, 0), ==, 1);
+
+    /* A write crossing the end of its zone: WRITE BOUNDARY VIOLATION */
+    ufs_zufs_build_write16(cdb, zone1, ZONE_BLOCKS + 1);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x05);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone1), ==, zone1);
+
+    /* A write to a full zone: INVALID FIELD IN CDB */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, zone2, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_write16(cdb, zone2, 1);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+
+    /* A WRITE(10) at an LBA above 2^31 is checked like a WRITE(16) */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = REQUEST_SENSE;
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, BIG_ZONED_TEST_LUN, cdb, NULL,
+                                           0, read_buf, sizeof(read_buf),
+                                           &rsp_upiu), ==, UFS_OCS_SUCCESS);
+    cdb[0] = WRITE_10;
+    stl_be_p(&cdb[2], 0x80000001);
+    stw_be_p(&cdb[7], 1);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, BIG_ZONED_TEST_LUN, cdb,
+                                           write_buf, sizeof(write_buf), NULL,
+                                           0, &rsp_upiu), ==, UFS_OCS_SUCCESS);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x04);
+    /* ... and one at the zone start moves that zone's write pointer */
+    stl_be_p(&cdb[2], 0x80000000);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, BIG_ZONED_TEST_LUN, cdb,
+                                           write_buf, sizeof(write_buf), NULL,
+                                           0, &rsp_upiu), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(read_buf));
+    stq_be_p(&cdb[2], 0x80000000);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, BIG_ZONED_TEST_LUN, cdb, NULL,
+                                           0, read_buf, sizeof(read_buf),
+                                           &rsp_upiu), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(ldq_be_p(&read_buf[64 + 16]), ==, 0x80000000);
+    g_assert_cmpuint(ldq_be_p(&read_buf[64 + 24]), ==, 0x80000001);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_open_zones(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t write_buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    int i;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+    memset(write_buf, 0xef, sizeof(write_buf));
+
+    /* Open MAX_OPEN_ZONE zones explicitly */
+    for (i = 0; i < MAX_OPEN_ZONE; i++) {
+        ufs_zufs_build_zbc_out(cdb, UFS_ZBC_OPEN_ZONE,
+                               (uint64_t)i * ZONE_BLOCKS, false);
+        g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu),
+                         ==, GOOD);
+    }
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x03), ==, MAX_OPEN_ZONE);
+
+    /* No implicitly open zone to close: INSUFFICIENT ZONE RESOURCES */
+    ufs_zufs_build_write16(cdb, (uint64_t)MAX_OPEN_ZONE * ZONE_BLOCKS, 1);
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, DATA_PROTECT, 0x55, 0x0e);
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_OPEN_ZONE,
+                           (uint64_t)MAX_OPEN_ZONE * ZONE_BLOCKS, false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, DATA_PROTECT, 0x55, 0x0e);
+
+    /* Closing an open zone with nothing written empties it */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_CLOSE_ZONE, 0, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x01), ==, NUM_ZONES - 5);
+
+    /*
+     * Fill the freed resource with an implicitly open zone, then write to
+     * one more zone: the implicitly open zone is closed.
+     */
+    ufs_zufs_build_write16(cdb, (uint64_t)MAX_OPEN_ZONE * ZONE_BLOCKS, 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    ufs_zufs_build_write16(cdb, (uint64_t)(MAX_OPEN_ZONE + 1) * ZONE_BLOCKS,
+                           1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x04), ==, 1);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, 1);
+
+    /* OPEN ALL: 5 explicit + 1 closed fit, the implicit one is closed */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_OPEN_ZONE, 0, true);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x03), ==, MAX_OPEN_ZONE);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x04), ==, 1);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, 0);
+
+    /* OPEN ALL again: 6 explicit + 1 closed do not fit, nothing changes */
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, DATA_PROTECT, 0x55, 0x0e);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x04), ==, 1);
+
+    /* FINISH ALL fills open and closed zones, empty ones stay empty */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, 0, true);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x05), ==, MAX_OPEN_ZONE + 1);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x01), ==,
+                     NUM_ZONES - MAX_OPEN_ZONE - 1);
+
+    /* RESET ALL */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_RESET_WRITE_POINTER, 0, true);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x01), ==, NUM_ZONES);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_unit_attention(void *obj, void *data,
+                                        QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t write_buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+
+    ufs_init(ufs, alloc);
+    memset(write_buf, 0x5a, sizeof(write_buf));
+
+    /*
+     * After the reset in ufs_init(), the first command that scsi-hd does not
+     * exempt gets UNIT ATTENTION and is not performed, zone commands too:
+     * the zone stays empty and the write pointer stays put, so that the
+     * guest can retry.
+     */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, 0, false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+    g_assert_cmpuint(rsp_upiu.sr.sense_data[2] & 0xf, ==, UNIT_ATTENTION);
+    ufs_zufs_build_write16(cdb, 0, 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, 0), ==, 1);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_io_error(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    uint8_t buf[4096];
+    uint8_t write_buf[4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+
+    ufs_init(ufs, alloc);
+    memset(write_buf, 0xa5, sizeof(write_buf));
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, request_sense_cdb,
+                                NULL, 0, buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    /* scsi-hd fails the first write at LBA 0: the write pointer moves back */
+    ufs_zufs_build_write16(cdb, 0, 1);
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(buf));
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(buf[64 + 1] >> 4, ==, 0x1);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 24]), ==, 0);
+
+    /* The retry succeeds */
+    ufs_zufs_build_write16(cdb, 0, 1);
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(buf));
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 24]), ==, 1);
+
+    ufs_exit(ufs, alloc);
+}
+
+/* Submit a SCSI command that writes data_in through MCQ, without waiting */
+static int ufs_zufs_send_write_async(QUfs *ufs, uint8_t lun,
+                                     const uint8_t *cdb,
+                                     const uint8_t *data_in,
+                                     size_t data_in_len)
+{
+    QTestState *qts = ufs->dev.bus->qts;
+    int cmd_desc_slot = alloc_cmd_desc_slot(ufs);
+    uint64_t req_upiu_addr =
+        ufs->cmd_desc_addr + cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE;
+    UfshcdSgEntry entry = { 0 };
+    UtpUpiuReq req_upiu = { 0 };
+    UtpTransferReqDesc utrd;
+
+    g_assert_true(ufs->support_mcq);
+    g_assert_cmpuint(data_in_len, <=, PRD_ENTRY_DATA_SIZE);
+    qtest_memwrite(qts, ufs->data_buffer_addr, data_in, data_in_len);
+    entry.addr = cpu_to_le64(ufs->data_buffer_addr);
+    entry.size = cpu_to_le32(data_in_len - 1);
+    qtest_memwrite(qts, req_upiu_addr + UTP_PRDT_UPIU_OFFSET, &entry,
+                   sizeof(entry));
+
+    req_upiu.header.trans_type = UFS_UPIU_TRANSACTION_COMMAND;
+    req_upiu.header.flags = UFS_UPIU_CMD_FLAGS_WRITE;
+    req_upiu.header.lun = lun;
+    req_upiu.header.task_tag = cmd_desc_slot;
+    req_upiu.sc.exp_data_transfer_len = cpu_to_be32(data_in_len);
+    memcpy(req_upiu.sc.cdb, cdb, UFS_CDB_SIZE);
+    qtest_memwrite(qts, req_upiu_addr, &req_upiu, sizeof(req_upiu));
+
+    utrd = ufs_build_req_utrd(req_upiu_addr, UFS_UTP_HOST_TO_DEVICE, 1);
+    __ufs_send_transfer_request_mcq_async(ufs, lun, &utrd);
+    return cmd_desc_slot;
+}
+
+/* Wait for the request of ufs_zufs_send_write_async(); returns its status */
+static uint8_t ufs_zufs_wait_async(QUfs *ufs, int cmd_desc_slot,
+                                   UtpUpiuRsp *rsp_upiu)
+{
+    uint64_t rsp_upiu_addr = ufs->cmd_desc_addr +
+                             cmd_desc_slot * UTP_COMMAND_DESCRIPTOR_SIZE +
+                             UTP_RESPONSE_UPIU_OFFSET;
+    uint64_t end_time;
+    UfsCqEntry cqe;
+    int n_cqe;
+
+    end_time = g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+        n_cqe = ufs_mcq_poll_cq(ufs, &cqe, 1);
+    } while (!n_cqe && g_get_monotonic_time() < end_time);
+    g_assert_cmpint(n_cqe, ==, 1);
+    g_assert_cmpuint(cqe.status, ==, UFS_OCS_SUCCESS);
+    ufs_wreg(ufs, A_IS, FIELD_DP32(0, IS, CQES, 1));
+
+    qtest_memread(ufs->dev.bus->qts, rsp_upiu_addr, rsp_upiu,
+                  sizeof(*rsp_upiu));
+    g_assert_cmpuint(rsp_upiu->header.task_tag, ==, cmd_desc_slot);
+    release_cmd_desc_slot(ufs, cmd_desc_slot);
+    return rsp_upiu->header.scsi_status;
+}
+
+static void ufstest_zufs_write_in_flight(void *obj, void *data,
+                                         QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    QTestState *qts = ufs->dev.bus->qts;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint64_t zone1 = ZONE_BLOCKS, zone2 = 2 * ZONE_BLOCKS,
+                   zone3 = 3 * ZONE_BLOCKS;
+    uint8_t buf[4096];
+    uint8_t write_buf[4096];
+    uint8_t fill_buf[8 * 4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    enum UtpOcsCodes ocs;
+    uint64_t wp, lba;
+    uint32_t blocks;
+    int slot, slot2;
+
+    ufs_init(ufs, alloc);
+    g_assert_true(ufs->support_mcq);
+    memset(write_buf, 0x5a, sizeof(write_buf));
+    memset(fill_buf, 0x3c, sizeof(fill_buf));
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, request_sense_cdb,
+                                NULL, 0, buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+
+    /*
+     * A write to zone 1 takes the only open resource and closes zone 0,
+     * which a write in flight opened. That write fails and still moves the
+     * write pointer back.
+     */
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "break write_aio A");
+    ufs_zufs_build_write16(cdb, 0, 1);
+    slot = ufs_zufs_send_write_async(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                     sizeof(write_buf));
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, 0, &wp), ==, 0x2);
+    g_assert_cmpuint(wp, ==, 1);
+
+    /* A write that scsi-hd rejects leaves this one undoable */
+    ufs_zufs_build_write16(cdb, 1, 1);
+    cdb[1] = 0x20;
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+
+    ufs_zufs_build_write16(cdb, zone1, 1);
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, 0, &wp), ==, 0x4);
+    g_assert_cmpuint(wp, ==, 1);
+
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "resume A");
+    g_assert_cmpuint(ufs_zufs_wait_async(ufs, slot, &rsp_upiu), ==,
+                     CHECK_CONDITION);
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, 0, &wp), ==, 0x1);
+    g_assert_cmpuint(wp, ==, 0);
+
+    ufs_zufs_build_write16(cdb, 0, 1);
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    /*
+     * FINISH ZONE completes while a write that filled zone 2 is in flight.
+     * When the write fails, the zone stays full.
+     */
+    for (lba = zone2; lba < zone2 + ZONE_BLOCKS - 1; lba += blocks) {
+        blocks = MIN(8, zone2 + ZONE_BLOCKS - 1 - lba);
+        ufs_zufs_build_write16(cdb, lba, blocks);
+        ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, fill_buf,
+                                    blocks * 4096, NULL, 0, &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    }
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, zone2, &wp),
+                     ==, 0x2);
+    g_assert_cmpuint(wp, ==, zone2 + ZONE_BLOCKS - 1);
+
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "break write_aio B");
+    ufs_zufs_build_write16(cdb, zone2 + ZONE_BLOCKS - 1, 1);
+    slot = ufs_zufs_send_write_async(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                     sizeof(write_buf));
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, zone2, &wp),
+                     ==, 0xe);
+
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, zone2, false);
+    ocs = ufs_send_scsi_command(ufs, EIO_ZONED_TEST_LUN, cdb, NULL, 0, NULL, 0,
+                                &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "resume B");
+    g_assert_cmpuint(ufs_zufs_wait_async(ufs, slot, &rsp_upiu), ==,
+                     CHECK_CONDITION);
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, zone2, &wp),
+                     ==, 0xe);
+
+    /*
+     * A write to zone 3 fails after a later write to the zone started: the
+     * write pointer is not moved back.
+     */
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "break write_aio C");
+    ufs_zufs_build_write16(cdb, zone3, 1);
+    slot = ufs_zufs_send_write_async(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                     sizeof(write_buf));
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "break write_aio D");
+    ufs_zufs_build_write16(cdb, zone3 + 1, 1);
+    slot2 = ufs_zufs_send_write_async(ufs, EIO_ZONED_TEST_LUN, cdb, write_buf,
+                                      sizeof(write_buf));
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "resume C");
+    g_assert_cmpuint(ufs_zufs_wait_async(ufs, slot, &rsp_upiu), ==,
+                     CHECK_CONDITION);
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, zone3, &wp),
+                     ==, 0x2);
+    g_assert_cmpuint(wp, ==, zone3 + 2);
+    qtest_qemu_io(qts, EIO_ZONED_TEST_DRIVE, "resume D");
+    g_assert_cmpuint(ufs_zufs_wait_async(ufs, slot2, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_zone(ufs, EIO_ZONED_TEST_LUN, zone3, &wp),
+                     ==, 0x2);
+    g_assert_cmpuint(wp, ==, zone3 + 2);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_report_zones(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    uint8_t buf[4096];
+    uint8_t write_buf[4096];
+    uint8_t write_buf2[2 * 4096] = { 0 };
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    uint64_t last_start;
+    enum UtpOcsCodes ocs;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+    memset(write_buf, 0x3c, sizeof(write_buf));
+
+    /* A start LBA inside a zone reports from that zone on */
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(buf));
+    stq_be_p(&cdb[2], 2 * ZONE_BLOCKS + 5);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&buf[0]), ==,
+                     (NUM_ZONES - 2) * REPORT_ZONES_DESC_SIZE);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 16]), ==, 2 * ZONE_BLOCKS);
+
+    /* PARTIAL: the zone list length counts only the returned zones */
+    ufs_zufs_build_report_zones(cdb, 0x80, 64 + 3 * REPORT_ZONES_DESC_SIZE);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&buf[0]), ==, 3 * REPORT_ZONES_DESC_SIZE);
+    ufs_zufs_build_report_zones(cdb, 0x00, 64 + 3 * REPORT_ZONES_DESC_SIZE);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, buf, sizeof(buf),
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&buf[0]), ==, NUM_ZONES * REPORT_ZONES_DESC_SIZE);
+
+    /* All zones except gap zones; no read-only or conventional zones */
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x3e), ==, NUM_ZONES);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x06), ==, 0);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x3f), ==, 0);
+
+    /* A capacity that is not a multiple of the zone size: a smaller zone */
+    ocs = ufs_send_scsi_command(ufs, ODD_ZONED_TEST_LUN, request_sense_cdb,
+                                NULL, 0, buf, sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    last_start = (uint64_t)(ODD_NUM_ZONES - 1) * (ODD_ZONE_SIZE / 4096);
+    ufs_zufs_build_report_zones(cdb, 0x00, sizeof(buf));
+    stq_be_p(&cdb[2], last_start);
+    ocs = ufs_send_scsi_command(ufs, ODD_ZONED_TEST_LUN, cdb, NULL, 0, buf,
+                                sizeof(buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    g_assert_cmpuint(ldl_be_p(&buf[0]), ==, REPORT_ZONES_DESC_SIZE);
+    g_assert_cmpuint(ldq_be_p(&buf[64 + 8]), ==,
+                     TEST_IMAGE_SIZE / 4096 - last_start);
+
+    /* A write crossing the end of that zone and of the logical unit */
+    ufs_zufs_build_write16(cdb, last_start, 1);
+    ocs = ufs_send_scsi_command(ufs, ODD_ZONED_TEST_LUN, cdb, write_buf,
+                                sizeof(write_buf), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, GOOD);
+    ufs_zufs_build_write16(cdb, TEST_IMAGE_SIZE / 4096 - 1, 2);
+    ocs = ufs_send_scsi_command(ufs, ODD_ZONED_TEST_LUN, cdb, write_buf2,
+                                sizeof(write_buf2), NULL, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x21, 0x00);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_zufs_more_cmds(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t write_buf[4096];
+    uint8_t fill_buf[8 * 4096];
+    uint8_t cdb[UFS_CDB_SIZE];
+    UtpUpiuRsp rsp_upiu;
+    const uint64_t zone4 = 4 * ZONE_BLOCKS, zone5 = 5 * ZONE_BLOCKS,
+                   zone6 = 6 * ZONE_BLOCKS, zone7 = 7 * ZONE_BLOCKS;
+    uint64_t lba;
+    uint32_t blocks;
+    int i;
+
+    ufs_init(ufs, alloc);
+    ufs_zufs_clear_unit_attention(ufs);
+    memset(write_buf, 0x96, sizeof(write_buf));
+    memset(fill_buf, 0x69, sizeof(fill_buf));
+
+    /* WRITE(12) and WRITE AND VERIFY(16) move the write pointer */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_12;
+    stl_be_p(&cdb[2], zone4);
+    stl_be_p(&cdb[6], 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = WRITE_VERIFY_16;
+    stq_be_p(&cdb[2], zone4 + 1);
+    stl_be_p(&cdb[10], 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone4), ==, zone4 + 2);
+
+    /* CLOSE ALL closes it, FINISH ZONE fills the closed zone */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_CLOSE_ZONE, 0, true);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x04), ==, 1);
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, zone4, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x05), ==, 1);
+
+    /* A zone operation on a range of zones is not supported */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_FINISH_ZONE, zone5, false);
+    stw_be_p(&cdb[12], 2);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+
+    /* With the ALL bit, ZONE COUNT does not matter */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_CLOSE_ZONE, 0, true);
+    stw_be_p(&cdb[12], 2);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+
+    /* A zone ID that is not the start of a zone */
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_RESET_WRITE_POINTER, zone5 + 1, false);
+    ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+
+    /*
+     * A write without a PRDT, or with one shorter than the transfer, fails
+     * and leaves the write pointer alone
+     */
+    ufs_zufs_build_write16(cdb, zone5, 1);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, NULL, 0,
+                                           NULL, 0, &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    ufs_zufs_build_write16(cdb, zone5, 2);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, write_buf,
+                                           sizeof(write_buf), NULL, 0,
+                                           &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone5), ==, zone5);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, 0);
+
+    /* UNMAP would bypass the write pointers */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = UNMAP;
+    stw_be_p(&cdb[7], 24);
+    memset(write_buf, 0, 24);
+    stw_be_p(&write_buf[0], 22);
+    stw_be_p(&write_buf[2], 16);
+    stq_be_p(&write_buf[8], zone4);
+    stl_be_p(&write_buf[16], 1);
+    ufs_zufs_send(ufs, cdb, write_buf, 24, NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x20, 0x00);
+
+    /*
+     * A write whose PRDT is shorter than the write changes no zone: a closed
+     * zone stays closed, an explicitly open one stays open.
+     */
+    ufs_zufs_build_write16(cdb, zone6, 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                   NULL, 0, &rsp_upiu), ==, GOOD);
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_CLOSE_ZONE, zone6, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_write16(cdb, zone6 + 1, 2);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, write_buf,
+                                           sizeof(write_buf), NULL, 0,
+                                           &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    g_assert_cmpuint(ufs_zufs_zone_cond(ufs, zone6), ==, 0x4);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone6), ==, zone6 + 1);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, 0);
+
+    ufs_zufs_build_zbc_out(cdb, UFS_ZBC_OPEN_ZONE, zone7, false);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, NULL, 0, &rsp_upiu), ==,
+                     GOOD);
+    ufs_zufs_build_write16(cdb, zone7, ZONE_BLOCKS);
+    g_assert_cmpuint(ufs_send_scsi_command(ufs, ZONED_TEST_LUN, cdb, write_buf,
+                                           sizeof(write_buf), NULL, 0,
+                                           &rsp_upiu), ==,
+                     UFS_OCS_MISMATCH_DATA_BUF_SIZE);
+    g_assert_cmpuint(ufs_zufs_zone_cond(ufs, zone7), ==, 0x3);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone7), ==, zone7);
+
+    /*
+     * Nor does a write that scsi-hd rejects, here for its WRPROTECT field:
+     * the closed zone stays closed, the explicitly open one that the write
+     * would fill stays open, and no implicitly open zone is closed to make
+     * room for the zone of the write.
+     */
+    ufs_zufs_build_write16(cdb, zone6 + 1, 1);
+    cdb[1] = 0x20;
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+    /* A read that follows does not start the rejected write either */
+    memset(cdb, 0, sizeof(cdb));
+    cdb[0] = READ_16;
+    stq_be_p(&cdb[2], zone6);
+    stl_be_p(&cdb[10], 1);
+    g_assert_cmpuint(ufs_zufs_send(ufs, cdb, NULL, 0, fill_buf, 4096,
+                                   &rsp_upiu), ==, GOOD);
+    g_assert_cmpuint(ufs_zufs_zone_cond(ufs, zone6), ==, 0x4);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone6), ==, zone6 + 1);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, 0);
+
+    for (lba = zone7; lba < zone7 + ZONE_BLOCKS - 1; lba += blocks) {
+        blocks = MIN(8, zone7 + ZONE_BLOCKS - 1 - lba);
+        ufs_zufs_build_write16(cdb, lba, blocks);
+        g_assert_cmpuint(ufs_zufs_send(ufs, cdb, fill_buf, blocks * 4096, NULL,
+                                       0, &rsp_upiu), ==, GOOD);
+    }
+    ufs_zufs_build_write16(cdb, zone7 + ZONE_BLOCKS - 1, 1);
+    cdb[1] = 0x20;
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+    g_assert_cmpuint(ufs_zufs_zone_cond(ufs, zone7), ==, 0x3);
+    g_assert_cmpuint(ufs_zufs_write_pointer(ufs, zone7), ==,
+                     zone7 + ZONE_BLOCKS - 1);
+
+    for (i = 0; i < MAX_OPEN_ZONE - 1; i++) {
+        ufs_zufs_build_write16(cdb, (8 + i) * ZONE_BLOCKS, 1);
+        g_assert_cmpuint(ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf),
+                                       NULL, 0, &rsp_upiu), ==, GOOD);
+    }
+    ufs_zufs_build_write16(cdb, (8 + i) * ZONE_BLOCKS, 1);
+    cdb[1] = 0x20;
+    ufs_zufs_send(ufs, cdb, write_buf, sizeof(write_buf), NULL, 0, &rsp_upiu);
+    ufs_zufs_assert_sense(&rsp_upiu, ILLEGAL_REQUEST, 0x24, 0x00);
+    g_assert_cmpuint(ufs_zufs_count_zones(ufs, 0x02), ==, MAX_OPEN_ZONE - 1);
+    g_assert_cmpuint(ufs_zufs_zone_cond(ufs, (8 + i) * ZONE_BLOCKS), ==, 0x1);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void *ufs_zufs_test_setup(GString *cmd_line, void *arg)
+{
+    char *tmp_path = drive_create();
+    char *odd_path = drive_create();
+    char *eio_path = drive_create();
+
+    g_string_append_printf(cmd_line,
+                           " -blockdev file,filename=%s,node-name=drv2 "
+                           "-device ufs-lu,bus=ufs0,drive=drv2,lun=%d,"
+                           "zoned=on,zoned.max_open=%d,zoned.zone_size=%d "
+                           "-blockdev file,filename=%s,node-name=drv3 "
+                           "-device ufs-lu,bus=ufs0,drive=drv3,lun=%d,"
+                           "zoned=on,zoned.zone_size=%d "
+                           "-drive if=none,id=%s,driver=raw,"
+                           "file.driver=blkdebug,file.image.filename=%s,"
+                           "file.inject-error.0.event=none,"
+                           "file.inject-error.0.iotype=write,"
+                           "file.inject-error.0.errno=5,"
+                           "file.inject-error.0.sector=0,"
+                           "file.inject-error.0.once=on,"
+                           "file.inject-error.1.event=none,"
+                           "file.inject-error.1.iotype=write,"
+                           "file.inject-error.1.errno=5,"
+                           "file.inject-error.1.sector=%d,"
+                           "file.inject-error.1.once=on,"
+                           "file.inject-error.2.event=none,"
+                           "file.inject-error.2.iotype=write,"
+                           "file.inject-error.2.errno=5,"
+                           "file.inject-error.2.sector=%d,"
+                           "file.inject-error.2.once=on "
+                           "-device ufs-lu,bus=ufs0,drive=%s,lun=%d,"
+                           "zoned=on,zoned.zone_size=%d,zoned.max_open=1 "
+                           "-blockdev null-co,node-name=drv5,read-zeroes=on,"
+                           "size=%" PRIu64 " "
+                           "-device ufs-lu,bus=ufs0,drive=drv5,lun=%d,"
+                           "zoned=on ",
+                           tmp_path, ZONED_TEST_LUN, MAX_OPEN_ZONE, ZONE_SIZE,
+                           odd_path, ODD_ZONED_TEST_LUN, ODD_ZONE_SIZE,
+                           EIO_ZONED_TEST_DRIVE, eio_path, EIO_ZONE2_SECTOR,
+                           EIO_ZONE3_SECTOR,
+                           EIO_ZONED_TEST_DRIVE, EIO_ZONED_TEST_LUN, ZONE_SIZE,
+                           (uint64_t)BIG_ZONED_TEST_SIZE, BIG_ZONED_TEST_LUN);
+
+    return arg;
+}
+
 static void ufs_register_nodes(void)
 {
     const char *arch;
@@ -1921,6 +3033,12 @@ static void ufs_register_nodes(void)
                                              "mcq=false,nutrs=32,nutmrs=8,"
                                              "wb-max-size=1024,"
                                              "wb-min-size=256" };
+    QOSGraphTestOptions zufs_test_opts = { .before = ufs_zufs_test_setup,
+                                           .edge.extra_device_opts =
+                                               "mcq=false,nutrs=32,nutmrs=8" };
+    QOSGraphTestOptions zufs_mcq_test_opts = { .before = ufs_zufs_test_setup,
+                                               .edge.extra_device_opts =
+                                                   "mcq=true,mcq-maxq=1" };
     QOSGraphTestOptions acpi_eject_test_opts = { .subprocess = true };
 
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });
@@ -1962,6 +3080,24 @@ static void ufs_register_nodes(void)
     qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
     qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
     qos_add_test("hid", "ufs", ufstest_hid, &io_test_opts);
+    qos_add_test("zufs-init", "ufs", ufstest_zufs_init, &zufs_test_opts);
+    qos_add_test("zufs-write", "ufs", ufstest_zufs_write, &zufs_test_opts);
+    qos_add_test("zufs-mcq-write", "ufs", ufstest_zufs_write,
+                 &zufs_mcq_test_opts);
+    qos_add_test("zufs-write-cmds", "ufs", ufstest_zufs_write_cmds,
+                 &zufs_test_opts);
+    qos_add_test("zufs-open-zones", "ufs", ufstest_zufs_open_zones,
+                 &zufs_test_opts);
+    qos_add_test("zufs-unit-attention", "ufs", ufstest_zufs_unit_attention,
+                 &zufs_test_opts);
+    qos_add_test("zufs-io-error", "ufs", ufstest_zufs_io_error,
+                 &zufs_test_opts);
+    qos_add_test("zufs-write-in-flight", "ufs", ufstest_zufs_write_in_flight,
+                 &zufs_mcq_test_opts);
+    qos_add_test("zufs-report-zones", "ufs", ufstest_zufs_report_zones,
+                 &zufs_test_opts);
+    qos_add_test("zufs-more-cmds", "ufs", ufstest_zufs_more_cmds,
+                 &zufs_test_opts);
 }
 
 libqos_init(ufs_register_nodes);

-- 
2.43.0

