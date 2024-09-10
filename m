Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35220EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1cy-0002Ol-58; Tue, 10 Sep 2024 10:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1cw-0002I1-MK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1ct-0007Si-Cg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365c512b00so1000309e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977629; x=1726582429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nn1a9HFZduZ/RNVuj0xIuaKX/DLxfqqaJjOeCmylyL8=;
 b=WPltl21WGO9N3hcGsvsCoSPlhh/76ABa/ckkY8KCrQTmIjQrrkq32heOQ9Lch5mp2L
 PnO4WHSk6I6szUrQybFbHHV76WZwYFcpS7bw1dRiWsgRLwoaeh9xhiXRZYF7jzRijER4
 jjJaknY8Rf+LwTi51DlgZELOcRvszyK/6CxqNh+nPSpmGl3cdBDZK9qVzO9Dgm49CUZo
 856YetQMLJeBCoHuhz2ulZaFNrmA3wFmK8U+3EQLJoZsl33/WacXm6SMjQUQACUtzmZl
 a/0/rREtqQZvQUpmJftx8fiujm0vaNuaZsxWYzSjIebXSYDhD+7cYgYOUzmJs8QlErS+
 jIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977629; x=1726582429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nn1a9HFZduZ/RNVuj0xIuaKX/DLxfqqaJjOeCmylyL8=;
 b=wlAyPjWGfK+mUlmfSUMRzATPTE47Xl7jUEgSZirxbQu/4Z9XInCCBpYnTPvFFMRxOP
 gh8+JMfRy2HKp6uzLinQYAKxi4MYSAdOe1hwFQcVAdEgE4/GJQGXKK1wRfqS6kkljXEN
 w/DXTDra9MFOqlxu3uaASm7d7EnlGFzdl7nwa6Q85oT8RBd825MsqN/ul9BISKSMgYTH
 xEtLaBW3Hgbs6rDg1ndECn33oVcHv3G2mTPyRVfHv9Uc22dJQirJ/HJUBQRzwWU9zzL4
 zjo7dXGHrrf0EgYQLiR9IFNOGrHbyy1e4t65z8s1BpLBFJgp01tuUAx1LdDjrq0wCT3Q
 pfjQ==
X-Gm-Message-State: AOJu0YymkTCmFHfNqtVbXSNnSBHEWwPUL32vsYvrDjlDkFi/eZbPL9Dr
 LMe0mZqaqiclcqzFkvbZQ9vvPlJN7vBDc+mI8tf2zMpfgihYK+yIFiwksunCB/Y=
X-Google-Smtp-Source: AGHT+IEN+uEi+sSwcMNzkasXjCFA5pK06+FrmC3zf8g5auPFpnmNgxgFyaFJBnH9NaEfz20v42HnlQ==
X-Received: by 2002:a05:6512:4025:b0:533:d3e:16e6 with SMTP id
 2adb3069b0e04-536587b2adcmr10879582e87.25.1725977629182; 
 Tue, 10 Sep 2024 07:13:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835b0bsm494599366b.12.2024.09.10.07.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 194AE5F762;
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 24/26] plugins: add plugin API to read guest memory
Date: Tue, 10 Sep 2024 15:07:31 +0100
Message-Id: <20240910140733.4007719-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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


