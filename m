Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuebY-0008Ul-6B; Tue, 18 Mar 2025 17:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuebA-0007vH-0v
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueb7-0001PV-Q7
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:35:43 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso6406478a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333740; x=1742938540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13k0jwEVfxqTq93kSJ5yE5chyzbVZf0RIEGz6xTXmR4=;
 b=eBzeKaPyTaUf8jOXxd2/ymIYvsum6TZLpCDy05l5Wp0cmCENKg625AaNXPQwkjakfq
 BMCYiiMv0fJl/16o0BjOTbZPS//WMPlWIxt5jw1bRCiI71ulacxmuuLP20+dT1IDp96D
 89C7Nf9Ne37Dai82DPczIAe8tBQGkZ/nuu1w245xOswuMuUOiSkwjGWkD2nFNhsY70lm
 kNKdt3ZFMHPKrqH9Ci/Mq884N1VFwDr9yItM640Kofe0fqO35svgnsdttU9tJeegn6e3
 foG6KN8Y9gEwcXH5mpxL6RNE/cWU0RuG5OpZcnhWlt/4RfhOgFizcuFVWXlYxx+LBrqX
 KVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333740; x=1742938540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13k0jwEVfxqTq93kSJ5yE5chyzbVZf0RIEGz6xTXmR4=;
 b=kEuzXBdNafpxy37lMCLJS1QfsT7f2WU0oxzKsJYvs8YtsHXuVWm3Wuu9EI+LCzNQRt
 1WUZ+aq3cKpaazMlmmATAN9Qgk+0zulg+mpLPXZ7TeoOdW/7VPlg6K26HaTsl1cpOm+x
 FS6Tg1o5OpJKh3JIiY4nJO5vc6qF7cJgCpQakVKmzlmzh2AKuDxV02CPnBKxeHXBveNT
 ROotW4jEaUTVjfMfL//FH/hFN0OJ4PQByjBxgwHi+sdl9ZOObDlX9dNVhMrzSpsUuHJT
 0Kmv8VsW/ECGQRIkpOPTPjVKSnSGJwsT75qi+Yn4DadepHcO3Fz5M0hRK1RLhcwJlBl+
 DYPg==
X-Gm-Message-State: AOJu0YyiEil/0TRuH9JYwoUWoRCTDcV1p5reqLxDykSIK/JjcqNDitXA
 SCdF3iT0c5qinCT5xYQ+7ZehvcNefdI+a3EhocX74WgLxQb53jMkz1Q4UA7m4T2OUjBeqp8mOlo
 W
X-Gm-Gg: ASbGncss9Ho6BDksXGTQ2NC9UkVqLGGN51z2d+KBfypmiHwyGMGGSbNImChJEMidVtd
 VzDB3j10Oby8fn9cacLGkJ9loSI2+4xlFpZkat/tMzwUp8wXoL0PtEEj22FwB7hkUTev/Ih/+5B
 a5JreJOt8HmeN1CvXvKVlyUrFKldNZRwy3CgRyUBc+tuP5EWTeBcQlsFUs4H14SMBN0xSQzivSi
 HKv4zKROgPtvSt6yDiTeifWLrPKztVhs4UzHBEFPmNd48LEEPJxyV+FhtdLQoPaP8zQtdakh0FK
 y9+eJy3YDEMbwQd2os1D2h8GhqW3hv9yW+3MyuvmSCjjRUAbpyx9NTYLd837I+W75gxNEPvwpm5
 8dlKpBb6gdX8=
X-Google-Smtp-Source: AGHT+IEI4NJ3vcQBsx5omIa5A4PcYeVE6sojwB6mc96aUPP/ExFuIdOPIViNhBZZHBXmgtSEhl8KOw==
X-Received: by 2002:a17:90a:ec8f:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-301be1fff3bmr268423a91.23.1742333740447; 
 Tue, 18 Mar 2025 14:35:40 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539e9ab7sm8678072a91.11.2025.03.18.14.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:35:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 42/42] meson: Only allow CONFIG_USER_ONLY from certain
 source sets
Date: Tue, 18 Mar 2025 14:32:07 -0700
Message-ID: <20250318213209.2579218-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Poison CONFIG_USER_ONLY and CONFIG_SOFTMMU unless
the compilation unit is in specific_ss, libuser_ss,
or libsystem_ss.  This is intended to prevent files
being incorrectly added to common_ss.

Remove #ifndef CONFIG_USER_ONLY / #error / #endif blocks.
All they do is trigger the poison error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h                       | 5 +++++
 include/hw/hw.h                             | 4 ----
 include/system/confidential-guest-support.h | 4 ----
 include/system/replay.h                     | 4 ----
 include/system/xen.h                        | 4 ----
 meson.build                                 | 6 ++++--
 6 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ed04b3108..a6ffe4577f 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -67,4 +67,9 @@
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
+#ifndef COMPILING_SYSTEM_VS_USER
+#pragma GCC poison CONFIG_USER_ONLY
+#pragma GCC poison CONFIG_SOFTMMU
+#endif
+
 #endif
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 045c1c8b09..1b33d12b7f 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -1,10 +1,6 @@
 #ifndef QEMU_HW_H
 #define QEMU_HW_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include hw/hw.h from user emulation
-#endif
-
 G_NORETURN void hw_error(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 
 #endif
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index b68c4bebbc..ea46b50c56 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -18,10 +18,6 @@
 #ifndef QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include system/confidential-guest-support.h from user emulation
-#endif
-
 #include "qom/object.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
diff --git a/include/system/replay.h b/include/system/replay.h
index 8926d8cf4b..1c87c97fdd 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -11,10 +11,6 @@
 #ifndef SYSTEM_REPLAY_H
 #define SYSTEM_REPLAY_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include this header from user emulation
-#endif
-
 #include "exec/replay-core.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-types-run-state.h"
diff --git a/include/system/xen.h b/include/system/xen.h
index 5f41915732..c2f283d1c2 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -10,10 +10,6 @@
 #ifndef SYSTEM_XEN_H
 #define SYSTEM_XEN_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include system/xen.h from user emulation
-#endif
-
 #include "exec/cpu-common.h"
 
 #ifdef COMPILING_PER_TARGET
diff --git a/meson.build b/meson.build
index 329e7f056a..b4d65a75e5 100644
--- a/meson.build
+++ b/meson.build
@@ -4054,7 +4054,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
                          libuser_ss.sources() + genh,
-                         c_args: '-DCONFIG_USER_ONLY',
+                         c_args: ['-DCONFIG_USER_ONLY',
+                                  '-DCOMPILING_SYSTEM_VS_USER'],
                          dependencies: libuser_ss.dependencies(),
                          build_by_default: false)
 libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
@@ -4064,7 +4065,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
 libsystem_ss = libsystem_ss.apply({})
 libsystem = static_library('system',
                            libsystem_ss.sources() + genh,
-                           c_args: '-DCONFIG_SOFTMMU',
+                           c_args: ['-DCONFIG_SOFTMMU',
+                                    '-DCOMPILING_SYSTEM_VS_USER'],
                            dependencies: libsystem_ss.dependencies(),
                            build_by_default: false)
 libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
-- 
2.43.0


