Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5A6D13C15
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkN45-0002Pu-Tz; Mon, 26 Jan 2026 08:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3s-0002IL-Fq; Mon, 26 Jan 2026 08:55:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3q-0004uQ-Bs; Mon, 26 Jan 2026 08:55:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PJNUXX025155;
 Mon, 26 Jan 2026 13:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Bb3R9S5Eyh4QGX9eA
 SkCXJT7BToT8CAoPaDCMpQpnP8=; b=pAXb+KcCiV6WTG0Xcl28XznIp2uxs/f0g
 /b2o2Ho7OulhuCCBvQHnl337fXJPhI5fHadBFTwWkZ6Z0Oola6XiC/gdCptmQJSE
 kZ0612dj4ycKXbRnd+2WLbqSe5y/DwWTKXm7f/PKjao4q5ZLZaC0UIP9bPR2JwbE
 7x5/3qW0adNZfQscTehyP04Bt63ZXWjgux0ICU2u7gQaPenIqOdTp9IPTy9C413v
 J7MXu5ZwNiHlf3CbXh8rXO7Kcz6pMIrj9+CALQCdAFN2wAhvuStKw9SvHcfLOvJ/
 T6KKB3zKZSDsp2SVPphurHYVwN7n8RS63DzgzCd9LFNjxrvNh3oBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmf9ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QDoxC1025253;
 Mon, 26 Jan 2026 13:55:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmf9b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAZn9x006741;
 Mon, 26 Jan 2026 13:55:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy4v3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QDtI2Y28574374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 13:55:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03CA75805E;
 Mon, 26 Jan 2026 13:55:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9064358043;
 Mon, 26 Jan 2026 13:55:17 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jan 2026 13:55:17 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 2/3] ppc/pnv: Add unimplemented quad and core regs
Date: Mon, 26 Jan 2026 07:55:06 -0600
Message-ID: <20260126135507.771552-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126135507.771552-1-calebs@linux.ibm.com>
References: <20260126135507.771552-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=69777248 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=eGgGPLgfgt7bj44kCrMA:9
X-Proofpoint-GUID: 6YrtJisGa0wSO5yUsO7YcZpbZAX0Wm33
X-Proofpoint-ORIG-GUID: 5balorqg7AGHA-qbIB_RuEmtODvpaHUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNyBTYWx0ZWRfX8BXAn2NmqLpd
 3FAeOW2SJNx9dhIflRH63FueQUYrSPlcoJUA8zdS4XK9g0nrcpZySlmbQTcts2II/wzilwiHRnf
 lZc85WI894utt2D75GwB7cXyQYm+LhfiLyV1xMh8Un133G0OZASNlps3yr4WlVkjF8jpUDoH5xT
 J5Nfzy5jRUhsUqBq3D8SBgCLeRAMujevyomEi3HVmJRBwb9vbg7N+ydbPx6+b4BdrzwN8OzDX+D
 rfV2MzfIa2x2djcdikFTOO1RqWm59IXBDoOJA897/k5eo7Ohl5+aCWg9Wki8ZlWXjgX4Iq8krc6
 6ZR0gHBCue2caOBqAraJz9AuLWyhPo1R7i7HIALPopDYXpDEuCCh+l7K8RzYd+7Kn6OqKY5neNv
 dtRVWi4WUM8SiMnm3bob7nGNwpsptLLayMS9qCi06Ru7ZVu6+c3qrXpBP5Snu1D4moc6rrhMfKQ
 rIJO/zLuDVltzmriZig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This commit adds the read/write functionality for few core and
quad registers.

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8939515c2c..56675f5506 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -185,10 +185,18 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  * POWER10 core controls
  */
 
+#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
 #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
+#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
+#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
 #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
 #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
+#define PNV10_XSCOM_EC_SPATTN_OR            0x497
+#define PNV10_XSCOM_EC_SPATTN_AND           0x498
+#define PNV10_XSCOM_EC_SPATTN               0x499
+#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
@@ -224,6 +232,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
             }
         }
         break;
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+        return 0;
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
+                              "xscom read at 0x%08x\n", __func__, offset);
+        break;
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -284,6 +305,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
         }
         break;
 
+    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
+    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
+    case PNV10_XSCOM_EC_SPATTN_OR:
+    case PNV10_XSCOM_EC_SPATTN_AND:
+    case PNV10_XSCOM_EC_SPATTN:
+    case PNV10_XSCOM_EC_SPATTN_MASK:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -579,6 +609,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
  * POWER10 Quads
  */
 
+#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
+#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
+#define P10_XSCOM_EQ3_HTM_MODE          0x11680
+#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
+#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
+#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
+#define P10_XSCOM_EQ2_HTM_MODE          0x12680
+#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
+#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
+#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
+#define P10_XSCOM_EQ1_HTM_MODE          0x14680
+#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
+#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
+#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
+#define P10_XSCOM_EQ0_HTM_MODE          0x18680
+#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
+
 static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
@@ -586,6 +633,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
     uint64_t val = -1;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        return 0;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -600,6 +664,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
     uint32_t offset = addr >> 3;
 
     switch (offset) {
+    case P10_XSCOM_EQ0_MODE_REG1:
+    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ0_HTM_MODE:
+    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ1_MODE_REG1:
+    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ1_HTM_MODE:
+    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ2_MODE_REG1:
+    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ2_HTM_MODE:
+    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
+    case P10_XSCOM_EQ3_MODE_REG1:
+    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
+    case P10_XSCOM_EQ3_HTM_MODE:
+    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
-- 
2.47.3


