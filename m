Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99186C5320E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglAW-0000jn-VY; Wed, 21 Aug 2024 09:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgb9a-0001sm-AT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:32:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sgb9W-00074T-L2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:32:54 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240821023245epoutp01f83a0804d6fd04552f712065019e8968~tnaVPfXzC2284722847epoutp01I
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:32:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240821023245epoutp01f83a0804d6fd04552f712065019e8968~tnaVPfXzC2284722847epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724207565;
 bh=N6uyiVAmxim8U0k7mpyvuJCgeFofxB0uCWjTNL6vsZY=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=cdqgwOGuqwe9Z4Rb129EnJ3LQDZaXiuPfvFP1Zf+t7sr/pxq0Lvcw15oT6sfDp0hj
 1AzlYKIYXgIwEZYh6TnlaK5RbpKpEldoBpvxcbk8Vhd3its1wV2SohkurUmoiekD7j
 P/5Tt4AiZgtP3gYCqei8LeRda8jyOw5YnQ3IjckQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240821023245epcas1p1cd8fa7dbae7f73653208bfb041b26786~tnaVAU8O31099710997epcas1p1Q;
 Wed, 21 Aug 2024 02:32:45 +0000 (GMT)
X-AuditID: b6c32a38-995ff70000002812-71-66c551cd5fbf
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 92.E8.10258.DC155C66; Wed, 21 Aug 2024 11:32:45 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test
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
Message-ID: <20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b@epcms1p3>
Date: Wed, 21 Aug 2024 11:32:45 +0900
X-CMS-MailID: 20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmru7ZwKNpBo3NvBY9r/axWdzfeo3R
 4lODlMX+bf9YLY737mCxWHnMxmL32ZlsDuweO2fdZfd4cm0zk8f7fVfZPPq2rGIMYInisklJ
 zcksSy3St0vgymju+c1a8Muw4tHdw+wNjB1qXYycHBICJhL/n3xm6WLk4hAS2MEoseziMyCH
 g4NXQFDi7w5hkBphAQeJdR3H2UFsIQEFiR/Lb7JBxC0lPj+ZBmazCZhLvJ90nRHEFhEwlfjz
 fR3YTGaBZUwSj29OYIJYxisxo/0pC4QtLbF9+VawBk4BP4nZn5dB1YhK3Fz9lh3Gfn9sPiOE
 LSLReu8sM4QtKPHg525GkDslBCQl1r/WhAjXS9y49pgNwq6ReNR2C2qMvsS1jo1ga3kFfCUu
 L94GVsMioCrxZSfMWheJy8/vgK1iFpCX2P52DjPIeGYBTYn1u/QhwnwS7772sMJ8smPeE6hW
 FYlFF99DrZWS+HpiHTPEZR4S++85Q0J2KqPEie4ulgmM8rMQgTsLybJZCMsWMDKvYhRLLSjO
 TU8tNiww0StOzC0uzUvXS87P3cQITh1aFjsY5779oHeIkYmD8RCjBAezkghv98uDaUK8KYmV
 ValF+fFFpTmpxYcYpTlYlMR5z1wpSxUSSE8sSc1OTS1ILYLJMnFwSjUwtTQuOfLhjPo3topt
 rHV3Ano0/goZmz07tezN2aC4yff2Z0mcULm9tfZMaoLa8VsnkzXlfj9vEFv0Qeb2H/VPH1dv
 bW7Otpe2FLE2kvSWjcreFXAxX+Ttc4nZ0sq7djR/mzZn/6Wz6uGx1R671rKu//CxQUYvWDx5
 3lkWqdrdzCJZYckdTyeHNU2WVL/jmBjubZL7R+q4WYUZyzv5vTXL45vMJsl7sfLm8M6/dK5j
 pmX3pdrlXDpKXJ1CTO1P9HuUimqSF6ysLOm5tnHG2n0TMnsmzHZWzC/e2GA5+ciz0/Nbn5+d
 adbFumf1xjUZ2zMV3f/dZ3e4KsMgttdq4nJV0ScyqiJqTxR0eZZU/c5XYinOSDTUYi4qTgQA
 8jq6EIwDAAA=
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p3>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=yc01.jeong@samsung.com; helo=mailout1.samsung.com
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

From d0ae8e25aec4ae7d222a2ea667d5ddb61f14fe02 Mon Sep 17 00:00:00 2001
From: Yoochan Jeong <yc01.jeong@samsung.com>
Date: Wed, 21 Aug 2024 09:03:06 +0900
Subject: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test

Minor bugs and errors related to ufs-test are resolved. Some
permissions and code implementations that are not synchronized
with the ufs spec are edited.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 hw/ufs/ufs.c           | 26 +++++++++++++++++++++-----
 tests/qtest/ufs-test.c | 12 +++++++++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ce2c96aeea..9472a3c14a 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -971,7 +971,7 @@ static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
         UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_EE_STATUS] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_SECONDS_PASSED] = UFS_QUERY_ATTR_WRITE,
-    [UFS_QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_FFU_STATUS] = UFS_QUERY_ATTR_READ,
     [UFS_QUERY_ATTR_IDN_PSA_STATE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
     [UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE] =
@@ -1038,7 +1038,7 @@ static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
     }
 
     *(((uint8_t *)&u->flags) + idn) = value;
-    req->rsp_upiu.qr.value = cpu_to_be32(value);
+    req->rsp_upiu.qr.value = value;
     return UFS_QUERY_RESULT_SUCCESS;
 }
 
@@ -1148,8 +1148,11 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
 {
     UfsHc *u = req->hc;
     uint8_t idn = req->req_upiu.qr.idn;
+    uint8_t selector = req->req_upiu.qr.selector;
     uint32_t value;
     QueryRespCode ret;
+    const uint8_t UFS_QUERY_ATTR_CNTX_CONF_SELECTOR = 15;
+    const uint32_t UFS_QUERY_ATTR_MAXVALUE = 0x0F;
 
     ret = ufs_attr_check_idn_valid(idn, op);
     if (ret) {
@@ -1159,10 +1162,20 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
     if (op == UFS_QUERY_ATTR_READ) {
         value = ufs_read_attr_value(u, idn);
     } else {
-        value = be32_to_cpu(req->req_upiu.qr.value);
+        value = req->req_upiu.qr.value;
+        if (idn == UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL &&
+            value > UFS_QUERY_ATTR_MAXVALUE) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
+        if (idn == UFS_QUERY_ATTR_IDN_CNTX_CONF) {
+            if (selector != UFS_QUERY_ATTR_CNTX_CONF_SELECTOR) {
+                return UFS_QUERY_RESULT_INVALID_SELECTOR;
+            } else if (value == 0x00 || value > UFS_QUERY_ATTR_MAXVALUE) {
+                return UFS_QUERY_RESULT_INVALID_VALUE;
+            }
+        }
         ufs_write_attr_value(u, idn, value);
     }
-
     req->rsp_upiu.qr.value = cpu_to_be32(value);
     return UFS_QUERY_RESULT_SUCCESS;
 }
@@ -1287,9 +1300,12 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
     UfsHc *u = req->hc;
     QueryRespCode status;
     uint8_t idn = req->req_upiu.qr.idn;
+    uint8_t selector = req->req_upiu.qr.selector;
     uint16_t length = be16_to_cpu(req->req_upiu.qr.length);
     InterconnectDescriptor desc;
-
+    if (selector != 0) {
+        return UFS_QUERY_RESULT_INVALID_SELECTOR;
+    }
     switch (idn) {
     case UFS_QUERY_DESC_IDN_DEVICE:
         memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device_desc));
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 82ec3f0671..d70c2ee4a3 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -119,8 +119,10 @@ static void ufs_send_nop_out(QUfs *ufs, uint8_t slot,
 
 static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
                            uint8_t query_opcode, uint8_t idn, uint8_t index,
+                           uint8_t selector, uint32_t attr_value,
                            UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
 {
+    const uint16_t UFS_QUERY_DESC_MAXLENGTH = 0x62;
     /* Build up utp transfer request descriptor */
     UtpTransferReqDesc utrd = ufs_build_req_utrd(ufs->cmd_desc_addr, slot,
                                                  UFS_UTP_NO_DATA_TRANSFER, 0);
@@ -136,13 +138,16 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
     req_upiu.header.query_func = query_function;
     req_upiu.header.task_tag = slot;
     /*
-     * QEMU UFS does not currently support Write descriptor and Write attribute,
+     * QEMU UFS does not currently support Write descriptor,
      * so the value of data_segment_length is always 0.
      */
     req_upiu.header.data_segment_length = 0;
     req_upiu.qr.opcode = query_opcode;
     req_upiu.qr.idn = idn;
     req_upiu.qr.index = index;
+    req_upiu.qr.selector = selector;
+    req_upiu.qr.value = attr_value;
+    req_upiu.qr.length = UFS_QUERY_DESC_MAXLENGTH;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
@@ -344,7 +349,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     /* Set fDeviceInit flag via query request */
     ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                    UFS_UPIU_QUERY_OPCODE_SET_FLAG,
-                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
+                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
 
     /* Wait for device to reset */
@@ -353,7 +358,8 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
         qtest_clock_step(ufs->dev.bus->qts, 100);
         ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
                        UFS_UPIU_QUERY_OPCODE_READ_FLAG,
-                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
+                       UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd,
+                       &rsp_upiu);
     } while (be32_to_cpu(rsp_upiu.qr.value) != 0 &&
              g_get_monotonic_time() < end_time);
     g_assert_cmpuint(be32_to_cpu(rsp_upiu.qr.value), ==, 0);
-- 
2.34.1


