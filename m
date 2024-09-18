Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B4CDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tc-0005fO-Qj; Wed, 18 Sep 2024 17:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tY-0005OE-O2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:28 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tV-0001ed-Oe
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c4226a5af8so209365a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693644; x=1727298444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdv6FZr762UL3zV+OCpAf4ICN/LAqMV42uOsRe1XxtM=;
 b=TxnAfILG2FBaRPo9p4k+oalXWLOjoSZJbSlb8+qDXzj5Bwsj1QV7lB9HJmThrOeAnP
 /8cMBfJnAhloAmE7zmScn0Nb+Kd3erNC9WKHYpLDQGYZhMGTcig9pF4xv8zkWdS1KuBW
 4wEc5+Z1MxXQHv/MWM1BdCyRFD3i8KopS12KzbiXf+VwKu0wLyBoKXdENIgJfVvVATk2
 ElWiusP6wW811bmOMgvxp9X0r4AQJeaW/wLcshWDCMyblB1ruoaCWbZdCR8kGV0sLr3d
 G56o/KKNBGIYz72+N9p5eWHM+71teOOuBfZ3VJu3ZlCmvqHCG0uVoFyS8oiWECJTps6l
 p+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693644; x=1727298444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdv6FZr762UL3zV+OCpAf4ICN/LAqMV42uOsRe1XxtM=;
 b=EIZLhntAZAnGZMziuJMqImPKWCzDhBvJIaN7BuXV5FMpJgxLp8P1TD6atX8bxwGGHp
 ptNfWCVjbWZx2F5RJCETZ75dCmSuSP32QJeTERz2MefQW6WQMBOqP4DbNl2+TOJGxIpJ
 qguyOy+IUVZXDEHlLREO+N1xwcHol5CN/7fjoWKr0UtZrYm8JK+VPEllp3SsNSCp/iFk
 ogADYOoVTqYKYEFsmtDx7HjBmIUxVuQ9S4UoF/G+eeC+07phtJx9g6gZkLuHJbosQpC6
 jb9W9kGiZVpcdR/iIH+cz69bZwB5r/1kkQNnq91nfrezhMnHmJNsZAbmaBaNohnxKZ82
 jjyw==
X-Gm-Message-State: AOJu0YyWwILlVGkwuHFSC4valVsMsh1KXhV0jQ5vuwtrkpZ7ax0VwHKg
 VUz6REJKl+/RLP/gKzRQ02VINRSj83iFDWEk3prRIUdJsPwGM5YEE9X+xPTZWCY=
X-Google-Smtp-Source: AGHT+IG4z8nJLGHFYjOdGE3LACJ7h/onpdpDp/3txyg2TdPgeZ+JqVxjoZ2wUfqsRsnfhkog6O2KjA==
X-Received: by 2002:a05:6402:4022:b0:5a1:c496:2447 with SMTP id
 4fb4d7f45d1cf-5c413e36c60mr22603579a12.21.1726693644252; 
 Wed, 18 Sep 2024 14:07:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb532a8sm5376035a12.28.2024.09.18.14.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCDBD5FC7F;
 Wed, 18 Sep 2024 22:07:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 16/18] plugins: add plugin API to read guest memory
Date: Wed, 18 Sep 2024 22:07:10 +0100
Message-Id: <20240918210712.2336854-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240827215329.248434-2-rowanbhart@gmail.com>
[AJB: tweaked cpu_memory_rw_debug call]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-17-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 649ce89815..622c9a0232 100644
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
@@ -884,6 +892,28 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
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
+bool qemu_plugin_read_memory_vaddr(uint64_t addr,
+                                   GByteArray *data, size_t len);
+
 /**
  * qemu_plugin_read_register() - read register for current vCPU
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3316d4a04d..24ea64e2de 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -560,6 +560,26 @@ GArray *qemu_plugin_get_registers(void)
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
+                                     data->len, false);
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
index eed9d8abd9..032661f9ea 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -21,6 +21,7 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_memory_vaddr;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
-- 
2.39.5


