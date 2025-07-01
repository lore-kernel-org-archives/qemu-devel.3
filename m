Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E2C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDB-0002lW-TH; Tue, 01 Jul 2025 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCu-0002PJ-0t
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcCo-000754-F7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:43:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so34769875e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381006; x=1751985806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRl+/jVdTWn/SE6FcpjjRNWIdDFt+7efEy/k/a0kODs=;
 b=waVpAmTKk95pCsl8Yf+z+YXm7fPNxG0ChGHwwfJWUOH/WJrm0s3KFO5u95gAM7qgzv
 plEbgS8iLu/svQgYgBtDnHMNB5DhiEaXQC3CyZQ+JO39Q3WMHl1AlXtq88nU5ZxTaQUt
 Zq2EzcqVw57YB9Uh26V+V1RDBSpQcutiNau61ASk9r20jkvL8Ra0OAk77n183bBpSvh+
 9Cg3ABE4FWGiK3x0RJQVW0sJk+GkW5Fc7kErKjhHL6pwhwLgU1zVKqOfEk9CL++z0Mii
 gpk52wnco4BN4BcOST3iVrj2mRun6TZb18JHbcbUGe1hCt6e0CNLf8JBpOZg3HOxzkMU
 7MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381006; x=1751985806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRl+/jVdTWn/SE6FcpjjRNWIdDFt+7efEy/k/a0kODs=;
 b=QQKqQkwlLSEyMHuC9WaPPwhyB7YwnjucGuHMROHcGxVFFLbGgKkCArCS9WQ5X39iay
 tBrMYw6Z/VFHiahaj6kvl2xilRGbpKjMrBbK3kk5VWYtWTuld4lB49IVkeGLbBShxXuA
 FTeQDTw7s03a0VCtmwP4E5dBZyROIsaPPy2JZsevk/CAgOhyAaMBqEBaK+mXYw58R3ox
 /umcf1x2U3+stZ0257CtdWjy/0WeHm5H+Ld6/BQtYRk6BApxNLLUK+JmzAAvcJAT+Er0
 2JvAKb97GeVUIJh/pa9VBGBtrI9h1/7AS8gFDG6KT6BoXz/cliwwZTNE17OFvoIKhutl
 J3aA==
X-Gm-Message-State: AOJu0YyUXnsubcK1iYbkgyjhXym0DheOV8oU5mXJQSMF3MPCOFLMpyk1
 XM15sIqUhzRVbrdnFahmpOO/ews+qsTjWhhb7S6wBdCDd2HI2j2TrChvKRFnG/J5CWbtNhqIYy5
 KIJ1a
X-Gm-Gg: ASbGncsDGF1E37T2edAk5rHkf4H6PgkvhmaN0YBm1dO6BbkXLzyxunsgQbYGRGf8QRe
 6bPvswooVJgxHXlzFC45G99pspJ0L0UnFNYOo8yRjAPLJ12LQ6CLRNuZ8qSNnqTbfYUyrxAo1WU
 BvP02m65eCE5H2Ihl7Kz0405fjRQWl4nUnX4c7XeH5KIUVBVHw5Ow9rBUEdKqedn6FLD5QO1VX2
 uGSY+XfxX41ViDraAe03gZ33gYLub8i2l8iSIUo6JSon03IQ9qybGbRWwOy0MyyhG/XyRMfFAHc
 IaC/fIT+pSJbuMTKh3Q/NtAmxLS8yd56cJkZ1Z9sbMb7MqiYn05owQVt301Bzu4D0ZMTbX+qMBU
 VB2MPMR1ousOK86o0vLeMqUliDjSNoFk/++cc
X-Google-Smtp-Source: AGHT+IFxWp6nbGft+2Udb6trDd3chSg8KN721L6q7FT0sfnWydH1/CQo33anu/jWB4LOlYZ8Ipbeug==
X-Received: by 2002:a05:600c:4e09:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-4538eeb8e0amr207871345e9.17.1751381006363; 
 Tue, 01 Jul 2025 07:43:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453941c67c2sm124253035e9.5.2025.07.01.07.43.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 35/68] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Tue,  1 Jul 2025 16:39:43 +0200
Message-ID: <20250701144017.43487-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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
---
 target/i386/whpx/whpx-all.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 821167a2a77..f812aa36c46 100644
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
+    vcpu->vcpu_dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.49.0


