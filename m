Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038E5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcBd-0007hl-Gv; Tue, 01 Jul 2025 10:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBU-0007Yf-MJ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBN-0006xk-Eq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso10931255e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380919; x=1751985719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvHH8ESXc2uoylBtlyeI37L8kgeEqdtaN6TEVZK1w0Q=;
 b=m5e8R6kogPLxePOEQmuF2Te8CiUMMCLbydjRbN/8vySBemYUZFmobxeNvhMajS3wRa
 rZuWOy0scgEeQy3vSz48myRZHUtVFE1c7/kROSy8qKFsSGmIek/Af0lKTwBjybo3W6Py
 mO6kA1Di3X+jNNbAL/OEkbhZKD7I+VImQzGQmijfRaRKzlwn4MYXroe59nLTbed3rAgJ
 gEcMoBo4aX+qzxIF6hdSziUnwLMUUieNRDXNIaZgoj5nQyk42E/MQXtUPQmVDSa61s8a
 mhvBhbFMiVX4o8azFgsSSLYuXnfODuv9H3onDHFqDAO8l57uS9jSjSzyzIXjMljm+K0D
 KHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380919; x=1751985719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvHH8ESXc2uoylBtlyeI37L8kgeEqdtaN6TEVZK1w0Q=;
 b=UoVQNX0EnF/UB7UKGWiUhVI2sZoJIUoUxmugu8xv3yyUoYjszuSdkSP3PUE5SS0P8H
 SBYx3VVPaSA/kimPdHiDo9WiqrOBPuWsznJZ34uTeOYb9Zmso6C32LoylRzFT1tFs48A
 zX09TzwFND/vTSCxYiiStCGEoULX0KyQRbr6Zg0S5sYrf+DQ9VWOuGyJ4wwwj5IO+kpJ
 +VztDDhG8GoHqoG/dkUwKaUHs/rRdRLwHnhiMSuN08o/rVyRyIeJO0TTskF/75GdVoRl
 PxoKo/VubmluN7JcaTC4iKRJGfn4fDh8YBIK8cHcLdBmv+Qn1D3iYuz4yQXKyX5NgWi+
 dpeg==
X-Gm-Message-State: AOJu0YzydTGvLMmhq4RACzdT6RCFTL1kCiYAw12s5KuSP1JjhB3GXrkR
 xvIWRSKiTuddt1ua/2PWJpVARRL1XS5w9f7055sDH5bhjqRzJwRForxtYudc62HmXYOHfYoEiy0
 VKyZn
X-Gm-Gg: ASbGnctkO4GhV63DuogR2ITLEFvCJmB9gtMnwKcTJBItaku5X5CBI3MNcGFt7jP6yEU
 cSQqmP9+CJUSIZ7y4FzWlW9f5kTrpMujv6H2eLwTe430WBViZv6g8lqm5+c1AvsS7vilMoup8Ps
 4opr1hwBdoFXLj65UwMCbyGttYfTO7zMh3rAlS8xN5IGls6mj33fLQ/zTNuR6kSoz2SfFS+tBBp
 dOaHXLlqERrQhsi+6ix/1EBEDh/itw8BEwtBA2J1+J+71iYvvjpZAAcIzlmXVzEh2nrmCxMZeb5
 0Lmu4yHbk8drYi1KV09LnZlraI2fXkbQFnhG9wDIGYkv5DGlunHMoPovHF/BSkI/t4BjND1FTLn
 QZ9S5G4URYcG+tqYVmkqqU1Nsb0WpW9RM5YFK
X-Google-Smtp-Source: AGHT+IFCMGCDC5yCCcpPerktcRBDOt41gxQp9SoBmaN7qcSKYlHNtmUTG1RzcHCDZ/u7iUrRs0rRJg==
X-Received: by 2002:a05:600c:138b:b0:450:d4a6:79ad with SMTP id
 5b1f17b1804b1-4538ee6e564mr170459015e9.23.1751380918941; 
 Tue, 01 Jul 2025 07:41:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d05sm171206525e9.2.2025.07.01.07.41.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/68] accel: Move cpus_are_resettable() declaration to
 AccelClass
Date: Tue,  1 Jul 2025 16:39:26 +0200
Message-ID: <20250701144017.43487-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

AccelOpsClass is for methods dealing with vCPUs.
When only dealing with AccelState, AccelClass is sufficient.

Move cpus_are_resettable() declaration to accel/accel-system.c.

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Adapt KVM handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h       |  1 +
 include/system/accel-ops.h |  1 -
 accel/accel-system.c       | 10 ++++++++++
 accel/kvm/kvm-accel-ops.c  |  6 ------
 accel/kvm/kvm-all.c        |  6 ++++++
 system/cpus.c              |  8 --------
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index c6fe8dc3913..3c6350d6d63 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -48,6 +48,7 @@ typedef struct AccelClass {
     void (*setup_post)(AccelState *as);
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
+    bool (*cpus_are_resettable)(AccelState *as);
 
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 51faf47ac69..d854b84a66a 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -34,7 +34,6 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
-    bool (*cpus_are_resettable)(void);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index af713cc9024..637e2390f35 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -62,6 +62,16 @@ void accel_setup_post(MachineState *ms)
     }
 }
 
+bool cpus_are_resettable(void)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->cpus_are_resettable) {
+        return acc->cpus_are_resettable(accel);
+    }
+    return true;
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index e5c15449aa6..be960bde5c4 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -78,11 +78,6 @@ static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
     return !kvm_halt_in_kernel();
 }
 
-static bool kvm_cpus_are_resettable(void)
-{
-    return !kvm_enabled() || !kvm_state->guest_state_protected;
-}
-
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static int kvm_update_guest_debug_ops(CPUState *cpu)
 {
@@ -96,7 +91,6 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->create_vcpu_thread = kvm_start_vcpu_thread;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
-    ops->cpus_are_resettable = kvm_cpus_are_resettable;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
     ops->synchronize_state = kvm_cpu_synchronize_state;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5cd38d536cf..f29e5c4eed4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3974,6 +3974,11 @@ static void kvm_accel_instance_init(Object *obj)
     s->msr_energy.enable = false;
 }
 
+static bool kvm_cpus_are_resettable(AccelState *as)
+{
+    return !kvm_enabled() || !kvm_state->guest_state_protected;
+}
+
 /**
  * kvm_gdbstub_sstep_flags():
  *
@@ -3992,6 +3997,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = kvm_init;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
+    ac->cpus_are_resettable = kvm_cpus_are_resettable;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
diff --git a/system/cpus.c b/system/cpus.c
index a43e0e4e796..4fb764ac880 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -195,14 +195,6 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu)
     }
 }
 
-bool cpus_are_resettable(void)
-{
-    if (cpus_accel->cpus_are_resettable) {
-        return cpus_accel->cpus_are_resettable();
-    }
-    return true;
-}
-
 void cpu_exec_reset_hold(CPUState *cpu)
 {
     if (cpus_accel->cpu_reset_hold) {
-- 
2.49.0


