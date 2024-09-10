Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700F3ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1d3-00030i-I2; Tue, 10 Sep 2024 10:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1d1-0002jy-6J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:59 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1cx-0007Ub-Qh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:58 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso1351701fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977634; x=1726582434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zroaak8xFFAJBnGJiz25P6JCeHv1e5w1wtwssc9iSGg=;
 b=HhONXx0xTryf6DjGZNASbMK047t84N9O8UJKqZCuUYU19vA8j0NS8xF/tVVu5+SI5P
 R1QOJeTk0J6IQL3IJfYQTFd4f+U8a1bB5ZUKL/H/MviOEpBhp7uFaGG5/boe+DEY8F6v
 Hp9SkSjpimURxO8iHN8lmd+HLS4RFmTOXuhDmTPMJCnHzrNUttDqQZStEt3hTeCr5krC
 tM6DKh2Q7l5/m5V3VwZrhxDfcGF92CrhWIAFttVOjHR8mKC960suk2AXVbykLe31hKPw
 YfCjghMQo799RitKPgSUqR77UQa9E7VFk3Y2C676pBKCxhD7dkSBapWGQmHjrVEa4RTG
 4K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977634; x=1726582434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zroaak8xFFAJBnGJiz25P6JCeHv1e5w1wtwssc9iSGg=;
 b=wOYan0oF/eMlZ86FAOVZLOP+kSZKuLl5wjBo3J41+uLv9YX7EcmW6hqzB+rXhYvnky
 INcOQL/uxsODGUEwJwyuVgW761S2BNmpHbZH9bIkraaKTrAIJxflW+V34kIXG5bCJR5V
 GjNch1RdfRGyVjRPb4ioq/nFj7Bi55zHxr+8kuXMYRFMb+0jNIRS67xkXkZRABBd2UhJ
 FYB2fZjWvvDEs0J4TM1e6vQWNdRZHd5P+ytl8MZI0szW5c3KUdNW9zRHJTlG2Vm69Foo
 9y0GnBYQKbxaYEw7TSduVJfDsLXp2Bt8jFs/CdFkx+y1ZrTT4UWrX8OjfEisRwZur0gb
 dzfg==
X-Gm-Message-State: AOJu0YxYlZKnLHuDm/vN5ZrNKvI7PlrNJ+kjyX0zZARybn3npkKgDJm9
 bBuiWJizGWVeZk7AleJuKyiMnlzJUvWWg1atQFc83hfn09eiIPLq/guZZG4ziPo=
X-Google-Smtp-Source: AGHT+IGsJkcb234kPMUwzZHCkiUcDRpmtSNvGnEqJULGzYtF86etGrETcfSgYxqk0A37XstmKdzd3g==
X-Received: by 2002:a2e:b88a:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2f75a96c43bmr108676401fa.3.1725977633258; 
 Tue, 10 Sep 2024 07:13:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2597a660sm485506266b.75.2024.09.10.07.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF45F5F78C;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 21/26] tests/tcg: add a system test to check memory
 instrumentation
Date: Tue, 10 Sep 2024 15:07:28 +0100
Message-Id: <20240910140733.4007719-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
add a new mode to track groups of reads and writes to regions. Because
the test_data is page aligned we can be sure all accesses to it are
ones we can count.

Finally we add a python script to integrate the data from the plugin
and the output of the test and validate they both agree on the total
counts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - aggressively align test_data on "region size"
  - sort the regions in the final report
  - ensure alpha-softmmu uses byte access when it can
---
 tests/tcg/multiarch/system/memory.c           |  50 +++--
 tests/tcg/plugins/mem.c                       | 178 +++++++++++++++++-
 tests/tcg/alpha/Makefile.softmmu-target       |   2 +-
 .../multiarch/system/Makefile.softmmu-target  |   6 +
 .../system/validate-memory-counts.py          | 115 +++++++++++
 5 files changed, 332 insertions(+), 19 deletions(-)
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 680dd4800b..ccff699015 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -14,26 +14,35 @@
 
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
 
 #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])))
 
-__attribute__((aligned(MEM_PAGE_SIZE)))
+__attribute__((aligned(TEST_SIZE)))
 static uint8_t test_data[TEST_SIZE];
 
 typedef void (*init_ufn) (int offset);
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
@@ -67,7 +76,7 @@ static void init_test_data_u8(int unused_offset)
 
     for (i = 0; i < TEST_SIZE; i++) {
         *ptr++ = BYTE_NEXT(count);
-        pdot(i);
+        pdot(i, true);
     }
 
     ml_printf("done %d @ %p\n", i, ptr);
@@ -93,8 +102,9 @@ static void init_test_data_s8(bool neg_first)
               neg_first ? "neg first" : "pos first");
     for (i = 0; i < TEST_SIZE / 2; i++) {
         *ptr++ = get_byte(i, neg_first);
+        pdot(i, true);
         *ptr++ = get_byte(i, !neg_first);
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done %d @ %p\n", i * 2, ptr);
 }
@@ -116,6 +126,7 @@ static void reset_start_data(int offset)
 
     for (i = 0; i < offset; i++) {
         *ptr++ = 0;
+        pdot(i, true);
     }
 
     ml_printf("done %d @ %p\n", i, ptr);
@@ -136,7 +147,7 @@ static void init_test_data_u16(int offset)
         uint16_t low = BYTE_NEXT(count), high = BYTE_NEXT(count);
         word = BYTE_SHIFT(high, 1) | BYTE_SHIFT(low, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done %d @ %p\n", i, ptr);
 }
@@ -158,7 +169,7 @@ static void init_test_data_u32(int offset)
         word = BYTE_SHIFT(b1, 3) | BYTE_SHIFT(b2, 2) | BYTE_SHIFT(b3, 1) |
                BYTE_SHIFT(b4, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done %d @ %p\n", i, ptr);
 }
@@ -184,7 +195,7 @@ static void init_test_data_u64(int offset)
                BYTE_SHIFT(b4, 4) | BYTE_SHIFT(b5, 3) | BYTE_SHIFT(b6, 2) |
                BYTE_SHIFT(b7, 1) | BYTE_SHIFT(b8, 0);
         *ptr++ = word;
-        pdot(i);
+        pdot(i, true);
     }
     ml_printf("done %d @ %p\n", i, ptr);
 }
@@ -207,7 +218,7 @@ static bool read_test_data_u16(int offset)
             ml_printf("Error %d < %d\n", high, low);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
 
     }
@@ -249,7 +260,7 @@ static bool read_test_data_u32(int offset)
             ml_printf("Error %d, %d, %d, %d", b1, b2, b3, b4);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
     }
     ml_printf("done %d @ %p\n", i, ptr);
@@ -304,7 +315,7 @@ static bool read_test_data_u64(int offset)
                       b1, b2, b3, b4, b5, b6, b7, b8);
             return false;
         } else {
-            pdot(i);
+            pdot(i, false);
         }
     }
     ml_printf("done %d @ %p\n", i, ptr);
@@ -376,9 +387,11 @@ static bool read_test_data_s8(int offset, bool neg_first)
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
@@ -409,9 +422,9 @@ static bool read_test_data_s16(int offset, bool neg_first)
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
@@ -442,9 +455,9 @@ static bool read_test_data_s32(int offset, bool neg_first)
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
@@ -498,6 +511,9 @@ int main(void)
     int i;
     bool ok = true;
 
+    ml_printf("Test data start: 0x%"PRIxPTR"\n", &test_data[0]);
+    ml_printf("Test data end: 0x%"PRIxPTR"\n", &test_data[TEST_SIZE]);
+
     /* Run through the unsigned tests first */
     for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
         ok = do_unsigned_test(init_ufns[i]);
@@ -513,6 +529,8 @@ int main(void)
         ok = do_signed_reads(true);
     }
 
+    ml_printf("Test data read: %"PRId32"\n", test_read_count);
+    ml_printf("Test data write: %"PRId32"\n", test_write_count);
     ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
     return ok ? 0 : -1;
 }
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 086e6f5bdf..42d735d5c8 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <endian.h>
 #include <stdio.h>
 #include <glib.h>
 
@@ -26,13 +27,46 @@ typedef struct {
     const char *sym;
 } InsnInfo;
 
+/*
+ * For the "memory" system test we need to track accesses to
+ * individual regions. We mirror the data written to the region and
+ * then check when it is read that it matches up.
+ *
+ * We do this as regions rather than pages to save on complications
+ * with page crossing and the fact the test only cares about the
+ * test_data region.
+ */
+static uint64_t region_size = 4096 * 4;
+static uint64_t region_mask;
+
+typedef struct {
+    uint64_t region_address;
+    uint64_t reads;
+    uint64_t writes;
+    uint8_t *data;
+    bool     seen_all;  /* Did we see every write and read with correct values? */
+} RegionInfo;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback, do_print_accesses;
+static bool do_inline, do_callback, do_print_accesses, do_region_summary;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
+
+static GMutex lock;
+static GHashTable *regions;
+
+static gint addr_order(gconstpointer a, gconstpointer b)
+{
+    RegionInfo *na = (RegionInfo *) a;
+    RegionInfo *nb = (RegionInfo *) b;
+
+    return na->region_address > nb->region_address ? 1 : -1;
+}
+
+
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
@@ -46,9 +80,129 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                qemu_plugin_u64_sum(io_count));
     }
     qemu_plugin_outs(out->str);
+
+
+    if (do_region_summary) {
+        GList *counts = g_hash_table_get_values(regions);
+
+        counts = g_list_sort(counts, addr_order);
+
+        g_string_printf(out, "Region Base, Reads, Writes, Seen all\n");
+
+        if (counts && g_list_next(counts)) {
+            for (/* counts */; counts->next; counts = counts->next) {
+                RegionInfo *ri = (RegionInfo *) counts->data;
+
+                g_string_append_printf(out,
+                                       "0x%016"PRIx64", "
+                                       "%"PRId64", %"PRId64", %s\n",
+                                       ri->region_address,
+                                       ri->reads,
+                                       ri->writes,
+                                       ri->seen_all ? "true" : "false");
+            }
+        }
+        qemu_plugin_outs(out->str);
+    }
+
     qemu_plugin_scoreboard_free(counts);
 }
 
+/*
+ * Update the region tracking info for the access. We split up accesses
+ * that span regions even though the plugin infrastructure will deliver
+ * it as a single access.
+ */
+static void update_region_info(uint64_t region, uint64_t offset,
+                               qemu_plugin_meminfo_t meminfo,
+                               qemu_plugin_mem_value value,
+                               unsigned size)
+{
+    bool be = qemu_plugin_mem_is_big_endian(meminfo);
+    bool is_store = qemu_plugin_mem_is_store(meminfo);
+    RegionInfo *ri;
+    bool unseen_data = false;
+
+    g_assert(offset + size <= region_size);
+
+    g_mutex_lock(&lock);
+    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+
+    if (!ri) {
+        ri = g_new0(RegionInfo, 1);
+        ri->region_address = region;
+        ri->data = g_malloc0(region_size);
+        ri->seen_all = true;
+        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+    }
+
+    if (is_store) {
+        ri->writes++;
+    } else {
+        ri->reads++;
+    }
+
+    switch (value.type) {
+    case QEMU_PLUGIN_MEM_VALUE_U8:
+        if (is_store) {
+            ri->data[offset] = value.data.u8;
+        } else if (ri->data[offset] != value.data.u8) {
+            unseen_data = true;
+        }
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U16:
+    {
+        uint16_t *p = (uint16_t *) &ri->data[offset];
+        if (is_store) {
+            *p = be ? be16toh(value.data.u16) : value.data.u16;
+        } else if (*p != value.data.u16) {
+            unseen_data = true;
+        }
+        break;
+    }
+    case QEMU_PLUGIN_MEM_VALUE_U32:
+    {
+        uint32_t *p = (uint32_t *) &ri->data[offset];
+        if (is_store) {
+            *p = be ? be32toh(value.data.u32) : value.data.u32;
+        } else if (*p != value.data.u32) {
+            unseen_data = true;
+        }
+        break;
+    }
+    case QEMU_PLUGIN_MEM_VALUE_U64:
+    {
+        uint64_t *p = (uint64_t *) &ri->data[offset];
+        if (is_store) {
+            *p = be ? be64toh(value.data.u64) : value.data.u64;
+        } else if (*p != value.data.u64) {
+            unseen_data = true;
+        }
+        break;
+    }
+    case QEMU_PLUGIN_MEM_VALUE_U128:
+        /* skip */
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * This is expected for regions initialised by QEMU (.text etc) but we
+     * expect to see all data read and written to the test_data region
+     * of the memory test.
+     */
+    if (unseen_data && ri->seen_all) {
+        g_autoptr(GString) error = g_string_new("Warning: ");
+        g_string_append_printf(error, "0x%016"PRIx64":%"PRId64" read an un-instrumented value\n",
+                               region, offset);
+        qemu_plugin_outs(error->str);
+        ri->seen_all = false;
+    }
+
+    g_mutex_unlock(&lock);
+}
+
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
                      uint64_t vaddr, void *udata)
 {
@@ -63,6 +217,15 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     } else {
         qemu_plugin_u64_add(mem_count, cpu_index, 1);
     }
+
+    if (do_region_summary) {
+        uint64_t region = vaddr & ~region_mask;
+        uint64_t offset = vaddr & region_mask;
+        qemu_plugin_mem_value value = qemu_plugin_mem_get_value(meminfo);
+        unsigned size = 1 << qemu_plugin_mem_size_shift(meminfo);
+
+        update_region_info(region, offset, meminfo, value, size);
+    }
 }
 
 static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -117,7 +280,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                 QEMU_PLUGIN_INLINE_ADD_U64,
                 mem_count, 1);
         }
-        if (do_callback) {
+        if (do_callback || do_region_summary) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
                                              QEMU_PLUGIN_CB_NO_REGS,
                                              rw, NULL);
@@ -176,6 +339,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "region-summary") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &do_region_summary)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -196,6 +365,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         qemu_plugin_outs(out->str);
     }
 
+    if (do_region_summary) {
+        region_mask = (region_size - 1);
+        regions = g_hash_table_new(NULL, g_direct_equal);
+    }
+
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
index a0eca4d6ea..a944102a3c 100644
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ b/tests/tcg/alpha/Makefile.softmmu-target
@@ -28,7 +28,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
+memory: CFLAGS+=-DCHECK_UNALIGNED=0 -mbwx
 
 # Running
 QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 32dc0f9830..07be001102 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -65,3 +65,9 @@ endif
 
 MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
 	run-gdbstub-untimely-packet run-gdbstub-registers
+
+# Test plugin memory access instrumentation
+run-plugin-memory-with-libmem.so: 		\
+	PLUGIN_ARGS=$(COMMA)region-summary=true
+run-plugin-memory-with-libmem.so: 		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
diff --git a/tests/tcg/multiarch/system/validate-memory-counts.py b/tests/tcg/multiarch/system/validate-memory-counts.py
new file mode 100755
index 0000000000..16c2788384
--- /dev/null
+++ b/tests/tcg/multiarch/system/validate-memory-counts.py
@@ -0,0 +1,115 @@
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
+      Region Base, Reads, Writes, Seen all
+      0x0000000040004000, 31093, 0, false
+      0x0000000040214000, 2522280, 278579, true
+      0x0000000040000000, 137398, 0, false
+      0x0000000040210000, 54727397, 33721956, false
+
+    And extract the ranges that match test data start and end and
+    return the results.
+    """
+    total_reads = 0
+    total_writes = 0
+    seen_all = False
+
+    with open(path, 'r') as f:
+        next(f)  # Skip the header
+        for line in f:
+
+            if line.startswith("Region Base"):
+                continue
+
+            parts = line.strip().split(', ')
+            if len(parts) != 4:
+                continue
+
+            region_base = int(parts[0], 16)
+            reads = int(parts[1])
+            writes = int(parts[2])
+
+            if start <= region_base < end: # Checking if within range
+                total_reads += reads
+                total_writes += writes
+                seen_all = parts[3] == "true"
+
+    return total_reads, total_writes, seen_all
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
+    actual_reads, actual_writes, seen_all = parse_plugin_output(mem_plugin_output_path, start, end)
+
+    if not seen_all:
+        print("Fail: didn't instrument all accesses to test_data.")
+        sys.exit(1)
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


