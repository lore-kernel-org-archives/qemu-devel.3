Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F6CA1003
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk3VE-0004Zl-MQ; Fri, 30 Aug 2024 11:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sk3VD-0004Yo-7k
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:25:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sk3VA-0007nN-G6
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 11:25:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9ae3665so2062332a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725031527; x=1725636327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r9QaAjsoS3eppOIkMgFN2T9U8ZNkaLBrRjxrNBIHJE=;
 b=z50Ic66yEGwkg6hmiQkFCSte5TqUTHL4e98eOhRhrRVvIlSUsjIv3V6dx1hNyu1tLK
 t+YiIReHTA5aINDIVJsLgz12p6SjDXWbT6NwUB3gl5h/xrleQ1lHMo8liC5VdemMhq7S
 2GVgMfRalp3Pn5q3nsZXoVRGbCvSGxfRYBAv5CUsU9c3R5X86xP2t2NXVCxLr1CtONxo
 wgFWskhQBeomkbeEwfvLlBpYpRcGhYaGrlWuC2DPvd/lzdPr62dG77Dyl2B8L1JY2Img
 3BSw5C+FGMcQ0g7NmMZfQBnGeOsIeielw4lH2eovfDpIeCGG0dxLJFqhWpCYN1HHkZ2A
 T/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725031527; x=1725636327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7r9QaAjsoS3eppOIkMgFN2T9U8ZNkaLBrRjxrNBIHJE=;
 b=RrVz3E1/cFcTFsLYS3rd0l4wPH3kS646kUcY4ejtYOmyBms9ruuB+pyuqW2vWCuX9B
 XP3qFu2FQee4unm+W9mxpVyyHWjHyFj1efa8f+NNGUgaoKM1rFva/2V3tFsyZc3l+uVb
 Shojd3UMf+Av4SpdU9WzRtUdWIpNSx+VT24v0kYctel1RLqP6vBwq72DJgaN3Blfg+CX
 g3u2Wts6mnCYOfV8cm+24NFB96EjJXvAlDx377//22vn0KLj7cGcRUp8WmWwrB3J1PV7
 B210AqNwzTW1XHl3X2x7qlmaEjFN9Vv5grI7IudVsFnKHKDAipYzJ4FeXtP62jEhPkgl
 HoeQ==
X-Gm-Message-State: AOJu0YwiVRktOT/+PDqOCMZa1dcX2JWHYg5AeDD5YDswy1oIYbQhLj17
 iLovPdgtsHX1VybSk9NRVSardQKPhf8guVsm1f7pbGMMlv+u2O17aPtaUPQIq0s=
X-Google-Smtp-Source: AGHT+IGNeOksIXptb7CVc6ucooPsrib89z6BjC9bDWmSMFkQfS6ZdSI5mmJnCaQP/O4uAMHdNvAkVg==
X-Received: by 2002:a05:6402:3204:b0:5a3:3cfd:26f7 with SMTP id
 4fb4d7f45d1cf-5c21ed98a9fmr6133543a12.32.1725031526070; 
 Fri, 30 Aug 2024 08:25:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226ce4fc4sm2117588a12.85.2024.08.30.08.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:25:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 779285F8AB;
 Fri, 30 Aug 2024 16:25:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH] tests/tcg: add a system test to check memory
 instrumentation
Date: Fri, 30 Aug 2024 16:25:07 +0100
Message-Id: <20240830152507.3026275-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87jzfz3dlf.fsf@draig.linaro.org>
References: <87jzfz3dlf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

At first I thought I could compile the user-mode test for system mode
however we already have a fairly comprehensive test case for system
mode in "memory" so lets use that.

First we extend the test to report where the test_data region is. Then
we expand the pdot() function to track the total number of reads and
writes to the region. We have to add some addition pdot() calls to
take into account multiple reads/writes in the test loops.

As tracking every access will quickly build up with "print-access" we
add a new mode to track groups of reads and writes to pages. Because
the test_data is page aligned we can be sure all accesses to it are
ones we can count.

Finally we add a python script to integrate the data from the plugin
and the output of the test and validate they both agree on the total
counts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/system/memory.c           |  48 +++++---
 tests/tcg/plugins/mem.c                       |  79 ++++++++++++-
 .../multiarch/system/Makefile.softmmu-target  |   6 +
 .../system/validate-memory-counts.py          | 108 ++++++++++++++++++
 4 files changed, 224 insertions(+), 17 deletions(-)
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 6eb2eb16f7..335ecbd7f0 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -14,12 +14,16 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <inttypes.h>
 #include <minilib.h>
 
 #ifndef CHECK_UNALIGNED
 # error "Target does not specify CHECK_UNALIGNED"
 #endif
 
+uint32_t test_read_count;
+uint32_t test_write_count;
+
 #define MEM_PAGE_SIZE 4096             /* nominal 4k "pages" */
 #define TEST_SIZE (MEM_PAGE_SIZE * 4)  /* 4 pages */
 
@@ -32,8 +36,13 @@ typedef void (*init_ufn) (int offset);
 typedef bool (*read_ufn) (int offset);
 typedef bool (*read_sfn) (int offset, bool nf);
 
-static void pdot(int count)
+static void pdot(int count, bool write)
 {
+    if (write) {
+        test_write_count++;
+    } else {
+        test_read_count++;
+    }
     if (count % 128 == 0) {
         ml_printf(".");
     }
@@ -66,7 +75,7 @@ static void init_test_data_u8(int unused_offset)
     ml_printf("Filling test area with u8:");
     for (i = 0; i < TEST_SIZE; i++) {
         *ptr++ = BYTE_NEXT(count);
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done\n");
 }
@@ -91,8 +100,9 @@ static void init_test_data_s8(bool neg_first)
               neg_first ? "neg first" : "pos first");
     for (i = 0; i < TEST_SIZE / 2; i++) {
         *ptr++ = get_byte(i, neg_first);
+        pdot(i, true);
         *ptr++ = get_byte(i, !neg_first);
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done\n");
 }
@@ -107,6 +117,7 @@ static void reset_start_data(int offset)
     int i;
     for (i = 0; i < offset; i++) {
         *ptr++ = 0;
+        pdot(i, true);
     }
 }
 
@@ -125,7 +136,7 @@ static void init_test_data_u16(int offset)
         uint16_t low = BYTE_NEXT(count), high = BYTE_NEXT(count);
         word = BYTE_SHIFT(high, 1) | BYTE_SHIFT(low, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done @ %p\n", ptr);
 }
@@ -147,7 +158,7 @@ static void init_test_data_u32(int offset)
         word = BYTE_SHIFT(b1, 3) | BYTE_SHIFT(b2, 2) | BYTE_SHIFT(b3, 1) |
                BYTE_SHIFT(b4, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done @ %p\n", ptr);
 }
@@ -172,7 +183,7 @@ static void init_test_data_u64(int offset)
                BYTE_SHIFT(b4, 4) | BYTE_SHIFT(b5, 3) | BYTE_SHIFT(b6, 2) |
                BYTE_SHIFT(b7, 1) | BYTE_SHIFT(b8, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done @ %p\n", ptr);
 }
@@ -194,7 +205,7 @@ static bool read_test_data_u16(int offset)
             ml_printf("Error %d < %d\n", high, low);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
 
     }
@@ -236,7 +247,7 @@ static bool read_test_data_u32(int offset)
             ml_printf("Error %d, %d, %d, %d", b1, b2, b3, b4);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
     }
     ml_printf("done @ %p\n", ptr);
@@ -290,7 +301,7 @@ static bool read_test_data_u64(int offset)
                       b1, b2, b3, b4, b5, b6, b7, b8);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
     }
     ml_printf("done @ %p\n", ptr);
@@ -357,9 +368,11 @@ static bool read_test_data_s8(int offset, bool neg_first)
         second = *ptr++;
 
         if (neg_first && first < 0 && second > 0) {
-            pdot(i);
+            pdot(i, false);
+            pdot(i, false);
         } else if (!neg_first && first > 0 && second < 0) {
-            pdot(i);
+            pdot(i, false);
+            pdot(i, false);
         } else {
             ml_printf("Error %d %c %d\n", first, neg_first ? '<' : '>', second);
             return false;
@@ -390,9 +403,9 @@ static bool read_test_data_s16(int offset, bool neg_first)
         int32_t data = *ptr++;
 
         if (neg_first && data < 0) {
-            pdot(i);
+            pdot(i, false);
         } else if (!neg_first && data > 0) {
-            pdot(i);
+            pdot(i, false);
         } else {
             ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
             return false;
@@ -423,9 +436,9 @@ static bool read_test_data_s32(int offset, bool neg_first)
         int64_t data = *ptr++;
 
         if (neg_first && data < 0) {
-            pdot(i);
+            pdot(i, false);
         } else if (!neg_first && data > 0) {
-            pdot(i);
+            pdot(i, false);
         } else {
             ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
             return false;
@@ -475,6 +488,9 @@ int main(void)
     int i;
     bool ok = true;
 
+    ml_printf("Test data start: 0x%"PRIxPTR"\n", &test_data[0]);
+    ml_printf("Test data end: 0x%"PRIxPTR"\n", &test_data[TEST_SIZE]);
+
     /* Run through the unsigned tests first */
     for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
         ok = do_unsigned_test(init_ufns[i]);
@@ -490,6 +506,8 @@ int main(void)
         ok = do_signed_reads(true);
     }
 
+    ml_printf("Test data read: %"PRId32"\n", test_read_count);
+    ml_printf("Test data write: %"PRId32"\n", test_write_count);
     ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
     return ok ? 0 : -1;
 }
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 086e6f5bdf..f9a2ab4c13 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -26,13 +26,27 @@ typedef struct {
     const char *sym;
 } InsnInfo;
 
+typedef struct {
+    uint64_t page_address;
+    uint64_t reads;
+    uint64_t read_bytes;
+    uint64_t writes;
+    uint64_t written_bytes;
+} PageInfo;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback, do_print_accesses;
+static bool do_inline, do_callback, do_print_accesses, do_page_summary;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
+static uint64_t page_size = 4096;
+static uint64_t page_mask;
+
+static GMutex lock;
+static GHashTable *pages;
+
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
@@ -46,6 +60,31 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                qemu_plugin_u64_sum(io_count));
     }
     qemu_plugin_outs(out->str);
+
+
+    if (do_page_summary) {
+        GList *counts = g_hash_table_get_values(pages);
+
+        g_string_printf(out, "PageAddr, Reads, Read Bytes, Writes, Write Bytes\n");
+
+        if (counts && g_list_next(counts)) {
+            for (/* counts */; counts->next; counts = counts->next) {
+                PageInfo *pi = (PageInfo *) counts->data;
+
+                g_string_append_printf(out,
+                                       "0x%016"PRIx64", "
+                                       "%"PRId64", %"PRId64", "
+                                       "%"PRId64", %"PRId64"\n",
+                                       pi->page_address,
+                                       pi->reads,
+                                       pi->read_bytes,
+                                       pi->writes,
+                                       pi->written_bytes);
+            }
+        }
+        qemu_plugin_outs(out->str);
+    }
+
     qemu_plugin_scoreboard_free(counts);
 }
 
@@ -63,6 +102,31 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     } else {
         qemu_plugin_u64_add(mem_count, cpu_index, 1);
     }
+
+    if (do_page_summary) {
+        uint64_t page = vaddr & ~page_mask;
+        PageInfo *pi;
+        unsigned size = 8 << qemu_plugin_mem_size_shift(meminfo);
+
+        g_mutex_lock(&lock);
+        pi = (PageInfo *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+
+        if (!pi) {
+            pi = g_new0(PageInfo, 1);
+            pi->page_address = page;
+            g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) pi);
+        }
+
+        if (qemu_plugin_mem_is_store(meminfo)) {
+            pi->writes++;
+            pi->written_bytes += size;
+        } else {
+            pi->reads++;
+            pi->read_bytes += size;
+        }
+
+        g_mutex_unlock(&lock);
+    }
 }
 
 static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -117,7 +181,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                 QEMU_PLUGIN_INLINE_ADD_U64,
                 mem_count, 1);
         }
-        if (do_callback) {
+        if (do_callback || do_page_summary) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
                                              QEMU_PLUGIN_CB_NO_REGS,
                                              rw, NULL);
@@ -176,6 +240,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "page-summary") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &do_page_summary)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -196,6 +266,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         qemu_plugin_outs(out->str);
     }
 
+    if (do_page_summary) {
+        page_mask = (page_size - 1);
+        pages = g_hash_table_new(NULL, g_direct_equal);
+    }
+
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 32dc0f9830..a1b33a6973 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -65,3 +65,9 @@ endif
 
 MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
 	run-gdbstub-untimely-packet run-gdbstub-registers
+
+# Test plugin memory access instrumentation
+run-plugin-memory-with-libmem.so: 		\
+	PLUGIN_ARGS=$(COMMA)page-summary=true
+run-plugin-memory-with-libmem.so: 		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
diff --git a/tests/tcg/multiarch/system/validate-memory-counts.py b/tests/tcg/multiarch/system/validate-memory-counts.py
new file mode 100755
index 0000000000..8c18bff066
--- /dev/null
+++ b/tests/tcg/multiarch/system/validate-memory-counts.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+#
+# validate-memory-counts.py: check we instrumented memory properly
+#
+# This program takes two inputs:
+#   - the mem plugin output
+#   - the memory binary output
+#
+# Copyright (C) 2024 Linaro Ltd
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+
+def extract_counts(path):
+    """
+    Load the output from path and extract the lines containing:
+
+      Test data start: 0x40214000
+      Test data end: 0x40218001
+      Test data read: 2522280
+      Test data write: 262111
+
+    From the stream of data. Extract the values for use in the
+    validation function.
+    """
+    start_address = None
+    end_address = None
+    read_count = 0
+    write_count = 0
+    with open(path, 'r') as f:
+        for line in f:
+            if line.startswith("Test data start:"):
+                start_address = int(line.split(':')[1].strip(), 16)
+            elif line.startswith("Test data end:"):
+                end_address = int(line.split(':')[1].strip(), 16)
+            elif line.startswith("Test data read:"):
+                read_count = int(line.split(':')[1].strip())
+            elif line.startswith("Test data write:"):
+                write_count = int(line.split(':')[1].strip())
+    return start_address, end_address, read_count, write_count
+
+
+def parse_plugin_output(path, start, end):
+    """
+    Load the plugin output from path in the form of:
+
+      PageAddr, Reads, Read Bytes, Writes, Write Bytes
+      0x0000000040214000, 630296, 15719488, 69700, 1116480
+      0x0000000040201000, 0, 0, 2, 128
+      0x0000000040215000, 630784, 15728640, 69632, 1114112
+
+    And extract the ranges that match test data start and end and
+    return the results.
+    """
+    total_reads = 0
+    total_read_bytes = 0
+    total_writes = 0
+    total_written_bytes = 0
+
+    with open(path, 'r') as f:
+        next(f)  # Skip the header
+        for line in f:
+            parts = line.strip().split(', ')
+            if len(parts) != 5:
+                continue
+            page_addr = int(parts[0], 16)
+            reads = int(parts[1])
+            read_bytes = int(parts[2])
+            writes = int(parts[3])
+            written_bytes = int(parts[4])
+            if start <= page_addr < end: # Checking if within range
+                total_reads += reads
+                total_read_bytes += read_bytes
+                total_writes += writes
+                total_written_bytes += written_bytes
+
+    return total_reads, total_read_bytes, total_writes, total_written_bytes
+
+def main():
+    if len(sys.argv) != 3:
+        print("Usage: <script_name>.py <memory_binary_output_path> <mem_plugin_output_path>")
+        sys.exit(1)
+
+    memory_binary_output_path = sys.argv[1]
+    mem_plugin_output_path = sys.argv[2]
+
+    # Extract counts from memory binary
+    start, end, expected_reads, expected_writes = extract_counts(memory_binary_output_path)
+
+    if start is None or end is None:
+        print("Failed to extract start or end address from memory binary output.")
+        sys.exit(1)
+
+    # Parse plugin output
+    actual_reads, actual_read_bytes, actual_writes, actual_written_bytes = parse_plugin_output(mem_plugin_output_path, start, end)
+
+    # Compare and report
+    if actual_reads == expected_reads and actual_writes == expected_writes:
+        sys.exit(0)
+    else:
+        print("Fail: The memory reads and writes count does not match.")
+        print(f"Expected Reads: {expected_reads}, Actual Reads: {actual_reads}")
+        print(f"Expected Writes: {expected_writes}, Actual Writes: {actual_writes}")
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.39.2


