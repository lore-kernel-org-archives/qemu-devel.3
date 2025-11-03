Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034E6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFreE-0003Ud-Nj; Mon, 03 Nov 2025 05:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrdg-0002gr-1D
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:18:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrdc-0003iP-UR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:18:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47721743fd0so22230275e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165088; x=1762769888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3F2C6kHHPWBiLc/P72P8z+qmvtuhzoJzLzlQGryUqk=;
 b=JrXWm2i9sbKlmU/fHc334+I5nClMLqz9Bg41QWiBktGFaiI0UXO0GiUkC60J7mJkZf
 9xFV892SKWeBelg2hSVHGQ4gyvvqxnP3PRN76//2qFzvj94jzYZ6mf0LKqwqUsY3ynAa
 ysX4v1svlNIJakK5M3Lt2UKAKc91+UElxsJeneDvi6A3G8pB6MlptNnc5AVzfWaUHkgx
 jVAN64gfi94Opf6SEoPkzWHRXVorM6zddlc6Cl9rGhQW2GO+r4Eq6/iSFkAxUnTOhPka
 0VEHWmbN4st43GC85UzH4XhKcEU112MtlZ/82rWs6nJydqfUFJLqoJvwz8pfQfxQIjq5
 mvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165088; x=1762769888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3F2C6kHHPWBiLc/P72P8z+qmvtuhzoJzLzlQGryUqk=;
 b=cxI2HfEBeuBIszACqYxA0QotbEpUPubnFAi1NzsYe8CNjTW4/DWaYkEG1ekttTI0/M
 jAYDgJDSF/DJt6SMVynoIPlZ6fCUOCq3T1F7bGKmKlbuBaJvpsBqviSyLP4G5lgHeqLv
 Y0ThQMWdM82Wo60FDclLLOxL4RF0IRHNS01ahnlIdezuV9LOiaA6E6GDvgpn5FC035yC
 WsmrgidLs3cgroLjDnqG2KZOM+wAR/BfWTiGsGlLMRmS2oKJRjun9LWWeRdsfOj9hVSe
 eeg+TtdRoeMOk+k52n1bXqg1xAqx41Eq6mWGi6/QioF7B29Nc8WN51ZXhVAsUi5WMSTf
 ebOg==
X-Gm-Message-State: AOJu0YyhQAiL8zuHI8BgQhyLvpuujAdiZ22VYLqs+Z3QPS5owi7sYE5+
 4TxwzWRPJXcxsdxa93Q6GauHY5rgk3q4s2jEa++SDOGEXsi8XdJ4NoZwVd6UiNtPwYyh0zcGBks
 lie+nMOeC5tbb
X-Gm-Gg: ASbGncvu6dakyd6k4N/c1b2etQrFc52xxuPigWTQR3Pm4onHq6bRcNJxlMktC9TDsUp
 Aj6RQ7D4mCtd5K2Cn+Lm14MOSpUJPB5HfN7YgDgeq8eNdOQOdR6L8ZWqlwDvOIX/PVZc33hHvZJ
 qG7fTNdVoIin7Am1ATPMVlDv8FwPo9nQ7AzVrJSzSkPQ0DcLcBi+F8/iYox0AyMX3cMCPsK3XgG
 +cHmOji+XLB+BMJLiYB7hOWb3p7zm5dFdmyJOj09ze+qM+KQb/NySOLvcAdLEzSirLLvSGWKWdD
 xjJ3JmkjUnriP9gJMGoxuTJ140pRKfD61I8nmWki3NBWlNMucXlkAkRTxcfroQs865BWTHFuegV
 H7EBI8BvKxatqh42P3NEQVa8vjtJsFG+bCE//1f8fwqOauV/sEY0sz8CzsPddYnUKyEE5PcuBfB
 LHCFxHLGO3VCUfF2qk8QsDgzHySFFDoX4etR/iyexdVTTmgx880QGizQg/rkoniV9y9w3meg==
X-Google-Smtp-Source: AGHT+IEHuBq/wFHmCFTx2774ySWL/Ys5ewUJW7M2q5VLL+eU7EDIg5S4F5865RPivRb2YxgNsYDZ9w==
X-Received: by 2002:a05:600c:1f8b:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-477308a06e8mr99471905e9.22.1762165088224; 
 Mon, 03 Nov 2025 02:18:08 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c9737830sm13128551f8f.16.2025.11.03.02.18.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:18:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 17/23] target/arm: Create GTimers *after* features
 finalized / accel realized
Date: Mon,  3 Nov 2025 11:10:26 +0100
Message-ID: <20251103101034.59039-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc1..b392374df98 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1636,26 +1636,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -1702,7 +1682,40 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
 
@@ -1723,18 +1736,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
2.51.0


