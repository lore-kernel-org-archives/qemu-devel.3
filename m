Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B7BECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1XB-0008W3-47; Tue, 10 Sep 2024 10:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X8-0008JR-Lg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:54 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X4-0006Za-Vz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:54 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d4979b843so376646766b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977269; x=1726582069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi/Ma4iZQyq9UPktSL9wJjpSik/SOJE+/JzqHwnFA1g=;
 b=tg5bZNSfbSotM8fdcSiSDEBIPwa9kIh/c4uK6+X6JAqcPspkcIeL8Z11gEI1B17hw1
 TtRRqM68v/KImy87Ff+Aqy+xF5DScQTP9bqT+n/0RMUB7exTrCc7/Tg1oZl5E3vSBTzG
 j0xMqS9RQU0yarV1uBM+JpXbZMk6W8YY9vHwE06ABT/hRHg90WZ8EJEGa3IwoonPIIMs
 Mpbc2a+lTbRLAujNvgGsSPPs+kp4C2cejDvJgQKgv9um/4z4ecgjjGwFRvDD0EGoUyGD
 /fKipiK4LdyNp+DVc6e3UTyh9Kyno2WvyMT4Tkj9PxmuU7TgY5ONiVBWo+l3Ki3lWObQ
 kQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977269; x=1726582069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fi/Ma4iZQyq9UPktSL9wJjpSik/SOJE+/JzqHwnFA1g=;
 b=ZKKErK+Gc02kO3xG/JLcY4pKJD+sO8yJQPMiWmcKu8jxtCLscxHfCNY4gJkFwjKh75
 TwnrDd4sb8ZphQ5slRAncVzifWeIonuVuWyZ8V6RfwCHlDr037VkNtgqDSjprUlC9K3p
 Cdh4EaHtQR5O7cNw/n+2tCaCNZAQqMKOHdclGb+6SNZZ9c46mOM5k6OrjXIm29THXCI7
 noUg8aDhD9yRVgVv/5keuRoJmspIsspW4fDUlLP+8Xd9cXp4fe3ukssbQtbp02s635Yu
 0Vo+O3Fi/8KTToPpi1RRlX3X5DD4zDTIqZ7Bz3P5bj290MoVOeMjcmSryZIx8tnQgxml
 ihPw==
X-Gm-Message-State: AOJu0Yxbzz0RquUSFEHtLRfOcHdwypKHP2YFmbRrCiB7JFbB6+Xm+UEw
 Mhsx7Mpv0LNIkCg6BienOEKWWXHxwhMRHARk0BYsRE9ZJwFtojIELbdY/by9shg=
X-Google-Smtp-Source: AGHT+IFtSnQC3W7zLRxuMIFpGHeZXAK0UXDTKpdYvut6xU65VLOm4bg437OH6NEMTMyIZQoIbEnnxw==
X-Received: by 2002:a17:906:4fc4:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a8ffaaa4ae0mr97954566b.11.1725977269050; 
 Tue, 10 Sep 2024 07:07:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cea3e1sm482519066b.167.2024.09.10.07.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 515645F9CC;
 Tue, 10 Sep 2024 15:07:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 26/26] plugins: add ability to register a GDB triggered
 callback
Date: Tue, 10 Sep 2024 15:07:33 +0100
Message-Id: <20240910140733.4007719-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
index 2015d6b409..3592e142f8 100644
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
index 42d735d5c8..ee71bd02c9 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -66,8 +66,7 @@ static gint addr_order(gconstpointer a, gconstpointer b)
     return na->region_address > nb->region_address ? 1 : -1;
 }
 
-
-static void plugin_exit(qemu_plugin_id_t id, void *p)
+static void plugin_report(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
@@ -81,6 +80,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     }
     qemu_plugin_outs(out->str);
 
+    g_mutex_lock(&lock);
 
     if (do_region_summary) {
         GList *counts = g_hash_table_get_values(regions);
@@ -105,6 +105,12 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
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
 
@@ -375,6 +381,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
2.39.2


