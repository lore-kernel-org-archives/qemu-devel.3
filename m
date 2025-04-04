Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE10C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Xbs-0004VN-0C; Thu, 03 Apr 2025 23:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbp-0004UO-OU
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbn-0002KE-6i
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fb0f619dso16780355ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743736842; x=1744341642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gavQL3JwiRzypFeNGtc8FI0f417Fp8ofqnic4ezhfa8=;
 b=aZZxlg+xQwgKFeurs+pjkrhkn4Z8fx7cec/sD/mIjk+Y1LjfV/kk8LAfdXzD7Xitr8
 O5g4TOG0aPMDhKn5B7EaAWvjHb+p0lolLR1EKy3SNriWyiT8WwBnAWGbFLOjNOb/nH+n
 1ehll6nZZIytuYXne1BPxyfZQPqZ11P/isApcYw+zhyDeVs/7DIRdvCSI4bgqNyHksX9
 XcEWXQg/BqLbCvSAKhtnfIBNvmFKRYh3WQq0oNwQvtCRdoKeS+v0hSMY0BBm4HAa1SkT
 hDUAfmQsjt8tcExL+wn1MYUrsVPzMq+y4NbQ/qlFhq52nEmWqprULlxdkkJ1GosD1Jlj
 CA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736842; x=1744341642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gavQL3JwiRzypFeNGtc8FI0f417Fp8ofqnic4ezhfa8=;
 b=Sq1x7LPqQsm2TGNnf2Iwekr3Wy9UF0jNHlaBgDCOPrBwzXMbMNLjjTm8h60eUuRhdN
 Xzp+ndq8V5SZgbHoHUbbV6yPuEk31x7RAr1PFUEt52eiKVFWhUmbM3G260IvrVXbn0yg
 XGEhXbJm19js1i68WM8rTF75ICiiQMD/xHRoijxWoYRjR/+32ss4SukPC4ZBpB3dhRm8
 4VFJMr75i/rHYTgTn3y4+46+EzPninmV1WHPmc8K3Uow4hlpu9DRO6NLEaNLe4cR5HJV
 slf8cjevJUldMK/RyaLHwnDN2Hyw5qYN7OW9oux96v1uJ2Dc1qCJHMH/nXak+npG4r0X
 QzXw==
X-Gm-Message-State: AOJu0YyWaWfiT3Ea06N3hQPDqsoDtlwpXoqTEEt/OkMrreie7kj3wcWW
 IEZ2BcPWsbGx6jc2QevPQOQsIhp5kQCFtovxPevZLZ79jlTpcmtVsTVx485X1LG73GXG2eO4BxF
 L
X-Gm-Gg: ASbGncuMbPauWbvG2v7Yr2jz5ydHSIdrD/QdiRWsJENL6yxHC/i/z7NpR3S7E6FT0kz
 jT417FpvI2PRUiGmSpi+6T4TcWSXvCFeAy9K+dZd+oPEg0Ix4fnX8HTSD05111nh9QMidg55XhO
 zhZN5RQRcZh7v8/HFmXfYYfuT61rMSM6Di75+oqZh5+Wc0MwB3UxR9B3eUmTjBOOwCinqTAK7RZ
 5ykN2n82he++wbZMhHbWhWJ42mNvhRI6FHCladcHR7GVi/Gz9hMWVR4VlVKFeZJL5ehxQ7HuMLi
 IQoG1WPhK5SUNFCrDDBnqCG7xLFCP9XN2BpLlS0MUJ1y
X-Google-Smtp-Source: AGHT+IFpRMm2KZNnDI22QKkc7T8fMWQAmxZdSeVhI7LyMiBmcPWJoXhOeNXiwCbCi5pcvkhh39RkaQ==
X-Received: by 2002:a17:902:f646:b0:229:1717:8826 with SMTP id
 d9443c01a7336-22a8a06d686mr23137615ad.28.1743736841703; 
 Thu, 03 Apr 2025 20:20:41 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad943sm22325945ad.23.2025.04.03.20.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 20:20:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 2/2] tests/tcg/plugins: add plugin to test reset and uninstall
Date: Thu,  3 Apr 2025 20:20:27 -0700
Message-Id: <20250404032027.430575-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
References: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

We perform a plugin reset, uninstall, and make sure we went through
those steps.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/reset.c     | 73 +++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build |  2 +-
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/plugins/reset.c

diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
new file mode 100644
index 00000000000..1be8be2a4b2
--- /dev/null
+++ b/tests/tcg/plugins/reset.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * Test the reset/uninstall cycle of a plugin.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+static qemu_plugin_id_t plugin_id;
+static bool was_reset;
+static bool was_uninstalled;
+
+static void after_uninstall(qemu_plugin_id_t id)
+{
+    g_assert(was_reset && !was_uninstalled);
+    qemu_plugin_outs("uninstall done\n");
+    was_uninstalled = true;
+}
+
+static void tb_exec_after_reset(unsigned int vcpu_index, void *userdata)
+{
+    g_assert(was_reset && !was_uninstalled);
+    qemu_plugin_uninstall(plugin_id, after_uninstall);
+}
+
+static void tb_trans_after_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    g_assert(was_reset && !was_uninstalled);
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_after_reset,
+                                         QEMU_PLUGIN_CB_NO_REGS, NULL);
+}
+
+static void after_reset(qemu_plugin_id_t id)
+{
+    g_assert(!was_reset && !was_uninstalled);
+    qemu_plugin_outs("reset done\n");
+    was_reset = true;
+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_after_reset);
+}
+
+static void tb_exec_before_reset(unsigned int vcpu_index, void *userdata)
+{
+    g_assert(!was_reset && !was_uninstalled);
+    qemu_plugin_reset(plugin_id, after_reset);
+}
+
+static void tb_trans_before_reset(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    g_assert(!was_reset && !was_uninstalled);
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, tb_exec_before_reset,
+                                         QEMU_PLUGIN_CB_NO_REGS, NULL);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    plugin_id = id;
+    qemu_plugin_register_vcpu_tb_trans_cb(id, tb_trans_before_reset);
+    return 0;
+}
+
+/* Since we uninstall the plugin, we can't use qemu_plugin_register_atexit_cb,
+ * so we use destructor attribute instead. */
+static void __attribute__((destructor)) on_plugin_exit(void)
+{
+    g_assert(was_reset && was_uninstalled);
+    qemu_plugin_outs("plugin exit\n");
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c8cb0626a6d..41f02f2c7fa 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
-- 
2.39.5


