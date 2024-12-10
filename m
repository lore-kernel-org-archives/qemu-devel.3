Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809EEE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnlL-0004k5-UY; Mon, 09 Dec 2024 19:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlE-0004iL-Oz; Mon, 09 Dec 2024 19:05:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlA-0001oF-Pg; Mon, 09 Dec 2024 19:05:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CvCnS008466;
 Tue, 10 Dec 2024 00:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hJgwqcM8u06wde17S
 ghyD3HBdctBYrnM+onwpjEzwNw=; b=OoLtS/HCk7eT3VgOisrsgdenmPHr6vPW7
 sm456KS1LCrysXKqyUYcCT0x93//cAYOyM78GsOAdLT0fpFCMWBpHijWiO7sqjbr
 QPSLib+Vt+18JS6jGmNCPoGNmW6LnxRPLrfjhSaNyWoP4cFxCVdV+KXrkfFFi6gs
 iv0NkR0ilp3yAIFTANQNctJEH+H+7caqQWeNM847TJFLbc1pJQJLr9nLeMno1fgD
 8uluj+2CLQ+ZmvjVMIgWrOf7b6n0V9Z0TgzVwEgXPqwINoY7KRRHSuHczEJGBm79
 euP2tEDs43C7+2NKmcWmRkISvzhkHNKFYJPra69qqsM+kDjrk3Yhg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA01qAY026260;
 Tue, 10 Dec 2024 00:05:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9La7KO032744;
 Tue, 10 Dec 2024 00:05:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps985u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05cnr53936492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B67320043;
 Tue, 10 Dec 2024 00:05:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3866B20040;
 Tue, 10 Dec 2024 00:05:36 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:36 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 01/14] ppc/xive2: Update NVP save/restore for group
 attributes
Date: Mon,  9 Dec 2024 18:05:04 -0600
Message-Id: <20241210000527.9541-2-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yDXHw96tynMToXPtU9WwKrhKP97sMbTg
X-Proofpoint-ORIG-GUID: OOVvqR0qIKkjBfiZZRJCkclo1qWs8m4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=634
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

If the 'H' attribute is set on the NVP structure, the hardware
automatically saves and restores some attributes from the TIMA in the
NVP structure.
The group-specific attributes LSMFB, LGS and T have an extra flag to
individually control what is saved/restored.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2_regs.h | 10 +++++++---
 hw/intc/xive2.c             | 23 ++++++++++++++++++-----
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 1d00c8df64..e88d6eab1e 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 internal structure definitions (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE2_REGS_H
@@ -152,6 +151,9 @@ typedef struct Xive2Nvp {
         uint32_t       w0;
 #define NVP2_W0_VALID              PPC_BIT32(0)
 #define NVP2_W0_HW                 PPC_BIT32(7)
+#define NVP2_W0_L                  PPC_BIT32(8)
+#define NVP2_W0_G                  PPC_BIT32(9)
+#define NVP2_W0_T                  PPC_BIT32(10)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
 #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
@@ -163,6 +165,8 @@ typedef struct Xive2Nvp {
 #define NVP2_W2_CPPR               PPC_BITMASK32(0, 7)
 #define NVP2_W2_IPB                PPC_BITMASK32(8, 15)
 #define NVP2_W2_LSMFB              PPC_BITMASK32(16, 23)
+#define NVP2_W2_T                  PPC_BIT32(27)
+#define NVP2_W2_LGS                PPC_BITMASK32(28, 31)
         uint32_t       w3;
         uint32_t       w4;
 #define NVP2_W4_ESC_ESB_BLOCK      PPC_BITMASK32(0, 3)  /* N:0 */
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index d1df35e9b3..24e504fce1 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation..
+ * Copyright (c) 2019-2024, IBM Corporation..
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -313,7 +312,19 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 
     nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
     nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
-    nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    if (nvp.w0 & NVP2_W0_L) {
+        /*
+         * Typically not used. If LSMFB is restored with 0, it will
+         * force a backlog rescan
+         */
+        nvp.w2 = xive_set_field32(NVP2_W2_LSMFB, nvp.w2, regs[TM_LSMFB]);
+    }
+    if (nvp.w0 & NVP2_W0_G) {
+        nvp.w2 = xive_set_field32(NVP2_W2_LGS, nvp.w2, regs[TM_LGS]);
+    }
+    if (nvp.w0 & NVP2_W0_T) {
+        nvp.w2 = xive_set_field32(NVP2_W2_T, nvp.w2, regs[TM_T]);
+    }
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
 
     nvp.w1 = xive_set_field32(NVP2_W1_CO, nvp.w1, 0);
@@ -527,7 +538,9 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
 
     tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
-    /* we don't model LSMFB */
+    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
+    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
 
     nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
     nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
-- 
2.43.0


