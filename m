Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA9AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiE-0002dc-Rc; Thu, 03 Jul 2025 07:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfb-0006iL-JX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHev-0003Qw-4W
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso55567535e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540355; x=1752145155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2PGC0Y3eaTf7CcEogf+cHF/JmHLi48aNNQRIJR2xDQ=;
 b=nZWfx686kvmsX77lvfJlKaihR2mXNxeRgqVJGAXrcHNwxkDkycXv1RzTLuf1sq8V3k
 /XTnrABOSNcFMSx8I2AVHeEWyWGj/djgn3nUhcuozANTviUSo2LY2kN+zUlIY4Mo0pcy
 b450Eh4wzjKe95RQmwo3mGwpqL2Qg+v4OZaaib0cU7u0EO9iFqN4zQ1pMaABNYx/qPR4
 uLcp+SHGRDwunQQtPydjBv4tHBIiDU5mwmJ17CNs1+HFgbSSpOpbmOOOnYRu+AIfrs4L
 ensPzOalH6Cxl1Yh6mIDkmAirfUvjyBUrK1k1ebshBW0vaSxHBkZlHImHUO3UgatvtCs
 6eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540355; x=1752145155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2PGC0Y3eaTf7CcEogf+cHF/JmHLi48aNNQRIJR2xDQ=;
 b=Y+w6tSfa1fdKXWSIejoYwu80NrDj9VDpnLRlsOqmBIkZ1x0VP5st0RknjwgBAOq3Xc
 4fDqhd3ULX8QGoNrSOvwUWBj07cL5dbncLPGTp5G2Sb+p525q3Adrs1AQGTXW/mhWR79
 9fk4rVYzxWd6WZjV5jMDTVCcupt1peEoyU2bXjmA8cX0Uudx+HeVqPWimkVd5rXd0Puu
 BHzllL7xFO3NVZR1GJilBgeK+myq7vkMSsoAfSTi27+zAC7r2ertd+CHOQ07tZVTZsy7
 essiD0g8bfdwD4eL4mKKh0Sr0/9OKzg3P2ip/sN/smGpzj8kNRCjlilUkJ6sOZ8460CV
 YLUQ==
X-Gm-Message-State: AOJu0YxpAG4RKXBmATnG3eu59o9C5P6phzOBMsgALACeCt2EbDP63JpN
 AbQd7q9m7uXC+tXRC5mjoXlkU6rZOIkyLYwPMuC8wk8AIi2bP2o1s3cF0kiNjxYsO6jl17NGMxe
 Y0pfIJhk=
X-Gm-Gg: ASbGncu5r1gWJ+60tImk/DkR6ql81jLDn08ixtGvT3T0Z3KVOCQBvkUCexe1O18z+V2
 96P9CJLJPAsDXoPRpcVkXMJ9/GLb1TZp7Z0ZH+Ee89ij1tyTj1ZgCWZD0IETgdCDfTFWRC4XqzS
 lrbBG3UaBH4VpsclEzxCi7I47ovvxDQEctdDqcbR7kqf73tp743crHVhq3Cs6xIffw+yCv/rSEp
 I/v4dYMwnkPB+YvyQcdHnIrkLhscc+Bg5Ck/iTTnSJaR4WpBCPfdu4koAyu68De2fjQCc9vuLjv
 hfw+mp/RVKRDsCBDZ9ZoNprfyGUWNse8Ivs8duGibuhKqezQHClTcQfJTNTaN5H7Qq6ZwU4kLbT
 rmebirBN0nik=
X-Google-Smtp-Source: AGHT+IEH6o23glPnSWgzT4Tyu2nuEfx1ONAPjD27xNsoZIhGywDOzMfGFQguEoku/1mG8S0e1h6Vxw==
X-Received: by 2002:a05:6000:2a88:b0:3a4:fcc3:4a14 with SMTP id
 ffacd0b85a97d-3b200865a3bmr4148920f8f.34.1751540354778; 
 Thu, 03 Jul 2025 03:59:14 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7524sm18507619f8f.12.2025.07.03.03.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v5 40/69] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 12:55:06 +0200
Message-ID: <20250703105540.67664-41-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


