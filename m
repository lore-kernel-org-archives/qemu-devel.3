Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9275AC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUna-0002M8-B3; Mon, 29 Jan 2024 11:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmB-0006nz-1E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:28 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUm7-0003vx-HI
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so39658085e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546781; x=1707151581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qs1q2hIX1TKLXUzvNhNiLBWs7dxyWeQLrsbzeUj/euM=;
 b=Ch/RCi0UXz1xSC3fxQT+A46De1e0aXvbw/pYhIKaOG0qH70b332S4wYXOG2ek1X64m
 qQ7rRkXx8umBulrwASA7MWVRq6vGLP3HU8Jo+agzO/ki8bDk3qmEM7STdGe/6JNacMMF
 EsthOmf6zaWzQowJP6N7A1xx0VopO7/KSKfVxERP94S+y2gKp0lxuYcYBxyfdJY7rMRr
 8+f/IxMZ2alhQQhJFztpiFUYAkc2B43aEfnKpNYG6iJQc15HRTqgfYstXSfmMgzeWBym
 lGoKYB296krBDtPyoQ9ADZ8Ux26nHZ4SPtgK5E3YeRmesUhd2sxK6wNn7FzdPL/uCEqy
 PoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546781; x=1707151581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qs1q2hIX1TKLXUzvNhNiLBWs7dxyWeQLrsbzeUj/euM=;
 b=rVYQkpkxm5rdoY1cpJsZC4L9Od+vem2LOx3Ng8/goYNfxq0ifTMqH2ZAx8rrBwCNDs
 GFJl/BGRsIOSKrUrgCSnsW6G7onO0VVVcPiNBy4d1/IjCAv/cImJmugqWWyt9w90GmXk
 oxxf2GM9Yi0AYZKeDQVCLudo0zNHDlpNZ99urvnhUTKbyPwUELrF2TkmoS2qgNlWN/aS
 R7NM9ZNjANU1wFTLQeJR8h0RPZwx5vNynk0zfFSivhC+cS5z09OWpaypHogqFyazrOwO
 P9N2w8DjBGi9afO4cAYr9Jierd71Gi1gPbrbSZstxgquDY3STDM95rlRYmIlIoApzxry
 v+9Q==
X-Gm-Message-State: AOJu0YzB2ombMWUt8nOZj6J1qyVTHLyEK2od+Z9QnR38/J78UNdsz0qK
 thzwmkknc6v1j37ANAql7HDXTX4JqVGiY7KQUg2K7l667dCApjPVVWH/xoZbG05qigfiYO18QsQ
 e
X-Google-Smtp-Source: AGHT+IFCSjt586qMBuxNZypsApcZ+VC1FCZxUMqaBfFfPBMsHNMjn2msv5U3H1M4DbXITkHOuF5KTQ==
X-Received: by 2002:a05:6000:402a:b0:33a:e525:b15 with SMTP id
 cp42-20020a056000402a00b0033ae5250b15mr4721457wrb.19.1706546781551; 
 Mon, 29 Jan 2024 08:46:21 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bh5-20020a05600005c500b0033aed46956csm3386579wrb.80.2024.01.29.08.46.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 10/29] target/cris: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:44:52 +0100
Message-ID: <20240129164514.73104-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 target/cris/cpu.c       | 10 +++-------
 target/cris/gdbstub.c   |  9 +++------
 target/cris/helper.c    | 12 ++++--------
 target/cris/translate.c |  6 ++----
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 4187e0ef3c..122071f142 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -58,10 +58,9 @@ static bool cris_cpu_has_work(CPUState *cs)
 
 static void cris_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    CRISCPU *cpu = CRIS_CPU(s);
+    CPUState *cs = CPU(obj);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint32_t vr;
 
     if (ccc->parent_phases.hold) {
@@ -142,10 +141,7 @@ static void cris_cpu_set_irq(void *opaque, int irq, int level)
 
 static void cris_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
-    CRISCPU *cc = CRIS_CPU(cpu);
-    CPUCRISState *env = &cc->env;
-
-    if (env->pregs[PR_VR] != 32) {
+    if (cpu_env(cpu)->pregs[PR_VR] != 32) {
         info->mach = bfd_mach_cris_v0_v10;
         info->print_insn = print_insn_crisv10;
     } else {
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index 25c0ca33a5..9e87069da8 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -23,8 +23,7 @@
 
 int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
 
     if (n < 15) {
         return gdb_get_reg32(mem_buf, env->regs[n]);
@@ -55,8 +54,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint8_t srs;
 
     srs = env->pregs[PR_SRS];
@@ -90,8 +88,7 @@ int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int cris_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint32_t tmp;
 
     if (n > 49) {
diff --git a/target/cris/helper.c b/target/cris/helper.c
index c0bf987e3e..1c3f86876f 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -53,8 +53,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     struct cris_mmu_result res;
     int prot, miss;
     target_ulong phy;
@@ -97,8 +96,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 void crisv10_cpu_do_interrupt(CPUState *cs)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     int ex_vec = -1;
 
     D_LOG("exception index=%d interrupt_req=%d\n",
@@ -159,8 +157,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
 void cris_cpu_do_interrupt(CPUState *cs)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     int ex_vec = -1;
 
     D_LOG("exception index=%d interrupt_req=%d\n",
@@ -262,8 +259,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     bool ret = false;
 
     if (interrupt_request & CPU_INTERRUPT_HARD
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..5213db820b 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3006,7 +3006,6 @@ static void cris_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUCRISState *env = cpu_env(cs);
     unsigned int insn_len;
 
     /* Pretty disas.  */
@@ -3014,7 +3013,7 @@ static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     dc->clear_x = 1;
 
-    insn_len = dc->decoder(env, dc);
+    insn_len = dc->decoder(cpu_env(cs), dc);
     dc->ppc = dc->pc;
     dc->pc += insn_len;
     dc->base.pc_next += insn_len;
@@ -3180,8 +3179,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
 void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     const char * const *regnames;
     const char * const *pregnames;
     int i;
-- 
2.41.0


