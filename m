Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7614FEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X5-00084S-HA; Tue, 10 Sep 2024 10:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X4-0007y5-1U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X0-0006XY-Vd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c26852af8fso7329944a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977265; x=1726582065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bg1S7MpqFLKynDQMTW/BgVqsjzz9T+4SZvu94a93bN0=;
 b=OSGH31h3qkkw7RvVqoDEAkbUyqhE03bXYGqVfczno4PyMCbnuxxQ1lki3CBdB1VNHE
 ibErBbDaongY04CUvmp/GiJIwQHI/8eaxUOEBnRhszK9r+f8ekIe8Eg9xMbBiOyYvsHm
 Y7GQsWr02kKAtPHDjR54PqRC2AfwMX/fwhDgimXGeNdiBM1YwaVK1ZEcDXkyESWa+NiO
 6pstBrUWTPfTARW3BPhjy9sSDBCe94qsWZbObnyA5ofodaiCIiV4ED1aS6whezrQIvuV
 2hDbIbY4sjvpR1MFQe/ssMwa6MFZAzC7GcwKpr/3b8ifVSwjY9NgiTTZPyA1w4YHF4w0
 kEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977265; x=1726582065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bg1S7MpqFLKynDQMTW/BgVqsjzz9T+4SZvu94a93bN0=;
 b=l8q/9C1YEFAHIBT0V7KSkyNT4OUvGDwrEW6DJ/vqK6At0aWsSB89bHTxnj78GyBTqM
 c9C9pEIKPWFDvruqz5oudbY28zhdfaX0jHo6XZhOpRK73dF9yb2J72otNla7AR1yk+u6
 0E7ABRSkI1o+QfhERNP1pkKPuPWHUcyakFllICqtR9Ixb23l62DtrHzXw1VeWUsyhceK
 5/WsavFI+DI+l4TXvoMt+4QEyh3wGGYNKZarhsaW/CvePj3jcudEm4wDAN0tDPWCUDpA
 HugyQKa0dBsigygxep4mB0/355B6qKZdq7rWS8hQqyTA9jVaP4Ga2jrL1TMwwIohPTN0
 p00g==
X-Gm-Message-State: AOJu0YxcFSglYMuJLEHyZ/JPJnBhEO5h8abt2iXBpy9xBk7JzppGxxXX
 mV94MFukR4AvTeiDHteKXKuzj8ZW5DumR1OiTIgKON1LAw6VI+SLh7uElKy0CIY=
X-Google-Smtp-Source: AGHT+IEi/0Wc0xg/L10zGHE+wHVRRGYGpIfWYPv8hdMQh0hn+pxd7BZD+gpJ3LXBwtWBKfSQIV8GYA==
X-Received: by 2002:a05:6402:5109:b0:5c2:4d9f:61c with SMTP id
 4fb4d7f45d1cf-5c3e9533614mr10178504a12.8.1725977265376; 
 Tue, 10 Sep 2024 07:07:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd4696asm4311411a12.30.2024.09.10.07.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31AEF633E6;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
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
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 15/26] plugins: extend API to get latest memory value accessed
Date: Tue, 10 Sep 2024 15:07:22 +0100
Message-Id: <20240910140733.4007719-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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


