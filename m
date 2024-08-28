Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E17C636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMmB-0007YH-NF; Wed, 28 Aug 2024 13:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm4-00074x-FD
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm1-0004Rh-GL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7143ae1b48fso4100882b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867275; x=1725472075;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPl61qcPi4IkfbdTv205Sf5xEsPUhvcDE8fgdnhJ6dE=;
 b=emx0bs4HkH+IIMO8H+a8htEVYdNoJ+pjF3/MF7PLic97aRY9XWyAOg2yTV6rcF8RDe
 /Cq6VQD8CKxFkuMXTp4TMUuet89KuF4/WtJ0vSK4ZJvy9bOCHQC+u/4bFQ6JJq3beIhM
 q+gX3qm6NFFG+eBgk3yS3X6ED0fQ8n+WXuRQ3M2Mwm1YIVKN8ZbjRTGuBPfZ916P/ejJ
 FyfBXQz5A0lSjQPNTP336n7XA76OCyL6NO9H2dMZvWctxwybN1YUFK4z9GcdeJPojeVq
 f1977Edf88YcaEc094Tc0dv7n66X/Q7djPSQgSBTwo/M798pXk3OGE0lOgD294vzHjY0
 UU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867275; x=1725472075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPl61qcPi4IkfbdTv205Sf5xEsPUhvcDE8fgdnhJ6dE=;
 b=PZFKd71TTaPOJrx4smwA7mC8bcY8w5HFZRve8C+0NTmzUXmKOojyu02IXPrXc95q1x
 h8bmts6TeFENO95lfN0mLgdIO4hOqKvyNjg9EOp5XCTWEsOqC1Z3PvbBLC1Qclk/n7v8
 m7LQKbUL4PDuSpqFFb4cIhw/khajkzoPR00kVdlOrSUhE9sZ8+/CeNl/IsufU9ZJ5g7v
 CYdFqnx3ahzz12KRNKrgVH7TT9vAZwpvvMOnOeRrR4C/IByqVjotqAxyyI/ZPezs/y10
 TPYS1IglA3rRFlZupvBF2a5OspymQ01i6phpfNM5B4dyxNLHXwsSWJHuOWnr7rSCY1o5
 muiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdx7YQdXkm+xL9V9fM4LGvu4L8vl65d3TwtNe+3iV8+qAHrNkFJTnmz/oHa0gSgLb1d8teuXY/u1Ml@nongnu.org
X-Gm-Message-State: AOJu0Yyt/hVL+kzwT27jWGPp0Wq6nGUME0UB1tVE+z0VEyKKSDwK44rS
 sB8mH7dczoZaDA6GHLrqhAsIvdAjefSze7jxQvSX64Ju08w6Cjjr9NIatyJ6KkM=
X-Google-Smtp-Source: AGHT+IFCU0S8Btcr5KHaQqRh4AtDHCEd0R/KJw9HHhSyhsUx+AlYQgLx3DL9RO8GCojBVx/KDT2lBw==
X-Received: by 2002:a05:6a21:3409:b0:1ca:db3c:196 with SMTP id
 adf61e73a8af0-1cce0fea4cfmr78981637.6.1724867274848; 
 Wed, 28 Aug 2024 10:47:54 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:47:54 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 07/20] target/riscv: zicfilp `lpad` impl and branch
 tracking
Date: Wed, 28 Aug 2024 10:47:25 -0700
Message-ID: <20240828174739.714313-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implements setting lp expected when `jalr` is encountered and implements
`lpad` instruction of zicfilp. `lpad` instruction is taken out of
auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
target of an indirect branch, cpu checks for 20 bit value in x7 upper
with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
sw check exception with tval = 2.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_user.h                 |  1 +
 target/riscv/insn32.decode              |  5 ++-
 target/riscv/insn_trans/trans_rvi.c.inc | 55 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index 02afad608b..e6927ff847 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -15,5 +15,6 @@
 #define xA6 16
 #define xA7 17  /* syscall number for RVI ABI */
 #define xT0 5   /* syscall number for RVE ABI */
+#define xT2 7
 
 #endif
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..27108b992b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -123,7 +123,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
-auipc    ....................       ..... 0010111 @u
+{
+  lpad   label:20                   00000 0010111
+  auipc  ....................       ..... 0010111 @u
+}
 jal      ....................       ..... 1101111 @j
 jalr     ............     ..... 000 ..... 1100111 @i
 beq      ....... .....    ..... 000 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..b427f3a939 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -36,6 +36,49 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
     return true;
 }
 
+static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
+{
+    /*
+     * fcfi_lp_expected can set only if fcfi was eanbled.
+     * translate further only if fcfi_lp_expected set.
+     * lpad comes from NOP space anyways, so return true if
+     * fcfi_lp_expected is false.
+     */
+    if (!ctx->fcfi_lp_expected) {
+        return true;
+    }
+
+    ctx->fcfi_lp_expected = false;
+    if ((ctx->base.pc_next) & 0x3) {
+        /*
+         * misaligned, according to spec we should raise sw check exception
+         */
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        return true;
+    }
+
+    /* per spec, label check performed only when embedded label non-zero */
+    if (a->label != 0) {
+        TCGLabel *skip = gen_new_label();
+        TCGv tmp = tcg_temp_new();
+        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        gen_set_label(skip);
+    }
+
+    tcg_gen_st8_tl(tcg_constant_tl(0), tcg_env,
+                  offsetof(CPURISCVState, elp));
+
+    return true;
+}
+
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     TCGv target_pc = dest_gpr(ctx, a->rd);
@@ -75,6 +118,18 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+    if (ctx->fcfi_enabled) {
+        /*
+         * return from functions (i.e. rs1 == xRA || rs1 == xT0) are not
+         * tracked. zicfilp introduces sw guarded branch as well. sw guarded
+         * branch are not tracked. rs1 == xT2 is a sw guarded branch.
+         */
+        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            tcg_gen_st8_tl(tcg_constant_tl(1),
+                          tcg_env, offsetof(CPURISCVState, elp));
+        }
+    }
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
-- 
2.44.0


