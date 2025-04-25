Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E80EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAH-000293-9P; Fri, 25 Apr 2025 18:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7a-0004ui-Br
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7S-0001JY-OP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:09 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b061a06f127so1944144a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618521; x=1746223321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiJ2SMandm8T2ScUuoEfW7GuA8BDd5L1ZrDyS3HLPBY=;
 b=FN9PwvHL8SbPGCcforF2+WVHNFePEPjaDoZRyBMZhxSy1+uLGuzeZMOXv6M6O8U04Z
 51YDsaX+I8Fqwv/VJsYCIlN8IW8ojm99MfmxxPSYK+AkW8AIAmIIFhBXeBTx4MB3IZfU
 JebSIS0Nnomp6GDJZ6m3K3B35ElLam19widS4EriEUmRvxA27phy0AKDvCLafZDY0MJ5
 aDr1dmgwE8ug7RDn75udt7TqY9HvMOhXSypMtx5TBYC684NR2AeNtIPJFqUt6FibKCwJ
 ESwLrqOQp37t2hTjDTi5Qdl3lc7bFdznkgjvyknGoMqQaeEcKz+oTXU+wSQsxMya4d+C
 Y5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618521; x=1746223321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiJ2SMandm8T2ScUuoEfW7GuA8BDd5L1ZrDyS3HLPBY=;
 b=T6uJbGRXczZfZ55MrepPAJwHxvwsEd0QhfxViUozrwfx6DIE3pe0rCa3HyElhmmkNJ
 NWFessiuc07eiPOaFb+OElkgOF8z9bc005i7Z8N6Pvf/cgH76K38o6Hd4llF6qn7wnzI
 tc/a90aS9QNs+JPML4qOOEYvllOOL8qThE1oB8M1EQ+vOObhvQlHuEh1wDFZMa0KjW9a
 rC4zRd1Ag1k32g9RhU9BrOUKzmKnM/wx13V5I6p8iZZb7R3qqkgX3ik/KZjWL/cXfcsv
 Rp+xxBOR9O9kuaUzdGaPO0S4c7vqOnoZQUdbwuWmj+KPXPpFoYITq1olkyBqPYVB8R86
 zshg==
X-Gm-Message-State: AOJu0YzTgcfnrJFW6e9q0X12TLU1WWInOKIXvq+4kt44J2n0CEBfZ2U9
 LeJpf6YmbSY1xjcXFg8IydXULdIvLncFm87OwV/+KBRMd+VU8e+9Z1C6+mYTLH5j3PIBc3b0/2h
 s
X-Gm-Gg: ASbGncvhSDfvY6PPXzJTbaH4pmJT9R8y/upVoToA2bAyt2anCzxnIOSwByvoZaStvm6
 PCImQ1lvB7pLuI8gxOznR0FLpZ5Zdt1VMEWduTudx+JweP2f6AAvRsYAzA7XgJjM5csKPhfxahU
 I0lCB3E3N3lPXeEID6LNxYy9HEl0mSB6GQ/Gs4tXao2zqA9ido4PEtUzlN9yTuC/z4KwTnSDmnk
 stqIeDZ7yeAON44ToqqXLHXlzjYrIq66iBoMB4tIz8oDX5B7Cr74J85Kv5ffXRLva8bzjliaa2e
 FWheEhMiVsEPDs+IyHVItKSiov56wyfEh7ptwCkMIr4hzuM6dCh5K3T+JQCWbqHnjdXQau8cwzU
 =
X-Google-Smtp-Source: AGHT+IEMl+hdvvrF4lI8USlxEml7jLQ5UC28UdLHJ/4KcwLXrjqWXGIoiL6wiiD4eFvfywn593+Z0Q==
X-Received: by 2002:a17:90b:1f89:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-309f7da6b69mr7124514a91.14.1745618520864; 
 Fri, 25 Apr 2025 15:02:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 085/159] tcg: Merge INDEX_op_movcond_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:39 -0700
Message-ID: <20250425215454.886111-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           |  2 +-
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 15 +++++----------
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d40ca001c2..5e085607d5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -51,6 +51,7 @@ DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -74,7 +75,6 @@ DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
-DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
 DEF(ld8s_i32, 1, 1, 1, 0)
@@ -98,7 +98,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 
-DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, 0)
 DEF(ld8s_i64, 1, 1, 1, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d0cb4588ed..54606388cc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2943,7 +2943,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mov_vec:
             done = fold_mov(&ctx, op);
             break;
-        CASE_OP_32_64(movcond):
+        case INDEX_op_movcond:
             done = fold_movcond(&ctx, op);
             break;
         case INDEX_op_mul:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 041ca95f0d..3527952c66 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1095,7 +1095,7 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i32(ret, v2);
     } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     }
 }
 
@@ -2799,7 +2799,7 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
     } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ba81a67e28..3f57f6aafd 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1064,8 +1064,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_movcond_i32, TCGOutOpMovcond, outop_movcond),
-    OUTOP(INDEX_op_movcond_i64, TCGOutOpMovcond, outop_movcond),
+    OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2292,13 +2291,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_and:
     case INDEX_op_brcond:
     case INDEX_op_mov:
+    case INDEX_op_movcond:
     case INDEX_op_negsetcond:
     case INDEX_op_or:
     case INDEX_op_setcond:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
@@ -2327,7 +2326,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2879,10 +2877,9 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_brcond:
             case INDEX_op_setcond:
             case INDEX_op_negsetcond:
-            case INDEX_op_movcond_i32:
+            case INDEX_op_movcond:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
-            case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
@@ -5082,8 +5079,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_brcond2_i32:
         op_cond = op->args[4];
         break;
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
     case INDEX_op_cmpsel_vec:
         op_cond = op->args[5];
@@ -5513,8 +5509,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         {
             const TCGOutOpMovcond *out = &outop_movcond;
             TCGCond cond = new_args[5];
diff --git a/tcg/tci.c b/tcg/tci.c
index aef0023dc6..9c3f58242e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -450,7 +450,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
             break;
-        case INDEX_op_movcond_i64:
+        case INDEX_op_movcond:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
             tmp32 = tci_compare64(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
@@ -1075,7 +1075,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_tci_movcond32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
         tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 18f02c5122..26dc3bad49 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -511,7 +511,7 @@ Conditional moves
        |
        | Set *dest* to -1 if (*t1* *cond* *t2*) is true, otherwise set to 0.
 
-   * - movcond_i32/i64 *dest*, *c1*, *c2*, *v1*, *v2*, *cond*
+   * - movcond *dest*, *c1*, *c2*, *v1*, *v2*, *cond*
 
      - | *dest* = (*c1* *cond* *c2* ? *v1* : *v2*)
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 79f9219187..99a5744ab4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -976,7 +976,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_movcond32
-                     : INDEX_op_movcond_i64);
+                     : INDEX_op_movcond);
     tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
 }
 
-- 
2.43.0


