Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9466C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2f1-0002d1-0w; Wed, 02 Jul 2025 14:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ea-0001bi-J5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eY-0002ir-Is
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so178657f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482670; x=1752087470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2PGC0Y3eaTf7CcEogf+cHF/JmHLi48aNNQRIJR2xDQ=;
 b=K9mu5jsyJ4BCrgY1xdgHIDK/9sYQDrjfI3qilzNEpOcxNco2kw8qh7CcWlnM0sg2zo
 FD4uXL9iLLtarB3V3gsl12mM6enrAsrTok3uAU/XYXAzm3c0debvLO9LIfezFFlqKlen
 VyKaetbSbyDSSS0Q/jyVlNM42PxGfyd+OLJuq9EMu/ById8IaU3SRt1JzwqGCvPj9WCC
 cIoqpQLEJzWVm24K6Xxso5LDA6zTKh2uMzi0ngpO5ydzjfDA9rSQKLePKfD0HmcoKE+r
 eiL2W2Ex5jwAt/ENbGtQztRT9rkHcVqhn3PVm2KtzNAY3oq2vfYloVz0oY4NuJXCZN+P
 NNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482670; x=1752087470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2PGC0Y3eaTf7CcEogf+cHF/JmHLi48aNNQRIJR2xDQ=;
 b=DgHLJVq52LWktdYbw8v4l91vUNiltKMZkfcD3jOj8+uPl9yxfO8OgdLU3P+f3L+0UD
 Inai6cnhYx7OhAsZ8Q+c3h4AA6xHAoP9dngvebKTFvzmU3Qyoq3IhP3GuGy0/zadhZWW
 C/LpqObjAA6yQUuF2chnovBcq0DP7g31Ft0VpkKlYdIXJw56To54XBALgW3T4cuUfEET
 k2MHAkcEmMM4oUdBhmCxT2LMR+CIZhtSOHDA5YGuTX+Pfax7oHygeu3Zoo+jkDFrtGc2
 0UBSg4wWn1K9EdVb1ep3Y2T1E2gIjvzFQSmuKaAy2GfMkyMnck5Tu4XGijE770LEiqei
 h/Aw==
X-Gm-Message-State: AOJu0YxzdY7I0Vtu/iwSM3GtKydMoQS7O6rg7OtWeg2hirRqs1K/xaRS
 Y8TO9+Vg53bVsxgQbC3Gv5EJeq76WB6ELadRTYv1QfEqb9S56LSUThZlts8EqTkYkN3wNt4emEt
 9O4js
X-Gm-Gg: ASbGnct+URdWUE43CI09zwQnX1ItKzXmxXCVY8+01w0XIqBGn+zt2q9C1/Cel8GPIsJ
 Seo+chwTTkpnOM7cBifAiex9eLlMsf6UriM+kLXtYcFhDKZhJibK1Qe2H9YAWewea8NGRO8fya/
 +u2G8Yk9udUDj6Lma+E1sVPdHlWI7zwohEZjEL7lpCDN4JbgqZcEmjcVVQkWz2O3wRp6HSs6tDw
 a7cFrdwGJORFrY/vlY+SCTK1rrjF64dfpmISu8u7j3/KtmVuY7piDTe2N4Cnyei1BgeUD1P8Bba
 RuBmYrotbsQ1xAx6KBp0LEJb/BuzQ5IaGdbJ73FjF6w63ERARTmR2p5CvyBGRbYndxhaO5mlgji
 6s6/vNzsGY/1JTPGnj+KevJGmiIWJaBG9V2M6
X-Google-Smtp-Source: AGHT+IHDc80Ra5KK7mfkSwtXkKpYnLTrvdiIpG44mW0X+iHQtrTUYq8fgEeFV0pXqsBFlSMvRn8B2g==
X-Received: by 2002:a5d:5f82:0:b0:3b1:a735:e6bb with SMTP id
 ffacd0b85a97d-3b342440d33mr40243f8f.4.1751482670000; 
 Wed, 02 Jul 2025 11:57:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bead7csm5352675e9.39.2025.07.02.11.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v4 35/65] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Wed,  2 Jul 2025 20:52:57 +0200
Message-ID: <20250702185332.43650-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/whpx/whpx-all.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 821167a2a77..525d6a9567b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -237,7 +237,6 @@ struct AccelCPUState {
     uint64_t tpr;
     uint64_t apic_base;
     bool interruption_pending;
-    bool dirty;
 
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
@@ -836,7 +835,7 @@ static HRESULT CALLBACK whpx_emu_setreg_callback(
      * The emulator just successfully wrote the register state. We clear the
      * dirty state so we avoid the double write on resume of the VP.
      */
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 
     return hr;
 }
@@ -1391,7 +1390,7 @@ static int whpx_last_vcpu_stopping(CPUState *cpu)
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-    if (cpu->accel->dirty) {
+    if (cpu->vcpu_dirty) {
         /* The CPU registers have been modified by other parts of QEMU. */
         return cpu_env(cpu)->eip;
     } else if (exit_context_valid) {
@@ -1704,9 +1703,9 @@ static int whpx_vcpu_run(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (exclusive_step_mode == WHPX_STEP_NONE) {
@@ -2054,9 +2053,9 @@ static int whpx_vcpu_run(CPUState *cpu)
 
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         whpx_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
@@ -2064,20 +2063,20 @@ static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 /*
@@ -2086,7 +2085,7 @@ static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
 
 void whpx_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_whpx_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2226,7 +2225,7 @@ int whpx_init_vcpu(CPUState *cpu)
     }
 
     vcpu->interruptable = true;
-    vcpu->dirty = true;
+    cpu->vcpu_dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.49.0


