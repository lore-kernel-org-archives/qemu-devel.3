Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FD4C55165
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpake-0001o8-ES; Thu, 30 Jul 2026 20:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakW-0001k3-Vb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakS-0001Lw-DR
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so536568b3a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456311; x=1786061111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o/mxzhPCz/14yoiAK7x8P3LSR9cSbKyXp0L6qWTNguE=;
 b=if0YGyHbCQQchtSbBNZl1D6xVjiDuV+X/bboFmxpEZgsmumyVwqY6UEWvlhUh0znqe
 TIAt7PLZnN64XFm71nbxKtqYj4A5WzhwtmtkfVzo2/mFNsq4WJLbCbUwzuVKYAkkcZ+g
 sUEvOKNYrJ/zO9/7bHVZ4koGvZDGXE4FduoiTmJg5tBzT2TRRpVfRVu+VEv7lh5rEX3s
 1yTeQ51zIvLPAcePsqF9twFOtSmyKacCAITmB4nHkHo0JKZsJ/Q4I36O+vnnZKpgODqu
 DCFk2TnDDjkRlzCiLk5ht4//sj88zjLe/gtYjA3DFD6/ivmsPbiEP/FKvmLrvq9YMgtJ
 MwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456311; x=1786061111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o/mxzhPCz/14yoiAK7x8P3LSR9cSbKyXp0L6qWTNguE=;
 b=Xe5H23CPz8RJYtEXBHl83GipdqY67KRQqdgJep3G++RPYAC9Q/tChW7IZgtGEbMRBu
 BBN6fxTMrgluBgfVBtr35t52ZIpyMezqSDxlI9bT5zEz0Njn/B6ncyFAzID8XdTR87oY
 bISpn0hVlEQ+vbGi6epP3Gb2xWb5yW29rw2mg8OK6HNp+93hf5JEcx5Tah/VdIS+6B9H
 26mlE4Gzjj0it30/nM0KvgLSojpeEEcfNm+vqhqIko43yK/CHXO88Tih01NWQUZan/U3
 v5cfRBKcSRrdTBVUNC7vKjpKEqrYcmyXABWxIhehRLRV8GCc+5SPJ/XEdt+42ZwoyLft
 +A+g==
X-Gm-Message-State: AOJu0YzHy+wSeXOrr1w3/e9tiO21/jRWlLFUlKTEwVXNvLwNnd1a3dtY
 WUBV9YlmH9JGbEmu5376OoxPcqptDPV2sLiwgOrdSn2Bf0qtzZUrhpCaJr6OpvqeHP0HsXqC83W
 n9c8j
X-Gm-Gg: AR+sD11xt1lc/7lCXqmL3/TO+Sa/3UNk3mskqY8WhkpUA8/k9U+k5KNHg9CR6Ob5OUv
 MMJJNp7RnR6rad/7i2Lkkshs03tqhjoWmvcLuVNvuuwWJ5Z1wYOCI/1aBCIvzrDhthywlwphiv/
 rnBvWgb4mj/Ylrd9jRToKluWs9qJGYU7S+De/qfW81+h/0QJ13iCy3MWhHyK1JhS5jZr6Y1naT8
 jYdQhju4IU+lwAvE2lJ+muS5Lxu4HyWdFIeTrmxmKb8GQLd4Bvc1BLz7zQPkorgFga6iDZC3/52
 MMOeslWS0+UInPWTs27yldeGmAnV0It3wzXS7erWzyfFhP2qUgSeKpJAj/Bu6/2LsWk6x+5P2+A
 aiCdA/mCP2SEjkr4Mf/brrdIFJL8vKUVYGlFAph3NVLEcUFWUFWkhR8KMBdDSTdAHMyGtW5kg+4
 Ps1l/D82UMqcjkRVq2E+KGe9Gg/k3lNQo5xProG+V8YSBTvL4tkGKLQIP1lBD/cNHnVdCrIgpyd
 6HBpQr5yW1QRjULAnbH
X-Received: by 2002:a05:6a00:2e0e:b0:848:2f7a:2e5d with SMTP id
 d2e1a72fcca58-84ebc46574amr4099771b3a.76.1785456310821; 
 Thu, 30 Jul 2026 17:05:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 07/11] tcg: Add revbit{32,64} opcodes
Date: Thu, 30 Jul 2026 17:04:59 -0700
Message-ID: <20260731000503.170446-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Add the plumbing, but not yet implemented for any host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  2 ++
 tcg/tcg-op.c                     | 43 +++++++++++++++++++++++---------
 tcg/tcg.c                        |  6 +++++
 docs/devel/tcg-ops.rst           | 11 ++++++++
 tcg/aarch64/tcg-target.c.inc     |  8 ++++++
 tcg/loongarch64/tcg-target.c.inc |  8 ++++++
 tcg/ppc64/tcg-target.c.inc       |  8 ++++++
 tcg/riscv64/tcg-target.c.inc     |  8 ++++++
 tcg/s390x/tcg-target.c.inc       |  8 ++++++
 tcg/sparc64/tcg-target.c.inc     |  8 ++++++
 tcg/tci/tcg-target.c.inc         |  8 ++++++
 tcg/x86_64/tcg-target.c.inc      |  8 ++++++
 12 files changed, 114 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 61f1c28858..ca2077733e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -79,6 +79,8 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(revbit32, 1, 1, 1, TCG_OPF_INT)
+DEF(revbit64, 1, 1, 1, TCG_OPF_INT)
 DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 02fb3504b1..04d5e15167 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1262,10 +1262,14 @@ static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
 
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    gen_bitswap_i32(ret, arg, 0x55555555u);
-    gen_bitswap_i32(ret, ret, 0x33333333u);
-    gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    tcg_gen_bswap32_i32(ret, ret);
+    if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3i_i32(INDEX_op_revbit32, ret, arg, 0);
+    } else {
+        gen_bitswap_i32(ret, arg, 0x55555555u);
+        gen_bitswap_i32(ret, ret, 0x33333333u);
+        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+        tcg_gen_bswap32_i32(ret, ret);
+    }
 }
 
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
@@ -1914,18 +1918,33 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    gen_bitswap_i64(ret, arg, 0x55555555ull);
-    gen_bitswap_i64(ret, ret, 0x33333333ull);
-    gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
-    tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+    if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_revbit32, ret, arg, flags);
+    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_revbit64, ret, arg, 0);
+        if (flags & TCG_BSWAP_OS) {
+            tcg_gen_sari_i64(ret, ret, 32);
+        } else {
+            tcg_gen_shri_i64(ret, ret, 32);
+        }
+    } else {
+        gen_bitswap_i64(ret, arg, 0x55555555ull);
+        gen_bitswap_i64(ret, ret, 0x33333333ull);
+        gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
+        tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+    }
 }
 
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-    gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-    gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    tcg_gen_bswap64_i64(ret, ret);
+    if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_revbit64, ret, arg, 0);
+    } else {
+        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
+        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
+        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+        tcg_gen_bswap64_i64(ret, ret);
+    }
 }
 
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e023ee8b9a..c2eb591f86 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1203,6 +1203,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_revbit32, TCGOutOpBswap, outop_revbit32),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
@@ -1230,6 +1231,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
     OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
 };
 
@@ -2944,6 +2946,8 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_bswap16:
             case INDEX_op_bswap32:
             case INDEX_op_bswap64:
+            case INDEX_op_revbit32:
+            case INDEX_op_revbit64:
                 {
                     TCGArg flags = op->args[k];
                     const char *name = NULL;
@@ -5575,6 +5579,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
+    case INDEX_op_revbit64:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
@@ -5587,6 +5592,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_bswap16:
     case INDEX_op_bswap32:
+    case INDEX_op_revbit32:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 92ef127c80..1b3a2618b6 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -495,6 +495,17 @@ Misc
          into 32-bit output *t0*.  Depending on the host, this may be a simple shift,
          or may require additional canonicalization.
 
+   * - revbit32 *t0*, *t1*, *flags*
+
+     - | 32 bit bit reverse.  The flags are the same as for bswap32.
+         On TCG_TYPE_I32, the flags should be zero.
+
+   * - revbit64 *t0*, *t1*, *flags*
+
+     - | 64 bit bit reverse. The flags are ignored, but still present
+         for consistency with the other revbit opcodes. For future
+         compatibility, the flags should be zero.
+
 
 Conditional moves
 -----------------
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cc9c2a5158..aa2c4e42ed 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2652,6 +2652,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_XZR, a1);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 182dcfd5eb..a5cd3c3b1e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1866,6 +1866,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index b54afa0b6d..a9a41ebd4f 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3421,6 +3421,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out32(s, NEG | RT(a0) | RA(a1));
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 76dd4fca97..4ebbe24774 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2469,6 +2469,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 84a9e73a46..10b9dcb0cf 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3020,6 +3020,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     if (type == TCG_TYPE_I32) {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 5e5c3f1cda..d22c1bd566 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1947,6 +1947,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
      tgen_sub(s, type, a0, TCG_REG_G0, a1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1b22c70616..e8b82a0c85 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -959,6 +959,14 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
     tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 1fc45e4ec6..70fec08c4c 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1290,6 +1290,14 @@ static inline void tcg_out_bswap64(TCGContext *s, int reg)
     tcg_out_opc(s, OPC_BSWAP + P_REXW + LOWREGMASK(reg), 0, reg, 0);
 }
 
+static const TCGOutOpBswap outop_revbit32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_revbit64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_arithi(TCGContext *s, int c, int r0,
                         tcg_target_long val, int cf)
 {
-- 
2.43.0


