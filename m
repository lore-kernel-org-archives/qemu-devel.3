Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9221BC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlX-0001HB-Ax; Thu, 22 May 2025 22:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlN-0001Ep-LF
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlF-0007j1-GI
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:03:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c96af71dso6847267b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965827; x=1748570627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19nm1BE1atXqg2lUu6wBedzxuVyUaQdQO9+pie3X/Tw=;
 b=VoAF43g1SbNBdg/v0FlzNiyGElsvK1AE8qcGN7gtl/wIQg431SKZYsPXe44ntpUycH
 FNeFCpxqYkDg4HtdrL0scdNLMucvyXpo7ISZDJoofVhey9dvLzZnvQehJpewA8Aem/nx
 RJhD89B1Uk9S1VbRF4+Lhoo6w8jYHm3XbrXWYZCtPVPu0mNtBaKW15pF2CZTZ8gX41VE
 2wuK0MzJB32Og2/9L9jhuOYRGDR/Vy0dzM1WhedwVyS3Q5dmFBWnipEtSuRDIFmlv+Sq
 PcrF30KdqgaIVA5+RZ1T7tmg/krhsx1fpcdUmFpFf0Kv7UIOIafnCVKfyRGYF4NsJbU2
 CnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965827; x=1748570627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19nm1BE1atXqg2lUu6wBedzxuVyUaQdQO9+pie3X/Tw=;
 b=GLYcr3YR+l/uXtVQQ4RMvbLOObe/tTfEGKWMP5WwgCnLkLfRmcE48hG4rJxNQ4yzQh
 T+W5jqhwz1Ylj0ZnEx5GYvFni2hXbLnQ6hQnvv6Tr7i4ULin4AeSqBZbnoNJBMBS3Ys1
 BPq8/iYGkfk1U7aEOOHSrWX3bUcp9d0zKsfS6ciBaVMctSCsxSpTCnJg5VAt7BcA7wSi
 4xvUoHzRL5f3/EFoxCXTLNky9rRd197Mr8gEtqL89f0VpKiS76UGUyuK38fWUWKfHo/i
 GP3oDpPQs512vDiHW7jy0gK96w69GUH3cMVOPXVU/cUBPc1Skpyxrdd63z14udS7/sRi
 uDuw==
X-Gm-Message-State: AOJu0Yyt6KCP6oanQ2VA8vcjb5Yr/D1vjgyLtA3ur1EISrc226MoEr//
 QdM5IqM70bJyX4F0Q9MHeHJ4FAuyoeK6nLw3eajrKjtkR2u2PnbAIdGdEaqvjVB3MTE=
X-Gm-Gg: ASbGncsmT/+zD82RtCZEFqz7gdN1GFVX9SNBNo5WoDHv/SYbEB/7x7dIhFPsqyQJiqG
 8gwPG1SaeWcdJ+MPLEyN0DVonYuPUgnsLZW1p+w4G/9X9R/b4XjSH/PsW6KOr5ZHCufugFlZ2FL
 u8LXd4+XzReAYpYqk0MFYc7RGQPunGT9KzURlFmu+B6pK7r4cH0jEAfir1+DD8LdNTAmTa+H7By
 pVFZ2GCvYyvCyRxBUfcjToSRfAMtNrM/TkZh8U9SocIyfihhJSg1Mk33RIoqDaX4DCQbymk+XC7
 IpHUOEyyytMJq10OfYlXzgDaWp53nQpXdNxSRF52qGgMRyJTGzljY8RzT4zS/g==
X-Google-Smtp-Source: AGHT+IHql7dQxnULfpnkVRTXtRD8dYjyUajmz3EKCB5gN3XXH39JdGhto5uO1F+iD2pqGr/TwnX2Cg==
X-Received: by 2002:a05:6a00:6f57:b0:73d:b1ff:c758 with SMTP id
 d2e1a72fcca58-742a98abbecmr37775090b3a.18.1747965827008; 
 Thu, 22 May 2025 19:03:47 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:46 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v4 2/9] plugins: Add register write API
Date: Thu, 22 May 2025 19:03:36 -0700
Message-ID: <20250523020344.1341179-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42f.google.com
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


