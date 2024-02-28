Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD2C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIZ0-00067k-Th; Wed, 28 Feb 2024 06:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYy-00063o-3d
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:28 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYp-0005nf-7x
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:27 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so3675418f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121437; x=1709726237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5MR4psNBT9iamDRZsbfoCZ2euS5zGBL3DbUgre87To=;
 b=au8QVJtVmRBU2QgYMmmAWjrXSPxKsANjmdVKZeUiKQqnPRyuiBiweEtiwwcXb7QIsO
 xE129/wO9Qb6Rsi3TuW5s0XGFQW/iBlgvuuLzzBCmU5c0YfusVPGIIyHzyy01NxSBa6f
 z9K3IUev6NC0ANpJWlrKhsLsfRbMp7iEf+zUyxQeRDiZIPVxpyXwwD9hbg9+40b1M8VO
 RuEKbRMm1XaWiJcwOsCy8UOtwkahd4X7lLRjngI+ZCNuLu34wuOYMOy6evvExUp1O8tq
 ynY6u3hA2yxseei4wiNCrR3AXDwvVuzLPpX1ozkCX63vJyocYI1WH3j/2zVwZFcgJ0/z
 bYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121437; x=1709726237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5MR4psNBT9iamDRZsbfoCZ2euS5zGBL3DbUgre87To=;
 b=aa3mibvmGhH3J5ig+r2PkCvPaLseSvOK6sHfn9HVdahc7hMKFc708lCNcwm5ztIUQt
 go1guk5xEpJQhlmm08bsysuP2FHZg6Hh/W9JVb33cJPfcZWw61MvjDPh2x+X7ll31LV/
 BHRQTQFH6Ch1LcFkq92N3zHfyJB3DBodpniH/Xgs7GrkmL9JkTqa/Y+PJ2kHEMxAHWWn
 JyLhNK3mSsDTGZvr4WHtzNYg6TZGIORfpAaDSpWFzO6I9UNCpDH14Kr71ccEnyBb3my1
 R/bCjejkEKCvO2YKgR0R4WI1QtwNLbhNUCqgrq9rc3P65kISLxpZ681+O/WpYZ7+7R2n
 Vc4w==
X-Gm-Message-State: AOJu0YxHNl048YNaR9WpCkf+VYZLlocCiba3LPLqFEX5l9mlzgs5ejOv
 /4dqD3i+0hlwVTGdVRBh9inFnqsZvmUp/kvV2oQ6thtdu9JM2hIdF0x29Iag07A=
X-Google-Smtp-Source: AGHT+IFm4Coy/XlhnmjpvMKhZmXs5D6clu9zZ3Rq8k9b0AF4CEFLTQWu6qukb7WtIEvfriiIJMMZQQ==
X-Received: by 2002:adf:e50d:0:b0:33d:1fce:5e32 with SMTP id
 j13-20020adfe50d000000b0033d1fce5e32mr8405533wrm.16.1709121437254; 
 Wed, 28 Feb 2024 03:57:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w10-20020adff9ca000000b0033d1b760125sm14452795wrr.92.2024.02.28.03.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76A175F90F;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 15/29] plugins: remove previous n_vcpus functions from API
Date: Wed, 28 Feb 2024 11:56:47 +0000
Message-Id: <20240228115701.1416107-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This information is already accessible using qemu_info_t during plugin
install.

We will introduce another function (qemu_plugin_num_vcpus) which
represent how many cpus were enabled, by tracking new cpu indexes.

It's a breaking change, so we bump API version.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213094009.150349-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-16-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4daab6efd29..e45181c793c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -50,11 +50,13 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * The plugins export the API they were built against by exposing the
  * symbol qemu_plugin_version which can be checked.
+ *
+ * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -643,12 +645,6 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
-/* returns -1 in user-mode */
-int qemu_plugin_n_vcpus(void);
-
-/* returns -1 in user-mode */
-int qemu_plugin_n_max_vcpus(void);
-
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85e..90f3f324ab6 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -15,7 +15,7 @@
 #include <gmodule.h>
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 0
+#define QEMU_PLUGIN_MIN_VERSION 2
 
 /* global state */
 struct qemu_plugin_state {
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 9e7ade3b374..c5c8ac75a9c 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -767,7 +767,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     policy = LRU;
 
-    cores = sys ? qemu_plugin_n_vcpus() : 1;
+    cores = sys ? info->system.smp_vcpus : 1;
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
diff --git a/plugins/api.c b/plugins/api.c
index 5521b0ad36c..2926b1961a8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -342,36 +342,6 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 #endif
 }
 
-/*
- * Queries to the number and potential maximum number of vCPUs there
- * will be. This helps the plugin dimension per-vcpu arrays.
- */
-
-#ifndef CONFIG_USER_ONLY
-static MachineState * get_ms(void)
-{
-    return MACHINE(qdev_get_machine());
-}
-#endif
-
-int qemu_plugin_n_vcpus(void)
-{
-#ifdef CONFIG_USER_ONLY
-    return -1;
-#else
-    return get_ms()->smp.cpus;
-#endif
-}
-
-int qemu_plugin_n_max_vcpus(void)
-{
-#ifdef CONFIG_USER_ONLY
-    return -1;
-#else
-    return get_ms()->smp.max_cpus;
-#endif
-}
-
 /*
  * Plugin output
  */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549d..ca806000d54 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -16,8 +16,6 @@
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
   qemu_plugin_mem_size_shift;
-  qemu_plugin_n_max_vcpus;
-  qemu_plugin_n_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
   qemu_plugin_register_atexit_cb;
-- 
2.39.2


