Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17234C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgwnd-0005Fr-Jb; Wed, 21 Aug 2024 21:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgwnb-0005FO-MJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:39:39 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgwnY-0006Cv-6z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 21:39:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240822013926epoutp04a67568b32a24a8d38ac5a6506729eb6e~t6VES7RMM1176511765epoutp042
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240822013926epoutp04a67568b32a24a8d38ac5a6506729eb6e~t6VES7RMM1176511765epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724290766;
 bh=VFXEaE2dL7KYMZX+iDb1LbxR+rtVsZ64x/tLWMXLtvo=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=eH6MlDi1G9WZcGKHUSraPUgLZvxO6/sllNg7Pf5s1QGOE0la8ehaFslF11OAe2OUd
 zU1Urg+H7xMTeiCzPtCYU8U+v7Ppd8X6nAeHE93ggL4qDdERbHrlGABnXj1LASt2PY
 xCQO1VcTf60MIy3V7X+7S1Un9Rqi4fdAEDB7TMHQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240822013926epcas1p2d7ea087cadf907a92117c6e008983541~t6VECIGWL0603406034epcas1p23;
 Thu, 22 Aug 2024 01:39:26 +0000 (GMT)
X-AuditID: b6c32a35-c03b870000002606-62-66c696ce3fa8
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 80.9A.09734.EC696C66; Thu, 22 Aug 2024 10:39:26 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 4/4] hw/ufs: ufs descriptor read test implemented
From: Yoochan Jeong <yc01.jeong@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
CC: Yoochan Jeong <yc01.jeong@samsung.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jeongyuchan0629@gmail.com"
 <jeongyuchan0629@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240822013925epcms1p112662453b1f4dcef8bc1e2f101bb6e6a@epcms1p1>
Date: Thu, 22 Aug 2024 10:39:25 +0900
X-CMS-MailID: 20240822013925epcms1p112662453b1f4dcef8bc1e2f101bb6e6a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCmru65acfSDCZPFbLoebWPzeL+1muM
 Fp8apCz2b/vHanG8dweLxcpjNha7z85kc2D32DnrLrvHk2ubmTze77vK5tG3ZRVjAEsUl01K
 ak5mWWqRvl0CV8bkTzsZCyYFVjyf+Jy5gfG6YxcjB4eEgInE3EcKXYxcHEICOxglprT8ZQKJ
 8woISvzdIdzFyMkhLOAo8afrMjuILSSgIPFj+U02iLiexOa1M9lAytkEdCQafjqAhEUEVCVe
 Ld7EAjKSWWA2k8SOk9MYQRISArwSM9qfskDY0hLbl28Fi3MK+EnM/ryMCSIuKnFz9Vt2GPv9
 sflQvSISrffOMkPYghIPfu5mhDhfUmL9a02IcL3EjWuP2SDsGolHbbegxuhLXOvYCLaWV8BX
 YuGEn2BxFqA7rz79A7XWReLs8d1gq5gF5CW2v53DDDKeWUBTYv0ufYgwn8S7rz2sMJ/smPcE
 qlVFYtHF91BrpSS+nljHDHGZh8T+e86QQJvKKLH1S+EERvlZiKCdhWTXLIRdCxiZVzGKpRYU
 56anFhsWGOoVJ+YWl+al6yXn525iBCcNLdMdjBPfftA7xMjEwXiIUYKDWUmEN+ne0TQh3pTE
 yqrUovz4otKc1OJDjNIcLErivGeulKUKCaQnlqRmp6YWpBbBZJk4OKUamLyneKkv+qMjPbP3
 6eMp3Le3Fhb9qfGd73l+geAc4xuM1enrcx0caxO63/5YsbjY/0D/6paLpttUWl/3qkbYrRKz
 jz1++P7qF599smYfflBw/edUq0zdvIsZLyfv7p7zQ9h38en3tS7zXzgJVn6azWJ8RIFv+wYT
 6a8HmcJtBdlqzrQezp31ds5P59XKd68GnJ54MVePb7q3w3Yu/X/N020fpmWf/VX9JKMwcP+9
 Q8Unly7c6Mn0dFLsQW3jSHG+Z++WnIiekLpPRvP4lZ2zN+89df+8vefleK4c4Vli32x8chVW
 6EwKv7triexnNvmaG09/sfm5yPvOadllsWN7fktANK+Bh7xkh2SwtPbsqJ9KLMUZiYZazEXF
 iQAZhwWuiQMAAA==
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p1>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=yc01.jeong@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From 936ef0a907bcf16809f9980c2d37e8fcb13697d2 Mon Sep 17 00:00:00 2001
From: Yoochan Jeong <yc01.jeong@samsung.com>
Date: Wed, 21 Aug 2024 09:09:54 +0900
Subject: [PATCH 4/4] hw/ufs: ufs descriptor read test implemented

New test function "ufstest_desc_request" added, which can check one's
virtual UFS device can properly read and its descriptor data.
(Writing descriptors are not implemented yet.)
The testcases attempt to read all kinds of descriptors at least once,
except for configuration descriptors (which are not implemented yet.)
There are some testcases that are intended to make an error caused by
an invalid index value or an invalid selector value.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 155 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index a8fd2f1acc..f96061f922 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -785,6 +785,160 @@ static void ufstest_attr_request(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_desc_request(void *obj, void *data, QGuestAllocator *alloc)
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
+    g_assert_cmpuint(rsp_upiu.qr.data[2], ==, 0x01);
+    g_assert_cmpuint(rsp_upiu.qr.data[3], ==, 0x80);
+    g_assert_cmpuint(rsp_upiu.qr.data[4], ==, 0x04);
+    g_assert_cmpuint(rsp_upiu.qr.data[5], ==, 0x10);
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
@@ -854,6 +1008,7 @@ static void ufs_register_nodes(void)
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("flag read-write", "ufs", ufstest_flag_request, &io_test_opts);
     qos_add_test("attr read-write", "ufs", ufstest_attr_request, &io_test_opts);
+    qos_add_test("desc read-write", "ufs", ufstest_desc_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


