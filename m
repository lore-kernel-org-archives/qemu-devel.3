Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59926C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxx-0007Jo-Ho; Sun, 16 Feb 2025 18:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwq-0004Wq-Jk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:17 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwj-0006U7-KQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:16 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so5361337a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748066; x=1740352866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dWNGKKhJgIDty3tW+9S0XZ9GNS5MAM0q41XF0iwuPDo=;
 b=m80GCUhE47zs0Wyks+Gj3AFil1qhGBkIpQ623fExeiKxa5VQvNRkXYtqf8QaM8de4w
 YWE5uh9dhsD6s2J+D9duFcH+XK0XhySjw4i3hPf47j1IU0FNyO/kE72tDUabFhc1wHdL
 kTNTg0Fm/K+nu6DxyVDplyQMxYoxaCZZSWqJ4MrzRdeTVoKHX6CROX8RTlbgOl5ZMWoL
 NdNBAIKT/MVUwp9nGhC/3i48hCig7mCdS3a71k0WAn4RomnYbpvlOrlZC4fh6cOBuyfM
 pATMu7i8IMAdnX6r0y1Ri7lqNRSiSu0OWsbZDtnqkdJmxY/abVKe+lfodhmdEFaDz81P
 iC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748066; x=1740352866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWNGKKhJgIDty3tW+9S0XZ9GNS5MAM0q41XF0iwuPDo=;
 b=f5dru+IYxe+87FAFKvDHa2RKXZhYjO6Sdpq3qax93dYPOVo1JrpluQnFDEADU1k94w
 rpAKo1Q5td17QojoJdfBwnUv2JQxuA27MPlHRyrxrjgsJPXVA7P2iNqcxVG1X+zU6q4z
 BySWlCkl703Wr+cLystw/NK867JHurCnVuqJzY+Z0CHJmc2p6yfTRLji7Z8mrrTR4t+y
 VH11FEfdLPjDg9R9awLxEZMqhamX/8q1uBp94mH7lDEHLHMLJcHi9Es7+IPtTtlSvGAz
 mXAXuS5RLpNRy6ksRvSMkyB7qGuwTqg4606bsQHC/y6JbE7blYgqUmfo2+xwZWt0rllD
 OCHQ==
X-Gm-Message-State: AOJu0Yy95KsRfsFc8+h7/+7vbnZXAcvjAG7bNqFHrg94sdG1iJrWum3r
 EjyhOvHmuPNMAajepqXjR6tUsvSZrGK7M58rwjrKz0iYePY4w+F6ipBntvAGT11vGNsQnzU58dC
 1
X-Gm-Gg: ASbGnctCHCHhuqOyHy56mfoibJy8okZIoEGrw8nNGs7UKUAW8elGJgtrI1CUF8HqqYs
 jixB0BKSgtY6BgRhSApd5K7FWPuS+W7gdqdqR2CJKulV7ROa1qoC3BzwhOHr5TNR2fgkTyYZlNa
 X8tiF/gtbn7E9ZPagSZBvD7tt7raANyleEreG+J5EsL3gfgqbcI9Gias3T7UJjB1ejuo7uN/bgS
 P9zZ8cY5VxLZXSlyXUT3m8VHDLLVF+a93rkFy1eRp2Rk0lEuLa6EWnMlPASH3YrrPDDbhDaMZOd
 LtLN2Qi8p7EGlz0vBYnChUZ1/4F2kgKuc+hm6HwC3Dh5dCM=
X-Google-Smtp-Source: AGHT+IGE/ogk/tU8erwk/acrmi8q/YKfYSW+P8YwEoSqD66ZVqUvVuAUJadlm6MZcnB3j0UoDulyMQ==
X-Received: by 2002:a17:90a:e7c3:b0:2ef:e0bb:1ef2 with SMTP id
 98e67ed59e1d1-2fc40f22e28mr11080166a91.19.1739748066429; 
 Sun, 16 Feb 2025 15:21:06 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 146/162] tcg/tci: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:55 -0800
Message-ID: <20250216231012.2808572-147-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tcg/tci.c                    | 54 ++++++++++++++++++++++++++++
 tcg/tci/tcg-target-opc.h.inc |  1 +
 tcg/tci/tcg-target.c.inc     | 69 +++++++++++++++++++++++++++++++-----
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index dc916eb112..d65ff2b8f1 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -361,6 +361,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
+    bool carry = false;
 
     regs[TCG_AREG0] = (tcg_target_ulong)env;
     regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
@@ -471,6 +472,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             regs[r0] = *(tcg_target_ulong *)ptr;
             break;
+        case INDEX_op_tci_setcarry:
+            carry = true;
+            break;
 
             /* Load/store operations (32 bit). */
 
@@ -575,6 +579,46 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
+        case INDEX_op_addco:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            t1 = regs[r1] + regs[r2];
+            carry = t1 < regs[r1];
+            regs[r0] = t1;
+            break;
+        case INDEX_op_addci:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2] + carry;
+            break;
+        case INDEX_op_addcio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                t1 = regs[r1] + regs[r2] + 1;
+                carry = t1 <= regs[r1];
+            } else {
+                t1 = regs[r1] + regs[r2];
+                carry = t1 < regs[r1];
+            }
+            regs[r0] = t1;
+            break;
+        case INDEX_op_subbo:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            carry = regs[r1] < regs[r2];
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_subbi:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2] - carry;
+            break;
+        case INDEX_op_subbio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                carry = regs[r1] <= regs[r2];
+                regs[r0] = regs[r1] - regs[r2] - 1;
+            } else {
+                carry = regs[r1] < regs[r2];
+                regs[r0] = regs[r1] - regs[r2];
+            }
+            break;
         case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
@@ -968,6 +1012,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), ptr);
         break;
 
+    case INDEX_op_tci_setcarry:
+        info->fprintf_func(info->stream, "%-12s", op_name);
+        break;
+
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
@@ -1007,6 +1055,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_addci:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
@@ -1027,6 +1078,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
+    case INDEX_op_subbi:
+    case INDEX_op_subbio:
+    case INDEX_op_subbo:
     case INDEX_op_xor:
     case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 672d9b7323..4eb32ed736 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -2,6 +2,7 @@
 /* These opcodes for use between the tci generator and interpreter. */
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcarry, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index bba96d7a19..947aa1aada 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -573,21 +573,50 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addco,
 };
 
+static void tgen_addci(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addci,
 };
 
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addcio,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -910,21 +939,45 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbo,
 };
 
+static void tgen_subbi(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbi,
 };
 
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbio,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


