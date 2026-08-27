Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F7C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRXK-00078g-K6; Thu, 27 Aug 2026 00:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXE-00076M-OY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXC-0006Rs-BZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso19724525ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804173; x=1788408973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=83aT+OUoVaSXUBZswXWe9rjbvcEl2UZbMtOlAN3Bbm0=;
 b=mlqZTUjtGbWvHRKFGjxdtOaChXvz5kNhC4O0WmFdoHSZ7wj5u8tRcJksaSArj6sibM
 MzWY9qMzZ1Ve+CmBMBmHYezb0v6dLhJiSxidQ7UVvCE96mD1nsDoQ3Y80502IPrufGlS
 FSyZNdzzAHLAcIp6EOjPd2dq2nkyg8/z5LUmZCLspHTWKR/VpY/XxDxWLGhbc+1h7bBI
 wvgKzOFdV3ssjfJhKiQyJNVCeGU1vhNGaXq41WOx+m7yLrSMe7JRS1c4ePD2ydOqzP94
 tnArGSjKrrFaxr6QZfOpHoGZmNSpdh9M38mxUifOEpfb6odD9ePGpBHD9Wubs3aNF7vm
 zodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804173; x=1788408973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=83aT+OUoVaSXUBZswXWe9rjbvcEl2UZbMtOlAN3Bbm0=;
 b=pAYM8xD4D86m9Gk+1LPUh/T/rWvuIzBD2LEYhQnrgJ8sNTDKeXJYz4/eIz6KJRQUEk
 AbMKaLcgIw46k1QwbvWPJNk14tS8rcJOXrvKOOWC6K3taJwbGqBRaLPh0/tuytKniqD5
 ICo4V+Ni4MBoSZMCeifPn02U6Ck43P2FAnbjki2gpsOf7fyT+y3z0rGsSI15JHKFxyXE
 MK+faZ+ydW5UdOogDBhWB8CHRVfbqBSSgrQ+vC5EY7DUKOv6NBX8g5JbG/iS2+zVejFq
 JyhJmszuXfjsimC1/GQyoZ877oNvErSk/oTbsYCEg32TMDvtOWzC9P94XKUql5YlQKXu
 5+gw==
X-Gm-Message-State: AFuF++kMK5hHHpuT+9QAM2/+sNfnsekUzQUdVOnqBorpQsdEc5m6uQer
 da4jH4195eYnt58hmCJQqTt1xGvlDq3/UhPwDZJiS/54EEjviVgOI+Rju9VPyo5YrBIxHxqPrGG
 XZfbXgRE=
X-Gm-Gg: AR+sD113/rWAjylW0w/N9CP0RhlSbtPPQbI85kcaGASJ13hN4KJIIUTxFZ4kkUcOjZ6
 5YAdKvlnhzVM1xFhvaequoccebLsQDe+dx1u5YsLggXlqRihhp6C7bo6dEr/SXvwyf6cFJm4d1v
 I8cCAn4unoavYhAiQw1V2U7M+bMndB5HbJgSTlmDrGHDZX83KUbkLvfdziZGYuYNQ+ez1q3SCnv
 qhf725QDHkJvNymADP5V6U+d1XYKYFG9VvH9CJ8DBqMubwhbJZ0CJTrrWYFh4IYKU3BRHbudsiB
 xoLd1RhkT2OWCq1KlCRkjubabux18/AGPe4b3mX9UHU1AcHlSzfL+H9N7O3u7d5eQqIKSk/CLm/
 vKMWqXlZUoa91NPPCXSvf6GTouFUPI3KH6RV57jp+aDUx6rhAhf05m3YjgdTTfyv4oikeOQc8gL
 xQui3xn4IOsXY0ZtLlULyWNtsGn5EjSTK5TnjukdwsxAS/Kacr7BQMv+lPvaAacOGUCX7eSYjyf
 GVT3LWcAI1v7+D/W48=
X-Received: by 2002:a17:90b:4e8f:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-3966d4032e5mr26919545a91.9.1787804172837; 
 Wed, 26 Aug 2026 21:16:12 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d81682sm969597a91.7.2026.08.26.21.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:16:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v4 3/6] target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
Date: Wed, 26 Aug 2026 21:15:54 -0700
Message-ID: <20260827041557.775080-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827041557.775080-1-richard.henderson@linaro.org>
References: <20260827041557.775080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Rename from aarch32_max_tcg_init and take an Object pointer,
in preparation from being used with TypeInit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      | 2 +-
 target/arm/cpu-max.c        | 2 +-
 target/arm/tcg/cpu-max-v8.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6b4e173a54..fc7d5ad6f2c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1838,7 +1838,7 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
 bool el_is_in_host(CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
-void aarch32_max_tcg_init(ARMCPU *cpu);
+void aarch32_max_v8_tcg_initfn(Object *obj);
 int exception_target_el(CPUARMState *env);
 bool arm_singlestep_active(CPUARMState *env);
 bool arm_generate_debug_exceptions(CPUARMState *env);
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 4df52bcb08e..9ed45c8764f 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -108,7 +108,7 @@ static void cpu_max_initfn(Object *obj)
 
     if (tcg_enabled()) {
         if (!aarch64_enabled) {
-            aarch32_max_tcg_init(cpu);
+            aarch32_max_v8_tcg_initfn(obj);
         } else {
             aarch64_max_tcg_initfn(obj);
         }
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 5c0ba28edf8..5a9845d88f3 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -101,8 +101,10 @@ void aa32_max_features(ARMCPU *cpu)
     FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
 
-void aarch32_max_tcg_init(ARMCPU *cpu)
+void aarch32_max_v8_tcg_initfn(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     aarch64_aa32_a57_init(cpu, false);
     aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
-- 
2.53.0


