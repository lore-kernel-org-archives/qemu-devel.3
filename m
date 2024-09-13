Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4E8EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxhA-0001zd-E2; Fri, 13 Sep 2024 00:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh7-0001hY-EI; Fri, 13 Sep 2024 00:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh5-0002Xu-MK; Fri, 13 Sep 2024 00:14:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CKUqQa007077;
 Fri, 13 Sep 2024 04:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=6bytuoo79gXzZ
 wp7Dtf9eUzeNhBDoFKoL0UAs57QOoU=; b=OyA5lAMz+VHuXkp+yAIgVZt0btFV8
 LGr1Hh2FMPNDWvECdkZQinOOhdlZSya8MNaXQizGAPo/Ag/3KGy0H2GjPJ5w7lLo
 T7epHxDqz5KSko85gxSrkmnGe0NhP0H/wNwirjvABdpfJ2Z9ABnEEI7owMOgtBr3
 bLJQZ6y/jX5xNtad5n8KYQhS+URzHZBsPHBZzTZfw4+n2zrLtYvVD1qYXTNY2VOk
 F5trs49N6cXBbc4AbKD/yOYMo2Ao9p3vqG+EoPicv06VeCq6L6KWdhe7jeWZlhhH
 09s2Z/r3M5gxiRnNFNRT7Ob0tbmzJ4GWBKy/ElhpbwttmwFTjYkCEu9ng==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx7j2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4DxUT026803;
 Fri, 13 Sep 2024 04:13:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx7j2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2t6iM013458;
 Fri, 13 Sep 2024 04:13:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmkmb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4Du0f31130364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F6BE2004B;
 Fri, 13 Sep 2024 04:13:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD94720040;
 Fri, 13 Sep 2024 04:13:55 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 09/10] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
Date: Fri, 13 Sep 2024 09:43:36 +0530
Message-ID: <20240913041337.912876-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913041337.912876-1-harshpb@linux.ibm.com>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IqEn_5cdUeIAnZATQpXQi8PbgZZJjhiw
X-Proofpoint-ORIG-GUID: 7l_WkvoJ4ptn6TqpcMngvkZrzeT-MwVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

As previously done for arch specific handlers, simplify var usage in
ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
env->spr[SPR_LPCR] in local vars and using it later at multiple places.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index d0e0f609a0..4eeeedff5b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2022,31 +2022,31 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
+    uint32_t pending_interrupts = env->pending_interrupts;
+    target_ulong lpcr = env->spr[SPR_LPCR];
+    bool async_deliver;
+
 #ifdef TARGET_PPC64
     switch (env->excp_model) {
     case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
-                                          env->spr[SPR_LPCR]);
+        return p7_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     case POWERPC_EXCP_POWER8:
-        return p8_next_unmasked_interrupt(env, env->pending_interrupts,
-                                          env->spr[SPR_LPCR]);
+        return p8_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
     case POWERPC_EXCP_POWER11:
-        return p9_next_unmasked_interrupt(env, env->pending_interrupts,
-			                  env->spr[SPR_LPCR]);
+        return p9_next_unmasked_interrupt(env, pending_interrupts, lpcr);
     default:
         break;
     }
 #endif
-    bool async_deliver;
 
     /* External reset */
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     /* Machine check exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+    if (pending_interrupts & PPC_INTERRUPT_MCK) {
         return PPC_INTERRUPT_MCK;
     }
 #if 0 /* TODO */
@@ -2065,9 +2065,9 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     async_deliver = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
     /* Hypervisor decrementer exception */
-    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
+    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
         /* LPCR will be clear when not supported so this will work */
-        bool hdice = !!(env->spr[SPR_LPCR] & LPCR_HDICE);
+        bool hdice = !!(lpcr & LPCR_HDICE);
         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
             /* HDEC clears on delivery */
             return PPC_INTERRUPT_HDECR;
@@ -2075,18 +2075,18 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
 
     /* Hypervisor virtualization interrupt */
-    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
+    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
         /* LPCR will be clear when not supported so this will work */
-        bool hvice = !!(env->spr[SPR_LPCR] & LPCR_HVICE);
+        bool hvice = !!(lpcr & LPCR_HVICE);
         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
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
         if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
             !FIELD_EX64(env->msr, MSR, PR))) ||
@@ -2096,45 +2096,45 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (FIELD_EX64(env->msr, MSR, CE)) {
         /* External critical interrupt */
-        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
+        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
             return PPC_INTERRUPT_CEXT;
         }
     }
     if (async_deliver != 0) {
         /* Watchdog timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
+        if (pending_interrupts & PPC_INTERRUPT_WDT) {
             return PPC_INTERRUPT_WDT;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
+        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
             return PPC_INTERRUPT_CDOORBELL;
         }
         /* Fixed interval timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
+        if (pending_interrupts & PPC_INTERRUPT_FIT) {
             return PPC_INTERRUPT_FIT;
         }
         /* Programmable interval timer on embedded PowerPC */
-        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
+        if (pending_interrupts & PPC_INTERRUPT_PIT) {
             return PPC_INTERRUPT_PIT;
         }
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
         /* Thermal interrupt */
-        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
+        if (pending_interrupts & PPC_INTERRUPT_THERM) {
             return PPC_INTERRUPT_THERM;
         }
         /* EBB exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
+        if (pending_interrupts & PPC_INTERRUPT_EBB) {
             /*
              * EBB exception must be taken in problem state and
              * with BESCR_GE set.
-- 
2.45.2


