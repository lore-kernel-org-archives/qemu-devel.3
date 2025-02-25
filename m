Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF119C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoK-0001cG-DN; Tue, 25 Feb 2025 06:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso2-0001YA-8l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnz-0007lD-93
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f3ac22948so2757051f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481729; x=1741086529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewr0cjB6f+D/BiqNnqVJdKZmiJnBgBiJmXhO/bcFtVA=;
 b=d5ffqIw2wxI/DuGaUPN/uyxmPUlEBZTVA7kX87upAiJ4X7kF7y62Nyul3Fp/zx37Yh
 X+8kFPAUcutmqjgZPjRcp1EKYhTSKOF07g7HwpgpoPMQfMOUWcV1nM3FfrWfo6V+B11M
 0zMwJL09qjpV7SAGHE6bNoEzwMwifIU2vlqPBI57zmMkLpn9MqPglvRCGb1FEOd36cJe
 Vg9inTnzy1eaPhWCPcCq/F2G4Ukh2GPG/Qa7kajO/14xofx4laBLT74/K0u7YKZQcUVf
 jEVWjH8A1uWORSE1lBOxv/v+55jMtMVz1Ua3Ku7WEZ4rdCxC9rTd1DaoWT0vbj58QPoP
 ZLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481729; x=1741086529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewr0cjB6f+D/BiqNnqVJdKZmiJnBgBiJmXhO/bcFtVA=;
 b=Vv7vDLT6gYIPqxuf1K/495LTdWO41CD9pgxE/iayaJ7cw1IZfT4tZgV54kDIkC9+D4
 5IL/ds26lZ8H1qpCCFwdyb+BxaB9ZmeYT3EFAsA/2UJgV7cj06ZLDXLyHZPbuFK7Rkw6
 89adNhytd7foe+f1fDSTvjM05l91GhexVHnx6OFSycppW85Hl29iLNAZT2tL6qPniYl9
 pSGJNFMaCBRvNpfij5Sybkk2JPB54jTglOu5mwdY1I/eUsEZD1ifdu+Lochk5Xs0EoXH
 M1LbW/4BeX3GzCThN/LlvguQjDHnh8v1nhGH1mdPusdSd41tbOfEsp+NI0a8serbmPIg
 Nm+w==
X-Gm-Message-State: AOJu0YwhLTkCfRkdmQa52PszPpbc5humIwjPtlANxq6wMEayHoaNAMne
 uiEJ/ng43s7HNLnBEHKOv0Ipq895E1xkWnC6UxZF//vboha15v5A2gIJb7tKBnw=
X-Gm-Gg: ASbGnctgG+gyjBfD1wu6hYKFiG7obO4tAvDPeLzVIpjdktI+1hH9VTLltG9ss8wqCYO
 WLWo8doE5XnI8WTiaEKJwUfV+ECUv0EWSqbaHCgpVKVBx2TuYTNjWux0E0vb9/C+geIZBOgJE57
 1iUPo41ROhgvQkgL/zVKIdE3C5BtWgY895yHvV9ZkuNRp7hi1Ozpf/BAg6Atz+Kdh0xK3AcdYC4
 /YCA2mQd5JTj612mxVK67a6ur80oEUWYckUzJblkMfuxvihRyd5yMw6SWUu4ZoAPUvwle44JArX
 Jo7CO+SUqrExpvBHIzgoRO2TjQoK
X-Google-Smtp-Source: AGHT+IHLfi8JcE0qjtIpELBvf0MyORKDmiRkihGdYk9i/NGYrkAO+aQpGpQGEGkKL0N38ZP0jygALQ==
X-Received: by 2002:a05:6000:1447:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-390cc5f20e0mr2418672f8f.3.1740481729559; 
 Tue, 25 Feb 2025 03:08:49 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2ee361dsm10521075e9.0.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B77735FA77;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 06/10] plugins/loader: compile loader only once
Date: Tue, 25 Feb 2025 11:08:40 +0000
Message-Id: <20250225110844.3296991-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


