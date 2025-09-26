Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DBACAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Q3-0006Nj-3X; Fri, 26 Sep 2025 09:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Q1-0006MY-MW
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Pq-0004w9-Fu
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso7001255e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892985; x=1759497785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAz0JTk4vVsduSfTi2oHWjqlddYgsu0yU35539b5ArY=;
 b=nD1eflIVxqJxgPv4Su8NFreSR91U+7HOLY9Cgm8Or7wTynXLCbndwadokbOoTEOi0I
 Atf6+ya3fZSRpWzkjmy3+ZfHnFGKwdzrWQn39qJmEwD0VadK5WMSVZCuBzNjxrHtdQkJ
 V0SJoY8qEGTEIkucZbXu1DSnrbTLg9ofgcDDt1bjC6lULJu7kLUOJfvTsCBmDlqBc5pv
 FMSHhzijOgMKA7H+UQgxC/6AdJBboAciBQcNtb8/VGayXOCOHBgrdKywmOgRtdWY3R3O
 KX1UC7ltFdSas9Zb/VvfwyIZHSdcfBJ8iUmjIXTev8xKern9ZqLVl+kwdf/2Me0R1tWK
 gh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892985; x=1759497785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAz0JTk4vVsduSfTi2oHWjqlddYgsu0yU35539b5ArY=;
 b=oErNP6bPvsiUkUX9REU/C3tXBx53iHpEGPvj8+jFIWM14FcG5LkUXslXW5iAXbyWxT
 sYzWXYFUq1l4E1Mf0CgElOtmqrVwnfEnt91hgnevL0oy1oLed5SwapyWqIp0cTtHHS4E
 f216VZWEw8qZG4vBA8vA/Xuc08BXn5CUIS/Kav4PBxJllWYngUUdiqaII/NtoIYYeIB+
 EbqDlX2UPSjgWkfY+Pih57Hgbc/EtMHaR3isxErDTDQvO8ivfTm2rEYWzNAOeHxHn9Jl
 IIqqolDsUS1KQ1zTbhJpgIvOKdizL4nPkpLy6g1xFsMA7EZUDxiEBVot484FVVuUGZRE
 xklA==
X-Gm-Message-State: AOJu0YyRHLen9pxcAvn4IdsjkoUZqgVsATia2ZWi7hhOxWbPSqn/+qiq
 kGYdLmgA1n/vzy9FoO7E/vtMf/sCI+aTkuo46cbw95hQLrLpoa/72wZSl1FtARAgSmxLwH9obJt
 uM9IOFDk=
X-Gm-Gg: ASbGncuFOcrtRWCygc42ugXaJmmWaIJwCmQDwmTVuiSF+TTXPBVgk2xVPu9ZC6VtHfg
 nrzWUBoxXmrsnKtIrdDF7QVXfhIfwG1MMUYS/Ad+cD0xoEGwoZXqT5urz27+vWpF6C5pRBmPq07
 D9bP2TAJThgCkrmk5S8jDbz9XLZA5kDAVOYtqDjnQgETXyyy1AAW7qyBH+qgZk/10HOKd6Hr3Ry
 UDvWnLnGM8V2a2dGjxGN0pyG480iTK0O524jIyhTll4J90u6eeLwAuaTDpYk9AtuV/6c9KgnxVi
 WRMQuelwwbq23q+BLGGWEsfqdHgBOc2nczShCiFhpeeE6EW/61ox7ui14aU1Wa45yPmt64T8GR3
 goOlHgdq4IlELYvtfE7J8r1Q=
X-Google-Smtp-Source: AGHT+IHMg0pP8IcWQv+sJp0KMHZ/zOVH6kiu3X6NqcrUHR2mvPPSG2oJErDS7jgG1U4D18bBlhA8jA==
X-Received: by 2002:a05:600c:4ec6:b0:46c:adf8:c845 with SMTP id
 5b1f17b1804b1-46e329c1768mr86328835e9.16.1758892985547; 
 Fri, 26 Sep 2025 06:23:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32c10823sm37200545e9.3.2025.09.26.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:23:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 864AE5F92F;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 19/24] contrib/plugins/uftrace: implement tracing
Date: Fri, 26 Sep 2025 14:17:38 +0100
Message-ID: <20250926131744.432185-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We implement tracing, following uftrace format.
Trace is flushed every 32 MB, so file operations don't impact
performance at runtime.

A different trace is generated per cpu, and we ensure they have a unique
name, based on vcpu_index, while keeping room for privilege level coming
in next commit.

Uftrace format is not officially documented, but it can be found here:
https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-21-alex.bennee@linaro.org>

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index bb775916270..b9dcd531987 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -12,6 +12,15 @@
 #include <qemu-plugin.h>
 #include <glib.h>
 #include <stdio.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <time.h>
+#include <unistd.h>
+
+#define MiB     (INT64_C(1) << 20)
+#define NANOSECONDS_PER_SECOND 1000000000LL
+#define TRACE_FLUSH_SIZE (32 * MiB)
+#define TRACE_ID_SCALE 100
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
@@ -24,6 +33,13 @@ typedef struct {
     uint64_t frame_pointer;
 } CallstackEntry;
 
+typedef struct {
+    GArray *t;
+    GString *path;
+    GString *name;
+    uint32_t id;
+} Trace;
+
 typedef struct Cpu Cpu;
 
 typedef struct {
@@ -34,6 +50,7 @@ typedef struct {
 } CpuOps;
 
 typedef struct Cpu {
+    Trace *trace;
     Callstack *cs;
     GByteArray *buf;
     CpuOps ops;
@@ -44,9 +61,41 @@ typedef struct {
     struct qemu_plugin_register *reg_fp;
 } Aarch64Cpu;
 
+typedef struct {
+    uint64_t timestamp;
+    uint64_t data;
+} UftraceEntry;
+
+typedef enum {
+    UFTRACE_ENTRY,
+    UFTRACE_EXIT,
+    UFTRACE_LOST,
+    UFTRACE_EVENT,
+} UftraceRecordType;
+
 static struct qemu_plugin_scoreboard *score;
 static CpuOps arch_ops;
 
+static uint64_t gettime_ns(void)
+{
+#ifdef _WIN32
+    /*
+     * On Windows, timespec_get is available only with UCRT, but not with
+     * MinGW64 environment. Simplify by using only gettimeofday on this
+     * platform. This may result in a precision loss.
+     */
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
+#else
+    /* We need nanosecond precision for short lived functions. */
+    struct timespec ts;
+    timespec_get(&ts, TIME_UTC);
+    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
+#endif
+    return now_ns;
+}
+
 static Callstack *callstack_new(void)
 {
     Callstack *cs = g_new0(Callstack, 1);
@@ -112,6 +161,86 @@ static CallstackEntry callstack_pop(Callstack *cs)
     return e;
 }
 
+static Trace *trace_new(uint32_t id, GString *name)
+{
+    Trace *t = g_new0(Trace, 1);
+    t->t = g_array_new(false, false, sizeof(UftraceEntry));
+    t->path = g_string_new(NULL);
+    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
+    t->name = g_string_new(name->str);
+    t->id = id;
+    return t;
+}
+
+static void trace_free(Trace *t)
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
+static void trace_flush(Trace *t, bool append)
+{
+    int create_dir = g_mkdir_with_parents("./uftrace.data",
+                                          S_IRWXU | S_IRWXG | S_IRWXO);
+    g_assert(create_dir == 0);
+    FILE *dat = fopen(t->path->str, append ? "a" : "w");
+    g_assert(dat);
+    GArray *data = t->t;
+    if (data->len) {
+        size_t wrote = fwrite(data->data, sizeof(UftraceEntry), data->len, dat);
+        g_assert(wrote == data->len);
+    }
+    fclose(dat);
+    g_array_set_size(data, 0);
+}
+
+static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
+                            size_t depth, UftraceRecordType type)
+{
+    /* https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909 */
+    const uint64_t record_magic = 0x5;
+    uint64_t data = type | (record_magic << 3);
+    data += depth << 6;
+    data += pc << 16;
+    UftraceEntry e = {.timestamp = timestamp, .data = data};
+    g_array_append_val(t->t, e);
+    if (t->t->len * sizeof(UftraceEntry) > TRACE_FLUSH_SIZE) {
+        trace_flush(t, true);
+    }
+}
+
+static void trace_enter_function(Trace *t, uint64_t timestamp,
+                                 uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
+}
+
+static void trace_exit_function(Trace *t, uint64_t timestamp,
+                                uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
+}
+
+static void trace_enter_stack(Trace *t, Callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
+        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
+static void trace_exit_stack(Trace *t, Callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
+        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
 static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
@@ -223,7 +352,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
 {
     uint64_t pc = (uintptr_t) udata;
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint64_t timestamp = gettime_ns();
     Callstack *cs = cpu->cs;
+    Trace *t = cpu->trace;
 
     uint64_t fp = cpu->ops.get_frame_pointer(cpu);
     if (!fp && callstack_empty(cs)) {
@@ -232,6 +363,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
          * long as a proper call does not happen.
          */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
         return;
     }
 
@@ -244,7 +376,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     CallstackEntry caller = callstack_caller(cs);
     if (fp == caller.frame_pointer) {
         /* return */
-        callstack_pop(cs);
+        CallstackEntry e = callstack_pop(cs);
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
         return;
     }
 
@@ -252,12 +385,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (caller_fp == top.frame_pointer) {
         /* call */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
         return;
     }
 
     /* discontinuity, exit current stack and unwind new one */
+    trace_exit_stack(t, cs, timestamp);
     callstack_clear(cs);
+
     cpu_unwind_stack(cpu, fp, pc);
+    trace_enter_stack(t, cs, timestamp);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -297,6 +434,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
 
+    g_assert(vcpu_index < UINT32_MAX / TRACE_ID_SCALE);
+    /* trace_id is: cpu_number * TRACE_ID_SCALE */
+    uint32_t trace_id = (vcpu_index + 1) * TRACE_ID_SCALE;
+
+    g_autoptr(GString) trace_name = g_string_new(NULL);
+    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+    cpu->trace = trace_new(trace_id, trace_name);
+    /* create/truncate trace file */
+    trace_flush(cpu->trace, false);
+
     cpu->cs = callstack_new();
 }
 
@@ -305,6 +452,7 @@ static void vcpu_end(unsigned int vcpu_index)
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
 
+    trace_free(cpu->trace);
     callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
@@ -312,6 +460,8 @@ static void vcpu_end(unsigned int vcpu_index)
 static void at_exit(qemu_plugin_id_t id, void *data)
 {
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
+        trace_flush(cpu->trace, true);
         vcpu_end(i);
     }
 
-- 
2.47.3


