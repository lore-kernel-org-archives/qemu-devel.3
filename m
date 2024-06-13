Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA343C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgs5-00086a-8k; Thu, 13 Jun 2024 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgrw-00082r-TY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgru-0007Ei-Nc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:44 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9Lt7H023621;
 Thu, 13 Jun 2024 09:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=XgSFVeD4OR3Dw
 zpr75OY9D12B9UtocmxwKTZYuTeL28=; b=tqxYoNKAa0KxEtWN9+Nr/CJLXuVWV
 uDC/ux4sa/4EJ3lsDWkek2c+h55e8WsLGVuoAkz8l7DxdUBFsjv6waCasRq4Ek7A
 Y07Mh2ec5cZL4Rl+rnnxh+8JueH2nneZsUJKpZgY229Xm0saJmK0PLQLvW6iy7eb
 1w1xPgBQ4IA+OLy5fzoIDjK9luoZ5BYWUTeK9PlYco4lq1bYi+RsNQs4/UN2EhG4
 96T571Rqy15C9vJgPTkPnZGeb6bdISCTDXRvwqJSdSN7ioA25MT50dOuSVx0DqUt
 3di1TCC/uvTpQ0LCxwWQ/qUzgHWID0tJLtZ4R49jqfR6rZyd1l1vD/Mfg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqqht10u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:39 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45D9XckH010420;
 Thu, 13 Jun 2024 09:33:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqqht10u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45D83Wrn004368; Thu, 13 Jun 2024 09:33:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mq60ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45D9XXA448431574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2024 09:33:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CC722004B;
 Thu, 13 Jun 2024 09:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49B4920043;
 Thu, 13 Jun 2024 09:33:32 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2024 09:33:32 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 2/4] target/ppc: Move VSX vector with length storage access
 insns to decodetree.
Date: Thu, 13 Jun 2024 15:03:16 +0530
Message-Id: <20240613093318.314913-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613093318.314913-1-rathc@linux.ibm.com>
References: <20240613093318.314913-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AaEc1gGiFwViEzynFk9cuMNP36Ea9Apk
X-Proofpoint-ORIG-GUID: IcVj-6I_J05s7bZI94khDOjbLHjZCfGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=934
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Moving the following instructions to decodetree specification :

        {l, st}xvl(l)           : X-form

The changes were verified by validating that the tcg-ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Also added a new function to calculate the effective address :
EA <- (RA == 0) ? 0 : GPR[RA], which is now used by the above-said insns,
and shall be used later by (p){lx, stx}vp insns.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                 |  8 +--
 target/ppc/insn32.decode            |  6 ++
 target/ppc/mem_helper.c             |  8 +--
 target/ppc/translate.c              | 18 ++++++
 target/ppc/translate/vsx-impl.c.inc | 94 ++++++++++++++++++++---------
 target/ppc/translate/vsx-ops.c.inc  |  8 ---
 6 files changed, 97 insertions(+), 45 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b4a0c4674..510ce76524 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -274,10 +274,10 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
-DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
-DEF_HELPER_4(stxvl, void, env, tl, vsr, tl)
-DEF_HELPER_4(stxvll, void, env, tl, vsr, tl)
+DEF_HELPER_4(LXVL, void, env, tl, vsr, tl)
+DEF_HELPER_4(LXVLL, void, env, tl, vsr, tl)
+DEF_HELPER_4(STXVL, void, env, tl, vsr, tl)
+DEF_HELPER_4(STXVLL, void, env, tl, vsr, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 88753c75e1..445fdb341f 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -805,6 +805,12 @@ STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
 STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
 STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
 
+LXVL            011111 ..... ..... ..... 0100001101 .   @X_TSX
+LXVLL           011111 ..... ..... ..... 0100101101 .   @X_TSX
+
+STXVL           011111 ..... ..... ..... 0110001101 .   @X_TSX
+STXVLL          011111 ..... ..... ..... 0110101101 .   @X_TSX
+
 ## VSX Vector Binary Floating-Point Sign Manipulation Instructions
 
 XVABSDP         111100 ..... 00000 ..... 111011001 ..   @XX2
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ea7e8443a8..dec1b25eb8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -467,8 +467,8 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     *xt = t;                                                            \
 }
 
-VSX_LXVL(lxvl, 0)
-VSX_LXVL(lxvll, 1)
+VSX_LXVL(LXVL, 0)
+VSX_LXVL(LXVLL, 1)
 #undef VSX_LXVL
 
 #define VSX_STXVL(name, lj)                                       \
@@ -496,8 +496,8 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
     }                                                             \
 }
 
-VSX_STXVL(stxvl, 0)
-VSX_STXVL(stxvll, 1)
+VSX_STXVL(STXVL, 0)
+VSX_STXVL(STXVLL, 1)
 #undef VSX_STXVL
 #undef GET_NB
 #endif /* TARGET_PPC64 */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..a1f2f4fbda 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3096,6 +3096,7 @@ static inline void gen_align_no_le(DisasContext *ctx)
                       (ctx->opcode & 0x03FF0000) | POWERPC_EXCP_ALIGN_LE);
 }
 
+/* EA <- {(ra == 0) ? 0 : GPR[ra]} + displ */
 static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
 {
     TCGv ea = tcg_temp_new();
@@ -3110,6 +3111,23 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
     return ea;
 }
 
+/* EA <- (ra == 0) ? 0 : GPR[ra] */
+static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
+{
+    TCGv EA;
+    if (!ra) {
+        EA = tcg_constant_tl(0);
+        return EA;
+    }
+    EA = tcg_temp_new();
+    if (NARROW_MODE(ctx)) {
+        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
+    } else {
+        tcg_gen_mov_tl(EA, cpu_gpr[ra]);
+    }
+    return EA;
+}
+
 /***                             Integer load                              ***/
 #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)
 #define BSWAP_MEMOP(op) ((op) | (ctx->default_tcg_memop_mask ^ MO_BSWAP))
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index de2a26a213..46bab49215 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -232,36 +232,72 @@ static void gen_lxvb16x(DisasContext *ctx)
     set_cpu_vsr(xT(ctx->opcode), xtl, false);
 }
 
-#ifdef TARGET_PPC64
-#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                         \
-static void gen_##name(DisasContext *ctx)                          \
-{                                                                  \
-    TCGv EA;                                                       \
-    TCGv_ptr xt;                                                   \
-                                                                   \
-    if (xT(ctx->opcode) < 32) {                                    \
-        if (unlikely(!ctx->vsx_enabled)) {                         \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);                 \
-            return;                                                \
-        }                                                          \
-    } else {                                                       \
-        if (unlikely(!ctx->altivec_enabled)) {                     \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                  \
-            return;                                                \
-        }                                                          \
-    }                                                              \
-    EA = tcg_temp_new();                                           \
-    xt = gen_vsr_ptr(xT(ctx->opcode));                             \
-    gen_set_access_type(ctx, ACCESS_INT);                          \
-    gen_addr_register(ctx, EA);                                    \
-    gen_helper_##name(tcg_env, EA, xt, cpu_gpr[rB(ctx->opcode)]);  \
-}
-
-VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
-VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
-VSX_VECTOR_LOAD_STORE_LENGTH(stxvll)
+#if defined(TARGET_PPC64)
+static bool do_ld_st_vl(DisasContext *ctx, arg_X *a,
+                        void (*helper)(TCGv_ptr, TCGv, TCGv_ptr, TCGv))
+{
+    TCGv EA;
+    TCGv_ptr xt;
+    if (a->rt < 32) {
+        REQUIRE_VSX(ctx);
+    } else {
+        REQUIRE_VECTOR(ctx);
+    }
+    xt = gen_vsr_ptr(a->rt);
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc_ra(ctx, a->ra);
+    helper(tcg_env, EA, xt, cpu_gpr[a->rb]);
+    return true;
+}
+#endif
+
+static bool trans_LXVL(DisasContext *ctx, arg_LXVL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_LXVL);
+#else
+    qemu_build_not_reached();
 #endif
+    return true;
+}
+
+static bool trans_LXVLL(DisasContext *ctx, arg_LXVLL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_LXVLL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STXVL(DisasContext *ctx, arg_STXVL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_STXVL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STXVLL(DisasContext *ctx, arg_STXVLL *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    return do_ld_st_vl(ctx, a, gen_helper_STXVLL);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
 
 static bool do_stxs(DisasContext *ctx, arg_X *a,
                     void (*op)(DisasContext *, TCGv_i64, TCGv))
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index d44cb55836..7f4326c974 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -4,19 +4,11 @@ GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
-#endif
 
 GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(stxvl, 0x1F, 0x0D, 0x0C, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxvll, 0x1F, 0x0D, 0x0D, 0, PPC_NONE, PPC2_ISA300),
-#endif
 
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
-- 
2.39.3


