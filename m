Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D039C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAr2-0002Cj-35; Sat, 06 Jul 2024 15:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqz-0002CN-V5
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqy-00044k-5c
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb05b0be01so15520275ad.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293226; x=1720898026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29AmjN08v39I61gQ3jvm15T5PbVM6dvTT6GDpWQa9nI=;
 b=SEHTXWSOEF9Ti4uIt8c8ENpHY9ryQ4U01opzwmPHBGMhbWyQe8nm4jMsRyrXUY9Mm4
 IL0UGfCaJh/kyHg3zrnsYyVwPWONBeIWLsnpE9cE2Qormqr8T8JVnSwHvsmIxOXb7y29
 ixh4Re+IPK03o4kbBp4OvCg86UmPfGzdRoiCcntLhOl7Y/9DtZRE0nfsqlysR9faUk1K
 M3bUinXMmFoBiRraVKYWv8Dos8uSkFdJOYSfJMKzHlhs16sAJtjyeN85pNmPDnSVq5pu
 lFMMD5NnYfX2d+YobUleetHde4x+K9nq9cdtstEYm/79n1cPuxaZNV5Wp/mSL+5aBaS6
 C6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293226; x=1720898026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29AmjN08v39I61gQ3jvm15T5PbVM6dvTT6GDpWQa9nI=;
 b=IDti/UylwYuHakytQj9cDp9h3UUX5+Dhagoln6teW8RWZTxWl9+/bq+jS8pbVFJMi6
 IO+CT6PawVWG5olTEWRdbw+iQyNnOk9E6sXQksWhXjgqGhkgqpzrNEqVKQxWnh8DJr6f
 ydlPEdkKdmSXq/OfoWWAbu6y/LJW3k2pvBPm3lBQhjDNuri68uNKXf8rwNxUkIR0nhFP
 SytJ3gweL5OxlT4bojgenKwMCVxh2Pcj6QEHwK7Vj3naA8W7dRBhTlqKStreRcZACVwm
 OrmgiONOR2+fsHg8ATxRcaj0gShipc/rcF1FLepNK/dOXgrcquq+IpjPJdibahytUu2+
 QRCA==
X-Gm-Message-State: AOJu0YxZUrUy1LnaH6rlWoHo0K0RGTulDxtPHQmQUGKALlIc2JPG45un
 cmDAsfls5Lv16jBdV20ufB6iVJyAfZ4r2VrzgfUZN7bGDCJujEzpAoiEFUy+ZSTt5zjkr3S4Urv
 NyjA=
X-Google-Smtp-Source: AGHT+IEQ8YUUTIXLW03S0KMC5gE6GQtE6k+TgQh3bRdiZIkQ+NSnzLFC45tjFuJJRtzj1yHWZCX4vA==
X-Received: by 2002:a17:902:ec8c:b0:1fb:1fd6:5e48 with SMTP id
 d9443c01a7336-1fb33e055bbmr68609115ad.7.1720293225842; 
 Sat, 06 Jul 2024 12:13:45 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6 3/7] plugins: extend API to get latest memory value accessed
Date: Sat,  6 Jul 2024 12:13:31 -0700
Message-Id: <20240706191335.878142-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

This value can be accessed only during a memory callback, using
new qemu_plugin_mem_get_value function.

Returned value can be extended when QEMU will support accesses wider
than 128 bits.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1719
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2152
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 32 ++++++++++++++++++++++++++++++++
 plugins/api.c                | 33 +++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 66 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b699..649ce89815f 100644
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
index 2ff13d09de6..3316d4a04d4 100644
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
index ca773d8d9fe..eed9d8abd90 100644
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


