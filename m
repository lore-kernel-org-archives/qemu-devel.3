Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC1EC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dJ-0005kz-Dm; Wed, 02 Jul 2025 14:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ce-0005Eo-CX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cV-0002Ll-K0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso38526525e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482544; x=1752087344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aB/j0dD+Tw6oDsMLdkju47YZrsXLX4R6aGxhn5wulM=;
 b=nSufxr4mYu0tyqDSOAHf+0QdDTX1ywjosdngN8wgzCfwloeRji/kyaZ5FGnoW7pyhz
 ++rQ8s3/ED32GoLl1wR2HMZ7vfhAbgoe5tpNovNSFwSOFAeja+HrJJU77iP+lYkG+H35
 UDf6Wdoki+8RXggk6BoC06YtcNwEll0VjXOMs29jrP7yOlAOsYWDs3VkKvy7K/oASsOl
 hYZ89F863+UbuKFjDloSC3M4UiVpoi/fYad1NFpdDVAYXZH4MB1AHitg9rARRhtXRVYQ
 dcJ4bTwbH2ZROWOypaUxdIlJhVMEIAkbKySddegDoiB7UdtM4rOBf8iLcAXlB8RpHmOQ
 M5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482544; x=1752087344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aB/j0dD+Tw6oDsMLdkju47YZrsXLX4R6aGxhn5wulM=;
 b=qHlB4Jp1BnwWoKNRpWADjd9bmQVfobDOkOR7RdNpSi+wQZep5ma6tSk80pumgzaV4B
 3V0mhi1eBLDEg4/hF8XZhTDbaivUKFqJhfeb1/v3RngMSxZB/xWA0BiSGvybUQQTAGf7
 Pq/8aaxZ1Ue5HLTSg28ydW2nAZFvLDN3ZAThaziPgVWFPYH5J0LDdYKrIIIyzPNXLaof
 FWTWkUjylCFTrvGESbTShyK8LZzukLB6xD4eCUjx7LufIIvmmXd1fuOJTZm8MQ8TZIPi
 rd9gE9pQ02kvl6hBeu0HSgR8GFvnsLBdCDB8QWwcC40qdPDUyRrZwRB1LiUk1sNcNtD5
 E25A==
X-Gm-Message-State: AOJu0YzXRoASFE1OjaHTLuVARpNO6YdbALlLf15wb4xv6lvnQsXrSrRN
 Q2Htyoj383Baf2X1SIPnSraSRIGL8AsJoe36cBAemF7oCQGznxQIq5srRE5FjzFqSL3NBReGGmo
 jVK06
X-Gm-Gg: ASbGncvvu32xEQuR1+gsZDhhANtBibOmBgQQGMKfoQBoX2Ar84wJE6nKenVy6E2ex0U
 hZupBh1JaFtWY6EGh3tOeh9l9nvFt56BUzK8QhNtdc/zdpqMhChnWRx90+6JGE90Vr+5yrhSuse
 TDlV9yO5Z/3P1gcYwtxfC2BwlurB6Y7u0oOK3kLzOTQyx7jIqsrbBH6QdMVesLrNg9EBqpNmK3z
 8Weg+nBsh5l+ZCQ2MFvgN0bZDC+KVetTNsJof+1Ub53KyNMPUngUgVZJSkUX2WGcXQKcqjbdADR
 HOORuEPPjLrlP5qdwsc6EGYVNh+3dmbFuPs5pHSkpA2+YOyCruGNSbVIh+Ra+kDxG8g2gJc1T7X
 Mk83ZuzbaDSn36nwEdjjVZAOtiIoOcCgUU5tE
X-Google-Smtp-Source: AGHT+IGCW4bTbz2dddSy6xxWh/wDXlXfWVKxcFEebZ5EDZfLvPjucngnBF2tRtCLb/AVvYsFIqjy8w==
X-Received: by 2002:a05:600c:6305:b0:453:6146:1182 with SMTP id
 5b1f17b1804b1-454a9cb45afmr6910235e9.32.1751482544367; 
 Wed, 02 Jul 2025 11:55:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm5692795e9.31.2025.07.02.11.55.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 18/65] accel: Move cpus_are_resettable() declaration to
 AccelClass
Date: Wed,  2 Jul 2025 20:52:40 +0200
Message-ID: <20250702185332.43650-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


