Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4C6C61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKb-0007Ew-3B; Mon, 09 Jun 2025 15:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKX-0007DS-TE
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKV-0004DB-7T
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742af84818cso3300215b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497925; x=1750102725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=HcU+mCGC3Xb5AqRhS/tkdnEVEJ++q86FVe+7cMGCM/eUZMes8sS9y7GwWAHNgyoTUd
 TUAsdO0Ja40GYgMUkZYJLekrDW27XXqzM0XxjvJtBHpjFg45F0gopV9fLJ4Ukx5C/Ep3
 HS8SCGQIlocfdnF5B6ePwGBljryggN6Mk87C2bzDuBK2cFengsiXWjoT2FnzDBnqGj7c
 8VNALlRW2oxMCEeqT31YB9NP0zy4I8JqOcMThzLwtlP+QytTIA5wE06CBbuVY0Pm+23y
 p4UVuy24VwsKb2rHFaIUgypgGx8/AMIc1Wo8lruNFHzc3gVCftcoyrU8SnPmtSkpE1Ih
 4sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497925; x=1750102725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=Ta+BSH8IlKhZOZcr4j6YkhukggEODrtWkqJkHxCDQ5WwbMhaapXhOhVgY7VEjwvd8t
 eucqZ28/oBabmWcb/ZhVNzOONCzVM9u9eUWPX60MiNLuhOcywc/ZJwyb4R3Wzym2Jg3n
 hKuR8x2i99DF3k6ydq+GOJtgYA6fiJgn7UG0H0H41zUoMr7OHkWnvkH8ljxERHBfxcS+
 pM3Sy4Z0EzYkjsnsDyjTcJGGoVEmAEdrOVXDD4M3L2WGGlQ0kDh6p/zTpIHQoDHu9e+9
 axzbJDo7wIuE8cGdYNC34mqiv9/QY0r9p6gzcsdp4SAUp5oZjlin0E6KCv8OWXd2Vfa6
 kWig==
X-Gm-Message-State: AOJu0Ywb+PQKqW5jibAnq+lgAtw++cYiffpxyhGXXYTPmzt1xAWra6XA
 oR2GUF5skh933ql4B8VVoG1njpCPm5dq6yvj6JZS1LJVr63urmi2H2/+9g/Fjkmz
X-Gm-Gg: ASbGncvmIgntqxPjgPehFZMubIMveaJVQNVa/vVnzNJfmUGyDL+0/Ad/6hG9FbqqrQ2
 bfZXOf4HZqKifjXYYnQiOtX8yPGCw+LOk9z9BEKaOViKAgEG2tKlDU5iugyBxg6+KVZO3NYmJSV
 Jfe2uYUPy5v2/ai8pyalAG7sZ+utQeFqswtUY9zMgRCQXcRQrjt1hRJPkWYuvmA8ECTO/bWtyL3
 Ua4acBpJ2aShqcbr7upscmn0bwMkmpU7fewh1cOIG3WSGYttSaiPN8K/yp8weaxsD3oXq8RZEGD
 sLOZxagqqaBNMN9KU4eBd9RMaWixAdy2hB5LZbo7wrO/VpHeLF9CD04el9/UWg==
X-Google-Smtp-Source: AGHT+IEjGKiL8UWIk+a8UiGmpId7If3TzYOhTD8OoAlhGmvBnnU5oF5JAw9A66/nphZWg0s7XNSt3Q==
X-Received: by 2002:a05:6a00:1818:b0:746:285b:595c with SMTP id
 d2e1a72fcca58-74827e7f47amr20396160b3a.8.1749497925331; 
 Mon, 09 Jun 2025 12:38:45 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:45 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v11 4/8] plugins: Add memory virtual address write API
Date: Mon,  9 Jun 2025 12:38:37 -0700
Message-ID: <20250609193841.348076-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609193841.348076-1-rowanbhart@gmail.com>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
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

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 9c9ebf6ce0..4167c46c2a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -958,6 +958,27 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
+ *
+ * @addr: A virtual address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care to only call this function in vCPU context (i.e.
+ * in callbacks) and avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3f04399c26..1f64a9ea64 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -476,6 +476,24 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
+bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
+{
+    g_assert(current_cpu);
+
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


