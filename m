Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62EAD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytR-0001nj-L3; Mon, 02 Mar 2026 03:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytD-0001j8-Aw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytB-0001Ya-4M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wm3ocIz5yPuGAgAzqL1S37jXenPDu6rAMForht0QG5U=;
 b=K8sv/0WPSi//Xc+wgntrAe782J14femFg6Vi9VvCx3ADRNgyOPg/pg1Jt1UE+05CGaTFpP
 6wvs8bUAFbYcGjxvSUBvMZqSW/CJCXiBDz7E/yOmTZK4gijzZCpMqn0cCEAaYDrP9m5soe
 3K06rdubsfCPeAYZeSJz8lTOX52AmZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-pxzqF27OMnCSKN9iAQ0h5g-1; Mon, 02 Mar 2026 03:44:26 -0500
X-MC-Unique: pxzqF27OMnCSKN9iAQ0h5g-1
X-Mimecast-MFC-AGG-ID: pxzqF27OMnCSKN9iAQ0h5g_1772441065
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so33317225e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441064; x=1773045864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wm3ocIz5yPuGAgAzqL1S37jXenPDu6rAMForht0QG5U=;
 b=ZNxkrc9h2EA0LAUaGHTlzTiAgvI80VrZ6svA9enSshFTULK08Qv6U2Mg4UpI2TZJj2
 KQU/ihljaEdDpHEB+dl5TkrWFM/V0kFKZCrCIafL/rJxKHBZ7iiksZxZ+r61TStXkz7k
 k7L8Egrq6oTWfS+eh2OHTbA7GZgU8/14wAieCZBiQUSO0c/kiqeTc6hNmfe3metbfQba
 cUfOZth8sI+FQUfmfKSVzTGXi7sKNwiybCKzAb1eaixQRHBoxXs3YtSXFULmSn+XfgM8
 40sV+uzsMukCzRErNZTR5OcEB5FhdmWm5ekP5fZQjF7ypqm54PVo9k3ndtcbgexC91zX
 svqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441064; x=1773045864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wm3ocIz5yPuGAgAzqL1S37jXenPDu6rAMForht0QG5U=;
 b=C5gNOEMFVS8WIRbMQsyg37gxOZD8NNKoxZmnzA6kCcHdCc4jZxtUXIFHNQM0H1Sg6q
 8mmQQAdcF0uIrCBHcl3hrynraowg3ix/ZuBKfmS3aQ5HgjtM62kO5L67rNbqM4bHfeYn
 iTeFX5FyXsYaXuWeeVRSe39coBnIthR1rCK74CgjM0EmPa3vq99Tfb4mzy1guA5GLpxk
 SIkJJE+jBllBPFCAG7uUVEEOWU7e/AZtK+KtyqNuyGOtUjueQxGOBXQiA5GZeNbycpbw
 tn1J7ynsYzp0PFdsBsHKtzkOjeXa0MV1vok1QXgxVH8u877Q8tJfxOMPFnNh3n9jV51O
 /w0A==
X-Gm-Message-State: AOJu0YxE3tZ9Lq+2XyLpsAQZJeizRWYQTl8O3xajdPlzCPfgcQ3JNTRs
 s8Hp19zsQqotkjvPDYXIiBtSRtvLCe9b56jNw51DLPn8uxUGaM4yejyf9nGvFaUOauq88WYCYR8
 OAIO6b3upKc3ysnDewSsq0TGIPJNs5E9yRSHgZMk1gGmkc46h8YTDNHCP/qoQHXtoG0fovqntBN
 UGN9v/BGJVHoX3XHrhVW1pN1J8mwLsTFMq8mcz+xGE
X-Gm-Gg: ATEYQzzZoOd8d2l8HrwtaVkbntM6Mim5sJ3GdNlOvp1s1eJe+/craFqdgBEmMIx0N/4
 bUDISxy316Scg8EsXDBMNDUO7ZaKmrObJrRPke+ldMEJLG6lO/fhPZMZMzQavsO/g5x2SMEGHXN
 QjyhuvmkkxfSIQym73XuA8j/xj6yTMCB7Q//cKoOxjFw3rD7z6/UKcwEFclIrH/oB8mJv702jm1
 RrbOel9KoUdXo76eto7qifU/lC81IXwvwTtRKt+wThYft2F3WopxtyuhZAD0AqAJwhk8GTCkJ8v
 /EOWmENLD8n2mR+EXX2m4ZnA19bdjvzEiTKtNPwiVjWegD1HPOiNJMBPW6DQLecIsyPVZe4TCIZ
 vMHDWDTTCWrj/HXjE6aZBrgBToDH0QmnomQdwXSGOSeeurqv8hig7INFF3QE/S7yvK8rh/PN2+k
 f5lrBSjtnUnXt5ki2DSpyifLwu5fY=
X-Received: by 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id
 5b1f17b1804b1-483c9b9eb7amr184465915e9.11.1772441064499; 
 Mon, 02 Mar 2026 00:44:24 -0800 (PST)
X-Received: by 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id
 5b1f17b1804b1-483c9b9eb7amr184465355e9.11.1772441063910; 
 Mon, 02 Mar 2026 00:44:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb296bfsm154969135e9.0.2026.03.02.00.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 016/102] whpx: common, i386, arm: rework state levels
Date: Mon,  2 Mar 2026 09:42:11 +0100
Message-ID: <20260302084338.473368-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Change state levels from a set of ifdefs to an enum.
Make register state loads use state levels too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260223233950.96076-16-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-accel-ops.h | 16 ++++++++++------
 include/system/whpx-all.h       |  6 ++++--
 accel/whpx/whpx-common.c        |  8 ++++----
 target/arm/whpx/whpx-all.c      |  8 ++++----
 target/i386/whpx/whpx-all.c     | 16 ++++++++--------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/system/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
index ed9d4c49f4d..4b2a7326548 100644
--- a/include/system/whpx-accel-ops.h
+++ b/include/system/whpx-accel-ops.h
@@ -22,11 +22,15 @@ void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
-/* state subset only touched by the VCPU itself during runtime */
-#define WHPX_SET_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define WHPX_SET_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define WHPX_SET_FULL_STATE      3
+typedef enum WHPXStateLevel {
+    /* subset of runtime state for faster returns from vmexit */
+    WHPX_LEVEL_FAST_RUNTIME_STATE,
+    /* state subset only touched by the VCPU itself during runtime */
+    WHPX_LEVEL_RUNTIME_STATE,
+    /* state subset modified during VCPU reset */
+    WHPX_LEVEL_RESET_STATE,
+    /* full state set, modified during initialization or on vmload */
+    WHPX_LEVEL_FULL_STATE
+} WHPXStateLevel;
 
 #endif /* TARGET_I386_WHPX_ACCEL_OPS_H */
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index b831c463b0b..2cbea71b149 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -2,10 +2,12 @@
 #ifndef SYSTEM_WHPX_ALL_H
 #define SYSTEM_WHPX_ALL_H
 
+#include "system/whpx-accel-ops.h"
+
 /* Called by whpx-common */
 int whpx_vcpu_run(CPUState *cpu);
-void whpx_get_registers(CPUState *cpu);
-void whpx_set_registers(CPUState *cpu, int level);
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level);
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level);
 int whpx_accel_init(AccelState *as, MachineState *ms);
 void whpx_cpu_instance_init(CPUState *cs);
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 88eef557998..4863fc86631 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -46,7 +46,7 @@ struct WHPDispatch whp_dispatch;
 void whpx_flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+        whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
         cpu->vcpu_dirty = false;
     }
 }
@@ -180,7 +180,7 @@ int whpx_last_vcpu_stopping(CPUState *cpu)
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-        whpx_get_registers(cpu);
+        whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
         cpu->vcpu_dirty = true;
     }
 }
@@ -188,14 +188,14 @@ static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_RESET_STATE);
     cpu->vcpu_dirty = false;
 }
 
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_FULL_STATE);
     cpu->vcpu_dirty = false;
 }
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 0d56e468bdf..bb94eac7bf8 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -417,7 +417,7 @@ int whpx_vcpu_run(CPUState *cpu)
     do {
         bool advance_pc = false;
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
             cpu->vcpu_dirty = false;
         }
 
@@ -482,7 +482,7 @@ int whpx_vcpu_run(CPUState *cpu)
         default:
             error_report("WHPX: Unexpected VP exit code 0x%08x",
                          vcpu->exit_ctx.ExitReason);
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
             qemu_system_guest_panicked(cpu_get_crash_info(cpu));
             bql_unlock();
@@ -516,7 +516,7 @@ static void clean_whv_register_value(WHV_REGISTER_VALUE *val)
     memset(val, 0, sizeof(WHV_REGISTER_VALUE));
 }
 
-void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -563,7 +563,7 @@ void whpx_get_registers(CPUState *cpu)
     aarch64_restore_sp(env, arm_current_el(env));
 }
 
-void whpx_set_registers(CPUState *cpu, int level)
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index baa3169c55c..c09d9affefa 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -367,7 +367,7 @@ static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
     return cr8 << 4;
 }
 
-void whpx_set_registers(CPUState *cpu, int level)
+void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -386,7 +386,7 @@ void whpx_set_registers(CPUState *cpu, int level)
      * Following MSRs have side effects on the guest or are too heavy for
      * runtime. Limit them to full state update.
      */
-    if (level >= WHPX_SET_RESET_STATE) {
+    if (level >= WHPX_LEVEL_RESET_STATE) {
         whpx_set_tsc(cpu);
     }
 
@@ -583,7 +583,7 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
-void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -770,10 +770,10 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
     struct x86_decode decode = { 0 };
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    whpx_get_registers(cpu);
+    whpx_get_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
-    whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+    whpx_set_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
 
     return 0;
 }
@@ -1589,7 +1589,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            whpx_set_registers(cpu, WHPX_LEVEL_RUNTIME_STATE);
             cpu->vcpu_dirty = false;
         }
 
@@ -1796,7 +1796,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
         case WHvRunVpExitReasonException:
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
             if ((vcpu->exit_ctx.VpException.ExceptionType ==
                  WHvX64ExceptionTypeDebugTrapOrFault) &&
@@ -1828,7 +1828,7 @@ int whpx_vcpu_run(CPUState *cpu)
         default:
             error_report("WHPX: Unexpected VP exit code %d",
                          vcpu->exit_ctx.ExitReason);
-            whpx_get_registers(cpu);
+            whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
             qemu_system_guest_panicked(cpu_get_crash_info(cpu));
             bql_unlock();
-- 
2.53.0


