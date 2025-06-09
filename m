Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00066C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOi6B-0007v5-1F; Mon, 09 Jun 2025 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi64-0007sv-Sb
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOi61-0002R9-DX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:23:51 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-311d5fdf1f0so3840703a91.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497026; x=1750101826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=IuqFCPN+9PkGWAXnrAnGU8HGRDkfCTO4SQ5KPjFt7KYVOP3SipUL9qWh8zvxBG8nnQ
 JUZzb+Ga5hR0s/C2jLSCDbP1vYmPRU775fPla0fi7pvJctJoX9i07cflrjgfTD9AKmyL
 NE8d5AwE6kbY9dwBAbmIeNG4cVkmUeQbG1eHkm0J1/3Yu2JHnSa7dEnVUzUGFQbGtGTQ
 OVGp0Frf8Hsh2IBNFAmnwlLyqJvKQjaD4ZOftfJaOSEgr04vz6tVNXsaeoMMQODUhftu
 mVTnz3N4hqUuzuN7Nk9YipuiCNjIZsX5HEsYMQYPmRFovkvVEVe5KQFa93ikikxQSqpC
 WtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497026; x=1750101826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=am/SSB+lDP4QcuKsXv+jG86omTxDuNRzA9QB6EFYUfilUxYOfBt3zImILc8YpxGD+3
 3KY3Tvl8L2+9/CuQ8HwHvkzBtx8Sumab1HCD/dvSOE+LtgYFl1IWftko9FttW0ANW7ug
 SnJ9F+1GNy7/Gn3T52eJs88PQAuMaiOwPoBZAMHhaK0h0BDectvDeC/jEHnDjoJRxfuP
 bIrmM53le+D3p1RMw3tjstYkJpFx4F7V6tW9PfFY50IHSJJnsKj2W7UUxbLHAYujB4Z/
 X9pKZo5EWgmAJyPxgBUpy2EH21fRR8MdvG4QsQ1ndC4itotmi+9SxuZMSxo/L9fKk/E1
 lZ8w==
X-Gm-Message-State: AOJu0YwhsbqvQQqkPjszi4zoQL/GHNYLGma9JQ2Z5XorIz1i/iR4DXNf
 jOF6HhOCdU409u7U6db95gFtR1Ko10EfWOBJEXAlKPMSDXxmB+ZfDu1+uZN8P2v/
X-Gm-Gg: ASbGncvSUNZVlMO82USU7hEysmfE36ogYVgzi8MYgHBNMQUVItyvbTTx+o5psumB5qt
 6e1L9Plr7hd8Moh5xwHlS7SJmaFls50hMN128E+QuU4rIyUN7DURc/wJ08JGzPnk76nqp7OoXG1
 MxNUf2yXrrL7mMrVPHtMf5H1V1X6UTDsrKKVqpJyjxf0hZg0SOX33Y8W9EjLWxpYEDTUbPOXsr+
 CCWmMiR/Q0UNKYBbx9aAo9Wv65Q+2HDpT+lrr9RIApr8AcUsWJaCoIIvA2+9pQuV7n3CFs39Kuv
 Z0f/L5YPevwKVYo/FUpIIOJn5bMsAUzW1mAhScKIxBW/uocs8U9ZJHnvQmbnsg==
X-Google-Smtp-Source: AGHT+IGawz0/JCwXfpQ7l06DeQfD0DcT7TfXTZs/v6rB3KxNDck3lX+320YpJ0R7Brp9UrvTdDMAxA==
X-Received: by 2002:a17:90b:17ca:b0:311:b0d3:855 with SMTP id
 98e67ed59e1d1-31346af9a73mr19788076a91.2.1749497026449; 
 Mon, 09 Jun 2025 12:23:46 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b044ef2sm6057658a91.3.2025.06.09.12.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:23:46 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v10 4/8] plugins: Add memory virtual address write API
Date: Mon,  9 Jun 2025 12:23:38 -0700
Message-ID: <20250609192342.316156-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609192342.316156-1-rowanbhart@gmail.com>
References: <20250609192342.316156-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x102e.google.com
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


