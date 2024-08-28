Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589AC5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCEX-0005XF-Iz; Wed, 28 Aug 2024 02:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjCEV-0005WC-12
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:32:44 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjCES-0005nH-5D
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 02:32:41 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo203838a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 23:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724826748; x=1725431548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6+Q831oNhFbMnhUfiTPapCUmkbhTxTMQ5+H4SSjAN8=;
 b=iPG1Sz5PzdahPQ/M+EpkoY5KC5DJv/NZxs9n6KwMWomn7xrb2cTgpx4ULwH7SqZuyc
 02kkE3UbyByPqRhEmgNhBC+F4WYvGIwyqb1+gG6mmoKE8MZnZ5ni9XDPoOMKkuFenvyZ
 zUNvWvchRe55e1WqKN3GYtgmtvWBV+fJwBAQJ8uN98i+jGOo/Yt5NJnVMg8fWNOu/IrH
 THqtfbjrI6cSmvLGdw0MIOKy6Y2x4+CamP0I0HbraaovXrNcI2u9ej48JsR1VT1uyJY+
 hDK9zR+5eOTrKpOdf6Mi6+FoEMLU+sOnFh9Y+Aquw62YHfXUFsFqVWiSiJwrTB+pFa3y
 j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724826748; x=1725431548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6+Q831oNhFbMnhUfiTPapCUmkbhTxTMQ5+H4SSjAN8=;
 b=tZB5noJ2iwhzW8ARqYgNqJFDC58EPDHtpcHbdbVhJiAtkrWBe6CwaS2CBvBQTlKfVo
 pmC/CnEMJaPAfbJXslZOEVGUDUWGsYmxAuMRIoIbz39JDrIkWkYESxCSxXOdasyU/QJo
 TogDsvBsKO3X8Avrx+7QJ34hpmUVXgirMI1Rop5QU0yDwYxFSkoYVY5Vdzgk6DpJ9hHQ
 yRBJ46OaFlGxHYXWuo6uLTAVY705+9HVG9OujXYPqmfNq8A6NRiYo7cyAQiIyf/LMa6O
 SE0QziuvaNOh/J419qzMO41iNMUf8NWwgEkBK/l6JaAw7S+2JiTBxJayXTP4Ybbu5+PU
 Lg0g==
X-Gm-Message-State: AOJu0YzVDR8UU9aU/JlNNt9uZLGb0R7zcZwY4cpHu0JvXyKEi/yndjmj
 NCw8W43ZMQatrFOTzp7B20mtWiJqXZHIePH7i034eYIoNbIRMFR1s1HzYXqC7z7UBA==
X-Google-Smtp-Source: AGHT+IGZ07wT7LRkYiYslVSvbipP8hYPJNnHRYUQ3Yez+UFFUs6YS199vFYYSqeLphs/u0tXmC7KzQ==
X-Received: by 2002:a17:90a:644c:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2d843d6f66dmr1803111a91.10.1724826747178; 
 Tue, 27 Aug 2024 23:32:27 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d84461411asm763970a91.24.2024.08.27.23.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 23:32:26 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 1/1] plugins: add API to read guest CPU memory from hwaddr
Date: Tue, 27 Aug 2024 23:32:24 -0700
Message-ID: <20240828063224.291503-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828063224.291503-1-rowanbhart@gmail.com>
References: <20240828063224.291503-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
 plugins/api.c                | 17 +++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..25f39c0960 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -868,6 +868,28 @@ QEMU_PLUGIN_API
 int qemu_plugin_read_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_read_cpu_memory_hwaddr() - read CPU memory from hwaddr
+ *
+ * @addr: A virtual address to read from
+ * @data: A byte array to store data into
+ * @len: The number of bytes to read, starting from @addr
+ *
+ * @len bytes of data is read starting at @addr and stored into @data. If @data
+ * is not large enough to hold @len bytes, it will be expanded to the necessary
+ * size, reallocating if necessary. @len must be greater than 0.
+ *
+ * This function does not ensure writes are flushed prior to reading, so
+ * callers should take care when calling this function in plugin callbacks to
+ * avoid attempting to read data which may not yet be written and should use
+ * the memory callback API instead.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
+                                          GByteArray *data, size_t len);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de..c87bed6641 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -527,6 +527,22 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
+                                        GByteArray *data, uint64_t len)
+{
+#ifndef CONFIG_USER_ONLY
+    if (len == 0) {
+        return false;
+    }
+
+    g_byte_array_set_size(data, len);
+    cpu_physical_memory_rw(addr, (void *)data->data, len, 0);
+    return true;
+#else
+    return false;
+#endif
+}
+
 int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
@@ -534,6 +550,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9f..5d9cfd71bb 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -20,6 +20,8 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_cpu_memory_hwaddr;
+  qemu_plugin_read_io_memory_hwaddr;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
-- 
2.46.0


