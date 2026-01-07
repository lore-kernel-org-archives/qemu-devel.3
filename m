Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3057D0D172
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda6m-0003lJ-7Q; Wed, 07 Jan 2026 15:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6i-0003iQ-Be
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6g-0006P2-Nc
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso11651015e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817573; x=1768422373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1XWIX49d0Vwn4pfuIJOThjNhdUUETepsmnFQNONRfA=;
 b=SJsscLJzEqBhdaOBsdjj+9uZeZ7WDDkNkpK6LP4+E/JOsTjdhzs9Bz9yYNCgbbJ7mb
 CISeZ5SR1Ev5/zfDsU7ZHb4Py0fck+VOomob5/pm1v7+P+cp2qZbi+3KBEh36JbRHMWM
 uOSk1qSCzEny25Jpff1N0xpZCX3brWYJwfh/1Uiuf+XMQ8LgwV+vPh0s0R2m+KZROSjL
 MYznSTjkOz5nONlb28QXnJrNJF5nWoQoA7R33Y6KBZaiJZXJyWUnvnDqA/lXWR4uiRhL
 9HFS00CPWIJm0gpYgOLCjyWtxhOl+tEmoJuUQWbClK6p0YN1DFq8gV/FMESioadThe0o
 lc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817573; x=1768422373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q1XWIX49d0Vwn4pfuIJOThjNhdUUETepsmnFQNONRfA=;
 b=Rj4iRQNpxIFYrvLFrMP8TE1oNRftnZXTiKP+it/PRRjX7CvLEPwNJZAAyNv5GAr6Rc
 q0TFsKerWUAmRXk619/cT6y44cs/1/BT5ChJWvsei3qLhjP0MCRl8ScN843hcNKxSuDl
 d15q484iNnMVOYq86inwmXRFar737DA/yPGZJUvfp9QwxSInyFpjgmXgW6s/USO0BAjW
 M22ntpuBFEEYAKJkUiDQ8Tzaa5Cun9bJKa71WEGZ7l7Xm1VglaHHdGY+xwcLto8PD7Em
 q2fOc97mvr+Zw9sy/uSHz6cfWz48LSywa4AqiHshBTn5QD80AQnrE5AAD6qSgzYxA0Je
 eesg==
X-Gm-Message-State: AOJu0YzrqbkOorw/gOvyKwklI2Bo+t0Rgti3LR3yJ356gYC2OwFmk/yi
 V2cqkw55BW9GebHUr60QW9qAhyo/3PKihl9h0zGhoGe5ql7shQD+XMKxk+F3N75HSJiiqnj2hZF
 DJLHDvwE=
X-Gm-Gg: AY/fxX5SMSBZ2x/BRlEvWyqsnSAQFdTRNIIeo/+UUSzfbBQRQYJnabfI7p4hxdwCCze
 VSz4sTPnuJ78jN1Fn1myoJ2j6quY8PuwZmp0vkOYnJe4ImXPCPIJFsFY6E+pcfEJvTul8YzBF30
 MLnJU8VBLBET4gx3NJUm36bNZ2CX5eSXK8eRKqMsoshsnhj/8H6V/4aHxWcTm2mJPTYUm9ukFcG
 4Akf9ieDuFut1aVMVH8GfyHsLkxE5W5hADvQCVoQK8TzDQbd3Ky5eMZA4rgvFDeQFoNJ2NA+Mfe
 tr/ClvRwCUiwPjUJTtAGuuk9lKHVuAqh2Ze+L9QFwGIWypxiK/+EAQQL7DlGQGaqTX1q5ezrHqB
 LXNVs9G1HQiEknCVcyzqhxavCcpt8l+moVOGQjaorttknDWI5gJaiTUg6acczcMj3OxzFdMj4yv
 A0BLMF/OiQNJvPZ8d0BglP6cpBRpGbAnu9TAche+OBukBpgoEylWt1CJY1Vdqq
X-Google-Smtp-Source: AGHT+IG3T8IvUp/JoGzSsH6DyCDMGSToGTOhWVRPe1rDkdZTENGa9SiFMfvPOUj6sz/np10v+p3iIA==
X-Received: by 2002:a05:600c:524f:b0:477:3fcf:368c with SMTP id
 5b1f17b1804b1-47d7f616361mr97740935e9.9.1767817572812; 
 Wed, 07 Jan 2026 12:26:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5eesm12386548f8f.34.2026.01.07.12.26.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] target/xtensa: Convert XTENSA_DEFAULT_CPU_MODEL to
 runtime (no MMU)
Date: Wed,  7 Jan 2026 21:25:51 +0100
Message-ID: <20260107202556.55787-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Similarly to the previous commit, now replace the
XTENSA_DEFAULT_CPU_NOMMU_MODEL definition by the
xtensa_default_cpu_model_nommu() helper which
evaluates endianness at runtime. Update xtfpga.c
machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu-qom.h |  1 +
 target/xtensa/cpu.h     |  8 --------
 hw/xtensa/xtfpga.c      | 20 ++++++++++++--------
 target/xtensa/cpu.c     |  5 +++++
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
index 66992d08c2e..75b97632453 100644
--- a/target/xtensa/cpu-qom.h
+++ b/target/xtensa/cpu-qom.h
@@ -39,5 +39,6 @@ OBJECT_DECLARE_CPU_TYPE(XtensaCPU, XtensaCPUClass, XTENSA_CPU)
 #define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
 
 const char *xtensa_default_cpu_model(void);
+const char *xtensa_default_cpu_model_nommu(void);
 
 #endif
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index fe2f25e527c..85399390044 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -605,14 +605,6 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
 
-#if TARGET_BIG_ENDIAN
-#define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
-#else
-#define XTENSA_DEFAULT_CPU_NOMMU_MODEL "de212"
-#endif
-#define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
-    XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
-
 void xtensa_collect_sr_names(const XtensaConfig *config);
 void xtensa_translate_init(void);
 void xtensa_translate_code(CPUState *cs, TranslationBlock *tb,
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5fd4d655557..3d7afcad4cc 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -609,10 +609,11 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx60 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
+    mc->desc = g_strdup_printf("lx60 noMMU EVB (%s)",
+                               xtensa_default_cpu_model_nommu());
     mc->init = xtfpga_lx60_nommu_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model_nommu();
     mc->default_ram_size = 64 * MiB;
 }
 
@@ -643,10 +644,11 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx200 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
+    mc->desc = g_strdup_printf("lx200 noMMU EVB (%s)",
+                               xtensa_default_cpu_model_nommu());
     mc->init = xtfpga_lx200_nommu_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model_nommu();
     mc->default_ram_size = 96 * MiB;
 }
 
@@ -677,10 +679,11 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "ml605 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
+    mc->desc = g_strdup_printf("ml605 noMMU EVB (%s)",
+                               xtensa_default_cpu_model_nommu());
     mc->init = xtfpga_ml605_nommu_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model_nommu();
     mc->default_ram_size = 256 * MiB;
 }
 
@@ -711,10 +714,11 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "kc705 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
+    mc->desc = g_strdup_printf("kc705 noMMU EVB (%s)",
+                               xtensa_default_cpu_model_nommu());
     mc->init = xtfpga_kc705_nommu_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model_nommu();
     mc->default_ram_size = 256 * MiB;
 }
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6220edda976..f09b93622c9 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -46,6 +46,11 @@ const char *xtensa_default_cpu_model(void)
     return target_big_endian() ? "fsf" : "dc232b";
 }
 
+const char *xtensa_default_cpu_model_nommu(void)
+{
+    return target_big_endian() ? "fsf" : "de212";
+}
+
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
-- 
2.52.0


