Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2482DC02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyo-00081h-Bw; Sun, 02 Feb 2025 22:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyl-0007zm-QW
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:31 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyk-0002f8-5o
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21ddb406f32so59669465ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552708; x=1739157508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buZLA0qUirjW027SjrYQXL+U33fLGsXttbSr8L05NfY=;
 b=hAwnu63hvTrfsKdkc82YuvY5OnZlD43RDjNbk8z/ThmGXW7qNcWkpk/pTv2mMy7ZwZ
 DibThNcgKK1nUvKCb3Mfu8kWKRbZyc8omP8u6VFYGZ4QeVjm+5MgjTZSIPeuPd9e5ABX
 n13BJ3jVSWSTA8e+npksjPxVjed/pl58iFgGeMkWgyawMYIfTGy9uAzIdA1XCbjKR8nZ
 lwuvRoAJo06cSbVOCtdRO9nfcST6Dgq9iAY48aIA0vI6G/ug4LQtlHufce/H2Bv+CQTV
 LMYX8/2Fy9350MZOFmduFsJ8/4L7/MjcjXAN/O/4gHIUGKkrRkLwhcaISk3kkbpTa0rL
 2zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552708; x=1739157508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buZLA0qUirjW027SjrYQXL+U33fLGsXttbSr8L05NfY=;
 b=Gf788noqWNNPmLYBG5RiUeCLveauC0rt0vAHk6p9OdyOUodUaFh2yP69AjU7MVa0On
 VZL52I+Wsn8RW8PKND3v13JMmRjLzvwLWmjLqDU+DMsxZqUsGZKYgcxiZLdn1ILYd/Xz
 SfUeiMVufkedJ8yhsvfNX1gAaqFm/+oHE9VbYbjY+w1cKdA2oNV+DZLvUIrd9xLwmv9H
 WXR1EUSrbkS91nv0U92s7l10DLNEwk8L+Orf8qWLSzOKagBmaXtg57MP9ChV4rVYUZ5E
 HNgfopz8/47SzTrTK08WiafdBCfAMAbho76uZxy7Itho79629PDDbtIzMcSficWXDOB/
 q0EQ==
X-Gm-Message-State: AOJu0YxUDmlcj2bTgA/ogniM4o0IVEIvzqn1khJ/sKOzM+Ih6FvnnIEg
 R2cbNNN8HbsIL0T69kMTTahF5JjiZtweUiM5aD/1CfW4E1qEcuYexga6NWNbOAWgzT+e1zLnneY
 N
X-Gm-Gg: ASbGncvBXqFwVET4ckpDYTAG0hFxNmfWYUlCDeWMwRsAgLJFQnsy7Eg6y/oG5S0t9sm
 o9RAnr2lhxWmSkrJ6kYGFkqWnA7FC0xVMSjqceWMqAdRc3PJU/j7dY/CjHPa6GATBXWyZJDrbVf
 DxXxNddzXgVKtmC5BOYKUcHfbKBMBTR3KuW8faONwrcI0fLD7tJjPsHhx8L+v8+IsDeoJHtK2Rd
 fu5rU/lkCPa8a1U8zXmD7y5En8ehbVtoUQ6EvoIIzQJaMGswnswPg1KL5Y6PU4yVrpPUWYk1OUA
 qY2z7YKfgvYI0kXUZa8bLOaB5S51f5JES59t9bmLDcNd7MU=
X-Google-Smtp-Source: AGHT+IGH205mypJ3s4gJ21UF+h+paxy8MOrVm10Pak8SvfGnhZEuQVM06uElNyBD2B7tvluwXi2EPQ==
X-Received: by 2002:a17:903:228d:b0:215:6e01:ad07 with SMTP id
 d9443c01a7336-21dd7c4e402mr280122615ad.6.1738552708128; 
 Sun, 02 Feb 2025 19:18:28 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 06/14] plugins: Link only when required in system mode
Date: Sun,  2 Feb 2025 19:18:13 -0800
Message-ID: <20250203031821.741477-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Provide out-of-line versions of some of the qemu/plugin.h API.
These will be referenced with --enable-plugin, but CONFIG_TCG
is disabled for a specific target.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/stubs.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 plugins/meson.build |  5 ++++-
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 plugins/stubs.c

diff --git a/plugins/stubs.c b/plugins/stubs.c
new file mode 100644
index 0000000000..57af8357e4
--- /dev/null
+++ b/plugins/stubs.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Stubs for when CONFIG_PLUGIN is enabled generally, but
+ * CONFIG_TCG_TARGET is disabled for a specific target.
+ * This will only be the case for 64-bit guests on 32-bit hosts
+ * when an alternate accelerator is enabled.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "qapi/error.h"
+
+
+void qemu_plugin_add_opts(void)
+{
+}
+
+void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head)
+{
+    error_report("plugin interface not enabled in this build");
+    exit(1);
+}
+
+int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
+{
+    return 0;
+}
+
+void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{
+}
+
+void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
+{
+}
+
+void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
+{
+}
+
+void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
+{
+}
+
+CPUPluginState *qemu_plugin_create_vcpu_state(void)
+{
+    /* Protected by tcg_enabled() */
+    g_assert_not_reached();
+}
diff --git a/plugins/meson.build b/plugins/meson.build
index d60be2a4d6..42442fe22b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -57,8 +57,11 @@ if host_os == 'windows'
     command: dlltool_cmd
   )
 endif
-specific_ss.add(files(
+
+specific_ss.add(when: 'CONFIG_TCG', if_true: files(
   'loader.c',
   'core.c',
   'api.c',
+), if_false: files(
+  'stubs.c'
 ))
-- 
2.43.0


