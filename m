Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E032DC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOT9-0001UG-Je; Fri, 24 Jul 2026 18:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSn-0001Ra-9v
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSl-0001HF-Py
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJcblp4097294; Fri, 24 Jul 2026 22:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=wodZg
 ad0+CVcYs6KAWJUGbkKVi3AVufm8YFuuj3cHO0=; b=MMuKtvTJWcnoJv6q66ZYw
 j0+9exwlyT9vIsoLMGxwnTLHUXlu9W2JiHBWrTBIBij/QawmwKLnxtoWsrxf+K/D
 62Q7ET/74MDKvJlMs+QthIGLJr4BDZ5AmhsjnkOiGsCvwkEWHSp7ZmRbj+6d0X2B
 3KYhr/76xlpDg9h3MIZCwURcqDbmMatjQaVyFYKYyZ/TRQpPIbeYVIrHA8+0uog+
 qcmJ4tl9r81C2andXEQBeAjCx0dUqQ45bFawSs01dbN3j5z6q6/9TO9UpCVCxRJC
 WDi5+FIiKtpu6F7mpO0ZViSgrYCpQL1s5K/5ewOJTLgH5poUD1BwWTwo/x31dSAO
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n3s7j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXY8V028241; Fri, 24 Jul 2026 22:33:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:48 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTS029565;
 Fri, 24 Jul 2026 22:33:47 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-4; Fri, 24 Jul 2026 22:33:47 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 3/5] amd_iommu: Define MMIO register masks
Date: Fri, 24 Jul 2026 15:31:29 -0700
Message-ID: <20260724223216.108667-4-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260724223216.108667-1-dongli.zhang@oracle.com>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607240203
X-Proofpoint-GUID: MP-uiswhzXTJjeGU49FVhqcEc_4utbW3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfXxzAQUUOiQy6i
 AYQxJYo3QjrVaqLIrixk9iIzje9vjattRu5rSesT6CSZwvEKP7UZuIoQblB7GzJXJNIK1KTmooY
 Wq7DiAgISY1WemyeLyrbSzlABHGfHfzedMT8ATS5EgsNWXAszVeG
X-Proofpoint-ORIG-GUID: MP-uiswhzXTJjeGU49FVhqcEc_4utbW3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX3jdQ9Ht3K+hP
 7soV1MpYbaY5NouMtXTbSS0aNG7B7ZdRJIPngMcf96uiUP/PvzPz4gVOsOBZ7sltGSgPLa7zSSt
 2EH7kmTd+NedJUy962GolgfRYksLugJZf2eA+YpBBgdIh+Ntzf36fPknVdoDFTyFuylhzQ/ACXS
 nWPI8Y4Vh88ObbRTwyRP+IG0UdwpDbrkf50Ynw7BeKl0naT+if2AjX3ku/mVb4svzkPsmCqSBDk
 thm6fv78DAuLLYZSxu8UB2rViOg+6NNrFYPW0fqEIPzMH4MqFZPcoY4jeu3pQAfy6QWPYkrwR7n
 xcRPoh81mc5/+RoNvKfpwjU33QQ++iOOi5Zdzbu/RW4UXavMH2lCOKWd2vAkl/0wxdgl0g7T/B+
 GEsKhw88eIKENvTgHzLeXMGBhJbzoNoopLFLaz9LbWK3RNpd8e4MCL5fmm124NM806IFmIC5uKo
 tu8UZYr/06T+9glgQgQiT5YKtoeSSmcTfB0uTwQw=
X-Authority-Analysis: v=2.4 cv=PryjqQM3 c=1 sm=1 tr=0 ts=6a63e84d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=rsjDDBtBbUy8qCx-RwwA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12114
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MMIO read-only and write-1-to-clear masks used by amdvi_init() are
currently hardcoded. The hardcoded values look ambiguous.

Define named masks for the AMD-Vi MMIO registers to make the code easier
to read and understand. Use status bit names that match the Linux AMD
IOMMU driver definitions.

This is a cleanup.

Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.c |  5 +++--
 hw/i386/amd_iommu.h | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2fd680c4ff..7ca6d33abb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2563,8 +2563,9 @@ static void amdvi_init(AMDVIState *s)
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
     amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
                    amdvi_extended_feature_register(s),
-                   0xffffffffffffffef, 0);
-    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
+                   AMDVI_MMIO_EXT_FEATURE_RO_MASK, 0);
+    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, AMDVI_MMIO_STATUS_RO_MASK,
+                   AMDVI_MMIO_STATUS_W1C_MASK);
 }
 
 static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1c..f86e37fe93 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -107,11 +107,25 @@
 #define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
-#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
-#define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
-#define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
-#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
 #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
+#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
+#define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
+#define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
+#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
+#define AMDVI_MMIO_STATUS_PPR_OVF     (1 << 5)
+#define AMDVI_MMIO_STATUS_PPR_INT     (1 << 6)
+#define AMDVI_MMIO_STATUS_PPR_RUN     (1 << 7)
+#define AMDVI_MMIO_STATUS_GALOG_RUN   (1 << 8)
+#define AMDVI_MMIO_STATUS_GALOG_OVF   (1 << 9)
+#define AMDVI_MMIO_STATUS_GALOG_INT   (1 << 10)
+
+#define AMDVI_MMIO_STATUS_RO_MASK \
+    (AMDVI_MMIO_STATUS_EVT_RUN | AMDVI_MMIO_STATUS_CMDBUF_RUN | \
+     AMDVI_MMIO_STATUS_PPR_RUN)
+#define AMDVI_MMIO_STATUS_W1C_MASK \
+    (AMDVI_MMIO_STATUS_EVT_OVF | AMDVI_MMIO_STATUS_EVENT_INT | \
+     AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPR_OVF | \
+     AMDVI_MMIO_STATUS_PPR_INT)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
 #define AMDVI_CMDBUF_ID_RSHIFT            4
@@ -227,6 +241,8 @@
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
+#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
+
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
         AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \
-- 
2.39.3


