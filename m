Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044A3FC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4m-0006dj-Op; Fri, 13 Sep 2024 13:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4c-0005y8-T3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4V-0005tk-QP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so2697334a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248422; x=1726853222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg1S7MpqFLKynDQMTW/BgVqsjzz9T+4SZvu94a93bN0=;
 b=xSeZG2eeWB+UFjTeZ8P4bdSFNXAnl+iYXQFhu6X1A7YqbjXYm0Xfw0230nIWivbG9u
 RSSrTu7PjR79It19K2iNQD2FMlvqA8aRur1mRAbrRAWlCc9dMJjIyShfqPh4w78RgUDz
 qZZ6kkbYXGSOVwM2+zOqGJxeErpDLSFWAI4ZkajmN9IEbtKGsNzQQmTHqOWIYinAddI/
 Nrk1mczg+sagJNVgXet64wNiYileIi3aQa6G72BcIiXbUoVXQikPwV2JFS8VjggLmeRV
 9FjKewZOxU+XfS47eJtaAatFon06F0pp3qdH3M+2RFYFH4UvT3sbVAY+B/cKljTNiW/I
 1Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248422; x=1726853222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg1S7MpqFLKynDQMTW/BgVqsjzz9T+4SZvu94a93bN0=;
 b=VVUAlMtApQwzVpphfJWkS6VdJMBR+5vzC/xnaMPE6zRYGlleWwhMZeej3U6ACyYPad
 jU+RvUPUb39Cg9Y6sTjPw14iLxUU5W4Qn8d2MCx8up61Wa0ION2G+EEsLhB5ejq9VdiL
 xhHMT2VYd+ul9pq+HLngqSHFaEoZtWjpgapNt0QiGpX7UACYLFU04HSdQZwn24Y3p4PS
 Q+WClWU2VL7xoDpAJjNZQaYJ6XjJF+U+foaMhM/u0p05bwZB1OSV3Im63oO4rkIfMgPS
 LY9piDiuakZB46MCL7/ZNgkr31yrW+BsrR7Emugy7QkV7qFIw3gCZ8OmzJ8im9Nbx6cA
 ntFw==
X-Gm-Message-State: AOJu0YyCrwN/utrb5WKNFr+Y3dHTX+aFKT0aEglcOxjjCRqUkUb6v9Ay
 nz884Z94+/qeYSLjKE8Sy39MkYrBQFSSP7LLdl3PvhNWSLq7LTBTjVpfGQ33QRk=
X-Google-Smtp-Source: AGHT+IGLdiyvCRAbVFKTTRI/yfVPVbqoQSZ8/27/OW2tLtvYMf4LNrIs0r6WsStQgUWWXN/5rWXdGw==
X-Received: by 2002:a17:907:3e8b:b0:a8b:6ee7:ba1b with SMTP id
 a640c23a62f3a-a902943de74mr591772366b.15.1726248421629; 
 Fri, 13 Sep 2024 10:27:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72861sm890889266b.105.2024.09.13.10.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C1255F9E2;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
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
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 05/17] plugins: extend API to get latest memory value accessed
Date: Fri, 13 Sep 2024 18:26:43 +0100
Message-Id: <20240913172655.173873-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This value can be accessed only during a memory callback, using
new qemu_plugin_mem_get_value function.

Returned value can be extended when QEMU will support accesses wider
than 128 bits.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1719
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2152
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240724194708.1843704-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h   | 32 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 33 +++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 66 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..649ce89815 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -262,6 +262,29 @@ enum qemu_plugin_mem_rw {
     QEMU_PLUGIN_MEM_RW,
 };
 
+enum qemu_plugin_mem_value_type {
+    QEMU_PLUGIN_MEM_VALUE_U8,
+    QEMU_PLUGIN_MEM_VALUE_U16,
+    QEMU_PLUGIN_MEM_VALUE_U32,
+    QEMU_PLUGIN_MEM_VALUE_U64,
+    QEMU_PLUGIN_MEM_VALUE_U128,
+};
+
+/* typedef qemu_plugin_mem_value - value accessed during a load/store */
+typedef struct {
+    enum qemu_plugin_mem_value_type type;
+    union {
+        uint8_t u8;
+        uint16_t u16;
+        uint32_t u32;
+        uint64_t u64;
+        struct {
+            uint64_t low;
+            uint64_t high;
+        } u128;
+    } data;
+} qemu_plugin_mem_value;
+
 /**
  * enum qemu_plugin_cond - condition to enable callback
  *
@@ -551,6 +574,15 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
+/**
+ * qemu_plugin_mem_get_mem_value() - return last value loaded/stored
+ * @info: opaque memory transaction handle
+ *
+ * Returns: memory value
+ */
+QEMU_PLUGIN_API
+qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info);
+
 /**
  * qemu_plugin_get_hwaddr() - return handle for memory operation
  * @info: opaque memory info structure
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de..3316d4a04d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -351,6 +351,39 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
     return get_plugin_meminfo_rw(info) & QEMU_PLUGIN_MEM_W;
 }
 
+qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info)
+{
+    uint64_t low = current_cpu->neg.plugin_mem_value_low;
+    qemu_plugin_mem_value value;
+
+    switch (qemu_plugin_mem_size_shift(info)) {
+    case 0:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U8;
+        value.data.u8 = (uint8_t)low;
+        break;
+    case 1:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U16;
+        value.data.u16 = (uint16_t)low;
+        break;
+    case 2:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U32;
+        value.data.u32 = (uint32_t)low;
+        break;
+    case 3:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U64;
+        value.data.u64 = low;
+        break;
+    case 4:
+        value.type = QEMU_PLUGIN_MEM_VALUE_U128;
+        value.data.u128.low = low;
+        value.data.u128.high = current_cpu->neg.plugin_mem_value_high;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return value;
+}
+
 /*
  * Virtual Memory queries
  */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9f..eed9d8abd9 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -13,6 +13,7 @@
   qemu_plugin_insn_size;
   qemu_plugin_insn_symbol;
   qemu_plugin_insn_vaddr;
+  qemu_plugin_mem_get_value;
   qemu_plugin_mem_is_big_endian;
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
-- 
2.39.2


