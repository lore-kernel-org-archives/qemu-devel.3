Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319B8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmu-0004NR-Ve; Thu, 15 May 2025 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmq-0004JH-Mx
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmo-00087G-NU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so9263445e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304757; x=1747909557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V44BClu19+jvYPw+zjT/7PfwtqiqasGrnUcfMcg673Q=;
 b=CZS+esSn4X67hdD7niZJW2zNGW1xSZjmt9Vp6kQXA/irzEdJfQCJO9peJ7JSaaaI8W
 YgHcF8wzJ4ITbP5/Nf9yHxmFzneuQpaGw3tMDlx3T1tmLNtb3zxWysOrP169Cc2UFKqY
 sOF3so3IYCIhQ9G0bjhfmyWUetoH6tqFNjPLeJcmskXmcoxotE8TpynPMvLz0bgaCbSm
 ZGkIa+IQmAav/CFdKVEvWt2VYwbChGSIbM+wbBK+XeWUooP4NAcj7t9YqoxvfyT/16Qs
 qqL4MiTygxm/9JkA9XSL8ozoKY1ZYFcNxG5veQKHrh4esa7PCKD6luQKf5Lj/CJudCFK
 3RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304757; x=1747909557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V44BClu19+jvYPw+zjT/7PfwtqiqasGrnUcfMcg673Q=;
 b=k12AB/syNHqeXeJ0ZAv3WKeSmnVmXOxHpuDJT1QItSIwloeTAzQIl6OT5cURWW4DCa
 yYa1Tq03KFnTAi1e6RdKPGAvCJSfqQaPfxV4jUbzY+clcytwt3hxywttCVQh7MYRvFiE
 rEM6hm71RPU4swr0segb/Kg6LzzmBynBGU/nARJxHA5ln4/aR6IBejRE1xeGRm4jI8I5
 7bto8FeCDpol1kiM8mABTFEl6JJKPp9DOxbCkKIJ50OnVJdBhluaAuweQRDULg/moEmZ
 s9xIGkvv3qVPWYb3TeMsLKFWxe24wNhZeXVyio9iWBem96XRXFeW5MjCz0BLNTwy+5cx
 AEKA==
X-Gm-Message-State: AOJu0YxJYEBIEDhsjsSccZMUEn8p/hzfCKp5+j6XRdccytJBJyJMgzYX
 eesJ8nSKX2/J/HpwttfQf6txsDsZp0jK29v3wUi+zQsjm/z7k2+XS0s0gn82K8XW/mrTVCjtcoB
 aMaw=
X-Gm-Gg: ASbGncvrDcKvHahGWhib8nivoBSfWkSJ8kFw6ARdgrJDbyHphQFwWCoJkaE8EEpYY0g
 jMIdPdW+3xi7xomQLzluJMzSUWUuQ7IdT6frik+KRK2NtwErlkoVj1UJF11UMvMJzYCEhJ9q2r2
 NLXu4/ULm8EcC0IyUcaBKHYeAoNH4TsUeCQjjiWiEaVJ1CcbPRR7SBljM2ySOIG/04XfUbuVRfg
 2L+jmDCP9EhULv1NCUCxfh26gyQ7pnurYAa5Voo5lGFLE1PgIRhLzW3rSBABXwnhCUNBjS6LIC4
 MJ7+1+LGeB116N3d2jXFvZSoRaNld5JNLMSRXSNi6leo1mkCO/05FmHBgyCjseEvju/y
X-Google-Smtp-Source: AGHT+IF2c+SWv/P9+Tpn2LV7RD4SHoKn+nx5riGwMirs1xFP5ntFGsPXnbFQ/pWSdohybR1ZJfxUGg==
X-Received: by 2002:a05:600c:c09:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-442f2168c29mr54196595e9.23.1747304756870; 
 Thu, 15 May 2025 03:25:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/58] target/arm: Move aarch64 CPU property code to
 TYPE_ARM_CPU
Date: Thu, 15 May 2025 11:24:53 +0100
Message-ID: <20250515102546.2149601-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The only thing we have left in the TYPE_AARCH64_CPU class that makes
it different to TYPE_ARM_CPU is that we register the handling of the
"aarch64" property there.

Move the handling of this property to the base class, where we make
it a property of the object rather than of the class, and add it
to the CPU if it has the ARM_FEATURE_AARCH64 property present at
init.  This is in line with how we handle other Arm CPU properties,
and should not change which CPUs it's visible for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429132200.605611-6-peter.maydell@linaro.org
---
 target/arm/cpu.c   | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c | 33 ---------------------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 45cb6fd7eed..603f08d05a0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1609,6 +1609,35 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     cpu->has_pmu = value;
 }
 
+static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
+}
+
+static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    /*
+     * At this time, this property is only allowed if KVM is enabled.  This
+     * restriction allows us to avoid fixing up functionality that assumes a
+     * uniform execution state like do_interrupt.
+     */
+    if (value == false) {
+        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
+            error_setg(errp, "'aarch64' feature cannot be disabled "
+                             "unless KVM is enabled and 32-bit EL1 "
+                             "is supported");
+            return;
+        }
+        unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    } else {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
+}
+
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
     /*
@@ -1736,6 +1765,13 @@ void arm_cpu_post_init(Object *obj)
      */
     arm_cpu_propagate_feature_implications(cpu);
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
+                                       aarch64_cpu_set_aarch64);
+        object_property_set_description(obj, "aarch64",
+                                        "Set on/off to enable/disable aarch64 "
+                                        "execution state ");
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 00629a5d1d1..e527465a3ca 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -781,45 +781,12 @@ static const ARMCPUInfo aarch64_cpus[] = {
 #endif
 };
 
-static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
-}
-
-static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    /* At this time, this property is only allowed if KVM is enabled.  This
-     * restriction allows us to avoid fixing up functionality that assumes a
-     * uniform execution state like do_interrupt.
-     */
-    if (value == false) {
-        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
-            error_setg(errp, "'aarch64' feature cannot be disabled "
-                             "unless KVM is enabled and 32-bit EL1 "
-                             "is supported");
-            return;
-        }
-        unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    } else {
-        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    }
-}
-
 static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
 
 static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 {
-    object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
-                                   aarch64_cpu_set_aarch64);
-    object_class_property_set_description(oc, "aarch64",
-                                          "Set on/off to enable/disable aarch64 "
-                                          "execution state ");
 }
 
 static void aarch64_cpu_instance_init(Object *obj)
-- 
2.43.0


