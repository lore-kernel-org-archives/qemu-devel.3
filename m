Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401C0CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d69-0006sR-Bc; Mon, 22 Sep 2025 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d50-0005GA-B6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d4p-0001zr-0k
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1933637f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758534194; x=1759138994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwmopQy5poKTlF9P1QjQmB8FAMOd4qFHdrOJJCzmIwA=;
 b=TgCHgNuO7FPyalq3hLwOu9mLbNY4Yn5+9r2FxqQrG62oKz1FZgpJiF313rgEAj2SVH
 R+qaFY977hlXqS/gyXUfW6nnMQh9ptBpWZN2iTxI47nacVNcQqldxlRm/qGoIJybu5AL
 dx43dhsChvn3L1ZroI3cyk5zKq7qx4lxjHO4KAQMMOtuSPwGEto6HGbRiAngmVmZNESg
 rPoPgWu+DU0vWwPQjTNN5y1D0aonfjLTcjyY7wqKp3QoqaiLzR47OMopQNn0LFXW5GCa
 z5M9dXxon4lYqwzEylnYDXKcquZB4g+aEYdMid2AQpp419bFmM+cHTSDv5d/uMNWHbLs
 9n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758534194; x=1759138994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwmopQy5poKTlF9P1QjQmB8FAMOd4qFHdrOJJCzmIwA=;
 b=ZMr0aXJxeDkWzu8bH7BxHrI5+ox/MWb7AFFXtKmyRzMKEl3b5o5wr2Pnqnpsk2K2zE
 bzXptkDWF8DIkpI+tPuDo5ZQITbAtbTBdn6r7KVq2ukygmRInmyR3PW6ljVuRuhoEiy4
 3DQVcaXa1zx8YPlR8vSdk8WHA74qnjSFphQj+mX+q5LCHGKakL2JL713CKGuC3LJE8Nn
 7WKDeolW4iyhrNB5RwLMsLTseQWN3lCRfOXaD9wj/5jGqi9BA5LN5zkoGFE/foIy8W5e
 TJDe0MCq1gLZuHZ5Hkzu583DLAFD2YTQwEBBVk55t11Dv6c6wmH3PwTW/G0Su7ouW/FG
 IPZA==
X-Gm-Message-State: AOJu0YxVXJyI73qCUBEdA9zlChgKnLZXZ0zd7YOG/JXPn66iHFlqGC2A
 uYJdpsDrcQrvqeS+V7Tdvt5MAEQfbYSaYn5EGEo4fvc1Joo5AiAj7GoRxSg9dskxrTU=
X-Gm-Gg: ASbGncu657Qa1W7Fzu/xBUB5tvE3QulrmAT/EK+I7BKfd+dIRA9B+jsyJ6CHCMM3WD5
 nAf2D6vf1IlIKli1+kaPM0vaN/4jOZLVHyn2+Uk41rKsBj5tkIQ18DNs9p1VHTNE9OSNAUSTWoJ
 5o5OkPSCLUaE5H5FNB7765ZvAVI+3tQbnSl+hbXRiKwElWx6YjwlPGxNSHThcnVGXnSHYbk/TCW
 uR/62CZ8J+cj7a7ciiGgEyAcZ5l9iL6N85AnjpTEVqBwh3K2K27C7ewzcZgtfIK61fW1La7nIRf
 7VpCLhRduvKgPD26C19bYc4iYipNOmUtpO6aWBuWOK2xOOZVFTl/sDYzWKBsRaai6m4jf4E0adJ
 PMPUj4EA0tiStba0uezEdIA0=
X-Google-Smtp-Source: AGHT+IHMb7n8NgsSwTEBDg3Np3NqZkfBfUKE8Q9bExmdMOlV/5F5WjvCwT/FYoiST7DXBexP9nLiFQ==
X-Received: by 2002:a05:6000:18a8:b0:3e7:ff32:1ab with SMTP id
 ffacd0b85a97d-3ee852a42a5mr10908154f8f.50.1758534194033; 
 Mon, 22 Sep 2025 02:43:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbefd5csm20259833f8f.51.2025.09.22.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:43:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A0265F8B9;
 Mon, 22 Sep 2025 10:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 19/25] contrib/plugins/uftrace: track callstack
Date: Mon, 22 Sep 2025 10:37:04 +0100
Message-ID: <20250922093711.2768983-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We now track callstack, based on frame pointer analysis. We can detect
function calls, returns, and discontinuities.
We implement a frame pointer based unwinding that is used for
discontinuities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/uftrace.c | 160 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index d060513446c..bb775916270 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -15,6 +15,15 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+typedef struct {
+    GArray *s;
+} Callstack;
+
+typedef struct {
+    uint64_t pc;
+    uint64_t frame_pointer;
+} CallstackEntry;
+
 typedef struct Cpu Cpu;
 
 typedef struct {
@@ -25,6 +34,7 @@ typedef struct {
 } CpuOps;
 
 typedef struct Cpu {
+    Callstack *cs;
     GByteArray *buf;
     CpuOps ops;
     void *arch;
@@ -37,6 +47,71 @@ typedef struct {
 static struct qemu_plugin_scoreboard *score;
 static CpuOps arch_ops;
 
+static Callstack *callstack_new(void)
+{
+    Callstack *cs = g_new0(Callstack, 1);
+    cs->s = g_array_new(false, false, sizeof(CallstackEntry));
+    return cs;
+}
+
+static void callstack_free(Callstack *cs)
+{
+    g_array_free(cs->s, true);
+    cs->s = NULL;
+    g_free(cs);
+}
+
+static size_t callstack_depth(const Callstack *cs)
+{
+    return cs->s->len;
+}
+
+static size_t callstack_empty(const Callstack *cs)
+{
+    return callstack_depth(cs) == 0;
+}
+
+static void callstack_clear(Callstack *cs)
+{
+    g_array_set_size(cs->s, 0);
+}
+
+static const CallstackEntry *callstack_at(const Callstack *cs, size_t depth)
+{
+    g_assert(depth > 0);
+    g_assert(depth <= callstack_depth(cs));
+    return &g_array_index(cs->s, CallstackEntry, depth - 1);
+}
+
+static CallstackEntry callstack_top(const Callstack *cs)
+{
+    if (callstack_depth(cs) >= 1) {
+        return *callstack_at(cs, callstack_depth(cs));
+    }
+    return (CallstackEntry){};
+}
+
+static CallstackEntry callstack_caller(const Callstack *cs)
+{
+    if (callstack_depth(cs) >= 2) {
+        return *callstack_at(cs, callstack_depth(cs) - 1);
+    }
+    return (CallstackEntry){};
+}
+
+static void callstack_push(Callstack *cs, CallstackEntry e)
+{
+    g_array_append_val(cs->s, e);
+}
+
+static CallstackEntry callstack_pop(Callstack *cs)
+{
+    g_assert(!callstack_empty(cs));
+    CallstackEntry e = callstack_top(cs);
+    g_array_set_size(cs->s, callstack_depth(cs) - 1);
+    return e;
+}
+
 static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
@@ -47,6 +122,50 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
     return *((uint64_t *) buf->data);
 }
 
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
+    CallstackEntry unwind[UNWIND_STACK_MAX_DEPTH];
+    size_t depth = 0;
+    do {
+        /* check we don't have an infinite stack */
+        for (size_t i = 0; i < depth; ++i) {
+            if (frame_pointer == unwind[i].frame_pointer) {
+                break;
+            }
+        }
+        CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
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
 static struct qemu_plugin_register *plugin_find_register(const char *name)
 {
     g_autoptr(GArray) regs = qemu_plugin_get_registers();
@@ -102,6 +221,43 @@ static CpuOps aarch64_ops = {
 
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
+    uint64_t pc = (uintptr_t) udata;
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    Callstack *cs = cpu->cs;
+
+    uint64_t fp = cpu->ops.get_frame_pointer(cpu);
+    if (!fp && callstack_empty(cs)) {
+        /*
+         * We simply push current pc. Note that we won't detect symbol change as
+         * long as a proper call does not happen.
+         */
+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        return;
+    }
+
+    CallstackEntry top = callstack_top(cs);
+    if (fp == top.frame_pointer) {
+        /* same function */
+        return;
+    }
+
+    CallstackEntry caller = callstack_caller(cs);
+    if (fp == caller.frame_pointer) {
+        /* return */
+        callstack_pop(cs);
+        return;
+    }
+
+    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
+    if (caller_fp == top.frame_pointer) {
+        /* call */
+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        return;
+    }
+
+    /* discontinuity, exit current stack and unwind new one */
+    callstack_clear(cs);
+    cpu_unwind_stack(cpu, fp, pc);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -140,12 +296,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
+
+    cpu->cs = callstack_new();
 }
 
 static void vcpu_end(unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
+
+    callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
 
-- 
2.47.3


