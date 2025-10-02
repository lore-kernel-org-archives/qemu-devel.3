Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD7ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HRJ-0006Fw-IA; Thu, 02 Oct 2025 07:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HR8-0006Bg-6d
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:27 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQJ-0005uz-Uc
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:25 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-76c144b06fdso11820447b3.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404259; x=1760009059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kk5riI+qsKCXUtISs+Mp5yJa8KqY6rXw3pNCXHWJaBk=;
 b=n3uUCtEcs/jvL6mW4kcUoQxhD0m0mdNsDxppPRLWpKfQcv82jwHXFbXT720l+HkfJG
 /K302Jlue7AogP8SUidQoAv3LAZ52cEgGL3DLfVY4DbjOLZqIaQFjg6cSWP3Rtc75Ffl
 Nhbh7bEYy83Gj9WBT9a0ZCvUPAVnA3wWCIN84ycJPrYqF6kTo+DDW7dwR8Asw5ely5T6
 Jx6soU6vQ6LH3fWU8HWDwI4ofarbDD+g5UDBQ+Ih2RZuvJan2s4RDOO/yD//TUcGKbo9
 qBEAUUuTd5Et8YmJsPX8otgkkfAPHJyb1U0FY2ycKbskezdZdRqsbmvLfpZK+FrM64bT
 Aa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404259; x=1760009059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kk5riI+qsKCXUtISs+Mp5yJa8KqY6rXw3pNCXHWJaBk=;
 b=hPlR7WUPDDWe7rQGGV2vwik3NnHqzC0PcBGITRGyo6Qptl4w65J/Raw91tiaY7pklp
 1374BCd7tNNrstCnmyR6kzfBZiiy5lBszryHQR65hpL3WsInz44F4h9rb/TIm37gJGfz
 sjxYuSv3oNFf95H4OQJ0B6DQeB1xn8wBzy+wNR/BhZD6o5uXvJqbFMdplMMs4ok1rVPT
 NWm2ll1hNtHRBgyNOLnS/M4IZj4xMX0/dCunRkdDeLSqhkWjQ0Uu99BabgVMkkDBQ9rU
 6rrzMw0dEVBCvDxukNuMUKY+B1q6AxX5kv4xHv0wjk4qRRYEy6q4yg+MX+VI/kDYcqS0
 V8eA==
X-Gm-Message-State: AOJu0YyLh1oH+2hBjqSMCvqAb8K/mUjhdhhR1aY6/5h/SK1maAhzAfS9
 ntFrjpf8ujS3PIZh9H5ghwqkYOJegWcDoX+RkDNiOQwsleGRbGNug48gTv+U+k/33u1frwz7Qsg
 tEPJGIOY=
X-Gm-Gg: ASbGncuge6A5rtHYdAw4ORIk9QB2AbsOJAFKp0ndxyRiiSFiqL+FsjSis4nS/owQAXs
 j7rP2A2tZAhAFemWPKaUXiAVFoBCT8ZsWfRS9zHrtSbM4O/39wAOQKR2bq2ZvgSxbKFbQ1e5qnd
 TaGnHUu0CSYz5Z+/pw5HrS2oXjIjtOLuudq9KeP+6zKgrs6aU+2AR67eVHgPbjYGd2cJxp+QTob
 Hg3t7SZ4RlPTHPXS7LiFWpv3ghLKa9AmmJg+B9OC+sbiy7H86XijT5XeNNuhL2ciT3R1rU3J5Cv
 1f5J+x7vwY1rOC309GSlklOghN9iRZdM22lt/COEozEud3alxD1OXxAJI6hyma8gOzjtmwRHJNs
 Z0recirwKGzwTdVkjOrTsweZOXCe+AO99zdZ+HR6QTJYO09JUPkstUtA7qnmR5K5/iTTP4GNfbz
 Y=
X-Google-Smtp-Source: AGHT+IEhGpLuO26CkdIXIgyZwNw0g/pbyr83EH1oa1iW1jJpUbM2HsNcpwTZ+ljq6ZXtyhzawyUFlw==
X-Received: by 2002:a05:690c:550c:20b0:773:e84f:ed01 with SMTP id
 00721157ae682-77f6f2cf206mr83487207b3.2.1759404258871; 
 Thu, 02 Oct 2025 04:24:18 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 16/17] hw/riscv/trace-encoder: send branches info
Date: Thu,  2 Oct 2025 08:23:34 -0300
Message-ID: <20251002112335.2374517-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index adda6b5bd8..c53e042b1e 100644
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
2.51.0


