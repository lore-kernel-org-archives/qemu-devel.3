Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B32CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtHy-0001P7-5j; Fri, 15 May 2026 10:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtHn-00017f-8j
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:13:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtHk-0004S6-HZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:13:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso83104445e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854381; x=1779459181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8aF1a7gJjQ7n0nAdGadLdH6XNXhhZ7j9w8BXeSbNoo=;
 b=Jx2BSCRXQ5KZHhhjZIEbHqLIM9FwF0DyVw4Pk3MjVgOEvlF3yiyB87NNHyh2KkYXSC
 hQsWmwvZPggfAAKho77wP9HSPjYqhbCZxIsMOErD4a9LDgREGG2TeFn3bcjXZbUTUqMC
 5V7FCy3ZdNEke27CbVBRuIMjg5+CBCiULBYg+x1q4hbYbxXyhkTV8RAWOG96rL502oel
 0Ww4NE+tPOjIx8pSfk0nGjk5zvKLkmX6U4EvGgzL6RMQ0p6B2q+hQeZgtFh+koppeXjV
 g0/qpQsRKDsMnwlXyWTHZQX1yX0rH2aBJc96/bIamTXe7K+kzJ6I22kOvKJc99Twmof+
 KU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854381; x=1779459181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8aF1a7gJjQ7n0nAdGadLdH6XNXhhZ7j9w8BXeSbNoo=;
 b=r60JX5kdo5FZ8DWR4U/DwKAr9jdWjpih5gWNiRl6orU8d1V3uuzhqKkPVxMCSO5MJf
 fXB3O4R5TJvPN3c7Xut8Kk9lEFSAIWjDJU7Um9o7rjo+ffotRXyVqwMlp8+mLqpIp2Sm
 rYV43R5LcOenGz7fMcPsnDvEpBzzgNULnTXmjShb+a4mLJ5UHeyyCZEMVFm+zPDiIt7m
 FydLqT08hDffNm/1Bn0p1Q4sLbESj6YpGghywgGSwhWcuOrF+LH2gaxh8F9fE5rYXRaO
 JDj95qCJ5m17aVeolMNOvIl7FVueMLjGdxIDOHigYYq44dz5EAhYRZxXRXmpI73pMQYY
 Ph7w==
X-Gm-Message-State: AOJu0YxLzAmfunyQdP0HIAkLYOUtMcSzc46drSHEpotdMvUC1Xzc3yUk
 aErpYVDuJlGEVbprYdZOBuubv4RSh8FXXU5Vt/OZU8/JDoTiLSv+lY8df8Fag+QXvg9+OfeG4sV
 2B4qIY+c=
X-Gm-Gg: Acq92OGH9T6zspMeCZIiMkqByvtEp/sGLkvr7QQYqW+I3JNlfNtN3R+0pN/jdYe8qgK
 GNIUUAqZYjVXBOXU55I+vPur+ibtqR3YaZeHp3cOhUM7a8RLaVCMr9XzPztf3rtWXBeKn7PB3My
 3mHdjhpM7DCa0tLXxYawiR/P6pwvI+q2tD1mpW/SKPGQdqpAME+eC9pISYgnQnyxktn6Q/J+hOH
 aFamwj8Lu9dENhE/NhcIrUKvsZEnX2V58kQvPqEvG5MS+xxPEPBGU01FVnhuxetv6iFf5+wRdJn
 vB+BFzlivCYAcXzN5KQszD6Hd7omiwgkyv6YeRwQ+l177XqpjWNZ9QI5+heBrVz+wwtT19EtIsD
 l/tjyMx76vVkgKfRT0CerI1DplPdWSgb4a80ce/7eaSnojY+XGELvAG5jhRW/PbTKb54ICOUTAP
 ijjWawcTvJHBnxHTwT/by6YlTPHgu/FRPPoSSoA4cXlMmSamgeo22r1Dk74gHBS2dBOM41nic0
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48fe60ed7b7mr53243485e9.10.1778854381458; 
 Fri, 15 May 2026 07:13:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c516sm67055005e9.13.2026.05.15.07.13.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:13:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 20/20] target/arm: Build cpu-max.c once
Date: Fri, 15 May 2026 16:10:31 +0200
Message-ID: <20260515141032.3271-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Call TargetInfo::target_aarch64() at runtime, allowing to
remove the target-specific TARGET_AARCH64 definition and
build cpu-max.c once as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-max.c   | 8 ++------
 target/arm/meson.build | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8cf8edc6535..d38bdfcf811 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
@@ -190,12 +191,7 @@ void aa32_max_features(ARMCPU *cpu)
 static void cpu_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-
-#ifdef TARGET_AARCH64
-    const bool aarch64_enabled = true;
-#else
-    const bool aarch64_enabled = false;
-#endif /* !TARGET_AARCH64 */
+    const bool aarch64_enabled = target_aarch64();
 
     if (hwaccel_enabled()) {
         assert(aarch64_enabled);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3e02941d0d5..9408131d178 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,7 +9,6 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
-arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
@@ -20,6 +19,7 @@ arm_common_ss.add(files(
 arm_common_user_system_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
+  'cpu-max.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.53.0


