Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84398CF07A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym1x-0006VD-0a; Thu, 10 Oct 2024 01:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1u-0006MX-0q; Thu, 10 Oct 2024 01:48:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1r-0005bI-Pi; Thu, 10 Oct 2024 01:48:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A5I05J031423;
 Thu, 10 Oct 2024 05:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=4c96Bacex16+u
 QHsCYzuhzrmmGBgqKDthpLMwn+PvuU=; b=AhqtzxIoEHr4ftmwXk1KevO6S+Hqz
 KlmK3+jjj0LTpRUWVPuUj6YTMUcuL552aXOtSe6Vy6sQsL+KRRD8fCQly/XNjTQj
 Psic/ualccTKH4zysHvjWQ3RHPNJjpThoDWvE+IJ9RNQgTNSFyWhA12VVfArhTrK
 8L1Wexqpjr0aImJKTXODIu+XTLjasrOiIVLUD6dhYTKzjnU1e0Vmblen596/R6DF
 4SF4SP5hxxVfDnLzyWfumGPlsZV38hLK9SbcfJR8rwF2iVjhllUBdLkqi1NZ0Dyb
 NSaBxTPmhGTuERkjRFX7z12chFIW8wv2jKPNwr1Ap1N/jFvgquW691Orw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4268ner3fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A5lsVK027894;
 Thu, 10 Oct 2024 05:47:54 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4268ner3fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A5QIDY013790;
 Thu, 10 Oct 2024 05:47:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fsse3q6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5lpv135652222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF2D20043;
 Thu, 10 Oct 2024 05:47:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B5EC20040;
 Thu, 10 Oct 2024 05:47:50 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 4/9] target/ppc: optimize p9 exception handling routines
Date: Thu, 10 Oct 2024 11:17:35 +0530
Message-ID: <20241010054740.1106997-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010054740.1106997-1-harshpb@linux.ibm.com>
References: <20241010054740.1106997-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EnV3lZid-fu4LTQ2Be6q6Mlx8zkBGJsD
X-Proofpoint-GUID: tJuTiRHJ3XG_eWkskqL2G1UGfhs0YnY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=592 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, p9 exception handling has multiple if-condition checks where
it does an indirect access to pending_interrupts and LPCR via env.
Pass the values during entry to avoid multiple indirect accesses.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 72 ++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2029144622..c7641898ca 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1872,60 +1872,65 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
      PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |  \
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
 
-static int p9_interrupt_powersave(CPUPPCState *env)
+static int p9_interrupt_powersave(CPUPPCState *env,
+                                  uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
+
     /* External Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_EEE)) {
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
+        (lpcr & LPCR_EEE)) {
+        bool heic = !!(lpcr & LPCR_HEIC);
         if (!heic || !FIELD_EX64_HV(env->msr) ||
             FIELD_EX64(env->msr, MSR, PR)) {
             return PPC_INTERRUPT_EXT;
         }
     }
     /* Decrementer Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_DEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
+        (lpcr & LPCR_DEE)) {
         return PPC_INTERRUPT_DECR;
     }
     /* Machine Check or Hypervisor Maintenance Exception */
-    if (env->spr[SPR_LPCR] & LPCR_OEE) {
-        if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (lpcr & LPCR_OEE) {
+        if (pending_interrupts & PPC_INTERRUPT_MCK) {
             return PPC_INTERRUPT_MCK;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_HMI) {
+        if (pending_interrupts & PPC_INTERRUPT_HMI) {
             return PPC_INTERRUPT_HMI;
         }
     }
     /* Privileged Doorbell Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_PDEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
+        (lpcr & LPCR_PDEE)) {
         return PPC_INTERRUPT_DOORBELL;
     }
     /* Hypervisor Doorbell Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_HDEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
+        (lpcr & LPCR_HDEE)) {
         return PPC_INTERRUPT_HDOORBELL;
     }
     /* Hypervisor virtualization exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HVIRT) &&
-        (env->spr[SPR_LPCR] & LPCR_HVEE)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
+        (lpcr & LPCR_HVEE)) {
         return PPC_INTERRUPT_HVIRT;
     }
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     return 0;
 }
 
-static int p9_next_unmasked_interrupt(CPUPPCState *env)
+static int p9_next_unmasked_interrupt(CPUPPCState *env,
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         if (env->spr[SPR_PSSCR] & PSSCR_EC) {
@@ -1933,7 +1938,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
              * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
              * wakeup the processor
              */
-            return p9_interrupt_powersave(env);
+            return p9_interrupt_powersave(env, pending_interrupts, lpcr);
         } else {
             /*
              * When it's clear, any system-caused exception exits power-saving
@@ -1944,14 +1949,14 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Machine check exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (pending_interrupts & PPC_INTERRUPT_MCK) {
         return PPC_INTERRUPT_MCK;
     }
 
     /* Hypervisor decrementer exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
+    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -1959,18 +1964,18 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Hypervisor virtualization interrupt */
-    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
+    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
             return PPC_INTERRUPT_HVIRT;
         }
     }
 
     /* External interrupt can ignore MSR:EE under some circumstances */
-    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+    if (pending_interrupts & PPC_INTERRUPT_EXT) {
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -1980,20 +1985,20 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (msr_ee != 0) {
         /* Decrementer exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+        if (pending_interrupts & PPC_INTERRUPT_DECR) {
             return PPC_INTERRUPT_DECR;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
             return PPC_INTERRUPT_DOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
             return PPC_INTERRUPT_HDOORBELL;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
+        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
             return PPC_INTERRUPT_PERFM;
         }
         /* EBB exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
+        if (pending_interrupts & PPC_INTERRUPT_EBB) {
             /*
              * EBB exception must be taken in problem state and
              * with BESCR_GE set.
@@ -2020,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-        return p9_next_unmasked_interrupt(env);
+        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
+			                  env->spr[SPR_LPCR]);
     default:
         break;
     }
-- 
2.45.2


