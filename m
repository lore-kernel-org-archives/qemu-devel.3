Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1ABC5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1silnK-0003qp-W7; Mon, 26 Aug 2024 22:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1silnJ-0003ln-NQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:18:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1silnH-000413-3s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 22:18:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2025031eb60so42964235ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724725129; x=1725329929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP79299gaSIQsDS0gNQOalNS+4lGfNRIbC9lynbHPgw=;
 b=mMog612Stjbo8OoOtY72tPmAUNKQT7w/z0ba+G+WAivzH+dzM3Lr34LOM9qnonvPdd
 nZRtXJf/zBJAypO+DLSpni0ssKJRaqceKYJoKyq6P31YVymGhAHXeNTLp4DveKci6OHe
 Z09RGcBiB+7Ko8Y2J5AFRv/pTAbDqmgC18LCIh8KoZDjLHqxNw+Ke6Ghnup//Wx0DMIB
 /gfqT7Y6UuMToJCD2D9kU1tLwRpwu1YCwr7REI2ZBeERFIJklOiMhixkO1gAbSmupVwB
 GQUB2NPd0zBULDPCUo/dgv8wl5bU6jcsIZuRrEpJRQAC0w21WcsS5v5Imua2ICrHt+O3
 Gveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724725129; x=1725329929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kP79299gaSIQsDS0gNQOalNS+4lGfNRIbC9lynbHPgw=;
 b=OvUm+i2C3dpK+tBOXO3E0RRHakbmw6DzZhY0Iq3KxRDpapPah/Rt8NTwCTAK6l08AB
 RQafDYJ+/QhnN2hJxGcchV3KP2GYR32XJrcChww+L9oCUUpEzHhckybpiF2Fimw/8tie
 guh+xRZCmPkQqTi8S9BRaAYLlCVCKDlNMr7XTVgyVVX7MiyDs1vaCrkcXYL3XJAZRxPF
 iCiio8K6Rj92GixnVQN8qbJsMolD5M4LXHBUTnDlLe3vO21mPL/jJJ8ZWekrWnObd1zm
 2ReN8mP+jNz7jT04UY1kd3cbTwSjgDZFMAqC9iMvxkWr/+fuOFOqT8ns1bbsSe//z7fH
 HMnA==
X-Gm-Message-State: AOJu0YxJIDle+QsClt6rDiVSdUC2lfEoebmCQGTkE/0CPTJmwUnn/8Px
 I2Omhq0LzdEbV9Lu0Y9W8MGxhG7CSEuqQZgh89HtmAzpeo9XzBsrtup6Y1pDN2eNNA==
X-Google-Smtp-Source: AGHT+IHX1FIFKeANqLnyKleJOqCHDVJHCxl0GJvGchS6fZHK3pcuBJt4fKSOTo/sCeUNH5rusVw/1Q==
X-Received: by 2002:a17:903:188:b0:1fc:86cc:4254 with SMTP id
 d9443c01a7336-2039e4b37c1mr125074345ad.33.1724725129272; 
 Mon, 26 Aug 2024 19:18:49 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038557e759sm73241305ad.67.2024.08.26.19.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 19:18:48 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 1/2] plugins: add plugin API to read guest memory
Date: Mon, 26 Aug 2024 19:18:45 -0700
Message-ID: <20240827021847.218390-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827021847.218390-1-rowanbhart@gmail.com>
References: <20240827021847.218390-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x636.google.com
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
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
 plugins/api.c                | 20 ++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..10f9db8cdc 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -57,11 +57,19 @@ typedef uint64_t qemu_plugin_id_t;
  * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
  *   Those functions are replaced by *_per_vcpu variants, which guarantee
  *   thread-safety for operations.
+ *
+ * version 3:
+ * - modified arguments and return value of qemu_plugin_insn_data to copy
+ *   the data into a user-provided buffer instead of returning a pointer
+ *   to the data.
+ *
+ * version 4:
+ * - added qemu_plugin_read_memory_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 3
+#define QEMU_PLUGIN_VERSION 4
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -852,6 +860,28 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
+ *
+ * @addr: A virtual address to read from
+ * @data: A byte array to store data into
+ * @len: The number of bytes to read, starting from @addr
+
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
+bool qemu_plugin_read_memory_vaddr(uint64_t addr,
+                                          GByteArray *data, size_t len);
+
 /**
  * qemu_plugin_read_register() - read register for current vCPU
  *
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de..cb7d818918 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -527,6 +527,26 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
+{
+    g_assert(current_cpu);
+
+    if (len == 0) {
+        return false;
+    }
+
+    g_byte_array_set_size(data, len);
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                data->len, 0);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9f..3ad479a924 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -20,6 +20,7 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_memory_vaddr;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
-- 
2.46.0


