Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A785C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 23:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUnt-0007ZC-6w; Wed, 11 Jun 2025 19:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnq-0007YF-DS
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUno-0001jq-R2
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-236192f8770so2597025ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749684255; x=1750289055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=GhzfOAgEFSWaMu7xDyMoojUS8xqgqjTVeCSu7IEK+RQv2QSHl8g5E4Rdm4G47oDmlB
 yM/oo3EcNeBXo497+pz4NgzAsjnYrvw8ApbxUCns+bwVq0QCzlGDDt95itGxPyrshlU9
 88rfJK1iGowNP+e1wSG7gStFfeKbHufB26rUxrpHQjm1n4zfma4eWrZaw5vz4xuEzX6a
 pB1as0sM4U5nopFyj7bbJ7rkOptB/AQjOCnNRG0VxDUQoDvp6vFxKRcZEuSUjfarO/FF
 7vQiNyuJj9EYdJzBjHFWXwWJvf3kGehbSZuGj76xsLRHzvNOkblIGIFO4yX5PkFtHxb/
 afhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749684255; x=1750289055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl2CsCbMIdd7IA6Ry113lx92Qe9OahNuvq02EUlL3YI=;
 b=RslP4soEOUh5WI5YohMrBTGsyb37RVzSp6QNwC0gnz21ZWk7RESLhDbM/a/jwJYzWz
 QMK3h+QYJoPYGx2fXUquI8wgZfQQ6KqK4vP9ANUs8ktiovM7VE1KmorF/svp/qMG/4LO
 FYO0SPeDQKV8XLVXFn6m98IjqJPNIuf+HjQ5LkIByl+ROtRQshpTYYk2ox+NvJAW+ymz
 AfCSK0hFxBjljBO/axymvNP5rj4iRi3qrMpjwqdVo6yy88Gb0HqVhATvE09EUwT1HKvA
 61KOkXQpzsX2ftpbdwiQFyDgvD6/k+T9/5IqcLf8+e1CpW9G64LoNoupSAgx63lAvzh/
 eOaQ==
X-Gm-Message-State: AOJu0YwElePuBEXG/dTyy/mc1JWE+2T1+5MaX6CrNpWn/HEsCciabsCd
 AppU2uBpqImX6vcztLRWNM/XXcwtAXnVK8dSolpvPlF/DV9ftYCAHvMegWOck07e
X-Gm-Gg: ASbGncsWAreeE1PI6r4XCJdBWASxEkbyfLnaS3q9nuGI31wWHokSj0w1aJN0IpA8/5c
 XVBQRkgmG4q5pWstLhQ+XbC+xam/TMK6NKU8lzBh221M3gwlGTQHGu+zEYOHavcPIqHR7MNuyt6
 hIKE7BW3ljVfw6Lf6OKoFTw3ow3qcwMYsU1wgGx2YuxCK1TYHBDWLeX3+R28Rdk+s5zAqYcWrVM
 8LG17ZOaAh+npCppHSQnSiMirNX5TU8zwRGfM/cWvyaLIKrEPsByEAOs6uFlsL4xqaqvTgNgh8B
 oY+wRXmSI0w/ED6jOs6EkF2BMpdzkU/aa02tCRMrntosQ3MeA0wepxJoLxdrZA==
X-Google-Smtp-Source: AGHT+IH9j3TCONUfZz7F4RnlXt7tN7tcf8da7rtl0qJ/4QI2TTO7rEQyEE5xGwAhrg8ytO6PK+lKoA==
X-Received: by 2002:a17:902:ea11:b0:232:609:86c9 with SMTP id
 d9443c01a7336-2364cd850bamr16090245ad.9.1749684254941; 
 Wed, 11 Jun 2025 16:24:14 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6d9c86sm1220295ad.101.2025.06.11.16.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 16:24:14 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v12 4/7] plugins: Add memory virtual address write API
Date: Wed, 11 Jun 2025 16:24:06 -0700
Message-ID: <20250611232409.2936521-5-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62c.google.com
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


