Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A3EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh2uI-0006H9-OP; Thu, 22 Aug 2024 04:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2u8-0005lI-W2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:10:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2u1-0003ft-3g
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:10:47 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240822081037epoutp01f063423ed4207340f9c8af32c13cb32f~t-qmrn6Gy1355413554epoutp01i
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:10:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240822081037epoutp01f063423ed4207340f9c8af32c13cb32f~t-qmrn6Gy1355413554epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724314237;
 bh=peOOMdnDZ9lJoQNizS5JTpk+si4tXnJCFXPM25eZRPc=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=b1UcKI2O+UGl3ScFEDuTUDN0YXHzJQYv58oZ2ui/VVQ9EELcd0nCurBodEv0d8Qyw
 VcCHPCtmUAGLszXLWnODwPwtx60fEvApeOgJl7cssyf6fk5STOOF54NVj9/iJvFVI7
 xmE9eAwjzbZL0vERxrDGnGqzr5hsD/Yq25luGSuo=
Received: from epsmgec1p1.samsung.com (unknown [182.195.42.51]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240822081036epcas1p29b0f6097490bf2ab31c7da8284fcd0d8~t-qmTwC9f2005220052epcas1p2o;
 Thu, 22 Aug 2024 08:10:36 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-75-66c6f27cda51
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 07.FC.08992.C72F6C66; Thu, 22 Aug 2024 17:10:36 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 2/4] hw/ufs: ufs flag read/write test implemented
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
Message-ID: <20240822081036epcms1p40404f328ff240ad0997ff0033dcd1db0@epcms1p4>
Date: Thu, 22 Aug 2024 17:10:36 +0900
X-CMS-MailID: 20240822081036epcms1p40404f328ff240ad0997ff0033dcd1db0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCmvm7Np2NpBs8mSlv0vNrHZnF/6zVG
 i08NUhb7t/1jtTjeu4PFYuUxG4vdZ2eyObB77Jx1l93jybXNTB7v911l8+jbsooxgCWKyyYl
 NSezLLVI3y6BK+PB5RdMBau1Kxa2/2NvYPyv2MXIySEhYCLxoGsWexcjF4eQwA5GiRvL3gI5
 HBy8AoISf3cIg9QIC7hI3Hn4iR3EFhJQkPix/CYbRFxPYvPamWwg5WwCOhINPx1AwiICqhKv
 Fm9iARnJLDCbSWLHyWmMELt4JWa0P2WBsKUlti/fChbnFPCT6Pq7iQkiLipxc/Vbdhj7/bH5
 UL0iEq33zjJD2IISD37uZgTZKyEgKbH+tSZEuF7ixrXHbBB2jcSjtltQY/QlrnVsBFvLK+Ar
 sf/qB7AxLEB3tnxYCTXeReLixtNgNrOAvMT2t3OYQcYzC2hKrN+lDxHmk3j3tYcV5pMd855A
 Xawisejie6i1UhJfT6xjhrjMQ+LNdX9IwE5llJi2pIdtAqP8LETYzkKybBbCsgWMzKsYxVIL
 inPTU5MNCwz1ihNzi0vz0vWS83M3MYITh5bxDsbL8//pHWJk4mA8xCjBwawkwpt072iaEG9K
 YmVValF+fFFpTmrxIUZpDhYlcd4zV8pShQTSE0tSs1NTC1KLYLJMHJxSDUyFy1VKlixlnz3x
 3KRHmb8uq6aezbNYsLd3ycqQcy9/eLybrv2uzO7HRovrMg6nZW5P1pCMV5tXEM2SdlQum60k
 RmSWQtis3tycEwHNG4sjDuhJc/Yt4L0ae/Vg5r6dT7rck+6q+P/iEkyZ6u9bF7ktNbupVz3p
 1vwtX7bO7JkkNvusuP5adRtb9mpbgzIvqSc+Bv2yx589jz+9fWb8geuvdjD/9U0qSn92oLIv
 O+xooPOkw7c7jtXHrFmz7t8lo9DdPAnbWTu7/CuVG1N9PK/M3OMYmLQ9U/iY02RvkaC/lfNt
 +e6sknD4dnzC9PkT0n6t2tXMIaf54gJ/zYMXuR90agxNjXZuZb7ie1xrRY8SS3FGoqEWc1Fx
 IgB2/XMviwMAAA==
X-CMS-RootMailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
References: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
 <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p4>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=yc01.jeong@samsung.com; helo=mailout1.samsung.com
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

New test function "ufstest_flag_request" added, which can check one's
virtual UFS device can properly read and write its flag data. It tests
if reading, setting, clearing and toggling flags work properly. There
are some testcases that are intended to make an error caused by
permission issues.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 tests/qtest/ufs-test.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9cc9e578ff..9f45a078e7 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -539,6 +539,87 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_query_flag_request(void *obj, void *data,
+                                       QGuestAllocator *alloc)
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
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    /* Flag Set, Clear, Toggle Test with fDeviceLifeSpanModeEn */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
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
@@ -606,6 +687,8 @@ static void ufs_register_nodes(void)
     }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
+    qos_add_test("flag read-write", "ufs",
+                 ufstest_query_flag_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


