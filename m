Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0955C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHZ-0004L8-TR; Mon, 02 Jun 2025 15:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHW-0004JZ-Qu
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHU-0004qv-R9
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso3418231b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894231; x=1749499031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypVRWuM+hXQiDhQiNE0atTWj9czA+HqzkvfzRIV5BeM=;
 b=TF8TXDZ2MyJbv+AzwvVt+uT9NFVJPMu0XQCD5Qccytjr/wIPACLH35Dl/WJNNyqARb
 nVY4y4kag98y4eTjBpSQKPQxrUdrAn3I3/3DCfKkn8OHMn+R6L/He/sdChQQM4nkU3Z4
 laIY14Hz8UkCPkIcyZ4JPBvadwRt34sZKgOLtSREKZgT8nbsqEq16BG2oYG2rmOx3PWh
 yCdMVFeJixTGZ0jjcNLK9Al92oFFmCUz1Xl3KVLt9W+VjA2rJux8CTRQ/A+QeVYHxlK0
 IVNpQfD3/+zrUj5mWi/ZnfzAX0DMu50Sb9RDaNPiRDtyszglK2hZSebDDteVJbZkYkhK
 4p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894231; x=1749499031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypVRWuM+hXQiDhQiNE0atTWj9czA+HqzkvfzRIV5BeM=;
 b=sCbeKI8bvur2PfCgUshBdY9xdH/R0+FfO67hXhXBpjUi9GrwcZJ2fDYggd8SkfVTJY
 qNtoTm2k+ut/td71dYt08xoTn6m1Nv8//SxtaUZCHts3yJBygrsSWKPe44SqZUdthR99
 R57EPIQAdp+FgN1ckeT0wRZ7DkKM01ZfFch+AJ+pIF0kVmUXbxgiesKxQC98f1DHFSSe
 OJBiRDsS7Ex34uXrH450krxW2Tu9qZx6fzoUfWCA3XgZAL56ymYUXCpw2BoZsNN0bnfb
 IheNqYRX+UC4yVL78rWvRmoRTA4v9PEQjKIIp0GqZw5sxIJsXrHQ8HB/x/qw1UdyzEZj
 ldcw==
X-Gm-Message-State: AOJu0YwbDwjyPPjUpKDk2kbZh957il1tIvBYIQo4AAI+3kRCy7V29LLn
 H0iBNc3qtph3u/93r4T6IjDKgN2nHXp2o/tdcIFMjPT+a9kVl6J0R6fMEpEoG0/P1kg=
X-Gm-Gg: ASbGnctO8STJag8s7CNscjNvOxUXQGy6GMJbZmZiqe3Q8OpbHkAC+bTADZkjb2MOSFH
 VyvCHCbuXIipgZm9iQZtx2R2E7evgfudwHPDsWDAvcX9Dk7o7B+q/MZHKW/Uw32H7yZAV2wsw+o
 0GqhqRckcrqTWtUJaF6lQmGIOA1exsEa5YmH/F3BRzqhxUMWOM+gzlQHtVBsl5/Mmv3/Lz1SW8u
 D0iV68gARcZ19XTjhzyaAM1IZo3A8ilxZh1DrCwA/KmVZmNF9/kUH6bKLd528b31rF6zrycT5YN
 V8DgBY98oI8I6SxPLL2B8DDrvjVHTDMPBXRq8+hIIT4KBH8ZZNA=
X-Google-Smtp-Source: AGHT+IEdPh3+EgH1MmMnIKqXhQQLsyUb1xkDNE44DdaFVkMaI25Z2hptCRJqGqj4mGKjm9fPudOJCQ==
X-Received: by 2002:a05:6a00:398c:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-747fbc58968mr871133b3a.7.1748894230984; 
 Mon, 02 Jun 2025 12:57:10 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:10 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v7 4/9] plugins: Add memory virtual address write API
Date: Mon,  2 Jun 2025 12:57:01 -0700
Message-ID: <20250602195706.1043662-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602195706.1043662-1-rowanbhart@gmail.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42e.google.com
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
 plugins/api.c              | 18 ++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 120fb626a6..8ae7758b95 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -948,6 +948,27 @@ QEMU_PLUGIN_API
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
index 16141f5c25..7258b6590b 100644
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


