Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69C0C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh2vQ-0002cj-IM; Thu, 22 Aug 2024 04:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2vM-0002NP-9J
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:12:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2vH-0003oW-4L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:12:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240822081152epoutp03c10687073699d6c4c9e9506876bc447a~t-rst1IhY2316923169epoutp03X
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:11:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240822081152epoutp03c10687073699d6c4c9e9506876bc447a~t-rst1IhY2316923169epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724314312;
 bh=PRFT1AGU3DDvw8se3g6HVn1VVczumX9Ah+X3MnETuSM=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=fmbHeGFoRGgKqu3RIa2RCC0iTOYRj8vZ3NYZG090RJB3xQUMHEicNTvEFWb0OqgCs
 QUcWQCmpyjoB1Y7vogb9QOJ1cHxZszg8e7o+18hqFuwblcs4Ms2u64Wwr3750zjp3c
 dAzrDcGJV+GluyBLoEZLKW/TjzHb3CMn9lyssCQ8=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240822081151epcas1p4c069bb83803d2254a119a016a1f657e9~t-rsdTlzn3093130931epcas1p4I;
 Thu, 22 Aug 2024 08:11:51 +0000 (GMT)
X-AuditID: b6c32a35-c03b870000002606-3d-66c6f2c759b2
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 95.4E.09734.7C2F6C66; Thu, 22 Aug 2024 17:11:51 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 3/4] hw/ufs: ufs attribute read/write test implemented
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
Message-ID: <20240822081151epcms1p80b636bf684860cf709ad8dd95599248e@epcms1p8>
Date: Thu, 22 Aug 2024 17:11:51 +0900
X-CMS-MailID: 20240822081151epcms1p80b636bf684860cf709ad8dd95599248e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCmnu7xT8fSDDru6Fn0vNrHZnF/6zVG
 i08NUhb7t/1jtTjeu4PFYuUxG4vdZ2eyObB77Jx1l93jybXNTB7v911l8+jbsooxgCWKyyYl
 NSezLLVI3y6BK+PS6eMsBe9cKlqfL2VvYJxp1sXIySEhYCJx7uA6pi5GLg4hgR2MEjN2z2Xs
 YuTg4BUQlPi7QxikRljAU2LG0nvMILaQgILEj+U32SDiehKb185kAylnE9CRaPjpABIWEVCV
 eLV4EwvISGaB2UwSO05OY4TYxSsxo/0pC4QtLbF9+VawOKeAn0TX301MEHFRiZur37LD2O+P
 zYfqFZFovXeWGcIWlHjwczfYmRICkhLrX2tChOslblx7zAZh10g8arsFNUZf4lrHRrC1vAK+
 EvMmPQUbwwJ0590X36DqXSR2/JwMVs8sIC+x/e0cZpDxzAKaEut36UOE+STefe1hhflkx7wn
 UBerSCy6+B5qjJTE1xPrmCEu85B4c90fErBTGSWmvmhgnMAoPwsRtrOQLJuFsGwBI/MqRrHU
 guLc9NRiwwJDveLE3OLSvHS95PzcTYzgxKFluoNx4tsPeocYmTgYDzFKcDArifAm3TuaJsSb
 klhZlVqUH19UmpNafIhRmoNFSZz3zJWyVCGB9MSS1OzU1ILUIpgsEwenVAPT9li2okU7Z6Xw
 S4rJ3Z6zLy4px/Ht7KbjSkLNV6a9Kk1bXx6V4cxkyrXX+8ZW/Yd7fiWeeWqTY6uWz2h4W8JR
 clZAQNVUw5UGtZ2P2FU1ni1yi1nA+VXrVLN47+4Siyqjx4wSCaKe969/WapR+ilD+cHK6lP1
 5+dbX/OI+nxC2LHz08P7oi8cuNcrTftvkHvpgd6l8of+jBZnMxJn/uay7l+95UDD/md+8+x0
 Hzpf5gi+aemj/PJBw/a513Ym9HgoXbr19O5eTu95Bbec+NfuV8lit+kuUl58SLfd4OjpzTb2
 C/kqbwjnvK9wvP/6etb5KyGmaxerrlMPVl/7+QOXVMCqeiG2bQ3y7zRu/HdUYinOSDTUYi4q
 TgQAsMOG24sDAAA=
X-CMS-RootMailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
References: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
 <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p8>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=yc01.jeong@samsung.com; helo=mailout3.samsung.com
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

New test function "ufstest_query_attr_request" added, which can check one's
virtual UFS device can properly read and write its attribute data.
It tests if reading and writing attributes work properly. There are
some testcases that are intended to make an error caused by writing an
invalid value, allocating an invalid selector and permission issues.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 137 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9f45a078e7..061371414a 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -620,6 +620,141 @@ static void ufstest_query_flag_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_query_attr_request(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    ufs_init(ufs, alloc);
+
+    /* Read Readable Attributes*/
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_BOOT_LU_EN);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_BKOPS_STATUS, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    /* Write Writable Attributes & Read Again */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x03, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0x07, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
+
+    /* Write Invalid Value (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x10, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_VALUE);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    /* Read Write-Only Attribute (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_SECONDS_PASSED, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_READABLE);
+
+    /* Write Read-Only Attribute (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0x01, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    /* Reset Written Attributes */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -689,6 +824,8 @@ static void ufs_register_nodes(void)
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("flag read-write", "ufs",
                  ufstest_query_flag_request, &io_test_opts);
+    qos_add_test("attr read-write", "ufs",
+                 ufstest_query_attr_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


