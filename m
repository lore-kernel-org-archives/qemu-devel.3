Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E004606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lGcxWlqf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrj6-0000zL-E8; Fri, 13 Nov 2026 08:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nayeoni.kim@samsung.com>)
 id 1xRioy-00005Y-RK
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:23:28 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nayeoni.kim@samsung.com>)
 id 1xRiou-0006pT-UJ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:23:28 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261113042311epoutp03a40493ecb21cca39a7d289b778c84822~ngBIVWe1P0142001420epoutp03H
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261113042311epoutp03a40493ecb21cca39a7d289b778c84822~ngBIVWe1P0142001420epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1794543791;
 bh=iCmQpHxQ1PfRl+LfLZjoMP+ssjAoTsUJWXZSBPrEbds=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=lGcxWlqfLs3iSCPSpr8dBZkU8LZyPSiHFVO+oSGbaI+1XhSrIIMw3ZhhOuKNPnuk1
 q7wC+HUsmlmGv6akN2awJLgrkr6t9mZythcrmo5nPYSsPC5JzL5/o+jA14QmuEWEgh
 2bMLXq1eKJ/Iqzj8jAZSpkdqBRU7cXjJRLYSN3+c=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261113042311epcas2p3103320309a196e255ca73c771e3a7c61~ngBH2ke8o1853018530epcas2p3n;
 Fri, 13 Nov 2026 04:23:11 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.212]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4jQkdV5rlqz3hhT7; Fri, 13 Nov
 2026 04:23:10 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] hw/ufs: Complete rejected query requests with OCS SUCCESS
From: Nayeon Kim <nayeoni.kim@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261113042310epcms2p7ebd28a583ec7a5b7af016f674d88d63c@epcms2p7>
Date: Fri, 13 Nov 2026 13:23:10 +0900
X-CMS-MailID: 20261113042310epcms2p7ebd28a583ec7a5b7af016f674d88d63c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261113042310epcms2p7ebd28a583ec7a5b7af016f674d88d63c
References: <CGME20261113042310epcms2p7ebd28a583ec7a5b7af016f674d88d63c@epcms2p7>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=nayeoni.kim@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: nayeoni.kim@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the device rejects a QUERY REQUEST, ufs_exec_query_cmd() puts the
Query Response code in the QUERY RESPONSE UPIU but also returns
UFS_REQUEST_FAIL, so the UTRD OCS becomes INVALID COMMAND TABLE
ATTRIBUTES. A rejected query is a device response, not a host
controller error. UFSHCI states that the QUERY RESPONSE UPIU completes
the request.

A Linux guest reads the Query Response code only when OCS is
SUCCESS, so it sees every rejected query as a transfer error.

Report query failures only in the Query Response field and update the
qtest expectations. The tests still check each Query Response code.

Signed-off-by: Nayeon Kim <nayeoni.kim@samsung.com>
---
 hw/ufs/ufs.c           |  3 ---
 tests/qtest/ufs-test.c | 26 +++++++++++++-------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 3de67831eaeb..6e441b0c8557 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -2577,9 +2577,6 @@ static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
                           data_segment_length);
     ufs_build_query_response(req);
 
-    if (status != UFS_QUERY_RESULT_SUCCESS) {
-        return UFS_REQUEST_FAIL;
-    }
     return UFS_REQUEST_SUCCESS;
 }
 
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 1f86d834ac97..e64954872f6d 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -1106,7 +1106,7 @@ static void ufstest_query_flag_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_FLAG,
                          UFS_QUERY_FLAG_IDN_PURGE_ENABLE, 0, 0, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_READABLE);
 
@@ -1114,7 +1114,7 @@ static void ufstest_query_flag_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_SET_FLAG,
                          UFS_QUERY_FLAG_IDN_BUSY_RTC, 0, 0, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_WRITEABLE);
 
@@ -1206,7 +1206,7 @@ static void ufstest_query_attr_request(void *obj, void *data,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x10,
                          &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_VALUE);
 
@@ -1221,7 +1221,7 @@ static void ufstest_query_attr_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_ATTR,
                          UFS_QUERY_ATTR_IDN_SECONDS_PASSED, 0, 0, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_READABLE);
 
@@ -1229,7 +1229,7 @@ static void ufstest_query_attr_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0x01, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_NOT_WRITEABLE);
 
@@ -1391,14 +1391,14 @@ static void ufstest_query_desc_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_DESC,
                          UFS_QUERY_DESC_IDN_UNIT, 4, 0, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_INDEX);
 
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_DESC,
                          UFS_QUERY_DESC_IDN_STRING, 5, 0, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_INDEX);
 
@@ -1406,14 +1406,14 @@ static void ufstest_query_desc_request(void *obj, void *data,
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_DESC,
                          UFS_QUERY_DESC_IDN_DEVICE, 0, 1, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_SELECTOR);
 
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_READ_DESC,
                          UFS_QUERY_DESC_IDN_STRING, 0, 1, 0, &rsp_upiu);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.response, ==,
                      UFS_QUERY_RESULT_INVALID_SELECTOR);
 
@@ -1748,19 +1748,19 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE, 0, 0, 0x100, &rsp);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
 
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_HID_PROG_RATIO, 0, 0, 50, &rsp);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
 
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_HID_STATE, 0, 0, 0x01, &rsp);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_NOT_WRITEABLE);
 
     /*
@@ -1769,7 +1769,7 @@ static void ufstest_hid(void *obj, void *data, QGuestAllocator *alloc)
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
                          UFS_QUERY_ATTR_IDN_DEFRAG_OP, 0, 0, 0x03, &rsp);
-    g_assert_cmpuint(ocs, ==, UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp.header.response, ==, UFS_QUERY_RESULT_INVALID_VALUE);
 
     /*
-- 
2.43.0


