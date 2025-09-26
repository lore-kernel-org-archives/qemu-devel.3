Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647B4CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Q3-0006N3-GT; Fri, 26 Sep 2025 09:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Py-0006Hx-60
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Po-0004vx-CY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so539828f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892985; x=1759497785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdDnD0rZnfTWEUKmWeobk/eVDfx9m8s0Jx+oQ2Wy7U8=;
 b=WnpeMAvQPWlT5GonnN7W9AJdo0mJ2WKyfpUTM5UZZr2nilNBAQb07JxL8QJAT3npGa
 l4XJKB57Tm0E6qYjqLzUdDJDd5CYhAzUQu0DzTpW7Up4lP/A6clMrR5sC8/qoUcLmwuK
 tRCS6KKit7HhVIMudb1CMdVWn/EDOrRnWmBx4gKMnn2T6Lr4AT3XsFhO5CLq3l0/w8or
 4/jeNqozPsF+e77mGgb7kWw20qPwYm4u8LFZ2k080GDfloM9VDxqXM3myqkOuRrQxhvM
 lR5qkZ34rb7RyV6igxw1wcIe8ppWVybAvbK2pZ6mfwO7kKOOUBETftVt+KrnbkdrRNj6
 5LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892985; x=1759497785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdDnD0rZnfTWEUKmWeobk/eVDfx9m8s0Jx+oQ2Wy7U8=;
 b=A56uTz1QpkyNLNu0xamfWWIuY/u9ywFQYTyddM4eCtcu0ptTyi69o81ev7a1SLxUor
 hp/QmfC+T4miBjVVPEDO0rmiPwhpYJQCnmCyHfqwh1pbpUs13I+/1udunRKW+xsh8twY
 OlsKUJG65pNBwsSklT/R4s7qqKCPUjPom2BLgd9HnW0J9PrwsXscCc/ocdNNN8EJskzv
 lxaBEnRaGaThMiuYfAcq6I616O+QHXhUxLE6LjRmB4YoI9pQuCn3fmy6Iw7TRgOWtxUd
 PQ3vLH2LKkL4jvpYYBraSNDzhEU0wcLmOz5V1pcqmwtdYErekf9NeuGHg1+2iThPDYWP
 EVJQ==
X-Gm-Message-State: AOJu0YwmMmIOiFi5nbSCNS2fdNue5/clRHXz1JtsCgxbG6I2k1BVxUn1
 1WjviBu44FBhPc+0p2NGBcFl3Yp7bafhWsRR/sI+05kx0M5/x27zLB4bKX3fyahO/Ow=
X-Gm-Gg: ASbGncsmt0bD5SI/8PgEl9PD8YHw0+wpVGgK+vh4Mr71Tjj1BUrunVC89Ptk+nbyK0J
 4UFxN3PB4D3Ranxr+98GvnRI4IEUmQ/UTJby5hTcTDQsu+Kf6OYE/HJ6s3VHXpqUTQep3F7KmBd
 me/KsHAcoBavYaQ0WbI7oYWJYvn7q7V4TpY2LzehFvIJNKZBgzTmUvS23OXl6zTFmwQU16ePVNM
 OnaFzBRXLuh/eMh5ZoWYnpnn/erABLo9Q1fwMaqtT6VHtmM8yZ//On2e73jv+mqV3LciuJDldSz
 3YVaN0Xn7KvHFQH0LU4j4yXikO+4IWiOpvKXM73rpFohSKThe9n62JS9lEDwbnN0uEV9QxCvECR
 nRdYVmiDylSwU6BLEuq4LuwJhNmAjZQ4dsA==
X-Google-Smtp-Source: AGHT+IF75MhQqvzipsW2teu78Lt6+q6UjPOJz5TG39A7Hs9Kq6nZuPe4ctcibO8RQqUnd2exbILLxA==
X-Received: by 2002:a5d:584c:0:b0:3fe:d6df:c679 with SMTP id
 ffacd0b85a97d-40e49e72688mr7183946f8f.55.1758892984820; 
 Fri, 26 Sep 2025 06:23:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1b665sm7014797f8f.27.2025.09.26.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:23:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6EA455F92E;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 18/24] contrib/plugins/uftrace: track callstack
Date: Fri, 26 Sep 2025 14:17:37 +0100
Message-ID: <20250926131744.432185-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

We now track callstack, based on frame pointer analysis. We can detect
function calls, returns, and discontinuities.
We implement a frame pointer based unwinding that is used for
discontinuities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-20-alex.bennee@linaro.org>

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


