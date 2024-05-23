Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E9C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYG-0007UK-Ml; Thu, 23 May 2024 19:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYC-0007Qp-2c; Thu, 23 May 2024 19:08:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYA-0005ii-7P; Thu, 23 May 2024 19:08:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8e85a0a5bso304672b3a.0; 
 Thu, 23 May 2024 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505719; x=1717110519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3LwtzSBzdHobHFPRfQ4MfzZA8hpZ0NTB1Y59BEwcgg=;
 b=eRlA9VpEmYwwbGTZ3Dhji99IhoPzJ1+LLatUMI95i27UBJ5nF9JDvcGg5qpw62a5N/
 lOC2PFusp7pVDXNqJeuRz+Pf51/aU5CzyXLtZEBKwjb9e6SOaXjxaYG1tSk5KwiCdjnO
 nLccssueV9ZL1nGQjuLzrHZ6PxXQQsTsH/auyfDRtpxU2/I7UfZLU160C0Mrs+RCENw0
 rqYQ/xhzP7JIzoh16Hlg0GrGw35Rhn5aoLCFaUWDFibxYWOp8zEAcrFU7TMQ9bisfWoO
 QokXH+mGW1jNU+RPrtyCKzBeUMV8INZMztDfpv1Wa9bgxutnd37fpi0ePX+FD+oJm1Lg
 NH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505719; x=1717110519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3LwtzSBzdHobHFPRfQ4MfzZA8hpZ0NTB1Y59BEwcgg=;
 b=q2YJd380yei++NRO/QVze0CaiZF8QmojLbiOltR+oMeYZ8Hbf/yzJmEscJT77Yhygg
 cHvMEU0dpIL0CUn+oSpDceGarFU/q2SggeLW4vV8eDSsg/G35vSoipsF6oY37NEx1ueG
 w86jF783hIuCF26TY4y1J/JB8DiTSpJkDjBr89AbuANENJsja3BvDUqjiYWtQhgY0Vtd
 tdqmnP7rSQjpNQ5f3M3U9wiB81cOV8R++wRVFPrVXSwU0zRBRE8ANFJ2GIjcfgDwyMRR
 9UWqYZSo/6BHt8edAVMBBTPzjjMdXyMHnAQ2hroXSU9Wj5N/3FId9sA3PqktJYV/jgjx
 mClw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLZZ+WugTXf7yN20xKqiMpUfN/Iu23BEttI7AMg5VdkaDwxM6865CsGv2oTpeFRfjf/qJbpUoJ2jDg0RdqTfYfqIFw
X-Gm-Message-State: AOJu0YwkEBTvihbuRFpgZMTBqpMdLSJ6vt+gixQo7+TCqhYrXnJM6KRF
 QJ+RfVTecL/ZwddAacu3Iv6ROPI3jLZM8DtcfvjG4hV6Rmc+7btwHycx+w==
X-Google-Smtp-Source: AGHT+IHR/y40WvoTsVH3OFmt3BhIkBRCzPFuhRONQ535EU1ynlrYMgHxxueuwOCJv/LPiPT8IuKqqg==
X-Received: by 2002:a05:6a00:8013:b0:6f3:854c:d2d with SMTP id
 d2e1a72fcca58-6f8f3086504mr692896b3a.9.1716505718731; 
 Thu, 23 May 2024 16:08:38 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/72] target/ppc: Move divw[u, e,
 eu] instructions to decodetree.
Date: Fri, 24 May 2024 09:06:46 +1000
Message-ID: <20240523230747.45703-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :
	 divw[u, e, eu][o][.] 	: XO-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                        |  4 +--
 target/ppc/insn32.decode                   |  5 ++++
 target/ppc/int_helper.c                    |  4 +--
 target/ppc/translate.c                     | 31 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 24 +++++++++++++++++
 5 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f177d5b906..6f5c0c20eb 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -55,8 +55,8 @@ DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 DEF_HELPER_4(divdeu, i64, env, i64, i64, i32)
 DEF_HELPER_4(divde, i64, env, i64, i64, i32)
 #endif
-DEF_HELPER_4(divweu, tl, env, tl, tl, i32)
-DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
+DEF_HELPER_4(DIVWEU, tl, env, tl, tl, i32)
+DEF_HELPER_4(DIVWE, tl, env, tl, tl, i32)
 
 DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index bb0f1dbd75..c5291504dd 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -371,6 +371,11 @@ MULLWO          011111 ..... ..... ..... 1 011101011 .  @XO_tab_rc
 MULHW           011111 ..... ..... ..... - 001001011 .  @XO_tab_rc
 MULHWU          011111 ..... ..... ..... - 000001011 .  @XO_tab_rc
 
+DIVW            011111 ..... ..... ..... . 111101011 .  @XO
+DIVWU           011111 ..... ..... ..... . 111001011 .  @XO
+DIVWE           011111 ..... ..... ..... . 110101011 .  @XO
+DIVWEU          011111 ..... ..... ..... . 110001011 .  @XO
+
 ## Fixed-Point Logical Instructions
 
 CFUGED          011111 ..... ..... ..... 0011011100 -   @X
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 0a5c3e78a4..dc1f72ff38 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -44,7 +44,7 @@ static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
     }
 }
 
-target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong helper_DIVWEU(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
     uint64_t rt = 0;
@@ -71,7 +71,7 @@ target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
     return (target_ulong)rt;
 }
 
-target_ulong helper_divwe(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
                           uint32_t oe)
 {
     int64_t rt = 0;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 277d96aa94..59248ae3fb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1777,21 +1777,6 @@ static inline void gen_op_arith_divw(DisasContext *ctx, TCGv ret,
         gen_set_Rc0(ctx, ret);
     }
 }
-/* Div functions */
-#define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    gen_op_arith_divw(ctx, cpu_gpr[rD(ctx->opcode)],                          \
-                     cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
-                     sign, compute_ov, Rc(ctx->opcode));                      \
-}
-/* divwu  divwu.  divwuo  divwuo.   */
-GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0);
-GEN_INT_ARITH_DIVW(divwuo, 0x1E, 0, 1);
-/* divw  divw.  divwo  divwo.   */
-GEN_INT_ARITH_DIVW(divw, 0x0F, 1, 0);
-GEN_INT_ARITH_DIVW(divwo, 0x1F, 1, 1);
-
 /* div[wd]eu[o][.] */
 #define GEN_DIVE(name, hlpr, compute_ov)                                      \
 static void gen_##name(DisasContext *ctx)                                     \
@@ -1804,11 +1789,6 @@ static void gen_##name(DisasContext *ctx)                                     \
     }                                                                         \
 }
 
-GEN_DIVE(divweu, divweu, 0);
-GEN_DIVE(divweuo, divweu, 1);
-GEN_DIVE(divwe, divwe, 0);
-GEN_DIVE(divweo, divwe, 1);
-
 #if defined(TARGET_PPC64)
 static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret, TCGv arg1,
                                      TCGv arg2, int sign, int compute_ov)
@@ -6470,17 +6450,6 @@ GEN_HANDLER_E(maddhd_maddhdu, 0x04, 0x18, 0xFF, 0x00000000, PPC_NONE,
 GEN_HANDLER_E(maddld, 0x04, 0x19, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA300),
 #endif
 
-#undef GEN_INT_ARITH_DIVW
-#define GEN_INT_ARITH_DIVW(name, opc3, sign, compute_ov)                      \
-GEN_HANDLER(name, 0x1F, 0x0B, opc3, 0x00000000, PPC_INTEGER)
-GEN_INT_ARITH_DIVW(divwu, 0x0E, 0, 0),
-GEN_INT_ARITH_DIVW(divwuo, 0x1E, 0, 1),
-GEN_INT_ARITH_DIVW(divw, 0x0F, 1, 0),
-GEN_INT_ARITH_DIVW(divwo, 0x1F, 1, 1),
-GEN_HANDLER_E(divwe, 0x1F, 0x0B, 0x0D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweo, 0x1F, 0x0B, 0x1D, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweu, 0x1F, 0x0B, 0x0C, 0, PPC_NONE, PPC2_DIVE_ISA206),
-GEN_HANDLER_E(divweuo, 0x1F, 0x0B, 0x1C, 0, PPC_NONE, PPC2_DIVE_ISA206),
 GEN_HANDLER_E(modsw, 0x1F, 0x0B, 0x18, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(moduw, 0x1F, 0x0B, 0x08, 0x00000001, PPC_NONE, PPC2_ISA300),
 
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 1a2ad58929..3265c77aa6 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -461,6 +461,30 @@ static bool do_mulhw(DisasContext *ctx, arg_XO_tab_rc *a,
 TRANS(MULHW, do_mulhw, tcg_gen_muls2_i32)
 TRANS(MULHWU, do_mulhw, tcg_gen_mulu2_i32)
 
+static bool do_divw(DisasContext *ctx, arg_XO *a, int sign)
+{
+    gen_op_arith_divw(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb],
+                      sign, a->oe, a->rc);
+    return true;
+}
+
+static bool do_divwe(DisasContext *ctx, arg_XO *a,
+                     void (*helper)(TCGv, TCGv_ptr, TCGv, TCGv, TCGv_i32))
+{
+    REQUIRE_INSNS_FLAGS2(ctx, DIVE_ISA206);
+    helper(cpu_gpr[a->rt], tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb],
+           tcg_constant_i32(a->oe));
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->rt]);
+    }
+    return true;
+}
+
+TRANS(DIVW, do_divw, 1);
+TRANS(DIVWU, do_divw, 0);
+TRANS(DIVWE, do_divwe, gen_helper_DIVWE);
+TRANS(DIVWEU, do_divwe, gen_helper_DIVWEU);
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.43.0


