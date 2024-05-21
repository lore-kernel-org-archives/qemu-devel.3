Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB2C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NUG-0007hB-2u; Tue, 21 May 2024 07:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NUE-0007gU-VV
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1s9NUA-0003wT-OF
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:16:54 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240521111646epoutp023ea1bef416696a305b1fcefa36905575~RfNlumG361629516295epoutp02a
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 11:16:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240521111646epoutp023ea1bef416696a305b1fcefa36905575~RfNlumG361629516295epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716290206;
 bh=kCvxzvP6Xbera+pHcnuspK3z4sIcQXnqJeN7D2vphYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c01CSocVwBcZA2NdmAMT2m86d7wbRyne8hAkwZxiHkkxiMWJmjZwikQAFT+/ChTCm
 LyKeIKSkglSu9D5Sn6lGjoKYzLm/ZHaTK7kqV82poKkDfsOYNrmOO+6dMkV7V0KD5w
 GFVu0NQ0rgMkB7l5M6X0BC5Fcqk+dA6ulu4Gmy2A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240521111645epcas2p4ea5d73692cb473adb206fc83b108ec2e~RfNknovlc2788927889epcas2p4b;
 Tue, 21 May 2024 11:16:45 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VkBhr2jhwz4x9Q1; Tue, 21 May
 2024 11:16:44 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 66.D7.09673.C928C466; Tue, 21 May 2024 20:16:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epcas2p3c86343fde1fdd6dbd868d09188084ae0~RfNjT7xdN1548015480epcas2p39;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240521111643epsmtrp281298f9c9e1c76e171581635e995645a~RfNjRzWjK2930529305epsmtrp2Q;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
X-AuditID: b6c32a45-82dff700000025c9-29-664c829c49d4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 10.B4.09238.B928C466; Tue, 21 May 2024 20:16:43 +0900 (KST)
Received: from localhost.dsn.sec.samsung.com (unknown [10.229.54.230]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240521111643epsmtip154abce00e64ac948f102a5b557835308~RfNjJLw6u0137501375epsmtip10;
 Tue, 21 May 2024 11:16:43 +0000 (GMT)
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 1/2] hw/ufs: Update MCQ-related fields to block/ufs.h
Date: Tue, 21 May 2024 20:05:43 +0900
Message-Id: <20240521110544.258772-2-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521110544.258772-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe6cJp80g6dfBC1uHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR2XbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/zctZa14IlO
 xeuW5ewNjH+Uuhg5OCQETCTmfWXtYuTiEBLYwSgxYWcLE4TziVHi95l17BDON0aJlvuH2boY
 OcE6Nv3aDpXYyyhx8+ocKOc3o8T+zS9YQarYBNQlGqa+YgGxRQTSJS6/W8kKso9ZIFvi4Q09
 kLCwgKvE/z9N7CA2i4CqxIz/ixlBbF4Ba4mO1d+YIJbJS+w/eJYZpJVTwEbi1Hs5iBJBiZMz
 n4BNZwYqad46mxnkBAmBW+wSp9ZsYITodZG40LkU6mhhiVfHt7BD2FISn9/thYqXS/x8Mwmq
 vkLi4KzbbJBgsZe49jwF4mJNifW79CGiyhJHbkFt5ZPoOPyXHSLMK9HRJgQxQ1ni46FDzBC2
 pMTyS6+h9nhI/Lv8ERrO/YwSPyb9ZpzAqDALyTOzkDwzC2HxAkbmVYxiqQXFuempxUYFhvDY
 Tc7P3cQIToharjsYJ7/9oHeIkYmD8RCjBAezkgjvpi2eaUK8KYmVValF+fFFpTmpxYcYTYEh
 PZFZSjQ5H5iS80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYKo5
 flMrheWb0K93FhoTz9QyWLDVy2Q/vHzg5YPKJWzPVA1vlr817Y5YW/h66tZkbh23H6FfMthW
 he0WzklK/imw6WlT756j56L+BvGafW3kPG5mOqPnQ85tmc/G3580TH/38JHLlOcdR2QurlBa
 8nmlRIXRtvN/WBdJO4cVTjE7p3GIo0Ln8q1mg0lxZ37XH3h/5nv2vC3lS649zFGV9LZcZXkx
 IVyhQdhNx+/rMSt1h0ST7Up3H28+utBi2eaQ50uVdzzpVmJuT8/75xr/ZFGIm2Jgv4hWamd4
 YOG3vu+r3i+dHLvzzOWdwnbqmv0aF55Ol/kuEcF3tPHQ9Dl3rbWv+b3sk3DyV9tf9zSXRUiJ
 pTgj0VCLuag4EQDkIBgCEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO7sJp80gxcz1CxuHtjJZPHgbj+j
 xf2t1xgtllxMtXh2+gCzxax37WwWx3t3sDiwezy5tpnJ4/2+q2wefVtWMQYwR3HZpKTmZJal
 FunbJXBl/Ny1lrXgiU7F65bl7A2Mf5S6GDk5JARMJDb92s7excjFISSwm1Fi3f3VLBAJSYl9
 p2+yQtjCEvdbjrBCFP1klFi14D1YEZuAukTD1FdgtohApsTCVx3sIDazQL5EV8cCJhBbWMBV
 4v+fJrA4i4CqxIz/ixlBbF4Ba4mO1d+YIBbIS+w/eJa5i5GDg1PARuLUezkQUwio5GobN0S1
 oMTJmU9YIKbLSzRvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLz
 czcxgsNXS2MH4735//QOMTJxMB5ilOBgVhLh3bTFM02INyWxsiq1KD++qDQntfgQozQHi5I4
 r+GM2SlCAumJJanZqakFqUUwWSYOTqkGpmX66cLvF/27qrLN6uF5FzvHrsa1m14plWRovPhx
 8PNKC523R24uLDeRvLNHeFqedtTrZdKSp5aJdE5UX/OpIfFz0tWl19de1zfh+y9y+bCcyKHP
 vQ/qap9HFNvLbW/RnqQez/Ys7W+M5nl/8TcR9tHsGjsnRe2RFzuXsXVj00Sr4E3BtU/MPl1/
 1lbYsi5WMtf05cr8Lf9FNbed+LP0UeEa26fBP/wyFvpclV/sNWfR+g239H0ytDdM1ft6edn+
 jrV2Eto7gme+vxr+U+ea92qmfNGcH5eCTy5ZOk3tpu6KlU9qNiW1vNlrMn1ZW4RqdnT+kV1O
 l0RTNWQUUoz+pnOnVPZPmqVX5HKAqdtty0IlluKMREMt5qLiRAD0b6fgzgIAAA==
X-CMS-MailID: 20240521111643epcas2p3c86343fde1fdd6dbd868d09188084ae0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521111643epcas2p3c86343fde1fdd6dbd868d09188084ae0
References: <20240521110544.258772-1-minwoo.im@samsung.com>
 <CGME20240521111643epcas2p3c86343fde1fdd6dbd868d09188084ae0@epcas2p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=minwoo.im@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch is a prep patch for the following MCQ support patch for
hw/ufs.  This patch updated minimal mandatory fields to support MCQ
based on UFSHCI 4.0.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 include/block/ufs.h | 108 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index d61598b8f3..3513b6e772 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -7,7 +7,7 @@
 
 typedef struct QEMU_PACKED UfsReg {
     uint32_t cap;
-    uint32_t rsvd0;
+    uint32_t mcqcap;
     uint32_t ver;
     uint32_t rsvd1;
     uint32_t hcpid;
@@ -46,6 +46,13 @@ typedef struct QEMU_PACKED UfsReg {
     uint32_t rsvd7[4];
     uint32_t rsvd8[16];
     uint32_t ccap;
+    uint32_t rsvd9[127];
+    uint32_t config;
+    uint32_t rsvd10[3];
+    uint32_t rsvd11[28];
+    uint32_t mcqconfig;
+    uint32_t esilba;
+    uint32_t esiuba;
 } UfsReg;
 
 REG32(CAP, offsetof(UfsReg, cap))
@@ -57,6 +64,15 @@ REG32(CAP, offsetof(UfsReg, cap))
     FIELD(CAP, OODDS, 25, 1)
     FIELD(CAP, UICDMETMS, 26, 1)
     FIELD(CAP, CS, 28, 1)
+    FIELD(CAP, LSDBS, 29, 1)
+    FIELD(CAP, MCQS, 30, 1)
+REG32(MCQCAP, offsetof(UfsReg, mcqcap))
+    FIELD(MCQCAP, MAXQ, 0, 8)
+    FIELD(MCQCAP, SP, 8, 1)
+    FIELD(MCQCAP, RRP, 9, 1)
+    FIELD(MCQCAP, EIS, 10, 1)
+    FIELD(MCQCAP, QCFGPTR, 16, 8)
+    FIELD(MCQCAP, MIAG, 24, 8)
 REG32(VER, offsetof(UfsReg, ver))
 REG32(HCPID, offsetof(UfsReg, hcpid))
 REG32(HCMID, offsetof(UfsReg, hcmid))
@@ -78,6 +94,7 @@ REG32(IS, offsetof(UfsReg, is))
     FIELD(IS, HCFES, 16, 1)
     FIELD(IS, SBFES, 17, 1)
     FIELD(IS, CEFES, 18, 1)
+    FIELD(IS, CQES, 20, 1)
 REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, UTRCE, 0, 1)
     FIELD(IE, UDEPRIE, 1, 1)
@@ -95,6 +112,7 @@ REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, HCFEE, 16, 1)
     FIELD(IE, SBFEE, 17, 1)
     FIELD(IE, CEFEE, 18, 1)
+    FIELD(IE, CQEE, 20, 1)
 REG32(HCS, offsetof(UfsReg, hcs))
     FIELD(HCS, DP, 0, 1)
     FIELD(HCS, UTRLRDY, 1, 1)
@@ -128,6 +146,10 @@ REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
 REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
 REG32(UCMDARG3, offsetof(UfsReg, ucmdarg3))
 REG32(CCAP, offsetof(UfsReg, ccap))
+REG32(CONFIG, offsetof(UfsReg, config))
+    FIELD(CONFIG, QT, 0, 1)
+REG32(MCQCONFIG, offsetof(UfsReg, mcqconfig))
+    FIELD(MCQCONFIG, MAC, 8, 8)
 
 #define UFS_INTR_MASK                                    \
     ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
@@ -157,6 +179,69 @@ REG32(CCAP, offsetof(UfsReg, ccap))
     ((be32_to_cpu(dword2) >> UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_SHIFT) & \
      UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_MASK)
 
+typedef struct QEMU_PACKED UfsMcqReg {
+    uint32_t sqattr;
+    uint32_t sqlba;
+    uint32_t squba;
+    uint32_t sqdao;
+    uint32_t sqisao;
+    uint32_t sqcfg;
+    uint32_t rsvd0[2];
+    uint32_t cqattr;
+    uint32_t cqlba;
+    uint32_t cquba;
+    uint32_t cqdao;
+    uint32_t cqisao;
+    uint32_t cqcfg;
+    uint32_t rsvd1[2];
+} UfsMcqReg;
+
+REG32(SQATTR, offsetof(UfsMcqReg, sqattr))
+    FIELD(SQATTR, SIZE, 0, 16)
+    FIELD(SQATTR, CQID, 16, 8)
+    FIELD(SQATTR, SQPL, 28, 3)
+    FIELD(SQATTR, SQEN, 31, 1)
+REG32(SQLBA, offsetof(UfsMcqReg, sqlba))
+REG32(SQUBA, offsetof(UfsMcqReg, squba))
+REG32(SQDAO, offsetof(UfsMcqReg, sqdao))
+REG32(SQISAO, offsetof(UfsMcqReg, sqisao))
+REG32(SQCFG, offsetof(UfsMcqReg, sqcfg))
+REG32(CQATTR, offsetof(UfsMcqReg, cqattr))
+    FIELD(CQATTR, SIZE, 0, 16)
+    FIELD(CQATTR, CQEN, 31, 1)
+REG32(CQLBA, offsetof(UfsMcqReg, cqlba))
+REG32(CQUBA, offsetof(UfsMcqReg, cquba))
+REG32(CQDAO, offsetof(UfsMcqReg, cqdao))
+REG32(CQISAO, offsetof(UfsMcqReg, cqisao))
+REG32(CQCFG, offsetof(UfsMcqReg, cqcfg))
+
+typedef struct QEMU_PACKED UfsMcqSqReg {
+    uint32_t hp;
+    uint32_t tp;
+    uint32_t rtc;
+    uint32_t cti;
+    uint32_t rts;
+} UfsMcqSqReg;
+
+typedef struct QEMU_PACKED UfsMcqCqReg {
+    uint32_t hp;
+    uint32_t tp;
+} UfsMcqCqReg;
+
+typedef struct QEMU_PACKED UfsMcqSqIntReg {
+    uint32_t is;
+    uint32_t ie;
+} UfsMcqSqIntReg;
+
+typedef struct QEMU_PACKED UfsMcqCqIntReg {
+    uint32_t is;
+    uint32_t ie;
+    uint32_t iacr;
+} UfsMcqCqIntReg;
+
+REG32(CQIS, offsetof(UfsMcqCqIntReg, is))
+    FIELD(CQIS, TEPS, 0, 1)
+
 typedef struct QEMU_PACKED DeviceDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1064,9 +1149,26 @@ typedef struct QEMU_PACKED UtpUpiuRsp {
     };
 } UtpUpiuRsp;
 
+/*
+ * MCQ Completion Queue Entry
+ */
+typedef UtpTransferReqDesc UfsSqEntry;
+typedef struct QEMU_PACKED UfsCqEntry {
+    uint64_t utp_addr;
+    uint16_t resp_len;
+    uint16_t resp_off;
+    uint16_t prdt_len;
+    uint16_t prdt_off;
+    uint8_t status;
+    uint8_t error;
+    uint16_t rsvd1;
+    uint32_t rsvd2[3];
+} UfsCqEntry;
+
 static inline void _ufs_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x104);
+    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x38C);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqReg) != 64);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
@@ -1086,5 +1188,7 @@ static inline void _ufs_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(UtpTaskReqDesc) != 80);
     QEMU_BUILD_BUG_ON(sizeof(UtpCmdRsp) != 40);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuRsp) != 288);
+    QEMU_BUILD_BUG_ON(sizeof(UfsSqEntry) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(UfsCqEntry) != 32);
 }
 #endif
-- 
2.34.1


