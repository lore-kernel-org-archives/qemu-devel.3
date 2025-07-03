Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9BEC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNq2-0007qM-Al; Thu, 03 Jul 2025 13:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpa-0007Lt-Q6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpY-0000p7-Rd
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so606335e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564078; x=1752168878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyTjZz7bBnxk9ld1sqElOmPl+Sebl+xEl5P+valYmlY=;
 b=V+qBZRDNXROM56SdOJo5Dy24IKYJNnPYXRT1LxAZwWjeyd50jITmNWpgB0S202uPsJ
 UqR330aKGeTwhIbc2WmarTwZzMs8A2UfyvnnKaXoHCU3On2lxmOGJDx2Wnb9kDkrApu+
 ESwfo/xPnlKeJ2Ti+9iE6pRyCVr1XBJQCfgaHLblhOEan6zQ/36m8IQrcI2bcVkPULGg
 uXbPDRh+LGr/o9i5L8QgLwhPzKHWWn9ElURPOmgJ4IWE6i9S1JmAX5LuDtOdP/1Tooo9
 OD/Qo/Us14bvURPft7Wf/R6wb3cTuFTK0cQjst+GN3niVyVuht+l1k6LX2NlaBAguFTu
 kGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564078; x=1752168878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyTjZz7bBnxk9ld1sqElOmPl+Sebl+xEl5P+valYmlY=;
 b=U+2fnxaiarWsLZB18zrLHu5yjOAFGyBiC+bEO844jFwZui17z9p6skMcUVv+ctkdkB
 sEE7Dl3fGAqVNdXSJO/QEBiWz1xokrDXkZMyL2gOe0sT/am7iL3cQgjYMx9WjYHxTgNU
 V+dCVx9PjxYMvprWjLTPFEbPW+PQDkGP/EwTAevUh+NUtaQ02tooZmG9Im3EkTcAOszZ
 k+C1IOfZ96AczPixUyW/yLL2Ejdet4qhaaTFmYsG38j0ewg+X3rbVtrrrKbIDKJxn767
 keQ0edgAtpFu3Ib6NUsgXLClEAV/t8L1rvqLqCm/peVy2cxAaCL7faHI0ruFBJ6Sah0u
 WpIA==
X-Gm-Message-State: AOJu0Yw8giqv2SzwE3GvTsHO1gnMGsIuSA56ioqHKd5EXGDR0AsXWEdE
 cFaIYCBe3vkvZuIX611SVXgtg9FT4EhWZAmCz2zaAaviEW2OIVhkfYh3Uh9LAjp8G7g0kCropHd
 WxHBshJI=
X-Gm-Gg: ASbGnctcO7R+wveVY0p2v9GcSTH+bWlpqMgm7TtOy/x/q4V1OB9uY6804+4GNMYicgS
 XCt/BbxJ7vkIfI5JvkVtdH3AnNOOdZTzS12D9HAw4Ywdm8IztxthItA6skoNuWrecCaDuyvowoV
 6fFhEMRWFMRTeOEu/7zJkDIMFiaGd1rQ1xZh2CxFxlwew3RdMe/0rWcEslGVa3+0AT4MGd36nQD
 spIFpHEu3WdnxfAgXoVw+nDs3JzVJhUf8GNZCWrAtrXz5PGVvB5fJEST0LpbQrIUgCoRsSXQ5P/
 GZs0R3uLz2Si1dDyXgYPyZM1V71GLKAcPEq8KriOWHi1x+ebjZFccxfs5dU3dw0vfAbKbQLzG8c
 reQQNTBY58cEb3ZCzFFLYpYHVxGZtKleOaisU
X-Google-Smtp-Source: AGHT+IFAJHwkgEpIDo3r/dndYw9yiQ+ExEG0BWMSJ0UFCuvq5gnAH+1qx0/80wXcTMZ+W44NRh6H1A==
X-Received: by 2002:a05:600c:4e90:b0:43d:fa59:cc8f with SMTP id
 5b1f17b1804b1-454a373b017mr79001095e9.33.1751564077925; 
 Thu, 03 Jul 2025 10:34:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285dc08sm311401f8f.98.2025.07.03.10.34.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v6 20/39] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 19:32:26 +0200
Message-ID: <20250703173248.44995-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index cf6d3e4cdd4..5001afad3a7 100644
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


