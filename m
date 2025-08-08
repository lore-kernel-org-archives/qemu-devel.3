Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA290C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVy-0008GD-HR; Thu, 07 Aug 2025 22:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVt-00087o-7y
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVn-0003UL-Qt
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-32117db952aso1548821a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618833; x=1755223633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=co5Pn4vXxl2xGepzoq0rmC9u8lz8ngf1vfiSXSUCvG8=;
 b=XBZmjdfSROgWc7iUcQMERZWGioCMqIq/DKf1uPbALaT3KoJrqFWt6Kpch6emUrdhYo
 LC8WDnmLWwLXu16hlCC7neI5dALGfTAtPUyiBcgqSW/V/Pz5jcEu3mFtgTUDlB40iztc
 /wVXL4Ze4vaw8p6mIyw3dAMOcP9AvSFXuL3vehcYu9TUTs5hPiTDYvrpvRutcxnVpcis
 YwcVqq1Fq/NtwSXfZ/dwRvM3EWu+rfF9C48jpxQ9Mnsk3YPBTv4PPI1sOUhUPyF7JDoW
 8S2RYaM8kIZ0J0uDZYwcQ96PFwv4ZoAmiKL9XvcQrZf35IeHQ4g/kElExtwUzeSMelRm
 vsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618833; x=1755223633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=co5Pn4vXxl2xGepzoq0rmC9u8lz8ngf1vfiSXSUCvG8=;
 b=gxumFNvNN/7GiK/axYA8WZVihGad+wTTWSWld2bByoi2eR9ridneCkNyp9C3aFHR+E
 7MsZQu6pYcSDgCZl35VBxYkg5HDjPw1zojszABWvF4jptmefR3jOnAyLi87tJABT1+Sx
 1yNrrNpco4CqmKGq1OiqIPZ5lYavDLAaHMLOAR/8GJWqp4UHG8lJW8gBePR3LyR9JPzu
 yu3CcEfB58Lnra44gbTQE/GaXxoe8VVUOFfnxfGnXB9cx+zkbq1uyZNJzVG9RYcOQOB6
 RpnNedHQ8pq0zXM/CiL/m9vbfrzQF9eUfBTXIVNmAnRhkeS91Z0/Uh3QNmqYIjSezZhP
 oeQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQOWT/yFrS5jjejgW1FSlk20Pz1TW045PDZvy+9XjtCPE9Esw3f8JyDAzP8GbMGOihYqaopjAUQn+J@nongnu.org
X-Gm-Message-State: AOJu0YzwXF4mZAdAt5Kr8rlTjc3F8hcM9vkE4PjYX4DcRXPZjBbPE5t4
 BukDWXShqpB56AKFQOPFVzqCuyEcE/7xvUkJJB8zZTEAvt6yXJg6U851Ox14Wjqtfmo=
X-Gm-Gg: ASbGncsQKmZMRZv8SpW+x1lcjNykFJ3bhMEaFQ2iO0nqu0pth5MuMIt+eO47iYVfEv5
 pK0gD7Nmfd3ezbZHNFvZRfcE+yrwkEEpl0DMyiAl1tqbp/Nnp132UQHUaZib342oJdkHWicF/PP
 zCWWeJoUhmEnkncJA7gLQA39Djx1rSV1cv9vSDhj9Gw6yqk8aXaOy9kyyKc9Tcv+BLBnzu2HXuz
 ukSg1nqSZJ6C/yXMgLU5Sqnfr7G5TPvHfDYN57ddIrczqd89uxbbuWpg1XJWX/9X+u1l9hFFTHl
 UdGYrlXaV4zlPjk2i6gJXWCL2dM7x3EgjIaY81wnbrw2DEbfY6HhPpCVbFr5VYmud2jVel0+MdQ
 dGgGT/fu7/HXEbgk4M4g1Ug==
X-Google-Smtp-Source: AGHT+IGhdg2jqJpyG8AyVPo6vT1FWqETi+LzEUAlo92PQifS6LiHWVcb6mcEju8fksSiEJS0IgVHCA==
X-Received: by 2002:a17:90b:224e:b0:31f:210e:e34a with SMTP id
 98e67ed59e1d1-321839f0c96mr1723085a91.8.1754618832853; 
 Thu, 07 Aug 2025 19:07:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
Date: Thu,  7 Aug 2025 19:06:57 -0700
Message-ID: <20250808020702.410109-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

We implement tracing, following uftrace format.
Trace is flushed every 32 MB, so file operations don't impact
performance at runtime.

A different trace is generated per cpu, and we ensure they have a unique
name, based on vcpu_index, while keeping room for privilege level coming
in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index d51faceb344..402a242433e 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -12,6 +12,13 @@
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
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
@@ -24,6 +31,13 @@ typedef struct {
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
@@ -34,6 +48,7 @@ typedef struct {
 } CpuOps;
 
 typedef struct Cpu {
+    Trace *trace;
     Callstack *cs;
     GByteArray *buf;
     CpuOps ops;
@@ -44,9 +59,41 @@ typedef struct {
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
+    UFTRACE_EVENT
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
@@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs)
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
+        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
+    }
+    fclose(dat);
+    g_array_set_size(data, 0);
+}
+
+static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
+                            size_t depth, UftraceRecordType type)
+{
+    /* libmcount/record.c:record_event */
+    const uint64_t record_magic = 0x5;
+    uint64_t data = type | record_magic << 3;
+    data += depth << 6;
+    data += pc << 16;
+    UftraceEntry e = {.timestamp = timestamp, .data = data};
+    g_array_append_val(t->t, e);
+    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
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
@@ -223,7 +349,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
 {
     uint64_t pc = (uintptr_t) udata;
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint64_t timestamp = gettime_ns();
     Callstack *cs = cpu->cs;
+    Trace *t = cpu->trace;
 
     uint64_t fp = cpu->ops.get_frame_pointer(cpu);
     if (!fp && callstack_empty(cs)) {
@@ -232,6 +360,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
          * long as a proper call does not happen.
          */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
         return;
     }
 
@@ -244,7 +373,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     CallstackEntry caller = callstack_caller(cs);
     if (fp == caller.frame_pointer) {
         /* return */
-        callstack_pop(cs);
+        CallstackEntry e = callstack_pop(cs);
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
         return;
     }
 
@@ -252,12 +382,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
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
@@ -296,6 +430,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
 
+    g_assert(vcpu_index < UINT32_MAX / 100);
+    /* trace_id is: cpu_number * 100 */
+    uint32_t trace_id = (vcpu_index + 1) * 100;
+
+    g_autoptr(GString) trace_name = g_string_new(NULL);
+    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+    cpu->trace = trace_new(trace_id, trace_name);
+    /* create/truncate trace file */
+    trace_flush(cpu->trace, false);
+
     cpu->cs = callstack_new();
 }
 
@@ -304,6 +448,7 @@ static void vcpu_end(unsigned int vcpu_index)
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
 
+    trace_free(cpu->trace);
     callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
@@ -311,6 +456,8 @@ static void vcpu_end(unsigned int vcpu_index)
 static void at_exit(qemu_plugin_id_t id, void *data)
 {
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
+        trace_flush(cpu->trace, true);
         vcpu_end(i);
     }
 
-- 
2.47.2


