Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED2EC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTt-0003MK-AN; Fri, 20 Jun 2025 09:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTq-0003C6-ES
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTo-0004gb-5k
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so19981815e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424906; x=1751029706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbJkhz3jwM/7an+ncj+kPtqJZzlzC4z2AtmZHXah0xc=;
 b=kz6nDLQxL7cOQ/4L1Q0iJKSGTsA+wCKVxr9WcTmC79JB9xUddiDuD27mNahfyyHsO1
 dl7Nkxnfpw7/hr5srkE2S+S6EPAI6QbNw7c48FzUDCGq2T4bNwZxbsEbqr4IZNZKF/PL
 h5GsOLExufkJkLu8c9iqIFQYgwy2xMeb21FvvQOvWV96I8OjrPmyvrzfXqYGY59e7TBo
 670lYv9ehCxuF9GQS72K+zvfSLtxEzHd+K86Ao7/xBriw+0yz+vSbZ5q4w8Wisd6Rp8V
 PzcK55dAF3T6luDlfrdzmuCtoRY+EPOOT/csBMHLX1TpFfWeIgn/YatTgvkkEsKBhygy
 zqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424906; x=1751029706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbJkhz3jwM/7an+ncj+kPtqJZzlzC4z2AtmZHXah0xc=;
 b=q8X9krGj/qtcXcKaYd57L5+sA5bOc55z4ZJeCUkJN/5Iito7+52N9uYeBm7znoJLEr
 4UQxd2NX45Gbm/hGFjZR+2LcLud6EJrvIbvQAigE8hR+8Kh+rEevnp3iAwnAhjo01i8j
 RcVqtaEZzCdgDo01yZDknuiaWSlCE3q5Hu1sfqXhrYWxGIOIsL4lvCwbUaDW6zYoftOh
 8ZX+SCrFpAg2g6ZY32W4cm2lL2c/u4Q1pFLEKlz7XNLeVSFDGpqR7cx/dTvWM9gvqcT9
 iJS7lsuTq1SN7VGbZh4Vs9+cLAmn+dmzFyam/lMdjf2S2f4EdwPZAChra3uppGdABJMk
 YNVw==
X-Gm-Message-State: AOJu0YwVra6KFdw6G0pi3M+FAA7E5Ajn/HpQcv62AXfsvXQuOeNSKA8R
 TeY6nuQGwj7Y3Pr07zqNsZknDOhorK/VH3vZP+mQBc+eyR7s7duzAjkcsqePfyp+4wyCsxhoqow
 giG4Aa2Y=
X-Gm-Gg: ASbGncu5s+OxVXLGBGyo2e1TkDChPVuLRrRr00r5drHthoNe3/FHUREE6jf6CZvYHJW
 U7lwXyxeJSurTclAHb7zhZeVJ2IfQeWE4PVqBR1WmekNGE1FE6u5gxFDKvGnp1jStfkUU3ff77A
 tIe6GcKO1r0dXT26SKqN9ZoUFGWww+fPllT0KHf2SEL62hkC8CnWuUvpSghXoIWYL+iq0mFJosR
 8IA9eB2oMRPZXaUOHg8dGATE13UcIW231pk2gi1Vg9bd6D1cRClIXZckt4J9NOaEUTyIJ9D0Wk5
 nxqVJwh0V2l9t4ivTy1FdX9Je0Z/Au8LRpCpwb6svyQcZLNYuFF/CklUJfLH9YDMcEmjRx8ArEE
 8LJOaSDmr2dVOTfO0gIE46g7irOu3dhJ40EGT
X-Google-Smtp-Source: AGHT+IEovICPCvjwxdsOFxQYVKyO0QusibpDDvB3y28q9auAAPau9mFOJbflgaPhOt3KoclCZXn79Q==
X-Received: by 2002:a05:600c:1d0b:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-453654cb826mr25614575e9.13.1750424906120; 
 Fri, 20 Jun 2025 06:08:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c41sm59776775e9.26.2025.06.20.06.08.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 13/26] target/arm: Create GTimers *after* features
 finalized / accel realized
Date: Fri, 20 Jun 2025 15:06:56 +0200
Message-ID: <20250620130709.31073-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Call generic (including accelerator) cpu_realize() handlers
*before* setting @gt_cntfrq_hz default

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


