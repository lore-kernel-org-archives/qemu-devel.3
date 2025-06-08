Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8941AC61CE7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOOrl-000598-3w; Sun, 08 Jun 2025 18:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrf-00057W-JB
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:43 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrd-00030E-Eb
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:43 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so2481608a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749423100; x=1750027900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWW4a9PQ/O4Q7KJJXSiLz2UUrA0y3cIURdmeEfB6pjM=;
 b=HGj874SpM8otOYgj8+fc8D3/y8b1Hpb2ov79VHeOGYNZjRNxfiOnl1apf0ufMep7Vh
 6R0Ua3fL2C6A5T394fVfiB23RX5dkk/CGE9qf0mKSBipkvxvn7jtS6z9jGm9ilvUUFC/
 HoPd2wzhF0cE34t/v1uG9cx4oZv4lV0AHOuOOcrd3rrt0okNVDLPy44IHiHfJYXUWBJg
 BlVOksnSVidi5SJq80L6MXe+5b6YcuSDc8kHub2Q0sq4uAGdxeO7DsVPzRHtkrTygGOl
 NclvQrGOWh6+1YLseHlA2U4ERLNHXAE2ly+vbxGKZVrCSCepkr4MZKmJiC5m8i6lMb6p
 Plig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749423100; x=1750027900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWW4a9PQ/O4Q7KJJXSiLz2UUrA0y3cIURdmeEfB6pjM=;
 b=MGKJOD/Upw5Oa9nfwQZY6IfvEgt9/D9fqqn03XvF+xFZI3AfFI1X78P56Rs/l7bF/6
 i6TG4i9BiRc4OvAW8q2ZYyiYAwxAC2mjIFMQ6wFUWSIAeiihiJfkGd3dkjt8A1O6FKR1
 S4DJ/yxv8PmMRHQP3SdbWGFeJ4HJOMWjDhVBkenHTIxIKetiGaPb31DhrSRC01CB8sKB
 nvTbHOubxMBisFhill4MU3I9zwQuBM0UQof5bfy2QoEJUnEvDIo1oG5Cfw4h4HWhV3N1
 RYdIgnYzPyRjUAGMQTV4jypCELoIZXjXmr+ckytcZHp6E5/NyvKv9FF3xeIiwhSRUO3Y
 YZFw==
X-Gm-Message-State: AOJu0Ywo+GZdyuAa0+vWL2DAr22JgPDR0x+MlTxmV7f1+GCOwIaUpJRk
 4xyYj3ib23Q6MUzDYaB4Uwv+ZfaQ4eANYzElnBEqAkk470jWSsLMl+3JdxzWlH/3PHE=
X-Gm-Gg: ASbGncuN6LMvHQ1FccmNKKN6GxPjHO3xvwlGMfsQ0+rigB/xFFySVn/WLuYkNPVD20p
 8T5S0LgvgqQYNKSuIVKatsv9encd/6TS6XzYjZOKHFQQMzfWY5wqJUrFarhl8QcIdxYI7jjAcpT
 W3kJd7a5KbHp4CHyphA9RMz17UYavChZcry5i8btd2Mj+1TfLq5mssrAOKBARNmNwOwWpHk7aWM
 HhFrydJXWGMA1Xi79zPHqWcVq00mQTIzW8PqA05gRWj4yGra4yvGfqCfXsJLrOECoIMz5wmHku9
 ln9sC9TaZoD/v7yDrLDaOwsJjKj7+rpkD8MubPqExv41lmp4rgI=
X-Google-Smtp-Source: AGHT+IFLUhcDEUy2gN5Ehyf3L6ZeD9TFSdnrqgG4kmH1Br4ORl5lkAWUjkMUOQ3U1WiQaKVuk8yIcw==
X-Received: by 2002:a17:90b:4b4f:b0:311:c939:c848 with SMTP id
 98e67ed59e1d1-31346b44fafmr19620944a91.0.1749423099717; 
 Sun, 08 Jun 2025 15:51:39 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128012sm4395970a91.32.2025.06.08.15.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:51:39 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v8 2/9] plugins: Add register write API
Date: Sun,  8 Jun 2025 15:51:29 -0700
Message-ID: <20250608225136.3340370-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds a function to the plugins API to allow plugins to write
register contents. It also moves the qemu_plugin_read_register function
so all the register-related functions are grouped together in the file.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
 plugins/api.c              | 22 +++++++++++-----
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..cfe1692ecb 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -871,7 +871,8 @@ struct qemu_plugin_register;
 /**
  * typedef qemu_plugin_reg_descriptor - register descriptions
  *
- * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register or
+ *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
  */
@@ -893,6 +894,41 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_register() - read register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+/**
+ * qemu_plugin_write_register() - write register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register write access is
+ * explicitly requested via the QEMU_PLUGIN_CB_RW_REGS flag.
+ *
+ * The size of @buf must be at least the size of the requested register.
+ * Attempting to write a register with @buf smaller than the register size
+ * will result in a crash or other undesired behavior.
+ *
+ * Returns the number of bytes written. On failure returns 0.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_write_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
@@ -915,22 +951,6 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
-/**
- * qemu_plugin_read_register() - read register for current vCPU
- *
- * @handle: a @qemu_plugin_reg_handle handle
- * @buf: A GByteArray for the data owned by the plugin
- *
- * This function is only available in a context that register read access is
- * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
- *
- * Returns the size of the read register. The content of @buf is in target byte
- * order. On failure returns -1.
- */
-QEMU_PLUGIN_API
-int qemu_plugin_read_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
-
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3c9d4832e9..3a7add50d2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -433,6 +433,21 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+}
+
+int qemu_plugin_write_register(struct qemu_plugin_register *reg,
+                               GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -453,13 +468,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
-{
-    g_assert(current_cpu);
-
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
-}
-
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


