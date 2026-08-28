Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC68C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpl8-0005lX-Dl; Fri, 28 Aug 2026 02:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl7-0005l8-Eb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl5-0000tR-Ac
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22KlD597115
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KmbJZQ3xtIRnaVSp8
 GaXmzkzNFdwByK7YXUx0rY/lDA=; b=LddyYDi3GnJOEeyfapHZlU5NHSgL2XRAG
 ZOvjW2pG2h8pl8vtIjZt4HwkPQ1r2AGyCyNfYzngybBPe929eX/TW6WllETAznlZ
 TjWpTW3NgHYC5lL4WLcg+q4TL82eIQanz17A1D+EKEz5VDQ86XR0gUy9YFroOK1b
 AR8jU+8mZ8gQCYBVvT6sIfphfQBysAR8VZAybm1dwbXzbxQciQaWW69c3ZMEmpxK
 WtpDwTo7X0gHaz0jnmz7fE/+J0s+tT8wSr7dXewtYfUMlIvy18wrlExIwJNofDHX
 dV2HO4HqqRG/rPavQkX+ery9x/1S2Qu2klxcgB/w5tD66v+0B5s2A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uKGl005956
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qmv9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S684C912059096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF282004B;
 Fri, 28 Aug 2026 06:08:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6917C20040;
 Fri, 28 Aug 2026 06:08:02 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 15/41] target/ppc: Move fixed-point byte-reversal store insns
 to decodetree
Date: Fri, 28 Aug 2026 11:36:50 +0530
Message-ID: <20260828060716.91672-16-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cfUf8ElLOvzfz8SjqjQ9AXoZQUnS33TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX+U+2WqoeAmwB
 62CFEshFldfznu/PR/0iJcU/jpNrPHn/fHsugFCDuHQLsxlGQuLc95aFk1qDkLMV/KGLsN+fO3E
 u7PhUKSDnto8pyhQzp2AWBvdslX6t/hZ8b0hKwpDRxvUVWvwAPkYqSsClvpFLIL4bh6gbbX706h
 W2YPWFPnA8LzkCxQtn5BUi1LCzLFe/ecootgnaxeXpTLOUW1pTL6Ovz/85B6yXKi7TUUgM9+dS8
 2tGJVruJz7TKq2pJFWpTe0kFzhJxOiXAPtoW+5G7EBpOj++KF8i0R7oV0XfaLF/B1iyD/CfAeQ6
 cJqSUaDJY2gxiPyFlnG8ImL5DIVUncmDE4GthjEDwHfCSFPWS5PZL1zVwAvIf86LexdZMhdx8CZ
 faN8LwnjbnSPKCT/VGFWlGpe9oOR4lAO6JIzYL+6D7vtiSeoYYkY4PyP47t3ocCq9SGh/TFXadg
 frAybygA1Ao1uftSOWQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XjGAUUzDke6TOz208osA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXzIBDbgKzwvDA
 FN+3T/69Ne1Ivxi795jALZq8V/Kk51hPhzLYgrZX6vaBSUE2vl92KTz8xsyVj6vV4dCymKjsoXo
 p4DfZUShLrNJ5usGL7XNG1jKMm6wQH8=
X-Proofpoint-ORIG-GUID: cfUf8ElLOvzfz8SjqjQ9AXoZQUnS33TQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Move the below PPC instructions to decodetree specification:

  st{d,h,w}brx, st{d,w,h,b}cix				: X-form

The changes were verified by validating that the TCG micro-ops generated
by those insns remain the same. These TCG micro-ops were captured with
the `-d op,in_asm` QEMU flag.

Additionally, remove GEN_STX and GEN_STX_E macros as they are no longer
used anywhere else.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-12-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  8 +++
 target/ppc/translate.c                     | 52 +++-----------
 target/ppc/translate/fixedpoint-impl.c.inc | 79 ++++++++++++++++++++++
 3 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 12fb4974e4..37f508a5c2 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -372,6 +372,14 @@ STVDX           011111 ..... ..... ..... 0010010001 -   @X
 STSKU           111110 ..... ..... ............. 0 11   @DD
 STCXU           111110 ..... ..... ............. 1 11   @DD
 
+STDBRX          011111 ..... ..... ..... 1010010100 -   @X
+STDCIX          011111 ..... ..... ..... 1111110101 -   @X
+STWCIX          011111 ..... ..... ..... 1110010101 -   @X
+STHCIX          011111 ..... ..... ..... 1110110101 -   @X
+STBCIX          011111 ..... ..... ..... 1111010101 -   @X
+STHBRX          011111 ..... ..... ..... 1110010110 -   @X
+STWBRX          011111 ..... ..... ..... 1010010110 -   @X
+
 ### Fixed-Point Compare Instructions
 
 CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 45418b4de5..749ae56cdf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2529,23 +2529,6 @@ GEN_LDX_HVRM(lhzcix, ld16u, 0x15, 0x19, PPC_CILDST)
 GEN_LDX_HVRM(lbzcix, ld8u, 0x15, 0x1a, PPC_CILDST)
 #endif
 
-/***                              Integer store                            ***/
-#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
-static void glue(gen_, name##x)(DisasContext *ctx)                            \
-{                                                                             \
-    TCGv EA;                                                                  \
-    chk(ctx);                                                                 \
-    gen_set_access_type(ctx, ACCESS_INT);                                     \
-    EA = tcg_temp_new();                                                      \
-    gen_addr_reg_index(ctx, EA);                                              \
-    gen_qemu_##stop(ctx, cpu_gpr[rS(ctx->opcode)], EA);                       \
-}
-#define GEN_STX(name, stop, opc2, opc3, type)                                 \
-    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_NONE)
-
-#define GEN_STX_HVRM(name, stop, opc2, opc3, type)                            \
-    GEN_STX_E(name, stop, opc2, opc3, type, PPC_NONE, CHK_HVRM)
-
 #define GEN_STEPX(name, stop, opc2, opc3)                                     \
 static void glue(gen_, name##epx)(DisasContext *ctx)                          \
 {                                                                             \
@@ -2565,12 +2548,6 @@ GEN_STEPX(stw, DEF_MEMOP(MO_UL), 0x1F, 0x04)
 GEN_STEPX(std, DEF_MEMOP(MO_UQ), 0x1d, 0x04)
 #endif
 
-#if defined(TARGET_PPC64)
-GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
-GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
-GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
-GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
-#endif
 /***                Integer load and store with byte reverse               ***/
 
 /* lhbrx */
@@ -2582,15 +2559,8 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
 #if defined(TARGET_PPC64)
 /* ldbrx */
 GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
-/* stdbrx */
-GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE);
 #endif  /* TARGET_PPC64 */
 
-/* sthbrx */
-GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER);
-/* stwbrx */
-GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER);
-
 /***                    Integer load and store multiple                    ***/
 
 /* lmw */
@@ -5147,9 +5117,17 @@ static int64_t dw_compose_ea(DisasContext *ctx, int x)
             return true;                            \
         }                                           \
     } while (0)
+#define REQUIRE_HVRM(CTX)                               \
+    do {                                                \
+        if (unlikely(ctx->pr || !ctx->hv || ctx->dr)) { \
+            gen_priv_opc(CTX);                          \
+            return true;                                \
+        }                                               \
+    } while (0)
 #else
 #define REQUIRE_SV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
 #define REQUIRE_HV(CTX) do { gen_priv_opc(CTX); return true; } while (0)
+#define REQUIRE_HVRM(CTX) do { gen_priv_opc(CTX); return true; } while (0)
 #endif
 
 /*
@@ -5756,20 +5734,6 @@ GEN_LDEPX(lw, DEF_MEMOP(MO_UL), 0x1F, 0x00)
 GEN_LDEPX(ld, DEF_MEMOP(MO_UQ), 0x1D, 0x00)
 #endif
 
-#undef GEN_STX_E
-#define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)                   \
-GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
-
-#if defined(TARGET_PPC64)
-GEN_STX_E(stdbr, st64r_i64, 0x14, 0x14, PPC_NONE, PPC2_DBRX, CHK_NONE)
-GEN_STX_HVRM(stdcix, st64_i64, 0x15, 0x1f, PPC_CILDST)
-GEN_STX_HVRM(stwcix, st32, 0x15, 0x1c, PPC_CILDST)
-GEN_STX_HVRM(sthcix, st16, 0x15, 0x1d, PPC_CILDST)
-GEN_STX_HVRM(stbcix, st8, 0x15, 0x1e, PPC_CILDST)
-#endif
-GEN_STX(sthbr, st16r, 0x16, 0x1C, PPC_INTEGER)
-GEN_STX(stwbr, st32r, 0x16, 0x14, PPC_INTEGER)
-
 #undef GEN_STEPX
 #define GEN_STEPX(name, ldop, opc2, opc3)                                     \
 GEN_HANDLER_E(name##epx, 0x1F, opc2, opc3,                                    \
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 9f669894a3..25a60d3d3a 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -566,6 +566,85 @@ TRANS(ADDIC_, do_add_D, false, true, false, true);
 TRANS(SLD, do_shift_X_rc, tcg_gen_shl_tl);
 TRANS(SRD, do_shift_X_rc, tcg_gen_shr_tl);
 
+static bool do_stxx(DisasContext *ctx, arg_X *a,
+                       void(*op)(DisasContext *, TCGv, TCGv), bool is_hvrm)
+{
+    TCGv ea;
+
+    if (is_hvrm) {
+            REQUIRE_HVRM(ctx);
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+    ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    op(ctx, cpu_gpr[a->rt], ea);
+
+    return true;
+}
+
+TRANS(STHBRX, do_stxx, gen_qemu_st16r, 0);
+TRANS(STWBRX, do_stxx, gen_qemu_st32r, 0);
+
+static bool trans_STDBRX(DisasContext *ctx, arg_STDBRX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, DBRX);
+#if defined(TARGET_PPC64)
+    return do_stxx(ctx, a, gen_qemu_st64r_i64, false);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STDCIX(DisasContext *ctx, arg_STDCIX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS(ctx, CILDST);
+#if defined(TARGET_PPC64)
+    return do_stxx(ctx, a, gen_qemu_st64_i64, true);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STWCIX(DisasContext *ctx, arg_STWCIX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS(ctx, CILDST);
+#if defined(TARGET_PPC64)
+    return do_stxx(ctx, a, gen_qemu_st32, true);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STHCIX(DisasContext *ctx, arg_STHCIX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS(ctx, CILDST);
+#if defined(TARGET_PPC64)
+    return do_stxx(ctx, a, gen_qemu_st16, true);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_STBCIX(DisasContext *ctx, arg_STBCIX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS(ctx, CILDST);
+#if defined(TARGET_PPC64)
+    return do_stxx(ctx, a, gen_qemu_st8, true);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 static bool trans_SUBFIC(DisasContext *ctx, arg_D *a)
 {
     gen_op_arith_subf(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra],
-- 
2.52.0


