Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23974C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 21:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj48A-0002zE-CR; Tue, 27 Aug 2024 17:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj488-0002rY-15
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sj486-0000ud-7z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:53:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d3ec4bacc5so87797a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724795613; x=1725400413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aahftweEp2bhThMsu5oRGRZbfrczxAqb0hpyuKnwTu4=;
 b=mAvkKpvaHDdFPg/gfrUpIY1r4kh5F7wGo6oUNlbW+P0s5Vks+PORMVqcUkZ18BvPyI
 pbijOUo3zUkUw94zUki6+HYv/ItVTVG4p0LaZsyGHtIJ99XeH7D82mvUvFargOjN4PC8
 oU0bG5xNlr3xwHSbJqC388JmufMJP0wTplU39uS3ZgDwRb52E/NNxWpKl/pEAyEd6uCl
 O6wtObl7/iuJtcXMi3eK6/hKGCotpBKjg+h4MPoidmKZ394bB+au9eWMbBGR2KTg9roP
 RpXNm8GUt7vAND42ICzMFr0WZz08CoI3AAjKGC/B26zG1HhPuZpA/HxF0Xu1kv833Foy
 zynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724795613; x=1725400413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aahftweEp2bhThMsu5oRGRZbfrczxAqb0hpyuKnwTu4=;
 b=PmQtHrb3zdFMNJLat0F/p3hFzETwI/24t/FMIIJkFt8phMe03ppf7ETFxCDIU2KD05
 VJFEKrAwZn45eiFn70D8A6tclUB/dl0j36Ooy/iyOKT86EFlJLHnwGAeG5vYTwlvk8dI
 dhrB8zh3v1eCZbj2xfAEAY06APxRc1bzn8fWaCK4ta4k33/0q00CXvs7JOAS0jIr0jP+
 1vUkBafnXotiao8kT5jp+6YYPEzPDb1GqHBASOHKUV26DOr558t3nIl5zJV555Ee+ZMW
 1dbsGt7xSh5vFEZ4jmilvPnDvfkoCYCCtO4bigCKaZeNtHLOT1Qwb1fHUj1aInYj+SaH
 A93w==
X-Gm-Message-State: AOJu0YyekM278u76EW9HTTfJO9p/m3B2VslyXel+04bK2PxCHtLmwOxC
 3smELdhAwihDE210s7eMzUpy0jA+y0zxNHvrQA2ZtH9z6e2QVUcPVHW65suqbCsVSw==
X-Google-Smtp-Source: AGHT+IFs4VDcjVERLxFjTo7m9jtL/S55TAgbigTKem1/xn6CsOwUDKqzmjEC377L9sQhg0F+WYcfIg==
X-Received: by 2002:a17:90a:1783:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2d843dae854mr202300a91.20.1724795612580; 
 Tue, 27 Aug 2024 14:53:32 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613b1f0d5sm12671445a91.55.2024.08.27.14.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 14:53:32 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v3 2/2] plugins: add option to dump write argument to syscall
 plugin
Date: Tue, 27 Aug 2024 14:53:29 -0700
Message-ID: <20240827215329.248434-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827215329.248434-1-rowanbhart@gmail.com>
References: <20240827215329.248434-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst    |  14 ++++-
 tests/tcg/plugins/syscall.c | 117 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index eea1261baa..e85d494ff0 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -388,6 +388,19 @@ run::
   160          1      0
   135          1      0
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Syscall plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - print=true|false
+    - Print the number of times each syscall is called
+  * - log_writes=true|false
+    - Log the buffer of each write syscall in hexdump format
+
 Test inline operations
 ......................
 
@@ -777,4 +790,3 @@ Other emulation features
 When running system emulation you can also enable deterministic
 execution which allows for repeatable record/replay debugging. See
 :ref:`Record/Replay<replay>` for more details.
-
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 72e1a5bf90..7c92f798b5 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -22,8 +22,57 @@ typedef struct {
     int64_t errors;
 } SyscallStats;
 
+struct SyscallInfo {
+    const char *name;
+    int64_t write_sysno;
+};
+
+const struct SyscallInfo arch_syscall_info[] = {
+    { "aarch64", 64 },
+    { "aarch64_be", 64 },
+    { "alpha", 4 },
+    { "arm", 4 },
+    { "armeb", 4 },
+    { "avr", -1 },
+    { "cris", -1 },
+    { "hexagon", 64 },
+    { "hppa", -1 },
+    { "i386", 4 },
+    { "loongarch64", -1 },
+    { "m68k", 4 },
+    { "microblaze", 4 },
+    { "microblazeel", 4 },
+    { "mips", 1 },
+    { "mips64", 1 },
+    { "mips64el", 1 },
+    { "mipsel", 1 },
+    { "mipsn32", 1 },
+    { "mipsn32el", 1 },
+    { "or1k", -1 },
+    { "ppc", 4 },
+    { "ppc64", 4 },
+    { "ppc64le", 4 },
+    { "riscv32", 64 },
+    { "riscv64", 64 },
+    { "rx", -1 },
+    { "s390x", -1 },
+    { "sh4", -1 },
+    { "sh4eb", -1 },
+    { "sparc", 4 },
+    { "sparc32plus", 4 },
+    { "sparc64", 4 },
+    { "tricore", -1 },
+    { "x86_64", 1 },
+    { "xtensa", 13 },
+    { "xtensaeb", 13 },
+    { NULL, -1 },
+};
+
 static GMutex lock;
 static GHashTable *statistics;
+static GByteArray *memory_buffer;
+static bool do_log_writes;
+static int64_t write_sysno = -1;
 
 static SyscallStats *get_or_create_entry(int64_t num)
 {
@@ -39,6 +88,44 @@ static SyscallStats *get_or_create_entry(int64_t num)
     return entry;
 }
 
+/*
+ * Hex-dump a GByteArray to the QEMU plugin output in the format:
+ * 61 63 63 65 6c 09 09 20 20 20 66 70 75 09 09 09  | accel.....fpu...
+ * 20 6d 6f 64 75 6c 65 2d 63 6f 6d 6d 6f 6e 2e 63  | .module-common.c
+ */
+static void hexdump(const GByteArray *data)
+{
+    g_autoptr(GString) out = g_string_new("");
+
+    for (guint index = 0; index < data->len; index += 16) {
+        for (guint col = 0; col < 16; col++) {
+            if (index + col < data->len) {
+                g_string_append_printf(out, "%02x ", data->data[index + col]);
+            } else {
+                g_string_append(out, "   ");
+            }
+        }
+
+        g_string_append(out, " | ");
+
+        for (guint col = 0; col < 16; col++) {
+            if (index + col >= data->len) {
+                break;
+            }
+
+            if (g_ascii_isgraph(data->data[index + col])) {
+                g_string_append_printf(out, "%c", data->data[index + col]);
+            } else {
+                g_string_append(out, ".");
+            }
+        }
+
+        g_string_append(out, "\n");
+    }
+
+    qemu_plugin_outs(out->str);
+}
+
 static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
@@ -54,6 +141,14 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
         g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
         qemu_plugin_outs(out);
     }
+
+    if (do_log_writes && num == write_sysno) {
+        if (qemu_plugin_read_memory_vaddr(a2, memory_buffer, a3)) {
+            hexdump(memory_buffer);
+        } else {
+            fprintf(stderr, "Error reading memory from vaddr %lu\n", a2);
+        }
+    }
 }
 
 static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
@@ -127,6 +222,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_print)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
             }
+        } else if (g_strcmp0(tokens[0], "log_writes") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_log_writes)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+            }
         } else {
             fprintf(stderr, "unsupported argument: %s\n", argv[i]);
             return -1;
@@ -137,6 +236,24 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
     }
 
+    if (do_log_writes) {
+        for (const struct SyscallInfo *syscall_info = arch_syscall_info;
+            syscall_info->name != NULL; syscall_info++) {
+
+            if (g_strcmp0(syscall_info->name, info->target_name) == 0) {
+                write_sysno = syscall_info->write_sysno;
+                break;
+            }
+        }
+
+        if (write_sysno == -1) {
+            fprintf(stderr, "write syscall number not found\n");
+            return -1;
+        }
+
+        memory_buffer = g_byte_array_new();
+    }
+
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.46.0


