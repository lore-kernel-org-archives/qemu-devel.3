Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBDFC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpT-0006hI-F1; Thu, 03 Jul 2025 13:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNov-0005vd-Dt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNot-0008Mk-6X
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso882555e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564037; x=1752168837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/XChvbBlrGhhVuJVL/Zk7Vb78wLAovjWCdTr9DfryE=;
 b=Ilj9qHRcfrirgUZHANYUUnT2efukP5TlI6YvdCGxoVz5KwAqF53vJfDkzRrEWRaZ7i
 y5y4WLt577QnjCSp3pOvudhSBsmq7iTSXE/TkHrgIu84xZ3ux2LlIo7LVG75fgzmS3pv
 rI23wW+kbYOKApur9Mn8TrIKxMUPT/tijZO9aIqO1DSbBni8x5R0/kyZBLD4WVcKXVLb
 1xu67SgoQr5rdJEIEqVW19flpzLz9wNBliGaJbCcIbvL6qa9hSjSMbRTVT0mkUP/CDBw
 hE1yzd785WgtmQraIyZZJY+PVT8I0jyzjTY301gWuzhTnL498is6ZXGJfSDe63jHSclz
 ktMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564037; x=1752168837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/XChvbBlrGhhVuJVL/Zk7Vb78wLAovjWCdTr9DfryE=;
 b=tcz4ZcNsOF/lUQmyqXqY4Jpw8iEUFJjJyOGpvK+B21lvy3UpnwCjp0o0t78HBLmx/D
 zSUH9jDNGjRFWpY9J8E7zKzLpkHcd+aCKwwwUdQQUrG+yZavni4ldHw1/OxY7wlaPbmL
 SFcxc+8X+q29b5rm4oI7ja6rKKACWdFbAJ8Xf+rFJzvj3XG3TqepbAXS2Yy/dYZJqIly
 qo1Mf1I5wqaHdPp5SgY6C2KAaQ6JrTOJkDOpyugypoce0XbnRNcdh5YDvY4C9AaLgchv
 KkVu/5NMOYthgyBLk0gHpN8eK63AEU7J5KTx7WQVsdFtc2VtWHPL79XjoeeXvoZyV4fQ
 aldQ==
X-Gm-Message-State: AOJu0YwNN7cUVKsMiaaF7faEasUJVeH/P3Me0HFHtj9x6PIi8SoZ6I7K
 8N0IwIL4N6Vimvw0K1QLJi3IDTJWfbktXfheGqVQW/ng7hjQOVo32AHXtqhNCZIw+0W8UyHq0E8
 jPuEZu8w=
X-Gm-Gg: ASbGncs39FUsuxeBdAg58nWJUMauTh32TOio1keY7tJc4QsjAqTWQZ1Rae8RyLpaBu/
 sThLdpOigfLfPT40DOVa2SINgWwCZWlkLVR1iU4WCsZSY1BYdgP1Ggn3lRUnWZzFfZvJQiZzO6R
 EoNgB486D4mYETBRvex0HS2O8X7ncUveTUphN2iTuwBXLmWtsUJVtGTzj7ICq5iN84+RZoS5sbk
 Cz98KDi9GCbB+WoqjWols5NHRypaStcntLYF8d/OAvjiDyMs5RXmSxmrgkqOSad0dxEeNne1nYo
 FmF/n36q5DPzeDmgxTVZTpc4q/FVaW6+gf7ddrfRTDRQ22pjp9mjv95KiOLGx2GQTk2fhvkTJvg
 ol7gdyt7cnTDStTHPRXqylOhIsWw5NVkiMbJE
X-Google-Smtp-Source: AGHT+IEjIcbV0/p4Gzpq8ssp7QneNZeB0/RBRlqRwz4r9eWXtga2gIBfvXxZyNMLZl6Wi93ElXZ5wA==
X-Received: by 2002:a05:600c:4e86:b0:453:c39:d0c6 with SMTP id
 5b1f17b1804b1-454a3737eccmr66163065e9.32.1751564036915; 
 Thu, 03 Jul 2025 10:33:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030c443sm344279f8f.11.2025.07.03.10.33.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 13/39] accel: Move cpus_are_resettable() declaration to
 AccelClass
Date: Thu,  3 Jul 2025 19:32:19 +0200
Message-ID: <20250703173248.44995-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
index fb176e89bad..f987d16baaa 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -45,6 +45,7 @@ typedef struct AccelClass {
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
+    bool (*cpus_are_resettable)(AccelState *as);
 
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 700df92ac6d..f19245d0a0e 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -33,7 +33,6 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelOpsClass *ops);
 
-    bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a0f562ae9ff..07b75dae797 100644
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
index 96606090889..99f61044da5 100644
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
index c8611552d19..88fb6d36941 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3979,6 +3979,11 @@ static void kvm_accel_instance_init(Object *obj)
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
@@ -3997,6 +4002,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = kvm_init;
     ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
+    ac->cpus_are_resettable = kvm_cpus_are_resettable;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ac->supports_guest_debug = kvm_supports_guest_debug;
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


