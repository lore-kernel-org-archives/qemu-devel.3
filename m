Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4764C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksp-0001za-Ms; Wed, 23 Apr 2025 20:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqO-0000zm-9b
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpy-0004gn-Po
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so304453b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455989; x=1746060789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwbKvRdGoMiUrRuxJx+msL79vGWbZKojWAn1/Wo2xRE=;
 b=xF1Dbn4WWFDALgf/Lc5PTDGWPmXnjLig77rJgjL8iU6Uo4xqq/sNZ4fU6WYn7on8tl
 LBgNNB/7PAI1uH776QKtFxdek+L643GRLc97Hbj3OhjuNOGyD+ElCMAOp7GwjQXj3J9F
 e1HgmNmpwqWdFs+cndz6N9rEIEvdpCarA6PFWRqFlT/4+dkW0xpF/aBFDBBme7U4CVF+
 7itvq+Zg4GqBrmUP5hnT7EsxHojirnfw5POjZWidINIFgMTIMt37DGkMdGtdwSNerFV7
 Kz7g0PF0PCsxQny8gwk/JsEv+w3L1cK1TM56MF7MzArJdj/j+Vyt4XVH2fgBLYfC8I2o
 1kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455989; x=1746060789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwbKvRdGoMiUrRuxJx+msL79vGWbZKojWAn1/Wo2xRE=;
 b=cOfxqCrLYE3n94bmk7nt+pi91yJHgCFRWNPZqvP4C84KdvBanq7TAbyp6YnLsXn2n9
 Tr3OjNR1caXNThiEvp/pYv760jSz2cqN9B80W8q2iSBztrKx58iNKuIXcFz75xC8ZrUJ
 quyX+lo2Qg0yUgfWgT5pLmj36c7QvfHBrNdEDF7EwS58MjJZjt1GmC0Gml20bUaHs0lZ
 YpMqwHgFcrte8t0lMwOS9LTKs+5M4Pz7wY2MlhlU26OpKLiQkhCALkYzX1LoLj7rB7BX
 6H72MUsUNXKXSc8G/Ce8nwSGwKPdQi4bjL7twrfXKO22fvxQy26doJppQ66JmYZlLhnX
 +jTw==
X-Gm-Message-State: AOJu0YysDMKFJ/ps/vklw4/54Pl6kku1cbeCGsEM4Ogx3tzQYMwNFvuE
 GNH4Z09QBgCUyuScytN1EdwM1e5dCBo/ClpMQagLgOO69U9EN8EloL2evgDehBKNY+kiNiOFJLq
 i
X-Gm-Gg: ASbGncujucHTBo9YnpCxT6qnLV9jAbtuB2gJjcuJu+Fr2ngABDCPYRhQuWqjiPlKjJo
 9bWp356LdQ6Z5WUcd7JXvMArUCCh0zFAax6MTUFnzq0EJHs0Nrop/BsmSltynwYz+TENjxVGyXl
 K5ckmeQ1GHF4ui3D/XM+FaVzsGv/N7byQDZixapxjtn7DQ8u4LaF/h7o2m1BX0sKT+WIVK1wbAp
 oVsR5eqgtvv5WxaIJstEqKMVTHdbCJ/gMd1qJNwf2ohOk3OBMbepQUK0aCf598oL32QNBe8DRd+
 lUSa1kSINgYYGYjpFYDDsJZwoAo/MsNxv4ZMSW7IjQ1J3khUFdEKRsS7RCnrujnagfZ2TMhOBLU
 =
X-Google-Smtp-Source: AGHT+IHLLnieU/Aq5ZaPDM5umhB/LmNnLLuSz56ISGzscxaEpIStF8IgnSThOJRy0rg1U7VUlPFhJA==
X-Received: by 2002:a05:6a20:d817:b0:1f5:7f56:a649 with SMTP id
 adf61e73a8af0-20444eebf54mr848872637.13.1745455989145; 
 Wed, 23 Apr 2025 17:53:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 046/148] semihosting: Move user-only implementation out-of-line
Date: Wed, 23 Apr 2025 17:47:51 -0700
Message-ID: <20250424004934.598783-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DIET_1=0.001, DKIM_SIGNED=0.1,
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
The only function that's required is semihosting_enabled.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/semihosting/semihost.h | 29 ++---------------------------
 semihosting/stubs-all.c        |  6 ++++++
 semihosting/stubs-system.c     |  6 ------
 semihosting/user.c             | 20 ++++++++++++++++++++
 semihosting/meson.build        |  5 +++--
 5 files changed, 31 insertions(+), 35 deletions(-)
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
diff --git a/semihosting/stubs-all.c b/semihosting/stubs-all.c
index a2a1fc9c6f..c001c84574 100644
--- a/semihosting/stubs-all.c
+++ b/semihosting/stubs-all.c
@@ -11,6 +11,12 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 
+/* Queries to config status default to off */
+bool semihosting_enabled(bool is_user)
+{
+    return false;
+}
+
 SemihostingTarget semihosting_get_target(void)
 {
     return SEMIHOSTING_TARGET_AUTO;
diff --git a/semihosting/stubs-system.c b/semihosting/stubs-system.c
index f26cbb7c25..989789f373 100644
--- a/semihosting/stubs-system.c
+++ b/semihosting/stubs-system.c
@@ -22,12 +22,6 @@ QemuOptsList qemu_semihosting_config_opts = {
     },
 };
 
-/* Queries to config status default to off */
-bool semihosting_enabled(bool is_user)
-{
-    return false;
-}
-
 /*
  * All the rest are empty subs. We could g_assert_not_reached() but
  * that adds extra weight to the final binary. Waste not want not.
diff --git a/semihosting/user.c b/semihosting/user.c
new file mode 100644
index 0000000000..515de3d2c0
--- /dev/null
+++ b/semihosting/user.c
@@ -0,0 +1,20 @@
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
+SemihostingTarget semihosting_get_target(void)
+{
+    return SEMIHOSTING_TARGET_AUTO;
+}
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 86f5004bed..f3d38dda91 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -7,8 +7,9 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: fil
   'uaccess.c',
 ))
 
-common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
+user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
+system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
 ), if_false: files(
-- 
2.43.0


