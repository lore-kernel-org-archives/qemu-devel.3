Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A849C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLO-0005HY-TF; Thu, 01 May 2025 02:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKy-00059H-Ct
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKw-00072k-G1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso721558b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080637; x=1746685437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOxKXFGwCu039etMQxzOSUx9I5tz+a2xiou6nYotXOs=;
 b=ZMND/4Cf0TWwzQXI4mJn9fEhySFKXgHtrKebxzNqoUPB1e6Ls8B2cqq0/eI7CFlPeO
 SPSH3Cx2FwyfWtDhhqLe7dr5qF6NUSeg3jUfw4MR+Re8phFAtUb0JDhc1Q+r5AVY6qLQ
 hcNTBh1ksWgh/Ht6zFc/WCEMS8Ned7w72lNSAz3AzgJsMOowJuSqJmEb5vrjMK3orbTG
 DztlCAxGDwAcT4zfu8ikChIhxUOdhIQ97F6zk8L/yxrqSihN/Odhz2404WVRFvz1/qnM
 qG7QhuonmLl6cc5GE3cuUWyhq8ODGFNDFe18WXUHbz5KHGfZdqy17wxXhpY8bmbs7PTt
 Km9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080637; x=1746685437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOxKXFGwCu039etMQxzOSUx9I5tz+a2xiou6nYotXOs=;
 b=kK38LgayciPyJb3dCtK8kQqSaUwbHUOxeKtvHb4fyanta/1B0ZnGYYdlguarZgyGDJ
 TKVLS/pJhVh8iVuAQV0W5p2Qr0VUuXFlmCbFmZZ3RPAlX7yyj0yKNVpiYNf6rxq+NvLS
 VHW1xOGy2FG9ZK4MponvVgvZsBPXY3Ojul7+OjZGF2bRkKCl4/Y+yyXdshgg/z3E8jtg
 yuqvB/J57Tc4mif531gjYsCjFSiD2Z+H+XQ+mnL2ghgbWlf2iHMtXsq+LLK/byvoUtmT
 2rZQdi26puiZ+LPql0JfTX1G0ZPvG6acpFE277dDKim71IMSSpiiNj7K089WU07CI1SH
 cexQ==
X-Gm-Message-State: AOJu0YzAmHyC1BMJZTcuk/1zPXbbLeNTM0wAYZua9Pak3JZ03BzmFxod
 mHI3y/Jb1E9jrlp6MhlDXFONK0ZDQhs7+OlaQcTcIDkFMftEyU9bW56Tlvh1/bIZYXihGVEI6xq
 V
X-Gm-Gg: ASbGncvmhmDTY1xBGaO18g9A2PeP6Z/ISehQQMQJTPYCool1QUI14NZMakZ8/+fJuMX
 VRIzvfq3KDFQwtjhf+dZICiGPp2D2EmLYsFbpwZ8v1SWfNGjh4it//miVxFaba1x76kLshBXb3U
 QRT7IQ1gdC8yoJo0EbRZSBDxL2srkgnOXS4wWcPY3tq7EALVglf+5lyN7xl6RsBYrHMDPDw7FuQ
 9xfX0lwfhBYgqAefxgigwKtyRh+gdwczX9TU3uyCrzf6uumsNc+fANidjT58Obw5RON594/vnW2
 C3zgrA/o7v4NyK+2RPvXb0hHe1RlM5pl9GyOMsZS
X-Google-Smtp-Source: AGHT+IHRnR+IPmf7SIZRqz2UrjJSmL/cOAzb0b8262p6NW8Ku0JmPcQONHO4WRpvOKQAo1aOXHsskA==
X-Received: by 2002:a05:6a00:a96:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-74049239b22mr1705425b3a.17.1746080636763; 
 Wed, 30 Apr 2025 23:23:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/33] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Wed, 30 Apr 2025 23:23:17 -0700
Message-ID: <20250501062344.2526061-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h  |  2 ++
 target/arm/cpu.c      | 31 -------------------------------
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 7b9c7c4a148..d156c790b66 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -221,4 +221,6 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c60..07f279fec8c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1099,37 +1099,6 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
-{
-#ifdef CONFIG_KVM
-    ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
-    CPUState *cs = CPU(cpu);
-    uint32_t linestate_bit;
-    int irq_id;
-
-    switch (irq) {
-    case ARM_CPU_IRQ:
-        irq_id = KVM_ARM_IRQ_CPU_IRQ;
-        linestate_bit = CPU_INTERRUPT_HARD;
-        break;
-    case ARM_CPU_FIQ:
-        irq_id = KVM_ARM_IRQ_CPU_FIQ;
-        linestate_bit = CPU_INTERRUPT_FIQ;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (level) {
-        env->irq_line_state |= linestate_bit;
-    } else {
-        env->irq_line_state &= ~linestate_bit;
-    }
-    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
-#endif
-}
-
 static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index e34d3f5e6b4..4806365cdc5 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -104,3 +104,8 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 97de8c7e939..8f68aa10298 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2468,3 +2468,32 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
         cpu->kvm_mte = true;
     }
 }
+
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
+{
+    ARMCPU *cpu = arm_cpu;
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    uint32_t linestate_bit;
+    int irq_id;
+
+    switch (irq) {
+    case ARM_CPU_IRQ:
+        irq_id = KVM_ARM_IRQ_CPU_IRQ;
+        linestate_bit = CPU_INTERRUPT_HARD;
+        break;
+    case ARM_CPU_FIQ:
+        irq_id = KVM_ARM_IRQ_CPU_FIQ;
+        linestate_bit = CPU_INTERRUPT_FIQ;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (level) {
+        env->irq_line_state |= linestate_bit;
+    } else {
+        env->irq_line_state &= ~linestate_bit;
+    }
+    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
+}
-- 
2.47.2


