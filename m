Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F1B10D14A5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7AtM-0001co-2G; Mon, 30 Mar 2026 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AtH-0001cA-2b
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:34:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AtE-0002Rx-T8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:34:42 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260330113438epoutp04e2d3de068d203918ed5b601236a9f5d5~hm0v3cIqT3269332693epoutp04O
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:34:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260330113438epoutp04e2d3de068d203918ed5b601236a9f5d5~hm0v3cIqT3269332693epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774870478;
 bh=929hjWggUVrwdftbuwljFXVoep6Fcv0oj2X4PuMCbKE=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=fMC0VTUdx9WThTl0jrar4TKYL48Ed/rmmn6H4DycPPlkmzRZETqzNIUHep/NxArpj
 38qajVsgDyonKXe3Y1ewjbyb6XsB2SEkjl3T4x1ly+YmyokSD5jkgGCJ/TT/CixTGK
 dgLaXs7B0EfqvNCpofMcG4bE4h281GZwJWiTCHrI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20260330113438epcas2p3fa4557fe381880cfa2e1ffeebf460337~hm0vQ_vGm0308203082epcas2p3D;
 Mon, 30 Mar 2026 11:34:38 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.210]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4fkq0Y5W2Hz3hhTC; Mon, 30 Mar
 2026 11:34:37 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 5/5] tests/qtest: Add UFS Write Booster QTest
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260330113436epcms2p2501e3cc236194ac83832914eb08eea3a@epcms2p2>
Date: Mon, 30 Mar 2026 20:34:36 +0900
X-CMS-MailID: 20260330113436epcms2p2501e3cc236194ac83832914eb08eea3a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p2>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It adds 'wb-init' and 'wb-read-write' TCs into tests/qtest/ufs-test.c.
'wb-init' tests that the WB support is properly initialized with UFS
device and 'wb-read-write' tests that WB can be enabled and WRITE I/O
can be handled/buffered as a WB command.

Signed-off-by: Jaemyung Lee <jameyung.lee@samsung.com>
---
 tests/qtest/ufs-test.c | 176 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 7f99944155..253fea27a5 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1182,6 +1182,173 @@ static void ufstest_query_desc_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }

+static void ufstest_wb_init(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    uint8_t *desc;
+    uint32_t value;
+
+    ufs_init(ufs, alloc);
+
+    /* Read Device Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_DEVICE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_DEVICE);
+
+    /* Check Write Booster Supportability */
+    desc = rsp_upiu.qr.data;
+
+    value = *(uint16_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_WB_SUP);
+    value = be16_to_cpu(value);
+    g_assert_cmpuint(value, ==, WB_RESIZE | WB_FIFO | WB_PINNED);
+
+    value = *(uint32_t *)(desc + UFS_DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+    value = be32_to_cpu(value);
+    g_assert_cmpuint(value & UFS_DEV_WB_SUPPORT, ==, UFS_DEV_WB_SUPPORT);
+
+    /* Read Geometry Descriptor */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                         UFS_QUERY_DESC_IDN_GEOMETRY, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
+
+    /* Check Write Booster Configuration */
+    desc = rsp_upiu.qr.data;
+
+    value = *(uint32_t *)(desc + UFS_GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS);
+    value = be32_to_cpu(value);
+    g_assert_cmpuint(value, ==, 1024);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ];
+    g_assert_cmpuint(value, ==, 3);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_RED_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    value = desc[UFS_GEOMETRY_DESC_PARAM_WB_SUP_WB_TYPE];
+    g_assert_cmpuint(value, ==, 1);
+
+    ufs_exit(ufs, alloc);
+}
+
+static void ufstest_wb_read_write(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+    uint8_t read_buf[4096] = { 0 };
+    uint8_t write_buf[4096] = { 0 };
+    const uint8_t read_capacity_cdb[UFS_CDB_SIZE] = {
+        /* allocation length 4096 */
+        SERVICE_ACTION_IN_16,
+        SAI_READ_CAPACITY_16,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x00,
+        0x10,
+        0x00,
+        0x00,
+        0x00
+    };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
+    const uint8_t write_cdb[UFS_CDB_SIZE] = {
+        /* WRITE(10) to LBA 0, transfer length 1 */
+        WRITE_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
+    };
+    uint32_t block_size;
+    enum UtpOcsCodes ocs;
+    UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
+    uint64_t end_time;
+
+    ufs_init(ufs, alloc);
+
+    /* Clear Unit Attention */
+    ocs = ufs_send_scsi_command(ufs, test_lun, request_sense_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
+    /* Read capacity */
+    ocs = ufs_send_scsi_command(ufs, test_lun, read_capacity_cdb, NULL, 0,
+                                read_buf, sizeof(read_buf), &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                     UFS_COMMAND_RESULT_SUCCESS);
+    block_size = ldl_be_p(&read_buf[8]);
+    g_assert_cmpuint(block_size, ==, 4096);
+
+    /* Check available buffer size */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0, &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0xA));
+
+    /* Enable WB */
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                         UFS_QUERY_FLAG_IDN_WB_EN, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    /* Write data */
+    for (int i = 0; i < 256; i++) {
+        memset(write_buf, 0xab, block_size);
+        ocs = ufs_send_scsi_command(ufs, test_lun, write_cdb, write_buf,
+                                    block_size, NULL, 0, &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
+                         UFS_COMMAND_RESULT_SUCCESS);
+    }
+
+    end_time = g_get_monotonic_time() + TIMEOUT_SECONDS * G_TIME_SPAN_SECOND;
+    do {
+        qtest_clock_step(ufs->dev.bus->qts, 100);
+
+        /* Check available buffer size */
+        ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                             UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                             UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE, 0, 0, 0,
+                             &rsp_upiu);
+        g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+        g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+        g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE);
+    } while (rsp_upiu.qr.value == cpu_to_be32(0xA) && g_get_monotonic_time() < end_time);
+
+    /* Check available buffer size */
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x9));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -1234,6 +1401,13 @@ static void ufs_register_nodes(void)
                                           .edge.extra_device_opts =
                                               "mcq=true,mcq-maxq=1" };

+    QOSGraphTestOptions wb_test_opts = { .before = ufs_blk_test_setup,
+                                         .edge.extra_device_opts =
+                                             "mcq=false,nutrs=32,nutmrs=8,"
+                                             "wb-max-size=1024,wb-min-size=256,"
+                                             "wb-max-lus=1,wb-cap-adj-fac=3,"
+                                             "wb-reduction=1" };
+
     add_qpci_address(&edge_opts, &(QPCIAddress){ .devfn = QPCI_DEVFN(4, 0) });

     qos_node_create_driver("ufs", ufs_create);
@@ -1262,6 +1436,8 @@ static void ufs_register_nodes(void)
                  &io_test_opts);
     qos_add_test("query-desciptor", "ufs", ufstest_query_desc_request,
                  &io_test_opts);
+    qos_add_test("wb-init", "ufs", ufstest_wb_init, &wb_test_opts);
+    qos_add_test("wb-read-write", "ufs", ufstest_wb_read_write, &wb_test_opts);
 }

 libqos_init(ufs_register_nodes);
--
2.34.1

