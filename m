Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889ACC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2db-0006ju-6m; Wed, 02 Jul 2025 14:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cY-00057r-Rp
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cO-0002Jd-VF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so3484976f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482538; x=1752087338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bV84MiQpGOn60kTDkD54slrXkuHu95fcxpVNCRAl6i0=;
 b=rTPLBQlYxB2vdRrwOU04j9qkZM31ov0Jzl8mQufWoPG2Pt//wq9N5Lwq2nyHC7ac7D
 ksdTxskI3EJ6AQSee6ZU3ntPdpONzSKoR3cv1OmBYnDqd48uHv/uCI+CK99ry3r+aUVU
 oudrUL0qvSu/UlCYML57K2dZL+q9XQiEXOnXoqG507/VOlLYQPfGwiVFvGG8RSLjGZlv
 MCKcmSVlNuWaHFm86XdAx9WcfOm1w7LyWvV4HDhQhzqY4zzNKOh0fxIgW1LQxrHTm8iM
 N8Q77spK9Q0EmrzceSaf1FZ6P8yh2YjRvK0+FYM7OqlKqvxehnAAqChO7rdVT0fLuhbE
 B/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482538; x=1752087338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV84MiQpGOn60kTDkD54slrXkuHu95fcxpVNCRAl6i0=;
 b=mfjNoSvweEstAp+3KzsB/GLERgtwW+gbHJjZ2/tmDJw6HWUGKzxtGpAnDko1Do/vpc
 2nUbeOSJX0Ka/KvSuDVlXBdui1tPv4AoIChSYyBWX7XwJYuGQzNF8LQPkdMz/LCtNO2W
 9VX993d+qHolWvu6037AVE+DoyS0r+LkfRylCLJ3hQGKS2cynvPADlo/9NP/8uagWu5y
 zrpiGDUzVC3+JF38S7VyhT76myWtdla1RoqmpSBEwoOfc5xPSrzczi1ZemUMsYF4h1+1
 E6huIeFR8RAUpMXKGLeHSvVt5zoV2VkWVQX7Sc0CMw+ei+k4mnVpBZW/l58b+LYNVYZD
 OO3w==
X-Gm-Message-State: AOJu0Yzo1BziIHcj2PXV1WrOhfprsEY6FfsI4NVMzqxveUKt0NUie7M5
 M7LK2jvzJuRqVd6qOrpk1dgmf9NGkaxPFhxjzsNhKeqyOWCU/PvGlQ+T5+Xj/DJik/1mz3shBcu
 GIhSn
X-Gm-Gg: ASbGncsyHJtJWvLYrPLRjl7yLk7XbM4aA0usgGIMouzyE1YUmp8zQaX/yxmxlPu63JI
 wSWIr9Eg03G7JYyn7IQ7CqcyzD4XjyzeQBsGQY7l7gMTZq64IeJkrhZ4V+HYdjM8VYrZli4vObF
 7xtVC2VQRtH8WfCZn6OsT5Xx24qwkQkM08XBPUvX65ScKOyCl92+CE1aBnujZ7mcuEvFYbYPbhm
 nECWNmSYzAlr6bkY5sPbih6YxVaNp6vvryzszz4dAO806q074KpQmslbZIUo4rwDUNrYpwyejPP
 LqMBXS/es9x3WKQDrHUpbi70G8OX4wO+CyweIfgQdl2LNGmCmkHrU12YMDLIjm6HAW9yDeRMvNW
 UvRNQm3pwgm1nd1+U/XbzGBNEGI0ztINLUeJz
X-Google-Smtp-Source: AGHT+IFODJ+D1AFeTvC1vkdycvK6lOL44CSBA8lY+BbJ04aT22gqywY98ryhDAizdMHORIqFjKZtkA==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3b1fe5bf079mr3216108f8f.2.1751482537445; 
 Wed, 02 Jul 2025 11:55:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f44dsm16538961f8f.87.2025.07.02.11.55.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v4 17/65] accel: Move supports_guest_debug() declaration to
 AccelClass
Date: Wed,  2 Jul 2025 20:52:39 +0200
Message-ID: <20250702185332.43650-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In order to have AccelClass methods instrospect their state,
we need to pass AccelState by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-cpus.h       | 1 -
 include/qemu/accel.h       | 1 +
 include/system/accel-ops.h | 1 -
 include/system/hvf.h       | 2 +-
 accel/hvf/hvf-accel-ops.c  | 2 +-
 accel/kvm/kvm-accel-ops.c  | 1 -
 accel/kvm/kvm-all.c        | 5 ++++-
 accel/tcg/tcg-accel-ops.c  | 6 ------
 accel/tcg/tcg-all.c        | 6 ++++++
 gdbstub/system.c           | 7 ++++---
 target/arm/hvf/hvf.c       | 2 +-
 target/i386/hvf/hvf.c      | 2 +-
 12 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 688511151c8..3185659562d 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -16,7 +16,6 @@ void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
-bool kvm_supports_guest_debug(void);
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 void kvm_remove_all_breakpoints(CPUState *cpu);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 1c097ac4dfb..c6fe8dc3913 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -50,6 +50,7 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 
     /* gdbstub related hooks */
+    bool (*supports_guest_debug)(AccelState *as);
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
     bool *allowed;
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index a863fe59388..51faf47ac69 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -65,7 +65,6 @@ struct AccelOpsClass {
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
-    bool (*supports_guest_debug)(void);
     int (*update_guest_debug)(CPUState *cpu);
     int (*insert_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
     int (*remove_breakpoint)(CPUState *cpu, int type, vaddr addr, vaddr len);
diff --git a/include/system/hvf.h b/include/system/hvf.h
index 8c4409a13f1..7b9384d816c 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -71,7 +71,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
 /*
  * Return whether the guest supports debugging.
  */
-bool hvf_arch_supports_guest_debug(void);
+bool hvf_arch_supports_guest_debug(AccelState *as);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 640f41faa43..e7f40888c26 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -364,6 +364,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
+    ac->supports_guest_debug = hvf_arch_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
 }
 
@@ -600,7 +601,6 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
-    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 };
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index e5c15449aa6..96606090889 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -104,7 +104,6 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
-    ops->supports_guest_debug = kvm_supports_guest_debug;
     ops->insert_breakpoint = kvm_insert_breakpoint;
     ops->remove_breakpoint = kvm_remove_breakpoint;
     ops->remove_all_breakpoints = kvm_remove_all_breakpoints;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 45579f80fa5..a9d917f1ea6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3528,7 +3528,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
-bool kvm_supports_guest_debug(void)
+static bool kvm_supports_guest_debug(AccelState *as)
 {
     /* probed during kvm_init() */
     return kvm_has_guest_debug;
@@ -3993,6 +3993,9 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
+#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
+    ac->supports_guest_debug = kvm_supports_guest_debug;
+#endif
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, kvm_set_kernel_irqchip,
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 37b4b21f882..07b1ec4ea50 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -106,11 +106,6 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static bool tcg_supports_guest_debug(void)
-{
-    return true;
-}
-
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
 static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
@@ -218,7 +213,6 @@ static void tcg_accel_ops_init(AccelClass *ac)
     }
 
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
-    ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5904582a68d..93972bc0919 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -219,6 +219,11 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
     qatomic_set(&one_insn_per_tb, value);
 }
 
+static bool tcg_supports_guest_debug(AccelState *as)
+{
+    return true;
+}
+
 static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
 {
     /*
@@ -242,6 +247,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
+    ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
     object_class_property_add_str(oc, "thread",
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8a32d8e1a1d..bced226fd94 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -634,9 +634,10 @@ int gdb_signal_to_target(int sig)
 
 bool gdb_supports_guest_debug(void)
 {
-    const AccelOpsClass *ops = cpus_get_accel();
-    if (ops->supports_guest_debug) {
-        return ops->supports_guest_debug();
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->supports_guest_debug) {
+        return acc->supports_guest_debug(accel);
     }
     return false;
 }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4c4d21e38cd..bd19a9f475d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2357,7 +2357,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps(cpu);
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 28484496710..bcf30662bec 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1024,7 +1024,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(AccelState *as)
 {
     return false;
 }
-- 
2.49.0


