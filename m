Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466EACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd6f-0005wF-Ky; Tue, 28 Oct 2025 02:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd6O-0005nO-Na
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:22:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd6L-0000V4-NJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:22:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-427007b1fe5so4703622f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632554; x=1762237354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXwgMzbkRa9lVN9HUpv/wtEfpGvPebV/MvemfcmQGBs=;
 b=ECBWx2Z8fyGQEehrOQ1DhKCRiFxvQBXlC1UqgzzUZpfbITAwp7o/5bPY77t4hIfeDO
 TGQ8OwhUKMR5ekFWbqv+PTGI7qqfIPXIdyeRfBVeXNDWTKF9brdZd6XFlCWv5kHqudFi
 e9UKzu17u+CpOm4ngB7FXZc/0wEAwP7K039ItbAJK5mn6woG0SBulTcDpJdHhjs7q2Fb
 RHY7IPWlvRb93OK92SaQ2pZG2L1U4MTeP33bT+8N9Kn7QrhtOpNPcI3XuRkjC3S3tFu/
 x2guZFFRDZYgtkGTxGAWExpsvg3+0wYPwnHpxlpu1LAzSAjBYbN5LNoSfGLV/3q1CHwf
 KzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632554; x=1762237354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXwgMzbkRa9lVN9HUpv/wtEfpGvPebV/MvemfcmQGBs=;
 b=Ww3xSR4t0Ez7wNh99Y9KE/sqsMtAz5HCcmMecUhp12+113tFQt1O1RJibR+0VED6Lt
 MkBi3rWyqr0oVeWBmAfX8Gr6hA26EE7oOu4VSw+QfRxD65OlDfk2xtI4lSNJXSAWXFN+
 I+voDsKJ+GOOh/td26xpMBP9HUXyOHRQCUCHAeoOu/WuDZsW0TT8nDpyU4zo/YpR+Uny
 u+CASBS/ENDHEYGB9ViOnyt0ufSqr1Eb8E6sRTjeZwJS7RFxWAdHe8VUjUrw/XPsn+RF
 Tu/jEr0d/1j0lcZ25DGYf0hnWIyvDahj4Re950gCgzDIboqwSgVYbtueaBLLSI1NkdoO
 rUVg==
X-Gm-Message-State: AOJu0YxpXhLs7yJi0zGGxK7lqEp4mxdSJP8siKIMjH+EY7Ncp0OuzClO
 SxC36yNopLVCWJ3sWuV1uQ6ZXJ0tXDzn85225Toou7AghJ47sHVGsBh5yHo4NRXhwle6SyF+aJO
 deB9SdOQ=
X-Gm-Gg: ASbGncsk/4hJLvNbBkzqC8j2hvdCBR5I+/cUipXckjJotY0l2+6kChI3jdS5VR5yTnx
 cOZxn0sT8kkZUj1GbPvk6QplSwJnv7okPVobiCAqqMOXZC/AmbpcykbfukNc92xBk84Eae76bG/
 7LY5NzJAG4UXrVDwJCRHjgkRprXegLK2sueq60nU/IUcX+7fRzno06wlKad2HD0y8Qyu4rdUL3R
 yNqXfUR/HSXumBQgD4tj9RV6ACuU8BQY2/F/w+mVO1jnycUyw2Pc0DxamX3H2lkmRLTB08cUmiH
 kIQf/YHK5uTIxWA+3rEdjKM2/y55dmTit3JCd9PQ35tJmakbDTzY+DMafipX2oD/TD3fm+R668c
 JUNIV+mD3OZgMDzd5oWAdI4QgQbXKwOj9mRX53h88pd6mlI5LesM2BM8jcAXAca85Xa2uqVJZPI
 XXoQ7ElS4XooZy/A1/L33dKim5N3X0gbrMO5o6atoeH6tfUwXcq+phEo8=
X-Google-Smtp-Source: AGHT+IFYoE0SswbNXBThHEKhBOsbGc8TvLh3juZIX9BKBrwhesx8c5z9wspKYFw/+Pu/6IczywwArg==
X-Received: by 2002:a05:6000:2008:b0:428:3d1d:6d15 with SMTP id
 ffacd0b85a97d-429a7e9c957mr1563338f8f.57.1761632554435; 
 Mon, 27 Oct 2025 23:22:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df682sm18216529f8f.43.2025.10.27.23.22.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:22:34 -0700 (PDT)
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
Subject: [PATCH v3 56/59] target/arm: Better describe PMU depends on TCG or HVF
Date: Tue, 28 Oct 2025 06:42:32 +0100
Message-ID: <20251028054238.14949-57-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
(ignoring QTest, because vCPUs are not available there).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c     |  2 +-
 target/arm/machine.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index eaf76532eca..5a5a9994af0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1979,7 +1979,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_PMU)) {
         pmu_init(cpu);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || hvf_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b0..80aa2e34b4b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
-#include "system/kvm.h"
+#include "system/hvf.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
@@ -943,7 +943,7 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(&cpu->env);
     }
 
@@ -978,7 +978,7 @@ static int cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(&cpu->env);
     }
 
@@ -1011,7 +1011,7 @@ static int cpu_pre_load(void *opaque)
      */
     env->irq_line_state = UINT32_MAX;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(env);
     }
 
@@ -1103,7 +1103,7 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(env);
     }
 
-- 
2.51.0


