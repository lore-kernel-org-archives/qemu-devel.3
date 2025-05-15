Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBB4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVn8-0004bE-HO; Thu, 15 May 2025 06:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn2-0004Qg-KN
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn0-00089X-QS
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a0bdcd7357so600199f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304769; x=1747909569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJ2vzUkmCNfhfxZp85kg68jtmVNXafBvWG/WJXtDBrM=;
 b=fSGTL+wwtDiiH4Qr0OI450+U8UOvSznFmjCc23siJq85ZmoThSd9cEaxFhEbNFCBRr
 dJCdIx4FaBnjlgs3EtrKfVLpxxI5t1rTPRKJfevVSaFUClXc2/xu0QzZi1yiGNOY9ov7
 biL6pcWrh6WvJDdNtejkhVlj5cWQXTNAyHJszGJhVzxtBegtfNVKEHDHtEPg73Vqu6UZ
 GjL1omSjSAa8ncYpO8WP7LMuUaI5e9u+r7CVqIJwETm7KiAZXMP+/AY67R1kmqAlOTxD
 iVtlNif2SjmfanKl6+0DOaB1YGHfvHsW4n2+f4/36U/nR7reDsNMX09rZi6SyKJ2J3KX
 mw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304769; x=1747909569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ2vzUkmCNfhfxZp85kg68jtmVNXafBvWG/WJXtDBrM=;
 b=hj5GndYg6PG8IRfov9obkwMBDAn1hT/jjJpPzNDMCCfrtvyqq6uIByufvQgFzLCfxZ
 0SUfxlltxaHYBAFdkrQq6V896AN4MM/UGgmIjGybp45uBKyQS4H4NhLpTazDsGKChrfH
 X/N5MMTkyAqQ2yucBRbSez3CpMUubtB8zLVsKkvt7xS2teN5RBXo91wgO06/uhDENxnG
 BfGzezb+FmKXmSkX9HYxTF0mDYrqN9E3uPG+2EkeePneKRy+dtZPbj+5rnJwGtQQwgQE
 jlHr0MFlO7Z4fZgL5dgbQQsMg3hvETvZUBKq52Q95iHJi9qAUcDSgxG35Cde2GtvMK5q
 8Nmg==
X-Gm-Message-State: AOJu0YxQQj41411/zTsf6Pi/1sdRgDZ9NHp3RCED0d1smLsR2zlWnsE7
 V7Kzlgnf4OUSKonT5CTW2P/hioibFM6g9zEgvGoFzJs5CRata+k7x21EC93cJ9L99zpTKH6aw9l
 CUBE=
X-Gm-Gg: ASbGncsafX82ig+Y30VX6Bw9hWLohGLTi0wGlPxH3TBdPOgkBwtFleqA0EYcLdSKkzQ
 pgM8HMhTZ9o7y9ij/J905ZmLPQ4BCo8o8wBu/zmTDZMM9haQwGCPO0v46k+D0apo1ZhO/ozxwby
 11YBLpK3llWVoSGM6rHU3+fMOoxuJh5c7KK+NVT0ZKrLSbCO4UB7CCgGW4KavP9S4L3AD4Bs7vS
 WZ1EXwrcpYWLHZugsz6ThZ8B5xlYjENt1Uz+Qikf0Ln4fKWrlZP2Ag3uF47Wo9h+SQpo7FIDAuI
 wAi+vhH1yRdZW07pdvpO6b+9aAIsC/Qx/X8Ivtl7+vFLXNx6hT6lzXccpg==
X-Google-Smtp-Source: AGHT+IF++aw10p+JMjrAJMTYyjK4P3m9CsxNUT6eVRVxkY7GRbOqUaA81qo3Rv8dwD3KZz2jyIB4Sg==
X-Received: by 2002:a05:6000:4007:b0:39f:175b:a68d with SMTP id
 ffacd0b85a97d-3a349699c4fmr6323255f8f.11.1747304768816; 
 Thu, 15 May 2025 03:26:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/58] target/arm: move kvm stubs and remove CONFIG_KVM from
 kvm_arm.h
Date: Thu, 15 May 2025 11:25:02 +0100
Message-ID: <20250515102546.2149601-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Add a forward decl for struct kvm_vcpu_init to avoid pulling all kvm
headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-5-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


