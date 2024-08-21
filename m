Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B351C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 05:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh0cq-0001IB-4U; Thu, 22 Aug 2024 01:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sgvC2-0008CC-Tg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 19:56:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1sgvC0-0007C0-LV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 19:56:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7142a93ea9cso184937b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724284602; x=1724889402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BSlovGKbIVaMGWNTrwmK7VUQWMwDBNdqvUfZfNyrhCA=;
 b=P+3LqxEQs+b7LNobMkw1+NVG/lI6oOPJ24cewBF4aXKUeS7m4Uhb/kPLsCuuNQaxoe
 st4nMk6dpP6nYXWJDbzJXTOK4hNnMObMxXDqpBlYEg2Hg96eTf6H87A1RtXAwvvh7qml
 EYLUmZuebQNR53mYLwChVyxrCfTsjy77XsIKIhIUVvgHuRCHspSvcht5AB6+nb3bLPeK
 2MYmtVFhqhC3E+qsZfMBoFtIx3A4iygPZDBhX7IlePEUG8UDFbkYgV7PGST+z8vK4gHg
 ym0q107Tt8SkQTfv4ZuMGiN6cTG7+y3Y4S0VUNsS7BIfcDfYjls6w5VMKbyIEAYxM6Pw
 jnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724284602; x=1724889402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSlovGKbIVaMGWNTrwmK7VUQWMwDBNdqvUfZfNyrhCA=;
 b=NCnxXxRFqo1reiMryNL5X3vwRRRumHyKwErLIu2+/jbHwjA1mVgnSvPd9uKCVBw2Hb
 qdsNPtOKPjRgzIB0BCHEihNyg1Nt+0Zkv0w+gKN4qQbWjPUvwDnwo0EjeTNjZPGHfKTq
 tScrvHk420MYR40TOuyf0Qy//LQV4dTGtsIXhnhb4rqCEllCfpgx99y1umcrFexNoUKb
 j0NrBW0mS+hIwuKhVgzAZL36t+dZqFr34/9odx1qLnJhBHOAII1eTkSSJDG6G0vccvK8
 JxZHG5AVO+w8Z+m4e8ePL53nd8vps6EJe4PcdmLjo1lGCgvWwxnO5l1afu/6QkJZDPqh
 Vruw==
X-Gm-Message-State: AOJu0YzSK52SMRA2A8vtISZdyhzZ8OtmYhjC1QaYJqu346XOHkC//6Hk
 TsbB229GUoqimgX2UlnbamY2z79/1CZjYjhqJ4X2gWNWL2ntFpXWp6eAiIEh7EM=
X-Google-Smtp-Source: AGHT+IFkzsylsNme1QiR1T6Tw+r8MCWYzqsu+yzwEOqlvh3nE+u2sxM8TpSYOMB2RSTbGIVZVUI0eA==
X-Received: by 2002:a05:6a00:1408:b0:70d:3938:f1a5 with SMTP id
 d2e1a72fcca58-71423570b24mr4945452b3a.22.1724284602207; 
 Wed, 21 Aug 2024 16:56:42 -0700 (PDT)
Received: from chaos.lan ([50.46.173.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430613asm209141b3a.155.2024.08.21.16.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 16:56:41 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] plugins: add plugin API to read guest memory
Date: Wed, 21 Aug 2024 16:56:07 -0700
Message-ID: <20240821235607.208622-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Aug 2024 01:44:43 -0400
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
---
 docs/about/emulation.rst     |  16 ++++-
 include/qemu/qemu-plugin.h   |  24 +++++++-
 plugins/api.c                |  21 +++++++
 plugins/qemu-plugins.symbols |   1 +
 tests/tcg/plugins/mem.c      |  37 +++++++++++-
 tests/tcg/plugins/syscall.c  | 113 +++++++++++++++++++++++++++++++++++
 6 files changed, 208 insertions(+), 4 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index eea1261baa..9c68e37887 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -354,6 +354,8 @@ Behaviour can be tweaked with the following arguments:
     - Use callbacks on each memory instrumentation.
   * - hwaddr=true|false
     - Count IO accesses (only for system emulation)
+  * - read=true|false
+    - Read the memory content of each access and display it
 
 System Calls
 ............
@@ -388,6 +390,19 @@ run::
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
 
@@ -777,4 +792,3 @@ Other emulation features
 When running system emulation you can also enable deterministic
 execution which allows for repeatable record/replay debugging. See
 :ref:`Record/Replay<replay>` for more details.
-
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c71c705b69..d4ec73574b 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -57,11 +57,19 @@ typedef uint64_t qemu_plugin_id_t;
  * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
  *   Those functions are replaced by *_per_vcpu variants, which guarantee
  *   thread-safety for operations.
+ *
+ * version 3:
+ * - modified arguments and return value of qemu_plugin_insn_data to copy
+ *   the data into a user-provided buffer instead of returning a pointer
+ *   to the data.
+ *
+ * version 4:
+ * - added qemu_plugin_read_memory_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 3
+#define QEMU_PLUGIN_VERSION 4
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -852,6 +860,20 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
+ *
+ * @addr: A virtual address to read from
+ * @len: The number of bytes to read, starting from @addr
+ *
+ * Returns a GByteArray with the read memory. Ownership of the GByteArray is
+ * transferred to the caller, which is responsible for deallocating it after
+ * use. On failure returns NULL.
+ */
+QEMU_PLUGIN_API
+GByteArray *qemu_plugin_read_memory_vaddr(uint64_t addr,
+                                          size_t len);
+
 /**
  * qemu_plugin_read_register() - read register for current vCPU
  *
diff --git a/plugins/api.c b/plugins/api.c
index 2ff13d09de..f210ca166a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -527,6 +527,27 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+GByteArray *qemu_plugin_read_memory_vaddr(vaddr addr, size_t len)
+{
+    g_assert(current_cpu);
+
+    if (len == 0) {
+        return NULL;
+    }
+
+    GByteArray *buf = g_byte_array_sized_new(len);
+    g_byte_array_set_size(buf, len);
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, buf->data, buf->len, 0);
+
+    if (result < 0) {
+        g_byte_array_unref(buf);
+        return NULL;
+    }
+
+    return buf;
+}
+
 int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index ca773d8d9f..3ad479a924 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -20,6 +20,7 @@
   qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_memory_vaddr;
   qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b650dddcce..c65d48680b 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -24,7 +24,7 @@ typedef struct {
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback;
+static bool do_inline, do_callback, do_read;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
@@ -58,6 +58,30 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     } else {
         qemu_plugin_u64_add(mem_count, cpu_index, 1);
     }
+
+    if (do_read) {
+        size_t size = qemu_plugin_mem_size_shift(meminfo);
+        GByteArray *data = qemu_plugin_read_memory_vaddr(vaddr, size);
+
+        if (data) {
+            g_autoptr(GString) out = g_string_new("");
+
+            if (qemu_plugin_mem_is_store(meminfo)) {
+                g_string_append(out, "store: ");
+            } else {
+                g_string_append(out, "load: ");
+            }
+
+            g_string_append_printf(out, "vaddr: 0x%" PRIx64 " data: 0x",
+                                   vaddr);
+            for (size_t i = 0; i < data->len; i++) {
+                g_string_append_printf(out, "%02x", data->data[i]);
+            }
+            g_string_append(out, "\n");
+            qemu_plugin_outs(out->str);
+            g_byte_array_free(data, TRUE);
+        }
+    }
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -86,7 +110,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -117,6 +140,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "read") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_read)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -129,6 +157,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         return -1;
     }
 
+    if (do_read && !do_callback) {
+        fprintf(stderr, "can't enable memory reading without callback\n");
+        return -1;
+    }
+
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 72e1a5bf90..67c7c404c4 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -22,8 +22,56 @@ typedef struct {
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
+static bool do_log_writes;
+static int64_t write_sysno = -1;
 
 static SyscallStats *get_or_create_entry(int64_t num)
 {
@@ -54,6 +102,51 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
         g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
         qemu_plugin_outs(out);
     }
+
+    if (do_log_writes && num == write_sysno) {
+        GByteArray *data = qemu_plugin_read_memory_vaddr(a2, a3);
+
+        g_autoptr(GString) out = g_string_new("");
+
+        size_t rows = (data->len % 16 == 0)
+            ? (data->len / 16)
+            : ((data->len / 16) + 1);
+        for (size_t row = 0; row < rows; row++) {
+            size_t len = (rows != data->len / 16 && row == rows - 1)
+                ? (data->len % 16)
+                : 16;
+            for (size_t i = 0; i < len; i++) {
+                g_string_append_printf(out, "%02x ",
+                    data->data[(row * 16) + i]);
+                if (i != 0 && i % 4 == 0) {
+                    g_string_append(out, " ");
+                }
+            }
+            for (size_t i = len; i < 16; i++) {
+                g_string_append(out, "   ");
+                if (i != 0 && i % 4 == 0) {
+                    g_string_append(out, " ");
+                }
+            }
+            g_string_append(out, " | ");
+            for (size_t i = 0; i < len; i++) {
+                g_string_append_printf(out,
+                    (data->data[(row * 16) + i] >= 0x21
+                        && data->data[(row * 16) + i] <= 0x7e)
+                    ? "%c"
+                    : ".", data->data[(row * 16) + i]);
+                if (i != 0 && i % 4 == 0) {
+                    g_string_append(out, " ");
+                }
+            }
+            g_string_append(out, "\n");
+        }
+
+
+        qemu_plugin_outs(out->str);
+
+        g_byte_array_free(data, TRUE);
+    }
 }
 
 static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
@@ -127,6 +220,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
@@ -137,6 +234,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
+    }
+
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.46.0


