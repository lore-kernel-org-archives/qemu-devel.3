Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8548CC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJj-0007Ts-MX; Fri, 26 Jan 2024 17:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJh-0007SG-5A
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:53 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJd-0003aU-4i
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:51 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso1640828a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306686; x=1706911486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRDZsAVCeKNjeYo+uMKOWsXHzCtDJO1BqKvym46fO1w=;
 b=TG0oCGAGzJNoaMwDv2FF+HvGLAIGODlNgjljyRTn7XHRyoiShqWxeM0Qgd6TAzZaZV
 +IG455b4Z3zMOLIDmTFqTqRLYVR1OnAvOT4CRI1Pei5EULPotO2TfnNwykW1Mm4Aurnq
 4s+WvyDnrUeaGc6+JAxfijb0uEPvVnh6ZJFDwLAQ7ftHtkvuSJzd9PpuDlyU4oORUFxW
 RO7aenXbJ/uhEYVjGyS8IfHqmm6kfZ5zmKD6BetsenoSxc5AeSt1ODVnHsZC+3OvImGe
 M+NXlYbmRTMu3g49mtsEYczCY+69A+jkfCgFK9MbQlK0q66sR44pnJyZdizyJObWgcN2
 7ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306686; x=1706911486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRDZsAVCeKNjeYo+uMKOWsXHzCtDJO1BqKvym46fO1w=;
 b=tCXgai5WXsm8GkK3LDgLeBbZiFVYwUilEpIscffKhcixBn0TcFPRaA071d7OvTes6v
 MdFYGkOgPU+e2oS44ubyWKSMk+oKss86yjkmOeJ8XDGMTIs5DynoBdleemdkmS0z87ru
 2RhIblX7ws4EuG5wSDCJrheYiXgdEQGIXAEPQ1RmiFiFED2OPbuCL01gQcaj7q3LJzjK
 jd2NNBRzX3fwrXdmctukzyCu1SFri7ylJIoEanaE+qso3Jak4yOoRknK15g8fiv8K1L0
 Odp7fdLv8odcLz+ZPaRGfwaAgYskPsaY2o2+GGSLdXyocxS/iX+JmQ21drPCgFWfOK0l
 mphA==
X-Gm-Message-State: AOJu0YzasF64ogjr9CoLZJd7wX01ZCbt1KMPAZJ+0tEIPc8sOYOyKIzT
 QszhSaayRj0ewmb8TW7oVA14HTpW9zsKjy+j+y9pLLsMhpm5RXVh8DxyF/9cr7GfhGizsNroQqN
 1
X-Google-Smtp-Source: AGHT+IHTfEcgSksuOIIKpp6/FxDzCiCmGegHFfvtO9Oagqe7Xe64Ye3dgCpZ2GcKkkqpkEKaxO5XfA==
X-Received: by 2002:a05:6402:22cb:b0:55e:b1c2:3939 with SMTP id
 dm11-20020a05640222cb00b0055eb1c23939mr48980edb.37.1706306686644; 
 Fri, 26 Jan 2024 14:04:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 er24-20020a056402449800b0055a82fe01cdsm1008665edb.67.2024.01.26.14.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 06/23] target/avr: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:48 +0100
Message-ID: <20240126220407.95022-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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
 target/avr/cpu.c     | 27 +++++++--------------------
 target/avr/gdbstub.c |  6 ++----
 target/avr/helper.c  | 10 +++-------
 3 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f5cbdc4a8c..2ad24373a8 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -43,31 +43,22 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
 
 static bool avr_cpu_has_work(CPUState *cs)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
-
     return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET))
-            && cpu_interrupts_enabled(env);
+            && cpu_interrupts_enabled(cpu_env(cs));
 }
 
 static void avr_cpu_synchronize_from_tb(CPUState *cs,
                                         const TranslationBlock *tb)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
-
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->pc_w = tb->pc / 2; /* internally PC points to words */
+    cpu_env(cs)->pc_w = tb->pc / 2; /* internally PC points to words */
 }
 
 static void avr_restore_state_to_opc(CPUState *cs,
                                      const TranslationBlock *tb,
                                      const uint64_t *data)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
-
-    env->pc_w = data[0];
+    cpu_env(cs)->pc_w = data[0];
 }
 
 static void avr_cpu_reset_hold(Object *obj)
@@ -165,8 +156,7 @@ static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 
 static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "\n");
@@ -276,8 +266,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
  */
 static void avr_avr5_initfn(Object *obj)
 {
-    AVRCPU *cpu = AVR_CPU(obj);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(CPU(obj));
 
     set_avr_feature(env, AVR_FEATURE_LPM);
     set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
@@ -305,8 +294,7 @@ static void avr_avr5_initfn(Object *obj)
  */
 static void avr_avr51_initfn(Object *obj)
 {
-    AVRCPU *cpu = AVR_CPU(obj);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(CPU(obj));
 
     set_avr_feature(env, AVR_FEATURE_LPM);
     set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
@@ -335,8 +323,7 @@ static void avr_avr51_initfn(Object *obj)
  */
 static void avr_avr6_initfn(Object *obj)
 {
-    AVRCPU *cpu = AVR_CPU(obj);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(CPU(obj));
 
     set_avr_feature(env, AVR_FEATURE_LPM);
     set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
index 150344d8b9..2eeee2bf4e 100644
--- a/target/avr/gdbstub.c
+++ b/target/avr/gdbstub.c
@@ -23,8 +23,7 @@
 
 int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(cs);
 
     /*  R */
     if (n < 32) {
@@ -53,8 +52,7 @@ int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(cs);
 
     /*  R */
     if (n < 32) {
diff --git a/target/avr/helper.c b/target/avr/helper.c
index fdc9884ea0..eeca415c43 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -30,8 +30,7 @@
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(cs);
 
     /*
      * We cannot separate a skip from the next instruction,
@@ -69,8 +68,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 void avr_cpu_do_interrupt(CPUState *cs)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-    CPUAVRState *env = &cpu->env;
+    CPUAVRState *env = cpu_env(cs);
 
     uint32_t ret = env->pc_w;
     int vector = 0;
@@ -144,9 +142,7 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             if (probe) {
                 page_size = 1;
             } else {
-                AVRCPU *cpu = AVR_CPU(cs);
-                CPUAVRState *env = &cpu->env;
-                env->fullacc = 1;
+                cpu_env(cs)->fullacc = 1;
                 cpu_loop_exit_restore(cs, retaddr);
             }
         }
-- 
2.41.0


