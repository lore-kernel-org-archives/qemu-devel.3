Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A966C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJn-0007W2-TL; Fri, 26 Jan 2024 17:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJl-0007UI-Lb
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:57 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJi-0003ea-FQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:57 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55783b7b47aso693602a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306692; x=1706911492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Geu08y2HUryuTkvO9FvgDhonl3J2Z6omRaCFm/Ev3sk=;
 b=PLplYAn86eS4s6l9QxiiOwSEmuilz7CDtnluxQV8rNuMeBPPIhJQwyGhmpPgmA2NVQ
 kFvTQ6+6no3393Q32Hk/kY45SLQKUL6715MSchA5uScG6z3qozVaQv4PsliXQCCezqoU
 pH9P/syc2aSrNt+EJlYektTbutkcjY7writt07FlAVk8h8pojxUknS8I26GCKCUdfAWn
 5XolXAGDAIHy5Xa14RLWM6bcSTril+1wrgXA85YHgVWePud/U0GzuF81W3O4/FLj9nd2
 mmnBUpt+/3gIrllkt6/LGzHA7f8YGZwBjmLz4KdcMLYb3Fc1xbZar06fRDs2zb+SQUoT
 bjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306692; x=1706911492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Geu08y2HUryuTkvO9FvgDhonl3J2Z6omRaCFm/Ev3sk=;
 b=JriT6Z3Gf1C5j09Zh9QvQDvHielRNKM3lwlT3P2EPH68dM9PbVhJfuutEVpFKrpElF
 19E0OhLEShhzB8MvJvUfCtrmX/oeAvBaGX1Q0IUGYG/6kR93qRZ4APe/YeQ00rcpPqDo
 g12zMLI8sDnXdX2Y0zVhTg60txARoV5l/iJ3FDtf4+y1fZd8m3VV23tci+TssUZJs9cn
 SiB9clHxI+nenNXRUmsO4faAn/IH0DL3SUCD77gskdjHGDXTdNV79JAw1Y53rKelLEQF
 OTuOLv2XU0Twn1HRgVJLHBkINrbBVkggBxAvNAdVkbb7bm4oKAoVWKVh6hRt8jonP3mZ
 8B9g==
X-Gm-Message-State: AOJu0YxdruJcRd1LgKOMik0ltA5KGq82/UL/HBRA5uuq1+y60bCsu5CK
 mn0Y6rUbRPEaphWasJe1ykLXbUkhqR3UN4FqElAAgC2Is0HS4ufgqWZb6An23vJikFqtpaqEEGW
 m
X-Google-Smtp-Source: AGHT+IGSE90pXEWL7Cb+erfNLqyRjCQmI09xpCoNPYbEE91v5O4UfayumX9ZrTPlrejsKPpURCnYzg==
X-Received: by 2002:a05:6402:5243:b0:55d:164d:6f57 with SMTP id
 t3-20020a056402524300b0055d164d6f57mr246874edd.9.1706306692566; 
 Fri, 26 Jan 2024 14:04:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 ig9-20020a056402458900b00559bb146ecbsm1011608edb.6.2024.01.26.14.04.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 07/23] target/cris: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:49 +0100
Message-ID: <20240126220407.95022-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
 target/cris/cpu.c       |  5 +----
 target/cris/gdbstub.c   |  9 +++------
 target/cris/helper.c    | 12 ++++--------
 target/cris/translate.c |  3 +--
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 9ba08e8b0c..8ec32fade8 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -142,10 +142,7 @@ static void cris_cpu_set_irq(void *opaque, int irq, int level)
 
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
index b3974ba0bb..a935167f00 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3180,8 +3180,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
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


