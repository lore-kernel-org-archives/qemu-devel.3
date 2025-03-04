Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17568C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpamZ-00018d-9e; Tue, 04 Mar 2025 17:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam6-0008BP-T3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:15 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaly-0007nU-BY
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:04 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so11473278a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127395; x=1741732195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NduONkNHzryA23734KniKbJ3709Oe6o9/gEpRh5YHc=;
 b=RyN3ESyuMkXpQgsGbrMy2kuOC0npfErUFUcL2qnVF7BQdv7tYH/foXh5yb6LSlhtkC
 rw8q7gYU2mhiR7LecI7+JTBBF+4qAG1oLEvE8qAYF2n2K+oej46+DeCdXtSns+DTUV/7
 cNgNVduz6wlGxU+PB/pYjjn17rGVQFAuzgOQtLRg7ckihhpzf93WmT67a5Z5AvJq+Z/p
 vIyCvwexuCab0PWWxNiGbEi1URje/algOSC1AjiZ4atAouawBVpx7lVl32VkjHjaAWoY
 OjTAh/t2r9nL05BJij5vqPxypOMUHAbMKNimfSRNTzctWyS7YPRqFJ1Nk+6C0Tfc9pO9
 k3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127395; x=1741732195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NduONkNHzryA23734KniKbJ3709Oe6o9/gEpRh5YHc=;
 b=SFMYkWbiktbiFRkh2Xdn7nSkmiX8UC8ieft4mX5AMGiXGP7teDvGBH3VMKa0X6OJgv
 SDFS5kAQW8CXY+FuUXHuEeLWBDSnhy2qgXJVGf5ggpzCTJGRW/UPmcUI/cC/byswjrxz
 e99tPqDrma+KPbBimcyUdkBbMJtVRxcfkFfnMX3oo+mK75MzKHb59tuXgx2JKGj9v4/o
 j5bINRp4C93c7u5NrEOtSWirBrAPQu2QQ9degSzXvumiSHok0Y7rknEAwxSBZzfiI3Ty
 kr1p8aJGtBWeq9jFpxzsRE4iaVKbvH3+zLunUusIyQJSj3UYIhSshi5T9kmxX1RUKrHJ
 r0Bw==
X-Gm-Message-State: AOJu0YzwncR81MiH8MMHqr9JB2+BEvk7SFPmLgwSoOpnI9IodMy25dA9
 VOdeWMT1YGey5ok9ofGk4qrpJlbSznJIYvYquxv4BM1DLTRtl11IRzf0zXGh98E=
X-Gm-Gg: ASbGncux7sNkuEFYQbXzX6iiu7P6EIMETQ6rs7AYweGaZ720xUqFUvbR+QsQ9xzQHTY
 scLHznLN8f5B+Wg8MH95ZYUsEdpe6+edelUTeuinJm1jRB5/2yeCk4vWMs/MRdIrx+8Vz81YBD9
 PkeNnDvgE/XrCbwtGveUTeYx3ptTEr9yTLGn3tqu/HpS89MTM72zembk+2gvldJ5bEUSXwHc8VZ
 5O3If5yKqBwsffl6KY9s30VTSgz/fuQL8o/mumeX/3ZfNWlW677lf3jcsTTr1BGf+1P4UNE1rMX
 5Jqnfd0hL0oOEFGpQM5YJura7lwaerLfnCmsBpyc1V+X/3c=
X-Google-Smtp-Source: AGHT+IEYyaUJhrtg1WSGdM5XLPAf5TsuQU8GAaB9pDpVMiR600V41mczw7as0Kv3QoUYsBJ18IvNwA==
X-Received: by 2002:a05:6402:518e:b0:5e0:9390:f0d2 with SMTP id
 4fb4d7f45d1cf-5e59f455d54mr646687a12.20.1741127395009; 
 Tue, 04 Mar 2025 14:29:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a66b1sm8643141a12.71.2025.03.04.14.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC3E1625C3;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 25/32] plugins/loader: compile loader only once
Date: Tue,  4 Mar 2025 22:24:32 +0000
Message-Id: <20250304222439.2035603-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There is very little in loader that is different between builds save
for a tiny user/system mode difference in the plugin_info structure.
Create two new files, user and system to hold mode specific helpers
and move loader into common_ss.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-7-alex.bennee@linaro.org>
---
 plugins/plugin.h    |  6 ++++++
 plugins/loader.c    | 13 ++-----------
 plugins/system.c    | 24 ++++++++++++++++++++++++
 plugins/user.c      | 19 +++++++++++++++++++
 plugins/meson.build |  7 ++++++-
 5 files changed, 57 insertions(+), 12 deletions(-)
 create mode 100644 plugins/system.c
 create mode 100644 plugins/user.c

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 9ed20b5c41..6fbc443b96 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -119,4 +119,10 @@ struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
 
 void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
 
+/**
+ * qemu_plugin_fillin_mode_info() - populate mode specific info
+ * info: pointer to qemu_info_t structure
+ */
+void qemu_plugin_fillin_mode_info(qemu_info_t *info);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/loader.c b/plugins/loader.c
index 827473c8b6..7523d554f0 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -31,9 +31,6 @@
 #include "qemu/memalign.h"
 #include "hw/core/cpu.h"
 #include "exec/tb-flush.h"
-#ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
-#endif
 
 #include "plugin.h"
 
@@ -300,14 +297,8 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
-#ifndef CONFIG_USER_ONLY
-    MachineState *ms = MACHINE(qdev_get_machine());
-    info->system_emulation = true;
-    info->system.smp_vcpus = ms->smp.cpus;
-    info->system.max_vcpus = ms->smp.max_cpus;
-#else
-    info->system_emulation = false;
-#endif
+
+    qemu_plugin_fillin_mode_info(info);
 
     QTAILQ_FOREACH_SAFE(desc, head, entry, next) {
         int err;
diff --git a/plugins/system.c b/plugins/system.c
new file mode 100644
index 0000000000..b3ecc33ba5
--- /dev/null
+++ b/plugins/system.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU Plugin system-emulation helpers
+ *
+ * Helpers that are specific to system emulation.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "hw/boards.h"
+
+#include "plugin.h"
+
+void qemu_plugin_fillin_mode_info(qemu_info_t *info)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    info->system_emulation = true;
+    info->system.smp_vcpus = ms->smp.cpus;
+    info->system.max_vcpus = ms->smp.max_cpus;
+}
diff --git a/plugins/user.c b/plugins/user.c
new file mode 100644
index 0000000000..250d542502
--- /dev/null
+++ b/plugins/user.c
@@ -0,0 +1,19 @@
+/*
+ * QEMU Plugin user-mode helpers
+ *
+ * Helpers that are specific to user-mode.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "plugin.h"
+
+void qemu_plugin_fillin_mode_info(qemu_info_t *info)
+{
+    info->system_emulation = false;
+}
diff --git a/plugins/meson.build b/plugins/meson.build
index d60be2a4d6..f7820806d3 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -57,8 +57,13 @@ if host_os == 'windows'
     command: dlltool_cmd
   )
 endif
+
+user_ss.add(files('user.c'))
+system_ss.add(files('system.c'))
+
+common_ss.add(files('loader.c'))
+
 specific_ss.add(files(
-  'loader.c',
   'core.c',
   'api.c',
 ))
-- 
2.39.5


