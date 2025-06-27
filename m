Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C206C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DL-0005Lx-OP; Fri, 27 Jun 2025 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D8-00059N-Rc
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D2-0007CK-Na
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so2055698f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023529; x=1751628329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfOydpti8CfNqtv6LkyLcOid8mAdomf3DMhRbN7UIJc=;
 b=rLq6Icx/uK9YYGmldgyn9GCjCjgOB9cYGdJ3i6gFDsGn6x4ar/uf9clsqeWgjUKhBZ
 mBApW/LAJIMg+RMBEOR0OxzjunEpgNhDa5JNi2uuYfJAHjeeR6vpyebF1ib/+CEKQYHQ
 Cl6JWV0sKsx2eb0B6DI53/YiaIdgZcxhcfV5RmWYzpsJYhbrZ3zBpiH0vwXoHSiUBFII
 ZHTfRP60rt3+sGBBaHUfpgjxlhoDnMn4h3gAhtoVR8jm3rSNxVNbehSvg4Fk4LOAzXku
 mS/K5UJb60vPLqFbdCbyWJgFP5D+VBM73h6BA80TwwyUidkBbI2taGNu74gi175WSeWD
 6k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023529; x=1751628329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfOydpti8CfNqtv6LkyLcOid8mAdomf3DMhRbN7UIJc=;
 b=UCkmwx6/HvE2zhiKSxX5fSwEWCJ3hpbO47n9lSXig+d5YmiNysjnvrC9lBPFgRs7IJ
 QxBlUS6/haPcX2NglCSpLPtULHmAx0yNX/RqmPFb38/nnjZ3l+P49ss3/rTKCyNJJNqK
 OT0XS0ubaqcRT2f23Z/iiUBYJTSCp9kLSBup7ui4i1KkDpcV5A8CQiJiwKUsCeTQHLzN
 Y8B91n/vNBUAqWRlIYRa3VHmh6YFIyLChh7LnoGGF+Yhr8D7f+AvfxEr4VdfYj33kKZX
 ENtQes5JOJ6at6GHSDjQTBSfrrvc7qElHMpzyT0S2FgV1w5QkYXJb5YWWL0512UJdtHH
 TGAA==
X-Gm-Message-State: AOJu0YxE07lRMsqYIMaKIkbTcmZuBKE5Dnm1SmcgpeQPMkJheFsxTeXC
 Zgmz6YmqllBgcjpEfL6/RhTeL+62lrSv9h+PjKVs1mWlMRI/MMAaw+YqLNUbkj+La0o=
X-Gm-Gg: ASbGncu27umlibvKvukla1pAcwJNptFum9PqhqocKd80esxKWBTIlN8RdFJ9wqtwERs
 voIt6J96ChQtzLhsTY4FYoBK9n1vWnUTwk5qXPeQXe9Tv70lTQKZTp7f0a5PcUCXnE+AFblHCTh
 9HxIHr8ThvSJR1QQms7GRyEAlpnwSX/+pCXuFWPYTVLxiVNIfIDYpI3FueXtPfaeUbAAPLWeCs/
 eJAVIZM5J3kwvx79G1BDD0yxVQD+yhGm+6HDFzHdO8Sk9Kd3APLySS7779VEeY7Qn2K5diAms/n
 mrtHAkFmT2V4zD1lTgRtRZQC/dbokMLC4iIOHLXu+RgBzQ/RDObLZSndMe63DD4=
X-Google-Smtp-Source: AGHT+IFjBZvWRw8+uqQSHaxseQCWp6n8WgnqxYEoFR44hjTbWjnXoLmHeSXgdqZgMV9lBehu2F+sKA==
X-Received: by 2002:a05:6000:4b0f:b0:3a5:281b:9fac with SMTP id
 ffacd0b85a97d-3a98b53f51emr2145050f8f.17.1751023529172; 
 Fri, 27 Jun 2025 04:25:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fadf3sm2503596f8f.34.2025.06.27.04.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BAD645F8BF;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 06/15] plugins: Add register write API
Date: Fri, 27 Jun 2025 12:25:02 +0100
Message-ID: <20250627112512.1880708-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
---
 include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
 plugins/api.c              | 26 +++++++++++++-----
 2 files changed, 56 insertions(+), 24 deletions(-)

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


