Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DBC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXL-00037J-1D; Mon, 12 May 2025 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWl-0002P7-FA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:24 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWh-0008Ru-0s
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:23 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so3243152a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073117; x=1747677917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH5ZtRCeVBPeaEwJ188gDPaPfkE7sAMWROIwRI8/rfo=;
 b=x6cFoFdGv6jxikpZaouTzMMzOSKSlmfyxT+LgNsOMStfrWJjXlS40ufqh60vFTBK4J
 ZoEdJMVzYsR4fsBVRkgUORMrQdqki+SZk4exGxNcWMKSV55n9RsdB8nvJqLbaAow/qbT
 29eLvvbIfkLRFfRm/SfKO2cZn702vfEHw0lT7vt5vSOaRed1XzRT+nopX9GOthGMUtZl
 a/VnoEV76xvKsGzGP3c2+CpHUP5uRaZs3S3H1zsVltpiIeI1S0fAHCK6W1EYOP0G4Aqv
 n2xq85955abHuVtRfdwASPHGlUax/i06alt50coc5Lkk56aphkVhQ7k39vDjGbYbmk8t
 HFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073117; x=1747677917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH5ZtRCeVBPeaEwJ188gDPaPfkE7sAMWROIwRI8/rfo=;
 b=mHEtNjRqBT3bHpIZ/VPTAFU9P0KPwo7+xksMQrAOWAdmAk8taaW83HoU0V3wA1CDYe
 w9RjZgguKJVvfDiEOZRC9FW1raIw+s0onWOLwgcK43dy8PwFp+vSd2gnh/vGfjZTAzOu
 vunupjPnK6WjFXlLbEM2Ah/6OXzyG5OLypDjSmZABO13X+mc6nbNs2y4GutDsdMYuAqj
 5Ckp0DpFlMBu3jKj0/gAMO3BWYZaCEVJqNmjm42R3hG/Y3UYQxW2+87Exq8PIqgYzbG4
 x1elEtYkEUWA1TeDZDdEdMd4qynH2HW3qa/lG8hXqc0rsnR9j1543Qt0DrjhEttsH83d
 JVgg==
X-Gm-Message-State: AOJu0YwpgupPUHoR5VjUPBgul4/vFV2vUv4RseGI725cafzWUbJeWC46
 Es7XCW22DiPaUimMkKQaaki4tBz5J97z+Aik0AaD8vM5H9IDzYp6ZFfXmzSbnkcu4FDw7C1pT7i
 E
X-Gm-Gg: ASbGnctKcxW0AiWOdLqC/DI8ICCR611Jdu065uTKykPQFIUFE+K1rfAbx3y44/eL3GT
 OVhxE/9zY0hzKogKv5qrCMN9izZMvNMovc8HgHdmb+fsUXHXGEaT11Hy4sLYG7WluFzldy+Yk4w
 eppsFcWcJoH2Ztw5RWrBZ35AMkRIT/y+fM/Zos6MEjamkHe79GB/cjFTgeMyI5mNoq7BA6q2Xwb
 BUW3B9b4k8vKRzmHoEbbBTrW3Wh0t28PMdBwvNJJpxfvH+ra3Xn/ZGW2168BIh0FDPXNQkqUay/
 9xyHCG+KzxL22cR+HojyueCCB466hv3OasBldyOLybAuETpZom0=
X-Google-Smtp-Source: AGHT+IETvanw0ckOxauhRh53BeO6QFOIvdwuGiTFcETu9+U7/rtOOWaOMqjOOmK8LiKZT11pMAkQYg==
X-Received: by 2002:a17:903:3d07:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-22fc91cafbemr189319255ad.52.1747073117126; 
 Mon, 12 May 2025 11:05:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 06/48] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Mon, 12 May 2025 11:04:20 -0700
Message-ID: <20250512180502.2395029-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Allow to get rid of CONFIG_KVM in target/arm/cpu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h  |  2 ++
 target/arm/cpu.c      | 31 -------------------------------
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 5bf5d56648f..b638e09a687 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -216,4 +216,6 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
+void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
+
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 45cb6fd7eed..d062829ec14 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1098,37 +1098,6 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
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
index 9c62d12b233..b6c39ca61fa 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2429,3 +2429,32 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
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


