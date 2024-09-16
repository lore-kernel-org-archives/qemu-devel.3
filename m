Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA8C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 09:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7dg-0000FI-G2; Mon, 16 Sep 2024 05:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7dd-0008Ux-C9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:03:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7dZ-0006TQ-Lj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:03:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so35639925e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726477392; x=1727082192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B68/UAkmHFNWKQn2wg+UZm8jcMQdmSX3ck9PnfQqapo=;
 b=rB5kSzXmy9JZki2OnJ3GYrKxYVu6q9HCUFCDDuNO3+rmXv4D4jvjXaYxZ3SOLr2jbO
 M257Dr5+p7gkqBe/LfRlTrt7NHNwY/WNXgmE5RcFNmWJvdRhgGG1MxTapUrXpZzknes8
 naWbqn/lrpHbeATpF9+0eGSCDybS1XDEZmhu2uV+mxkQmgBtO7WPVoMpaZTFgsSFyh6W
 4rNPEXsJq1jXwMDYeTe+EZH9obq4Z+qd5g31rG/TyL1TXt6rHx0kkpKfoDoQqO2u299/
 uKzypbeh2s5ipVjuhRa2CFxVf2cJnL06siprJM8t3oD7dOttDnW9jYop4WCCif5YvmiO
 +LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726477392; x=1727082192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B68/UAkmHFNWKQn2wg+UZm8jcMQdmSX3ck9PnfQqapo=;
 b=Yrb24disO/37Zx9HaiytpQijYcpWXtgyRxw7dXjJlX18SipLDtw3I3G2I8DNBnBGr3
 mJoLHTLFgSgbETHJuWfz4scxjOPUqFYFRRsgMpDs3sojt9ABSMQaFMJbO3sP9cSpJjAn
 dPYxlHa8tb/XcwkWxtKCDRYxX8m2/ZDRQF7qEkuGPZpQlaEGyqcgBZFxMTaAq/+n8KPc
 X/+h2zjhUmsRKOQlFmE9OPFl8FaE/gewvqvRY+sLa/RNBqAozRzkOEVpjiJ1LpXZNs8A
 CEtmUyNp1zfEp8dD8C45XVVqOPX8WfLaIFBpaBC2PXP5fnC/eWw6k4Aqo6yV9Bo6AtkK
 WW7A==
X-Gm-Message-State: AOJu0Yy+m2cVrEBtWGPawW1ajWWbKE5XrdA7ZRYLBEyJEZLkuFmoOJJz
 3y/PTyyOvh6IA0/bvtZblYyQplBVEXU6XWvwaYmcSn8ZpJGbWOv/5SIRA8X7QX4=
X-Google-Smtp-Source: AGHT+IFpmSQCy7cM22BZM0ggb3oZsZrzR7HeGFrmduUy88rI6FzJ/fEMUpYb3IWB99wrfa1aG4c0PA==
X-Received: by 2002:a05:600c:5104:b0:42c:b2fa:1c0a with SMTP id
 5b1f17b1804b1-42cdb566287mr110441505e9.23.1726477391840; 
 Mon, 16 Sep 2024 02:03:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e846asm6625976f8f.41.2024.09.16.02.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:03:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D70C75FCD7;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 16/18] plugins: add plugin API to read guest memory
Date: Mon, 16 Sep 2024 09:53:58 +0100
Message-Id: <20240916085400.1046925-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

---
vAJB:
  - explicit bool for cpu_memory_rw_debug
v2
  - fix alignment
---
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
 plugins/api.c                | 20 ++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

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


