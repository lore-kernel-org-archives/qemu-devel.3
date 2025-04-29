Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B53C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kvd-0005NP-PO; Tue, 29 Apr 2025 09:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuj-00056g-FE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kub-0005gN-PY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so4114091f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932929; x=1746537729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZwkigIUy0IIiAszFNbLpeUVLw4uBqn4OmPKEQckEf8=;
 b=OebY71w+830xMii18W0xfl8h8Aomm9SXj/sVMAxccyPhyZx//Wgc1hk59gcESGa2GD
 mfNzn0TRm7tekot+vk4Lgrrvh7/W6YPfSKq6u2MgGoEiVxlkoRwHJ5BsL+PztkvETYib
 HkjAPl3pY192riqkxfhPy7sqNT64kagGVKi4zaPWY9L028kcmI9tPQ2+Fw4qlFcx+GJE
 LHl3C1XBW2fLlTnr9U8LSMARHgPXb6DaveMJ1TViRq7xv+Pvvejulxeuq4oJ6RvJsJPp
 jKNALSBFEZxbLoHbr7La8BtimOVnc6ULravDyPN/7x/66ueZwmulU20MVSn2zeS6FDwZ
 gDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932929; x=1746537729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZwkigIUy0IIiAszFNbLpeUVLw4uBqn4OmPKEQckEf8=;
 b=itzfedcL8t4G/CbqQ/FYfpufkdq+2NpiBdFfLRmhynGo4ODnCLWJB5EBbcYaQW4COl
 aB2m/TU61uoUOG/a+aBYqRNnK5KOm7nBtUhQ1gSLIQa5mEHfImX1Ciox9qXMDMwNsKIN
 xTOcUjKWaNEowmhFKWLqqIFCKCBb2dtl3FO20cLXaKElIC9Zxx2zdvO52uDOa5S0x2/J
 XsuKDs7KMk0R71xeT34GNTJeMIl2GEm/deeNb2BGy8Ao9KQAJsSeBnWJHYVC9ZKeFaaO
 jjN5LSUr4Abdpy5bEj6/hqNFz+Pc8uVyGh5Rz7zZU3bmTvHhQUTIfVAeDLBwbHGn0UN3
 BWBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCT2KAqjfOH/uJa/G67DuT2Ngn/vJjn+tvdMlxnjrtrGJJcI3euJX6Gcpk1YLvZU6Aph6LaFkQmcwQ@nongnu.org
X-Gm-Message-State: AOJu0YyyFXnHqZ20eUDWn5bxmlQUg54/S/AhVBsYB1nMxA6AN7Da9ITt
 ntpfCurh7MVfFAGNGvBtfEql9ks2Ola+YgigVlVi+VuOUKY/LkkQcDhwdaobNYd3UKQ/goDm8WF
 4
X-Gm-Gg: ASbGnct8yTXtUF7b1cT26kwYeB4v8cVgXcPmQRjb8xm8PPNRemtHU6r6T7eWGXUM5xj
 JrNp+aepQqJQEec0Um1KDURtNjBRDcOOspdnwBqWWhY+PGndzivC7hUUEIr3zxmFyrnX/A1CKqQ
 +c3VD9rvxtLnmZOKsP9C4D9I8oy7qcp0hZAXRVBs3YCIbjHB9xE+5qpi/QaWNyTJiTlaZUbOM7Q
 KaeOwxTsisnrg8DXgIuzFG5lEA1AoMU4rfTITaBjiSfqUTVNs3Kxh7AuIMsRBItEyYjh5Ou9MVM
 whmi1BvmEq4kpmygSEqgiuSsIq6sEdvR2J6lG+y1pZT9tZo=
X-Google-Smtp-Source: AGHT+IFxI6Z9guiwoFXputfkjuj6m/0HV4z+gVSiFmysC4u0iNvAf5OrZxT/jhYqwpKainfr0VU4XQ==
X-Received: by 2002:a05:6000:2211:b0:39e:cbd2:986e with SMTP id
 ffacd0b85a97d-3a08ad28663mr2286164f8f.5.1745932929510; 
 Tue, 29 Apr 2025 06:22:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 7/7] target/arm: Remove TYPE_AARCH64_CPU
Date: Tue, 29 Apr 2025 14:22:00 +0100
Message-ID: <20250429132200.605611-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
index fdcf8cd1ae0..a394c7d46d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1141,10 +1141,6 @@ struct ARMCPUClass {
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
index f1c06a3fd89..7be34388fc2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -353,7 +353,6 @@ static inline int r14_bank_number(int mode)
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


