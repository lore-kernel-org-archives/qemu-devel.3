Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA5CCD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtHs-0001En-K4; Fri, 15 May 2026 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtHg-00013R-Jb
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:13:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtHc-0004Py-H9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so4958669f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854374; x=1779459174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTJ12u23QhbWwNIBCNdFgEzxGR2+OzqbFo7UXsWqIjM=;
 b=QMFs0qRqop+MithR3eQKIIJafkehs/KpUZxBI10SUxvyuB4v2JOUPEIyhAgjgx3WIE
 hoyLb5DbiHaFM0pEOOEHjsuEAa3neHVnMtqqsEoBAmSlNOxKuQVR06wK5qFp9J77wntW
 VDHplsm7AIZV6ctRMLLYIbRCqpLEoZRMg9qONPCQMqtdD/GxkLYeHcqOITLX1F77UxbP
 KoDtG2sR2TP+orvfqt9k1R4ANJm2xwKMUeyXfgBX6nKBphBb4MsXkdXSIyTUymjhcqwn
 eiby7x0JsDDIwrQ5ZcHWfGGQRard808JXXbtJhtJ4ZJEOL0r+DQVL3WlI6JDHw1nZX3B
 mZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854374; x=1779459174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTJ12u23QhbWwNIBCNdFgEzxGR2+OzqbFo7UXsWqIjM=;
 b=JF7LDeogZsf4067jlikQ+y9TB9oJnv6xU0rawSA3sJYn0P5guL/Z4IkgvBK1ILvnHv
 U/MH7WTAG/GgGXbPvUY5vdNVXs5oVyddHcwqPrDbmbNlGc2iBlSQR224W48yD5mViaPD
 uk3yFnBdYYGR4nCWNap681YcwEI6Iw9e6uRSgFaAjA6OOgpfpgKXzdv00iH2/3H4xaqJ
 DI8T1PTboPIKN1zNLlrwvBLVlK+vdSbM198zVHp2D1IdKS8p4Asp0M5TOvJEkBCP1RTv
 IH9iOMFTKYXzXCF1kSkxw1XXT5YlH8ybWonjGO+jj7Ekb+GSyhhP3n4B9z2XpW/+Lm4j
 rODw==
X-Gm-Message-State: AOJu0YwyjQMNX3Otg9DHdvIA3RFMulRZUw7rljPVJ0mocN5OgS+ydQ+m
 81I29lBCpVXvllAAdXAUB7vcQ/h+zzYTZQCt4sl9/766EgVLQgq9rzH3fu8gY6OhSo2fk3DEqPu
 G6CjC2CU=
X-Gm-Gg: Acq92OHJmFCRuGTtsx/xOTbN7dR+zcxV17YPTiwL2ogZkfHSVUq/87zNAb7BZntHIV1
 X7vQ0VpFoYyC01WChzYBXB6oD5WVvtltnfWOpNLKTiy/ZmME0pTniXePuJ8b/P2Qwxd7jlVR0ne
 NHWUG64HjAestyLvHQiy1wfpZu2dhm89zDXrk1C+vQ8yuz0UG3SAP8q9VzlsVO4A/Mi3+mGVSxw
 Ati3blxTVFi/5hWS8LgHI/QqECWOiGtw3qm2Lx31+e7Fp7T0f3f24V3yJR8swwFxnCevKOY1NGm
 u7HiFcMswnAApI3nXrxpiVdNeBIE1hrzqMwJ1YuZm7TYfupb9wn+B9ddRsu4JrSiPrnrfLZSPY6
 834VPuB/PJJEA+3nRAtZw9eYSuFz3IRmWmVhkl+JnNl0g8yooZes+ceEYLZo8B9oHuYzJvfHWbN
 TP4yDiaO5ckxE9E4j6e9fW044hio3XkKumKIv9X02SAZdg/2XZzgxfXaIVR3fUJ2kSrUNjkFem
X-Received: by 2002:a05:6000:2f83:b0:45a:e3dd:5869 with SMTP id
 ffacd0b85a97d-45e5c595745mr5918727f8f.30.1778854374234; 
 Fri, 15 May 2026 07:12:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm14697629f8f.2.2026.05.15.07.12.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:12:53 -0700 (PDT)
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
Subject: [PATCH v6 19/20] target/arm: Build cpu32-system.o as common object
Date: Fri, 15 May 2026 16:10:30 +0200
Message-ID: <20260515141032.3271-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

cpu32.c only contains CPU types used in 32-bit system emulation:
rename it as cpu32-system.c; always compile the file but only
register the QOM types for the 32-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 19 ++++++-------------
 target/arm/tcg/meson.build                 |  5 +----
 2 files changed, 7 insertions(+), 17 deletions(-)
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (98%)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32-system.c
similarity index 98%
rename from target/arm/tcg/cpu32.c
rename to target/arm/tcg/cpu32-system.c
index 8220d785f5b..51ed1f8f269 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32-system.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM TCG-only CPUs.
+ * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -10,18 +10,13 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
-#if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
-#endif
 #include "cpregs.h"
 
-
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -738,13 +733,11 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
 
 static void arm_tcg_cpu_register_types(void)
 {
-    size_t i;
-
-    for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
-        arm_cpu_register(&arm_tcg_cpus[i]);
+    if (target_arm()) {
+        for (size_t i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
+            arm_cpu_register(&arm_tcg_cpus[i]);
+        }
     }
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index f821331fbee..a6aac6deef0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,10 +29,6 @@ translate32_d = [
 
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64 + files(
   'gengvec64.c',
   'translate-a64.c',
@@ -83,6 +79,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
+  'cpu32-system.c',
   'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
-- 
2.53.0


