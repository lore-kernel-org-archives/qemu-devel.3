Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B5C5473F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TF-0003Eq-40; Tue, 27 Aug 2024 19:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TB-0002zI-12
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5T8-0000rr-2N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-202146e93f6so62351465ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800761; x=1725405561;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPl61qcPi4IkfbdTv205Sf5xEsPUhvcDE8fgdnhJ6dE=;
 b=v3vQASqs2mb3/wfK3lUYZSagWtUlZpArDAnZsrOO/4qu93Zskmg/6xHybaQTl8ZppR
 FHecH4KW88rGPnx9w1FIbulGLg2XxVG/NhcUAcvEIaySwIwLkM+CnZDsIhnmHoGeGzFQ
 jKp+icwjvqgqubb7jwYwoy+x3PMd4TdgHxVGik2kz6Tjqxb90T8KFtJ6fjp7lMWeQDCH
 iSUZOoLmmMwTcx2LM9dy5BM7opUW9YQ+V6zhl5hLfN8EmhbKaYU9TK6Hh02Cv0+C7EP8
 aFck/lTvG0v7idm+sLV5NjHtxe0qA3S3Coati97c8dHTid1ywEMrG/KSsuyS21xfZeqU
 HOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800761; x=1725405561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPl61qcPi4IkfbdTv205Sf5xEsPUhvcDE8fgdnhJ6dE=;
 b=SRtvD02+pdTTWgk5ciGSI3jr54HwSlld9HMdmP1FQ0CGYQ1D9b85E7HZYwTQIMljFq
 DqpdoXX2/sB+H8tOL51pvnqr61qr0JKnUVqtImr1pSOAJQTFGbqT7gAR0gjtjKD5zi8e
 Zra31TJq1iFG6GZHpwXi+HpDC6XVLNBTGMyoH4RuxN9WIiwYi9kDk2K4Yzqtp7TRMrUr
 2IFL24xj5w1bE13fcedKqJTKCuD3kkYsyF0d/FakzdhFkQXEe76/zG1keAHGhUSM+BHk
 mgabDPj7YXy5CQOMHSPCFUg1S/vN1pExojIAjEJ5sDj/Rvl7XENy5SXpCKMVDsVXjJLT
 isow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnIln+RPsfx8rO01r2F0cVbIGSClNbcQcSfdsmEsWCcaNW7fR1zYc59KSKfj66BX04KOtnypNMmdEn@nongnu.org
X-Gm-Message-State: AOJu0YzgFlkvfNN3+sn9WWfTdeNyjNIvuDdpFdC45TsNXecGCPjtbKv4
 bKHZZe4HFJAD8gknEjFCRrEiJYSJa+aR+PNTNsqDxCqdauQS9EiCKjr4VcL1Oz0=
X-Google-Smtp-Source: AGHT+IEGwxVs8WMejTrD5t93vGQ+vUdAJYeEqjeX+HJI6csKCbLhmeku3c0+V81kkkSMZpDjWfJmPw==
X-Received: by 2002:a17:903:11c5:b0:1fd:a0b9:2be7 with SMTP id
 d9443c01a7336-2039e44f83dmr175332215ad.13.1724800760608; 
 Tue, 27 Aug 2024 16:19:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v10 08/21] target/riscv: zicfilp `lpad` impl and branch
 tracking
Date: Tue, 27 Aug 2024 16:18:52 -0700
Message-ID: <20240827231906.553327-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
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


