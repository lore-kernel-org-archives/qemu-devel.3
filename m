Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55473C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnqh-0002R4-4t; Sun, 16 Feb 2025 18:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpl-0000jg-2k
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpi-0005Qp-QE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220c8eb195aso78728585ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747633; x=1740352433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RjKlkQC8yvz9LJZGM+JQjK59HoVMzClSDDyDQhJlfhI=;
 b=h2G751YKZYawWUZgOBnAfiTgk1J8c0jtwdHoOYHeuzminGX/aS8JUWI4Yo2YWq1gKc
 xzDLaj1zmoyTw5pCtzbO9ZPVhz+BfyCbw3I9CjycdMyO75O+g23TO0NnErKJFCbbL7D4
 d8qy9oLF7wSGrkBsxiuICcCmYgzTu6sbV3noNypy2EUG2bclN2NoAlH0qcz/uci46tnk
 Vka/3KbyBpHfL4lY25OzfySPDMY1m6+6BA0F2NO2HtBpbLd8ZkPqAzR+XIao+0zYHQ/0
 4a3EmdM3htnej/ZCvxjHoHTSVG2J69dzDRCjBjHn2Zulob+Hhofyfe20hZa6Eo9XB0kL
 WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747633; x=1740352433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjKlkQC8yvz9LJZGM+JQjK59HoVMzClSDDyDQhJlfhI=;
 b=KN+F5vKw1fKYblGqIAludAT5EFYEiMQT2fq43BGR8xVnbUW3aGLAeRzDBjSWB2wt07
 hPm1frMAKAoe4Rk9DcPmJD0NPSf7cr7LgelCvQTQxOhS5os8YJJ67m6Y7L8ZWdW7AoIK
 iJfBtRUl7a9qeGRqYRD2XGp5OaMbnddkYrYFhL9u1qZiqpPk60fcFs8x5Fh4uZmGIYt5
 3K3I/bFY8+2kqUrKSIBXzTyA8PjO43x44/byEgDKcSiOHjAAtheUGD25f4aAELUNQTaH
 6ei7kEENcC33c2XMtdNkrU1HuakqoAUNqjua2KKNw2u+zDE9ZO+ElXsOhuIwoyR2vKsx
 ULqA==
X-Gm-Message-State: AOJu0YyIDenv9aTa7NcGWgv6a6id/Ux1lVTpE7apknkQMXCghsV88c1G
 X+t4Yld8FuhRsEuZMoGmzJNeKGrtEyfRcmk51Htdwxqni2LnBOPaBsaDbXwC6l5k5vAB8eHxRK5
 4
X-Gm-Gg: ASbGncv8GaFTFYCAFdWk/FFGix5xVRdqtDn17qPEo3gEjHf8OS/vptvrViRs3PJflUB
 stAcpF1LlDl7wJhSiB7jja7jdhNmg2UsghWXJCeQI6GZUwht9ljrSadzDcrIpZHstYs2L8NrWuF
 T160lpHZnYZnxOJ2sZJz53alo3Rgqzttm9Wlo4lCxxX/yMqEQo47KpEYLPVO/J3GRRya3Hf0ABV
 OHlb6Noa/DgBX9S/smDuKBc58XWlANOl7qOYD2GaqY4QuOEIeziNZXl+pb6rQLe33mLQa0nYbmW
 n/9ErFZRlh/WJGkqF/RUILFPtPdwe2pyKUIoMiq/zMzvySg=
X-Google-Smtp-Source: AGHT+IEWzZCwTeiCrql/2vgzHBU2pLgRcUkzwMMAMaq8alBd7Zf9zPWRZ5la2rMphd8RZy14MCu6uw==
X-Received: by 2002:a17:903:41c3:b0:216:73f0:ef63 with SMTP id
 d9443c01a7336-221040d6c56mr118436395ad.49.1739747633302; 
 Sun, 16 Feb 2025 15:13:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 051/162] tcg: Merge INDEX_op_remu_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:20 -0800
Message-ID: <20250216231012.2808572-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    | 5 +----
 tcg/optimize.c           | 9 +++++----
 tcg/tcg-op.c             | 8 ++++----
 tcg/tcg.c                | 6 ++----
 tcg/tci.c                | 4 ++--
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 040f4da835..ebb23347e9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -57,6 +57,7 @@ DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
+DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -72,8 +73,6 @@ DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
-/* arith */
-DEF(remu_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -115,8 +114,6 @@ DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
-/* arith */
-DEF(remu_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 55663ff4c3..6f0887f808 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -563,9 +563,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x % ((int64_t)y ? : 1);
 
-    case INDEX_op_remu_i32:
-        return (uint32_t)x % ((uint32_t)y ? : 1);
-    case INDEX_op_remu_i64:
+    case INDEX_op_remu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x % ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
     default:
@@ -3012,7 +3013,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_qemu_st(&ctx, op);
             break;
         case INDEX_op_rems:
-        CASE_OP_32_64(remu):
+        case INDEX_op_remu:
             done = fold_remainder(&ctx, op);
             break;
         CASE_OP_32_64(rotl):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4ff6c9f0ab..0f1e83a49f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -649,8 +649,8 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_remu_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
@@ -2017,8 +2017,8 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_remu_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 41371823d4..12418d1aa6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1041,8 +1041,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
-    OUTOP(INDEX_op_remu_i32, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_remu_i64, TCGOutOpBinary, outop_remu),
+    OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5417,8 +5416,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_rems:
-    case INDEX_op_remu_i32:
-    case INDEX_op_remu_i64:
+    case INDEX_op_remu:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index bd5817a382..5d2cba4941 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -732,7 +732,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
             break;
-        case INDEX_op_remu_i64:
+        case INDEX_op_remu:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
@@ -1080,9 +1080,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_rems:
+    case INDEX_op_remu:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 1f4160a585..bceecb0596 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -292,7 +292,7 @@ Arithmetic
      - | *t0* = *t1* % *t2* (signed)
        | Undefined behavior if division by zero or overflow.
 
-   * - remu_i32/i64 *t0*, *t1*, *t2*
+   * - remu *t0*, *t1*, *t2*
 
      - | *t0* = *t1* % *t2* (unsigned)
        | Undefined behavior if division by zero.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 421a2a8ac7..eb30fd04ba 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -769,7 +769,7 @@ static void tgen_remu(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_remu32
-                     : INDEX_op_remu_i64);
+                     : INDEX_op_remu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


