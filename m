Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F582C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnT-0001RU-2V; Mon, 29 Jan 2024 11:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUm3-0006Ng-GZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUm1-0003tH-Gg
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so35005735e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546776; x=1707151576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPVrCbRU1M9we1PYSP3dETCN8UlJAlkr84+2F+spRWs=;
 b=R5+ccjgyt0wl49flqVAoimHC8H+t6wDZiqg53pkxw77bLkdXOv+Lq+uj9McPAV7rr9
 rUpoi0QqzsJnIGYpgevTsnrYxJjEiy3mjjYcNdgFKuBzid/4O8nPYJbnKwKMjF0m42co
 uuKCd9y7nYCb7fiZJnElwdk5zzDyFDKR+8OVAAjcOOk2BjUJd30T5XPIhha99aBRm0GZ
 RSX60UiZcMBWcnInt+/jMvWP4ukrGPmmris0DIJNIAr9yn2l3MDSm+a1hJwSjN+83Yzv
 9eP03easd4p8zdftsdnRWS5dEwv+PHv4Fqt4vT2uC9Nuk+mEk87HgjkfyA+eZtijQOpZ
 vOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546776; x=1707151576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPVrCbRU1M9we1PYSP3dETCN8UlJAlkr84+2F+spRWs=;
 b=rBH5EeAWLcTW9IR+J8+0x/qrtxhHzIroNQb4jNwRPELulScl4Nxp96dghqj6yUf/wz
 UTeezXxZ9VI2UZM39ayquVKCZO6QPzj+b4xZsNJUCwDJzQx5P1UwEO1vgPecA8923OMd
 gUc3rvy3y2RsCGpYGHNH0ZqVp3RZJwVkY+OQLgDsZJ/UP4W2OdxzD/BX0RuTeSC5B4XA
 vyMqOAH3SNUZK7QEZRsi3BAVQy2a80PsnMLaNY4O1U8+w7O3KTse/UCNEm3rHB5q9vtm
 TuWk8yXJ1uhCW3o4chfOtNUIdyx8mkh9WAKUB1wTWSP9ESeU58TvW1A1lt8yi9ESUGuP
 aeNg==
X-Gm-Message-State: AOJu0YyYTveY1awh3owfByn0ZrhaTgMUVP3TSx+SKIxdyXO/JrVNACQH
 TnsV0mYZNrKBNrHMfhrYVoTvYjNUFVEf3saxJ6wifD/Q9sJdAHrpBztrjUoeVVb2AbRriWJPwCW
 b
X-Google-Smtp-Source: AGHT+IGoyi1GJloWLT4o+Y6UqAMpV8DbzJbKaJW69srVFEf22YWTwUw/j8yDRVynsB1cqMzyP4ftLg==
X-Received: by 2002:a05:600c:35d5:b0:40e:af40:b4da with SMTP id
 r21-20020a05600c35d500b0040eaf40b4damr6044761wmq.26.1706546775871; 
 Mon, 29 Jan 2024 08:46:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c451200b0040e880ac6ecsm14562416wmo.35.2024.01.29.08.46.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v3 09/29] target/avr: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:44:51 +0100
Message-ID: <20240129164514.73104-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/avr/cpu.c       | 27 +++++++--------------------
 target/avr/gdbstub.c   |  6 ++----
 target/avr/helper.c    | 10 +++-------
 target/avr/translate.c |  3 +--
 4 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 0f191a4c9d..50ded8538b 100644
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
diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..682a44139e 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2657,11 +2657,10 @@ static bool canonicalize_skip(DisasContext *ctx)
 static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUAVRState *env = cpu_env(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->cs = cs;
-    ctx->env = env;
+    ctx->env = cpu_env(cs);
     ctx->npc = ctx->base.pc_first / 2;
 
     ctx->skip_cond = TCG_COND_NEVER;
-- 
2.41.0


