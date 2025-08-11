Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2195ACA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVzf-00053e-Jt; Mon, 11 Aug 2025 13:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzE-0004w6-1X
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVz3-0001pE-Vz
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b783ea5014so2507943f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932006; x=1755536806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MJUQ+OQJ9HkeNlMQlODjCm+Oh2wh/gShIDZyY6yH20=;
 b=UyvPmZq8Ae4Ionh90UMja3Y8NHm8JoV70c8UzRGhPaVb4u5ARtH7PyT1662120Ghxf
 pyrICAW71NGj7EVvN59VmeYiILoNzrHIxdRofZKLTKzAI40Mv4zxNgpxPFKBVU9mwIod
 /0j5HVLSm4rz0RgrCJsJIBtUkgYjTC1fCMf5QyesoVf5a2aY2xalgkkkkpfP7boIOr5q
 /h6Rt+CjDi9MfgbdzPty6eqZ6HT+tdPnuxXTricZ41vpyTyMV2ideGpQqpvU00KtQr2g
 aLolnqx3FHpeI+spFckI63SFlprYO+vxkzdjduvOfRvc9U1oT6OSIiHVTFiPVJMLRHGV
 gfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932006; x=1755536806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MJUQ+OQJ9HkeNlMQlODjCm+Oh2wh/gShIDZyY6yH20=;
 b=UdQgmQWESqVxnvG1bQNAs3jEv4plCl2vB0qwJdjuJQAhvvtRQli4jJH5FZVZ3jSACi
 Hv4ANBcakxIOVnbsKONhNKnlUp9D8CZEkMlWkJoCyOx1z0lQrFNkoilnhZS18GnLLfu6
 e3+HpHbJ82blChE2cf0f5Yux112ayZoOd2AOcvTApZL6g/KaYP+g0sgGxTgGgJQhRL5/
 IUFg44cakcpSbmPlgHSM57TMjMxUVRBY47MMiVcJZ/VYpZo737ezJdsNQhlwbaQOoW3D
 z9IhWl7mEMMBZfVIqcgNqtID87bbGDlSU7XDOfMgUlRsbpWCAKbaTdM7Iotym2GLcrKX
 SeYw==
X-Gm-Message-State: AOJu0Yyl+eKmnfLJ1IbXGzBj/yVnAI/AiUOWNXXg0FM8Gr1ZBN8jJgWJ
 TTmZgEkXmnU9APKOxFsIxeapoaGI6CsFVK36K2hzKB9kUKa+qZ+iixu2anlXq1InqnD4n3oKtNe
 g62Ck
X-Gm-Gg: ASbGncuk96izhZxS71tNk/RyQcM+EwXKJlxzgFN9znUg53Rn4Zv9AqUvh89NNhUJ1N9
 t/c7yMqiCwwPps58SqAHpi89n+iUSajCbymG3yKHKYSG+QlAjydegt1iQqBpm/Q9oPlu7L2v3Ah
 Kx2zRoBjDsCu3Wo5abmDC360hqPwFu2TwDG4jksHk6RZjQVKhJvMXDB9n7aaPO/p6jCUojQaswm
 R7ZtrFpyTJXGNM2niFJOhIinvlK7zRQjZT/3YmbkmEMuWlufjOVQrLzcz4IRRj0MMXdyu2V1lpx
 Q+2TewLC568J6+4tCGS9WYpCUoQ4cfMEAOGIyQmtC4IF4S0MNHCRw8e4Q3pf4x/P26lZnfwjDYL
 PJU+3lJRW3sK6gM0gRcPLP1rJ7Lss4gQQ4MpqS7PC3vTpiuYSwQ1g3LNnogCtg5q0LNq+2RFb
X-Google-Smtp-Source: AGHT+IHQU/+29t09xJxuB50pqa5k+Bpb42xmnALPPoJ7HYs9t6XhwQxWVIBqxqWkJr4ZvR5q0iDpcA==
X-Received: by 2002:a5d:64ef:0:b0:3b6:12d9:9f1b with SMTP id
 ffacd0b85a97d-3b900b2de3amr11005330f8f.22.1754932006474; 
 Mon, 11 Aug 2025 10:06:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eff7918csm196801235e9.25.2025.08.11.10.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 06/11] target/arm: Introduce host_cpu_feature_supported()
Date: Mon, 11 Aug 2025 19:06:06 +0200
Message-ID: <20250811170611.37482-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

host_cpu_feature_supported() is the generic method which
dispatch to the host accelerator implementation, taking
care to cache supported features.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h          | 11 +++++++++++
 target/arm/arm_hw_accel.c | 27 +++++++++++++++++++++++++++
 target/arm/meson.build    |  2 +-
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/arm_hw_accel.c

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5136c4caabf..aff60cef6da 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2508,6 +2508,16 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
 
 #if !defined(CONFIG_USER_ONLY)
 
+/**
+ * host_cpu_feature_supported:
+ * @feat: Feature to test for support
+ * @can_emulate: Whether Allow to fall back to emulation if @feat is not
+ *               supported by hardware accelerator
+ *
+ * Hardware accelerator implementation of cpu_feature_supported().
+ */
+bool host_cpu_feature_supported(enum arm_features feature, bool can_emulate);
+
 /**
  * arm_hw_accel_cpu_feature_supported:
  * @feat: Feature to test for support
@@ -2515,6 +2525,7 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
  *               supported by hardware accelerator
  *
  * Hardware accelerator implementation of cpu_feature_supported().
+ * Common code should use the generic host_cpu_feature_supported() equivalent.
  */
 bool arm_hw_accel_cpu_feature_supported(enum arm_features feat,
                                         bool can_emulate);
diff --git a/target/arm/arm_hw_accel.c b/target/arm/arm_hw_accel.c
new file mode 100644
index 00000000000..3a8ff007599
--- /dev/null
+++ b/target/arm/arm_hw_accel.c
@@ -0,0 +1,27 @@
+/*
+ * QEMU helpers for ARM hardware accelerators
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+bool host_cpu_feature_supported(enum arm_features feat, bool can_emulate)
+{
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+    static enum { F_UNKN, F_SUPP, F_UNSUPP } supported[64] = { };
+
+    assert(feat < ARRAY_SIZE(supported));
+    if (supported[feat] == F_UNKN) {
+        supported[feat] = arm_hw_accel_cpu_feature_supported(feat, can_emulate);
+    }
+    return supported[feat] == F_SUPP;
+#elif defined(CONFIG_TCG)
+    return can_emulate;
+#else
+#error
+#endif
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 07d9271aa4d..37718c85666 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,7 +11,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-qmp-cmds.c',
+  'arm-qmp-cmds.c', 'arm_hw_accel.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-- 
2.49.0


