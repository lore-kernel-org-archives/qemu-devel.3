Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C16D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtF-0004Lz-Cm; Fri, 16 Jan 2026 06:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsu-0003Tz-3F
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:56 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsr-0007Iu-7R
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:55 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432da746749so918499f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562451; x=1769167251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mdL+wHf2jb8vzNgdW5aXH6N99ClOOaSA46aED8I1stE=;
 b=x8Y/WCjEyUNBUs19Kv6D5OKEqN2pDsahqw8eW/eoQS3xrLdsCJjdGacg08bCrbwZJq
 ykxQINHvBKZ0VdTbZrE85U05NjSJRKJShEYh3uroezA6rz6b+sMkHlYjzUIJvGMZUft0
 0LBLTwU+HciyqvP9QVUi1PDw5DiJmjdaYMRgrhTUp6taH+T6nuUr7t9synrnmi8Yzf2P
 buvaoSuBXYwfwGlN7VFXmUaVF4eY6jiZ+57nmLQAJR9rHlduHvvoWguHqgrFzIkmjso/
 MIFmsj0VfjX1z1XcKz8BYzAWqNZQcTPp4xLVu4NqYqEwc443Bydez4hOEKNlFiBbO1VU
 VEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562451; x=1769167251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mdL+wHf2jb8vzNgdW5aXH6N99ClOOaSA46aED8I1stE=;
 b=Jqy6HvbHQu5uLjWKAH1fU3nYy4g3HQj8rMIQ+ZTSAQP6GXIg7FB7DywIlJJD5tUsfd
 1vRkkspEQDVx3VpymlM+UjeZY4yEXeMYHx7Zoadshs8m/kaRL/JIIyNwK0CrGA0NNQYX
 CNHugCSOqjEYq1FjO+jMZEg3zF5El4p3C5o4DlsM+ZeDPGL/4KEwuw97fvp7oTM6Dvo4
 wEgbkjB42Lo4SlL1N0K7Ir6Q+BlHv4FXq8Xsl1Gv5h7eRGZ1b+n0iFjxLCq80hZC7GcJ
 wHrTsp6XD1inh85jBAL7OvRx/hn27NYnWnePQGIE0d5y/1sLci89/ONUt61eWMmMojUi
 iOMg==
X-Gm-Message-State: AOJu0YzkaPslNcKH259U8wZ6YHCJp13xLljW7OQXJbU+kD1DBQwXNjyL
 3/ROlTWExZDGRlfyoxp2brtBm7FVHEomPQuUDGxehxAHUiXm5LYQkHZt0G80heX4d94UDJ3kH41
 ToJ4KS0s=
X-Gm-Gg: AY/fxX5VJ3dRw+7UT3ItsQAFrVARgL8sQBKFjX01z2lHBF2qirJUabo8ZUTi+ZRjJuy
 CIupzTirPX0ZSaSj2XOmhYrcTrueCHsJTvbCub5/ulLiKU/lht3HFAriOwpn68Ud5ZnbAAtLx+1
 RZxAuOUFGF/7ZlMcZfcd28W9hQnbX24GuAMaNGBj5TOEh/net6+GpICP9l8tdgKMuvVlaiEOtiA
 4Gk0hxe/5PjUHjR1YNtWPGIYIvu7p2CmXtIN+EsTwVA2pIsYKueC3ZYiNdBFlQYN6RehCilsXZC
 wGwXgkcDsgTkVIS/LqwSldd1GBJIaIORDBAxdy0Zf1XVRJj3YBqKXFhG85w6nCCuRwfTnitCOW7
 sd/73spPpjf3z3OcNAtM78T0jGt/Le2IYMnxl5nODqQLPYbe/tU5DdCf7ONk+JfU48xQwEzbcmg
 2JbwfMwOMD/jUkX+vBqAw3daINiYgFNJabJe1iNBfPAwTB0eKmlIhFChlm5ngc
X-Received: by 2002:a05:6000:144a:b0:42f:bab5:953d with SMTP id
 ffacd0b85a97d-43569bcbc8emr3056582f8f.47.1768562451200; 
 Fri, 16 Jan 2026 03:20:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm4699628f8f.40.2026.01.16.03.20.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] target/arm: Create GTimers *after* features finalized /
 accel realized
Date: Fri, 16 Jan 2026 12:18:01 +0100
Message-ID: <20260116111807.36053-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Call generic (including accelerator) cpu_realize() handlers
*before* setting @gt_cntfrq_hz default

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-18-philmd@linaro.org>
---
 target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index caf7980b1fc..c1087bf5b92 100644
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
2.52.0


