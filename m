Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D44606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=YAy4p5yx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMadl-0004Z3-8y; Thu, 29 Oct 2026 20:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMada-0004WO-75
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xMadW-0003cy-OM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:38:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZ0JR2257137; Fri, 30 Oct 2026 00:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=8AO9z
 X02KKkYjQiAA6XL64wtAq8lOksvsfSsNfqqeLk=; b=YAy4p5yx5RLkKlfxH9R55
 e6Du+vsBAGr5OXtQk0h1zCVBvrQ7rJoxqKvULv+8eqqT4+yVhhfRK13bz6eRrKEn
 ZcycgPxc4MNHc71qjblFY3dyeUFf/LvXthsae74ki0vHSdyOqqcynY/ltSNSZoVb
 Xf7qFwW2oYuyrnMzFwO63K1lav9OlS+3qfqwSIgKSgom6Vi4qFwV0qwgGaqsLCLt
 vINhOdI156L1LBmUae5q7w4cw5DtMQakGwvu51QH8X3jcal7Qm4Ml0eIJhnc0M54
 CF5N9qklXnTyONA4ajF90e4u0oHJmO+GPzDL8M3vSHBH9oau03Pq5mhi5qDrZ9C5
 g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hme61r42j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 00:38:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 69TNgCf52004316; Fri, 30 Oct 2026 00:38:22 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4hmg231tmh-4; Fri, 30 Oct 2026 00:38:21 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 3/5] amd_iommu: Define MMIO register masks
Date: Fri, 30 Oct 2026 00:38:15 +0000
Message-ID: <20261030003817.3521476-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
References: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610300001
X-Authority-Analysis: v=2.4 cv=L9qI0OT8 c=1 sm=1 tr=0 ts=6ae3e6ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=FWg1iXwi4-l0suFNVhsA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: tn-lda6tzF0RIsVcDPoOq_gKrYqsH4aF
X-Proofpoint-ORIG-GUID: tn-lda6tzF0RIsVcDPoOq_gKrYqsH4aF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX5Ctws/713zk7
 qiJJxRC31+VRo4urlrBWD3WcSoThenFvENSW5UIrA0PvLJRx+03hywq407anJiBq+9fQY2MyOuI
 eLiewLNI6I+KxNgOtuurCqZVP7YM6rynHCkkUQYesdTHJ3UG5BFTRrLQ/5dn1R+0X/nN3B8Oq5u
 dkYmXp4KsqPySUi/WkYUl71DmBs7sHC4iX7FJfI8MCY/8k+ZS53JRiXpKRU7xqKgm9DptFd4LOX
 Ap9EPGYDWg+sFURmlXLkWqqRlkgAmVBL5vxY1AFB8LA8HhY0XgQ1YfErVrAVXQ9jkup7sNulg0y
 /bgXmgoOQ6kjGDmwNBWKpYvO7gBstqA44xsjTRBCTK5tsLSh242srA41BkihV8OdaBytVRZ0dYZ
 IkCI/d0WQLSjRgO7Jkiv+PZjKMX3C7ccceI3VBgv2cfsNAWIPOyC2cWkOlDh/4tH8lnzPnhNeC9
 x618ZdER9m6sKm6D1cQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX2pr1rl0HCWaK
 yF8hd65PhWnriL0mWTNJaAgbXWjgd8lME9PEVT0vlEaO9hgXNsEOuS0xxxLTj4H95XLcTx4EFJV
 EIsgacZMhTNzepsr2/TxqMZrHzsZs0Ydj5oSC4p1NW+bGdzcNJHz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dongli Zhang <dongli.zhang@oracle.com>

The MMIO read-only and write-1-to-clear masks used by amdvi_init() are
currently hardcoded. The hardcoded values look ambiguous.

Define named masks for the AMD-Vi MMIO registers to make the code easier
to read and understand.

No functional change is intended.

Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
[ajz: apply Sairaj's naming requests, update all code references]
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 18 ++++++++++--------
 hw/i386/amd_iommu.h | 24 ++++++++++++++++++++----
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f52a922c69..a7f735f691 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -294,7 +294,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 
     /* event logging not enabled */
     if (!s->evtlog_enabled || amdvi_test_mask(s, AMDVI_MMIO_STATUS,
-        AMDVI_MMIO_STATUS_EVT_OVF)) {
+        AMDVI_MMIO_STATUS_EVTLOG_OVF)) {
         return;
     }
 
@@ -304,7 +304,8 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
     if (evtlog_tail_next == s->evtlog_head) {
         /* generate overflow interrupt */
         if (s->evtlog_intr) {
-            amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
+            amdvi_assign_orq(s, AMDVI_MMIO_STATUS,
+                             AMDVI_MMIO_STATUS_EVTLOG_OVF);
             amdvi_generate_msi_interrupt(s);
         }
         return;
@@ -325,7 +326,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
     amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
 
     if (s->evtlog_intr) {
-        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
+        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVTLOG_INT);
         amdvi_generate_msi_interrupt(s);
     }
 }
@@ -1694,9 +1695,9 @@ static void amdvi_handle_control_write(AMDVIState *s)
         amdvi_assign_andq(s, AMDVI_MMIO_STATUS, ~AMDVI_MMIO_STATUS_CMDBUF_RUN);
     }
     if (s->evtlog_enabled) {
-        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_RUN);
+        amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVTLOG_RUN);
     } else {
-        amdvi_assign_andq(s, AMDVI_MMIO_STATUS, ~AMDVI_MMIO_STATUS_EVT_RUN);
+        amdvi_assign_andq(s, AMDVI_MMIO_STATUS, ~AMDVI_MMIO_STATUS_EVTLOG_RUN);
     }
 
     trace_amdvi_control_status(control);
@@ -1751,7 +1752,7 @@ static inline void amdvi_handle_evtbase_write(AMDVIState *s)
 {
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_EVENT_BASE);
 
-    if (amdvi_readq(s, AMDVI_MMIO_STATUS) & AMDVI_MMIO_STATUS_EVENT_INT)
+    if (amdvi_readq(s, AMDVI_MMIO_STATUS) & AMDVI_MMIO_STATUS_EVTLOG_INT)
         /* Do not reset if eventlog interrupt bit is set*/
         return;
 
@@ -2572,8 +2573,9 @@ static void amdvi_init(AMDVIState *s)
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
index 948d8611b1..00842fd487 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -107,11 +107,25 @@
 #define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
-#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
-#define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
+#define AMDVI_MMIO_STATUS_EVTLOG_OVF  (1 << 0)
+#define AMDVI_MMIO_STATUS_EVTLOG_INT  (1 << 1)
 #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
-#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
-#define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
+#define AMDVI_MMIO_STATUS_EVTLOG_RUN  (1 << 3)
+#define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
+#define AMDVI_MMIO_STATUS_PPRLOG_OVF  (1 << 5)
+#define AMDVI_MMIO_STATUS_PPRLOG_INT  (1 << 6)
+#define AMDVI_MMIO_STATUS_PPRLOG_RUN  (1 << 7)
+#define AMDVI_MMIO_STATUS_GALOG_RUN   (1 << 8)
+#define AMDVI_MMIO_STATUS_GALOG_OVF   (1 << 9)
+#define AMDVI_MMIO_STATUS_GALOG_INT   (1 << 10)
+
+#define AMDVI_MMIO_STATUS_RO_MASK \
+    (AMDVI_MMIO_STATUS_EVTLOG_RUN | AMDVI_MMIO_STATUS_CMDBUF_RUN | \
+     AMDVI_MMIO_STATUS_PPRLOG_RUN)
+#define AMDVI_MMIO_STATUS_W1C_MASK \
+    (AMDVI_MMIO_STATUS_EVTLOG_OVF | AMDVI_MMIO_STATUS_EVTLOG_INT | \
+     AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPRLOG_OVF | \
+     AMDVI_MMIO_STATUS_PPRLOG_INT)
 
 #define AMDVI_CMDBUF_ID_BYTE              0x07
 #define AMDVI_CMDBUF_ID_RSHIFT            4
@@ -230,6 +244,8 @@
         (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | \
          AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
+#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
+
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
         AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \
-- 
2.47.3


