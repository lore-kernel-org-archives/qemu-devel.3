Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5228DC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mDM-0004d6-Bi; Tue, 15 Apr 2025 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m7m-0002si-Bi
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:15 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6b-0005RN-1S
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:03 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c5aecec8f3so899487085a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745879; x=1745350679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slbwdvS55I87g1hzr+vXDFKtKtdORTzPko4P+Uo/zrE=;
 b=KBGCxFqxcX+Z8LiNzTul0sgrueqzyn0Z7WwrFg7RCO67MouldQ5pg0d1pSyk+coV79
 Rd9gGhCtGH1BbbR8C29QQLSRHRZWTo9zNBoN10F3l8YubSU9ACAxz13NiqMoEe/kGnp4
 fc7aEHvrSXjHj4k1n+30n50n26tWBekyL0t27ECOjy4cO4wFZ7I4V8Vnq+QrCruIR6QY
 pJO8HjVUTvKsnpmwm3a1L4QY9inwACBqqs7mX4Q7ym0yNmrT+buiacH2H76ynpDu6zby
 wBcyCSVgq/DUHAnpVk5rNfI8wvv4G+Eadsl5HrNIxGF2BQ5QGYOZZTBWvQ3d/mSvKC+X
 VbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745879; x=1745350679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slbwdvS55I87g1hzr+vXDFKtKtdORTzPko4P+Uo/zrE=;
 b=VTrXL4by5tBiJrlEDUJIjjaFUkBdsD9gpeJnOZHBj5uFBGGwIy3BAtX/UMzRy5mCUZ
 dTGG+50twVyUtGXJyiumb2nM+641otTfRwNnYS2+1MKbZ8MfTHRQBmy55cit2GLiOLBP
 vsg0Fw4KB2bguBCm/tooUEoKEBDVagFt+Zx62Dpmx5s0Dx7G1NKQTchZGghCPO+PKC1K
 uy+B/pDHt9CGM8BIVYtjfX41iPWDx4ry6nyTcHZHfSgy333ZqLyr7EU3NvZdwiRO46NH
 PDKmnvJNWngkWxZwx99dakfIMaRhSen6W/0k85RGIMmRqNPDsqQBWH+T7XSD0Q6E8wcr
 HygA==
X-Gm-Message-State: AOJu0YwYzHK5/2Zowg/rO8//qCmAvL9DKRMZnlGar5dU5DPNDNKyPB59
 mLh8ONlOnGKrhbvagzLm75+mXP2F0oSArxgdgHKZyJ/30d561H8YO6ZasrCjuoum6/IMj7pBoHW
 S
X-Gm-Gg: ASbGnct/Fo1dBX7vSBuDzCGsbhaIm6+h9PtXGO4J3dvbdMYWcMDUwsjz0b9w2sL8Th4
 n7hsrmJ/sAntj2vj99jPp656nojMsJ9eP9BCd0y2gnyFZkDIMOiUkPJ1GDIPllyIEZ4rZsy1aRC
 4Hy5PR7yu+RT6Z+IfUJ1fLk8Onxv9liOSKwHizZsqKzmJ4mbeDgODe4/4jq7zhtorO1IhXkaGyF
 ljezUejCCMPjRmaelWVYh+zZhFx+CHZ6nkZbRDWlVelU6aavYebGQ66UDxpfFL9rsGwPd9UeiNQ
 tnEiWDsaFSBGNrmJtF1Lm8t2nI2nkFwbqV8e6Am2sgJrzEPg/Y8xpOU0AUp4+Po8fqFpTZkqBkE
 =
X-Google-Smtp-Source: AGHT+IHrKpA7DrLbeLzqJKTLYVjOxWY63cRNTdCjYpyih8anMGtoMsYt2KkX5FREjoSRmjB/6750PQ==
X-Received: by 2002:a17:902:ea0e:b0:224:6ee:ad with SMTP id
 d9443c01a7336-22c31adb46cmr4871435ad.44.1744745551185; 
 Tue, 15 Apr 2025 12:32:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 088/163] tcg: Merge INDEX_op_bswap16_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:59 -0700
Message-ID: <20250415192515.232910-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 3 +--
 tcg/optimize.c           | 7 +++----
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5e085607d5..acfbaa05b4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(bswap16, 1, 1, 1, TCG_OPF_INT)
 DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(ctpop, 1, 1, 0, TCG_OPF_INT)
 DEF(ctz, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
-DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 
 /* load/store */
@@ -122,7 +122,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8783447e29..75849a1495 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -506,7 +506,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_ctpop:
         return type == TCG_TYPE_I32 ? ctpop32(x) : ctpop64(x);
 
-    CASE_OP_32_64(bswap16):
+    case INDEX_op_bswap16:
         x = bswap16(x);
         return y & TCG_BSWAP_OS ? (int16_t)x : x;
 
@@ -1560,8 +1560,7 @@ static bool fold_bswap(OptContext *ctx, TCGOp *op)
 
     z_mask = t1->z_mask;
     switch (op->opc) {
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         z_mask = bswap16(z_mask);
         sign = INT16_MIN;
         break;
@@ -2858,7 +2857,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_brcond2_i32:
             done = fold_brcond2(&ctx, op);
             break;
-        CASE_OP_32_64(bswap16):
+        case INDEX_op_bswap16:
         CASE_OP_32_64(bswap32):
         case INDEX_op_bswap64_i64:
             done = fold_bswap(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c5b3bc8148..917f52b04a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1257,8 +1257,8 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
 
-    if (tcg_op_supported(INDEX_op_bswap16_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3i_i32(INDEX_op_bswap16_i32, ret, arg, flags);
+    if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3i_i32(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -2087,8 +2087,8 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         }
-    } else if (tcg_op_supported(INDEX_op_bswap16_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3i_i64(INDEX_op_bswap16_i64, ret, arg, flags);
+    } else if (tcg_op_supported(INDEX_op_bswap16, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3i_i64(INDEX_op_bswap16, ret, arg, flags);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a6af923450..2337a3c247 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1075,8 +1075,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
-    OUTOP(INDEX_op_bswap16_i32, TCGOutOpBswap, outop_bswap16),
-    OUTOP(INDEX_op_bswap16_i64, TCGOutOpBswap, outop_bswap16),
+    OUTOP(INDEX_op_bswap16, TCGOutOpBswap, outop_bswap16),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2941,8 +2940,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                     i = 1;
                 }
                 break;
-            case INDEX_op_bswap16_i32:
-            case INDEX_op_bswap16_i64:
+            case INDEX_op_bswap16:
             case INDEX_op_bswap32_i32:
             case INDEX_op_bswap32_i64:
             case INDEX_op_bswap64_i64:
@@ -5486,8 +5484,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap16:
         {
             const TCGOutOpBswap *out =
                 container_of(all_outop[op->opc], TCGOutOpBswap, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index ae447e91bd..905ca154fc 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -686,7 +686,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_write_reg64(regs, r1, r0, T1 - T2);
             break;
 #endif
-        CASE_32_64(bswap16)
+        case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
             break;
@@ -1005,14 +1005,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), s2);
         break;
 
+    case INDEX_op_bswap16:
     case INDEX_op_ctpop:
     case INDEX_op_mov:
     case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_bswap16_i32:
-    case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 26dc3bad49..509cfe7db1 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -415,7 +415,7 @@ Misc
      - | *t0* = *t1*
        | Move *t1* to *t0*.
 
-   * - bswap16_i32/i64 *t0*, *t1*, *flags*
+   * - bswap16 *t0*, *t1*, *flags*
 
      - | 16 bit byte swap on the low bits of a 32/64 bit input.
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2a8ba07e37..4d3d9569cc 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -905,7 +905,7 @@ static const TCGOutOpUnary outop_ctpop = {
 static void tgen_bswap16(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, unsigned flags)
 {
-    tcg_out_op_rr(s, INDEX_op_bswap16_i32, a0, a1);
+    tcg_out_op_rr(s, INDEX_op_bswap16, a0, a1);
     if (flags & TCG_BSWAP_OS) {
         tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
     }
-- 
2.43.0


