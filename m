Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FEC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 09:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7dg-0000HY-PN; Mon, 16 Sep 2024 05:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7dd-00004r-PK
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:03:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7da-0006TX-24
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 05:03:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-375e5c12042so2254272f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726477392; x=1727082192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U65BhC2x8p0opV4eVz/mjZrnRxZWN1usFEftwKCpBYI=;
 b=WfrT7smF8riUJdd/6h145zPnBnuj2TnoIxvE98DCg8xqOd+WjozSpuXmXhIt5z8k0E
 t7wsmzbLmJcAFGk+xGvxKZVvqlrSzvtNCql5wRASvaJOnO1oOJLCkzcpTThYqbqoUxpe
 TThVm+SakRWV+yoeTuEPtl1KxVD186+Z8LzXczxPUT8SkEZXAtzFaU3fqmJEH6QeUDhT
 vr/y7iy9oiSGkYltCb7TVAFFdc+plxm7j2QBTfAbi1VX8iTi2cNWtZkjM1Shs8fMbzT9
 qq0Sjm+Z4IdtDIab/7p3EBM8yKkcVgieIA5PvQH0lIzjFvGBusOK1pM678yg3Ilkypmi
 7Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726477392; x=1727082192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U65BhC2x8p0opV4eVz/mjZrnRxZWN1usFEftwKCpBYI=;
 b=d2/iMhV0oUMltKX4sCCuCwsVCPfF8pcgaM74TEqlr7SJ6uEfCHpsVygbYXMKQD+cxA
 nJ1NfRCi2F6Gf8JKldtvpqihSNfJasSerOPZi+uj+Fey/c0KXhzM8/1mh+URWPNKG8II
 CUhOlNfYAEEScqImM/t+e7wAQ72jKKm9cL4+HHhFJghhtyC3T8nKFtP9r2MFUCdngoLW
 uVrrEy7cdzEvJy/lxZ/CxVBFHgMeV+DEsrm0GR+YUWDIPwVzMjSLx3VMiNVFuQLfN7nn
 nSuzDf+m6fo5W/bpjt9kIrXKm0fFLDhRZfYweA4hJ00kGmrIDFndk1uQlaN2sHfEVBNK
 pcSA==
X-Gm-Message-State: AOJu0YyexnCwluaX7Q2h9Jqz5lsQqLcLSif94RbPfyLcdgCmXx7AodAH
 wp7a8x3pgVym2gCkT74ZNsfS3m+EIJsfcLJUP0VAa30XO/iCrrLJA2HGJsKw+fE=
X-Google-Smtp-Source: AGHT+IEUj37DLR+apiOF1A7V6eetNxiNCZIuQGst+RyRSXUppdiifzsC75DC4PmH9Xtjo6lmJwJWnw==
X-Received: by 2002:adf:fc0a:0:b0:371:8c61:577c with SMTP id
 ffacd0b85a97d-378c2d121c0mr7853546f8f.26.1726477392184; 
 Mon, 16 Sep 2024 02:03:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780015dsm6635115f8f.69.2024.09.16.02.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:03:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1A375FCE4;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v2 17/18] plugins: add option to dump write argument to
 syscall plugin
Date: Mon, 16 Sep 2024 09:53:59 +0100
Message-Id: <20240916085400.1046925-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240827215329.248434-3-rowanbhart@gmail.com>
[AJB: tweak fmt string for vaddr]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
vAJB
  - tweak fmt string for PRIu64
v2
  - add static to arch_syscall_info
---
 docs/about/emulation.rst    |  14 ++++-
 tests/tcg/plugins/syscall.c | 117 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a4470127c9..23e4949049 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -418,6 +418,19 @@ run::
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
 
@@ -807,4 +820,3 @@ Other emulation features
 When running system emulation you can also enable deterministic
 execution which allows for repeatable record/replay debugging. See
 :ref:`Record/Replay<replay>` for more details.
-
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 72e1a5bf90..89dc7f49b1 100644
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
+static const struct SyscallInfo arch_syscall_info[] = {
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
+            fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n", a2);
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
2.39.5


