Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04C2CF042A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2C-0000Fa-51; Tue, 08 Oct 2024 18:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2A-0000EQ-Ad
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:26 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ28-0003wH-CN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20bb92346caso2102515ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427823; x=1729032623;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4w8EQzzS8x/AP9HynEBDyPrYuUiwLotAgsmDd3Ae1DI=;
 b=1ZdIleOB+xsxycsl2ftTx258ByF64mHwTRm3IumD8FdyqnCu84O/Jg4WEo3eOTg8mf
 hRVm6JKKb7AMVjrwrNmTkNYlqBXw2yjWZ71kuCzxq+uH+YeqkDwLyKkbTOvFu3rcheLQ
 KE31x4Xu0akM3AQsv61kK+h6DCitdLAd5ZANBPwOz9TreSbooW5QiK7tz5NygoRvRxPV
 dnUrv4yv7V1fp+8IO7QYLQQ6aF9UVX7EDq4BWWuoOPiao/4IckrgQ0EtCL5oT5WJ1sKo
 LUJFY8+i0OoA4DQ0FOTB+nq9MhTkN7GAIqxcLq0LoHPkR9bnT7CDg2h9Bd5nB5t0PVbK
 1OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427823; x=1729032623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4w8EQzzS8x/AP9HynEBDyPrYuUiwLotAgsmDd3Ae1DI=;
 b=TQ5t3zSLquPOF1PA72p4dPPRyuUrMqxr3CCMIdEBAKVN1TXoHujmhX4WoY+F7g3w9Q
 u6Q5EKXVsdvgojcVullyJwUqqzkPLIcOZpD/B7RqhxD2zp/ryZnPSXKAnIgi5wXpZKSB
 2LSbb0rnyl36+mCwj8EXXu5e7vCjdMo2RINwCpbiao5Q+Sun99NAtbgFr73q5153PT0N
 nCLqEJG4Qo08coJt9y5HeMYUQ2WHtDyXLxDSAWlbd5BnxZTyZlJ+zi0aOWmNxwpoxGDz
 0U61FtFpXakYRBaSQq9+BSVsMg4+4GUXPM70R+2zX29QB+rSlHNYytSAFH6yt5w4GcFD
 JlyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWpWGXNLibaUn6pV8k7YGIOzV2t41ll0ZbmgUZd0UtW9GIIUIk1hqIzbEbConHI7FXzaOlC/prnnIo@nongnu.org
X-Gm-Message-State: AOJu0YyJ5GuXhBu8fp5p326iz2VSlPSKH/lg2LjBhMBOqyXZQCw0+ZuG
 Sa+Ugn7aYt0yg859YY81D8jXIKrq+/Ki2/fiqglKqmVnlowcEII44J0XGRZ430g=
X-Google-Smtp-Source: AGHT+IHwHClx/hA0PiNbnQoZchTQOhSDGsyOWdTdjtOMID66jAoVcYhHOhIAVGYbxIyQS384kqqZ0A==
X-Received: by 2002:a17:903:1cf:b0:205:59b7:69c2 with SMTP id
 d9443c01a7336-20c63187db5mr9538915ad.7.1728427823118; 
 Tue, 08 Oct 2024 15:50:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 07/20] target/riscv: zicfilp `lpad` impl and branch
 tracking
Date: Tue,  8 Oct 2024 15:49:57 -0700
Message-ID: <20241008225010.1861630-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index fab5c06719..638fc0fb7b 100644
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
2.45.0


