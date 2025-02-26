Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61861C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI9p-00005V-RL; Wed, 26 Feb 2025 09:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8e-0005Re-G9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:01 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8Z-0007Z8-4M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so43528885e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579103; x=1741183903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NduONkNHzryA23734KniKbJ3709Oe6o9/gEpRh5YHc=;
 b=u1gi+6mkRmmi7OBSyZg2bxAQkugnQQ71KYvl/DwxC0sKKM49YbOBJjsLl8h+UJrCmg
 DT1Vf5SiCVVl63SFay4nuGJQHyZrthELFLrJmdKf7WeF5oUIQSHjpveAhBnwL/fMSSsV
 DUPSFJ7+iCzZYLgaRGfDKPweJjRHbgchWYcIsMKQgrh4MZSK4i6Z4y7Rvahc18bhFptw
 j/91l9MpbBGEWI2BjZ5nucKSIKVPTpWpmI0Xqk0a52CsfarsTd+O7qBbvg0regaTQk5D
 KW6zM/a5UlZUjJAP9trWUsQvH43qnEL7P/Q4GgVd+RWKZ9ee77Hn68+fflPqhbGCu8M+
 4PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579103; x=1741183903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NduONkNHzryA23734KniKbJ3709Oe6o9/gEpRh5YHc=;
 b=HYB5EvSW1VcoeQE4u97sNI1xQ0a/DfSLOkYiZVPs2WEFkybzyqWqWpks6a+hO0mwbJ
 BzJfQ1nI8XDf7UPSzkxw56vrKnw6wBo9dUJmdGycpRd/rIcrbLTVOdhlyos2mGyT8ohK
 pBq43WiTE7alBR8rJqEPzk0ElnuY784VkotI27358sWNhNRMfJoDUBECMImBRy1C8vl8
 1/0rlP+vymElh26eYmPM2HMgzll0MvFqKIJ8WMCxP/WclvvsldGYijrXxvC4CPBulq6O
 Yvohat2TgiEoT9/musxN0OrOvnUQScrfxsaFsIzk52NNOYHJeLJx2N7r29HWTSuXCByL
 Zc+w==
X-Gm-Message-State: AOJu0YwnTO0YQuc0kitZPKSQyzITLSgyLpd3xQCFkMoTkiGE4TWvY0A6
 vyR72Qk8Sxv81gShRA/aPX3WVBwCnpi4BwAq9+97G1ElLIIRkDC4vsL4bB91uGg=
X-Gm-Gg: ASbGncsoLK9cjejFoWbH2vBjEnIyrsN/DH+qYsw1A/M3uiC9Ezgtxor1FQtaqhNQmv8
 H/OOohuwPu3533MspKqQeO86qqxx51ITWQOdTc8mdQngVr2vT9+3hNZ9NkVXUgNruHFXLx+dmQ7
 MKgTteyHWVkBRJncSVd/Z7Z6+1P/4ikcWAkEghWEEDauhIRUighEh0ne8AzWjVHddktCt45kMbK
 fm4p42ho+bAZ2PamuBp8GB35R7bG9Ab+vXQcuJ/laRxWn2TGYxGFRVu3raRGOx24/TVJ3vk8KLv
 NfglrWpZz/JcIdztNh9V+1ynv2JE
X-Google-Smtp-Source: AGHT+IFrQcjmbOw6dSRCjQJxBYsvNcSnp22Xn4NpDOzqFMlr40EPPbe18kn62r72W0EnjMtkyVLhWA==
X-Received: by 2002:a05:6000:1864:b0:390:dbf5:407b with SMTP id
 ffacd0b85a97d-390dbf541d3mr1600486f8f.28.1740579102813; 
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e70c8sm5673538f8f.76.2025.02.26.06.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D869D606FE;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 20/25] plugins/loader: compile loader only once
Date: Wed, 26 Feb 2025 14:03:38 +0000
Message-Id: <20250226140343.3907080-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


