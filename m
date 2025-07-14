Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31747C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKz2-0004ku-PY; Mon, 14 Jul 2025 11:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubJbC-0003LD-3x
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:52:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubJb4-0004dS-V0
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:52:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so30281615e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752501114; x=1753105914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b65ck84coYQ3QVG+RekMC+HihY4/9ws56nByYyrZvco=;
 b=a6PxOUe4MBsAojRB4NzDWOysBc7zPi9KrVvsD84Qr+AbvF3SjgmuVxDOZIiKJ+qvnm
 36HmoDwnOCWFEs6vZCF479873ZadAFv9N8MO3h74evFdjQQsnellYapyKnPKoKEpYhoO
 +DGK95UHrRmI3nPnF3UBzxHCjFOcE/+66kBdXxobgAeyqaiO7UxL/wSaDPPR5yqJDPCM
 Aa52OFiJQ2MZLS9s5WkxCDyH71ulj+KuMfqwipNyBUMmMwhwL+5s62kuzfCkd067Mxa4
 UkTjjK1UhyG0QethXqIlgW8Eo5ti3wFNxmnwCsYXEcs8AbGUkSCBGfqpwhkAebADEdR0
 Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752501114; x=1753105914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b65ck84coYQ3QVG+RekMC+HihY4/9ws56nByYyrZvco=;
 b=fOTECSHr7qNXf9bLFQnMmjVe08OQmKQ08CK++CchLELkNjL8WJ8Qgr0DGkKihgYtlG
 0LGXJNhHL8I5SwjhGpdOW+DejagaqWMBdjdfAQtha4pw3+elq2CkZtjKhaG3AV6xKIxM
 t7Cph/fkmKtRc6BCam5yEQ/DUwTArpdEdYXzRsUctwCLOGuSYwps5cbN4z+FqMvrb3+O
 DymCOAvCODPODqB54oeCKRhR3Uwr5KA3WPJf6QYxvAwPcbvg5w1Vvl46NiPcwoLIO8yG
 j+YyDH8LbR01O483ac60I9QzLjQcJGfLw3zqaQ3/K8tdFmB0XRR6dCMa0kDPB/sVo0mR
 swbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPBREaCn2QJc5MfR/+QqLRmmxt4jg/CU1lQmouJY7CNGoI76H1Zjl8bGd2LkzjjAb94SNuR4avGZF@nongnu.org
X-Gm-Message-State: AOJu0YziR97/rQm70E3P/7PqzXK5KWjLBN1TZWviS9NQJnVUt975qEaK
 0htllh32pqsYJqYtXYpEQQGWrTxcL19U9SqzNSGaDnStX03KMItxo6kH0TkOXHNHidk=
X-Gm-Gg: ASbGncu3zpUNq/40afr8WXc9L3CxzIvFlVImKQaz+d+OhUGN7kanT7DMINGVpXZknGd
 pTEJQdgu56GcQX3kWSH+Bjyj/I/Sxqh8rW3pnE9KKm1LnQ6znXlG14FL8MtFOe41j+tzb6vl/+f
 zsYNVp4aLYsZx2DiOmIRRE0I20buSQhYoUXMFbR3PnONkeeSDMkYZO1e2lZe46WwUoqoKQcY+jX
 gOtjIG+dsPVge03cv54lRuzQzwe0mCZKKnExqY+CrvRuuToErJHjihPFMdIo4Kz/+8Klq7CgPab
 kLmbwy6Woub/tzvlbThQwvUAI4geSzy4Wz2XYLFKfso/ouOIZJR/6hNPK+brp1n8jQT63kQiT6x
 kZyIl88Gkh5l9ZAF/DrDOIbGqfubR
X-Google-Smtp-Source: AGHT+IG7iG1QXdEZwJdk/HjuWlgUWeDp+HeaB1P3r29bzysD4RutNf6hE2ET8sMqk42vCQi1oMdhhg==
X-Received: by 2002:a05:600c:8209:b0:456:1dd2:4e3a with SMTP id
 5b1f17b1804b1-4561dd252femr24989915e9.3.1752501114276; 
 Mon, 14 Jul 2025 06:51:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1d5sm12547760f8f.78.2025.07.14.06.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:51:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] target/arm: Provide always-false kvm_arm_*_supported() stubs
 for usermode
Date: Mon, 14 Jul 2025 14:51:52 +0100
Message-ID: <20250714135152.1896214-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

If you try to build aarch64-linux-user with clang and --enable-debug then it
fails to compile:

 ld: libqemu-aarch64-linux-user.a.p/target_arm_cpu64.c.o: in function `cpu_arm_set_sve':
 ../../target/arm/cpu64.c:321:(.text+0x1254): undefined reference to `kvm_arm_sve_supported'

This is a regression introduced in commit f86d4220, which switched
the kvm-stub.c file away from being built for all arm targets to only
being built for system emulation binaries.  It doesn't affect gcc,
presumably because even at -O0 gcc folds away the always-false
kvm_enabled() condition but clang does not.

We would prefer not to build kvm-stub.c once for usermode and once
for system-emulation binaries, and we can't build it just once for
both because it includes cpu.h.  So instead provide always-false
versions of the five functions that are valid to call without KVM
support in kvm_arm.h.

Fixes: f86d42205c2eba ("target/arm/meson: accelerator files are not needed in user mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3033
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm never sure when we prefer to use stub-functions in separate C files
vs when we prefer to have ifdeffed stubs in headers. There are several
ways we could fix this compile error, so I just picked one...
---
 target/arm/kvm_arm.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b4cad051551..6a9b6374a6d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -161,6 +161,14 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
  */
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
 
+/*
+ * These "is some KVM subfeature enabled?" functions may be called
+ * when KVM support is not present, including in the user-mode
+ * emulators. The kvm-stub.c file is only built into the system
+ * emulators, so for user-mode emulation we provide "always false"
+ * stubs here.
+ */
+#ifndef CONFIG_USER_ONLY
 /**
  * kvm_arm_aarch32_supported:
  *
@@ -197,6 +205,33 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+#else
+
+static inline bool kvm_arm_aarch32_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_pmu_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_sve_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_el2_supported(void)
+{
+    return false;
+}
+#endif
 
 /**
  * kvm_arm_get_max_vm_ipa_size:
-- 
2.43.0


