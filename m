Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD2D1CDDE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZl-0002n7-CY; Tue, 22 Oct 2024 06:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ4-0001qk-PK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:38 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ2-000260-Mc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:38 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so710440466b.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594595; x=1730199395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncBC08IoBkP10ef5QDpG5SV+FPj/pwrW84Mb8BGJC6M=;
 b=ANmHrUZhQRwGwzgFbQBxlEKpB/wrKEFGuckawy2mwC4MfaX8BW92MyY/mCGboH7M1B
 DriFw2NMOSgdbRhJoZXPoE/4jXmKLmKhIRlAKGryOZMWwz6gDyfnzC6bdWWeLCq1AFB/
 uoJRNtCs4BSks536GKGBtWQnq3dJXbDcRGWXByqwi7pFjnmzBhaqOoovUAwkTl2s5JcW
 U6vBzPHkZoTUenTm+FuTU2hcTyHu/RYKX5FfwzbfUU87azXxBG6aFCUh6WamRVjzuXgF
 5nA02UA3BOIR9qxyp/vZytKG+vQNI2HXMxjVfYGcN6nTizwFekGSnJz0XGkFm+oBPqKX
 39eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594595; x=1730199395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncBC08IoBkP10ef5QDpG5SV+FPj/pwrW84Mb8BGJC6M=;
 b=PVcCtbZqNfp3u3Nw6alqBE7FAYXiQxJUJynN1PU+X/wokTJuoqVYptjPA5af9lKDxb
 weWvhkv/D17g96gvmbbh5RnCS5MRJyuSQKNGHfxUopJCyzB12Lxd3ErRaRB64ppU8Nif
 wPas0WFrJQmVvfqc7smC4Z+y6EbYtU9AtwkV8/0DXAz3oXeB1UhLc0q4bzoaaIghA9Qv
 UA0U/sAvopsA7bqx6KcdisuXoKvfeBForEpNO2aewE3mr/5HChZsjKETeFTAMyKAhQAK
 Uc3MIYVkiZJ3n3+RtOTUgNSCcuicepwPq3wnvPXGZzxbD4LcIOnhvSlIeDRKBZgTLb3R
 beuA==
X-Gm-Message-State: AOJu0Yx3qlSVxerQXM5gtTTJy29qXKAtBh5AQuZftKK0ArZ0DJxthUDk
 tGoAmTUyq63Ekymv43Ke61bwxygkCeCRrW90RBbisHrXTYp48w7v4R7TYiAb4ZU=
X-Google-Smtp-Source: AGHT+IHBLyW0mHPJl2GnPpKKp3UGFXSgagg2mGtBM8c3JT2vxTQvXvz98RyNa3XJTjQV1wo5eVGMhQ==
X-Received: by 2002:a17:906:c10b:b0:a9a:6bd:95dc with SMTP id
 a640c23a62f3a-a9aad3715ccmr189373366b.46.1729594594783; 
 Tue, 22 Oct 2024 03:56:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91559951sm321731866b.106.2024.10.22.03.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2565B5FC34;
 Tue, 22 Oct 2024 11:56:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 17/20] plugins: add ability to register a GDB triggered
 callback
Date: Tue, 22 Oct 2024 11:56:11 +0100
Message-Id: <20241022105614.839199-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now gdbstub has gained the ability to extend its command tables we can
allow it to trigger plugin callbacks. This is probably most useful for
QEMU developers debugging plugins themselves but might be useful for
other stuff.

Trigger the callback by sending:

  maintenance packet Qqemu.plugin_cb

I've extended the memory plugin to report on the packet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin-event.h  |  1 +
 include/qemu/qemu-plugin.h   | 16 ++++++++++++++++
 plugins/plugin.h             |  9 +++++++++
 plugins/api.c                | 18 ++++++++++++++++++
 plugins/core.c               | 37 ++++++++++++++++++++++++++++++++++++
 tests/tcg/plugins/mem.c      | 11 +++++++++--
 plugins/qemu-plugins.symbols |  1 +
 7 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..d9aa56cf4f 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_GDBSTUB,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a0232..99c3b365aa 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -802,6 +802,22 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
+
+/**
+ * qemu_plugin_register_gdb_cb() - register a gdb callback
+ * @id: plugin ID
+ * @cb: callback
+ * @userdata: user data for callback
+ *
+ * When using the gdbstub to debug a guest you can send a command that
+ * will trigger the callback. This is useful if you want the plugin to
+ * print out collected state at particular points when debugging a
+ * program.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_gdb_cb(qemu_plugin_id_t id,
+                                 qemu_plugin_udata_cb_t cb, void *userdata);
+
 /* returns how many vcpus were started at this point */
 int qemu_plugin_num_vcpus(void);
 
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 30e2299a54..f37667c9fb 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -118,4 +118,13 @@ struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
 
 void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
 
+/**
+ * plugin_register_gdbstub_commands - register gdbstub commands
+ *
+ * This should only be called once to register gdbstub commands so we
+ * can trigger callbacks if needed.
+ */
+void plugin_register_gdbstub_commands(void);
+
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de..62141616f4 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -681,3 +681,21 @@ void qemu_plugin_update_ns(const void *handle, int64_t new_time)
     }
 #endif
 }
+
+/*
+ * gdbstub hooks
+ */
+
+static bool gdbstub_callbacks;
+
+void qemu_plugin_register_gdb_cb(qemu_plugin_id_t id,
+                                 qemu_plugin_udata_cb_t cb,
+                                 void *udata)
+{
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_GDBSTUB, cb, udata);
+
+    if (!gdbstub_callbacks) {
+        plugin_register_gdbstub_commands();
+        gdbstub_callbacks = true;
+    }
+}
diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e68..e7fce08799 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -23,6 +23,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
 #include "hw/core/cpu.h"
+#include "gdbstub/commands.h"
 
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
@@ -147,6 +148,7 @@ static void plugin_cb__udata(enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_ATEXIT:
+    case QEMU_PLUGIN_EV_GDBSTUB:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_udata_cb_t func = cb->f.udata;
 
@@ -768,3 +770,38 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
     g_array_free(score->data, TRUE);
     g_free(score);
 }
+
+/*
+ * gdbstub integration
+ */
+
+static void handle_plugin_cb(GArray *params, void *user_ctx)
+{
+    plugin_cb__udata(QEMU_PLUGIN_EV_GDBSTUB);
+    gdb_put_packet("OK");
+}
+
+enum Command {
+    PluginCallback,
+    NUM_GDB_CMDS
+};
+
+static const GdbCmdParseEntry cmd_handler_table[NUM_GDB_CMDS] = {
+    [PluginCallback] = {
+        .handler = handle_plugin_cb,
+        .cmd_startswith = true,
+        .cmd = "qemu.plugin_cb",
+        .schema = "s?",
+    },
+};
+
+void plugin_register_gdbstub_commands(void)
+{
+    g_autoptr(GPtrArray) set_table = g_ptr_array_new();
+
+    for (int i = 0; i < NUM_GDB_CMDS; i++) {
+        g_ptr_array_add(set_table, (gpointer) &cmd_handler_table[PluginCallback]);
+    }
+
+    gdb_extend_set_table(set_table);
+}
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..d416d92fc2 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -75,8 +75,7 @@ static gint addr_order(gconstpointer a, gconstpointer b)
     return na->region_address > nb->region_address ? 1 : -1;
 }
 
-
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_report(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
@@ -90,6 +89,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     }
     qemu_plugin_outs(out->str);
 
+    g_mutex_lock(&lock);
 
     if (do_region_summary) {
         GList *counts = g_hash_table_get_values(regions);
@@ -114,6 +114,12 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         qemu_plugin_outs(out->str);
     }
 
+    g_mutex_unlock(&lock);
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    plugin_report(id, p);
     qemu_plugin_scoreboard_free(counts);
 }
 
@@ -400,6 +406,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         counts, CPUCount, mem_count);
     io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_gdb_cb(id, plugin_report, NULL);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 032661f9ea..d272e8e0f3 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -25,6 +25,7 @@
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
+  qemu_plugin_register_gdb_cb;
   qemu_plugin_register_vcpu_exit_cb;
   qemu_plugin_register_vcpu_idle_cb;
   qemu_plugin_register_vcpu_init_cb;
-- 
2.39.5


