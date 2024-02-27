Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698A4C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyif-0007xu-3h; Tue, 27 Feb 2024 09:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reyhM-0006cI-0Z
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:49 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygU-00027W-31
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:44:47 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d28051376eso40112781fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045031; x=1709649831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VoWfZh+ZjeHnIZS/0T0SSPiqruErjk06xElhK1rNbU=;
 b=csHqr+u6vBSBkJ4qN7u31lS1jVroBhHs1VYOYiaDubuOAxWWjQKvesbz722GyrTEdx
 RTrswhGP8vmCLkr7+h+ZAvdm1SZ+RMjLs8TJ003VCTP2p13PlJLaEqG1qSJPTZgYWAov
 gJ3X0eoN+JaqFDYrF8bVMtWzRrHgtHEpexeFUhot+AXLvL/n8Gb8iluTIh/4gkf5N6T1
 TNI918h0BjM6+7WvOD8o5yEKaBDZrL4hQF1eUnrxyQfxnVdnks1Gkr7YPrQdZQulPR5M
 TEs8bjLcgwTBvU2/PTCaR9emeMYH/WYx+mNbrvLhe9QBmVRo1lSl2iOqNnm3vKRmgHOx
 R0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045031; x=1709649831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VoWfZh+ZjeHnIZS/0T0SSPiqruErjk06xElhK1rNbU=;
 b=OkG6Cnme1wjk1sTG6Rx60xPRnzo5DA5e6BpF2wSuewGZrEQVt8CT4u5/LqPKcmbZcv
 aG6ZDYpWb9RrIx3cUr4cA8e5xjSQ7x6VUxXtUsQpStF/0IbRiEz3YmzugpvMJ2gL5Hvs
 5+ha9j2HjUwQhLR29N+DwX6TXfL1gpbhM42P9TDBghLDVeuOPj6BWkIuEY7yd8U2TCfE
 q6Jyn73PAqAS3nnW0BLqhh5tDmAyGJRh0CTpAeO2lrmtoMEnVX7lfPV8yKhtGr5HqRD8
 EHWSIgaYVhTml6TmlrZVHimB8burq0+Tv+xyqib9hda+q4XOk8xy1OngDXFFdwV0flKF
 IvXQ==
X-Gm-Message-State: AOJu0YxXy0K7Njd9WV4xwXIwzaw9hIGbocgxH06BY1wTfLA8KqT9qXlq
 D+wX2rsUMZEG1YVeY6WXrq/Y1vcwXZ7GnzIAyT2Sv0n7XCFP/QUWw2zvYjkUWTc=
X-Google-Smtp-Source: AGHT+IHknx+LqXL3Q4Ng1ItwEbvm5vYdlBF3ZeI/fkv31spuGKiqN4pzUPkNCiN0f1ENhSRjfjCpLw==
X-Received: by 2002:a2e:a1c9:0:b0:2d2:3a7b:a78d with SMTP id
 c9-20020a2ea1c9000000b002d23a7ba78dmr6255906ljm.33.1709045031694; 
 Tue, 27 Feb 2024 06:43:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c225400b00410df4bf22esm15302166wmm.38.2024.02.27.06.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 070475F90F;
 Tue, 27 Feb 2024 14:43:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 15/29] plugins: remove previous n_vcpus functions from API
Date: Tue, 27 Feb 2024 14:43:21 +0000
Message-Id: <20240227144335.1196131-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 include/qemu/qemu-plugin.h   | 10 +++-------
 plugins/plugin.h             |  2 +-
 contrib/plugins/cache.c      |  2 +-
 plugins/api.c                | 30 ------------------------------
 plugins/qemu-plugins.symbols |  2 --
 5 files changed, 5 insertions(+), 41 deletions(-)

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


