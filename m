Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929E9C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHg6-0007Bi-Pd; Thu, 03 Jul 2025 07:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdE-0004lZ-C0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHd6-0001li-O6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45310223677so38343025e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540243; x=1752145043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aB/j0dD+Tw6oDsMLdkju47YZrsXLX4R6aGxhn5wulM=;
 b=B7XWKqN7BfcSXVoNFGJ8T5jMC+B6W5RDAflMApcqKKjFpquWChPhD3hukpRVP/XECI
 0VC9AxzOSsCGGBjq9e1Ayu9r35U3ybjcI8KaEsDJar5cSieoImffkOBktHJwwUVujoEZ
 m2EB195ih2Y63Ajoo59jvqUWaRPUurYQzOOaWV01UxnRzjkKfRkD4zoi6fx7NEYjR9Jq
 LtU6LrAml4cy1ZcLDXwrhsgLEbjOsrKB/LTPLwU0O+VWv3YwEdpRD3Ggb6WZ14kzIqRz
 6oY+/F1vVeHVypYz6Ury+Yj8pS0KFghRD6/QI3AIMfMYEpRxLAHUrYSE4J8u1QCNsgKf
 bbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540243; x=1752145043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aB/j0dD+Tw6oDsMLdkju47YZrsXLX4R6aGxhn5wulM=;
 b=Y5eTkvmGYyayG7qkQnLwGxOF7C8RoWEJpBns98zibICJ/vhL9BjyZK8p7J8YYwAEre
 hZQc72fpDWqXdpQic+j14RI12p0DUk/cjQNfPQuCaTlrAAFrQd7YRJq5T4leZAemoKO0
 1hi1GrAyinRYNC6kq8VG1F3EEyF2Hc7ZjynU78pFvoEhCad1iKAFn7dm4n7dg/Dqznps
 C0V00LBcBLDE1WUekoztSpNczuiUCxXCw/lS/0NtGxWsIx2+YC0E1JXXbb8Kh8iEBmun
 OHy2iJE5ryb9CLXQeASFE0mPZVTPInes/WC9iISMzbjJCJhty49CCZVHFVFzj3F+H+9a
 jQ8A==
X-Gm-Message-State: AOJu0Yx79vQCrAh6wRraMBkMgVkZWMMO2+COzir0KNzCkvrWbGcqTzin
 0pXkjoIiPCZxafJFP7dgonhGDqiI/Q+CuaqXN71AJExkvq1E55vA1B3OsTMJ5RinGMDzS6i47Du
 7h2plfsw=
X-Gm-Gg: ASbGncvhllPYhuICkRchRiw2v0ZTgUYnT0/Ak/H1YhJjc+Frz3jOeP3SQZs+gFpOv4T
 298aEaN1WwZY1pIj3+d3fggwSOpXmUFW/Umx1dHMfrfwEQYacD3Zdvaq14q/kt5GQaFYK/xaMu5
 gr9EOoh9NZ1bs0HRWkB3BEd9m76iNL7P4iH0zpM6T9PFEYWs0Lqc8ozObdrWO7ighCVsfUPI480
 vdzY0hM2/QWsbKIzI9Kuh8TIZzrgBFhWnpaU3cXtX+CcS/X6joiLyAfeOwbIyZSUG7O2xrRB70Y
 5SSzYPMEhhnotGkvRncCPgOE9IqsdgUea2nbudL7ZDYFMhwMjylns9dR0vj2bzLbCXGVLwJOS9v
 AsQmK5e0poU4=
X-Google-Smtp-Source: AGHT+IFY575descHYaPdwzTKawSS5YJf9NFJv4bMQ6/yUPx4/P07s8hQbXogExn1Qi/cQ/c9nYIcQQ==
X-Received: by 2002:a05:600c:638e:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-454a36d8b1bmr64595345e9.2.1751540242724; 
 Thu, 03 Jul 2025 03:57:22 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9beb2b2sm22701505e9.35.2025.07.03.03.57.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 19/69] accel: Move cpus_are_resettable() declaration to
 AccelClass
Date: Thu,  3 Jul 2025 12:54:45 +0200
Message-ID: <20250703105540.67664-20-philmd@linaro.org>
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
index a9d917f1ea6..9d1dc56d7e8 100644
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


