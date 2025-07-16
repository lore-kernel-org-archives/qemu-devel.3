Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75504C83F2D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubuma-0006vk-Dm; Wed, 16 Jul 2025 01:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumY-0006pM-3C
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumU-0007rB-QK
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so5133166b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644053; x=1753248853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwgVGlpuVZMdGPEt0il7SpuQqcFCUGwkOsSd1PPAb10=;
 b=B40bqbuSub8EUULvrZquwU3v7EuG9BB/q+r6VVaJoFIu4/g8g7+B11n6DthkJl2LUN
 9rwtcNjR5d9vMI5z3iuuSeXXRWCHu0Wtb92wuNhaif0wT/YKWSspMWNGJ6TnHz7CpA/1
 /HubssyD0ChsbrQDJLyapOm5SRhOQ3evaF0Jpu5Vv36JA/xwvD5qYdEaDyCVutu2SDAM
 /3SXVjym89bQWCviZ+1OD4vWAxUFH98lFzDL6++CxLKernQv1389ZS3ivxndStI1YaWC
 YUjco2W4C3O6uovVTCWpcN1LbCTFOS9Re7GiNVDbLROfcAd+LtYrMO+s1uuF485prHZV
 20Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644053; x=1753248853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwgVGlpuVZMdGPEt0il7SpuQqcFCUGwkOsSd1PPAb10=;
 b=L8TWzFjN6Lxh97XynX2cjwPzcMRYg0j8uU/XFTtmpbqmFKG8QzNpHbe1h6+2MCtALk
 fpiaa2ZUwJqLZtwTR1CxaP4g+H+MVc0JCQl5o0Q9D/YutEXgOp62uu6UJO+BKUKSN3Hr
 q46yYOSoKOiUBPH1/OfFUs+Ym7BCe1GjSp2dV1h7vCi4tPS+iu7W1qnpQWS9fQu9UlNE
 M2g8EyLpadiIR1bUYVQCouXzwIXr7ZNLkt2rliMha8DjpJYcEROr256ISZxTtjvjY8TV
 uwdB85BS5TxV+FpPLLADCfolpp8NXQjUYpwDOI0hXtm4mfH0prZR64c91e39z5clN/OY
 DAYQ==
X-Gm-Message-State: AOJu0Yx76fO0AVebFNpYd+WWJ9ZURItHp6hQVJ0bGgVjF8MU0fza84lA
 YsH2spjAL1ByX6f+E7VrqjKmWNZAnG/KXwFN3+mRWq/iFqTmwkRLw3yYB3Z3HS7xPhuxw1evuxB
 33mUy
X-Gm-Gg: ASbGncurfFbbWoMaHJtgzigeE+Ev1Hm7H6IOOORYcKI9qnLpYamnrzGvlLGN5XjUcOy
 GbnuxOcotstXRwrOifx99eUUsLxDctd1UXdDmTYj75MpsfXWVAGrmiRp387L58s7AsftNHDlc4C
 Hw9aiyfb9BxQqkEtYLfI9priqi0Im/cVIBOWz5eTOc10A2YTpIhJQosKCstVi+lQtyAjsnjGXzd
 19DcoX6O9eQNUPskjjzvNO+BWzaTBaK4jtwegcMbBz25QNyFs1L05JCF13xRejJ7s0RLImbmst3
 MzYyy89hnhmUPWv+0nuRqawBgAp2UuSusI3J6vTnPrmcwCEgnRs5oYh+v22xPLNLEgb7baIhKVh
 FPzX7+04XQWac/OpDb7khDY6eDNgYg/Vu
X-Google-Smtp-Source: AGHT+IF99NxSn1WABM+WhkvVNAtfIRnci4TMeQl5x8SQzsxOB+8QpgQYb+qtB+CkJxDw/z0X2VEriw==
X-Received: by 2002:a05:6a20:6a0b:b0:237:b53b:64dd with SMTP id
 adf61e73a8af0-237d5a0b1eemr3409016637.11.1752644053223; 
 Tue, 15 Jul 2025 22:34:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06aa6sm13790162b3a.62.2025.07.15.22.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 22:34:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] contrib/plugins/uftrace: new uftrace plugin
Date: Tue, 15 Jul 2025 22:34:02 -0700
Message-ID: <20250716053407.2814736-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
References: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

This plugin generates a binary trace compatible with:
https://github.com/namhyung/uftrace

It tracks frame pointer during execution, detecting function
calls/returns and works in system and user mode.

It's implemented for aarch64 only (adding other architecture should
be trivial, especially x86_64 that share the same stack layout).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c   | 613 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   3 +-
 2 files changed, 615 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
new file mode 100644
index 00000000000..1f52e8e0f4e
--- /dev/null
+++ b/contrib/plugins/uftrace.c
@@ -0,0 +1,613 @@
+/*
+ * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Generates a trace compatible with uftrace (similar to uftrace record).
+ * https://github.com/namhyung/uftrace
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <qemu-plugin.h>
+#include <glib.h>
+#include <stdio.h>
+#include <sys/time.h>
+#include <time.h>
+#include <sys/stat.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct {
+    GArray *s;
+} callstack;
+
+typedef struct {
+    uint64_t pc;
+    uint64_t frame_pointer;
+} callstack_entry;
+
+typedef struct {
+    GArray *t;
+    GString *path;
+    GString *name;
+    uint32_t id;
+} trace;
+
+typedef struct Cpu Cpu;
+
+typedef struct {
+    void (*init)(Cpu *cpu);
+    void (*end)(Cpu *cpu);
+    uint64_t (*get_frame_pointer)(Cpu *cpu);
+    bool (*does_insn_modify_frame_pointer)(const char *disas);
+} CpuOps;
+
+typedef struct Cpu {
+    uint64_t insn_count;
+    trace *trace;
+    callstack *cs;
+    GArray *callstacks; /* callstack *callstacks[] */
+    GArray *traces; /* trace *traces [] */
+    GByteArray *buf;
+    CpuOps ops;
+    void *arch;
+} Cpu;
+
+typedef struct {
+    struct qemu_plugin_register *reg_fp;
+} Aarch64Cpu;
+
+typedef struct {
+    uint64_t timestamp;
+    uint64_t data;
+} uftrace_entry;
+
+enum uftrace_record_type {
+    UFTRACE_ENTRY,
+    UFTRACE_EXIT,
+    UFTRACE_LOST,
+    UFTRACE_EVENT
+};
+
+static struct qemu_plugin_scoreboard *score;
+static CpuOps arch_ops;
+
+static void uftrace_write_map(bool system_emulation)
+{
+    FILE *sid_map = fopen("./uftrace.data/sid-0.map", "w");
+    g_assert(sid_map);
+
+    if (system_emulation) {
+        fprintf(sid_map,
+                "# map stack on highest address possible, to prevent uftrace\n"
+                "# from considering any kernel address\n");
+        fprintf(sid_map,
+          "ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]\n");
+    } else {
+        /* in user mode, copy /proc/self/maps instead */
+        FILE *self_map = fopen("/proc/self/maps", "r");
+        g_assert(self_map);
+        for (;;) {
+            int c = fgetc(self_map);
+            if (c == EOF) {
+                break;
+            }
+            fputc(c, sid_map);
+        }
+        fclose(self_map);
+    }
+    fclose(sid_map);
+}
+
+static void uftrace_write_task(const GArray *traces)
+{
+    FILE *task = fopen("./uftrace.data/task.txt", "w");
+    g_assert(task);
+    for (int i = 0; i < traces->len; ++i) {
+        trace *t = g_array_index(traces, trace*, i);
+        fprintf(task, "SESS timestamp=0.0 pid=%"PRIu32" sid=0 exename=\"%s\"\n",
+                t->id, t->name->str);
+        fprintf(task, "TASK timestamp=0.0 tid=%"PRIu32" pid=%"PRIu32"\n",
+                t->id, t->id);
+    }
+    fclose(task);
+}
+
+static void uftrace_write_info(const GArray *traces)
+{
+    g_autoptr(GString) taskinfo_tids = g_string_new("taskinfo:tids=");
+    for (int i = 0; i < traces->len; ++i) {
+        trace *t = g_array_index(traces, trace*, i);
+        const char *delim = i > 0 ? "," : "";
+        g_string_append_printf(taskinfo_tids, "%s%"PRIu32, delim, t->id);
+    }
+
+    g_autoptr(GString) taskinfo_nr_tid = g_string_new("taskinfo:nr_tid=");
+    g_string_append_printf(taskinfo_nr_tid, "%d", traces->len);
+
+    FILE *info = fopen("./uftrace.data/info", "w");
+    g_assert(info);
+    /*
+     * $ uftrace dump --debug
+     * uftrace file header: magic         = 4674726163652100
+     * uftrace file header: version       = 4
+     * uftrace file header: header size   = 40
+     * uftrace file header: endian        = 1 (little)
+     * ftrace file header: class          = 2 (64 bit)
+     * uftrace file header: features      = 0x1263 (PLTHOOK | ...
+     * uftrace file header: info          = 0x7bff (EXE_NAME | ...
+     *  <0000000000000000>: 46 74 72 61 63 65 21 00  04 00 00 00 28 00 01 02
+     *  <0000000000000010>: 63 12 00 00 00 00 00 00  ff 7b 00 00 00 00 00 00
+     *  <0000000000000020>: 00 04 00 00 00 00 00 00
+     */
+    const uint8_t header[] = {0x46, 0x74, 0x72, 0x61, 0x63, 0x65, 0x21, 0x00,
+                              0x04, 0x00, 0x00, 0x00, 0x28, 0x00, 0x01, 0x02,
+                              0x63, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                              0xff, 0x7b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                              0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+    fwrite(header, sizeof(header), 1, info);
+    const char *info_data[] = {
+        "exename:from_qemu",
+        "build_id:0123456789abcdef0123456789abcdef01234567",
+        "exit_status:0",
+        "cmdline:uftrace record qemu",
+        "cpuinfo:lines=2",
+        "cpuinfo:nr_cpus=1 / 1 (online/possible)",
+        "cpuinfo:desc=Intel 8086",
+        "meminfo:1.0 / 1.0 GB (free / total)",
+        "osinfo:lines=3",
+        "osinfo:kernel=Linux 6.12.33",
+        "osinfo:hostname=pc",
+        "osinfo:distro=\"Debian GNU/Linux 13 (trixie)\"",
+        "taskinfo:lines=2",
+        taskinfo_nr_tid->str,
+        taskinfo_tids->str,
+        "usageinfo:lines=6",
+        "usageinfo:systime=0.000000",
+        "usageinfo:usrtime=0.000000",
+        "usageinfo:ctxsw=0 / 0 (voluntary / involuntary)",
+        "usageinfo:maxrss=8016",
+        "usageinfo:pagefault=0 / 0 (major / minor)",
+        "usageinfo:iops=0 / 0 (read / write)",
+        "loadinfo:0.0 / 0.0 / 0.0",
+        "record_date:Mon Jan  1 00:00:00 2025",
+        "elapsed_time:1000000000000.0 sec",
+        "pattern_type:regex",
+        "uftrace_version:v0.17 ( x86_64 dwarf python3 luajit tui perf sched dynamic kernel )",
+        "utc_offset:1751552954",
+        0};
+    const char **info_data_it = info_data;
+    while (*(info_data_it)) {
+        fprintf(info, "%s\n", *info_data_it);
+        ++info_data_it;
+    }
+    fclose(info);
+}
+
+static callstack *callstack_new(void)
+{
+    callstack *cs = g_malloc0(sizeof(callstack));
+    cs->s = g_array_new(false, false, sizeof(callstack_entry));
+    return cs;
+}
+
+static void callstack_free(callstack *cs)
+{
+    g_array_free(cs->s, true);
+    cs->s = NULL;
+    g_free(cs);
+}
+
+static size_t callstack_depth(const callstack *cs)
+{
+    return cs->s->len;
+}
+
+static size_t callstack_empty(const callstack *cs)
+{
+    return callstack_depth(cs) == 0;
+}
+
+static void callstack_clear(callstack *cs)
+{
+    g_array_set_size(cs->s, 0);
+}
+
+static const callstack_entry *callstack_at(const callstack *cs, size_t depth)
+{
+    g_assert(depth > 0);
+    g_assert(depth <= callstack_depth(cs));
+    return &g_array_index(cs->s, callstack_entry, depth - 1);
+}
+
+static callstack_entry callstack_top(const callstack *cs)
+{
+    if (callstack_depth(cs) >= 1) {
+        return *callstack_at(cs, callstack_depth(cs));
+    }
+    return (callstack_entry){};
+}
+
+static callstack_entry callstack_caller(const callstack *cs)
+{
+    if (callstack_depth(cs) >= 2) {
+        return *callstack_at(cs, callstack_depth(cs) - 1);
+    }
+    return (callstack_entry){};
+}
+
+static void callstack_push(callstack *cs, callstack_entry e)
+{
+    g_array_append_val(cs->s, e);
+}
+
+static callstack_entry callstack_pop(callstack *cs)
+{
+    g_assert(!callstack_empty(cs));
+    callstack_entry e = callstack_top(cs);
+    g_array_set_size(cs->s, callstack_depth(cs) - 1);
+    return e;
+}
+
+static trace *trace_new(uint32_t id, GString *name)
+{
+    trace *t = g_malloc0(sizeof(trace));
+    t->t = g_array_new(false, false, sizeof(uftrace_entry));
+    t->path = g_string_new(NULL);
+    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
+    t->name = g_string_new(name->str);
+    t->id = id;
+    return t;
+}
+
+static void trace_free(trace *t)
+{
+    g_assert(t->t->len == 0);
+    g_array_free(t->t, true);
+    t->t = NULL;
+    g_string_free(t->path, true);
+    t->path = NULL;
+    g_string_free(t->name, true);
+    t->name = NULL;
+    g_free(t);
+}
+
+static void trace_flush(trace *t, bool append)
+{
+    int create_dir = g_mkdir_with_parents("./uftrace.data",
+                                          S_IRWXU | S_IRWXG | S_IRWXO);
+    g_assert(create_dir == 0);
+    FILE *dat = fopen(t->path->str, append ? "a" : "w");
+    g_assert(dat);
+    GArray *data = t->t;
+    if (data->len) {
+        fwrite(data->data, data->len, sizeof(uftrace_entry), dat);
+    }
+    fclose(dat);
+    g_array_set_size(data, 0);
+}
+
+static void trace_add_entry(trace *t, uint64_t timestamp, uint64_t pc,
+                            size_t depth, enum uftrace_record_type type)
+{
+    /* libmcount/record.c:record_event */
+    const uint64_t record_magic = 0x5;
+    uint64_t data = type | record_magic << 3;
+    data += depth << 6;
+    data += pc << 16;
+    uftrace_entry e = {.timestamp = timestamp, .data = data};
+    g_array_append_val(t->t, e);
+    if (t->t->len * sizeof(uftrace_entry) > 32 * 1024 * 1024) {
+        /* flush every 32 MB */
+        trace_flush(t, true);
+    }
+}
+
+static void trace_enter_function(trace *t, uint64_t timestamp,
+                                 uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
+}
+
+static void trace_exit_function(trace *t, uint64_t timestamp,
+                                uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
+}
+
+static void trace_enter_stack(trace *t, callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
+        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
+static void trace_exit_stack(trace *t, callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
+        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
+static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
+{
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    size_t sz = qemu_plugin_read_register(reg, buf);
+    g_assert(sz == 8);
+    g_assert(buf->len == 8);
+    return *((uint64_t *) buf->data);
+}
+
+static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
+{
+    g_assert(addr);
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    bool read = qemu_plugin_read_memory_vaddr(addr, buf, 8);
+    if (!read) {
+        return 0;
+    }
+    g_assert(buf->len == 8);
+    return *((uint64_t *) buf->data);
+}
+
+static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
+{
+    g_assert(callstack_empty(cpu->cs));
+
+    #define UNWIND_STACK_MAX_DEPTH 1024
+    callstack_entry unwind[UNWIND_STACK_MAX_DEPTH];
+    size_t depth = 0;
+    do {
+        /* check we don't have an infinite stack */
+        for (size_t i = 0; i < depth; ++i) {
+            if (frame_pointer == unwind[i].frame_pointer) {
+                break;
+            }
+        }
+        callstack_entry e = {.frame_pointer = frame_pointer, .pc = pc};
+        unwind[depth] = e;
+        depth++;
+        if (frame_pointer) {
+            frame_pointer = cpu_read_memory64(cpu, frame_pointer);
+        }
+        pc = cpu_read_memory64(cpu, frame_pointer + 8); /* read previous lr */
+    } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
+    #undef UNWIND_STACK_MAX_DEPTH
+
+    /* push it from bottom to top */
+    while (depth) {
+        callstack_push(cpu->cs, unwind[depth - 1]);
+        --depth;
+    }
+}
+
+static uint64_t cpu_get_timestamp(const Cpu *cpu)
+{
+    return cpu->insn_count;
+}
+
+static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_fp);
+}
+
+static void aarch64_init(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = g_malloc0(sizeof(Aarch64Cpu));
+    cpu_->arch = cpu;
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    for (int i = 0; i < regs->len; ++i) {
+        qemu_plugin_reg_descriptor *reg;
+        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!strcmp(reg->name, "x29")) {
+            cpu->reg_fp = reg->handle;
+        }
+    }
+    if (!cpu->reg_fp) {
+        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is not "
+                        "available. Please use an AArch64 cpu (or -cpu max).\n");
+        g_abort();
+    }
+}
+
+static void aarch64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
+{
+    /*
+     * Check if current instruction concerns fp register "x29".
+     * We add a prefix space to make sure we don't match addresses dump
+     * in disassembly.
+     */
+    return strstr(disas, " x29");
+}
+
+static CpuOps aarch64_ops = {
+    .init = aarch64_init,
+    .end = aarch64_end,
+    .get_frame_pointer = aarch64_get_frame_pointer,
+    .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
+};
+
+static void track_callstack(unsigned int cpu_index, void *udata)
+{
+    uint64_t pc = (uintptr_t) udata;
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint64_t timestamp = cpu_get_timestamp(cpu);
+    callstack *cs = cpu->cs;
+    trace *t = cpu->trace;
+
+    uint64_t fp = cpu->ops.get_frame_pointer(cpu);
+    if (!fp && callstack_empty(cs)) {
+        /*
+         * We simply push current pc. Note that we won't detect symbol change as
+         * long as a proper call does not happen.
+         */
+        callstack_push(cs, (callstack_entry){.frame_pointer = fp,
+                                               .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        return;
+    }
+
+    callstack_entry top = callstack_top(cs);
+    if (fp == top.frame_pointer) {
+        /* same function */
+        return;
+    }
+
+    callstack_entry caller = callstack_caller(cs);
+    if (fp == caller.frame_pointer) {
+        /* return */
+        callstack_entry e = callstack_pop(cs);
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        return;
+    }
+
+    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
+    if (caller_fp == top.frame_pointer) {
+        /* call */
+        callstack_push(cs, (callstack_entry){.frame_pointer = fp,
+                .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        return;
+    }
+
+    /* discontinuity, exit current stack and unwind new one */
+    trace_exit_stack(t, cs, timestamp);
+    callstack_clear(cs);
+
+    cpu_unwind_stack(cpu, fp, pc);
+    trace_enter_stack(t, cs, timestamp);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+
+    qemu_plugin_u64 insn_count = qemu_plugin_scoreboard_u64_in_struct(
+                                      score, Cpu, insn_count);
+
+    /*
+     * We instrument all instructions following one that might have updated
+     * the frame pointer. We always instrument first instruction in block, as
+     * last executed instruction, in previous tb, may have modified it.
+     */
+    bool instrument_insn = true;
+    for (int i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+
+        if (instrument_insn) {
+            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                                   QEMU_PLUGIN_CB_R_REGS,
+                                                   (void *) pc);
+            instrument_insn = false;
+        }
+
+        char *disas = qemu_plugin_insn_disas(insn);
+        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
+            instrument_insn = true;
+        }
+    }
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->ops = arch_ops;
+
+    cpu->ops.init(cpu);
+    cpu->buf = g_byte_array_new();
+    cpu->callstacks = g_array_new(0, 0, sizeof(callstack *));
+    cpu->traces = g_array_new(0, 0, sizeof(trace *));
+
+    g_assert(vcpu_index < 1000);
+    uint32_t trace_id = 1000 * 1000 + vcpu_index * 1000;
+
+    g_autoptr(GString) trace_name = g_string_new(NULL);
+    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+    trace *t = trace_new(trace_id, trace_name);
+    g_array_append_val(cpu->traces, t);
+    callstack *cs = callstack_new();
+    g_array_append_val(cpu->callstacks, cs);
+    /* create/truncate trace file */
+    trace_flush(t, false);
+
+    cpu->cs = cs;
+    cpu->trace = t;
+}
+
+static void vcpu_end(unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    g_byte_array_free(cpu->buf, true);
+
+    for (size_t i = 0; i < cpu->traces->len; ++i) {
+        trace *t = g_array_index(cpu->traces, trace*, i);
+        trace_free(t);
+    }
+
+    for (size_t i = 0; i < cpu->callstacks->len; ++i) {
+        callstack *cs = g_array_index(cpu->callstacks, callstack*, i);
+        callstack_free(cs);
+    }
+
+    g_array_free(cpu->traces, true);
+    g_array_free(cpu->callstacks, true);
+    memset(cpu, 0, sizeof(Cpu));
+}
+
+static void at_exit(qemu_plugin_id_t id, void *data)
+{
+    bool system_emulation = (bool) data;
+    g_autoptr(GArray) traces = g_array_new(0, 0, sizeof(trace *));
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
+        for (size_t j = 0; j < cpu->traces->len; ++j) {
+            trace *t = g_array_index(cpu->traces, trace*, j);
+            g_array_append_val(traces, t);
+        }
+    }
+
+    for (size_t i = 0; i < traces->len; ++i) {
+        trace *t = g_array_index(traces, trace*, i);
+        trace_flush(t, true);
+    }
+
+    uftrace_write_map(system_emulation);
+    uftrace_write_info(traces);
+    uftrace_write_task(traces);
+
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        vcpu_end(i);
+    }
+
+    qemu_plugin_scoreboard_free(score);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (!strcmp(info->target_name, "aarch64")) {
+        arch_ops = aarch64_ops;
+    } else {
+        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
+                info->target_name);
+        return 1;
+    }
+
+    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 1876bc78438..7eb3629c95d 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,5 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
+                   'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.2


