Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10895C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh2wE-0006MP-JA; Thu, 22 Aug 2024 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2wD-0006G8-6F
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:12:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2wA-0004AK-Co
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:12:56 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240822081251epoutp02ce253fb39e2f459adc2cc52ea3552661~t-sj2V-vo1873218732epoutp027
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240822081251epoutp02ce253fb39e2f459adc2cc52ea3552661~t-sj2V-vo1873218732epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724314371;
 bh=ApvMX5Gv/uAu6oZ460rDZr0EufBPjuLQzrbqJKDHQ0g=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=WUDLbF/GOaIeNpLDTexy6+asxJ1Q1YDyj3nQcbPBMgiSHmcgiNUvaizSKbgcLajhO
 nFRjoEcKnQOcJYsTfWMsboKVWWmW5BIHH25VmUhQvM42JH9CTgjStKNoGkSHBTpaU5
 g1OR4EnES+WqLSCwNwKkpLFXQ3EOdwQTRlSQeHRM=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240822081251epcas1p2a77b0f522c133514f881dcbe5a69bcf3~t-sjmzO4p1842218422epcas1p2Q;
 Thu, 22 Aug 2024 08:12:51 +0000 (GMT)
X-AuditID: b6c32a39-8f9ff70000002606-8e-66c6f3022924
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 25.E0.09734.203F6C66; Thu, 22 Aug 2024 17:12:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 4/4] hw/ufs: ufs descriptor read test implemented
From: Yoochan Jeong <yc01.jeong@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: Yoochan Jeong <yc01.jeong@samsung.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jeongyuchan0629@gmail.com"
 <jeongyuchan0629@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240822081250epcms1p44a1e0f0c3343e58ec103f749276a8b52@epcms1p4>
Date: Thu, 22 Aug 2024 17:12:50 +0900
X-CMS-MailID: 20240822081250epcms1p44a1e0f0c3343e58ec103f749276a8b52
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmri7T52NpBguWmFr0vNrHZnF/6zVG
 i08NUhb7t/1jtTjeu4PFYuUxG4vdZ2eyObB77Jx1l93jybXNTB7v911l8+jbsooxgCWKyyYl
 NSezLLVI3y6BK+PgzdvsBSd8K04tEW1gbLbrYuTkkBAwkbj76RpLFyMXh5DADkaJngnHWLsY
 OTh4BQQl/u4QBqkRFnCR2PP1HRuILSSgIPFj+U02iLiexOa1M9lAytkEdCQafjqAhEUEVCVe
 Ld4ENpJZYDaTxI6T0xghdvFKzGh/ygJhS0tsX74VLM4p4CfR9XcTE0RcVOLm6rfsMPb7Y/Oh
 ekUkWu+dZYawBSUe/NzNCLJXQkBSYv1rTYhwvcSNa4/ZIOwaiUdtt6DG6Etc69gItpZXwFfi
 3J+7YHEWoDvf7PoHVeMi8X/eIbBVzALyEtvfzmEGGc8soCmxfpc+RJhP4t3XHlaYT3bMewJ1
 sYrEoovvodZKSXw9sY4Z4jIPiTfX/SEBO5VRYtqSHrYJjPKzEGE7C8myWQjLFjAyr2IUSy0o
 zk1PLTYsMNUrTswtLs1L10vOz93ECE4bWpY7GKe//aB3iJGJg/EQowQHs5IIb9K9o2lCvCmJ
 lVWpRfnxRaU5qcWHGKU5WJTEec9cKUsVEkhPLEnNTk0tSC2CyTJxcEo1MG07FNN7YKOddJ92
 bOWUp/95f135k2xraHdUqoF7iv6bP0pbA0QYo+87dOXPWdfpXFUxWXz69jB3hVKx5svJe46W
 dclKHsya06O0ezG72bp90QouP3963S0rcklZ+EU422PWy2czj6ROa6z9mmalH/Duw0uW10lz
 uJ4WhHyUKPmtrJVkwHGy46hNmM5DT6GwfRGbvLI+txS4X5nEeiL4aunkHaHuD8+/fxV9Iu9O
 lXJ2yLeFJz645C74OEdp9ca0PxHPvDw+9uqscXPLMDWc9nHzjrWHqlOffzE+MG9O/pX7HGt4
 PVQ9RP0+8aR66Yl82P3r9JYbeZIbDk7R2pnEFZqo8VnE9ZCzuMOU3Y9j1JRYijMSDbWYi4oT
 ATc3XwyKAwAA
X-CMS-RootMailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
References: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
 <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p4>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=yc01.jeong@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: yc01.jeong@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

New test function "ufstest_query_desc_request" added, which can check one's
virtual UFS device can properly read and its descriptor data.
(Writing descriptors are not implemented yet.)
The testcases attempt to read all kinds of descriptors at least once,
except for configuration descriptors (which are not implemented yet.)
There are some testcases that are intended to make an error caused by
an invalid index value or an invalid selector value.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 153 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 061371414a..60199abbee 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -755,6 +755,157 @@ static void ufstest_query_attr_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_query_desc_request(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    ufs_init(ufs, alloc);
+
+    /* Write Descriptor is not supported yet */
+
+    /* Read Device Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_DESC);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_DESC_IDN_DEVICE);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_DEVICE);
+
+    /* Read Configuration Descriptor is not supported yet*/
+
+    /* Read Unit Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 0,
+                   0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
+    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 0);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 1,
+                   0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(UnitDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
+    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 1);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT,
+                   UFS_UPIU_RPMB_WLUN, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(RpmbUnitDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_UNIT);
+    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, UFS_UPIU_RPMB_WLUN);
+
+    /* Read Interconnect Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC,
+                   UFS_QUERY_DESC_IDN_INTERCONNECT, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(InterconnectDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_INTERCONNECT);
+
+    /* Read String Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x12);
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
+                   1, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x22);
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
+                   4, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, 0x0a);
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_STRING);
+
+    /* Read Geometry Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_GEOMETRY,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(GeometryDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_GEOMETRY);
+
+    /* Read Power Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_POWER, 0,
+                   0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==,
+                     sizeof(PowerParametersDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_POWER);
+
+    /* Read Health Descriptor */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_HEALTH,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.data[0], ==, sizeof(DeviceHealthDescriptor));
+    g_assert_cmpuint(rsp_upiu.qr.data[1], ==, UFS_QUERY_DESC_IDN_HEALTH);
+
+    /* Invalid Index (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_UNIT, 4,
+                   0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_INDEX);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
+                   5, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_INDEX);
+
+    /* Invalid Selector (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_DEVICE,
+                   0, 1, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_SELECTOR);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_DESC, UFS_QUERY_DESC_IDN_STRING,
+                   0, 1, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_SELECTOR);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -826,6 +977,8 @@ static void ufs_register_nodes(void)
                  ufstest_query_flag_request, &io_test_opts);
     qos_add_test("attr read-write", "ufs",
                  ufstest_query_attr_request, &io_test_opts);
+    qos_add_test("desc read-write", "ufs",
+                 ufstest_query_desc_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


