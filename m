Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B6BEEEC0D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxhB-00022Q-8Y; Fri, 13 Sep 2024 00:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh5-0001b0-V5; Fri, 13 Sep 2024 00:14:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh4-0002XV-1Q; Fri, 13 Sep 2024 00:14:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CG92Fj017485;
 Fri, 13 Sep 2024 04:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=A7yJ13b74nNKZ
 v48YXQ39+FnPwowSUhGuaZCIyJmuhk=; b=fWPN9NTMkJG3scXk5hMxTi79mvSxF
 7DDZD8SIMjjHbf5jNHa30kRhii0KIJqHf0UTXiJASy5lsqXC4oGoNeU54BppCfnC
 V338NKDLQDjAhq2qAVwX5FnJhbrh3lgstnpHhvNvgFnBwS+orponwpt9JGvIdTYb
 +XayYo1KJrjhzjEnm0KsIgAkKGbzvSmEGNxNfJ6+YBdg7De0FohCSc501Pugp6qp
 hWSQ0vgwxxFzjGDDdjUqmXGWlfq9hqSkWUaQVvzMioPxJ9f5KM6NTAwpHyn3CCZ9
 DfSWdXJRlaIsX582Vq9tN/lsKK8s1gYjqNRrcfiHbFcBv89A8UCH66w/w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejayjmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4DwO7021936;
 Fri, 13 Sep 2024 04:13:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejayjmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D0nHxl003130;
 Fri, 13 Sep 2024 04:13:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uc0px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4DtfQ52691340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E9092004E;
 Fri, 13 Sep 2024 04:13:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C3EC20040;
 Fri, 13 Sep 2024 04:13:54 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 08/10] target/ppc: optimize p7 exception handling routines
Date: Fri, 13 Sep 2024 09:43:35 +0530
Message-ID: <20240913041337.912876-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913041337.912876-1-harshpb@linux.ibm.com>
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cLG7VzH7rMj74KYNjHFwyUaFI2fmYifd
X-Proofpoint-GUID: z2YR_HPaa86YK5sFpbrRZ3h6n4iV_PNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=566 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130028
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

Like p8 and p9, simplifying p7 exception handling rotuines to avoid
un-necessary multiple indirect accesses to env->pending_interrupts and
env->spr[SPR_LPCR].

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c0828aac88..d0e0f609a0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1683,51 +1683,54 @@ void ppc_cpu_do_interrupt(CPUState *cs)
      PPC_INTERRUPT_PIT | PPC_INTERRUPT_DOORBELL | PPC_INTERRUPT_HDOORBELL | \
      PPC_INTERRUPT_THERM | PPC_INTERRUPT_EBB)
 
-static int p7_interrupt_powersave(CPUPPCState *env)
+static int p7_interrupt_powersave(uint32_t pending_interrupts,
+                                  target_ulong lpcr)
 {
-    if ((env->pending_interrupts & PPC_INTERRUPT_EXT) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE0)) {
+    if ((pending_interrupts & PPC_INTERRUPT_EXT) &&
+        (lpcr & LPCR_P7_PECE0)) {
         return PPC_INTERRUPT_EXT;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_DECR) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
+    if ((pending_interrupts & PPC_INTERRUPT_DECR) &&
+        (lpcr & LPCR_P7_PECE1)) {
         return PPC_INTERRUPT_DECR;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_MCK) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
+    if ((pending_interrupts & PPC_INTERRUPT_MCK) &&
+        (lpcr & LPCR_P7_PECE2)) {
         return PPC_INTERRUPT_MCK;
     }
-    if ((env->pending_interrupts & PPC_INTERRUPT_HMI) &&
-        (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
+    if ((pending_interrupts & PPC_INTERRUPT_HMI) &&
+        (lpcr & LPCR_P7_PECE2)) {
         return PPC_INTERRUPT_HMI;
     }
-    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+    if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
     }
     return 0;
 }
 
-static int p7_next_unmasked_interrupt(CPUPPCState *env)
+static int p7_next_unmasked_interrupt(CPUPPCState *env,
+                                      uint32_t pending_interrupts,
+                                      target_ulong lpcr)
 {
     CPUState *cs = env_cpu(env);
 
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
-    assert((env->pending_interrupts & P7_UNUSED_INTERRUPTS) == 0);
+    assert((pending_interrupts & P7_UNUSED_INTERRUPTS) == 0);
 
     if (cs->halted) {
         /* LPCR[PECE] controls which interrupts can exit power-saving mode */
-        return p7_interrupt_powersave(env);
+        return p7_interrupt_powersave(pending_interrupts, lpcr);
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
@@ -1737,9 +1740,9 @@ static int p7_next_unmasked_interrupt(CPUPPCState *env)
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
@@ -1749,10 +1752,10 @@ static int p7_next_unmasked_interrupt(CPUPPCState *env)
     }
     if (msr_ee != 0) {
         /* Decrementer exception */
-        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+        if (pending_interrupts & PPC_INTERRUPT_DECR) {
             return PPC_INTERRUPT_DECR;
         }
-        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
+        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
             return PPC_INTERRUPT_PERFM;
         }
     }
@@ -2022,7 +2025,8 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 #ifdef TARGET_PPC64
     switch (env->excp_model) {
     case POWERPC_EXCP_POWER7:
-        return p7_next_unmasked_interrupt(env);
+        return p7_next_unmasked_interrupt(env, env->pending_interrupts,
+                                          env->spr[SPR_LPCR]);
     case POWERPC_EXCP_POWER8:
         return p8_next_unmasked_interrupt(env, env->pending_interrupts,
                                           env->spr[SPR_LPCR]);
-- 
2.45.2


