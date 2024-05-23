Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2934C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 05:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA0n0-0002S4-Tl; Thu, 23 May 2024 01:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mt-0002Nm-OR; Thu, 23 May 2024 01:14:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mj-0000nx-OD; Thu, 23 May 2024 01:14:43 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N4gHPv010934; Thu, 23 May 2024 05:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U0LnLOcSldDbyoe5ngu0wcbm/Rgr48mR4HEmFqNhcl8=;
 b=efzITzBZkQqkhwN2bqG53Ovs+NLsEHmEGc7PxQYgn6sNqq1U27OCmJzcQIT5mxeT5VV7
 g1REF4wWKhxwQ7Zd1PnZOtlQP5Ykwt4EmnHD2lj9rVHPM8E1mrY6PVL/FPdNk/kiKuJx
 rtBKea+c9DPpwZOXxd7dr+VOhzALF9fjMxVd6O5XeX4RuVSOp8tK+4v5VtCZfM2lQQ+0
 Q3rhYGukhQHGB/1yYV0iKJ3nKuB52Wv3t3D0Xq7/Jf7iGE8MzIFoO2fn2W1EKLn90LcI
 zuAxObogwIkOWuFH4C+3l4zVov0wBIE7xQP+FhLBb/KhDAk0tqfNEOFXWmLHdsWZJtTd hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9wkm88g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:33 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N5EXc2026334;
 Thu, 23 May 2024 05:14:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9wkm88g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N4JpeJ026447; Thu, 23 May 2024 05:14:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785mqytt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N5ES8M13107692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 05:14:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C4972004E;
 Thu, 23 May 2024 05:14:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52FA320043;
 Thu, 23 May 2024 05:14:27 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 05:14:27 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v2 4/7] target/ppc: optimize p9 exception handling routines
Date: Thu, 23 May 2024 10:44:09 +0530
Message-Id: <20240523051412.226970-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523051412.226970-1-harshpb@linux.ibm.com>
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mAKgcCDg7aiJTj5kcX46mSYUHrJ3j6So
X-Proofpoint-GUID: NENsPc2txvr78Q6Lz9lb-Uj3yMX9M9_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_02,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=544
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Currently, p9 exception handling has multiple if-condition checks where
it does an indirect access to pending_interrupts via env. Pass the
value during entry to avoid multiple indirect accesses.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 47 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0712098cf7..704eddac63 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1842,10 +1842,12 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
      PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |  \
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_THERM)
 
-static int p9_interrupt_powersave(CPUPPCState *env)
+static int p9_interrupt_powersave(CPUPPCState *env,
+                                  uint32_t pending_interrupts)
 {
+
     /* External Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
         (env->spr[SPR_LPCR] & LPCR_EEE)) {
         bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
         if (!heic || !FIELD_EX64_HV(env->msr) ||
@@ -1854,48 +1856,49 @@ static int p9_interrupt_powersave(CPUPPCState *env)
         }
     }
     /* Decrementer Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
         (env->spr[SPR_LPCR] & LPCR_DEE)) {
         return PPC_INTERRUPT_DECR;
     }
     /* Machine Check or Hypervisor Maintenance Exception */
     if (env->spr[SPR_LPCR] & LPCR_OEE) {
-        if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
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
+    if ((pending_interrupts & PPC_INTERRUPT_DOORBELL) &&
         (env->spr[SPR_LPCR] & LPCR_PDEE)) {
         return PPC_INTERRUPT_DOORBELL;
     }
     /* Hypervisor Doorbell Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
+    if ((pending_interrupts & PPC_INTERRUPT_HDOORBELL) &&
         (env->spr[SPR_LPCR] & LPCR_HDEE)) {
         return PPC_INTERRUPT_HDOORBELL;
     }
     /* Hypervisor virtualization exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_HVIRT) &&
+    if ((pending_interrupts & PPC_INTERRUPT_HVIRT) &&
         (env->spr[SPR_LPCR] & LPCR_HVEE)) {
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
+                                      uint32_t pending_interrupts)
 {
     CPUState *cs = env_cpu(env);
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         if (env->spr[SPR_PSSCR] & PSSCR_EC) {
@@ -1903,7 +1906,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
              * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
              * wakeup the processor
              */
-            return p9_interrupt_powersave(env);
+            return p9_interrupt_powersave(env, pending_interrupts);
         } else {
             /*
              * When it's clear, any system-caused exception exits power-saving
@@ -1914,12 +1917,12 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
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
         bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
@@ -1929,7 +1932,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Hypervisor virtualization interrupt */
-    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
+    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
         bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
@@ -1938,7 +1941,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* External interrupt can ignore MSR:EE under some circumstances */
-    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
+    if (pending_interrupts & PPC_INTERRUPT_EXT) {
         bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
         bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
@@ -1950,20 +1953,20 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
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
@@ -1989,7 +1992,7 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
         return p8_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
-        return p9_next_unmasked_interrupt(env);
+        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
     default:
         break;
     }
-- 
2.39.3


