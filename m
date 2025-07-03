Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1329DC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNox-0005wg-JA; Thu, 03 Jul 2025 13:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNop-0005sz-C2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoj-0008Kx-Jq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so1227155e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564026; x=1752168826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A30taD1aPEEofESOAsc80jgDmI5t1sj6mCcriwxyD+g=;
 b=zeWM5gWJUwZZvjskGiY6g2hxDYXN0Rnadjgv/g/yQpBjN2CkDfNBKfHVQpslUjd/jX
 fZ87LHGArGy8hQp3dYYWbZ3+X4zXa0lPlw1gmAra+KARd3bccRIbL15wb6b1OSTSDCyg
 43xufZ1pG98appM/wWsFadFpwS498+EWc8Xev4SEdvAjvwyl+fqDRV7EpWkim4qL3MSM
 SXS1pJhbiKYAx18gsRKZwlpCsBmPRTYpdJGeWaz6+Y0itFxhbBnVN+cRpiGoeH/gCSX4
 hWP/YWcS5/rDoLxf5LfRcc8UJ8IW7kibdpayMhz8DqKl/8Bi/s73Hk+yu+JSWc/Eb6j5
 Y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564026; x=1752168826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A30taD1aPEEofESOAsc80jgDmI5t1sj6mCcriwxyD+g=;
 b=qabfuTJ0pWdewgLv8nWX0fjYmj/RrIkTRMKsHbAcJgW7TqN/3VL+zq0K5g/uguKyXD
 L2lvROd8McvsHv/t5BJRk9o8knDAuEGqNvLsWh/upBnWKQkEU4BobvetU6RZdvdtmV06
 6xnVCbnAW45vru3f52oVyItmEtVR3KPtN5SxLbMtGNGU8/2lhIFZEry9/igQnDiu2fC/
 ylQEUwjXa9IBob5ZL7JOkRS4Y5gyZBNArCaZn8LiF0u0o8LOD34zbyHiFZy74XA67Tmq
 gi9mKF5A7zUE7EACghqHnOND5RI/Q4HZrprjk7l/Ea/tInGaMjGlbUU6IqwpqLbIRFcT
 4L0A==
X-Gm-Message-State: AOJu0Yxli+T/vA6pXP51BrWz/HDqXwQgI57QguGIAPz9gG58ZgggODGv
 CkAvdFCPjVG6kaRroITo1e4qzs2ov0w2Kzp8H83KDAWSMclsyBKFTJ1WuLHTKcHxk53bNE7qAyT
 UIXTTFLU=
X-Gm-Gg: ASbGncvHivIgDCPrEjH3mWdSUEk01kOk1IYZfoJylvxD3zAzevjmqmKZYYf/1N/bPzT
 0cogQ7Buy+r1yLBFmi64SGPKb+KHjUqvSjzXCtox0icZVNO5gTFb7tsQqlZ5cf9O4a0sWktTBj6
 5F+rJ7PxabGYJ9PEce6a3XnQXnloVI0UUagEbiCOe3UaGhpXzGPEcmVZwDMGeGyh1fWa4Dqan/8
 1leeUT5D4RcffoyQ97sMmkDAgn3eJjEsk/d55gaQ4UznCwDOogdJ096LfY/dHfO/zuSTRjMD6RM
 js61RcUK5hcz+UoBdfcIsj0Y0xemb/LQPO5p2EqZVJ+zMJgAjA9W5VQIi1+gEPtXrc8R8EE2IKk
 hBy+c9VskAJFfxLVouRISvt3ADYPfrH86ZFkl
X-Google-Smtp-Source: AGHT+IHwIDNoVury+sO++O+38FFCgpt/bPUeAOrnvgPx/tPb/xI5mMAiDAMsv72CdRz4/LUz9GTMUQ==
X-Received: by 2002:a05:600c:828f:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-454a430eb1dmr83743085e9.30.1751564026303; 
 Thu, 03 Jul 2025 10:33:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1890626sm3350015e9.40.2025.07.03.10.33.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 11/39] accel/tcg: Extract statistic related code to
 tcg-stats.c
Date: Thu,  3 Jul 2025 19:32:17 +0200
Message-ID: <20250703173248.44995-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Statistic code is not specific to system emulation (except
cross-page checks) and can be used to analyze user-mode binaries.
Extract statistic related code to its own file: tcg-stats.c,
keeping the original LGPL-2.1-or-later license tag.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/monitor.c   | 193 ---------------------------------------
 accel/tcg/tcg-stats.c | 206 ++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/meson.build |   1 +
 3 files changed, 207 insertions(+), 193 deletions(-)
 create mode 100644 accel/tcg/tcg-stats.c

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index e7ed7281a4b..adb9de5a1c6 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -7,205 +7,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "qemu/qht.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
-#include "system/cpu-timers.h"
-#include "exec/icount.h"
 #include "system/tcg.h"
-#include "tcg/tcg.h"
 #include "internal-common.h"
-#include "tb-context.h"
-
-
-static void dump_drift_info(GString *buf)
-{
-    if (!icount_enabled()) {
-        return;
-    }
-
-    g_string_append_printf(buf, "Host - Guest clock  %"PRIi64" ms\n",
-                           (cpu_get_clock() - icount_get()) / SCALE_MS);
-    if (icount_align_option) {
-        g_string_append_printf(buf, "Max guest delay     %"PRIi64" ms\n",
-                               -max_delay / SCALE_MS);
-        g_string_append_printf(buf, "Max guest advance   %"PRIi64" ms\n",
-                               max_advance / SCALE_MS);
-    } else {
-        g_string_append_printf(buf, "Max guest delay     NA\n");
-        g_string_append_printf(buf, "Max guest advance   NA\n");
-    }
-}
-
-static void dump_accel_info(GString *buf)
-{
-    AccelState *accel = current_accel();
-    bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
-                                                    "one-insn-per-tb",
-                                                    &error_fatal);
-
-    g_string_append_printf(buf, "Accelerator settings:\n");
-    g_string_append_printf(buf, "one-insn-per-tb: %s\n\n",
-                           one_insn_per_tb ? "on" : "off");
-}
-
-static void print_qht_statistics(struct qht_stats hst, GString *buf)
-{
-    uint32_t hgram_opts;
-    size_t hgram_bins;
-    char *hgram;
-
-    if (!hst.head_buckets) {
-        return;
-    }
-    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
-                           "(%0.2f%% head buckets used)\n",
-                           hst.used_head_buckets, hst.head_buckets,
-                           (double)hst.used_head_buckets /
-                           hst.head_buckets * 100);
-
-    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
-    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
-        hgram_opts |= QDIST_PR_NODECIMAL;
-    }
-    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
-    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain occ. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.occupancy) * 100, hgram);
-    g_free(hgram);
-
-    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
-    if (hgram_bins > 10) {
-        hgram_bins = 10;
-    } else {
-        hgram_bins = 0;
-        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
-    }
-    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
-    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.chain), hgram);
-    g_free(hgram);
-}
-
-struct tb_tree_stats {
-    size_t nb_tbs;
-    size_t host_size;
-    size_t target_size;
-    size_t max_target_size;
-    size_t direct_jmp_count;
-    size_t direct_jmp2_count;
-    size_t cross_page;
-};
-
-static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
-{
-    const TranslationBlock *tb = value;
-    struct tb_tree_stats *tst = data;
-
-    tst->nb_tbs++;
-    tst->host_size += tb->tc.size;
-    tst->target_size += tb->size;
-    if (tb->size > tst->max_target_size) {
-        tst->max_target_size = tb->size;
-    }
-    if (tb->page_addr[1] != -1) {
-        tst->cross_page++;
-    }
-    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
-        tst->direct_jmp_count++;
-        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
-            tst->direct_jmp2_count++;
-        }
-    }
-    return false;
-}
-
-static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
-{
-    CPUState *cpu;
-    size_t full = 0, part = 0, elide = 0;
-
-    CPU_FOREACH(cpu) {
-        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
-        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
-        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
-    }
-    *pfull = full;
-    *ppart = part;
-    *pelide = elide;
-}
-
-static void tcg_dump_flush_info(GString *buf)
-{
-    size_t flush_full, flush_part, flush_elide;
-
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-}
-
-static void dump_exec_info(GString *buf)
-{
-    struct tb_tree_stats tst = {};
-    struct qht_stats hst;
-    size_t nb_tbs;
-
-    tcg_tb_foreach(tb_tree_stats_iter, &tst);
-    nb_tbs = tst.nb_tbs;
-    /* XXX: avoid using doubles ? */
-    g_string_append_printf(buf, "Translation buffer state:\n");
-    /*
-     * Report total code size including the padding and TB structs;
-     * otherwise users might think "-accel tcg,tb-size" is not honoured.
-     * For avg host size we use the precise numbers from tb_tree_stats though.
-     */
-    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
-                           tcg_code_size(), tcg_code_capacity());
-    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
-    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
-                           nb_tbs ? tst.target_size / nb_tbs : 0,
-                           tst.max_target_size);
-    g_string_append_printf(buf, "TB avg host size    %zu bytes "
-                           "(expansion ratio: %0.1f)\n",
-                           nb_tbs ? tst.host_size / nb_tbs : 0,
-                           tst.target_size ?
-                           (double)tst.host_size / tst.target_size : 0);
-    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
-                           tst.cross_page,
-                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
-    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
-                           "(2 jumps=%zu %zu%%)\n",
-                           tst.direct_jmp_count,
-                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
-                           tst.direct_jmp2_count,
-                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
-
-    qht_statistics_init(&tb_ctx.htable, &hst);
-    print_qht_statistics(hst, buf);
-    qht_statistics_destroy(&hst);
-
-    g_string_append_printf(buf, "\nStatistics:\n");
-    tcg_dump_flush_info(buf);
-}
-
-void tcg_dump_stats(GString *buf)
-{
-    dump_accel_info(buf);
-    dump_exec_info(buf);
-    dump_drift_info(buf);
-}
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
 {
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
new file mode 100644
index 00000000000..284ac435bdb
--- /dev/null
+++ b/accel/tcg/tcg-stats.c
@@ -0,0 +1,206 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ *  QEMU TCG statistics
+ *
+ *  Copyright (c) 2003-2005 Fabrice Bellard
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/qht.h"
+#include "qapi/error.h"
+#include "system/cpu-timers.h"
+#include "exec/icount.h"
+#include "hw/core/cpu.h"
+#include "tcg/tcg.h"
+#include "internal-common.h"
+#include "tb-context.h"
+
+static void dump_drift_info(GString *buf)
+{
+    if (!icount_enabled()) {
+        return;
+    }
+
+    g_string_append_printf(buf, "Host - Guest clock  %"PRIi64" ms\n",
+                           (cpu_get_clock() - icount_get()) / SCALE_MS);
+    if (icount_align_option) {
+        g_string_append_printf(buf, "Max guest delay     %"PRIi64" ms\n",
+                               -max_delay / SCALE_MS);
+        g_string_append_printf(buf, "Max guest advance   %"PRIi64" ms\n",
+                               max_advance / SCALE_MS);
+    } else {
+        g_string_append_printf(buf, "Max guest delay     NA\n");
+        g_string_append_printf(buf, "Max guest advance   NA\n");
+    }
+}
+
+static void dump_accel_info(GString *buf)
+{
+    AccelState *accel = current_accel();
+    bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
+                                                    "one-insn-per-tb",
+                                                    &error_fatal);
+
+    g_string_append_printf(buf, "Accelerator settings:\n");
+    g_string_append_printf(buf, "one-insn-per-tb: %s\n\n",
+                           one_insn_per_tb ? "on" : "off");
+}
+
+static void print_qht_statistics(struct qht_stats hst, GString *buf)
+{
+    uint32_t hgram_opts;
+    size_t hgram_bins;
+    char *hgram;
+
+    if (!hst.head_buckets) {
+        return;
+    }
+    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
+                           "(%0.2f%% head buckets used)\n",
+                           hst.used_head_buckets, hst.head_buckets,
+                           (double)hst.used_head_buckets /
+                           hst.head_buckets * 100);
+
+    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
+    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
+        hgram_opts |= QDIST_PR_NODECIMAL;
+    }
+    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
+    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain occ. "
+                           "Histogram: %s\n",
+                           qdist_avg(&hst.occupancy) * 100, hgram);
+    g_free(hgram);
+
+    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
+    if (hgram_bins > 10) {
+        hgram_bins = 10;
+    } else {
+        hgram_bins = 0;
+        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
+    }
+    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
+    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
+                           "Histogram: %s\n",
+                           qdist_avg(&hst.chain), hgram);
+    g_free(hgram);
+}
+
+struct tb_tree_stats {
+    size_t nb_tbs;
+    size_t host_size;
+    size_t target_size;
+    size_t max_target_size;
+    size_t direct_jmp_count;
+    size_t direct_jmp2_count;
+    size_t cross_page;
+};
+
+static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    struct tb_tree_stats *tst = data;
+
+    tst->nb_tbs++;
+    tst->host_size += tb->tc.size;
+    tst->target_size += tb->size;
+    if (tb->size > tst->max_target_size) {
+        tst->max_target_size = tb->size;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (tb->page_addr[1] != -1) {
+        tst->cross_page++;
+    }
+#endif
+    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
+        tst->direct_jmp_count++;
+        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
+            tst->direct_jmp2_count++;
+        }
+    }
+    return false;
+}
+
+static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
+{
+    CPUState *cpu;
+    size_t full = 0, part = 0, elide = 0;
+
+    CPU_FOREACH(cpu) {
+        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
+        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
+        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
+    }
+    *pfull = full;
+    *ppart = part;
+    *pelide = elide;
+}
+
+static void tcg_dump_flush_info(GString *buf)
+{
+    size_t flush_full, flush_part, flush_elide;
+
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+}
+
+static void dump_exec_info(GString *buf)
+{
+    struct tb_tree_stats tst = {};
+    struct qht_stats hst;
+    size_t nb_tbs;
+
+    tcg_tb_foreach(tb_tree_stats_iter, &tst);
+    nb_tbs = tst.nb_tbs;
+    /* XXX: avoid using doubles ? */
+    g_string_append_printf(buf, "Translation buffer state:\n");
+    /*
+     * Report total code size including the padding and TB structs;
+     * otherwise users might think "-accel tcg,tb-size" is not honoured.
+     * For avg host size we use the precise numbers from tb_tree_stats though.
+     */
+    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
+                           tcg_code_size(), tcg_code_capacity());
+    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
+    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
+                           nb_tbs ? tst.target_size / nb_tbs : 0,
+                           tst.max_target_size);
+    g_string_append_printf(buf, "TB avg host size    %zu bytes "
+                           "(expansion ratio: %0.1f)\n",
+                           nb_tbs ? tst.host_size / nb_tbs : 0,
+                           tst.target_size ?
+                           (double)tst.host_size / tst.target_size : 0);
+    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
+                           tst.cross_page,
+                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
+    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
+                           "(2 jumps=%zu %zu%%)\n",
+                           tst.direct_jmp_count,
+                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
+                           tst.direct_jmp2_count,
+                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
+
+    qht_statistics_init(&tb_ctx.htable, &hst);
+    print_qht_statistics(hst, buf);
+    qht_statistics_destroy(&hst);
+
+    g_string_append_printf(buf, "\nStatistics:\n");
+    tcg_dump_flush_info(buf);
+}
+
+void tcg_dump_stats(GString *buf)
+{
+    dump_accel_info(buf);
+    dump_exec_info(buf);
+    dump_drift_info(buf);
+}
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 575e92bb9e8..002aa8f4588 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_ss.add(files(
   'tcg-runtime-gvec.c',
   'tb-maint.c',
   'tcg-all.c',
+  'tcg-stats.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.49.0


