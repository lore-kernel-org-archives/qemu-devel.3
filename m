Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6635ACD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBa4-0000Hd-Fq; Wed, 27 May 2026 06:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZz-00007w-Q4
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZx-0001Mo-EW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so7057062f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878016; x=1780482816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hqnPZYQp8hrYDsAnwsPRdxvpE11beC22Q+5GnRJOyQY=;
 b=lHHpVlfU2ErOKPkJxH2FoVXeF4kPKtX2AmAguhgtEeTDwSCJFInVcVV6iYn7txOCJh
 YTMebVHktCuclpUKiAZ9illSY+44qFTR3vWrHvKpkFcLDwNW2uKWyJpKabeU7I8jwRbt
 rW0FJWWwXlyW2uYB7ELyhC9OJkTx1LI/vKg39L4FBY2iDk8W4liOov8pFdQ6kSrJYLVa
 JTTNpUZAltLMr0Sfx9sqsl2gIMYChyhGOI02JWQpH8EswHR32GaP0fjWQg6fk0krfPwd
 e2bDm1snuvqmqZtV5DyU9ckeo1Bagu57z7WGw/pu8Db0mZV8Jj6BMRpqaeh8d4ZzoRKl
 nT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878016; x=1780482816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hqnPZYQp8hrYDsAnwsPRdxvpE11beC22Q+5GnRJOyQY=;
 b=IVVdCT/mWl0f2FixklD1CKZw5fmuo66ukFZvBQ/yi24dQP2vTLIdGnAgrJEoRlQGUY
 tfkw3dxlRqsMHuPPsqq6TFdfe3dUeq5SerI6taG0wnjCgotpvOEZ2/lKTl+RSd4NPHC9
 FjqJsYSIGRPv43WTKr4GwbNiUr6HcNTiMAXA4Guow7DQg/SWNricp7K6Z88/7/TVTr49
 z4nmknrCJc29aDnlSfv9X5mebFB29isyqSqgM1IG9ZLKxSzCIRNmuacTgn3F6QLpMaif
 vwkUuaFWmd4PLsGHHrKiw6p1zfg9vilnaR3nL+O7gkvOh6u30M8iD22yJqBZvtzajuT9
 jbRg==
X-Gm-Message-State: AOJu0YwENkjbVbTVAAF4bLPZyP0rXHC0/Gk3bAtwRMA7XIBbAFvkkyZb
 IisK/YwrNnx18d91Bu53H2Dik4RNqk2PR0XIs6AVwCSZcJUG+pEJI8mVPqZElwVy+mnVrYwML7j
 8lSykm4JalA==
X-Gm-Gg: Acq92OEyjbehUFo/CKbiMk+ECwwmt2TLuOhtZrnZHbBwzQZtSAlTX+gdjA1ayks1cqh
 XgWrINkGc0/zoQGXnqX4OlwgNHRrwJqVo/E+fDqMr2uvOAnswDvPJsNKOn4U8pMwnLGZitC/fdO
 x22SnthvaBQzChB231DtqzzeSMTCeqZI1Kccm6RZj4/5Yz/UMPngfsj6AAufzKpYBRx4xHZ/40W
 0+ZULgDzNpkFBewPCRic7SZVJOM7ppS/Xi/oJqY7klrs0DrLNNvsRiNmPQK/0qcERHKf3i01QuB
 XiUz+VTcGVA2Wcl6+ueX2UVb7Q+b8kbzRp8Eezvblw+RQSsoGQW1z9HERfaj1mMWNOaKXMek31/
 ToxVxSu2INdTilTRTTjn/fyf7j9v1YNzzJ5v8MZ6T6PhcXJ+LhSvWcqsbVFePHn/UWHk6igFE/z
 a2ZpI5Q/lANv8GOYsoiym8YwoGmI0S8WkO7m7DEdJeTRJmhLl8HeKwrKwY8RcwjZIzvw==
X-Received: by 2002:a5d:5d02:0:b0:43e:b0f8:66f1 with SMTP id
 ffacd0b85a97d-45eb3afd371mr37004859f8f.43.1779878015548; 
 Wed, 27 May 2026 03:33:35 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5584b8sm4812875f8f.11.2026.05.27.03.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] target/arm: Define 'max' CPU type in cpu-max.c
Date: Wed, 27 May 2026 12:30:30 +0200
Message-ID: <20260527103037.4461-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather than having the 32-bit 'max' CPU type defined in
cpu32.c and the 64-bit counter part in cpu64.c, unify the
code in a single place in cpu-max.c. Define stubs for
aarch64_host_initfn() and aarch64_max_tcg_initfn() in the
32-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-16-philmd@linaro.org>
---
 target/arm/internals.h   |  1 +
 target/arm/cpu-max.c     | 65 ++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu64.c       | 21 +------------
 target/arm/tcg/cpu32.c   | 29 ------------------
 target/arm/tcg/stubs32.c | 10 +++++++
 5 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 27414e7481f..ae5afc5362e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1774,6 +1774,7 @@ void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
 void aarch64_aa32_a57_init(Object *obj, bool aa32_only);
+void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 6fc54ebe74e..8cf8edc6535 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,7 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "system/hw_accel.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
+#include "system/tcg.h"
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
@@ -178,3 +181,65 @@ void aa32_max_features(ARMCPU *cpu)
 
     FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
+
+/*
+ * -cpu max: a CPU with as many features enabled as our emulation supports.
+ * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
+ * this only needs to handle 32 bits, and need not care about KVM.
+ */
+static void cpu_max_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+#ifdef TARGET_AARCH64
+    const bool aarch64_enabled = true;
+#else
+    const bool aarch64_enabled = false;
+#endif /* !TARGET_AARCH64 */
+
+    if (hwaccel_enabled()) {
+        assert(aarch64_enabled);
+        /*
+         * When hardware acceleration enabled, '-cpu max' is
+         * identical to '-cpu host'
+         */
+        aarch64_host_initfn(obj);
+        return;
+    }
+
+    if (tcg_enabled() || qtest_enabled()) {
+        aarch64_aa32_a57_init(obj, !aarch64_enabled);
+    }
+
+    if (!aarch64_enabled) {
+        aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+        /*
+         * Break with true ARMv8 and add back old-style VFP short-vector
+         * support. Only do this for user-mode, where -cpu max is the default,
+         * so that older v6 and v7 programs are more likely to work without
+         * adjustment.
+         */
+        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+    } else if (tcg_enabled()) {
+        assert(aarch64_enabled);
+        /*
+         * '-cpu max' for TCG: we currently do this as
+         * "A57 with extra things"
+         */
+        aarch64_max_tcg_initfn(obj);
+    }
+}
+
+static const ARMCPUInfo arm_max_cpu = {
+    .name = "max",
+    .initfn = cpu_max_initfn,
+};
+
+static void arm_max_cpu_register_types(void)
+{
+    arm_cpu_register(&arm_max_cpu);
+}
+
+type_init(arm_max_cpu_register_types)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 499d154dace..28167355773 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -791,7 +791,7 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
 }
 #endif
 
-static void aarch64_host_initfn(Object *obj)
+void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
@@ -818,28 +818,9 @@ static void aarch64_host_initfn(Object *obj)
     }
 }
 
-static void aarch64_max_initfn(Object *obj)
-{
-    if (hwaccel_enabled()) {
-        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
-        aarch64_host_initfn(obj);
-        return;
-    }
-
-    if (tcg_enabled() || qtest_enabled()) {
-        aarch64_aa32_a57_init(obj, false);
-    }
-
-    /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-    if (tcg_enabled()) {
-        aarch64_max_tcg_initfn(obj);
-    }
-}
-
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-    { .name = "max",                .initfn = aarch64_max_initfn },
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index a2f730451fb..8220d785f5b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -711,32 +711,6 @@ static void sa1110_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000070;
 }
 
-#ifndef TARGET_AARCH64
-/*
- * -cpu max: a CPU with as many features enabled as our emulation supports.
- * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
- * this only needs to handle 32 bits, and need not care about KVM.
- */
-static void arm_max_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    /* Cortex-A57 advertising none of the aarch64 features */
-    aarch64_aa32_a57_init(obj, true);
-
-    aa32_max_features(cpu);
-
-#ifdef CONFIG_USER_ONLY
-    /*
-     * Break with true ARMv8 and add back old-style VFP short-vector support.
-     * Only do this for user-mode, where -cpu max is the default, so that
-     * older v6 and v7 programs are more likely to work without adjustment.
-     */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
-}
-#endif /* !TARGET_AARCH64 */
-
 static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "arm926",      .initfn = arm926_initfn },
     { .name = "arm946",      .initfn = arm946_initfn },
@@ -760,9 +734,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
-#ifndef TARGET_AARCH64
-    { .name = "max",         .initfn = arm_max_initfn },
-#endif
 };
 
 static void arm_tcg_cpu_register_types(void)
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index 3945dc49e5e..78f819ef6ff 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -22,3 +22,13 @@ void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     g_assert_not_reached();
 }
+
+void aarch64_host_initfn(Object *obj)
+{
+    g_assert_not_reached();
+}
+
+void aarch64_max_tcg_initfn(Object *obj)
+{
+    g_assert_not_reached();
+}
-- 
2.53.0


