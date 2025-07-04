Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC39C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdST-0006an-KO; Fri, 04 Jul 2025 06:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSL-0006Jx-3e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSJ-0006iL-2z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso317889f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624141; x=1752228941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1AkDLUIDoYeXz0B32G8TfwPxxxgPR7nn1gNxi5L7EiE=;
 b=luB5qGZdVDPgIsl+7jUuczhATbx3bWzkJgskPN5yjr6DHxo15sQSdTGrmEBBLrrTQe
 ABZCKcjZD3NcA89tLvk7VfzVn4wZkfSGjn/DRdml6I3N6RBc/UwZFDlxk/zFX6C5tuuv
 1qx1LWRv+GFbPYFAhH+e7Ntj2gKwM3JZARmS5PYZlsXLxtzKP3DpPWJ02/bZQgBeucnc
 5WqnwRZY5igM/hSeToNCH/wsbb9ag9MRKu4ut017j2azLaeQ9RQMpARKZsBXhth5AHaD
 wji1TARgruFQxBENwn8Z2BaLfnfqv7qGTupQn3J6rbr99rUYo8jqaGI9QU9j+bvHb2JK
 gufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624141; x=1752228941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AkDLUIDoYeXz0B32G8TfwPxxxgPR7nn1gNxi5L7EiE=;
 b=hn6E6uB828An5Off6zYkFCcCmVY82FOYImgf04cKSR88zhEDTJ0Ow+/JmQ+JcXsovw
 WoL52iypgff8IdKe9LjJVTGHf+c7Bgsaixhe+Yz4c0BY7g6Yt8OxAbi+gxgKGTIgwynt
 VYiF0qyZg/m8/+AJPMqldGQREljyvPd6qgU1OiY3unAIjJq3J2EpmZHKoCpJ30i6SB0R
 npjXZ1O7lXuBO1fwBMX7MrFeeaYq/5Ximti7yOYurO7tBlrv6UDMsqTKi3m2OM3myMWI
 C814nMNpS+8EvJydY4jrgh/wjznV2tQePkYleIqmR55gCSv0MG6OL9k8xQ5TQd2ob9Ef
 dXXA==
X-Gm-Message-State: AOJu0YySYg1sc0tllbkSWJRaFFpoct07rwn29q2t8GxBJA4aAbKgQk2d
 Vxk7McXvV3642PBN+1p8/MQBwuWPWoo3YOZE9o9AfaSq8kvOuKwZ1AgRUtoTGyT8/vPoLVkIdQD
 Wmy1FNe0=
X-Gm-Gg: ASbGncs8gIfzHtZPPsasfH1oVSWW+PJ0YgUejlIutpQXAMAOdPuggjJQksrf1Qu6OlC
 Pzd2sV60vuKalnd6wMG27JMVCbfKF93sOWw8fTnpeoWw4YakpO3eonLKfc58Gpt5m8Rt1vFsaAw
 mpIXe+9Xj7AXqEBrTVp++en6ytySGqOyWbCxDfaEHf7DBUz0ct8ekBgang0vhh7p1mpaGoiO6QC
 Vel2RXwljxWJOZh88oRct6PDPQyxqmBjX8ccoNbUbb3yq22HSSBHv7ODMxmvjBTLCXE5oQ2Xjni
 Pz26JuSbNIBKXvv3vxBBGm/clT07uDUafqqjPsnEgAuIs6JPjJRQ7w4nTaXH/kt/IuWsIJ+qQJt
 Uj/yeInnBu3giiyisvplwyYrBnMaUuWZmOGbC
X-Google-Smtp-Source: AGHT+IG/HgEBUTT88wK7/BwJk08r3jrp/DIfryKaaz82R3YFViYDpBq5guH0biNJQtynZlyqTdT4lQ==
X-Received: by 2002:a05:6000:250d:b0:3a4:dd8e:e16b with SMTP id
 ffacd0b85a97d-3b4964d4079mr1364888f8f.20.1751624140864; 
 Fri, 04 Jul 2025 03:15:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1698f54sm22234415e9.33.2025.07.04.03.15.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/31] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Fri,  4 Jul 2025 12:14:15 +0200
Message-ID: <20250704101433.8813-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-21-philmd@linaro.org>
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


