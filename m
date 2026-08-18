Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3CBC5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCe-0007T1-4L; Tue, 18 Aug 2026 13:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCd-0007Sh-7d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCa-0004kA-Fx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so149524b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072535; x=1787677335; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LE/vkj6OKUzpNRHjUmqP28r8rRJv1Dnx5QX4LKQGz0k=;
 b=n8z9U7p9cpxVVz6nvBM8x6vcNYcJkWizrd/9zArmIRUjik3yOvBedDITK4+m3bBAQx
 aqt43fGnCbE9ME08jrjJcgyI5sGQSWly4J01Jb4kNre1+08IgXhDTJXeiHeez2NnR/Et
 ph7gBhl5wQnkeAJkFWESzHG+6OZeFs7DM681XSXwOR/B3U5bt6dKlP1NrWlz+M9OfN7o
 DDSNv6/vd1/JKKzrGVlwjmFAaKmpBUufCsTsXtxobUxsEHwTXc0nVWjfA2yT4S+WFV/T
 QI/IiDh50Eqf70e3itpJx6eCIn3GIGuDPzU5OflepDm5cUg92XpMGhgu0PPXkWkN6ibV
 L0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072535; x=1787677335;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LE/vkj6OKUzpNRHjUmqP28r8rRJv1Dnx5QX4LKQGz0k=;
 b=WMdZZAiMIMA9ngXhSTK6Gn+ZsFBKxQ0hQCdtuH4KW3MpmbsRMMwK6s4tu98GNShnEc
 twhQu2K7x1oWGT2MpyZP79axwhIyhWaetqEP/s4dzbOdxh1c0TgoBgleoS9IVZ5OpA7u
 6g3z7Ivx+1r9JrfOEtUOUmHd/6FiN/ekcd6wArQBZ4Bp/NpMFW/Ezd5GwhuH1MUaGyer
 oRRrhQnUl1Lcwa5KWfxDTWRTh/bj+xxW2Z2t8DG02YY1MEDUOMv6iY1C1nj1k59IWDqV
 99NyyclDTl0pUHRk09Ox7WTxUQR1Xwn/LeRGE0XkUCA6/fAbjvaOOXahVM0PnAM60vah
 nB0g==
X-Gm-Message-State: AOJu0YzRRfdGU4CWj9jGejuK5oiXNu5a/nmgB9OE+qVBwgO84F9lza0L
 DWnWC3QKJacwWw6cMXZy4ixTPsyjWf3BluhbcGMTt3kYpQpaT/NTp2yzZDH+1uT4+G/vd3LVOgS
 1KXeo34g=
X-Gm-Gg: AR+sD12kM9EO3MaNWHwXnd8Bw+tK0VB+tbgwmrpnPYC0kpbLYCLmA7roUQNrksMifuC
 5SNg0N1l/wn1k70kEtyd4F0TFRsjQYPrc83F6zWemLkZmGhNX7DNwf2VeYg0QKlYbxumEKh1YHt
 ep2BI4Njna/pU9+Qv5WSeDZuGOU9abHPIwiVfShpIhLS33Mv1v6+JJmA1+dSNjRbIvi/V7fk/ZO
 7/eFOacf6lVSvxxLaNN2Mm03lMMa+fl4GnIAU5NUK6OY5W+3IW0eGyCpDmtlQzNTVbcAwbykrvG
 ZS++EeZfSl6YMl1V1zz91kdRm5ENdoc40EI31AhavR1PeD5WnYgmks0MYPNtbXXGj69LVHn3L1f
 kRVFV1OkcUogN6K/FCjiTs1uScGVufT+LQuvoUppbj/vneEAmiF9rbJ6CDEBIfHkcAFe9/dwOst
 rKjNa9dplVv/xD+C/++3IOaAxtTNCywMNycvdmZbnrgEI5BQWtVxnlQdvMjAEvmUTOL7c1NYV4D
 z9HCVdzuAnX+TBXnt/YpB2yr7H955GR0ZM=
X-Received: by 2002:a05:6a00:158d:b0:851:bf92:34c9 with SMTP id
 d2e1a72fcca58-851bf9236b6mr10157414b3a.9.1787072534815; 
 Tue, 18 Aug 2026 10:02:14 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 14/38] tcg: Add revbit{8,32,64} opcodes
Date: Tue, 18 Aug 2026 10:01:31 -0700
Message-ID: <20260818170155.1907006-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  3 ++
 tcg/tcg-op.c                     | 66 +++++++++++++++++++++++++-------
 tcg/tcg.c                        |  7 ++++
 docs/devel/tcg-ops.rst           | 16 ++++++++
 tcg/aarch64/tcg-target.c.inc     | 12 ++++++
 tcg/loongarch64/tcg-target.c.inc | 12 ++++++
 tcg/ppc64/tcg-target.c.inc       | 12 ++++++
 tcg/riscv64/tcg-target.c.inc     | 12 ++++++
 tcg/s390x/tcg-target.c.inc       | 12 ++++++
 tcg/sparc64/tcg-target.c.inc     | 12 ++++++
 tcg/tci/tcg-target.c.inc         | 12 ++++++
 tcg/x86_64/tcg-target.c.inc      | 12 ++++++
 12 files changed, 174 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 61f1c28858..13c7f17f76 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -79,6 +79,9 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(revbit8, 1, 1, 0, TCG_OPF_INT)
+DEF(revbit32, 1, 1, 1, TCG_OPF_INT)
+DEF(revbit64, 1, 1, 0, TCG_OPF_INT)
 DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c24a7962fc..c302a484cd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1270,15 +1270,26 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    gen_bitswap_i32(ret, arg, 0x55555555u);
-    gen_bitswap_i32(ret, ret, 0x33333333u);
-    gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
+        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
+    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
+        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
+        tcg_gen_bswap32_i32(ret, ret);
+    } else {
+        gen_bitswap_i32(ret, arg, 0x55555555u);
+        gen_bitswap_i32(ret, ret, 0x33333333u);
+        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+    }
 }
 
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    tcg_gen_revbit8_i32(ret, arg);
-    tcg_gen_bswap32_i32(ret, ret);
+    if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3i_i32(INDEX_op_revbit32, ret, arg, 0);
+    } else {
+        tcg_gen_revbit8_i32(ret, arg);
+        tcg_gen_bswap32_i32(ret, ret);
+    }
 }
 
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
@@ -1870,23 +1881,50 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    gen_bitswap_i64(ret, arg, 0x55555555ull);
-    gen_bitswap_i64(ret, ret, 0x33333333ull);
-    gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
-    tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+    if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_revbit32, ret, arg, flags);
+    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
+        if (flags & TCG_BSWAP_OS) {
+            tcg_gen_sari_i64(ret, ret, 32);
+        } else {
+            tcg_gen_shri_i64(ret, ret, 32);
+        }
+    } else {
+        if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
+            tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
+        } else {
+            gen_bitswap_i64(ret, arg, 0x55555555ull);
+            gen_bitswap_i64(ret, ret, 0x33333333ull);
+            gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
+            flags |= TCG_BSWAP_IZ;
+        }
+        tcg_gen_bswap32_i64(ret, ret, flags);
+    }
 }
 
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-    gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-    gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
+    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
+        tcg_gen_bswap64_i64(ret, ret);
+    } else {
+        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
+        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
+        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+    }
 }
 
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    tcg_gen_revbit8_i64(ret, arg);
-    tcg_gen_bswap64_i64(ret, ret);
+    if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
+    } else {
+        tcg_gen_revbit8_i64(ret, arg);
+        tcg_gen_bswap64_i64(ret, ret);
+    }
 }
 
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 937d0c8fd7..8a324ce885 100644
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
@@ -1230,6 +1231,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_extrh_i64_i32, TCGOutOpUnary, outop_extrh_i64_i32),
     OUTOP(INDEX_op_ld32u, TCGOutOpLoad, outop_ld32u),
     OUTOP(INDEX_op_ld32s, TCGOutOpLoad, outop_ld32s),
+    OUTOP(INDEX_op_revbit8, TCGOutOpUnary, outop_revbit8),
+    OUTOP(INDEX_op_revbit64, TCGOutOpUnary, outop_revbit64),
     OUTOP(INDEX_op_st32, TCGOutOpStore, outop_st),
 };
 
@@ -2950,6 +2953,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_bswap16:
             case INDEX_op_bswap32:
             case INDEX_op_bswap64:
+            case INDEX_op_revbit32:
                 {
                     TCGArg flags = op->args[k];
                     const char *name = NULL;
@@ -5581,6 +5585,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_ctpop:
     case INDEX_op_neg:
     case INDEX_op_not:
+    case INDEX_op_revbit8:
+    case INDEX_op_revbit64:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
@@ -5593,6 +5599,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_bswap16:
     case INDEX_op_bswap32:
+    case INDEX_op_revbit32:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 92ef127c80..f2e9255dd9 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -495,6 +495,22 @@ Misc
          into 32-bit output *t0*.  Depending on the host, this may be a simple shift,
          or may require additional canonicalization.
 
+   * - revbit8 *dest*, *t1*
+
+     - | Reverse the 8 bits within each byte of input *t1* with
+       | output in *dest*; the byte order is unchanged.
+
+   * - revbit32 *dest*, *t1*, *flags*
+
+     - | Reverse the 32 bits of the lower 32 bits of input *t1*
+       | with output in *dest*.  On TCG_TYPE_I64, *flags* control
+       | any required sign or zero extension of the result in
+       | the same way as for bswap32.
+       | On TCG_TYPE_I32, *flags* should be zero.
+
+   * - revbit64 *dest*, *t1*
+
+     - | Reverse the 64 bits of input *t1* with output in *dest*.
 
 Conditional moves
 -----------------
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cc9c2a5158..0afa988087 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2652,6 +2652,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 182dcfd5eb..97ed51d99c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1866,6 +1866,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index b54afa0b6d..07dff67e84 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3421,6 +3421,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 76dd4fca97..687146e0b0 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2469,6 +2469,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 84a9e73a46..c481745c3f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3020,6 +3020,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 5e5c3f1cda..d6ed9d3362 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1947,6 +1947,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 1b22c70616..1b61668517 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -959,6 +959,18 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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
index 1fc45e4ec6..37acba9045 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1290,6 +1290,18 @@ static inline void tcg_out_bswap64(TCGContext *s, int reg)
     tcg_out_opc(s, OPC_BSWAP + P_REXW + LOWREGMASK(reg), 0, reg, 0);
 }
 
+static const TCGOutOpUnary outop_revbit8 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
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


