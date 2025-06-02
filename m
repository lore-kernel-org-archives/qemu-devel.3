Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A189C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLye9-0003hR-CN; Mon, 02 Jun 2025 02:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLO-0006d9-G3
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLM-000260-1l
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2769413b3a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844498; x=1749449298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19nm1BE1atXqg2lUu6wBedzxuVyUaQdQO9+pie3X/Tw=;
 b=c6sWIsANlhoX3An+0Yx7QShM9vVRoRacaQggOOLB+FDXO0tovPrGEm2yBYaZBBo6e0
 28AufIHTrsI4zHHf7K+VWfPbPMrjYJ1p1HuWfwwdo3g/bAlQRiGAiyasq6CHI8KEWBHZ
 POvCwaDidZkvyr0Q/UzZdGyEIFwsUNdOMV2Ia8iJ9NrGl5A6zNcYdxRW+4PIVGcGftV8
 uIpmGhEvsQGxFS17YP6SBQ8Twk9nhkHcAlXwbsbVpw1s2mU79l69HwRMKfDSnYQBHsXC
 x9cMmszHmOO4nKGqfZ+D1wrdMEVzOaRFfDJG7/P1lMdW+kDY+2lB0dcj479Ex6LAHMFT
 LNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844498; x=1749449298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19nm1BE1atXqg2lUu6wBedzxuVyUaQdQO9+pie3X/Tw=;
 b=E7lO43i/BR59tQypDjTdgWjXCFzbmA2PkWyKon5/F7zlH/B95Cz0pp++W9EpGrqdvq
 7HPaFoeRzU62efnyxQ9rVPTY7P3RKY8oE//NvIHU+zNNLZIuqEPg7Lt3Iv8Rie/Wx3xI
 1ySZE9T5sINRvEpyM5TD3+hRctoCKpFCtiCBmo/uo252g+AJ/P6ArkzcXC77eNLZWfX7
 7JFgvbHxuMImyGd5aRjjiK2oX0HDNx/MxjclUvqTRAknU8dfO13qZq94OTk8BdXjvN3h
 E2cuCqFLqkFYLbF0KHSyS3mQKVYOzamFjSTbZI2UDHTeDRJOSwHdxLKbJnuWsThQojaw
 Hixg==
X-Gm-Message-State: AOJu0Yy9nGFqNiyZlz1y4yxvx2aGshp1grhV6s+XtV7VxQYNLGzZfXvp
 1yCEIxvAQnu3lQbt+vrr2Sio0DVXDRgEe44X/JEdx/ZMG6gEgWaV7KdFXmxe4cctP+Y=
X-Gm-Gg: ASbGncvkRcYzcah/nzeGPVnrXeYooH3r3htIQY6Ee1pPLaLdnGVGWM1hzH8vso4YoQo
 18bOSas1mc6t7P/ZxnpLHZKww2FGfxx3y0FZ+CQCqQyP5PN1TjtwhFBdXiA2WcNzNQGIU01Xi97
 jffbmozk+nqplD10t7HJGiVdHxpIBUek/2vCAPUQ6FEmGmvfzm8csO9AdL6RyHTAwV3jTM/cymK
 jzTN/a+J+wyCGLP/UqrwG+UkgYbUVfHx4RTwLltYNuqtJCxemSACogGXcBhQyhpokP+I1caaOfB
 JgNvTgCmMgIJcQPjvl75xzw728hcPKE+9EvYqvxfUdkVDCVuqAA=
X-Google-Smtp-Source: AGHT+IE12aeN596AlaQnNv1XWM0pMG0N90dKdp3dG9ejBYQlROZTTNy5SjbN9oTbieshSNYnCzSIlA==
X-Received: by 2002:a05:6a00:c95:b0:73d:f9d2:9c64 with SMTP id
 d2e1a72fcca58-747bdda14bfmr15682190b3a.10.1748844498433; 
 Sun, 01 Jun 2025 23:08:18 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:18 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v6 2/9] plugins: Add register write API
Date: Sun,  1 Jun 2025 23:08:08 -0700
Message-ID: <20250602060815.328261-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42b.google.com
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

This patch adds a function to the plugins API to allow plugins to write
register contents. It also moves the qemu_plugin_read_register function
so all the register-related functions are grouped together in the file.

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
 plugins/api.c              | 22 +++++++++++-----
 2 files changed, 52 insertions(+), 24 deletions(-)

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
index 3c9d4832e9..3a7add50d2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -433,6 +433,21 @@ GArray *qemu_plugin_get_registers(void)
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
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -453,13 +468,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
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


