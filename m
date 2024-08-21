Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E939C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglAP-0000Pi-S1; Wed, 21 Aug 2024 09:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgbAt-00024v-IO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:34:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgbAo-000789-Pn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:34:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240821023405epoutp0479ebd9095d1118374d7d0ab328e8503c~tnbf7N7761606216062epoutp04G
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240821023405epoutp0479ebd9095d1118374d7d0ab328e8503c~tnbf7N7761606216062epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724207645;
 bh=/jnEXg82krZrCK9RGKVhlkHKL0aHSxH2jLNY8e03PA0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=EleQdOaS9Vk2oIW9GG3Ipk6+qdBNThsGvb3oH35evvxLC1Chm52EtnBcWgxhz14LS
 WiJMy62mcsH7BZuwJdd5gmraZs93bUz/NEmoOO+z1HOnDbKpGU+V+uovzWZQ+tdvtY
 hUxZVyeweObdCdAWkbnDKwwCncdKCQ+D5OzMK0Ak=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240821023405epcas1p2ef2e059ba13c8207f54837b0c91ed65c~tnbfn-yjX2808428084epcas1p2r;
 Wed, 21 Aug 2024 02:34:05 +0000 (GMT)
X-AuditID: b6c32a38-995ff70000002812-30-66c5521de89d
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 8F.49.10258.D1255C66; Wed, 21 Aug 2024 11:34:05 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/4] hw/ufs: ufs flag read/write test implemented
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
Message-ID: <20240821023405epcms1p5c389077e4d12b814f75a50218ea0dd9f@epcms1p5>
Date: Wed, 21 Aug 2024 11:34:05 +0900
X-CMS-MailID: 20240821023405epcms1p5c389077e4d12b814f75a50218ea0dd9f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmvq5s0NE0g3M7RC16Xu1js7i/9Rqj
 xacGKYv92/6xWhzv3cFisfKYjcXuszPZHNg9ds66y+7x5NpmJo/3+66yefRtWcUYwBLFZZOS
 mpNZllqkb5fAlXHhlUjBd+2K99u+sDcwPlHqYuTgkBAwkWh+otbFyMUhJLCDUeJzw3d2kDiv
 gKDE3x3CXYycHMICjhIXpq1jB7GFBBQkfiy/yQYRt5T4/GQamM0mYC7xftJ1RhBbRMBU4s/3
 dSwgM5kFljFJPL45gQkkISHAKzGj/SkLhC0tsX35VrAGTgE/idmfl0HViErcXP2WHcZ+f2w+
 I4QtItF67ywzhC0o8eDnbkaI+yUl1r/WhAjXS9y49pgNwq6ReNR2C2qMvsS1jo1ga3kFfCV2
 nJoCNoZFQFVixY8pUPUuEt0Lr4HZzALyEtvfzmEGGc8soCmxfpc+RJhP4t3XHlaYT3bMewJ1
 sYrEoovvocZISXw9sY4Z4jIPif33nCEhO5VRYuW+fqYJjPKzEIE7C8myWQjLFjAyr2IUSy0o
 zk1PLTYsMNErTswtLs1L10vOz93ECE4bWhY7GOe+/aB3iJGJg/EQowQHs5IIb/fLg2lCvCmJ
 lVWpRfnxRaU5qcWHGKU5WJTEec9cKUsVEkhPLEnNTk0tSC2CyTJxcEo1MGXM29dfPLOFY4ln
 fyljp19QleYGztXKBmET+7juM9wXZLwlt5hB7UuPkXfZycfTOt6c2rg+8uWLH3oi6rE+Nw+c
 CK/YcbyN//MqNQttiy8farVsOI6KNlXOfyT0YJrcUtZsHnde6Xk3PZbniscom0yx3bfwhatd
 TkzHOzvlLteqsCW69mVbF+asZns+k1Ntbc1p/kkn9U7yLXZS0sq24em0Vpx/73/Qe6tNK760
 9di8EGplOLfxRvcWXe+Xfz6WT358NPhlXmfJ08ovCkrhd74xndhgce9xbuz9p13mwnv35rzf
 NKtDJkjttZ3Hxn9h7D01UyzmXP1b2VhQJ7BZcM300M4Em5UzNiQte1e1W4mlOCPRUIu5qDgR
 AF+Uf2mKAwAA
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p5>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=yc01.jeong@samsung.com; helo=mailout4.samsung.com
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

From fa2187660e82e7772c2061b22ba9eab95e92f77c Mon Sep 17 00:00:00 2001
From: Yoochan Jeong <yc01.jeong@samsung.com>
Date: Wed, 21 Aug 2024 09:08:18 +0900
Subject: [PATCH 2/4] hw/ufs: ufs flag read/write test implemented

New test function "ufstest_flag_request" added, which can check one's
virtual UFS device can properly read and write its flag data. It tests
if reading, setting, clearing and toggling flags work properly. There
are some testcases that are intended to make an error caused by
permission issues.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d70c2ee4a3..f93de9f1f2 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -540,6 +540,86 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_flag_request(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    ufs_init(ufs, alloc);
+
+    /* Read read-only flag */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_FLAG);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_FLAG_IDN_FDEVICEINIT);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 0);
+
+    /* Flag Set, Clear, Toggle Test with fDeviceLifeSpanModeEn */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 0);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 1);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 0);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 1);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, 0);
+
+    /* Read Write-only Flag (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_PURGE_ENABLE, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_READABLE);
+
+    /* Write Read-Only Flag (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_SET_FLAG, UFS_QUERY_FLAG_IDN_BUSY_RTC,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -607,6 +687,7 @@ static void ufs_register_nodes(void)
     }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
+    qos_add_test("flag read-write", "ufs", ufstest_flag_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


