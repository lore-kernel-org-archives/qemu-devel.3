Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE923C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 05:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA0n4-0002VL-Vq; Thu, 23 May 2024 01:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mx-0002Pc-Nz; Thu, 23 May 2024 01:14:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mt-0000qB-A3; Thu, 23 May 2024 01:14:50 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N3HKx5001091; Thu, 23 May 2024 05:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tQXpvB/s4QtmZroqzmXZWEFJAg4CyxgeNjGw46b7bH0=;
 b=KMRrFoUgzwHwc9vmubtiGgX89C1z4NWbRZdIM/+MM2bM0CfMuRXcIme+7V35b53ae0i5
 QWuXfMQ+lT1UFKTbjy8vXuIy3/0vl0wy/y7hafVDLQYsRwv3Jr92TFk+x124lssNNEzn
 HNdapw4RCqJz4HCsU9gysPgVGS+p3yyTCy9ZLVB5AyT33lnYE8oQhDB097VG8Os7Jb8g
 wUoMIImHk8U44m+ptkx38Y/CuvqjDKCBbAVhsC4LWF7OgBI1a3n4RZzKh/4eVHoj5Ayn
 reg9b2Sjjk8M8++MplIifJtQh3PNnPlFeaizvpFIBLdPGTWCbN+dcGoN4h1vrsLn+DlR vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9wrrr896-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:35 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N5EYou022198;
 Thu, 23 May 2024 05:14:34 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9wrrr894-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N2LrJu008123; Thu, 23 May 2024 05:14:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vm7ptp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N5ETg026411426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 05:14:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFAC820040;
 Thu, 23 May 2024 05:14:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6A3020043;
 Thu, 23 May 2024 05:14:28 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 05:14:28 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v2 5/7] target/ppc: optimize p9 exception handling routines
 for lpcr
Date: Thu, 23 May 2024 10:44:10 +0530
Message-Id: <20240523051412.226970-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523051412.226970-1-harshpb@linux.ibm.com>
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xOq0x2Lu8HIJe8MAXrC8Bo90xzbzoJqz
X-Proofpoint-GUID: 4sVqMyJyP4_q4q8u1AHfmZyhQS4KImTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_02,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=783 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405230033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Like pending_interrupts, env->spr[SPR_LPCR] is being used at multiple
places across p9 exception handlers. Pass the value during entry and
avoid multiple indirect accesses.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 704eddac63..d3db81e6ae 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1843,13 +1843,14 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
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
@@ -1857,11 +1858,11 @@ static int p9_interrupt_powersave(CPUPPCState *env,
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
@@ -1871,17 +1872,17 @@ static int p9_interrupt_powersave(CPUPPCState *env,
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
@@ -1891,7 +1892,8 @@ static int p9_interrupt_powersave(CPUPPCState *env,
 }
 
 static int p9_next_unmasked_interrupt(CPUPPCState *env,
-                                      uint32_t pending_interrupts)
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
@@ -1906,7 +1908,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
              * When PSSCR[EC] is set, LPCR[PECE] controls which interrupts can
              * wakeup the processor
              */
-            return p9_interrupt_powersave(env, pending_interrupts);
+            return p9_interrupt_powersave(env, pending_interrupts, lpcr);
         } else {
             /*
              * When it's clear, any system-caused exception exits power-saving
@@ -1924,7 +1926,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
     /* Hypervisor decrementer exception */
     if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -1934,7 +1936,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
     /* Hypervisor virtualization interrupt */
     if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((msr_ee || !FIELD_EX64_HV(env->msr)) && hvice) {
             return PPC_INTERRUPT_HVIRT;
         }
@@ -1942,8 +1944,8 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 
     /* External interrupt can ignore MSR:EE under some circumstances */
     if (pending_interrupts & PPC_INTERRUPT_EXT) {
-        bool lpes0 = !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
+        bool lpes0 = !!(lpcr & LPCR_LPES0);
+        bool heic = !!(lpcr & LPCR_HEIC);
         /* HEIC blocks delivery to the hypervisor */
         if ((msr_ee && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -1992,7 +1994,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
         return p8_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
-        return p9_next_unmasked_interrupt(env, env->pending_interrupts);
+        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
+                                          env->spr[SPR_LPCR]);
     default:
         break;
     }
-- 
2.39.3


