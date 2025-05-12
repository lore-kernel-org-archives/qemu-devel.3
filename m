Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD37BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXX9-0002Rh-1f; Mon, 12 May 2025 14:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWh-0002DX-Qe
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWf-0008RN-M3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e76850b80so34266035ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073115; x=1747677915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AlvH8T2wxvPoUN2cgh0nAAaoM8ETcHqqaWl8h2qra8=;
 b=mBqSufvhkQSFgGJv07J63ddFZaekeM9AP4brpuwccyUCr9KWeJ/zWhOWenccMRJeyc
 zJx18D2iC+C7eIlrXtvJDVX8x3BXwlJuiyHd0oYnrbJoEJxvE45GXRyKmlpJZHI1xuHi
 BLxkEAa8/uscd3uL2ikN+cypK1IpF1nCIlVUu252VloefIbhdb3w8fzzjVI1vyX5fD52
 AD+lJbhHdhm3eZdbCB0bJvdvx9b0QttSIaP0Xkn2CjrxX6lMjIEv/bv1riMu2tZqMePq
 3WhxzqcYvAI+q4e0UqNaPHjSfNzDhNghYlCoYAdLwBZ8psDuijiUOCPunRS2sy05iJlh
 kmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073115; x=1747677915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AlvH8T2wxvPoUN2cgh0nAAaoM8ETcHqqaWl8h2qra8=;
 b=KgjfrgqKZa2jws5KsKocOTIzx2pJwHxIMx8DwXMyzXy8Pz/I/8CzbgGWFnyn935Qlt
 O2mv9HXwMpbBFUvW38Eysk8bcX4KG16f3EVYdpXQPgtpI9iVCyojvkF/zo3VLVGJJpk+
 1uer5XhNOCDXhRek6WEThDG8oXPRvNbskWEeUnx+LJVaVCFcLhaunSC5UWY7H5bBiQjn
 gXwHCBxiIUSebOxoJUatLwqbIQYo7yRH8cWIMtb6M2TX14fcgqAdGcrMtcqkv2Kpf1rP
 y2oVN2on2NRYrCnmGetMmgnF3gL+QnorAxNqHhuTdiXuU8oOR2yXiArXTNwYoC974SGl
 rqKw==
X-Gm-Message-State: AOJu0Yx0ioEKc183nEwM+6mIW1dG1vA12MY/1R25TDkQShcKY87r07h9
 cnbGumrKfTDfNYLgqRjI9K5vf9EexhOVEHo0aEMKmviFK2CsuoJdRJCKP4oOnEtDWrMh55DnUVK
 z
X-Gm-Gg: ASbGncuQIxAPOCbbdrKkQe6ODqG+dF9Xh2wHy3GsWIanGb4oE8jt7XSsTkeb0gZemjc
 KinD6OTL4SRCyMKo+UqrsRj7DJh1O5RN06WClvcL6P57bVAiOGVF5vWYfXKmPRRL7e02jr3ory+
 e8JVNwazfn+1VhF203wZYpfKuvCXE9WJRn/dSnjqHDcWz7/N+dTYgUPTw1VYeQAPF7ICvzSgjKW
 KmEJKBgd7oLow0o2jCbRML0INvnHUgEUvm3vPHGlldKPSSNbP2SW/lgzAY5rqWo5VasZupSCYG7
 s5vecHPyAn9EuoyBKxSPfL9TJ91Khyj5DApk0mcMF82TzAtf13s=
X-Google-Smtp-Source: AGHT+IEtCiZ7pWhfj+zvU+QjNZ6OJ+sx69sEdRwyVqIutBYFsRWs/EvFgb05ePx/aof8VSDvqJ8C0A==
X-Received: by 2002:a17:902:dac5:b0:22e:5389:67fb with SMTP id
 d9443c01a7336-22fc8b0fab0mr193964295ad.7.1747073115383; 
 Mon, 12 May 2025 11:05:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 04/48] target/arm: move kvm stubs and remove CONFIG_KVM
 from kvm_arm.h
Date: Mon, 12 May 2025 11:04:18 -0700
Message-ID: <20250512180502.2395029-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
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
index 5f17fc2f3d5..5bf5d56648f 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -94,7 +94,7 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-#ifdef CONFIG_KVM
+struct kvm_vcpu_init;
 /**
  * kvm_arm_create_scratch_host_vcpu:
  * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in that order
@@ -216,85 +216,4 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
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


