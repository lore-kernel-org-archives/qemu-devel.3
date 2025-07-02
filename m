Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B8AC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2e-0000DI-3j; Wed, 02 Jul 2025 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2Z-000065-Ud
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:12 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2U-00031a-TV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4728867f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453405; x=1752058205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaLVJH5otwR+otl8BtaHu4M3HmdksGlIfafwyt6VO9Q=;
 b=IgRJiOBlPLJ1I/YSK+K0CXg7NpOF6KRNUg1BTqBdRo4y/ywoUhE5oUwNSUSA9106pG
 SIYXuYBiKMfEyrAPwgyTzlLcguKFYjXUZfIUbQkPJFTyjBbHlKNWI8hhZb1Zw4enLpZJ
 TLz/JRiNxQtk2BZQDuzDXva0as/q1wfBd71Rv2FoPqoUwMO3oNXPjP1iNSgHuaBzalDB
 xeASBlAKPC+Ocde29gN4+87pfshthoYaHpL4wd6X3dL/r93H2miEXmuWgusVnrDdbbiu
 N1UIgL0q5IrPiqe6uNINxxA3R3EjJ3qEag0kcBG0du4YG2cBkHxZLhvcrYl16FtEREbz
 Xvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453405; x=1752058205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaLVJH5otwR+otl8BtaHu4M3HmdksGlIfafwyt6VO9Q=;
 b=g9G07sLnAF10//hTB/G3c0NQCuXa7kvq3779Tkv2V+VbEiDkXxhACglYFafLxej4fh
 pNgKJJcvGk01QVTx0FXPH9oTdwVS1sxvNKNm7sjcnX/8Lr3ko3RLhG1gj89oWLgyQHuH
 OevrpuSe6DRQRHPnquZmeu+UpRY2vQkyxrWNABvs2fp8yb+Z7ZlkkucWLtwc7H25qdZB
 jx+xq49ynohDJ/JE2T6AST0HwIkLtC1jqzqqrsnMXf6xIltQpHDs2qX/lSqTpBy9ISdD
 yYSFKO/idneY+uMJY/sAmLzvy4uVoBTnvafTD8h3GD0VMGKAYu3kSzQsw/D4DlTvFFEE
 WgeQ==
X-Gm-Message-State: AOJu0Yx6Ak+H4Ya9vum2/dIEEaaAmuUw1Hnmh1tfzNkzeBDf4HWIH3YI
 v8iLc9m7GaBwox+pCIwhn7uCcKYPD76Thua6efSfS+7llhUokT+SCp6dmMcfaOQFF28=
X-Gm-Gg: ASbGncvN6GjvlXlrAHM2O3GudEmFmrbFnJ/ylMYhYLyjd9PHTo7vqxZ4xOxMKiSep7f
 pqLPmlxAbeQcYMULOMAsaQDkAELCTLaDZ/WcyVxAJCkvlbu8N5Os8QJvS3my7n53B0PMyQ3g7bS
 pCSbqj+y6dOPGH5wYLitewu63K8lrROhEFbJRlM6YDYLhfYjG9wueL8Wilo6Y2vitXXex4Y/mxk
 1yfKo8OdueWe8zxLbs/S1sBBr99AEX0roGbC3bRX8T8XH5SLokG39XrdOaf325F6H7e1qPijWYQ
 j4mIUuMIur/l5UlrzgJ9XnDxubBNBfuwkDRN1AVWU4NgGf1RS6B6UJalKXg+t/M=
X-Google-Smtp-Source: AGHT+IGc9umVJPo23eo45L18kx7azIwjJrTQ1i6krJLRzAx+GNxtnYVM4q0KYSWxGw/aQHouIzI2vw==
X-Received: by 2002:a05:6000:2582:b0:3a5:52d4:5b39 with SMTP id
 ffacd0b85a97d-3b1fd74c462mr1743386f8f.8.1751453404980; 
 Wed, 02 Jul 2025 03:50:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538f2fec5fsm173621235e9.40.2025.07.02.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 593025F8DC;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 06/15] plugins: Add register write API
Date: Wed,  2 Jul 2025 11:49:46 +0100
Message-ID: <20250702104955.3778269-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

This patch adds a function to the plugins API to allow plugins to write
register contents. It also moves the qemu_plugin_read_register function
so all the register-related functions are grouped together in the file.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-3-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-7-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..cfe1692ecb 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -871,7 +871,8 @@ struct qemu_plugin_register;
 /**
  * typedef qemu_plugin_reg_descriptor - register descriptions
  *
- * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register or
+ *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
  */
@@ -893,6 +894,41 @@ typedef struct {
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
+ * explicitly requested via the QEMU_PLUGIN_CB_RW_REGS flag.
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
@@ -915,22 +951,6 @@ QEMU_PLUGIN_API
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
index 3c9d4832e9..6514f2c76a 100644
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
+    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+        return -1;
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
2.47.2


