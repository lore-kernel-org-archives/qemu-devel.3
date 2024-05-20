Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CFDC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90L3-0000k5-CM; Mon, 20 May 2024 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90L2-0000jk-2c; Mon, 20 May 2024 06:33:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90L0-0008Vm-3R; Mon, 20 May 2024 06:33:51 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K9G5im002183; Mon, 20 May 2024 10:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0el9Vuo4hmVFd1M6Rs7vUpttBZy2/hKb73FLJFQ3Wg4=;
 b=JHDDcQ343DaJ3Mc0qnKIR9DfJObGo1fD9TASaZxOAIo5QjXKf6GB3mUIDrNOXFutmmJJ
 GR5yvtXxNWWLTVB1QCZd+upbxI0TTjXa/gf3cyFVNocXDcF2zL5bwJPNIM9PDez4oQ1/
 K4PqtY/Ec1fjCX6p/9GqMV/B/4j5TTwI3Gv926uCynsLHZkpRY0nA3sF+GTXeoGutEik
 gE6I1XxM+FqEEh/e52xim5wOSIbTPn0rtap6LWMKjz0hrE+Nkpn0Ucsa22PxBQBEzigz
 waYVsAsJiFCtnygXIOw9ptTXhmR7TqtIJ259EW73mruTKIpMHbGyBu9lWZhHbceSxKfM mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y83f3g68x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:47 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KAXlST002173;
 Mon, 20 May 2024 10:33:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y83f3g68w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44K9cnY0023485; Mon, 20 May 2024 10:33:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77nny83v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44KAXglp33620650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 10:33:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9AE62004D;
 Mon, 20 May 2024 10:33:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D68C20040;
 Mon, 20 May 2024 10:33:40 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.195.33.101]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 10:33:40 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/ppc: optimize p9 exception handling routines
Date: Mon, 20 May 2024 16:03:27 +0530
Message-Id: <20240520103329.381158-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240520103329.381158-1-harshpb@linux.ibm.com>
References: <20240520103329.381158-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tFPQseUoPgVS2-dqK_tww0clG3yptsVQ
X-Proofpoint-GUID: SPKRe3ESoBiIMIzjQlrRF-AZG5ZjH55q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=657
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200087
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

Currently, p9 exception handling has multiple if-condition checks where
it does an indirect access to pending_interrupts via env. Cache the
value during entry and reuse later to avoid multiple indirect accesses.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0712098cf7..4f158196bb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1844,8 +1844,10 @@ static int p8_next_unmasked_interrupt(CPUPPCState *env)
 
 static int p9_interrupt_powersave(CPUPPCState *env)
 {
+    uint32_t pending_interrupts = env->pending_interrupts;
+
     /* External Exception */
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
         (env->spr[SPR_LPCR] & LPCR_EEE)) {
         bool heic = !!(env->spr[SPR_LPCR] & LPCR_HEIC);
         if (!heic || !FIELD_EX64_HV(env->msr) ||
@@ -1854,35 +1856,35 @@ static int p9_interrupt_powersave(CPUPPCState *env)
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
@@ -1891,11 +1893,12 @@ static int p9_interrupt_powersave(CPUPPCState *env)
 static int p9_next_unmasked_interrupt(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
+    uint32_t pending_interrupts = env->pending_interrupts;
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P9_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         if (env->spr[SPR_PSSCR] & PSSCR_EC) {
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
-- 
2.39.3


