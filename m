Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD51EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxh4-0001Uj-Lw; Fri, 13 Sep 2024 00:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh2-0001LT-70; Fri, 13 Sep 2024 00:14:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxgz-0002WB-PH; Fri, 13 Sep 2024 00:13:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CLJaS9018969;
 Fri, 13 Sep 2024 04:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=kgKQeK6HCbNb+
 cYwN+K/Y/Q+cfxj9f6DvaaQSo+XRto=; b=ny2hmSlJz2UjVAm0MUjxEgMb4rbhb
 IHyK+5qdCS/1sVUzlUC/1UIqemrHXvSlW0YYigp5bSEgLe/o6ngCSK20wEjHE4wD
 m+JnYBu2/2jngYHNLcxoVLfguC3OnT9Xpq1vsSkh6U5MUyzTOMMf/ZWAMgJvTxRt
 DryUNsUyS99d48Wo6yNiivPO6ShlCAwcxKQAyyfVHq+bNId5ewD9RYZ+RqXdBmt3
 rU+cv7CWbEQBSQ8ZkGPuX0QyGGexEkt62vrn6XG6VVFS+zPY6O2cufAGgeB7iHnz
 3K9HdnZ2VDx3lwhQv/EtMLMtyqLEKFXeDzUwrYBwHgZmOXgfHZapeid0g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4Ds8w008413;
 Fri, 13 Sep 2024 04:13:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kyb1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2mK8v013465;
 Fri, 13 Sep 2024 04:13:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmkmb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4Dpwr45941102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D364C2004E;
 Fri, 13 Sep 2024 04:13:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2D9E20040;
 Fri, 13 Sep 2024 04:13:50 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:50 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 05/10] target/ppc: optimize p9 exception handling routines
 for lpcr
Date: Fri, 13 Sep 2024 09:43:32 +0530
Message-ID: <20240913041337.912876-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913041337.912876-1-harshpb@linux.ibm.com>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZKEbV7XkqeAUAv0FT34qu_WmZw5Q_4Kb
X-Proofpoint-ORIG-GUID: VpWU5CWcTyongMzEJlFjpH0CUywLT_04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=773 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Like pending_interrupts, env->spr[SPR_LPCR] is being used at multiple
places across p9 exception handlers. Pass the value during entry and
avoid multiple indirect accesses.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 31c1653e2b..c7641898ca 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1873,13 +1873,14 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
 
 static int p9_interrupt_powersave(CPUPPCState *env,
-                                  uint32_t pending_interrupts)
+                                  uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
 
     /* External Exception */
     if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_EEE)) {
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+        (lpcr & LPCR_EEE)) {
+        bool heic = !!(lpcr & LPCR_HEIC);
         if (!heic || !FIELD_EX64_HV(env->msr) ||
             FIELD_EX64(env->msr, MSR, PR)) {
             return PPC_INTERRUPT_EXT;
@@ -1887,11 +1888,11 @@ static int p9_interrupt_powersave(CPUPPCState *env,
     }
     /* Decrementer Exception */
     if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_DEE)) {
+        (lpcr & LPCR_DEE)) {
         return PPC_INTERRUPT_DECR;
     }
     /* Machine Check or Hypervisor Maintenance Exception */
-    if (env->spr[SPR_LPCR] & LPCR_OEE) {
+    if (lpcr & LPCR_OEE) {
         if (pending_interrupts & PPC_INTERRUPT_MCK) {
             return PPC_INTERRUPT_MCK;
         }
@@ -1901,17 +1902,17 @@ static int p9_interrupt_powersave(CPUPPCState *env,
     }
     /* Privileged Doorbell Exception */
     if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_PDEE)) {
+        (lpcr & LPCR_PDEE)) {
         return PPC_INTERRUPT_DOORBELL;
     }
     /* Hypervisor Doorbell Exception */
     if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
-        (env->spr[SPR_LPCR] & LPCR_HDEE)) {
+        (lpcr & LPCR_HDEE)) {
         return PPC_INTERRUPT_HDOORBELL;
     }
     /* Hypervisor virtualization exception */
     if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
-        (env->spr[SPR_LPCR] & LPCR_HVEE)) {
+        (lpcr & LPCR_HVEE)) {
         return PPC_INTERRUPT_HVIRT;
     }
     if (pending_interrupts & PPC_INTERRUPT_RESET) {
@@ -1921,7 +1922,8 @@ static int p9_interrupt_powersave(CPUPPCState *env,
 }
 
 static int p9_next_unmasked_interrupt(CPUPPCState *env,
-                                      uint32_t pending_interrupts)
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
@@ -1936,7 +1938,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
              * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
              * wakeup the processor
              */
-            return p9_interrupt_powersave(env, pending_interrupts);
+            return p9_interrupt_powersave(env, pending_interrupts, lpcr);
         } else {
             /*
              * When it's clear, any system-caused exception exits power-saving
@@ -1954,7 +1956,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
     /* Hypervisor decrementer exception */
     if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -1964,7 +1966,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
     /* Hypervisor virtualization interrupt */
     if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
             return PPC_INTERRUPT_HVIRT;
         }
@@ -1972,8 +1974,8 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 
     /* External interrupt can ignore MSR:EE under some circumstances */
     if (pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -2023,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
+        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
+			                  env->spr[SPR_LPCR]);
     default:
         break;
     }
-- 
2.45.2


