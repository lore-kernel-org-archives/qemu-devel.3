Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29478C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9c-0001nM-DC; Mon, 23 Jun 2025 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9Y-0001ga-H5
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9W-0000dG-DO
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so2047569f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681194; x=1751285994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9TcP7uZ8sj3k25ApWupc8E4+ydRbD8zQYT0ugNh7kc=;
 b=x0a+n3xsCkbXf+3bMpES750By6XlLaP2v+7WFgtu95XgvW8nEk0A47TaHGkTbmZ7w8
 rMpOt9jt3N/JbPrPLByBUZuMdOnXbjLzrF3z5kfoNvTzS8NYdyMfYyjBbVccsI7sWSHD
 YKwUrl9nYRBDaQY1TJUN7nNS/7R5j0kaJ220SJEQHQBuxs/ANgyfXmw8a/HIxfzRAQJU
 8wSmUP46V6maUxp4tqf64+XpFTa4DFZhFKf9XGmqD+hWhYPskYP9ubfQlpMhTnWaH4AH
 B/rGWZJHqKjqxAtRH+h3KRPmD2NTMZukqbVX4NX2YuHIrp2CEsni5fbAF22NP9yUZMfV
 8PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681194; x=1751285994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9TcP7uZ8sj3k25ApWupc8E4+ydRbD8zQYT0ugNh7kc=;
 b=vGuoiIPFB/lnGfWGQkUGlMW5o1vvD1n2SLvBxMMD5iRafUaAanuWQ1G4KOBsODbeR3
 JQS4GbdKjsYynGF5LWflaTW4RjEATCo0SCskVGgagoywBoPXJwTJCh10nZL6v8VU9v75
 gXpkEHXEwQ/yJ6yKbwZFTSFszu0lCzSVBOZGmZ1fmM0aaGWO0LSK5InlQAr3ug4Zry7F
 E7iULL2PNQngih+T3Weh93TUeK48GaLvQAaIbLxrXlg0sE/VH1cEAl8uQ5tPLTdl90RU
 l+SPyBEPvdJgYdCRUrNWfTFAYiatlaMTXglbgR7T7e4xBliIxYlZllPdNu9rPS6wMF71
 /tCw==
X-Gm-Message-State: AOJu0YyoWbXzGhJaQYYLZX++Wgnb/L1Vw1CZoi5OfT7grnK6NcM/Q/5t
 cG8RXW0As77z8wi3GdXPNjQimVtUHtndhMS9V7Ku+JnoH7kdeZlyWrtnrxdkpe7WZQBopP4tjZw
 cdu7M
X-Gm-Gg: ASbGnctDhrHIrCw6RdG25virl1XlPxWfhlHzFSXH8FVYGMoGNNDbZTY06/r2kYaHtPj
 TmObWO3rsb+Ec22K/JvWgUWjdSUm7ykJJhLE8MSvS7cPqYxrCWOGQ+Xc47p6LT7bK5N1MpBV9VQ
 wfVqSIYT83ORGha/Gydf88jQyBxXGvahAgOJEnOJXl1adNPjIaRos329vqXX8RWkMyGY4nphmom
 zKvES7JQRpbEALbVDVJshUrldFr/f4VQ6pBKeXKrkKLfH5DWcydpUWvVRNONQ3doysCRk+Soadw
 e79GydfDPph5u6LPQhAe8WiOzxmzuFBgTj7j1dhN25yaO7hmvSaj32pbWqoHgkPoMsgzwOQQAPM
 ykX/zpf61ubsWSKkemgLH57PhqStmMdEUPUX4
X-Google-Smtp-Source: AGHT+IEHiq/SjlZG6KJQYhM0dN6HzIW1qJU45zGcdqrFfg265NhL0FAhAnfqOQcq/6jydwJBpJn65g==
X-Received: by 2002:adf:e187:0:b0:3a4:f723:3e73 with SMTP id
 ffacd0b85a97d-3a6d129ccdbmr8492187f8f.16.1750681194323; 
 Mon, 23 Jun 2025 05:19:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f10385sm9537215f8f.17.2025.06.23.05.19.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 13/26] target/arm: Create GTimers *after* features
 finalized / accel realized
Date: Mon, 23 Jun 2025 14:18:32 +0200
Message-ID: <20250623121845.7214-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
index e5b70f5de81..ab5fbd9b40b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1985,26 +1985,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
@@ -2051,7 +2031,40 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
+#ifndef CONFIG_USER_ONLY
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
     {
         uint64_t scale = gt_cntfrq_period_ns(cpu);
 
@@ -2072,18 +2085,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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


