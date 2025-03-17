Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8012C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBST-0000oa-4A; Mon, 17 Mar 2025 10:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSF-0000fI-UM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuBSA-0001C1-Cu
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:28:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so22627285e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742221709; x=1742826509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=12NoV+qUwolNTR/lyBhiD8xL6EvtlX/77nQHYFb4d7s=;
 b=kMVHGNouJDtVDHVEQLzlJo0h7I2E44kyk1DsXF+vVzlZJ4KQcWDAz0tokvoJ6Unm/M
 4VGYmVMi/4SH1EQ2+6VCCb70Be6AH0N/My8qf8f7UnrV11pajbosbMXYLX8Bh25RRiCM
 fiopiWTXOp8ymedXghNH+I5YGwWN05xA95oDmOudqOFJcpNSucz3kOosm+kDaU8a1q8g
 alkdAgZ30e9Ti15V8uvplKSj2hk499s/bIR6A7ucaOCFaIHCWhZNdOBSV1Fan6Qz1Zd/
 kZftuBD92e71/tRarpBrdlPd55eozSSXmWZEW+DAZnEy8mADrN3LXPDg/ygOcHy0eBrG
 Ko/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221709; x=1742826509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12NoV+qUwolNTR/lyBhiD8xL6EvtlX/77nQHYFb4d7s=;
 b=nGGwT7MjjCId6OONzV6eygTML5rG1lVpG9wm0Dx0eqOZgmIGTemgL787yqQOV+RTcj
 80nJkVh5x7iPm25R4Afk2dBz91hd0NTJ6Q+rpfAw0cwrbPXS08RCMlWKBPk3THBBJaWx
 K/mAvT1S3Kwdq0NNm/Gd/4A6YwwYXah9ugvACzpLpXWlgr4wifPkGLOTd/wii60URG58
 dHSTlaaSLj+BeMMMleM+ZnpM2MHndkidJpFhpJw1UXvqZugzpD5RVv5L8uji6Efhy+gK
 vGO4RWPai0kvKzK1eSaeKnC52vEvsq7A4OkkyelZZV7sRoFLT7CL4DWaLEQkyg6n0Xj6
 vhzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV6ujvSnN8uE4fUWWnagmhR8j47oh1oSE1sjg2MKzKzmk2Tg25F873HIH5FI6mxtLD/r8EaDpzGZs1@nongnu.org
X-Gm-Message-State: AOJu0Ywvev5TMJ3olVoHCQHOFKQ1wbSgJXeZ0LWQyOgrWTeFzVUfh4uw
 GP7you4CzyyuS1/ZlmeHdbxJ8Vz6+86MCwIN69mjmWqGb25iPnb9H5faR0BNJ1ispUlipjAVF0R
 y
X-Gm-Gg: ASbGncslgpyUK8KK9QfsrrRKP/AMPqmTbd+AZLP7Ul2+YNGISMJLArcKhMp1DkMs2D5
 5zH0q6LG1N3p8eMR1hFu2xXLTUEt2tHvbk+DAmvsDcgtgSAW2To810svKj3AgDaLpbrJe4zOFCo
 gkfdR4m9ziRfly10wiAPwwDyi6ewJikSgj8eHP/MTAGkN6xXD6eXzw5U9yQ+0r/ILwwsJQ7Aiyg
 DHmlNdfdXCunzP9drv0nhVGhs02xFKQq+iuqhUwk34f043uT0hODOsFtqMepZEQSb8jdZK15pkh
 1qLObGJvIGFcOxAMypcmZBehqI8jb2Zi9MEAYeeGnuyI+EDi/tM=
X-Google-Smtp-Source: AGHT+IGpBHCzykbXxWcXhiu7h/aN6iP/PHg8IQjHJIIz9irlj1m3HfoLJsjVINPdWH6VTW9MCVhycA==
X-Received: by 2002:a7b:c4c9:0:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43d23cb505fmr111623215e9.29.1742221708482; 
 Mon, 17 Mar 2025 07:28:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60ad4sm107914985e9.29.2025.03.17.07.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:28:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-10.1 7/9] target/arm: Move aarch64 CPU property code to
 TYPE_ARM_CPU
Date: Mon, 17 Mar 2025 14:28:17 +0000
Message-ID: <20250317142819.900029-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317142819.900029-1-peter.maydell@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The only thing we have left in the TYPE_AARCH64_CPU class that makes
it different to TYPE_ARM_CPU is that we register the handling of the
"aarch64" property there.

Move the handling of this property to the base class, where we make
it a property of the object rather than of the class, and add it
to the CPU if it has the ARM_FEATURE_AARCH64 property present at
init.  This is in line with how we handle other Arm CPU properties,
and should not change which CPUs it's visible for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c | 33 ---------------------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 75d5df4879b..9c6e8f5a935 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1608,6 +1608,35 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
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
@@ -1735,6 +1764,13 @@ void arm_cpu_post_init(Object *obj)
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
index 2f87df082cd..49cf06a7bdc 100644
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
 
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
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


