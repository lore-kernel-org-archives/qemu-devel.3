Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62611C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWU-0004mB-46; Wed, 12 Mar 2025 23:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWC-0004ga-IM
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVy-0007nx-Mu
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22401f4d35aso9395915ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837544; x=1742442344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPMqV5ZrxescUBAWokXjuel9hAvYVjYaAdlujGAXfkU=;
 b=cGijrBXBjRIojYCBfgjhR9sOa2vJto7rFPFgWc60ri7yclx8IrXXRSp8EdSHanVyun
 pQHIs5l1GVvihAuhwc/QiSopeXkPxZJCgoY0dUXQL+CsuPR3TOT4puB1F60PfpT8+WY/
 rn/JTGCJLGLARsAxCZLIMGJJ2CpUTkVuhZUFSyi4F7yrHYNrW48RxS1tArhohzC89IQP
 AahpoJoEV3C2Euf4WkYoA61eYtU/fazXbzJpFxjAxX220YzRem/kOMYUffBDD1g9Gjgc
 y8D/ST2VSj4VcoygD5dbHAlj3NWw1fxkMHY0Ft/td7saLQCptTU/oW1RyMZXLKsZDnwg
 bKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837544; x=1742442344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPMqV5ZrxescUBAWokXjuel9hAvYVjYaAdlujGAXfkU=;
 b=lv06R7YYVwDVgfVqVuM6rFeD2T/2QW2mzkKa+mCvMcAO8fyyag3GIWk6anD/beVMpO
 0SHcohLO0tW/JjyeL7NaTDsq0wstyCn3vAsYqCPmbb+w00yxO/Fxjj+6v88OMO7+cBpv
 Cco9CG/MODQbpX0VwDEjauFdiGN0gEoArnzumTrkas7x5l9c1RgW+0yBqyg4Fv6fFZ9Q
 ZDHHxzxX6DxXlkmJW4xeDYRIXyuNlxseX5bQLNzQQtPR5pJsayza1YfvlCN10ns1FiHW
 ipS/KSPHI2oeyjQkT9VAvhwvus/s4IGT1KOrr5+EoaILii4QOz/jnc4IZtYokUwuJoQo
 dx/g==
X-Gm-Message-State: AOJu0YzNk5yKHWgsTJJ1qbvTEus/xzP9sNsKEevXcgcuZwxIpOpOwSYH
 QRU6g65mukFcE9Oy4yJMj7YzAA+g7NssAuYUe0qWXthpt9/pkS5tpxuxmKVbId+MHaZmTN+/k4F
 9
X-Gm-Gg: ASbGnctrzanRB0yrAIAv3xVCQEjGRyr/NO4KgpcyGUJ4aCM7Ph/51F2krwfj8y+Kia/
 KMPb5QLBZDrkpTPBbF3DTUs7KVb4qtMMM/Rzwfic4ROhQ+lzzL+4V/hQEqNJglS+2MsGCJ0ZgYE
 IBKiQHB+X2/2BAdFU5MkWOfZrB+Hy3YZ0GqqMr1l+XtU930dcwF2KAuu8dxcvnfB03F4bxp3gXt
 PSXEiyqlKXBDvnl/YmWyRwJfhlKF0zyhWDKziJLnuJuQc6ZrzsnlCfFyxbe1Xn/r2Tu+T83kRmA
 NSeuT17Hnsorxvv7kkvptN2n6H4QJtIkEkRzPllEDyi753tw8zdtrNbSM236Ssnf4m5U/qWlwQD
 t4Xl8kVcrles=
X-Google-Smtp-Source: AGHT+IHqD/JfN0cKDQ7eOQiGKklZGFVD4Ij69WaAwm+ErVaw2EQS1e+iHNPaP+SQ8R+R7CmItgbEXw==
X-Received: by 2002:a05:6a00:2341:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-736eb7ff1bamr13265603b3a.13.1741837544199; 
 Wed, 12 Mar 2025 20:45:44 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 22/37] semihosting: Move user-only implementation out-of-line
Date: Wed, 12 Mar 2025 20:45:02 -0700
Message-ID: <20250313034524.3069690-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Avoid testing CONFIG_USER_ONLY in semihost.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/semihosting/semihost.h | 29 ++---------------------------
 semihosting/user.c             | 30 ++++++++++++++++++++++++++++++
 semihosting/meson.build        |  2 ++
 3 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 semihosting/user.c

diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index 97d2a2ba99..b03e637578 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
     SEMIHOSTING_TARGET_GDB
 } SemihostingTarget;
 
-#ifdef CONFIG_USER_ONLY
-static inline bool semihosting_enabled(bool is_user)
-{
-    return true;
-}
-
-static inline SemihostingTarget semihosting_get_target(void)
-{
-    return SEMIHOSTING_TARGET_AUTO;
-}
-
-static inline const char *semihosting_get_arg(int i)
-{
-    return NULL;
-}
-
-static inline int semihosting_get_argc(void)
-{
-    return 0;
-}
-
-static inline const char *semihosting_get_cmdline(void)
-{
-    return NULL;
-}
-#else /* !CONFIG_USER_ONLY */
 /**
  * semihosting_enabled:
  * @is_user: true if guest code is in usermode (i.e. not privileged)
@@ -59,17 +33,18 @@ static inline const char *semihosting_get_cmdline(void)
  * Return true if guest code is allowed to make semihosting calls.
  */
 bool semihosting_enabled(bool is_user);
+
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
+
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *optstr);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
-#endif /* CONFIG_USER_ONLY */
 void qemu_semihosting_guestfd_init(void);
 
 #endif /* SEMIHOST_H */
diff --git a/semihosting/user.c b/semihosting/user.c
new file mode 100644
index 0000000000..f5b500493b
--- /dev/null
+++ b/semihosting/user.c
@@ -0,0 +1,30 @@
+/*
+ * Semihosting for user emulation
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "semihosting/semihost.h"
+
+bool semihosting_enabled(bool is_user)
+{
+    return true;
+}
+
+const char *semihosting_get_arg(int i)
+{
+    return NULL;
+}
+
+int semihosting_get_argc(void)
+{
+    return 0;
+}
+
+const char *semihosting_get_cmdline(void)
+{
+    return NULL;
+}
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 86f5004bed..ab67f87e4f 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -15,5 +15,7 @@ system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
   'stubs-system.c',
 ))
 
+user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
+
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.43.0


