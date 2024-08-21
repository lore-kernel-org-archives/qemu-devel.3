Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C62C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglAY-0000vS-7q; Wed, 21 Aug 2024 09:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgbBk-0002NC-RF
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:35:09 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgbBh-0007OL-Ny
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:35:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240821023502epoutp03d6eb5ad5a0fdc3df4e2437d12f4c3f8d~tncUdZnef0325603256epoutp03A
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240821023502epoutp03d6eb5ad5a0fdc3df4e2437d12f4c3f8d~tncUdZnef0325603256epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724207702;
 bh=oK9TosyU+tU+v44bqNhWkIMGnuXQSQIIajL48CtDwaM=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=UG6K/Jtv78FQXfYD+sfRBewf9rlk0aU8+a7GlkLCA68mF0wH7bld3sN1krV+cUKBo
 gvdxOCCN6wc6HhQtLf0Yj9EIMTnNtlpYXcfUkRmxqyiFZSMkqT0XFGmIJlkcWMYeek
 v+Rtj5prPJ/kJNLdQEUwle13b0yxUmOTfKW54bhw=
Received: from epsmgec1p1.samsung.com (unknown [182.195.42.51]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240821023501epcas1p1da5a0ee714be3a9042b128dd5513588a~tncUKRf-X0575805758epcas1p1k;
 Wed, 21 Aug 2024 02:35:01 +0000 (GMT)
X-AuditID: b6c32a33-faa0ca8000002320-44-66c552551175
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 CE.94.08992.55255C66; Wed, 21 Aug 2024 11:35:01 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 3/4] hw/ufs: ufs attribute read/write test implemented
From: =?UTF-8?B?7KCV7Jyg7LCs?= <yc01.jeong@samsung.com>
To: =?UTF-8?B?6rmA7KCc7Jqx?= <jeuk20.kim@samsung.com>
CC: =?UTF-8?B?7KCV7Jyg7LCs?= <yc01.jeong@samsung.com>, "thuth@redhat.com"
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
Message-ID: <20240821023501epcms1p1af3e6eb45517d1a1526b32f44c9bc355@epcms1p1>
Date: Wed, 21 Aug 2024 11:35:01 +0900
X-CMS-MailID: 20240821023501epcms1p1af3e6eb45517d1a1526b32f44c9bc355
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmnm5o0NE0g7aL+hY9r/axWdzfeo3R
 4lODlMX+bf9YLY737mCxWHnMxmL32ZlsDuweO2fdZfd4cm0zk8f7fVfZPPq2rGIMYInisklJ
 zcksSy3St0vgyjj0ZSZrwZ6Qiqlvz7A1MH506mLk5JAQMJF4+PAqexcjF4eQwA5GiRcfLzJ1
 MXJw8AoISvzdIQxSIyzgJrFq83sWEFtIQEHix/KbbBBxS4nPT6aB2WwC5hLvJ11nBLFFBEwl
 /nxfxwIyk1lgGZPE45sTmCCW8UrMaH/KAmFLS2xfvhWsgVPAT2L252VQNaISN1e/ZYex3x+b
 zwhhi0i03jvLDGELSjz4uZsR5E4JAUmJ9a81IcL1EjeuPWaDsGskHrXdghqjL3GtYyMLxFu+
 Eis7WUHCLAKqEltbu6DKXSTOvb8ENp1ZQF5i+9s5zCDlzAKaEut36UOE+STefe1hhXlkx7wn
 UAerSCy6+B5qjJTE1xPrmCEO85DYf88ZEmhTGSW2fimcwCg/CxG0s5DsmoWwawEj8ypGsdSC
 4tz01GTDAkO94sTc4tK8dL3k/NxNjOC0oWW8g/Hy/H96hxiZOBgPMUpwMCuJ8Ha/PJgmxJuS
 WFmVWpQfX1Sak1p8iFGag0VJnPfMlbJUIYH0xJLU7NTUgtQimCwTB6dUA9NyDjPLFfsOvnm6
 eHeGhDHvzUYvXiaRc5uv7fBc/H6VUUjXX/HFiWJ2mQlvg+pdM780eF//8FH2+vTGxm/qqzOW
 K23/IHHQReVr+5fTkx9arjYw01wgwHducviBaaul3yfcyLrNKP3kaL/4z6sqO/ce7/JIWtzz
 1SP/rlqE8l33Z1oLWU/IXj9fUGC4asutyIcaE94fjN/xJIu1q79hzxuF7PK+tJC3bH5ZDbzK
 1RlVm05x2p/cueiHzoVFt05dVvz2Rd5msrOPmtnD9LxbC0/+/FbFW5+9KC/Ht3HfhXNtXKcj
 mPzcAsUmiS4/vPH0gsgK740Rsxp8LzgKmwRN1nn947fHLOeFL8wDm89vURZTYinOSDTUYi4q
 TgQAtsCL1YoDAAA=
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p1>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=yc01.jeong@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Aug 2024 09:14:17 -0400
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

From 3341c347a70783c5e60a963501e63cb5da8f2e1f Mon Sep 17 00:00:00 2001
From: Yoochan Jeong <yc01.jeong@samsung.com>
Date: Wed, 21 Aug 2024 09:09:32 +0900
Subject: [PATCH 3/4] hw/ufs: ufs attribute read/write test implemented

New test function "ufstest_attr_request" added, which can check one's
virtual UFS device can properly read and write its attribute data.
It tests if reading and writing attributes work properly. There are
some testcases that are intended to make an error caused by writing an
invalid value, allocating an invalid selector and permission issues.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 166 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index f93de9f1f2..a8fd2f1acc 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -620,6 +620,171 @@ static void ufstest_flag_request(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_attr_request(void *obj, void *data, QGuestAllocator *alloc)
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
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_CNTX_CONF, 0, 15, 0x10, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_VALUE);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_CNTX_CONF, 0, 15, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
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
+    /* Invalid Selector (Intended Error)*/
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_CNTX_CONF, 0, 16, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_SELECTOR);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_CNTX_CONF, 0, 15, 0, &utrd, &rsp_upiu);
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
@@ -688,6 +853,7 @@ static void ufs_register_nodes(void)
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("flag read-write", "ufs", ufstest_flag_request, &io_test_opts);
+    qos_add_test("attr read-write", "ufs", ufstest_attr_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


