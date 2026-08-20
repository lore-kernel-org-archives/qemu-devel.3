Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F276C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kg-0003Jc-Rh; Thu, 20 Aug 2026 10:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kV-00033D-GK; Thu, 20 Aug 2026 10:28:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kT-0002Ew-4R; Thu, 20 Aug 2026 10:28:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8PGpB471252; Thu, 20 Aug 2026 14:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CqzDjq7l4O+IaARkE
 PBI2CVSTC2dgfEmh5aI2l76Ndw=; b=skowzq2wPXAGxmU0YLkjpl1Tfx5luyiSY
 vpGPtlkHLfBFc3AZkvDvs0q4yPdvIW8Ykq9x6NcmP4cTPe08/zbB0pMT1IP0bUYB
 jtpZc5KhRCw6B2gaWWKf6ozteRlm/fi7ER2ZxUlN1wMmmE3PPN7rWxKGI9t/Ol/3
 YAPqA9VPC4G4tB2sw7SOH/Ihxb4NWUmQl3qa1NU5PeMXSxHMppJrwU6oWJyJPR/X
 GdhjR3ObuI1RdlYYHGsgVtjdDL35pYF7YqrQxXuMB1bIfBi1s1eFIiBf6HujM7SN
 AC4p7D1fgfKY4VkV+DzEBKpX43nFSpZU4NzCiwVT4kZNpt8NuhF5g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0jy1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEQOaW006060;
 Thu, 20 Aug 2026 14:28:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twf3yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KERvh429229320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:27:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E59F20049;
 Thu, 20 Aug 2026 14:27:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B14520040;
 Thu, 20 Aug 2026 14:27:54 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:27:53 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 5/7] target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
Date: Thu, 20 Aug 2026 19:57:02 +0530
Message-ID: <20260820142717.337686-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
References: <20260820142717.337686-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a870ef3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yMmXoBJQ3w1rxId9nhgA:9
X-Proofpoint-ORIG-GUID: bZTnfmEbvdlS_tNKxBmrosMymRcuEKhP
X-Proofpoint-GUID: EPMyWK7YqiXE0sCBAJr0M5XJQAnRXW28
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6/x+7p/hCeT7
 cut3nRbpoCJVIoQAv0Suw+uQteIUv/pHEkHmg7xUGOKnsmB1pKBuj+nOKkU9CGKtErHqHbyt6K4
 BkjDYumMw1iq/2Ko57os7Dg6/s0IYLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXzJfsGAqg4gnJ
 sJOypyyAWAR2MyJZBq6qRWZS1nZcL23tmUDI7rNZybmhcF+X+x6Sm0L1aYdl5S282NO9lRm23yy
 DrpIAbzVfNXXcYdWYQlJCkgI2YFUw770hExBiN8oJcLDdBnuP/eZXrd8/xzYJhAR/kBHe8yYzwj
 2DC90cUZjyhszEY+rY3DA48w4sHqJtjBzvLq0j0NZDzYTQmqM48OxvSyjMe59itKJWMZNWSgEwv
 b7pTB855/gWqyVCkM2y/qFHhJN06wH83WKaAX7raolmXoReAGRrCJU9WdYEujMOUPupD90OwmHc
 R7WR0np2fYVP5Qv7PD+qtBTozIj6UR0fQm+bYIQiFCaWzmlZjOEWP+uWSlWPebYqeuP11WWGlLm
 oISvbjVlSKOlYQYzH9A8qkfg1Yx/5bqO6F07cBmxy9X/5lRSzfjw9EHp+BDTGHrecfv1So9n2A/
 pwsmWvtubyDtY//6WRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PPC2_ISA207S is only ever set in the CPUPPCState's insns_flags2
alongside PPC2_ISA207. Checks made by PPC2_ISA207S could be
replaced with PPC2_ISA207, hence rendering it useless and apt for
removal. This patch does the same.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/ppc/spapr_caps.c                            | 2 +-
 linux-user/ppc/elfload.c                       | 2 +-
 target/ppc/cpu.h                               | 5 +----
 target/ppc/cpu_init.c                          | 3 +--
 target/ppc/cpu_init.h                          | 2 +-
 target/ppc/tcg-excp_helper.c                   | 8 ++++----
 target/ppc/translate.c                         | 6 +++---
 target/ppc/translate/bhrb-impl.c.inc           | 4 ++--
 target/ppc/translate/branch-impl.c.inc         | 2 +-
 target/ppc/translate/processor-ctrl-impl.c.inc | 8 ++++----
 10 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f4a26a85b5..0d659e9b02 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -676,7 +676,7 @@ static void cap_ail_mode_3_apply(SpaprMachineState *spapr,
 
     if (tcg_enabled()) {
         /* AIL-3 is only supported on POWER8 and above CPUs. */
-        if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
+        if (!(pcc->insns_flags2 & PPC2_ISA207)) {
             error_setg(errp, "TCG only supports cap-ail-mode-3 on POWER8 and later CPUs");
             error_append_hint(errp, "Try appending -machine cap-ail-mode-3=off\n");
             return;
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 8c40f1a663..7bf49e7c0b 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -116,7 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
 
     GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
-    GET_FEATURE2((PPC2_ISA207 | PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
+    GET_FEATURE2(PPC2_ISA207, (QEMU_PPC_FEATURE2_ARCH_2_07 |
                   QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
     GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
                  QEMU_PPC_FEATURE2_DARN | QEMU_PPC_FEATURE2_HAS_IEEE128);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 00676cea2b..4a77607f80 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2577,8 +2577,6 @@ enum {
     PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
-    /* PowerISA 2.07 Book3s specification                                    */
-    PPC2_ISA207S       = 0x0000000000008000ULL,
     /* Double precision floating point conversion for signed integer 64      */
     PPC2_FP_CVT_S64    = 0x0000000000010000ULL,
     /* Transactional Memory (ISA 2.07, Book II)                              */
@@ -2603,8 +2601,7 @@ enum {
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
-                        PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
-                        PPC2_ISA207S | PPC2_DFP | \
+                        PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
                         PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ec4fbd2663..00c40a5328 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6349,8 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 |
-                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
+                        PPC2_FP_TST_ISA206 | PPC2_ISA205 | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
                         PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 73f014c82a..4ba559d8af 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -18,7 +18,7 @@
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
      PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_ISA205 |         \
-     PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
+     PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |                   \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
 
 #define PPC_INSNS_FLAGS2_POWER9                                      \
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index d06d3f8642..93aedb0c8e 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -314,7 +314,7 @@ void ppc_cpu_debug_excp_handler(CPUState *cs)
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
 
-    if (env->insns_flags2 & PPC2_ISA207S) {
+    if (env->insns_flags2 & PPC2_ISA207) {
         if (cs->watchpoint_hit) {
             if (cs->watchpoint_hit->flags & BP_CPU) {
                 env->spr[SPR_DAR] = cs->watchpoint_hit->hitaddr;
@@ -336,7 +336,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
 
-    if (env->insns_flags2 & PPC2_ISA207S) {
+    if (env->insns_flags2 & PPC2_ISA207) {
         target_ulong priv;
 
         priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
@@ -365,7 +365,7 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     bool wt, wti, hv, sv, pr;
     uint32_t dawrx;
 
-    if ((env->insns_flags2 & PPC2_ISA207S) &&
+    if ((env->insns_flags2 & PPC2_ISA207) &&
         (wp == env->dawr_watchpoint[0])) {
         dawrx = env->spr[SPR_DAWRX0];
     } else if ((env->insns_flags2 & PPC2_ISA310) &&
@@ -849,7 +849,7 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
 {
     uint32_t error_code = 0;
-    if (env->insns_flags2 & PPC2_ISA207S) {
+    if (env->insns_flags2 & PPC2_ISA207) {
         /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
         env->spr[SPR_POWER_SIAR] = prev_ip;
         error_code = PPC_BIT(33);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c6c87d3e33..bc23a71a2f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2775,7 +2775,7 @@ static inline void gen_op_mfspr(DisasContext *ctx)
         }
     } else {
         /* ISA 2.07 defines these as no-ops */
-        if ((ctx->insns_flags2 & PPC2_ISA207S) &&
+        if ((ctx->insns_flags2 & PPC2_ISA207) &&
             (sprn >= 808 && sprn <= 811)) {
             /* This is a nop */
             return;
@@ -2841,7 +2841,7 @@ static void gen_mtspr(DisasContext *ctx)
         }
     } else {
         /* ISA 2.07 defines these as no-ops */
-        if ((ctx->insns_flags2 & PPC2_ISA207S) &&
+        if ((ctx->insns_flags2 & PPC2_ISA207) &&
             (sprn >= 808 && sprn <= 811)) {
             /* This is a nop */
             return;
@@ -4105,7 +4105,7 @@ TRANS64(LDARX, do_load_locked, DEF_MEMOP(MO_UQ))
 static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
 #if defined(TARGET_PPC64)
     TCGv EA;
     TCGv_i128 t16;
diff --git a/target/ppc/translate/bhrb-impl.c.inc b/target/ppc/translate/bhrb-impl.c.inc
index 3a19bc4555..4b3914a1f6 100644
--- a/target/ppc/translate/bhrb-impl.c.inc
+++ b/target/ppc/translate/bhrb-impl.c.inc
@@ -14,7 +14,7 @@
 
 static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     TCGv_i32 bhrbe = tcg_constant_i32(arg->bhrbe);
     gen_helper_mfbhrbe(cpu_gpr[arg->rt], tcg_env, bhrbe);
     return true;
@@ -22,7 +22,7 @@ static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
 
 static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     gen_helper_clrbhrb(tcg_env);
     return true;
 }
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index 77eac0a239..526525369e 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -14,7 +14,7 @@
 
 static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
 
     translator_io_start(&ctx->base);
     gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_NORECORD);
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index 3b3ed3019a..155d728b02 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -23,7 +23,7 @@
 
 static bool trans_MSGCLR(DisasContext *ctx, arg_X_rb *a)
 {
-    if (!(ctx->insns_flags2 & PPC2_ISA207S)) {
+    if (!(ctx->insns_flags2 & PPC2_ISA207)) {
         /*
          * Before Power ISA 2.07, processor control instructions were only
          * implemented in the "Embedded.Processor Control" category.
@@ -47,7 +47,7 @@ static bool trans_MSGCLR(DisasContext *ctx, arg_X_rb *a)
 
 static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 {
-    if (!(ctx->insns_flags2 & PPC2_ISA207S)) {
+    if (!(ctx->insns_flags2 & PPC2_ISA207)) {
         /*
          * Before Power ISA 2.07, processor control instructions were only
          * implemented in the "Embedded.Processor Control" category.
@@ -72,7 +72,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 static bool trans_MSGCLRP(DisasContext *ctx, arg_X_rb *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     REQUIRE_SV(ctx);
 #if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
     gen_helper_book3s_msgclrp(tcg_env, cpu_gpr[a->rb]);
@@ -85,7 +85,7 @@ static bool trans_MSGCLRP(DisasContext *ctx, arg_X_rb *a)
 static bool trans_MSGSNDP(DisasContext *ctx, arg_X_rb *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     REQUIRE_SV(ctx);
 #if !defined(CONFIG_USER_ONLY) && defined(TARGET_PPC64)
     gen_helper_book3s_msgsndp(tcg_env, cpu_gpr[a->rb]);
-- 
2.55.0


