Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7AEC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmu-0004ND-VU; Thu, 15 May 2025 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmt-0004KR-DU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmr-00087s-Ac
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso5029985e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304760; x=1747909560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zvEbnDk7n0V5mA6cNTidl4bv1ZVHjjW3TCNPh3U2qMA=;
 b=zwySI0dITlL7WXBSu1w6qX41xHVbM354LJ5nL2UKcRirIQN6pQZUspNYQNdDlyxu3L
 bo2DpTQ/UviG1C/bXqptogfDG9DKokdCCQOJ7Ce3MT0Qoso3w3CdgJ0sHjjfa39jMqBk
 fRLnqNsT15tEsnizpVjaeihl28HZQR8YYULijV4sNgA9q4DD3L+Bj/n7VnGoTQhDUsLg
 UfGoOUpjYEMLcHMUpixb1oFlDN3zRhQGxZ+UfLipFLELE0+a72XgiET1nHDeY+0sx63l
 KqJcHou5KTL1fQcEtKqijGHdoTBMVYtK0i8IUlKTlN3dI4r1yOVppNf1BKxVKT+DLN81
 Bgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304760; x=1747909560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvEbnDk7n0V5mA6cNTidl4bv1ZVHjjW3TCNPh3U2qMA=;
 b=WuUG8K2LDL5T69cN8ayAhuQ74QKL/Nv5bO1YcLqmL5MttIpD9VEr46SuSNhanSHyUw
 lYazs5T7p1OHpULg6Fe0j9aN3DyWmMNkhIlnucTZmGw4+vYDXHzkp4udwCtgTsUTQIwt
 Syrl7mhlgtRtjVte0RgvNGuaPNqfeQ8eey3BdOMcDNGlCU/xtvk089qE95oj/V3faUno
 q3Vy1402kkmAFg4srXKA776fBOKF3mTHXDZ8f67bSddQmaepGlwC0uhgbc7vyLSQaOe6
 h2bTbG6UbwdMDkVPXfZ+dyc3HYAs1RzQVOBfyyDXekhQ36rjxdkE7INy3vvr1PrdvRWr
 zeYQ==
X-Gm-Message-State: AOJu0YyFafdSsVzWKigJNa0QLva4GAznaJYNT6ZSt3q6gLOLxY7VzAha
 RPiO9V3SCPpLMM/r7CxcSrvenrI47vYSPbiGaOuu6cmwgoJpPoZaxglW/BndFm33Y55v7V7JDnv
 iLy4=
X-Gm-Gg: ASbGncsmiJ3s/sBL/0tyRfVgteSd0/dydUDplUffTaEhaxta+JYv1I2cRrZj+U2RzY3
 W+G8ccHfEib/CzCA2AVkcjvelPFAbm6p0RZ8Adznmf4BOGexqcjA4fIEul2CDY1xwYr1h6kj6ec
 UGiLNIyABL+5C9pPAS6xaWmLzyf+QZJNj2v2N4D7JBrpdtELLWLYtuQiIAksl4+N4ChwZwWO7qf
 owXkIz16hMoTiimoc8V0Y/+mciS+Hm9zqTOYuIgE9KU8p5XVElFVTjRrkvXmwb6NI1CQSfSA8Ei
 FrnHSGhvqoYjs6FFQx71nQtte18pljNKrvHwW105oRJAPYXM5uUCPO8S/w==
X-Google-Smtp-Source: AGHT+IFpVaKGS/8mXXZpESh7090WTYueSXj6RvKPocg3ZbSFsuCr7MHXcRy9j9xeX/dKyqm1Gua0cg==
X-Received: by 2002:a05:600c:5128:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442f2169795mr45289785e9.23.1747304759650; 
 Thu, 15 May 2025 03:25:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/58] target/arm: Remove TYPE_AARCH64_CPU
Date: Thu, 15 May 2025 11:24:55 +0100
Message-ID: <20250515102546.2149601-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The TYPE_AARCH64_CPU class is an abstract type that is the parent of
all the AArch64 CPUs.  It now has no special behaviour of its own, so
we can eliminate it and make the AArch64 CPUs directly inherit from
TYPE_ARM_CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429132200.605611-8-peter.maydell@linaro.org
---
 target/arm/cpu-qom.h   |  5 -----
 target/arm/cpu.h       |  4 ----
 target/arm/internals.h |  1 -
 target/arm/cpu64.c     | 49 +-----------------------------------------
 target/arm/tcg/cpu64.c |  2 +-
 5 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index b497667d61e..2fcb0e12525 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -28,11 +28,6 @@ OBJECT_DECLARE_CPU_TYPE(ARMCPU, ARMCPUClass, ARM_CPU)
 
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
 
-#define TYPE_AARCH64_CPU "aarch64-cpu"
-typedef struct AArch64CPUClass AArch64CPUClass;
-DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
-                       TYPE_AARCH64_CPU)
-
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6ed6409cb7a..302c24e2324 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1138,10 +1138,6 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
-struct AArch64CPUClass {
-    ARMCPUClass parent_class;
-};
-
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a396c0be3b7..702eb1a5483 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -354,7 +354,6 @@ static inline int r14_bank_number(int mode)
 }
 
 void arm_cpu_register(const ARMCPUInfo *info);
-void aarch64_cpu_register(const ARMCPUInfo *info);
 
 void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e527465a3ca..200da1c489b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -781,59 +781,12 @@ static const ARMCPUInfo aarch64_cpus[] = {
 #endif
 };
 
-static void aarch64_cpu_finalizefn(Object *obj)
-{
-}
-
-static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
-{
-}
-
-static void aarch64_cpu_instance_init(Object *obj)
-{
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
-
-    acc->info->initfn(obj);
-    arm_cpu_post_init(obj);
-}
-
-static void cpu_register_class_init(ObjectClass *oc, const void *data)
-{
-    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
-
-    acc->info = data;
-}
-
-void aarch64_cpu_register(const ARMCPUInfo *info)
-{
-    TypeInfo type_info = {
-        .parent = TYPE_AARCH64_CPU,
-        .instance_init = aarch64_cpu_instance_init,
-        .class_init = info->class_init ?: cpu_register_class_init,
-        .class_data = info,
-    };
-
-    type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register_static(&type_info);
-    g_free((void *)type_info.name);
-}
-
-static const TypeInfo aarch64_cpu_type_info = {
-    .name = TYPE_AARCH64_CPU,
-    .parent = TYPE_ARM_CPU,
-    .instance_finalize = aarch64_cpu_finalizefn,
-    .abstract = true,
-    .class_init = aarch64_cpu_class_init,
-};
-
 static void aarch64_cpu_register_types(void)
 {
     size_t i;
 
-    type_register_static(&aarch64_cpu_type_info);
-
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        aarch64_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i]);
     }
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 29ab0ac79da..5d8ed2794d3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1316,7 +1316,7 @@ static void aarch64_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        aarch64_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i]);
     }
 }
 
-- 
2.43.0


