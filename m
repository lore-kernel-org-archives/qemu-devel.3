Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE430C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh2tO-0002Ot-Fz; Thu, 22 Aug 2024 04:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2tM-0002Fq-UO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:10:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh2tJ-0003Md-51
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:10:00 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240822080951epoutp04e48c988a13d859c0772e6bf8ccd5ee1f~t-p8t5-0A0169501695epoutp04F
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:09:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240822080951epoutp04e48c988a13d859c0772e6bf8ccd5ee1f~t-p8t5-0A0169501695epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724314192;
 bh=22NrpoqnHafTl3NuCOoXpp+J5abI/wIFhknJH3Zzo1Q=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=gUuK7qpPx+ztbYqBiRxq/3B3hN0GUm41GYDMiTG2xbq+LLObsrlWsEul9mDQI18dD
 RWFgjmNJkGUXNGi7d4lLy9xOgR4pDCVvUrtMkzxurHgkFfPkgylgCmAgDz/Mhxh0IY
 FoPVuEqGhESoaD5vEghW2hvT2VUqya9XVPugbf7U=
Received: from epsmgec1p1.samsung.com (unknown [182.195.42.54]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240822080951epcas1p39c515d6b10eb1cd2fe9bf2adaf4aab79~t-p8Tuz5n2566825668epcas1p3R;
 Thu, 22 Aug 2024 08:09:51 +0000 (GMT)
X-AuditID: b6c32a36-ef9ff70000002597-ff-66c6f24ffb7f
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 90.D4.09623.F42F6C66; Thu, 22 Aug 2024 17:09:51 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 1/4] hw/ufs: minor bug fixes related to ufs-test
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
Message-ID: <20240822080950epcms1p3d4c509b00ec973811a2daa43b1b2cc5e@epcms1p3>
Date: Thu, 22 Aug 2024 17:09:50 +0900
X-CMS-MailID: 20240822080950epcms1p3d4c509b00ec973811a2daa43b1b2cc5e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCmnq7/p2NpBjf+iln0vNrHZnF/6zVG
 i08NUhb7t/1jtTjeu4PFYuUxG4vdZ2eyObB77Jx1l93jybXNTB7v911l8+jbsooxgCWKyyYl
 NSezLLVI3y6BK+PcxPKCUzoVfx5+Zm1gnKjUxcjJISFgIjHj+w62LkYuDiGBHYwSC3e/Zeli
 5ODgFRCU+LtDGKRGWMBZYun7FSwgtpCAgsSP5TfZIOJ6EpvXzmQDKWcT0JFo+OkAEhYRUJV4
 tXgTC8hIZoHZTBI7Tk5jhNjFKzGj/SkLhC0tsX35VrA4p4CfRNffTUwQcVGJm6vfssPY74/N
 h+oVkWi9d5YZwhaUePBzNyPIXgkBSYn1rzUhwvUSN649ZoOwayQetd2CGqMvca1jI9RXvhIP
 ToqAhFmAzrww+SoLxBQXiZvH0kDCzALyEtvfzmEGCTMLaEqs36UPEeaTePe1hxXmjx3znkDd
 qyKx6OJ7qKVSEl9PrGOGmOgh8ea6PyRYpzJKTJx0lnkCo/wsRMjOQrJsFsKyBYzMqxjFUguK
 c9NTiw0LjPSKE3OLS/PS9ZLzczcxglOGltkOxklvP+gdYmTiYDzEKMHBrCTCm3TvaJoQb0pi
 ZVVqUX58UWlOavEhRmkOFiVx3jNXylKFBNITS1KzU1MLUotgskwcnFINTAK+91IUX7HmVd5c
 8Kqovi7hcl7E3g1nzuyY/2zHHQHu16vspkvpH9t2TliX/+Jhawvhkgt+LJzffsb3G9dL8O6s
 0XE+UHqkPSVU8NEXW+2//7aWJOivbuT0M/X+mnmLuVruVl6Fp+aJzIZ8kUl1ZgsazwS9vdn8
 pmyDwxNlkVl66+dp2YWqKJeyelaoJq5nfOB7bsH2lOeOt7bWdQbnvX42danLtMB7PtPKNUKl
 Nm3ePLPvgfN5XTn9nmCpV+3hK8U73hyP+MzyR6umoubTh8uKE65xdajFaRxIdfUzWB1067ng
 d2nVk7F+Rw5uk/Bk3sKb0nhP4/680zvruN3Kdbwc0puU3xxmzs/RKmZUYinOSDTUYi4qTgQA
 YVTQNIgDAAA=
X-CMS-RootMailID: 20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71
References: <20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p1>
 <CGME20240822080846epcms1p122450de3fc0c0f8aa46db1ea00392c71@epcms1p3>
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

Minor bugs and errors related to ufs-test are resolved. Some
permissions and code implementations that are not synchronized
with the ufs spec are edited.

Based on: 20240802051902epcms2p319bc095a15eaef8de4e6955f6718371d@epcms2p3
Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
---
 hw/ufs/ufs.c           | 19 +++++++++++++------
 include/block/ufs.h    |  6 ++++++
 tests/qtest/ufs-test.c | 11 ++++++++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ce2c96aeea..79f786ed4e 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1111,10 +1111,13 @@ static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
     return 0;
 }
 
-static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
+static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
 {
     switch (idn) {
     case UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
+        if (value > UFS_QUERY_ATTR_ACTIVE_ICC_MAXVALUE) {
+            return UFS_QUERY_RESULT_INVALID_VALUE;
+        }
         u->attributes.active_icc_level = value;
         break;
     case UFS_QUERY_ATTR_IDN_MAX_DATA_IN:
@@ -1142,6 +1145,7 @@ static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
         u->attributes.psa_data_size = cpu_to_be32(value);
         break;
     }
+    return UFS_QUERY_RESULT_SUCCESS;
 }
 
 static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
@@ -1158,13 +1162,13 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
 
     if (op == UFS_QUERY_ATTR_READ) {
         value = ufs_read_attr_value(u, idn);
+        ret = UFS_QUERY_RESULT_SUCCESS;
     } else {
-        value = be32_to_cpu(req->req_upiu.qr.value);
-        ufs_write_attr_value(u, idn, value);
+        value = req->req_upiu.qr.value;
+        ret = ufs_write_attr_value(u, idn, value);
     }
-
     req->rsp_upiu.qr.value = cpu_to_be32(value);
-    return UFS_QUERY_RESULT_SUCCESS;
+    return ret;
 }
 
 static const RpmbUnitDescriptor rpmb_unit_desc = {
@@ -1287,9 +1291,12 @@ static QueryRespCode ufs_read_desc(UfsRequest *req)
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
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 92da7a89b9..57f5ea3500 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -763,6 +763,12 @@ typedef struct QEMU_PACKED UtpTaskReqDesc {
  */
 #define UFS_WB_EXCEED_LIFETIME 0x0B
 
+/*
+ * The range of valid value of Active ICC attritbute
+ * is from 0x00 to 0x0F.
+ */
+#define UFS_QUERY_ATTR_ACTIVE_ICC_MAXVALUE 0x0F
+
 /*
  * In UFS Spec, the Extra Header Segment (EHS) starts from byte 32 in UPIU
  * request/response packet
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 82ec3f0671..9cc9e578ff 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -119,6 +119,7 @@ static void ufs_send_nop_out(QUfs *ufs, uint8_t slot,
 
 static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
                            uint8_t query_opcode, uint8_t idn, uint8_t index,
+                           uint8_t selector, uint32_t attr_value,
                            UtpTransferReqDesc *utrd_out, UtpUpiuRsp *rsp_out)
 {
     /* Build up utp transfer request descriptor */
@@ -136,13 +137,16 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
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
+    req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
     qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
                    sizeof(req_upiu));
 
@@ -344,7 +348,7 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
     /* Set fDeviceInit flag via query request */
     ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                    UFS_UPIU_QUERY_OPCODE_SET_FLAG,
-                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, &utrd, &rsp_upiu);
+                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
 
     /* Wait for device to reset */
@@ -353,7 +357,8 @@ static void ufs_init(QUfs *ufs, QGuestAllocator *alloc)
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


