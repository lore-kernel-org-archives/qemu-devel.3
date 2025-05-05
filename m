Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19893C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC577-0006NJ-QP; Mon, 05 May 2025 19:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56x-0006D4-9t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56u-0003XQ-0i
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227a8cdd241so62168175ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487230; x=1747092030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=iBwFIujPXBZ8pNNli85qS/vzsUkB7SYCYpyumN0OpLmE+gZbNrvJJAT1U/jeB2bhST
 Bw9+HLmQ7GJUjR/CE7TMz+NL6/7R/8d7073P695hODP8Pr0sKpagEL6EKLptYhNoabk8
 43k2O+3kJlmYgCq9nuF9hSk64GVk2uaoXLnaS96odArR7LDbDlDG5/+GjHEEQwewwjmV
 iyPRQ26csVdm7Ux3s4+0fpVMgOLtc8iEZbn4/otjlvEh5+MKFSBNnHJefjp69B5niFD0
 rrKH6Gbeix6XSOaFRNzLCkneL4pTqf26Z0qLtgB18mUsFPoAMoMEmWVKwr0ifXyh9lPE
 nOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487230; x=1747092030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xML4J0OK01b5ZM+8qKTIYRySQNd3gi0WVCRNgOjS4SA=;
 b=emDEKusrbt3s1YFtCkMGF5iKiKuFQSKT8gjUXS8c44ruP3P0y7puItXJI/4X+d2EHU
 4tGbuTBZLPEeYEzeDsrL0Yan7BmQasvd+7XYueMJxJlihL/PmlFdPm7eLOjFzAQglr1m
 equype2SVstdUYFQJPGfv2ewXvrDmpMZ1IAiCQweKpc8p6RlEQP2ULraAemKGjWQlIcS
 QdU8CKM+pnXLr56FHb7OD7Y8P28c8a3fygd4xJR8mRF2U4w1cgFhI7jkT4a3elRVZg5L
 LmEPutnvIuqh6Y4GlG9uysBMXtqzFy0vl00yOvsnmSzHo6iYGtfRZwIqiFVr0zPhiZvp
 pOIw==
X-Gm-Message-State: AOJu0YyJ58Pbt/2/nJmbeoDOBHkwfJFIrtVBHmAiwwh1kRr7x5GDdzOL
 qL2K0ZQ1byoD1Qfugr5fHPw0mRoNz/kxxEsraUtyAoVlbvN6um8WxjXe8emzwQEDAsDpDwqkENw
 FcPs=
X-Gm-Gg: ASbGncuFLvoisVB7YGpJiOVQv0l2Kt7WlRj3NWPucyvXPvw06GzUAICuoqFGHhcAP+d
 6BBehGmop02Ock6NqBRbmzIS/Vm+EJsdq9r41pZM/y0iHN7VqQ1O5lVJVNt1K+WyaFWwmr0zyg3
 AWnUTc6Fjr11TeswDAcvDJLV7qnoNZ4GpxP1NNI1uG3XROTo5iBJT6tUOB8v/ccwm3dUX0F8gDa
 Ik/7g463s6QBLh2fZwoIWvgtv5/HzjG8xii2e2ng3QaW96PMwLvNpA7wdG4Wn3rXKZkuYTLIAIN
 TFcfDulnltthCgSbw13H/Cnx39hISGyXug233OwZOM6QKi2qvJI=
X-Google-Smtp-Source: AGHT+IHC2Jo05pn952wK+Shdz+FACMdNmO9OlVTSCdZkPIpQy/IzGCCRrr1li/1SwgK+QzI+o9r6dw==
X-Received: by 2002:a17:903:1ce:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-22e35fdf665mr13164945ad.14.1746487230235; 
 Mon, 05 May 2025 16:20:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 11/50] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Mon,  5 May 2025 16:19:36 -0700
Message-ID: <20250505232015.130990-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Need to stub cpu64 finalize functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 26 ++++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 00ae2778058..c3a1e8e284d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1878,7 +1878,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1914,7 +1913,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
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
2.47.2


