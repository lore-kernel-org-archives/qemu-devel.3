Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3B8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnJ-0004yb-KD; Thu, 15 May 2025 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn8-0004cO-VA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn7-0008Af-5n
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:18 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a1d8c0966fso530966f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304775; x=1747909575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RG8Ka89WGECPxEN9oHVhNLbmDepbN7rDBbuob6DhDg4=;
 b=se4HmPfr6ryKxfn9E7+km11kM5AJ3U/zw3vAN2k4jgWKyML1X0reLjrGWGsYrSaFhG
 uSAbc8VS99WGAxyYn39KFZWfHbJFDuLKXnPj7j2M40aa6q3cT+KW1J0whKvkf5ghpbSc
 hzUH51YiKJJctFK1/c9YTnzKcu4TD3O+jwYAozbVuc6boUIbHxpwlTrb+L7fXN+gZwew
 4P821+9vgEgFpd8+nLBtGu1WOsp2Q9sme2Vb6OXaxTuZ9hEv7DrzPwIzIUmgPClt09Yp
 y6S4EaGMJ5GtqluJvdJx/siEQSCCebQ8A2Z6i0/ipqhObgavEWS4hs+ted0v/gIBwPM9
 zJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304775; x=1747909575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG8Ka89WGECPxEN9oHVhNLbmDepbN7rDBbuob6DhDg4=;
 b=MInsAtC8Uf8ueunT0d8aXkQIzyx+aHHK/2OjqeZkz2fu8cYHLldjC0B2ao08mLcTFg
 ycyoFu8GXJaftSkzO6hWqAQ6QQ76Z2EbCiWMwfTvox7H/qG0yaBmv8LUcJ5K4HoY7+jf
 e6hLCdDazgYuolKlD6i202/MI7+BK8nxv4YLh0Ucq2W2mjezM3tGE1b/x1UDmdhdVB8V
 WvHiWIXrloFh5l1bBmDbeVdlv93ths4c4WAqbHD6zi7T17/cIoZtBy1qAmMTSUhRTb+E
 t5fUPRbDyFoAgKe6gMKJc+qBxXjjhav1TcdAPzH/QsYsjpWSXYQN1ysSmrAl3FK7mQsz
 vYYQ==
X-Gm-Message-State: AOJu0YxOK0q4SOMq4BojN/tEp9pOw20kL9BLx2vk49XEVjFXnwwSVDB9
 SpYp7MBA8g447X5Qh79hAiVx/92JgcoQXl2Q9kbqhS3naumjkj8B1P5ZlZ4GfJIIhogNp7t+XZG
 jv6xqjIE=
X-Gm-Gg: ASbGnctifTtY6rMflW24IjQ71by0mhf8VqEXYzUFUSOc207jPBs82u+u37NRPPT5AB2
 5wU7QhLv+oo/AwGdtZdSBRDQ/A/evAIldlxW65MvUvnpm9BDImkSG1jRlhk7BlADz8mUAS2n7LS
 pqSVfvDK6yM2oPTvfNMl+qrAQKwhSE/Ou25W9VptHb6RFilTeezhJzXwC8aqOGK46AaLLCwHlge
 5nZKnrfUpQHe9P85DVOxOtbmokq7HihqLdd6XLWYBbjXi30AcI5B+Gsbri6D/WDxPKnfL5qTlsQ
 bi6JKchtqHF7AGeLMU+9/jM3g0cTjietO4WwDddZrJ11LjN30J05mhf6pg==
X-Google-Smtp-Source: AGHT+IE1BLszunUFW8kOr6VdkRYO7w48uBOhjgUsErGAKRDeUrrlxU77B2+lqzKpRLb38/LWTA/sSg==
X-Received: by 2002:a05:6000:2a5:b0:3a0:b817:2d7a with SMTP id
 ffacd0b85a97d-3a351222edemr2489026f8f.29.1747304775317; 
 Thu, 15 May 2025 03:26:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/58] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Thu, 15 May 2025 11:25:07 +0100
Message-ID: <20250515102546.2149601-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Need to stub cpu64 finalize functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-10-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ec9bc72c3d6..ca5ed7892e4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1913,7 +1913,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1949,7 +1948,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
-#endif
 
     if (kvm_enabled()) {
         kvm_arm_steal_time_finalize(cpu, &local_err);
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
new file mode 100644
index 00000000000..81be44d8462
--- /dev/null
+++ b/target/arm/cpu32-stubs.c
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include <glib.h>
+
+void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..c39ddc4427b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,10 +11,13 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_ss.add(when: 'TARGET_AARCH64',
+  if_true: files(
+    'cpu64.c',
+    'gdbstub64.c'),
+  if_false: files(
+    'cpu32-stubs.c'),
+)
 
 arm_system_ss = ss.source_set()
 arm_system_ss.add(files(
-- 
2.43.0


