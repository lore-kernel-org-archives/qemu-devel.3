Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BC9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzR-0002lu-2h; Wed, 21 May 2025 05:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzI-0002ih-BB
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfz8-0001bY-G2
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso6578954b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820616; x=1748425416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNcrawxKqZ/qeUEHaOl7zBZ2/y+VobVUnCpMTs79Y8s=;
 b=RlXnwylqa83ex07lZoPMBNceu7vJmjS7/21zSrwzLiHanVSl9I9ADZk36II6Bgnnrm
 SRNE4eBUfx+wyHSoVgAz+DLsEuon8VVUqJUmqEkTQ04/RtlVoWHCL7zyQ8T/WItE6P1s
 pzbPJ006F/5uO4pJmLYSbGUf8sJl56k1GOYLpx1dsp5JVHME4MB+n8i0+/8NruzVg4t3
 S+ZLCKW+yY2EBywePmjEO4p8axbHezXr/XYgXzY057rVBlzIl3BYQW/SksCU64Itg66C
 XOR5KA+fC2Wk6DSaFsfbZMCakjs7xokHe/nJq1pEHS5zfp1vHf2q0WUf83gyAOB0BSkf
 9H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820616; x=1748425416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNcrawxKqZ/qeUEHaOl7zBZ2/y+VobVUnCpMTs79Y8s=;
 b=qWpW+YLj2l9lPxn4xViCFH2C1zcAVU/pcn2mdveU/RHE90CamD3F9nHRlXi4ncxSUN
 k4ntzj+cvAm6i20Cmb1uwmXjizjLMYkFbuQNMdmSA6/d8Jx4Wuh8iulwxFy5eFZiCuWi
 s898dkhSlU0fuT1fOyz4ixJyiLnzIgZ6te0lwfEq7iSyn80dj9tChEtiLY8LpOGPKQfy
 /DpruENE7efcqYvyEpGZUjJ0O1zlDO6B6wDsye7f+P2h2W6VKXH6YrnG0SoOwX/PLPim
 Ha9FsK72+BZl3YGHf7v4f3sxWNctWNENXrHwuHztWLfesocR0dJpYkZJjRWcbSIGxJNT
 NbCg==
X-Gm-Message-State: AOJu0YyxAPoQAI+d7WlFp4la2pqpfJcbEfZpv0KJt8l9Gv9e3/KK4hPb
 GYGWL7OXqsPqyKYm8MpKySV68B9hXJwuc7S/yRnNjHTR+C0E1uQKF5iADBCR1cvh2Hw=
X-Gm-Gg: ASbGncsMveN3cOhQ15QJMsUh5isfeGVj0NUCTlRXaU+A5Ec7MgGrMObdZKX1fC14x3l
 2JIsq9o98D1IwF4p0T4NxtRFFFMsyMEPcf59jrmQocA9aF9/uWXaL//Hark6ico4fKdVsY5VM6H
 Io68MPEnPbfBcXbapRkmV3slRo9TdK8TJ8zxlQut8qcexksPjSh92O4QQwwea++4M/EDHmhyTHo
 rpgrMuP83cFJdlZuGv77NjwLKlLJIPTidyMGtoUVm00lVX/4qrm1s58Ii2P/ZR4/+f9B6uUKJJo
 T8/rJL5Y8yU9QgcZg7924dhrsJb3TgFg+heh1eNgjjzC/qEtHZg=
X-Google-Smtp-Source: AGHT+IG0IvZXOWUDfesBRJoVVMzo8UkVpW0qkPC7zeVuUDKCyoBV8fik23Qw8M5qncEP3SsznqSbPg==
X-Received: by 2002:a05:6a20:518a:b0:216:5f68:427b with SMTP id
 adf61e73a8af0-2165f68442cmr21441618637.33.1747820616342; 
 Wed, 21 May 2025 02:43:36 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:36 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v3 3/8] Add address space API
Date: Wed, 21 May 2025 02:43:27 -0700
Message-ID: <20250521094333.4075796-4-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521094333.4075796-1-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/plugin.h      |  6 +++
 include/qemu/qemu-plugin.h | 45 ++++++++++++++++++++++
 plugins/api.c              | 79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..38439a37fa 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -139,6 +139,12 @@ struct qemu_plugin_tb {
     GArray *cbs;
 };
 
+/* Internal context for address space information */
+struct qemu_plugin_address_space_info {
+    CPUState *cpu;
+    GPtrArray *names;
+};
+
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 68c8632fd7..1380f7d441 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -926,6 +926,51 @@ QEMU_PLUGIN_API
 int qemu_plugin_write_register(struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/** struct qemu_plugin_address_space_info - Opaque handle for space info */
+struct qemu_plugin_address_space_info;
+
+/**
+ * qemu_plugin_get_current_vcpu_address_spaces() - get a list of address spaces
+ * for the current vCPU
+ *
+ * This function should be called in vCPU context, i.e. from a vCPU, translation
+ * block, or operation callback.
+ *
+ * This function is only valid for softmmu targets.
+ *
+ * Returns an opaque qemu_plugin_address_space* handle that is only valid for
+ * the duration of the callback. The caller is not responsible for freeing the
+ * result.
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_address_space_info*
+qemu_plugin_get_current_vcpu_address_spaces(void);
+
+/**
+ * qemu_plugin_n_address_spaces() - get the number of address spaces
+ *
+ * @info: opaque handle to address space information
+ *
+ * Returns the number of address spaces, or -1 if the handle is invalid.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_n_address_spaces(struct qemu_plugin_address_space_info *info);
+
+/**
+ * qemu_plugin_address_space_name() - get the name of an address space
+ *
+ * @info: opaque handle to address space information
+ * @idx: index of the address space
+ *
+ * Returns the name of the address space, or NULL if the handle is invalid. The
+ * caller is responsible for freeing the result.
+ *
+ */
+QEMU_PLUGIN_API
+const char*
+qemu_plugin_address_space_name(struct qemu_plugin_address_space_info *info,
+                               unsigned int idx);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
diff --git a/plugins/api.c b/plugins/api.c
index 79b2dc20b8..d1cc6ff86e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,6 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
+#include "system/memory.h"
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
@@ -452,6 +453,84 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
+#ifdef CONFIG_SOFTMMU
+static __thread struct qemu_plugin_address_space_info address_space_info = {
+    NULL, NULL
+};
+static void free_g_string_and_data(gpointer data)
+{
+    g_string_free(data, true);
+}
+#endif
+
+struct qemu_plugin_address_space_info*
+qemu_plugin_get_current_vcpu_address_spaces(void)
+{
+#ifdef CONFIG_SOFTMMU
+    CPUState *cpu = current_cpu;
+
+    if (address_space_info.names == NULL) {
+        address_space_info.cpu = NULL;
+        address_space_info.names = g_ptr_array_new();
+        g_ptr_array_set_free_func(address_space_info.names,
+                                  free_g_string_and_data);
+    }
+
+    g_ptr_array_set_size(address_space_info.names, 0);
+
+    for (size_t i = 0; i < cpu->cpu_ases_count; i++) {
+        AddressSpace *as = cpu_get_address_space(cpu, i);
+
+        if (as == NULL || as->name == NULL) {
+            return NULL;
+        }
+
+        g_ptr_array_add(address_space_info.names,
+                        g_string_new(as->name));
+    }
+
+    address_space_info.cpu = cpu;
+
+    return &address_space_info;
+#else
+    return NULL;
+#endif
+}
+
+int qemu_plugin_n_address_spaces(struct qemu_plugin_address_space_info *info)
+{
+#ifdef CONFIG_SOFTMMU
+    if (info->cpu != current_cpu) {
+        address_space_info.cpu = NULL;
+        g_ptr_array_set_size(address_space_info.names, 0);
+        return -1;
+    }
+
+    return info->names->len;
+#else
+    return -1;
+#endif
+}
+
+const char *
+qemu_plugin_address_space_name(struct qemu_plugin_address_space_info *info,
+                               unsigned int idx)
+{
+#ifdef CONFIG_SOFTMMU
+    if (info->cpu != current_cpu) {
+        address_space_info.cpu = NULL;
+        g_ptr_array_set_size(address_space_info.names, 0);
+        return NULL;
+    }
+
+    if (idx < info->names->len) {
+        GString *name = g_ptr_array_index(info->names, idx);
+        return g_strdup(name->str);
+    }
+#endif
+    return NULL;
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
-- 
2.49.0


