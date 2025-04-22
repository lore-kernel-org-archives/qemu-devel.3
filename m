Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF37C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQg-0000Zy-Nx; Tue, 22 Apr 2025 15:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLh-0000fr-DR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLe-0006dm-AM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2243803b776so87046045ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350321; x=1745955121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeENUlDVgehwxdXE0XXPfIIxCZLEhLec/NmTrOg0uCg=;
 b=ptIttOG8nxSjjNMj5KSgBMA39cXJt20rqBXlGJ2b9IP0X+IAlTtOtBupeJrNsZUOHk
 nvaz2jS6XRKUrswjyFbf4uJVTJJvH5GKzy8JutZR4PvuF7JqmSgzaHkozUZTxmHN9U87
 Hv3bUrz/mu2Lzm4w0nmQUqKizPUBBxnbdxI/ogfAIqNR+0WoFcRdQluoNJKud3IGWUee
 0orAkrGdkhnSjMV0wyRWqkurwYRPPIHwF0d2tfWits/DNY7pUzoqncecE+y0VsvujPPB
 qj8RKQs3KdtAbdbYFZtif5WhAzOf1VTaRfee1q7GJcnFqD8Zch+nejjr8SWSqStP6fCL
 iaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350321; x=1745955121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeENUlDVgehwxdXE0XXPfIIxCZLEhLec/NmTrOg0uCg=;
 b=xHbRC3D2mLiGBhz8jg9XENdxaA1e9+3l1aBs27dAx5czkaXuQAtisSY7IqsLLHHnKB
 gpvjnRg0hQFB1Bu+/0xXlCGynD7NBk0Uh/lhbEMLLojfUDavdWmlLlIbyrgQcBgKlIcX
 YhdOu+2fUe7ZhjDx3w8LUjdrCuGwtf0TEbM+MZEsVeGRwLiZlqrjDFNsmu6peThf/Cdt
 G6ESiiH02g/UKTKDIM/lB4GdghmuVsLaEvtBQnK9J5QQ9SKQEbnFQLYwS/l2BMXcoFok
 msOBLEtjB95Qj3PJC14vwh2QNxrcx/27XepIpxwYlUt96vUP2bu5JGBtVDaF4hBSJEcp
 oG8A==
X-Gm-Message-State: AOJu0YzVxwuVTzHwi1pQVBuMSHAcQkQrLxf1ICjaRqrcwRODbDnmbNYB
 TQOnqm5oCXBjjcm/+equlQ53GkJcFFjK7jqTS2F2dNQ3qUls+PCPL2kWV6o0Zh2TuSocwjMdGUE
 j
X-Gm-Gg: ASbGncval+1/rBY7IMMkKnrUI70esIIXuAtp6kiiQfBEj2sH9JX94OGpZFGk04mAMaF
 43oaQcq1PPsTrbqK3+PpoDOq3giaby3H49HhV3pctTkv/XYEjzZ6NL8d3Q7JOoRPf6vyebfxx1m
 h6QM7eZNifDK0OG12+NxcoMKnOJgVU0o2UpY5NVlal1gkq4Og3Xvgdd9iOrhGpLmtwtjYA1mwTr
 iRiaIaUIEtcHvYrfuHDIkFSOrket+jGdm55++GKkvOfEFc2j2YYr9J9WfjJJ0LVT7jRDX8lmVlJ
 b+6OqtjmMxIRcIX5S81UBFXenVQU0Ar7EkUkxG/dNFZTlNpweqd2gHWsyPePlVO8jFKVhA+/9J0
 =
X-Google-Smtp-Source: AGHT+IEo0HpKVRM00HaypfRWZDvEfW76TqdgXsav9qClPvyOQ6un3bcHJ+Bu5+v5Ja7GIrFtE587+Q==
X-Received: by 2002:a17:902:db01:b0:223:501c:7581 with SMTP id
 d9443c01a7336-22c535a4e39mr236437975ad.16.1745350320812; 
 Tue, 22 Apr 2025 12:32:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 061/147] meson: Only allow CONFIG_USER_ONLY from certain
 source sets
Date: Tue, 22 Apr 2025 12:26:50 -0700
Message-ID: <20250422192819.302784-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 2c151fd1e0..4180a5a489 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -66,4 +66,9 @@
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
index 7e22afe135..657949326b 100644
--- a/meson.build
+++ b/meson.build
@@ -4050,7 +4050,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
                          libuser_ss.sources() + genh,
-                         c_args: '-DCONFIG_USER_ONLY',
+                         c_args: ['-DCONFIG_USER_ONLY',
+                                  '-DCOMPILING_SYSTEM_VS_USER'],
                          dependencies: libuser_ss.dependencies(),
                          build_by_default: false)
 libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
@@ -4060,7 +4061,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
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


