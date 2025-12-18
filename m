Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C69FD711A5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWKEO-0005P2-TU; Thu, 18 Dec 2025 15:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEL-0005Nk-CM; Thu, 18 Dec 2025 15:04:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEJ-00084Y-Ig; Thu, 18 Dec 2025 15:04:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJmDLU013642;
 Thu, 18 Dec 2025 20:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ESB1n2O+xezp6BQfw
 vXDc3+88LCIxrbhKdRqD7Cg14s=; b=cBsw5BOoOOIEsJSZqNkJxd6AhwkV7zuye
 AVZ0AhHtS6Znl0yN5WZKlrKDfzhEeLseHND6FKvCSrvP968tewbH6U3oXuRx08wm
 VtxMrwfS4UppW7NuyttrCaloJA/Jyv5dV8MxP95mztm3XBeBdqUnrpQ8xYahpbGZ
 av+fExVS9jUCVX/VQQhc017x++Q1iho4zznMIrVCn84Ma7o0y4JcQeeFDxeTyBXK
 ZXKWrrqHqPTQ5rbVybXSV/gwHTQnEx74Z+xyhWHAUjNj3gNFVMI/8ZB5vRM0A91i
 FuO9ivZtxViwgc2y9qvbAEInpS8nNJBlVkpCBK44zngGsu0uCP7AA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIK3Gu9012626;
 Thu, 18 Dec 2025 20:04:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d02t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJY8IT031521;
 Thu, 18 Dec 2025 20:04:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvu84ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:04 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIK424658458574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 20:04:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B696E58055;
 Thu, 18 Dec 2025 20:04:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57A4E58043;
 Thu, 18 Dec 2025 20:04:02 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 20:04:02 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH 3/4] ppc/pnv: Add unimplemented quad and core regs
Date: Thu, 18 Dec 2025 14:03:52 -0600
Message-ID: <20251218200353.301866-4-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218200353.301866-1-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WYkBqkhX c=1 sm=1 tr=0 ts=69445e35 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=eGgGPLgfgt7bj44kCrMA:9
X-Proofpoint-GUID: 7P-v4ENDoYtEEJF_0Vr8EZtrPXloX0Se
X-Proofpoint-ORIG-GUID: 5P90RbLfR4VIRYCO8e5McVWl2Lq4avHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NCBTYWx0ZWRfX0LCqe4/1eF7c
 IhPrQdBHI//cszTSDjY/CThCVll/uf8b7r0TS15FymT17z2+gfNh3nZbcODvgYui2XiC5XJNj5u
 2IhbQPnAs9ABWL0NwGhXuZl0k0UvQ7mrvguHopDrK8tCSJrU4ag2fkMUy2piMa/KaGaGogs56ML
 WvU6rs0RCUiQxIXYotmEE+IaBd19gy32e54tnjzRVH7DOr1tES2xoBNu7rChzTpnsRH9wSHwl7L
 QDD6SdrG+Wdu9G4jziJf6o7sQe3D96tRvUgR6IruD+EegCWXlT712uxcrw2n/rKVKSTsl3ivOU8
 4TD710pTzPzRgku0MivNjj1AKWCUW1X2lumUm2P2kI4a90mDgBCRQ3rGCtY7oWhcRYNNbcgZ+yB
 ZsP5Z3CW0MB+XHC4KowK/tBt2gklpm2MMWjjU6eWy2t1CtdZ2ZOquff1KFMXwGmq7Nd7BTnM18N
 1+Se2THeZP0uMuzPDvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512180164
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit adds the read/write functionality for few core and
quad registers.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index fb2dfc7ba2..84a2fa6364 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -184,10 +184,18 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
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
@@ -223,6 +231,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
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
@@ -283,6 +304,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
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
@@ -568,6 +598,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
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
@@ -575,6 +622,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
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
@@ -589,6 +653,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
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


