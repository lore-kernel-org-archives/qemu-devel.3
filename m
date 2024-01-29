Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CA7C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUoF-0005Bc-7B; Mon, 29 Jan 2024 11:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnA-0000BK-IC
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUn6-0004CY-9Y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so35016105e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546842; x=1707151642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81+lsllbL0HrT+oLcmb3UYRaeAjWMCareNwo8xEwpX8=;
 b=kYWcNNgnmIdoTW7yNmzdwoDFvIUYB3MOp09YkYcX63HGi1Clws3rZBiP3J3SEt76W0
 royFn75knaET8Ry8Rguw+pv4LXWLktNxZ1ZSQfoXiRuvVqZCCImzhafZ/zhqfGtxRy1N
 B54AkMhMgeeGItnBdQEhKhM0rsZJwalBkS9UBobQRavoVSqjOH9MLdXyOpcpg0D/dYVR
 lqp8JQ/Xrri69Ky7BFgs28etHgKyOzfQEeD+NQ2NAK+Ry4YRYL6slWDUF9R5zGwHF7RT
 vi4vgbvkLQs8KO54Zs2LzrbjGGh1D9xsihRNV09caDzWtCQfGBGIEDQCJUKU8p6pHWrb
 MfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546842; x=1707151642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81+lsllbL0HrT+oLcmb3UYRaeAjWMCareNwo8xEwpX8=;
 b=c5uUahg7vPIRKpa1YtOMvkRocdHtzwdb8b6VZIPUYnJajlClg4VBDgUS/tIWpDeEWz
 Az7+a/2JToSrxLNQu4x2wR3ClI3hGMQTtVJKHURKyvGAmkRpZf8JwrMv0T4eVvai/Baj
 yLE0gm4S4lmmlQMsakRU97lmYeWwzhtm9km7Q1hdU5tlbwzidXiMbI4/4HJ86QtQ/edP
 3M5JTYfsjEma/IY9XI0O2gwGzwgnO1Oofwrnl5TB7vI9N+AFspOnBfWoNYERjeMtdJHR
 /+Zui/f/T+KZUixyxfv1VD3SEU/aVck3c97scbDpVSRPtHPTwo0xtDHj7CwQB9zEVmQE
 ECXg==
X-Gm-Message-State: AOJu0YwOT9yXRgFvHv0oQN94LvEbTQEEBkisksIxEpRESFwgclklfOcc
 TxknWH8wPZk3ll3MKoWxlLYEG3D7Satmet+sQQ9if8jRnukB9h9qNJelAwBVki8wl/20kwupktO
 l
X-Google-Smtp-Source: AGHT+IF84eaJDqu3xt4h++MvVzAifUXMdWy4p6XWOiZiCT5EhNKvbhRD8nzigVrNm+QsqfgoC8z5Ng==
X-Received: by 2002:adf:fc46:0:b0:33a:eadb:f4cd with SMTP id
 e6-20020adffc46000000b0033aeadbf4cdmr2748018wrs.58.1706546841883; 
 Mon, 29 Jan 2024 08:47:21 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0033af670213dsm259833wrq.110.2024.01.29.08.47.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 20/29] target/openrisc: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Date: Mon, 29 Jan 2024 17:45:02 +0100
Message-ID: <20240129164514.73104-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/gdbstub.c   | 6 ++----
 target/openrisc/interrupt.c | 6 ++----
 target/openrisc/translate.c | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index d1074a0581..c2a77d5d4d 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -23,8 +23,7 @@
 
 int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    CPUOpenRISCState *env = &cpu->env;
+    CPUOpenRISCState *env = cpu_env(cs);
 
     if (n < 32) {
         return gdb_get_reg32(mem_buf, cpu_get_gpr(env, n));
@@ -48,9 +47,8 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CPUOpenRISCState *env = &cpu->env;
+    CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
     if (n > cc->gdb_num_core_regs) {
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index d4fdb8ce8e..b3b5b40577 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -29,8 +29,7 @@
 
 void openrisc_cpu_do_interrupt(CPUState *cs)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    CPUOpenRISCState *env = &cpu->env;
+    CPUOpenRISCState *env = cpu_env(cs);
     int exception = cs->exception_index;
 
     env->epcr = env->pc;
@@ -105,8 +104,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
 
 bool openrisc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    CPUOpenRISCState *env = &cpu->env;
+    CPUOpenRISCState *env = cpu_env(cs);
     int idx = -1;
 
     if ((interrupt_request & CPU_INTERRUPT_HARD) && (env->sr & SR_IEE)) {
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..12899c911d 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1564,8 +1564,7 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    uint32_t insn = translator_ldl(&cpu->env, &dc->base, dc->base.pc_next);
+    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
@@ -1668,8 +1667,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
 void openrisc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    CPUOpenRISCState *env = &cpu->env;
+    CPUOpenRISCState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PC=%08x\n", env->pc);
-- 
2.41.0


