Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76012CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnP-00077J-Ar; Tue, 02 Sep 2025 03:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnG-000749-8O
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnB-0001un-F6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4174311b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799459; x=1757404259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8jo0LSSh8lJpsdcimtvOxocpTr/cr5eTG3kdaxxUXg=;
 b=DqCN0h6YmYXM/ZmVGyYIy0OHoaFD3f6Uz3BX2WBSkCWvxAZ+kqGMZuuKcqmnYo/X8x
 sXojiVeglqcmsPj/v4qB98Ju0diVhne2E4ynwNNwH0aw3oXU0rBq+kBXckqWLFHVzU8A
 dhmQToWJB3D1RYTPvz8mFv+7gg4lyHqsWF0peH1jFNVx59alcVY7c7UrAa5MuZoRbyK3
 Ei0PtO9BEiJgTf80nD7BDpaIlh/RuuRNww3VA/P7O4XHR8bMrZkEGUk7hxv7AsK1bIzP
 o8sPLWDnNyqvA5JI+r2X7BfdseTwKbh+WB7MuFCPyvFCwDEIksOHXijhnFBHrNV9yCAV
 klBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799459; x=1757404259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8jo0LSSh8lJpsdcimtvOxocpTr/cr5eTG3kdaxxUXg=;
 b=pK702/HXJxFut9nyDqAwjt0G0TZq1w7rY/RPT4+0IsQvRHA+xBMOGZt3hc6A2etTHT
 meKKCTCB8AdXjs/nUcWNkMkRxcBgE40PNs9rS34KhVnIk8jG8jnLTktZukzJTDMkwBhV
 8suN4ZSCOFtG/9flY7KtlL7/grkT/52+E+feuYQyZ0BVinGgXjp9JPs3jwqAoEYe8K11
 XaFnYdrzaBjhhdh9lNVaxVzPDhrY9JsW8/1cNHZ0AuivMmkuutTMl6J+B6xA6xNYRCTL
 ibao4tXtvxUxQ7X5iDUp1zz8ZOszzcvc/BmYz6wZOXF+IO/od677ZQQj8xXV/WdCJW30
 bN9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGsRB+bUXBedneI0rVT5AZryerehnSbgAG5QqfnWlS5Xkgh5bKxgQG6TQ/GeGk5vkfS1jQHjXCR7ww@nongnu.org
X-Gm-Message-State: AOJu0YzifOsbakYOy0Tpb5PryL1eIqYwCaAwynzmhhjO/reqAfaH+Qaa
 +c1SkWHVYAZfpcC6t9T4565SfJbkmWCrG12H+OtMwUAiPIiuFx2oY9eMlrPylE3AdGc=
X-Gm-Gg: ASbGncsTwzK4AQQbkz9dL2kNOcvFEsfIcaIY4xd28BqjluxZ8JEp2cwi095RYWEz0Iu
 nf0PykleDprr+23hzS7mTcDXYouqSTyb2aoFyKsZiNCwSmhpDjCDXnaB+xTdEjh+1Qd3/Jt72hv
 xelP98oa9Jg8cRQsy7p/8ioxPr0PiT88/kbHQPbirDbzAavO3z8/elaM1tS4yk7LtRTXluLLkAf
 OPZ1V/HvpE9VrfOdgUGaZyYU5zB0WzS9alN9tLnSF9dvYNlj2dpLg220T6Qfhklim18PkoG+J+S
 j6O0pgX3zSGMCvnHX3mL2kaXMV2w78LWuped6jW9733OAvpV9T4UovRXBPGDeovlIxHtjUU8yXj
 uSM5zWpGUOnO9SDkuf1os5NhUT69S+YnPV7vACAyRgaw=
X-Google-Smtp-Source: AGHT+IHZPc12v5wUMl4IagFfd4ZJIviALA2uvv6Etzy1rXPfhLTYsmFNpgm3aASFqDx0xeiRN7u/YA==
X-Received: by 2002:a05:6a00:5a:b0:772:44c4:4e23 with SMTP id
 d2e1a72fcca58-77244c45955mr8476062b3a.6.1756799458839; 
 Tue, 02 Sep 2025 00:50:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:50:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 3/9] contrib/plugins/uftrace: track callstack
Date: Tue,  2 Sep 2025 00:50:36 -0700
Message-ID: <20250902075042.223990-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

We now track callstack, based on frame pointer analysis. We can detect
function calls, returns, and discontinuities.
We implement a frame pointer based unwinding that is used for
discontinuities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


