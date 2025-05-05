Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D748EC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC56v-0006Bh-KD; Mon, 05 May 2025 19:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56s-00069I-Qe
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56o-0003V9-Jd
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33e5013aso53522945ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487225; x=1747092025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ktcl5OZ+t3GMcQQ7Jgx3PtMsJ0l/J5yPLlaHDm/4GNI=;
 b=d3uAuy7idSo7dfYNjZ6JuGUDMDqQ0rDcDTXUwmx8zb5wPQZcJgY/T9cquHVx/oWDWw
 xdbz+Fznm+7DW+G0bj1va7IuD6OFR49QALY4BrPZz2a4ZjuNuzJ8j5VmDyk47o/SX/lJ
 tuctbcdvyKNOr2qF11gc66J4bVvJO40C7hmsW6WgygJLZltIgtskZi4biv7CMawdxKiS
 2thU+8km+GqLizQmS3obmOSm2cBXN4je1PB04fsHRv6hmJUdjAyxhCw8zKJ+vZGWM2rV
 R4JUeVOw9j30C6Hu8c11Js6nYkHgaESf7om0+FOzAiUWHLykinNskj1Xmf6auPqXE2wb
 IREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487225; x=1747092025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ktcl5OZ+t3GMcQQ7Jgx3PtMsJ0l/J5yPLlaHDm/4GNI=;
 b=bJgf7+4tfPpRr3hNGCmtkMgrLY1sb3jAjt56ONZF31YP+MGsEloIhrzLUKSCOrXivD
 ONBKPjrZQV1jxMR2vJ2o9ZncTNn679c4Ze8f0EZRgMIwI5xOs/ng9zNc15KovMNJ8K8s
 drJxNEcPy+EK+YcQBjteZr15HEm/UczGdU+97dgV6Z3rJTot7GyI5hwvUUek8o3moO3b
 H4m17px5dadlV/i8HaFIOBYqQbKScRmutWYy+x6uIIyPGdtAEystBlpm8/ycVvR8vj2X
 +A3L9zHJTIMbKOzntrJsg7jEc914isCxVB+pqfnaaf4wHP/Ps2leMQevGpHEML9BmrfT
 /DVw==
X-Gm-Message-State: AOJu0YxV8iZxjHwtIYFTrrRVWSzY0Up25DCWEpbsZSrJEkiFwwu5BmTf
 tqIfJWfOmZcBkohuzF/MW3ce3R9MOvqcPURNcakIMswl01GRSZcER0nI3iw+lLc53LGA7a0O/IJ
 xFVA=
X-Gm-Gg: ASbGncs6CZqyt38sK0gP5dVwbBICkc6OlT+KpRuPkLCQdjrL/l8w6bH5R5alaBJw5bs
 rUW8tz04HKI2bxzk6PNZxwb3igzULuFpewHc/hkK09lQA7j/OxJGFVMIqBtXHuUaquEobkf+BtN
 TFqQbEgUUIWNgpXHd+sM9QxbEkgibZoy3Rter6kHqYU8XiKwaiM47o0+DhoRvcEt8ZMkO9AzVWY
 fMWOBiXJTayFShwB5LmFcujF7ul4J1h1wzVWRmHn/WmafnnVnpswuizCjb2ZIx9+Qqu5u0yVcYK
 XMl6Z/V+aWA928Q44I4Hp2iBEYpjlE/A97E4hSWA
X-Google-Smtp-Source: AGHT+IEppQ78GCWxvrp1Kg3rIqo0UbIgXB98fJRAHTjCpcIyipY13SYl5qyGbdie65ZUaGKZqlqcrA==
X-Received: by 2002:a17:902:ef07:b0:223:fdac:2e4 with SMTP id
 d9443c01a7336-22e1ea1f373mr137466205ad.1.1746487225057; 
 Mon, 05 May 2025 16:20:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/50] target/arm: move kvm stubs and remove CONFIG_KVM
 from kvm_arm.h
Date: Mon,  5 May 2025 16:19:30 -0700
Message-ID: <20250505232015.130990-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Add a forward decl for struct kvm_vcpu_init to avoid pulling all kvm
headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h  | 83 +------------------------------------------
 target/arm/kvm-stub.c | 77 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 82 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 05c3de8cd46..7b9c7c4a148 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -94,7 +94,7 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-#ifdef CONFIG_KVM
+struct kvm_vcpu_init;
 /**
  * kvm_arm_create_scratch_host_vcpu:
  * @cpus_to_try: array of QEMU_KVM_ARM_TARGET_* values (terminated with
@@ -221,85 +221,4 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
-#else
-
-/*
- * It's safe to call these functions without KVM support.
- * They should either do nothing or return "not supported".
- */
-static inline bool kvm_arm_aarch32_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_pmu_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_sve_supported(void)
-{
-    return false;
-}
-
-static inline bool kvm_arm_mte_supported(void)
-{
-    return false;
-}
-
-/*
- * These functions should never actually be called without KVM support.
- */
-static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
-{
-    g_assert_not_reached();
-}
-
-static inline int kvm_arm_vgic_probe(void)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pmu_init(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-
-static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 965a486b320..2b73d0598c1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -22,3 +22,80 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
 {
     g_assert_not_reached();
 }
+
+/*
+ * It's safe to call these functions without KVM support.
+ * They should either do nothing or return "not supported".
+ */
+bool kvm_arm_aarch32_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_pmu_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_sve_supported(void)
+{
+    return false;
+}
+
+bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
+/*
+ * These functions should never actually be called without KVM support.
+ */
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
+{
+    g_assert_not_reached();
+}
+
+int kvm_arm_vgic_probe(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pmu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


