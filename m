Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D4BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWv-0005Jo-MH; Wed, 12 Mar 2025 23:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWP-0004jm-Dl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW9-0007ql-O3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224191d92e4so9432275ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837556; x=1742442356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/DByL3ihQv9gjcrJmCBUjllouYG+4z7Wwry9cL7B6M=;
 b=WQDNwQpHRI9sTXEFtaNNjDkVLrh+QechPMCZT+CK+Tj14QuKoDejAUo3g/lfOuzyD+
 Zm7zAzkIhPhZk7zF2+4wZiuxB4KgL1mB+YIlj+nbZPbUSzBKMGo5mBqlS6/+L+qAKakM
 vFiVlALHJXnt2H5DEtjez623NaLz8hwjCuQ8auOPfllz5a2LEOzacajCNiKDtHlvilgW
 /A0pliikRnEAYgD4YYX4wo6jcARWb1MzYHMzc4gY8bQ18WgIom3gg2ieC5R9h/zaBfGM
 RTZwjq5VqUW36S/yCtjD3qLpgEP8VXC3Ar3O4aCErvRQMeKx0TmzJ8dbRT7E0eMt1RnH
 TMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837556; x=1742442356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/DByL3ihQv9gjcrJmCBUjllouYG+4z7Wwry9cL7B6M=;
 b=OKaQNwl4J4Mk77+vd5ANXVVryYUZj7hIz/qn3i0evY/1KMjIlMXCJ3d5ovcSgxXxj4
 3pLKo+rZkTK49ldIZGIxuLxnTt9os19UOnPwexcsu0Jk75aCtx7bJVh1JWnHc76llJFk
 QUJFigerxTrgEAgtjGAt4UcoHs9fJdXkPhcPK4mMHOEAaXjqxlQ7Tw2dBJ15kOWh8ZgZ
 T0iGBHcyE212p4vOXfHK4lMMgFesbMDKDkBzpd+8WfSRBIEDLRrGdYf4apdPa6U14ic2
 T/4WtGKS8vQuhFNZlT/FfJVzJKI5sAI+VXQZfUXBDzeADCw/Wf8oX5ryibSWcRsFGmK4
 AYmw==
X-Gm-Message-State: AOJu0YxgxOVXEioahY7/iO55iRZywCMlbSpgK8qEPg7pC6zWyv1TtoJn
 Bk4uZn4bYITKcqp67E0iZMbVDMdIZvkkJekCzNPQeSalPAcHDONpIQnHilWIfa1LYzmMY2wmSfe
 /
X-Gm-Gg: ASbGncuLfhsb5eW9cCj0HxI7LoqOo0cu2U6JrpFZL+MSU+G22ebnCVeaneDh4Fi5sh5
 S21qbGy5QWF+ujAWVN8/Q6RDtRbgPoHItI77MxMTL8IF6yQblVZXIwBwcuNvnALt52qYiomZj6P
 fyqyc0uKtTtj81iZB7S3mJl+WENZTJGyfp55LJ9rIzzwfQITzxDdVz4cWi4L5UoCJCa96RKTfo2
 tXmMQQCRFkRClaCn7Jlo8Yk/mSDhRGiCBTw+A8BaEXmYzI1cItEGfmlOQWLRBeVmIlVmwCoiNe+
 oNA9RBa7E2x7HQv1pSrhmaim+xurcfNfDckOmcDsnFsy/F2VDvf4zgguqVRcyQ+FWVU82xr7QAN
 jcH4097hFXEE=
X-Google-Smtp-Source: AGHT+IEfjjSwrun/5xLo73iDjccbJHCnuP8zqUkAUmr6QUiUCT9xf2eB2F7zMUOpB+uqa4Vgfc+N6A==
X-Received: by 2002:a05:6a00:2351:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-736aaa079e4mr30934995b3a.11.1741837555969; 
 Wed, 12 Mar 2025 20:45:55 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 37/37] meson: Only allow CONFIG_USER_ONLY from certain source
 sets
Date: Wed, 12 Mar 2025 20:45:17 -0700
Message-ID: <20250313034524.3069690-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 990c19a8ef..4ca384c409 100644
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
index 3869e5bfbc..c2c71b6f8a 100644
--- a/meson.build
+++ b/meson.build
@@ -4043,7 +4043,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
                          libuser_ss.sources() + genh,
-                         c_args: '-DCONFIG_USER_ONLY',
+                         c_args: ['-DCONFIG_USER_ONLY',
+                                  '-DCOMPILING_SYSTEM_VS_USER'],
                          dependencies: libuser_ss.dependencies(),
                          build_by_default: false)
 libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
@@ -4053,7 +4054,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
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


