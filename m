Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F38CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrZ-0007UD-IV; Tue, 11 Nov 2025 06:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrK-0006n4-Ky
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImrI-0004Wo-Tn
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:26 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29568d93e87so36494845ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861703; x=1763466503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obRy1SkPe/aJ6PXAHbxL+hkYwKo0WH2K1/L4xG7aCQM=;
 b=EF0JLZyGSToQHrr3ezHoqg5utY0h120VHHgENztAvXgDRN/JooC/esMTc9nOFNsz4S
 bk2MpGzP6hIbUrOsCQ6RH1ad5HD/xRZkJliDdJAUvF2SlGDXGDWwi+EDHz710o7egXpe
 MXL2hqRKRStD9zQUNzgdMfj+XyJKtPlqMQ3C82TzKGvveoZd75lhZsYJGtUgg38iJQd9
 LoYNN8mbaHsw3uYl50N9dgKJTOHGdZt0VVUtkPqwO7g028K0Y8OyLJyjEL2Z3LAWhIXv
 6y8QA1dXH3p9AyHO+RqZuUTW9GaP2wD3g7iP+Yb/qHFO/GOdMO5iOO82wiLDx+bXNN2A
 qjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861703; x=1763466503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=obRy1SkPe/aJ6PXAHbxL+hkYwKo0WH2K1/L4xG7aCQM=;
 b=eg74Rq7VTDJZ9WiDBvvHiJ74etFvxoTf4ypVD1LaZ62svnipzPv33321C8ZBy/Gyjy
 7wg8/W/Am2ik4kYtTb34kc5cBUD6b4eeIutYDwSEuTSQZzwNxqg6UywZ0ReUKCJpfDYz
 I9pzqYMnN3wjklAjtcFvYa7Lk8cKZY5bS977mNJtCw9S7vAbQsDwHBaQiUR0hsCssMAp
 SaVHFEts+FLuzTAwZ3zm1oo6bAA4TbE+CNX5y4n5W1Xv3qhWEvbLd/e9N2QZ3oGDToxQ
 a32yHBKUBvF9MSo+l5MamL1MWNmiCxDrfynQKO6dIekuskflwheQNcaZ8YC8pP9qtSl7
 sRnw==
X-Gm-Message-State: AOJu0Yy1y7miiBAdyUZHjVSsmwSEUrotxzI59SnPgbRla3Vd4gzYpSLZ
 Mvg6Nr/JKsV0qi3SC7V9YFuby9TcjJfYNw4E0jX5ecEWiKcpjUGWKS57mIP2KecwXHE+5gOojru
 Wfa94bDI=
X-Gm-Gg: ASbGncuVmFHnT4d3zAUfNzaAdZNWos8xI2aLkG4Io869+gqJ2sr8pdI2wFGYbSqiKBi
 7hC/EU8kIPYMpB7ZQe9CG7U71AHr4HtGl3OuoxgND9o5kYnxFEn27igKntxoeh/9/nSMjGzT0PM
 DnS/H37Ehfdp9tPYq6FHo+C4jLphZfN82gtYsVKSyHI4Q6+CqyaOBfHi3KlE+RjjwHUiwbY/7Fw
 gkNRBif2wdfNbYpKCL6Ijv/Y5EOsI/VboomofGJ8SJNYHbelfEvn6hMsWjSS5nIyhk7mfq7GtTa
 8YtcjZQeoQb4L3mh248lvXBeQPentY+5PJHCi4X4k1+3c3VOnPNdFJJoC3C04unZ8ACc0aoEMb+
 f89Bo9r7bxseNYzhy9yQ12/sadioI5RYtdUn6FQkEwX+/s2xvbz++F8taULOTcyDpwfPikkJMej
 esKipKMv1zGjX5FXJDXNh7m76RZY4=
X-Google-Smtp-Source: AGHT+IEjcXFajXAH74/R1W9Y+YV23swG7neS3xAc3/rkmHaD9J9qaSh+ltK90AQXHAz8o30qPlguIA==
X-Received: by 2002:a17:903:244a:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-297e53f933cmr151688785ad.3.1762861703202; 
 Tue, 11 Nov 2025 03:48:23 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:22 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 12/17] target/riscv, hw/riscv: send trace ppccd packets
Date: Tue, 11 Nov 2025 08:46:51 -0300
Message-ID: <20251111114656.2285048-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

The ppccd (privilege change) trace packets consists of sync packets like we
already sent during trace start and resyncs.

The privilege change is being fetched via riscv_cpu_set_mode().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c  | 18 ++++++++++++++++++
 hw/riscv/trace-encoder.h  |  1 +
 target/riscv/cpu_helper.c | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 0750bd22b5..9a4530bbea 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -389,6 +389,19 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    trencoder->first_pc = pc;
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -420,6 +433,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
+{
+    trencoder_send_sync_msg(trencoder_obj, pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 4898026f2b..2bf07c01f6 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -50,5 +50,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
                                uint64_t tval);
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f2990cf7c4..665aad6dea 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1034,6 +1034,8 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
+    CPUState *cs = env_cpu(env);
+
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
@@ -1041,6 +1043,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
             riscv_itrigger_update_priv(env);
         }
 
+        if (newpriv != env->priv) {
+            RISCVCPU *cpu = RISCV_CPU(cs);
+
+            if (cpu->trencoder &&
+                TRACE_ENCODER(cpu->trencoder)->trace_running) {
+                trencoder_trace_ppccd(cpu->trencoder, env->pc);
+            }
+        }
+
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
@@ -1061,7 +1072,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
     if (riscv_has_ext(env, RVH)) {
         /* Flush the TLB on all virt mode changes. */
         if (env->virt_enabled != virt_en) {
-            tlb_flush(env_cpu(env));
+            tlb_flush(cs);
         }
 
         env->virt_enabled = virt_en;
-- 
2.51.1


