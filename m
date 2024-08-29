Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE3FC87FC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjiJU-0003HC-Nk; Thu, 29 Aug 2024 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjiJR-0003GM-Jj
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:47:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sjiJP-0000Pv-V5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:47:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71433096e89so713846b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724950074; x=1725554874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOSDxlfd71xtIaPGQdqxAYOreF3ZSs4J4TaR3CjaON4=;
 b=I2XjE3pQCsBebJg82xPI9FetqpivtkszoZwymNxYPKLX2S0p5k0qC4McqhWU+7SR+k
 0AOXuO0y+M1fEdJrVSHkCOryLCOlUPCGNeaspYA3U1ReTPXsmJmFoohba/a7uGGkNyoJ
 xXPSczGKdkeVE7dKS6Hku77iqkMGfhq/7DwgaEI08Ck6VATSkoSjNKYctUmlcrGZbDU2
 hZr9L0Jicmw4T0bIK2wlzTxLby+GeI8z8uk8ZZllqNN3xI7phQOX4LGe0Z+VaFotvQwc
 rIzzI18c/GdYQUJ+Y4qzeuibe+EbM/Rwog8O9df4yxJ2C2OtsaC88JSVSgh9CpBtQjsy
 LU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950074; x=1725554874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOSDxlfd71xtIaPGQdqxAYOreF3ZSs4J4TaR3CjaON4=;
 b=OBweGn7IFVvhFeyhLg0Wt61Rilw4NdPMuxWDKE8xqLPO0UVqpb255aeAc87SLNeuCc
 MhBgwodxuAjZ26UFHQFsjHGq0M48Zon9hwyBvbFe9+ZLiBWzDbN1iwjPfFOnlGDvJWQw
 e8xkprVbtAEnnsG6LX0rITV9MTpIfiZV1s4DmzdAEVODqqGEuGVgbtpPutjGPGQ5d1Na
 TvrpxFQABfvuHnvRoulxyCpryix4kt6eTf9DEJXhIzMI68uJlpQCavjy8gT2KOttqAIy
 CGodFZEFWYFmUEuPJTFSP118IRInjPHVez3tM836syLkCyCcWAD4yw46d1t41WbuP+V5
 0qTw==
X-Gm-Message-State: AOJu0YyAMzSP/U1t9twuLawayJ45CSU31WNTB6hOUYYMvzGvg+cCCVYZ
 cmwXPt8gW7uswl+AEwD3mFZMHqrLVw7TQN7YtpS0RHOtoHfBxyYGb21j5e1C26LYDQ==
X-Google-Smtp-Source: AGHT+IFhWSJhDtTIdX7OywnUZMU2OrThWQ4jnPMppfgVtMQeTYTY+d1pySfKk+OcVVwHRJhEY3Ri1g==
X-Received: by 2002:a05:6a20:c886:b0:1c0:f648:8574 with SMTP id
 adf61e73a8af0-1cce101d2a0mr2800086637.29.1724950074090; 
 Thu, 29 Aug 2024 09:47:54 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e55a4630sm1349061b3a.62.2024.08.29.09.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 09:47:53 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 1/1] plugins: add API to read guest CPU memory from hwaddr
Date: Thu, 29 Aug 2024 09:47:51 -0700
Message-ID: <20240829164751.9504-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829164751.9504-1-rowanbhart@gmail.com>
References: <20240829164751.9504-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
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
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 40 insertions(+)

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
index ca773d8d9f..616cae1e7f 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -20,6 +20,7 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_cpu_memory_hwaddr;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
-- 
2.46.0


