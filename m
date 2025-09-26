Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A626CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Lb-0008Do-8k; Fri, 26 Sep 2025 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LX-0008CK-NN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kw-000457-Kw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so11929345e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892685; x=1759497485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzN/TgoAIkonCXT/uVBGl8EaJyMt7CwI7sLpMGZB2gI=;
 b=nxpMkFHVnamkn44Fz7LIDSVqyo28u/2SRrFgnwI3HtaFxUjehLfKVOr0DbMUZT44VS
 4D6zb679aDtu3ntlU5TgNeQJ58GTHoOYMQvJi65aGJqedvjp67X4y2HXA719QGNn2PJe
 V54TzxUZ98HPlCBDZ+vDs2nRuCUJ02pwEqIl/sOi0MnzRrcvrys7qHp2fGREanO9r4DY
 2l682EwUEwLRsa3EQyyGDwmCQqI+JkbpSMGqIZbgLXsXhpFIZD9L/3hIUEBk7BnCgX2C
 UXwn2m8kuXM+gM76SPvltmwwOAsnVjYKDsyRkdry+CLWDZgQiit99wvs7pfUC6jJPHVX
 +I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892685; x=1759497485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzN/TgoAIkonCXT/uVBGl8EaJyMt7CwI7sLpMGZB2gI=;
 b=XnC1NZp01s0FnVPHXN/Y0pVDHOlSVmMlTX7S4/1s8x3GWSOecIwe1Mhxqh5pF4EMMy
 Y8StDQAtifap03xpWQyDPCicuIY6Vlv1BnqULpcDIJ2hQawtWN0RwW7BilrRY43QYOhu
 zeZE6XdLUqPHqRM9C1rY7T158c7WW7yQYw/cjKq4+V3So07QUo7fytBwkDDAPfSveMKO
 dY9pDw1daeMBz40IsET9J2sTuiDZK+7VkI52FEwoIW0ytlQ4sez+B5n3qkOBNnpSYOVx
 +lRCEKqzySM7Pq5kTlgTxmg72M3Yd5AHaY4R7TfxbVkCuR8sR5WgsL7lEiF7maZ8AZu3
 xnNw==
X-Gm-Message-State: AOJu0YzHdZzn3MFl28eJOt54rhtfpqdjBJpGuOgMFef1DQykyWmGs3JP
 ewLFz0Gw64ncGMuOQgXWb6uKbIUZTYs/WI9LaT7v3QwbjYOHTvyvZ1Y4CDNEE/Ux78w=
X-Gm-Gg: ASbGncvo3rlTunhR3wYp7LGhNXsn4qmEUR+9grUNNsipOkWFTHQ5FjpcFeV9syPFpdp
 HsUdQtCPGaRl1jXIpBL0y4iyPRGOinIzkhkKyTCgDZtctLTC0Orh0nMrnpDyWYpDS4LN4FGopxD
 LzyBfLwy7IwSjd4Tcu/xGFYF0SQAEBv9m8B1TKhP016PPi34nLHiYE6hkuEsGm4/5ghh6NHx4dO
 5om8jpvGkiRT5Mg8eWJCPeNJHqwlInEo+knuu1m0BEwZawzPGrLtmaNhYQQ0eqnUshyUkiVZ2qX
 pf1YSNLxkUcgYclalUujoN5NmF7/QCFGJARGXGxgQRf21RoQiKSPbJQ63jDL7iK7+qYLGYzhSee
 +O8CdhWKJSI9ALnUEok14iVg=
X-Google-Smtp-Source: AGHT+IE6ih/y01eCo5mD5dGThigSu6jb7OvGSIkPL/6XOGqCD5efUMCmsZw9pFChFQ7b1TTlj4Wclg==
X-Received: by 2002:a05:600c:8907:b0:46e:3732:88ec with SMTP id
 5b1f17b1804b1-46e37328daemr44843325e9.9.1758892684737; 
 Fri, 26 Sep 2025 06:18:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e330fbcc5sm37966075e9.4.2025.09.26.06.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D6945F926;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 16/24] contrib/plugins/uftrace: skeleton file
Date: Fri, 26 Sep 2025 14:17:35 +0100
Message-ID: <20250926131744.432185-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We define a scoreboard that will hold our data per cpu. As well, we
define a buffer per cpu that will be used to read registers and memories
in a thread-safe way.

For now, we just instrument all instructions with an empty callback.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-18-alex.bennee@linaro.org>

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
new file mode 100644
index 00000000000..4af0130b159
--- /dev/null
+++ b/contrib/plugins/uftrace.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Generates a trace compatible with uftrace (similar to uftrace record).
+ * https://github.com/namhyung/uftrace
+ *
+ * See docs/about/emulation.rst|Uftrace for details and examples.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <qemu-plugin.h>
+#include <glib.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct Cpu {
+    GByteArray *buf;
+} Cpu;
+
+static struct qemu_plugin_scoreboard *score;
+
+static void track_callstack(unsigned int cpu_index, void *udata)
+{
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+
+    for (size_t i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                               QEMU_PLUGIN_CB_R_REGS,
+                                               (void *) pc);
+    }
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->buf = g_byte_array_new();
+}
+
+static void vcpu_end(unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    g_byte_array_free(cpu->buf, true);
+    memset(cpu, 0, sizeof(Cpu));
+}
+
+static void at_exit(qemu_plugin_id_t id, void *data)
+{
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        vcpu_end(i);
+    }
+
+    qemu_plugin_scoreboard_free(score);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 1876bc78438..7eb3629c95d 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,5 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
+                   'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.3


