Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE30C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 21:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj489-0002u8-2V; Tue, 27 Aug 2024 17:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj487-0002qx-1U
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj485-0000uU-CE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d3c0d587e4so4274270a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724795612; x=1725400412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=witZCXcE7KUJfJbgxXp83/OpY1XcCKoZDa2zRQ4MDjQ=;
 b=MsDTq9cBwxv0WDWHGTauKGUsep/srzJMkpKVo6g8PjHbSq6BT4QzkxWT1pzSXBiZE4
 DtNpW3prKURfwhhmjFOh7jPVxmLE4jaEvtecrbkUniCLnoLG/DR1yzQLoUyqsf3EgCC7
 SF+aEWhMBJm9P3FeAOoHgJgcC45tdgiJ0zauuTFfcaxVJTE4SiiyUyP0Q23E5amjGdLw
 O3PXhT/yWo3Zs9oDSOySurgJyeWPM7mqSPgOd8HXN1E37h9mMosuQjQn8osuoVWGHBY2
 9w9ocw7mXWL3xKaAuaBZB+pfE3Nql4dkocO3xWIIXPYtY2tmtYQJCTOnN8rYYohFY//e
 9sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724795612; x=1725400412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=witZCXcE7KUJfJbgxXp83/OpY1XcCKoZDa2zRQ4MDjQ=;
 b=ZLfd0aOjOarxfYxKv4HnXKqAqx2THaswA/o34MRReVLULNVBxe8HwsEh67YZDaP9f+
 33ZGruY/hzvwwxAB+hZa+LL5VlfrYsDCgZqL05FGySfL1vfRUdgp9sWkIlnceGn7l+r9
 o4sA/vewPotykC1I4vXJyzcRsLF4/b9vLHwCneCYUkEgU1hu+wsRE1NF9jH3nPnVEC7H
 9LjbJSBbzzxpW3yWYjYN9TMtLIwzLArgRFhPpm8WAPTZUWsAknX2PE9pCBXinOgLi4qM
 yQ4EeEnZLRMQWSTLc4gyuUVZ9kobGJUb2w9QoCt8TCj+0hNkdi1yCdS4DCdiClLRfNrp
 vaLg==
X-Gm-Message-State: AOJu0YyO1nR3dfvFs7HNriLU05rZ7bz/EBJ6Yh4jR92fdsIBFwAzTqfl
 Q6SXpBe8M2S7s2J9CAl60X11vlrw/jsyBOmTctf/1Q0stOtod7J0JN4NtLRDrdFMtg==
X-Google-Smtp-Source: AGHT+IH5xAmuMekrohjpciXkJSaV1vThH65JzTaBSEZGwm6NvkM2F9Cwh7Xy8MX2ZQaghPnr/A6UCQ==
X-Received: by 2002:a17:90b:4ac3:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2d8441dad61mr73485a91.41.1724795611616; 
 Tue, 27 Aug 2024 14:53:31 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613b1f0d5sm12671445a91.55.2024.08.27.14.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 14:53:31 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v3 1/2] plugins: add plugin API to read guest memory
Date: Tue, 27 Aug 2024 14:53:28 -0700
Message-ID: <20240827215329.248434-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827215329.248434-1-rowanbhart@gmail.com>
References: <20240827215329.248434-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102b.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
 plugins/api.c                | 20 ++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..e4068f823b 100644
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


