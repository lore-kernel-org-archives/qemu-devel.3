Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54114C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLU-0002Sr-Ru; Fri, 20 Jun 2025 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfL1-0001xN-Gy
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKz-0004X2-Px
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453636fa0ceso13441755e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439736; x=1751044536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1GTaYWZywYs50lh4vOEbx7myievIbwu11g+y0nMdhM=;
 b=nwdgGG3DWS3cZP9/llzzBu3rgZVkflI40qqWjdyI1gBwHYrNN43jRyAVZbfJxIA8EB
 X7x55dudBUcaaVVtQxUd+fvO9Z1P4vuAiTQvkHMN3Zeeqry2Xp3JGvwlFN27Tf8dMCY1
 op1cdGNTlzF8lBrVDNh6mg2gHdLq42/vDbsfG3Nk7hN0ZTcBUDQXKDMV1+JPErEhN38B
 WN3xkv1jcK19/gTGfeeXaXa2IFcCLCOGQEj0mSoqoJcRHhGG9x1ev/nsUc0nta3wwqbk
 DfevQvCDZ4GrZfYAUFwJli0NliwfcSR7uGuC5vNpEV1aNIFn7wStkijd34U/RSVa3Z24
 CLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439736; x=1751044536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1GTaYWZywYs50lh4vOEbx7myievIbwu11g+y0nMdhM=;
 b=hkgVP4NazHqcg664wxgF1E2a5pdfGMwanAJQ0q5LbMnKFYf4LyCwkksiG6GRRgvZQR
 l0nO6nFGOn1571V23oAiXf2EgYmBOgmpSPkR1bDsy67zGIjwIggHmebMMfA0db0QQZve
 7V7LNpNN5YCAmw7eB9GWJRVUDBaZSE7rrZ2WXtfDBoUl7FGjSGmCypHl9lLiCNPMczEZ
 lyuiTlqoGjJwAX04hK4j540YPPTWFzpeq0801D+Dnjb0nOR35tJNcWDh9Kk5swfNKBmG
 mxz9GKlY+S7C0K0kpW1phm/IcJZJ3XUv6VR+vC/1eyxT33yrmcS9ml9el+zEqsjscu0j
 frNw==
X-Gm-Message-State: AOJu0YzvrUV17SvAjGLWFmQByOVZwsPsYDI7VAyU29rpV6O7qs9lQitr
 yv9ohwIAYAMPyvQ4u9Iu0lWWgpTlL0RkMbzKahmUdAXBNQUDTj6k4D87GZfNkM3qJAYf6CJE1EG
 0t13GQgc=
X-Gm-Gg: ASbGncvaF5BV5X16RoqDJHK5MkQZzksz/f4aU3wHp5ZPVb4jIHCAIPCiTDOYP+wZUSO
 cy2UK5iuMpXq29GPqEnQVOLvpmvFl9aSc7avFBe8AzVgqSVBJvpIi6RbcRENptzvEDyyut5oF2y
 Lp+EHd5WTmkuqVrCtCY9k8WCXzuJyu7/sNFV7QHJuNBeX98g4uixC6zLOsB8Ya8ym9jgp+83LBV
 PQ7S/w/ksvmTdLAPTnMe4nmy0L1frg5HerVDvloxzHxIT8oIcGSb9Xn12NVKS0MCnm3jwEGs6r5
 rFal2v5dkWaYVUyJCG6Z03K0mDH8Eh5n/Yphj4jWkPpDNa4y542JuzGC9gel4j7HhEhNFZjLbws
 BIfQz6AzcoC4IRASorkvmtO98wUlMJgVtiYjP
X-Google-Smtp-Source: AGHT+IFfInKkCzKKTIR5f5ept0GOo3G3ayL/Xre2dZ0OUuZHrfen7pkETN+jF1IjIvozwx075zg1mA==
X-Received: by 2002:a05:600c:4f8a:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-453659f5049mr32473875e9.33.1750439735704; 
 Fri, 20 Jun 2025 10:15:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f105efsm2630475f8f.15.2025.06.20.10.15.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 23/48] accel/whpx: Replace @dirty field by generic
 @hwaccel_synchronized
Date: Fri, 20 Jun 2025 19:13:16 +0200
Message-ID: <20250620171342.92678-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index 238c3b95c6f..77af84a87d4 100644
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
+    cpu->hwaccel_synchronized = true;
 
     return hr;
 }
@@ -1391,7 +1390,7 @@ static int whpx_last_vcpu_stopping(CPUState *cpu)
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-    if (cpu->accel->dirty) {
+    if (!cpu->hwaccel_synchronized) {
         /* The CPU registers have been modified by other parts of QEMU. */
         return cpu_env(cpu)->eip;
     } else if (exit_context_valid) {
@@ -1704,9 +1703,9 @@ static int whpx_vcpu_run(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (!cpu->hwaccel_synchronized) {
             whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
-            cpu->accel->dirty = false;
+            cpu->hwaccel_synchronized = true;
         }
 
         if (exclusive_step_mode == WHPX_STEP_NONE) {
@@ -2054,9 +2053,9 @@ static int whpx_vcpu_run(CPUState *cpu)
 
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (cpu->hwaccel_synchronized) {
         whpx_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->hwaccel_synchronized = false;
     }
 }
 
@@ -2064,20 +2063,20 @@ static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
-    cpu->accel->dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
     whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
-    cpu->accel->dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->hwaccel_synchronized = false;
 }
 
 /*
@@ -2086,7 +2085,7 @@ static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
 
 void whpx_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (cpu->hwaccel_synchronized) {
         run_on_cpu(cpu, do_whpx_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2226,7 +2225,7 @@ int whpx_init_vcpu(CPUState *cpu)
     }
 
     vcpu->interruptable = true;
-    vcpu->dirty = true;
+    vcpu->hwaccel_synchronized = false;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.49.0


