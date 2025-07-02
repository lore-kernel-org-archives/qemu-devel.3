Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB65C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2f-0000Dt-2V; Wed, 02 Jul 2025 06:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2Y-0008WN-0F
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2T-0002yG-EG
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3718781f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453403; x=1752058203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz2+qC8xETuWCBtFi38dLbw9y0bYYX3IVoNM5Sk2/QI=;
 b=YTJP2iD49CJ/iBImNCJNqBLIE//E/3HANbrmO77s/xRxRr1O/5y/ra9f3/bKe+tsaM
 gVsMoqXlEaj5OC6FqgkLMv39JdoS0iDhvIu+QZLm825aywvIKZ11zjiV1fQgL4G6wLRJ
 hoZsrf9mXZtvErteWTVxYmvBMK+nW/eDPIHAX8GDZYlwfIb1eZeo72kvsOIRvdnST2H1
 W7lfpEx1SEFXnbxGSJuRkf8Vxbt5RlocrXlU+q05MJqRF06UZFe8+qQ8EYn8nLfkpQeS
 s36hDWNItjagY7RzJOLYMhsMs8NMWLiBehC7Vbn1uTojE+SIcR9/t4dO8VXjwCKJ1WTd
 BeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453403; x=1752058203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz2+qC8xETuWCBtFi38dLbw9y0bYYX3IVoNM5Sk2/QI=;
 b=Q47+GuRNm4Xb1igVhw5XtLbw4lNT7vLaYMyctdV8S9kBAFNNTz5Jb3h0Mj2ndGNUZR
 HiOm8LPaSWjtAaGT60DZNQV4v1xC03J9EeDdgjh2eLmyb5JJhdohnOYdVzfYdQVH1A4G
 f5b1k0+pkqxvU1jeHEspo8Xj+VEGNJuegYy7D53e/Sm/xPgHTLh0r2iTQwnj/PgRkoWF
 E3Rjrk+Lav8FmxQPVoczoPi/uCttZ26LovUBj4PZOOB8xC7OqoHMrJ8kL7aNQl31w6xR
 VSSZqNfs+Ax2ntU47HajGF6RguvSCdwBW5dVxpKcTi3nLAlQ3RLuNJp13ZoA+71Y/tgH
 BskQ==
X-Gm-Message-State: AOJu0YyZCT4CXhDGKjaEBCqRDYYEHVn8mxEp9ui6vmNiYsmYEth0eWYJ
 IOWj9zf8kSKKVc4j+J5IYzVdaRREUO8SLQFyJXay8EwKFbbpS0mYiyNQVT6/qKow9wpqk7JYg2F
 kga4RZIY=
X-Gm-Gg: ASbGncu/VEVMLRxC3PGRaBjGKLAlkOgGlHLETpxcHwfPN0bUrefDCSHHqVt3/gGUG1O
 v2TfxxqLPZdPe/cwm63qbgSWzgch/NpA9EDB78bnOdWqM92sP540Awr8dfDfK1U3jogdfVkmBbA
 xIVXG5U1iwrj8rdeiopR924qg0ouKrBaUitOvPq9YKiucv6wt05iVBGFm8AwJvo6v/zETM8u6do
 OZZPCAjOG7TtPS9Jor1nO1ToFJClAEHrHJSBe6SgbQQwNuHCJNPzd58FUy3GjxlQzVwXCpMx0K/
 +/g7P+PdjV9UdUjaAjLMPJpKaWXNr9aeuxazCVoImnbonLgeauUAiCJcJ/vSIDA=
X-Google-Smtp-Source: AGHT+IElRmRP6XMVnFdIGIqOEMoFQ5CenYNciLrHyT1/0xG9B0kLhD+AsoftRwW6CGX9VVsk9556Fw==
X-Received: by 2002:a05:6000:4a09:b0:3ab:27f9:e51 with SMTP id
 ffacd0b85a97d-3b200582cadmr1618013f8f.31.1751453403380; 
 Wed, 02 Jul 2025 03:50:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c5fasm228963525e9.8.2025.07.02.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A80B5F8F1;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 08/15] plugins: Add memory virtual address write API
Date: Wed,  2 Jul 2025 11:49:48 +0100
Message-ID: <20250702104955.3778269-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

This patch adds functions to the plugins API to allow reading and
writing memory via virtual addresses. These functions only permit doing
so on the current CPU, because there is no way to ensure consistency if
plugins are allowed to read or write to other CPUs that aren't currently
in the context of the plugin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-5-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-9-alex.bennee@linaro.org>

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
2.47.2


