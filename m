Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73101C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPn-0008Qs-GX; Wed, 07 May 2025 19:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPc-00087s-8F
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPa-0002RK-1H
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227d6b530d8so4593025ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661368; x=1747266168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH5ZtRCeVBPeaEwJ188gDPaPfkE7sAMWROIwRI8/rfo=;
 b=WsYAm63WuKJ52gNYt9q726MiToVodeiHtcotrz2vLOMYhht5oBGUs2e2w4CE3PimNN
 hqcmUP9SfonSPTZK+fg898StZD1ukqc+qkeRQ4UysRqkSyGYHcd4fzYuDaGnQOcxNYAS
 aLv15q9IwtoPX2BS0JURsd1jZPim6sKcR7Yt9z4EoVZTRbcnMawF13o5ETtIJsyBIe2F
 8gGHwI+c7wr9PBHo1LrBBUH54iR7lpKD4X96c0+rsA8HfcltZ0tTxFdEN80q/LzcEqX5
 gvisHu6P6hFdJ3A4fdBqM7s0y2F99Jkb5m/T/3hG3Ie2nXyzwrgblGxs/r5Ik10G+pH+
 zr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661368; x=1747266168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH5ZtRCeVBPeaEwJ188gDPaPfkE7sAMWROIwRI8/rfo=;
 b=TJUhJyZa9aBLyyn+yYh7Re7kCnEGmynU9wy3gVyPEcpK6xh1iLuEEcTg2MU2g9lett
 GYJd7SXjTVe/sbxSUmIwyUDXiM/3aphyL1bQkJzutplSXpa/DL9qx9BZLQlOiKp5meU0
 jO1wRTiztBdOy7+Z4QNJZEzUYZQ4kgSYsQS1w2hJq5vK/6MgDKyV6ykxAy6+zBKWGhqm
 +Kb4Ifpxr/iivPZPL7fKXE7AtbdEoeXmQ+/0PX8ZVyCCCcYu6ZKm0rwIToxWySZhR2iw
 jgEYi707YwYTadi0s2oxcQw0CNHKpyP7yEgpLXBoO22T3j5wdEQB/h1Iv88SVWEU9z3u
 OMQg==
X-Gm-Message-State: AOJu0YwyKW4q9T39VdCcXAsmW4lyoTrqQtOs8P/RKwnfapcclXq5sMok
 2NamFX1JdxhZCoe9wcQL57z28j6VwU+u7LN0j9thU7Kh5cQkJTKh0jJ+07Z8lcfN+i1q9qn8lFB
 LfmuK6A==
X-Gm-Gg: ASbGncu3xuLxrTMfKnF7gOQ3BLba8PMIBoCH+m5zjgP32fmgTcw3MbeFvqmrTxtWQwI
 UDl2A8+TOxHzykZFlxV8s9s/lqVFbXZdt9HImrIV8dTgF3UAFIU830sYPDukw9yHSyb815Hsb/8
 WOQIk1ENt2OfnymYhMpfVDvWecURcxNyj4kpOQXAAYJJjUGpYifWQOFexp/fg+aYiIeKprc2lyg
 SXjoXwId56fG9ubWorHlMQ9OIXWGK2xNqIluzUZxEhYtvqNH/E0JiErFx9K4cZHolS3ijjDOYos
 EQtl7w/F/k5Qa9ufFuq4CF6G+liT7wkvBEuvpd26
X-Google-Smtp-Source: AGHT+IFDUVNwwhWVulYfNSLoyuZxcW1zQrk5HN1MrlYxS3XpcmOjPsatZYcv0uHEc9J9FrqM7d+Acw==
X-Received: by 2002:a17:902:d50f:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-22e5ee1cc66mr81484075ad.47.1746661368656; 
 Wed, 07 May 2025 16:42:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 06/49] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Date: Wed,  7 May 2025 16:41:57 -0700
Message-ID: <20250507234241.957746-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


