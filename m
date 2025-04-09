Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B04C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VLR-0003r4-Gq; Wed, 09 Apr 2025 09:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLM-0003pi-0E
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLG-0001OM-FC
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so5678112f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744204784; x=1744809584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPim0OCZ4SdNm+PdrMyC88tt/xq9iIkHytGr1uhNXmY=;
 b=HH7BmVS9c+xGd0Ju8AlYwu1FzGs0/HQ8/yl8Qw7ArbRj7AYyepWVi47RuoKKXduws5
 Ny9fl2CkaU0CrS1EebDT3vpDbvyCKxplm5n0uloyPii4SgiQZU+8bWCSgybURMwXdiVW
 Wh+B6JBgORby+aCHlRP56iFAWmECOmLNUr7h3mJNXKZB6UF4ZfsRH9IUg3VUSLdaIddo
 z3imM1EOPw1q1T+TQB4KX6yplhG0Mzsyydq7ZJj+2qF4r0GKO+G5YG6Hnagy374cmW5X
 RDgYcwl0+DMLVZ/Y0S44j53Oh4H0KKvH41aiy8i+Fzv33sV+tgts7OqkpAU/tyGf/4K5
 yc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204784; x=1744809584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPim0OCZ4SdNm+PdrMyC88tt/xq9iIkHytGr1uhNXmY=;
 b=QAF4/74bQQpIXxXG6z4ufY2uLsi/F1g5z1MHLYNOPEWQpzNhBiQbC+ZewI80RmRagJ
 Mizp1nnVXZjYcPiNfwP8C7aXV9gfYAmaXnGmXZW9xiyo49q6PhsnLu/o1A1ol0t+pjmW
 gzJz7cxHSsueBg5Oc5lib+5B1jtnFXtgQ7njlYjljf5Jk0xjfDvdqLv9UHb32TsmBZHC
 TDlUl0kThWSJOb8um2OLANYF8f5gcUVijOomgBpZBfCJ1CMfEdHRy9Zgc78/9M4ax8Yw
 wVIfWzxjey0LvAc+TvGneld/fC4PIzPd6QnZNz7ZYELxybpIIiT+fshnfiSFHXkC2csT
 TtJQ==
X-Gm-Message-State: AOJu0YylxKtkBLK9s/s/kIu59Tgg9fcvLs42lxbtEaX7PGiOfdcZWRSV
 oGoO+9bVS8LSibzV+ttE5HAeco/EtwD0Hox6OPVT1maKxj4NU2P5O8/6vtkqESc=
X-Gm-Gg: ASbGncvxyLW0joEo+isvytclgudcsoQZqqJR6bj6SMiZvQBYMUpsTHn7JJVtjJKlUdA
 sx8qs9jK0OmL1mRuf5ci5Bvaqwb0WJp6NmfLiEAc2SC+kxGhA+0U8Eo64P5TVl6HmOqzTOOVYn3
 FmX4K4rmfTRSISjC6UBvW4HUx//zJZRC3ydnb4cn7bFcLofz3JUSIT6LRS+FNUFr/YishT5GIPq
 4x/SR9iUVRn4etkuwKo50Zk/fYDvz2tLsLZ9wyqTLdjMnXDw8oAJq0KmKSdsrGO0NoECGX2/HuJ
 M5+4WzWreiCZq2MvSn2c7LazO+TVTuqqXfjblII55Qs=
X-Google-Smtp-Source: AGHT+IEARGnNAxxnnuzeewKTYHrS044Q6VjpWNYmCyPnR8TT45LX9p/qiLKUx1gyPPRLxBupx+Nxwg==
X-Received: by 2002:a05:6000:2913:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-39d88524404mr2322897f8f.9.1744204784436; 
 Wed, 09 Apr 2025 06:19:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207cb692sm21103135e9.40.2025.04.09.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:19:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B335E5FA4B;
 Wed,  9 Apr 2025 14:19:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 3/3] tests/tcg/plugins: add plugin to test reset and uninstall
Date: Wed,  9 Apr 2025 14:19:42 +0100
Message-Id: <20250409131942.1706923-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250409131942.1706923-1-alex.bennee@linaro.org>
References: <20250409131942.1706923-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We perform a plugin reset, uninstall, and make sure we went through
those steps.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250404032027.430575-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/reset.c b/tests/tcg/plugins/reset.c
new file mode 100644
index 0000000000..1be8be2a4b
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
index c8cb0626a6..41f02f2c7f 100644
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


