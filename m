Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82008C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzE-0002cb-BJ; Wed, 21 May 2025 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzC-0002cD-Go
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfz8-0001bW-4S
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso6578940b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820616; x=1748425416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9l29Gqtnblx1C+tXQ0EhOa9NoMzGN3zx9AMjGXDdxI=;
 b=G21BWw55spQjVAIknVTTecqFuax8WKOrm7oIrQ4db0nZ1j0+X81z8P750udp00JnsC
 84OaX1qU768SxwFSm6Q+M0dzvUf7+DWpRv9yoR+D+Z94aBojL1P9yDslIrKRmnY/4Ypu
 4zZAadXkw39sC4JyIjJu4g7nQHIZDT5TZ1zpmWpIMxLRBg/BQACO57ge038R9S3BymO2
 CakG8vB7H1qyroyKbNr6H08IskOgjA8i9nQPqaLfH2JYCZqrm1ITQBLjzRrqOWiJD34g
 IZNoftXGiCDecnqDG19T02srWd6NplfinKhi/+Vr3guqGhSTzUxDoBjCb4BSeeQL7wQa
 C9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820616; x=1748425416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9l29Gqtnblx1C+tXQ0EhOa9NoMzGN3zx9AMjGXDdxI=;
 b=Jhf015ejDXkUXytd+WMku55dHMopUDsjvw9KME1HhDAF3U4ThQjn4jtvCIjzwKN4iw
 06ze2jgG9/88KYARpicovBUwXaopb+5lAwt3OjQmswZQpmukmRfDvw2BWFRls9/wvVha
 JOM/oQSGWGUuD3ktmNMFeCsYRJmg3KtzNa3jzLbUt0QMqsxGnGv/sDH2Fmtyr1/xqJRl
 6PX53MdOGDkd6V+Oz51kNvoYsVHKpOxRTmjs8m4tmuHG37g4+Ghz8jOylvtZ723k4RLn
 RuYDtavmOry9XlNJY0wpJZap8m2tjqkwiEblebj/83vioCQ7xl62afbVO0BFz2+4dV9A
 q4Rg==
X-Gm-Message-State: AOJu0YzHT9FOW6sWSLhr4keMXEGVMfbX1dJbSaaHH0mBs9mfY/QRtIIW
 jWX0+WaGeWSj40OGPU0vLp+fLggFu2vNk39UMMcDoMq3LLtOf1vaRM0mNkE8u3l0NGU=
X-Gm-Gg: ASbGncviQvMKDcw7QUQ7UrSyNxfWPxtG2MugGTplhDmlEIwMmS7+kwu7E+Azt/uXn/o
 lCSEFMy6NAZ3XztxSyZPixC1Edt6NUMcLcYKrwiQXcXaj4T8bH6PyJ0ABSqGX2YXxFzTrnj1CN1
 8tNrMHVCGxCzIlYJLJeBtMVbLXlYh8Gh6waAlbU4ooIFrNL+dagEw6hCFfK3GeBTbI47Qn/5+fG
 uJUtM7IGbwW5bGX9L1NPul5LfNlQMCEhExZYd1XOk1Zcmff2XahA0EjhMbyXxCPr+tStFEspONh
 ayP6sKCCxt0+dl9Y12TDanaju34mA6A3dUsIfDo4ECDRcuxrskA=
X-Google-Smtp-Source: AGHT+IFohnOCuX+lqQtb0xoPfq7A7aL9yyagfHZE7UYzfSXOgDcvgWh+oEnBf2xHoKgVZFBiO+egcQ==
X-Received: by 2002:a05:6300:668b:b0:216:1ea0:a52b with SMTP id
 adf61e73a8af0-21621a2ec54mr30048189637.41.1747820615676; 
 Wed, 21 May 2025 02:43:35 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:35 -0700 (PDT)
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
Subject: [PATCH v3 2/8] Add register write API
Date: Wed, 21 May 2025 02:43:26 -0700
Message-ID: <20250521094333.4075796-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521094333.4075796-1-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 57 +++++++++++++++++++++++++-------------
 plugins/api.c              | 26 ++++++++++++-----
 2 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..68c8632fd7 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -254,9 +254,6 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
- *
- * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
- * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -871,7 +868,8 @@ struct qemu_plugin_register;
 /**
  * typedef qemu_plugin_reg_descriptor - register descriptions
  *
- * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register or
+ *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
  */
@@ -893,6 +891,41 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_register() - read register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+/**
+ * qemu_plugin_write_register() - write register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register write access is
+ * explicitly requested via the QEMU_PLUGIN_CB_W_REGS flag.
+ *
+ * The size of @buf must be at least the size of the requested register.
+ * Attempting to write a register with @buf smaller than the register size
+ * will result in a crash or other undesired behavior.
+ *
+ * Returns the number of bytes written. On failure returns 0.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_write_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
@@ -915,22 +948,6 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
-/**
- * qemu_plugin_read_register() - read register for current vCPU
- *
- * @handle: a @qemu_plugin_reg_handle handle
- * @buf: A GByteArray for the data owned by the plugin
- *
- * This function is only available in a context that register read access is
- * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
- *
- * Returns the size of the read register. The content of @buf is in target byte
- * order. On failure returns -1.
- */
-QEMU_PLUGIN_API
-int qemu_plugin_read_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
-
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3c9d4832e9..79b2dc20b8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -433,6 +433,25 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+}
+
+int qemu_plugin_write_register(struct qemu_plugin_register *reg, 
+                               GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    if (buf->len == 0) {
+        return 0;
+    }
+
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -453,13 +472,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
-{
-    g_assert(current_cpu);
-
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
-}
-
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


