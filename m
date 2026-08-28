Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D3BC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplo-0007vw-Be; Fri, 28 Aug 2026 02:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplm-0007jB-3A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplk-00010C-3w
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22Msb2941380
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NDD1OvGTonqXoO4Dj
 +D+3OXUHZJ958y4Uq7qPsRJ878=; b=O73jiJ3GyZpbW2HmTZqkQJAzSP15ILDFU
 i2KzX5DjMLnuWJqVcyOIzcorjLS5sbf3HZgPcdjGadSnBLRiX8GZaQNGPNVViFE4
 VabO19BVxMH4XTI0TSYv1lN8x4/wzOt03LsdkX10rhkiyxElJZ6/d+0VBsD+Gyn5
 18t+eQjcbzTXCbyzaHEoa8A2XoCCYnerFBY3tqRqqJUqeQyyvTt4B82YfYkNOp7i
 Bb/YXBJfnnnWh+9Kze0ZMW+LbNQn4zw/opXV1s0BxKgYNRwrWtVorRTXbEHFD5B2
 VR1pHgZdzEE+M9qbQkUfQBMbgGUjG+X/tTXouFl/F9JEzJiFv770w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eraayn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uNv1003691
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmk2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68jrX32440708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28B5920043;
 Fri, 28 Aug 2026 06:08:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50DF320040;
 Fri, 28 Aug 2026 06:08:43 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Tanushree Shah <tshah@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 30/41] target/ppc: Move lmw, stmw instructions to decodetree
Date: Fri, 28 Aug 2026 11:37:05 +0530
Message-ID: <20260828060716.91672-31-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wi0hAo6PrDxu5F8ElKKyYaMIj6_P9M5R
X-Proofpoint-ORIG-GUID: wi0hAo6PrDxu5F8ElKKyYaMIj6_P9M5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX0OVvNYsfS0Gx
 xxSuMed6aQUqBLkBs7fK6eyd2Jlzk5wJq6hnv6ZCrzvnm5g+4cYLxhDPSNrGEj1XZ0aVXMmxjdg
 ryx/+SDP6rOzg24QGOIy3rZz27Ldulbt54en0j8kOPAuN/gAkFSInem6sXrzACcNabWSyraZV5d
 nRxOp0X9ymwd7bHpIW/6x070Wn6ZBP03mQsoySNArdMAqgDNNsP596AWH2PLSoWigrB9I7lcRZj
 0DU8aZwk9ZO+3/FoupGHH11PrwIFlZrtPJPA8OOgL6thb1VAyKmoCf1s5bnF5qCoM3mdy1TPDD9
 9ROEVpIrZbZ6mD5DY5H/3CEeXH5vqwGI5cLl/P3UiZdr/Ye0DUc42nalXKj4h/fJlSYLNUG/ndT
 dKdwnzMcNgNvE+H2ZcQ7yC1w4Mwu0luc5ZAWkxPyIen8M5VuuL0sYKnA/HdmAO0g9yJK6WuEqdm
 be1lvJ/UmfYhTRMgLlA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a9125f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=EKBDPzd3v7EvMxvHOJ8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX+llc9R4idPLu
 rAbY5k40WUG9rryzOXKMcDVwH+m9J2hhN7f47faQa+yzTmO+SfnW2qOKlVM5HrA5M4sAmxACvYI
 QfJLvYm2TEZb5duIN622Z+wE6LjdIYI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Tanushree Shah <tshah@linux.ibm.com>

Moving the following instructions to decodetree specification:
 lmw  : D-form
 stmw : D-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the
"-d in_asm,op" flag.

Additionally, validated using small assembly tests confirming the
the correct register store/load behavior. Also, confirmed the
register values are same before and after the change.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-27-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper.h                        |  4 +--
 target/ppc/insn32.decode                   |  3 ++
 target/ppc/mem_helper.c                    |  4 +--
 target/ppc/translate.c                     | 39 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 32 ++++++++++++++++++
 5 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7da752c69b..ec3350fee8 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -43,8 +43,8 @@ DEF_HELPER_1(check_tlb_flush_local, void, env)
 DEF_HELPER_1(check_tlb_flush_global, void, env)
 #endif
 
-DEF_HELPER_3(lmw, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_3(LMW, void, env, tl, i32)
+DEF_HELPER_FLAGS_3(STMW, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(LSW, void, env, tl, i32, i32)
 DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 92ee278f63..ef128f63c1 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -354,6 +354,7 @@ LVDX            011111 ..... ..... ..... 0000010001 -   @X
 LSKU            111010 ..... ..... ............. 0 11   @DD
 LCXU            111010 ..... ..... ............. 1 11   @DD
 
+LMW             101110 ..... ..... ................     @D
 
 ### Fixed-Point Atomic Load/Store Instructions
 
@@ -399,6 +400,8 @@ STBCIX          011111 ..... ..... ..... 1111010101 -   @X
 STHBRX          011111 ..... ..... ..... 1110010110 -   @X
 STWBRX          011111 ..... ..... ..... 1010010110 -   @X
 
+STMW            101111 ..... ..... ................     @D
+
 ### Fixed-Point Compare Instructions
 
 CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 10c648cf06..dc5eab8c76 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -73,7 +73,7 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
     return NULL;
 }
 
-void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void helper_LMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
@@ -98,7 +98,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     }
 }
 
-void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void helper_STMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ce94f9e4e6..880915f3da 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2455,43 +2455,6 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
 GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
 #endif  /* TARGET_PPC64 */
 
-/***                    Integer load and store multiple                    ***/
-
-/* lmw */
-static void gen_lmw(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    t1 = tcg_constant_i32(rD(ctx->opcode));
-    gen_addr_imm_index(ctx, t0, 0);
-    gen_helper_lmw(tcg_env, t0, t1);
-}
-
-/* stmw */
-static void gen_stmw(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    t1 = tcg_constant_i32(rS(ctx->opcode));
-    gen_addr_imm_index(ctx, t0, 0);
-    gen_helper_stmw(tcg_env, t0, t1);
-}
-
-
 #if !defined(CONFIG_USER_ONLY)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 {
@@ -4695,8 +4658,6 @@ GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 /* handles stfdp, stxsd, stxssp */
 GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index efef56a119..8475205f14 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -288,6 +288,38 @@ static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
     return true;
 }
 
+/* Load/Store Multiple Word */
+static bool do_ldst_multiple(DisasContext *ctx, arg_D *a, bool store)
+{
+    TCGv ea;
+    TCGv_i32 reg;
+
+    REQUIRE_INSNS_FLAGS(ctx, INTEGER);
+
+    /* Little-endian mode is not supported for multiple word operations */
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+
+    reg = tcg_constant_i32(a->rt);
+    ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
+
+    /* Call the appropriate helper function */
+    if (store) {
+        gen_helper_STMW(tcg_env, ea, reg);
+    } else {
+        gen_helper_LMW(tcg_env, ea, reg);
+    }
+
+    return true;
+}
+
+TRANS(LMW, do_ldst_multiple, false)
+TRANS(STMW, do_ldst_multiple, true)
+
 /*
  * Fixed-Point Compare Instructions
  */
-- 
2.52.0


