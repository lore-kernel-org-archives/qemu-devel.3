Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE2CC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUKb-0000ov-Tu; Fri, 26 Jan 2024 17:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKD-00082B-NI
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:26 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKA-00043L-PD
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:24 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5100cb64e7dso1320421e87.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306717; x=1706911517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woNcbihCgyljuhpYMr+Cr15jve2C8HR8mCIZjTtoatM=;
 b=gF2YX61PLXLmtfzxzgXb6aQWR5AHsmxVTZ49bZ8AvKD6/E31T5IhZnA9/U9mw5Chr+
 RYkiP2Mvn4c6tt0AwmDIUnnoXITvRxwpbKEm/glKzd/q2Vujzr2u7v5jvNCFjMmnHQpf
 uyj6NQ1ymF/rgN7nBu8jQrCJgPT5pIwZoApwik0RkV6nsBEySP6xWVpkWDOelvktMAxU
 SIwDBq+xR6yoFz9xqxKRAgm9JyNBOf3RuP52TA5X7J3kRfPoK3NDdaoklO1z33XnjgTU
 7Ju5VFduRH+21+99hxDCIix4++9TS2vS8c/0dI2JxAhX94G4j3slrMjk42NeLR6SADYZ
 HUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306717; x=1706911517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woNcbihCgyljuhpYMr+Cr15jve2C8HR8mCIZjTtoatM=;
 b=cBVwNzV/al3CMZccC9asUijXVh8jzhaOr81U5OT5p4nXq4q46wsaJQn/+oGxUBLeol
 gE0X+Y86KZ4XFFiq3ZCqjv/W/0WT21eq+Di8DKJuzX5A508BDmHshjFEa0e4ON5C8OLE
 YwWhK7LxJ3Vbp1yr4xxm7xBS11/JsK2Di6UcWPx0d63bWR7FDHAEhPllQ+RkIYh78yNA
 3dTZF1x+iAEJas5454r8ncSZSFaB9Fuh9fPXUOD4l3UL+Y9Vy2RZNYbBAxxli8Ui4L2n
 OWVzhlczhyXrpj9bMSw1pCybp0KqRcsjTpxrVQBgZlahN67nfHT4WwKRdgIXhqESUp2n
 aOjw==
X-Gm-Message-State: AOJu0YyM+Y+fDHHosF1wGcSzMuTYeUUfrY3EqnvucDvuZUxltROiAypq
 0rEUH99cFsjlAllsL6Cq/iTx0SkJwbdhEMuBwsbnLucXSsuBXxffrosUKcj5lGth2gBp6Z2EE9b
 h
X-Google-Smtp-Source: AGHT+IGEfUSbbgqMLQdvSJbtXPFqUYX6PGTjtPfy/2qbsLf9jCgJGYcSa5vmpQHmXErBdW8QamwwYA==
X-Received: by 2002:a2e:8ed5:0:b0:2cc:e9e6:e451 with SMTP id
 e21-20020a2e8ed5000000b002cce9e6e451mr172509ljl.86.1706306717285; 
 Fri, 26 Jan 2024 14:05:17 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a056402434100b0055d1d0b4a4asm1002967edc.18.2024.01.26.14.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:05:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 11/23] target/m68k: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:53 +0100
Message-ID: <20240126220407.95022-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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
 target/m68k/cpu.c       | 30 ++++++++++--------------------
 target/m68k/gdbstub.c   |  6 ++----
 target/m68k/helper.c    |  3 +--
 target/m68k/m68k-semi.c |  6 ++----
 target/m68k/op_helper.c | 11 +++--------
 target/m68k/translate.c |  3 +--
 6 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1421e77c2c..c122fd96fb 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -117,8 +117,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char *cpu_model)
 
 static void m5206_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_MOVEFROMSR_PRIV);
@@ -127,8 +126,7 @@ static void m5206_cpu_initfn(Object *obj)
 /* Base feature set, including isns. for m68k family */
 static void m68000_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_M68K);
     m68k_set_feature(env, M68K_FEATURE_USP);
@@ -141,8 +139,7 @@ static void m68000_cpu_initfn(Object *obj)
  */
 static void m68010_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68000_cpu_initfn(obj);
     m68k_set_feature(env, M68K_FEATURE_M68010);
@@ -161,8 +158,7 @@ static void m68010_cpu_initfn(Object *obj)
  */
 static void m68020_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68010_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68010);
@@ -192,8 +188,7 @@ static void m68020_cpu_initfn(Object *obj)
  */
 static void m68030_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68020_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68020);
@@ -219,8 +214,7 @@ static void m68030_cpu_initfn(Object *obj)
  */
 static void m68040_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
@@ -240,8 +234,7 @@ static void m68040_cpu_initfn(Object *obj)
  */
 static void m68060_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68040_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68040);
@@ -254,8 +247,7 @@ static void m68060_cpu_initfn(Object *obj)
 
 static void m5208_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_APLUSC);
@@ -267,8 +259,7 @@ static void m5208_cpu_initfn(Object *obj)
 
 static void cfv4e_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_B);
@@ -281,8 +272,7 @@ static void cfv4e_cpu_initfn(Object *obj)
 
 static void any_cpu_initfn(Object *obj)
 {
-    M68kCPU *cpu = M68K_CPU(obj);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(CPU(obj));
 
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_A);
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_B);
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 1e5f033a12..15547e2313 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -23,8 +23,7 @@
 
 int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     if (n < 8) {
         /* D0-D7 */
@@ -50,8 +49,7 @@ int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     uint32_t tmp;
 
     tmp = ldl_p(mem_buf);
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 14508dfa11..85f3cd1680 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -894,8 +894,7 @@ txfail:
 
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     hwaddr phys_addr;
     int prot;
     int access_type;
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index b4ffb70f8b..546cff2246 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -77,8 +77,7 @@ static int host_to_gdb_errno(int err)
 
 static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     target_ulong args = env->dregs[1];
     if (put_user_u32(ret, args) ||
@@ -95,8 +94,7 @@ static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 
 static void m68k_semi_u64_cb(CPUState *cs, uint64_t ret, int err)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     target_ulong args = env->dregs[1];
     if (put_user_u32(ret >> 32, args) ||
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..851cca640d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -441,10 +441,7 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
 
 void m68k_cpu_do_interrupt(CPUState *cs)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
-
-    do_interrupt_all(env, 0);
+    do_interrupt_all(cpu_env(cs), 0);
 }
 
 static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
@@ -457,8 +454,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     cpu_restore_state(cs, retaddr);
 
@@ -511,8 +507,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
 
     if (interrupt_request & CPU_INTERRUPT_HARD
         && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4a0b0b2703..9688476a7b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6108,8 +6108,7 @@ static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
 
 void m68k_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-    CPUM68KState *env = &cpu->env;
+    CPUM68KState *env = cpu_env(cs);
     int i;
     uint16_t sr;
     for (i = 0; i < 8; i++) {
-- 
2.41.0


