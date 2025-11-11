Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EABCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImre-0007nx-RM; Tue, 11 Nov 2025 06:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrZ-0007Tg-Am
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:41 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrW-0004Yl-Bg
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-297dc3e299bso30669105ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861716; x=1763466516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdvq16DNFrDDYS/eBUrRZ3SqUnavTY0SVfaYl0dw6yY=;
 b=LUDF0lsL4CmYGzS8QFeNh2Y2QiZp/JVjybAdJxT/4r6kbkfiIQ6L8dDLbFgpNgzsMz
 pFB+SrqoQk9z9wCNnDvX/wH63HvC9zOup234C+aGjQZSlXZKVcZuhtDVA27PPtQhWR9R
 uCwQhnpQzWBoq3qYLNtxrRjIhL1e9pjIUjoeYMe67Hdo3Ko+Z3udafWw5iKDUVUOx5OR
 qxXYubopuvs69K6KdCEez7qnzaf2MXIOrRQgFk8Ipva3BjIoYb19/9gzhNxnHtxKzjA+
 DX7Jfd1ddAKOkjmobWQypVVyqX2l4+rQBF6SGjQxdYMJBuFv2okxW6XJb/qoFYN5A3HM
 ICzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861716; x=1763466516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bdvq16DNFrDDYS/eBUrRZ3SqUnavTY0SVfaYl0dw6yY=;
 b=QUDEarocYKKZPECy1YLvpJeMgq+5YEHdCiUXkGlF8O+RSOX20FEoyn6dJTBIVlAMCK
 Zu3oIQqY53RelnkyoRoFp66IrClZAmQqaCJ7COmbQfcLRHCxv+byB51cBFczXgBKOx5+
 omS9zu4SXaa+CJl7Wmd82Wp3yzGuDMsKDs5OUr7QGnnyoEuRHGE2pKG3N/yC8GRtVKk2
 ppsDLxfpuEm2G6acWpcZYtKqL2P/xJOQpx4rh4t3CvPy0GpxKI2B6nHn8H1aWqHAiglt
 TCQIh8PxGHHTudR9hefrvP4Lavh8MF/8Tp7VZu9QL4pD1NQAIjUDWe5bHrSx0D0wXh1o
 wfeg==
X-Gm-Message-State: AOJu0YxSYCNC9HhwMYF6fKL4oQyPFrj0GbB7YIkenRci7fcl8NEmK7bp
 ggX4+9zaApUhSniSVDw2L84YFS4OrNGOXTBHAXmU5BnI4Uk5nHPvgBQA+zD4MimQo5LIG3E5lh9
 6AOw2SvQ=
X-Gm-Gg: ASbGncugTfdf9/RYXrdcT7K4a9c8t2q5wEN7/VRYkqksnJg402qW9b7zXoff+VD5RsR
 hyB7bkYvy+Dp/qkB+wFaBjjVQljvvFDSSZRxTPMpkjUe7t/VIrQJIdgG6bHkXXwDed1wnD5Ob2S
 J5Q/Aqcpdlfgxb3dPYisTtIKjFqA22TK2PiiKlMnT+1c/mjDMC/lTdASP2L2gBKtpNarUGAT7ti
 2L06mO0/qGcGkS9kwyq+LQJFHOvUXBISjn7+twXGIZgWfjtOuL4eWJ2PZl9N9/r+5YD3/eZWPFl
 cBerLiTtZ/tiSoo/0lUyzCAKW2HMiSnXwXL1pfAXOJV7QI+ZUe0HlFJzPDCh4T4m9g7wAd8Qjok
 tdrgDBzrn50/GcS6GyPH0nVavgP4oQDi8HeLQ7a8rU+ZCpb6mGh7CrWndrnjLn2H1rcYo6b4gaA
 OE/hGB/av1sqemoA+AEPMKVsyRM2m+tZ7+pNhYIw==
X-Google-Smtp-Source: AGHT+IHMVmKKijhoOpwgRfU6G9sx5t8C2qfX8SqaY6PYOQSh80/4U9ZvQLhw9I1FXFF0WZi1hSLrlw==
X-Received: by 2002:a17:902:d507:b0:295:6a69:4ad5 with SMTP id
 d9443c01a7336-297e571bce3mr157218985ad.56.1762861716433; 
 Tue, 11 Nov 2025 03:48:36 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:35 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 14/17] hw/riscv,
 target/riscv: send resync updiscon trace packets
Date: Tue, 11 Nov 2025 08:46:53 -0300
Message-ID: <20251111114656.2285048-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Send updiscon packets based on the constraints already discussed in the
previous patch:

- We do not implement any form of call/return prediction in the encoder,
  and TCG will always retire a single insn per cycle, e.g. irreport will
  always be equal to updiscon;

- irdepth is not implemented since we'll always return a  package where
  irreport == updiscon.

Note that we're sending an updiscon packet if the 'updiscon_pending'
flag is set when we're about the send a resync or a trap packet. The TCG
helper in this case is just setting the trace encoder flags instead of
actually triggering a RAM sink SMEM write.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  3 ++
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
 target/riscv/trace_helper.c                   | 14 +++++++
 target/riscv/translate.c                      |  9 +++++
 7 files changed, 77 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 9a4530bbea..5572483d26 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
+{
+    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t addr_msb = extract64(pc, 31, 1);
+    bool notify = addr_msb;
+    bool updiscon = !notify;
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                 notify,
+                                                 updiscon);
+    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
+
+    trencoder->updiscon_pending = false;
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
     msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
@@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
                                               ecause, is_interrupt,
                                               tval);
@@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
 
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
+void trencoder_report_updiscon(Object *trencoder_obj)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->updiscon_pending = true;
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 2bf07c01f6..0c44092ccb 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -36,6 +36,8 @@ struct TraceEncoder {
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
 
+    bool updiscon_pending;
+
     bool enabled;
     bool trace_running;
     bool trace_next_insn;
@@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                bool is_interrupt,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
+void trencoder_report_updiscon(Object *trencoder_obj);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e80320ad16..f27ff319e9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
+DEF_HELPER_1(trace_updiscon, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..28089539d5 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -26,6 +26,8 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
+    gen_trace_updiscon();
+
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
     return true;
@@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
+    gen_trace_updiscon();
+
     /*
      * The RISC-V semihosting spec specifies the following
      * three-instruction sequence to flag a semihosting call:
@@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        gen_trace_updiscon();
+
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
         gen_update_pc(ctx, 0);
@@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
     gen_update_pc(ctx, 0);
@@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
+
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..ac00cbc802 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+    gen_trace_updiscon();
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index ed84e6f79a..4b2b645f04 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
         te->trace_next_insn = false;
     }
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    te->updiscon_pending = true;
+    te->trace_next_insn = true;
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
     return;
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ff288051e3..26c7678cb9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -617,6 +617,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
+static void gen_trace_updiscon(void)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_updiscon(tcg_env);
+    gen_set_label(skip);
+}
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
-- 
2.51.1


