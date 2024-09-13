Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9031EFC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spAC1-0002Ey-Rs; Fri, 13 Sep 2024 13:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spABz-00027V-O2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:34:47 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spABw-0006gX-SU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:34:47 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f759688444so22073981fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248881; x=1726853681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nn1a9HFZduZ/RNVuj0xIuaKX/DLxfqqaJjOeCmylyL8=;
 b=tTkfcZUmCNKGLyh2V5MO06VGEDgPobtTDAXChTRIO1YK2Jnlk0vCvsJMrb8eOglXR/
 Te4+LCHY8KFcQJBFLTty+HSKg7c3IHQryuTpmtPJuZKbhOvn5iTQF6v9+6wwsQfpB6Ut
 KDR9rLMbdSFTZFoQ2N52FaXmKPkGtKEbfYiiqZAtbq3zLMwnmn+qjBszUCYUf5FhSdxs
 +nk/H/l0Q+yGNBoWLaSYdOnoaJkFUHacWjV5E3RuvxZMusbKsYc5LaoJZVU6xkK0DNX8
 UazG1iDKJzVq4BEPTb+fnhWc+yqkgkpug/NCvCbIMdgY5EnHPf3pqRHYxyg65z3PtFif
 ncHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248881; x=1726853681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nn1a9HFZduZ/RNVuj0xIuaKX/DLxfqqaJjOeCmylyL8=;
 b=iJl9rWvYOxtHay1cwdJwzrOdaYaMQEwXGZ3/6Xaq8dF8rkdRV/b4P6O4VabjQwd50E
 vh5oXZFxHkGWv8+X3tKXa7cW2gmQBrYhm29nnItRthrjWxi+W90uFDzPqpZLaQ1naNar
 43RgpJSxH+TdkmehRC5po6GwpmM012pyPazgD4QBHm+hVQigYievhPmFL415iS3YSpTr
 lRzs0pXdByDOTUHKYAnDRNUssURV2XMRPCLhjiFHfzZLQgKYmBxv8l1OPTjIsBMe9t3S
 iQ+trBN5SJIEtFp4WM5nihgZKxvu8OVzh4A5bOdCxaY8+uzpEfwMrw5lAEtZd9lbDe81
 Lp5Q==
X-Gm-Message-State: AOJu0Yyrq5YeKbVSGU4Q66ro5LN2X7JnfvA7ZtOFJKVyI0NXZvdzfDwY
 H9RG+N9KafaTy+9kAQOU3cfa3aY8XjKfrCUJl4mfMUwnfKaAJWTcK4aT9oKvtF8=
X-Google-Smtp-Source: AGHT+IHuWZ6XpT3slItY2QaJSeT8M0ib7RZhha7UJ5Q3gkR/BAtI1rcyaXOFNa/bpRaoNVZCipj/CA==
X-Received: by 2002:a05:651c:2111:b0:2f6:6202:bfd5 with SMTP id
 38308e7fff4ca-2f787f44772mr48763821fa.34.1726248881031; 
 Fri, 13 Sep 2024 10:34:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c421bf637esm804991a12.3.2024.09.13.10.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:34:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1EDD5F897;
 Fri, 13 Sep 2024 18:26:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 16/17] plugins: add plugin API to read guest memory
Date: Fri, 13 Sep 2024 18:26:54 +0100
Message-Id: <20240913172655.173873-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240827215329.248434-2-rowanbhart@gmail.com>
[AJB: tweaked cpu_memory_rw_debug call]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
vAJB:
  - explicit bool for cpu_memory_rw_debug
---
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
 plugins/api.c                | 20 ++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 649ce89815..2015d6b409 100644
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
+                                          GByteArray *data, size_t len);
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
2.39.2


