Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9BCC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPj-0007qy-1n; Fri, 04 Jul 2025 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPh-0007qX-0Q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPe-00054J-Ut
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:25:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so682140f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635509; x=1752240309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YlPfivgchPNQdEOzqEtSvldwfqBebST1wJYyAXBd+8I=;
 b=ubqLMKBByx1JLj/gHvgE82lIZFzD1Vqzr6JYhOx7nNecBd4Lw4FrM540CKooHB1kjc
 1S9Sw87NZbGXycvaQO3tlR4n/oS9kG9o6vU2CaU9bys4JHQmMMpi4yyU5vrPh4kHe+ND
 go5mbrGhXgsqhrwRIxJs1+XqyPbUiDUEgtuYJzFtvOR+UWj2w1QRq0gL4W733TAKjtXW
 03PgxHggIKXkv/ycc6vyrfjefB43kFpVtlKknkZaO6pY65teORC3jW+a3RiGNkNr9a6n
 vlC9OjZz7kzdfosq0SLLQ3xw90AzWUEC9bb8nrPTQqo4P1zTrORzclqb+YtCT94rz8O0
 xD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635509; x=1752240309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlPfivgchPNQdEOzqEtSvldwfqBebST1wJYyAXBd+8I=;
 b=vPMsH9MiE0Y/HH3nDVjKHlcwDaTHTInKZtkLAgoVuxEVlMCm38vnXwVsew89qzltgv
 RtbqWKczIqtQ8oABlI8oiox99RpIf4g2K4G0uFpYphguL0c+nmmaqxNr9jg8ngTkL14v
 x1LwJn2byOf31HqgsXdKQ5u51SiyqLh4KgG5UKba90EHoeVjYathgjBw7p91D7G34uTY
 W5aoCQcQYKXPnCmOZaf532E/vC3x4sj2BVnUDXlCBIhpjOf/1Aow23qLp5KAN39NxXYQ
 FeblI8g5deEa95FWgnVl4cWmGDozfmCLuuIBdIumZkOdG4oXS6E0BS5VTCkmvaq8fX7x
 sCeA==
X-Gm-Message-State: AOJu0YzwK88T+709dEr7ck3StDGitZdgVp4EsMVy2/3i7XkmeTbO5IEK
 GKkD9tjIcK8DjCiPqK3ByE/qT0iOgXmZyEgRIjT5EWuByduj0nMPh9ef2SO1ouSAKAaunvTAX7H
 7+kGe
X-Gm-Gg: ASbGnctV6pOnta79A1YZIYZSOlnl2U64R1FHUvaEYA1jZS1vsEcxNksFGc/GZak9N9L
 lcSWqqIczsQDv813HFFFIooG0fo80Ek6SeI7kLYTs7xYIjYGx8kpyGyEJjHX+IXlU6bW4zkrMW2
 IXjWQuMK8eYEG9l0SxS9VI47BpTXV8hc6Q06lsXJ2mSvn0vwthy1VwhAjqkFC/X39rso8MqsJyB
 CHrsyp/AToTtVbr38vfL4JF16jeY4T39LT2VZ+I54xXWg3Z+Hm0W8u0JCXlAqZtgCxn7WW/0iyV
 zXKPrBe5vW0o/JNPjIw6r9LUJO2pwkI1DiuntzyYXsdHsEqP81+MZwrhUpWlpqAcSSruqt7VPhX
 zq2Ci4NxIPUigCR4TKvRGo137SJJxxn2mJY7+hvo7bYkyW9rzyaTi
X-Google-Smtp-Source: AGHT+IGoKq2fUch9JCYRQKxldLgrSdfznVr87N4f4WgJ/O+vvJSi2POcKlJdQdZ8VuzrnoeIiPeBjg==
X-Received: by 2002:a05:6000:1885:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3b49558ac68mr3125902f8f.24.1751635508675; 
 Fri, 04 Jul 2025 06:25:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3016sm84423525e9.0.2025.07.04.06.25.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 34/36] accel/system: Convert pre_resume() from AccelOpsClass
 to AccelClass
Date: Fri,  4 Jul 2025 15:24:39 +0200
Message-ID: <20250704132439.25743-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Accelerators call pre_resume() once. Since it isn't a method to
call for each vCPU, move it from AccelOpsClass to AccelClass.
Adapt WHPX.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250702185332.43650-21-philmd@linaro.org>
---
 include/qemu/accel.h              | 3 +++
 include/system/accel-ops.h        | 1 -
 target/i386/whpx/whpx-accel-ops.h | 1 -
 accel/accel-system.c              | 9 +++++++++
 system/cpus.c                     | 4 +---
 target/i386/whpx/whpx-accel-ops.c | 1 -
 target/i386/whpx/whpx-all.c       | 3 ++-
 7 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 1c097ac4dfb..f2bfc02d61e 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -51,6 +51,7 @@ typedef struct AccelClass {
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
+    void (*pre_resume_vm)(AccelState *as, bool step_pending);
 
     bool *allowed;
     /*
@@ -86,6 +87,8 @@ int accel_init_machine(AccelState *accel, MachineState *ms);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
+void accel_pre_resume(MachineState *ms, bool step_pending);
+
 /**
  * accel_cpu_instance_init:
  * @cpu: The CPU that needs to do accel-specific object initializations.
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index a786c7d478a..bf7383511d0 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -61,7 +61,6 @@ struct AccelOpsClass {
      */
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
-    void (*synchronize_pre_resume)(bool step_pending);
 
     /* handle_interrupt is mandatory. */
     void (*handle_interrupt)(CPUState *cpu, int mask);
diff --git a/target/i386/whpx/whpx-accel-ops.h b/target/i386/whpx/whpx-accel-ops.h
index e6cf15511d4..54cfc25a147 100644
--- a/target/i386/whpx/whpx-accel-ops.h
+++ b/target/i386/whpx/whpx-accel-ops.h
@@ -21,7 +21,6 @@ void whpx_cpu_synchronize_state(CPUState *cpu);
 void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
-void whpx_cpu_synchronize_pre_resume(bool step_pending);
 
 /* state subset only touched by the VCPU itself during runtime */
 #define WHPX_SET_RUNTIME_STATE   1
diff --git a/accel/accel-system.c b/accel/accel-system.c
index af713cc9024..c54c30f18ba 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -62,6 +62,15 @@ void accel_setup_post(MachineState *ms)
     }
 }
 
+void accel_pre_resume(MachineState *ms, bool step_pending)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->pre_resume_vm) {
+        acc->pre_resume_vm(accel, step_pending);
+    }
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
diff --git a/system/cpus.c b/system/cpus.c
index 0d0eec82a2f..8e6da2e0606 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -768,9 +768,7 @@ int vm_prepare_start(bool step_pending)
      * WHPX accelerator needs to know whether we are going to step
      * any CPUs, before starting the first one.
      */
-    if (cpus_accel->synchronize_pre_resume) {
-        cpus_accel->synchronize_pre_resume(step_pending);
-    }
+    accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume();
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 31cf15f0045..5f4841c9fa4 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -96,7 +96,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
-    ops->synchronize_pre_resume = whpx_cpu_synchronize_pre_resume;
 }
 
 static const TypeInfo whpx_accel_ops_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 721c4782b9c..faf56e19722 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2105,7 +2105,7 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_whpx_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
 }
 
-void whpx_cpu_synchronize_pre_resume(bool step_pending)
+static void whpx_pre_resume_vm(AccelState *as, bool step_pending)
 {
     whpx_global.step_pending = step_pending;
 }
@@ -2697,6 +2697,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "WHPX";
     ac->init_machine = whpx_accel_init;
+    ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-- 
2.49.0


