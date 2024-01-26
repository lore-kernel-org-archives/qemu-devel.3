Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB982C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTULY-0004Mk-A3; Fri, 26 Jan 2024 17:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTULM-0002kW-BX
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:36 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTULG-0004gD-SR
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:36 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so1093437f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306788; x=1706911588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gDIWjU9eQG9A3OK765d3tfkinBgpjsJUVS32LoH/b8=;
 b=c6Ph6sF0VFQnRqEFNAjmWZvXHBwThh6kIc9VJXx8PBU50BpU1uK419beIrA42t7Svm
 KkPuhiShMa5xs99O6Y3i99fQzURJbTtpeP+so99rToR6Rdq0C4JZgvYmqCzjcoxD4bZS
 I7xvIHuQezCEg3vmeF/jE6FkTEXBrqDqgOBAVHFuq0o1EtV/feIKtPX6mnItFEyFzPcB
 GgkHb23kQlnf6yeZwoImVi1g7znImX1t9QGI9Pp57HRezqztS0if807sO3zZpXWLtsQo
 5P+trc4ue9YV36cj7KqzcDtCLU8guaeaQ3M6fS590gZDujBTEwXHpsCKT7UXk7qVz8b/
 POsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306788; x=1706911588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gDIWjU9eQG9A3OK765d3tfkinBgpjsJUVS32LoH/b8=;
 b=v3TpB1gv2fCyPb2imqH3w7ZQ/6lzwGQjAe+DTzh4C1eKIpIjN6mW9drPmxwfLVZo9j
 lKrj6ssbXQTe4rZ81nxn8PEEhNajJlFG2VAFkdIwbIXBDlPwLM/nGRQP1UlhbdnIxRnB
 pLR2Ls22Uvp1U0tgVWd7/qTheHJdMUW7dxP9BZycWjKqZsqroL3l18oudodnUhUj/mcG
 sEEL5osG+aD3xtPzCj7l2HEdH7GELBQT/QjdhzKjfIgOU/5XVSjRaKtRJT2241e1KTEv
 tqzym5PimaQT56fxtUD1NgNGpHSt16SKckstFB2l2RoZW+Tw5HVcOzi1QlGsNV6p898Y
 J7qQ==
X-Gm-Message-State: AOJu0YySbg4qEBBCKq+LuzQkGrrrZMln2gayevFxlmDZY8gQ7uZwa0MA
 y4HYdkW2ilnl6xEDSJLSgEypVDqLSJTeyfHxWCM+BQLxopzo1LGGxt+yFwEsHerQr9Fnr+rIbi1
 +
X-Google-Smtp-Source: AGHT+IE6Sp0LhSpi9Ej8yVTXgYN+0vvayY09E84fmgM1h1bEh6llJXcaofzqIUik5z4nEIAzN4Om7w==
X-Received: by 2002:a5d:6a0b:0:b0:336:6db3:1d7a with SMTP id
 m11-20020a5d6a0b000000b003366db31d7amr188913wru.103.1706306787955; 
 Fri, 26 Jan 2024 14:06:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 bp19-20020a5d5a93000000b003394495566dsm2118313wrb.22.2024.01.26.14.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:06:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 22/23] target/xtensa: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:04:04 +0100
Message-ID: <20240126220407.95022-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/dbg_helper.c | 3 +--
 target/xtensa/exc_helper.c | 3 +--
 target/xtensa/gdbstub.c    | 6 ++----
 target/xtensa/helper.c     | 9 +++------
 target/xtensa/translate.c  | 3 +--
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 497dafca71..5546c82ecd 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -66,8 +66,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 
 bool xtensa_debug_check_breakpoint(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     unsigned int i;
 
     if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 168419a505..0514c2c1f3 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -205,8 +205,7 @@ static void handle_interrupt(CPUXtensaState *env)
 /* Called from cpu_handle_interrupt with BQL held */
 void xtensa_cpu_do_interrupt(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
         qemu_log_mask(CPU_LOG_INT,
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4b3bfb7e59..4748fb6532 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -65,8 +65,7 @@ void xtensa_count_regs(const XtensaConfig *config,
 
 int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
     int num_regs = env->config->gdb_regmap.num_core_regs;
@@ -120,8 +119,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t tmp;
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index a9f8907083..ca214b948a 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -217,8 +217,7 @@ static uint32_t check_hw_breakpoints(CPUXtensaState *env)
 
 void xtensa_breakpoint_handler(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
@@ -266,8 +265,7 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
@@ -297,8 +295,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     cpu_restore_state(cs, retaddr);
     HELPER(exception_cause_vaddr)(env, env->pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 87947236ca..426dcb6169 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1248,8 +1248,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     xtensa_isa isa = env->config->isa;
     int i, j;
 
-- 
2.41.0


