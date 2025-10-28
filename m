Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19197CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd0H-0006t0-SJ; Tue, 28 Oct 2025 02:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd0D-0006r1-8Y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:16:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd0B-0007DK-4P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:16:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4298bada5bdso5032987f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632173; x=1762236973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3F2C6kHHPWBiLc/P72P8z+qmvtuhzoJzLzlQGryUqk=;
 b=WtfiCYM/2TwjZw86KVUAig5wCQNJEAjJJ6rC1s0lZq/S8M8Z3MjEP0CB/12jjyOsXK
 5lrH2fO+YbmAgGKTXnFYx1R1JzVSalKCRFXHBAq8XYnDjRBSRyCI4TYIQA2tA9m7Nwoi
 erOiD/mEG1TNNuToKW3T+YWY508gp3zd0SCp0yKcXzWdDzEg7gWH2vNMKpDu6i69vRD9
 /Ws+J6XwWTOur6GeXmx0+ua7cQ/qHHcFY334VeSHZGy5OIhvqSvsmJBjabQ1MZImRMPJ
 wg49am9uaBBSe7SwpLLXqMAzthgueAAzG+18KuFFlqxiFDqOPwQxkEe5T82FsRFGQQdn
 yxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632173; x=1762236973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3F2C6kHHPWBiLc/P72P8z+qmvtuhzoJzLzlQGryUqk=;
 b=bAqPD/g8SfVStXkZQdTwsABHtuBnjDGkMZxm9nle4pmDR8DD7afvx5T2bxyRcJeMiI
 WPXOYHgUuEFfyx3zZW4YnlVr9S/29nycQ+5nbPtQQmlEMB5LcKwh1gkDfXh43CRrz55D
 SqfAQdu+6dyoPAj9XOlFZiLk0futIPTD065s95myrcaL8qqX4Q0QKea5JGy4Bxi1zspd
 MfXIWbfGo19b5gic8f44ah2/Hkxky0nXz379YWxYYlDwx1dDoNmowMAFmOckeRzBKtuc
 Kpf+EXFbqaa8TWsZUKJUA2yC8OBSCxvHs/0mDOMtbxpyocTIjy9Iqth+8uL/aDGcDzB9
 P3Dg==
X-Gm-Message-State: AOJu0YxtG7heKFD/30RiUUSjcOMcIa0ZqGKeJxuFi5Q2tFB1QmaucCit
 ncD3y1YdtPXn5+9ub3tvoNDprljAUN6P1shzaVju6KKf5wxBuOnAYR1eBYcLW33GFQjp9net7aU
 v2ROytV4=
X-Gm-Gg: ASbGncuKtoR3Y7UkNPM7YqwM35CZHYtUQBGZT0ij02vXrIYdyQPbAO2DaoVgHdRQOcE
 BVlGGs7z3xh3JtXnxkmzRG6nbIRDHQ2Wl8mUIDDZenLs97SpqkBDm4uMPNUVG/ehYlBmej0ea6Q
 ff6OAQ1xP1Dd223g3YSDlhnkifxVOlg7x+wuruK6OMir5Qi728xPy+UGtXgoijEGi6/ioIOXDwt
 FyaiQjFYyAx/IZTkE1ShncMhiSLLgqjwctNyTDpfWGJqNoYXm2Uy3JDbPxiTphzl9v8mEdOUhFz
 YiJzMw4TqecTHorKzfugRg7Dzqd0jX0pM9CXWE3cIGEkNBfIvyVM2CXkmSBrbWEcL0A7Qsm+iP6
 IQuYI0NZORHWnVuWsiLli2uR4X46pzhy3tDx5fttWGtSaPO9CAoZmufxIinkVVfuDRtpxuPJRYK
 6PBo/PEWkMhdSzxqDMwzLWzfsq/s/2MGWeeKoWbRRDK0zngV8tflQ+lB0iEIo7HFSQjg==
X-Google-Smtp-Source: AGHT+IGb9T3YcMPO7ReDLcnf+Bx79AaMQRQ96dRDiGzO8YEaWlDWsmdkTs5JF+do7TRqsyEPeV+dWw==
X-Received: by 2002:a05:6000:40ca:b0:429:8b47:2f35 with SMTP id
 ffacd0b85a97d-429a7e59bb8mr1623077f8f.26.1761632172878; 
 Mon, 27 Oct 2025 23:16:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d514asm18420589f8f.23.2025.10.27.23.16.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:16:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 47/59] target/arm: Create GTimers *after* features
 finalized / accel realized
Date: Tue, 28 Oct 2025 06:42:23 +0100
Message-ID: <20251028054238.14949-48-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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


