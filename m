Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532E1C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnu6-0003qw-08; Sun, 16 Feb 2025 18:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntG-0002bl-9g
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntD-00062c-3l
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:33 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2210d92292eso30330375ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747849; x=1740352649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m/bM54+/z+05ZHrlPUBkKQ12IBejnDJ2p7UEwfEQHU4=;
 b=PnfHuKNxWvPYpIPPz4FlmBerhPK4x6+JdtsANUuEXqsm2n2zW+Q8zKJk8OtCpiiXtU
 HFKPbOR1frbcpBDbbXClVtaEmA1FbQ3MhcQmDTIKPgWLesVOpbtPBe2u7oGiCxTIQohl
 6liFs//GHTaJ1wVqS7mrgfbs+p9/JW2QLXz58+CwELWa7sMc9ea1dT2ez8TFeUlMWBtx
 Ihhusc9yfbXeNpcla6u2PNPJZqeLOU1MYqmccX1tuligLdbRvAUDOAMR4/pfroK/Ny64
 Mv+WWg03wm7FLobdRhQHZ7buWIZFjv14hGb5nqq+Hjuk3Al7bv/MidK5PN9DzideztZz
 rmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747849; x=1740352649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/bM54+/z+05ZHrlPUBkKQ12IBejnDJ2p7UEwfEQHU4=;
 b=cIJvvygr8cl/q227scldH9S/s3FZxDirTLNd5rJvbsN9bXvP2TySDOBDTwrkYQF/zv
 xijiHxXKwjI3f91zZXOkLh7hpaxK7I65/bZAuXsBWO+YfyQ62fAniEkJ/jcC32y4b5/5
 fsEYTm0myfUbF1dQu2d8HWGFubWQsgj/r4bq3h0LcVTasKTeO57Z9M0JdGS4JzHvI/in
 b6eROvYOPsF2dE4En5BUcdV54QrLwjQ5OoNRFSqgfEDLjWonKYSFtixCrWyaKUI8GFpI
 9oUdZ3hU2ecikoBHOXoRvXQpwfwVfg0Ll/1L2iVyV9464c6btRrUIBcHOc6xOxpAW/td
 bndg==
X-Gm-Message-State: AOJu0Yw22E5StME6/czc1l11CMDgjubJ+Hxyg6TZs1uVvMahVv4XBWhq
 8mPH2puSbKV7D0Q0HiSw0hLucyCcGtJzGEP7nf2ZDdacqHN4U4DTkgYMb+JCq5xbdxDlMtPloi/
 s
X-Gm-Gg: ASbGnctVNXl4pmqU8nt15nh1H7hCly4fCN/PIVcEqoPAys7eD/wyBPlfuQJag2Fh1xW
 LeaHEFd+brXaS30YPDxkSxWvYMeiWU+X7Z4ZTsDR/qTAee1By4SGKiyzJqCNyv+e4I0gNlYSb9C
 k2IvPGOvq1MEsf/OKcYq8BxxKah8+TCOfqx47iS65KhdIdsOR6i12Ke1U6lXIIXgtTOTeMqs2Lr
 uQkgK42AKeG/NVIuKLEQkpua4OG9yM3LMs13t5Ah9yZCJPlXC3fiIGNfnLWfu1JZ4E204Bl73ec
 8OBvBHZzZwvUWBG3jvh/1EQil3/dNsvvI88FjvsOyB1cWq0=
X-Google-Smtp-Source: AGHT+IHaPlnvpvVU5fSASS9+6yUoDe3gjXyM8evKpKRuSHdKhXkYfzt8DQe+3NBrhFPs903ic6c5Kw==
X-Received: by 2002:a17:902:e5ca:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-221040bc327mr124352445ad.39.1739747848901; 
 Sun, 16 Feb 2025 15:17:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 099/162] tcg: Convert extrh_i64_i32 to TCGOutOpUnary
Date: Sun, 16 Feb 2025 15:09:08 -0800
Message-ID: <20250216231012.2808572-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

At the same time, make extrh_i64_i32 mandatory.  This closes a hole
in which move arguments could be cast between TCGv_i32 and TCGv_i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c                     |  7 +------
 tcg/tcg.c                        |  5 +++--
 tcg/aarch64/tcg-target.c.inc     | 10 ++++++++++
 tcg/i386/tcg-target.c.inc        | 20 +++++++++++++-------
 tcg/loongarch64/tcg-target.c.inc | 15 ++++++++++-----
 tcg/mips/tcg-target.c.inc        | 17 ++++++++++++-----
 tcg/ppc/tcg-target.c.inc         | 12 ++++++++++++
 tcg/riscv/tcg-target.c.inc       | 15 ++++++++++-----
 tcg/s390x/tcg-target.c.inc       | 10 ++++++++++
 tcg/sparc64/tcg-target.c.inc     | 10 ++++++++++
 tcg/tci/tcg-target.c.inc         | 12 ++++++++++++
 11 files changed, 103 insertions(+), 30 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7ecd1f6c8f..b88f411ece 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2972,14 +2972,9 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_extr_i64_i32) {
+    } else {
         tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
-    } else {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t, arg, 32);
-        tcg_gen_mov_i32(ret, (TCGv_i32)t);
-        tcg_temp_free_i64(t);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a3d9493673..eb5b39dc36 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1162,6 +1162,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
     OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
     OUTOP(INDEX_op_extrl_i64_i32, TCGOutOpUnary, outop_extrl_i64_i32),
+    OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
 #endif
 };
 
@@ -2412,13 +2413,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
-    case INDEX_op_extrh_i64_i32:
-        return TCG_TARGET_HAS_extr_i64_i32;
     case INDEX_op_add2_i64:
         return TCG_TARGET_HAS_add2_i64;
     case INDEX_op_sub2_i64:
@@ -5499,6 +5499,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8abc5f26da..4ea1aebc5e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2220,6 +2220,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_ubfm(s, TCG_TYPE_I64, a0, a1, 32, 63);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0594aba59b..a932550b2d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2794,6 +2794,18 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3212,6 +3224,7 @@ static const TCGOutOpExtract outop_sextract = {
     .out_rr = tgen_sextract,
 };
 
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -3363,10 +3376,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_st(s, TCG_TYPE_I64, a0, a1, a2);
         }
         break;
-
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
-        break;
 #endif
 
     OP_32_64(deposit):
@@ -3995,9 +4004,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_extrh_i64_i32:
-        return C_O1_I1(r, 0);
-
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
         return C_O1_I2(r, 0, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 59457c4323..fdeed82df0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1455,6 +1455,16 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_srai_d(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1855,10 +1865,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_b(s, 0);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_opc_srai_d(s, a0, a1, 32);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bstrins_w(s, a0, a2, args[3], args[3] + args[4] - 1);
         break;
@@ -2456,7 +2462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld8u_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 07dc69cb6f..0050de8fe9 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1793,6 +1793,18 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_dsra(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2321,10 +2333,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_dsra(s, a0, a1, 32);
-        break;
-
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
@@ -2394,7 +2402,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bb03efe055..ba6d7556f7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2965,6 +2965,18 @@ static void tgen_eqv(TCGContext *s, TCGType type,
     tcg_out32(s, EQV | SAB(a1, a0, a2));
 }
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_shri64(s, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_divs(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 76ad2df410..46b4e1167c 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2151,6 +2151,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2619,10 +2629,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_extrh_i64_i32:
-        tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2871,7 +2877,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 1ea041c75f..3b3749efd3 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2409,6 +2409,16 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_sh64(s, RSY_SRLG, a0, a1, TCG_REG_NONE, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d52907f7e3..c1cce7c196 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1501,6 +1501,16 @@ static const TCGOutOpBinary outop_eqv = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_arithi(s, a0, a1, 32, SHIFT_SRLX);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e9b46d5e66..d84d01e098 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -670,6 +670,18 @@ static const TCGOutOpBinary outop_eqv = {
     .out_rrr = tgen_eqv,
 };
 
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
 static void tgen_mul(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


