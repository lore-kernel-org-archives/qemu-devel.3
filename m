Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9141ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImt8-00024J-D8; Tue, 11 Nov 2025 06:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrk-0008Aj-CV
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImri-0004aP-AC
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-295ceaf8dacso42651745ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861728; x=1763466528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpQVY4NISu/ik+Tbx2HNl6JcAWJQl7TZbFrzNsX0wvg=;
 b=LV42o9/TOZflOZq0hvXELFHq/beVcovb2Fi1QEYYgqmRDXo31/G782TC1a+ypHEukK
 3lGcxvrywDsgQRlmzVyhCZIKNo9zwKZpVxoV0zDnDnM+BtqSGuzgR6x/kdUDLsYbN3Hb
 YQq64mXFkZvR8lYvBcFBCXPG8W5eZY23zaR5QiL/PhtMH1DtiLN9tP+pJzhpbtSmn5xx
 20j4r3syPxQHv1FuvmmjqmbGADpo91vaozpzu9gn78YlbMh+H8NkiGk9sNMWlM6Q8AXH
 ZFkriKzoXhoFFXiWQPzaoS6AI0UyABa0p3CwhxN9XZwCjmvmxXwd7TlrOJzQbHZpn90K
 gbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861728; x=1763466528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lpQVY4NISu/ik+Tbx2HNl6JcAWJQl7TZbFrzNsX0wvg=;
 b=QMqhBLnX+U0fLrbAywHe9L01zsXYK3rSUFThTHPYQ4icBwShzh4Drne+unsgQsIsbv
 /Ltie1nuUj4EW20FYiCKs06NAJzm/GES2vKn9TQHxJgAc1RqF3xyOLFlrWMIgKwJYUPB
 0Awe7SaCbwBt7NceOFrzHLvw8DNI2fbn7Fj/G93Y1zNlWnG/EfzZZmxTVCf4VdBhDDDT
 2BoZAClyqjbZTwlagc/CW/aYkPf29E4wPf7rBJNc1MQaWF0vOgKLMPHMq0diFm7dGc9F
 YZ+MrBKHDgEpUMFZ7NYJtlPz9bjLMydTJtwa+43XHvdEA/zz+L9N7o2hNTAU1cSb6WXz
 6zNg==
X-Gm-Message-State: AOJu0YzorC4ixEECfYuuin/r5MuG3FkLNHzB3PdhzuxDZerBNlrRW8hh
 Y2v6/41j6f6Gh2pIXcHwjOHSPf+zeeAZaV4KYqt7//QZtH3e50slOhS4DYAUhzWf/XloG96p1KI
 IID8jdUE=
X-Gm-Gg: ASbGncsb9v4Iq5Hr6GC+XDiR6VK00xxk6sHevDPuoeRm5ywvCmYhyrn1M1kej/f+70Z
 Hr0LadoWqDjECvfoPsSGb1nhcBk/zZiZY7FJDfOPvv9vzBjInVvlL3KiSnEk1GL/4GoXJzFjRrz
 vdIxlzviUE2kjYtYjEbsDqq8vLW172eM+WKf8ID1G/RYzVd2nCELyZEt8kN0cnoplhtLxWMg8Ar
 RrLTXMXihFMrAc1b4WQBgIT/4qr0MwiLUo2SQx3jP/ubLDLXVM8NVtQj7o4xyOC6f430SYJ2bnH
 IHS5tby73Kujl1pje9DF4yIUJcu7BjpmWojekwBkp+igOe92nlZQz1lk1nkG0pSv/x6gaOyoz1U
 RLTR4K5qpGZpnjdEjTE2pVM855c0xkjxzkefrDPTiBLADY+U2eq1ifz20QZY2NOHl80f5FPk9t/
 Xs1e0uUsuHCtD28vhiJ21xuGHbzTmR4SLjV6yzfg==
X-Google-Smtp-Source: AGHT+IFtft3zogg+yN7/V2ywtS6cRScCK2+n9l41K3bM+pM58QFg2kBxmguYP2E005lY2bfepNsr0A==
X-Received: by 2002:a17:903:1a2e:b0:295:5945:2930 with SMTP id
 d9443c01a7336-297e5411a06mr168238605ad.2.1762861728591; 
 Tue, 11 Nov 2025 03:48:48 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:48 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 16/17] hw/riscv/trace-encoder: send branches info
Date: Tue, 11 Nov 2025 08:46:55 -0300
Message-ID: <20251111114656.2285048-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Branch info is reported via the TCG helpers, updating the trace encoder
internal branch map.

Branch packets are sent in two circunstances:

- when the branch map is full;

- when an updiscon packet is about to be sent and the branch map
  isn't empty.

The former will trigger a Format 1 no-addr packet, the latter a Format 1
with the updiscon address.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c                | 52 ++++++++++++++++++++++++-
 hw/riscv/trace-encoder.h                |  4 ++
 target/riscv/helper.h                   |  1 +
 target/riscv/insn_trans/trans_rvi.c.inc | 13 +++++++
 target/riscv/trace_helper.c             | 12 ++++++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 5572483d26..5b8f773b11 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -29,6 +29,8 @@
  */
 #define TRACE_MSG_MAX_SIZE 32
 
+#define TRACE_MAX_BRANCHES 31
+
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
     CPURISCVState *env = &te->cpu->env;
@@ -313,6 +315,9 @@ static void trencoder_reset(DeviceState *dev)
     te->trace_running = false;
     te->trace_next_insn = false;
     env->trace_running = false;
+
+    te->branch_map = 0;
+    te->branches = 0;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -410,9 +415,20 @@ static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
     bool updiscon = !notify;
     uint8_t msg_size;
 
-    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+    if (trencoder->branches > 0) {
+        msg_size = rv_etrace_gen_encoded_format1(format2_msg,
+                                                 trencoder->branches,
+                                                 trencoder->branch_map,
+                                                 pc,
                                                  notify,
                                                  updiscon);
+        trencoder->branches = 0;
+    } else {
+        msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                     notify,
+                                                     updiscon);
+    }
+
     trencoder_send_message_smem(trencoder, format2_msg, msg_size);
 
     trencoder->updiscon_pending = false;
@@ -457,6 +473,40 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_branch_map(Object *trencoder_obj)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format1_noaddr(msg,
+                                                    te->branches,
+                                                    te->branch_map);
+    trencoder_send_message_smem(te, msg, msg_size);
+}
+
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+
+    /*
+     * Note: the e-trace spec determines the value '1' for a
+     * branch *not* taken. The helper API is using taken = 1
+     * to be more intuitive when reading TCG code.
+     */
+    if (!taken) {
+        te->branch_map = deposit32(te->branch_map, te->branches, 1, 1);
+    }
+
+    te->last_branch_pc = pc;
+    te->branches++;
+
+    if (te->branches == TRACE_MAX_BRANCHES) {
+        trencoder_send_branch_map(trencoder_obj);
+        te->branches = 0;
+    }
+}
+
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 0c44092ccb..854f8a9ad6 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -28,6 +28,9 @@ struct TraceEncoder {
     uint32_t reg_mem_size;
 
     uint64_t first_pc;
+    uint64_t last_branch_pc;
+    uint32_t branch_map;
+    uint8_t branches;
 
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
@@ -54,5 +57,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 void trencoder_report_updiscon(Object *trencoder_obj);
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f27ff319e9..b1de064e17 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
 DEF_HELPER_1(trace_updiscon, void, env)
+DEF_HELPER_3(trace_branch, void, env, tl, int)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ac00cbc802..ee29adbdeb 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -268,6 +268,15 @@ static void gen_setcond_i128(TCGv rl, TCGv rh,
     tcg_gen_movi_tl(rh, 0);
 }
 
+static void gen_trace_branch(int taken)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_branch(tcg_env, cpu_pc, tcg_constant_i32(taken));
+    gen_set_label(skip);
+}
+
 static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 {
     TCGLabel *l = gen_new_label();
@@ -299,11 +308,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     }
 #endif
 
+    gen_trace_branch(0);
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
     gen_set_label(l); /* branch taken */
 
+    gen_trace_branch(1);
+
     if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
                                     ctx->priv_ver,
                                     ctx->misa_ext) &&
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index 4b2b645f04..b48b89e0db 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -37,6 +37,13 @@ void helper_trace_updiscon(CPURISCVState *env)
     te->updiscon_pending = true;
     te->trace_next_insn = true;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    trencoder_report_branch(cpu->trencoder, pc, taken);
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
@@ -47,4 +54,9 @@ void helper_trace_updiscon(CPURISCVState *env)
 {
     return;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
-- 
2.51.1


