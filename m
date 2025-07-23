Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47560C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZza-0007DE-5m; Wed, 23 Jul 2025 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtL-0002u9-7m
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtI-0002qc-KZ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso4393833f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278734; x=1753883534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiARY+eRyGpj1UCxkCuj/Q44h4QzLd4Og99m8x5oSqA=;
 b=uGPGDRiJgJW1Ri8NI0SiF3R9RoFiekE5OxoYU/wvTCsLNPu2TPSq8bXYNdLGoX3sM/
 WaX50YtTEP8NWdm54cSZ/jWPTJzJM5KjFAERwgMvH7S2+F25cgYofQgprOPYJH6OgxLl
 OevAsgmG85WiSvk80FRlzDgL3l9+hMcVYYFiG1RzQ2htGS2G0Lzld3p9OqBitaVgfE0w
 nXKQReRAdoc0mtypcABjdk7HkRrV7VvWy06iHZJMFtTUaWHnHUS7SE0RA055W8j7B+yK
 3gxAO/9/erq4cbKEWxcJ+2sVPEmxE9WQO+pmX+TZHkpQ/HVjBIDQAwK9LjlM35ZFWNAJ
 N//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278734; x=1753883534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiARY+eRyGpj1UCxkCuj/Q44h4QzLd4Og99m8x5oSqA=;
 b=FxXi19pRL71RU9pM18wIxVSCj6wzEPKDKr9RC2OTKxEDQhqewcv3lipk0yUz/6lEow
 m/NEAb9TJthS7eZYcrItyb9V9kZ2F4fVKKiRgE7RMQBgIx8RtIFdsgH+UIEqPs1xL2k+
 QrWvBgC/rsmTikfCgLUWZjz0F6MzV+38A5DFanvNdUGD2q8Ov9UQDH5gfZQ1Wv+PoEpu
 l1n+M1JOUtWzAHSQcpRuRopXEdkMpfBYauLl2A3nSvWHj64iNuS3idPGSqgv6/yCV2pt
 JTH2RNvBk5rK83E+EOwfDKn266nOqb3YNICmywyGC1oXYjcms5zf7tZXUvMRTxgHadOS
 r++g==
X-Gm-Message-State: AOJu0YzIiiBa0xpnCFOEsU1p/4qHmVjxIGH4yHmLtIN/VxV9kHD5b2tw
 GVwH/YvYm+XRuFgGAcXkRO2M6IxR4T5B3LpTeIrLJydWigOsnm0sijKavJE0RMOyIKhoBZXjGid
 r0Pdd
X-Gm-Gg: ASbGncuDOKRyG/cNbQ4C4wfHKck1S5AABLjUtgnvczkgVpuQWYZrpVZoDYv/mF5lWJ7
 ytOgmrechTa9qOcMMH+WiUvVxhu9O7IUiBxDHs2sTN25v6mVznzYbXJv/n9ew9iGzBWCFz+moRi
 4LxFTSyQsLLvY53nMKDdrluJ/arIolpl/ancFctFn0TKNOw9Zz+5lBG45Ox8ySDJaHD9daRFVCq
 CuI8BtQIYHvgqiYFqvXZfG/Aj7e0EwyO4ORtmh007moAgBZS7vppSaXHy8nGaYz2imSVCVkxOXQ
 O2kePEgZhE4Zfw6dzIqzPLQY7AeTKo2vpUS1DpSKwCszqzuu8544zvWdGuxRqTf4hW/aZ6n5EfG
 cOihEOB2iypwCfFc/q9oyKevBHa4Dh9ptcaGQBn419jBwVQRRnIIzQQS8aIBuJl8IbtxSewVz
X-Google-Smtp-Source: AGHT+IGOGeaNpp/3rjwqSfe7zdH2Up3/bgh9seutQ6iWn2IBT0XPLD6MPpsDf4oznKcs0iaK81+G4A==
X-Received: by 2002:a05:6000:2c0c:b0:3b6:333:256f with SMTP id
 ffacd0b85a97d-3b768f27e15mr2455163f8f.58.1753278733653; 
 Wed, 23 Jul 2025 06:52:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf4bsm16292187f8f.31.2025.07.23.06.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Jul 2025 06:52:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 3/4] target/arm: Create GTimers *after* features
 finalized / accel realized
Date: Wed, 23 Jul 2025 15:51:55 +0200
Message-ID: <20250723135156.85426-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723135156.85426-1-philmd@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Call generic (including accelerator) cpu_realize() handlers
*before* setting @gt_cntfrq_hz default

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399c..70755fc7e87 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1992,26 +1992,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!cpu->gt_cntfrq_hz) {
-        /*
-         * 0 means "the board didn't set a value, use the default". (We also
-         * get here for the CONFIG_USER_ONLY case.)
-         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
-         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
-         * which gives a 16ns tick period.
-         *
-         * We will use the back-compat value:
-         *  - for QEMU CPU types added before we standardized on 1GHz
-         *  - for versioned machine types with a version of 9.0 or earlier
-         */
-        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
-            cpu->backcompat_cntfrq) {
-            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
-        } else {
-            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
-        }
-    }
-
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2058,7 +2038,40 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
     }
+#endif
 
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    arm_cpu_finalize_features(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!cpu->gt_cntfrq_hz) {
+        /*
+         * 0 means "the board didn't set a value, use the default". (We also
+         * get here for the CONFIG_USER_ONLY case.)
+         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+         * which gives a 16ns tick period.
+         *
+         * We will use the back-compat value:
+         *  - for QEMU CPU types added before we standardized on 1GHz
+         *  - for versioned machine types with a version of 9.0 or earlier
+         */
+        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
+            cpu->backcompat_cntfrq) {
+            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
+        } else {
+            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        }
+    }
+#ifndef CONFIG_USER_ONLY
     {
         uint64_t scale = gt_cntfrq_period_ns(cpu);
 
@@ -2079,18 +2092,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    arm_cpu_finalize_features(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
 #ifdef CONFIG_USER_ONLY
     /*
      * User mode relies on IC IVAU instructions to catch modification of
-- 
2.49.0


