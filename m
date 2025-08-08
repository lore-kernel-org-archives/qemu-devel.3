Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890B7C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJ5T-0005U8-Rz; Fri, 08 Aug 2025 05:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJ5S-0005To-I3
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:08:30 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJ5Q-000634-AO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:08:30 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-af93c3bac8fso278371466b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754644106; x=1755248906; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4uWW4/OI7oNNN8Qt6MsN5xTp7YNTk2oyZefI5zLj/N8=;
 b=IUv+cItvO/0ZmeImyOOQw0yEEbUd5z5gUF60cwzB0mha8vwCPqIAn6NW+vGl9y1IXM
 5eGbExUOoaZ6y46JNxszrfUgeto6Zd1/9Uz9NzTpmO9vYIRRo5xajDGiFu0Mz4DKuRV9
 jwkuPNd2DghiPeXG9zFZKLRguYlpEXArGpttomzDST62N190rpck7ENTIhbebVTPv0rQ
 tK1q35eUOFUqWRc41RbXyqredhLqpl/BoZzL2vDnHeblZm9UvJm5UOeC2780JxBEqlFL
 n3La2JP8k92ylmgnmtMztavubKGnVmuBWgBqzc5BHstGN41TbBDQ/J75XTptXGVtxnsa
 2OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754644106; x=1755248906;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uWW4/OI7oNNN8Qt6MsN5xTp7YNTk2oyZefI5zLj/N8=;
 b=SqOlvHKwtthg6SAHsl0b2SwR4Xh+wj1LanhByODO6Co1XtLQ+OaoxmtTiEmWI5h69K
 4nQVM8ZPZCScvjJCx0L0pFXbmfOMSEQuuZskWpHcBHfHf3skG7lYJLLycHiZnKHXjE0Q
 mGsfFtFmaIRa7r+C7jRi0NcUfu6dpNt5Q3V9QrVERiHOPDTBA0PMXWSW8jrhdAnpfyU1
 t1R9DS8+9uMOcOrdhe9iO1fnWfzbro3vRDdlW7XxP6gpn4WIL44uQmtdiFEGQ7Kih07q
 S8Xep+/nMSlVyaiNwJpDTHRXJVQp83C9Sq2mV5u7dSSVwj+aVjdHjU46DV61FZxhK4lz
 GuMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfGvhbhcZWFEv3aCeNwok+hp32FDYSOXluX8czbyf3sry/ytbAJCsryrTv4Q8sWpROAI0Zhbwb0ghv@nongnu.org
X-Gm-Message-State: AOJu0YyO26fp2pMzS6G13F6Gqe4k00z+kmkUtthRJlPSUZ4O+DQPSuES
 67ZLSGxZEgmEV2RP9OSYKMpabcJ3Awn5qumw1ikVRuzOzxDyOR6wrqqvwaRzO1j/8GU=
X-Gm-Gg: ASbGncvv/nGAh3T1gqThVD0CJ0ub5Knl4w1u4B8q33WQoJjy8ft252Kr1wMmL9CvJiH
 RncrO8qKrefFFlCvbapwpQlaCVVlRReomAU0fLZS0J47ahNkzVfJyJn6D2ywjDUvg7mfAK04NdP
 ovSMxO/dUNqBkWT1cMlrIEGKfOcixB2ZkNkmsp14Xu5VNr9rL11pypmI7LJZs0ZgkbqkQuyv1vX
 1421F1XYuoc32OBOYZJrGgZciiYoThAqiWOlQf/AbporQETDg/UckA2BscYJLDUi9DJzmGGjSsR
 CANVvAN+cur1QPvLndHGJckYzSzMdXVasvH4Tq+Xy8MwpwCVu4XRBqgj9aA3Jo21oQ+0CGI5xXJ
 TEroRWdRNotEpgyFAXxeKcR/U0gWbt3TX8L488J7X6E7I6F6eRU7CUQZlJ38KU0VcwwxAUqFw
X-Google-Smtp-Source: AGHT+IEzXu2oUR0J1EMb97B5LLhE+oQ7HeaxjKM9+XApX/yUhBQlfArKNzLjOscfdxDyz6OSR8ZC5A==
X-Received: by 2002:a17:907:da2:b0:ae3:696c:60a with SMTP id
 a640c23a62f3a-af9c6375a29mr159752666b.8.1754644105625; 
 Fri, 08 Aug 2025 02:08:25 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a750253sm1466301466b.86.2025.08.08.02.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:08:25 -0700 (PDT)
Date: Fri, 08 Aug 2025 11:49:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 3/9] contrib/plugins/uftrace: track callstack
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-4-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-4-pierrick.bouvier@linaro.org>
Message-ID: <t0o41z.23tpc2iz8vjf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>We now track callstack, based on frame pointer analysis. We can detect
>function calls, returns, and discontinuities.
>We implement a frame pointer based unwinding that is used for
>discontinuities.


Nit: Never heard of the "discontinuity" term for program execution 
before :D Maybe "async control flow (signals, interrupts)"?

>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 160 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 160 insertions(+)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 4b1a2f38143..d51faceb344 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -15,6 +15,15 @@
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>+typedef struct {
>+    GArray *s;
>+} Callstack;
>+
>+typedef struct {
>+    uint64_t pc;
>+    uint64_t frame_pointer;
>+} CallstackEntry;
>+
> typedef struct Cpu Cpu;
> 
> typedef struct {
>@@ -25,6 +34,7 @@ typedef struct {
> } CpuOps;
> 
> typedef struct Cpu {
>+    Callstack *cs;
>     GByteArray *buf;
>     CpuOps ops;
>     void *arch;
>@@ -37,6 +47,71 @@ typedef struct {
> static struct qemu_plugin_scoreboard *score;
> static CpuOps arch_ops;
> 
>+static Callstack *callstack_new(void)
>+{
>+    Callstack *cs = g_new0(Callstack, 1);
>+    cs->s = g_array_new(false, false, sizeof(CallstackEntry));
>+    return cs;
>+}
>+
>+static void callstack_free(Callstack *cs)
>+{
>+    g_array_free(cs->s, true);
>+    cs->s = NULL;
>+    g_free(cs);
>+}
>+
>+static size_t callstack_depth(const Callstack *cs)
>+{
>+    return cs->s->len;
>+}
>+
>+static size_t callstack_empty(const Callstack *cs)
>+{
>+    return callstack_depth(cs) == 0;
>+}
>+
>+static void callstack_clear(Callstack *cs)
>+{
>+    g_array_set_size(cs->s, 0);
>+}
>+
>+static const CallstackEntry *callstack_at(const Callstack *cs, size_t depth)
>+{
>+    g_assert(depth > 0);
>+    g_assert(depth <= callstack_depth(cs));
>+    return &g_array_index(cs->s, CallstackEntry, depth - 1);
>+}
>+
>+static CallstackEntry callstack_top(const Callstack *cs)
>+{
>+    if (callstack_depth(cs) >= 1) {
>+        return *callstack_at(cs, callstack_depth(cs));
>+    }
>+    return (CallstackEntry){};
>+}
>+
>+static CallstackEntry callstack_caller(const Callstack *cs)
>+{
>+    if (callstack_depth(cs) >= 2) {
>+        return *callstack_at(cs, callstack_depth(cs) - 1);
>+    }
>+    return (CallstackEntry){};
>+}
>+
>+static void callstack_push(Callstack *cs, CallstackEntry e)
>+{
>+    g_array_append_val(cs->s, e);
>+}
>+
>+static CallstackEntry callstack_pop(Callstack *cs)
>+{
>+    g_assert(!callstack_empty(cs));
>+    CallstackEntry e = callstack_top(cs);
>+    g_array_set_size(cs->s, callstack_depth(cs) - 1);
>+    return e;
>+}
>+
> static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
> {
>     GByteArray *buf = cpu->buf;
>@@ -47,6 +122,50 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>     return *((uint64_t *) buf->data);
> }
> 
>+static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
>+{
>+    g_assert(addr);
>+    GByteArray *buf = cpu->buf;
>+    g_byte_array_set_size(buf, 0);
>+    bool read = qemu_plugin_read_memory_vaddr(addr, buf, 8);
>+    if (!read) {
>+        return 0;
>+    }
>+    g_assert(buf->len == 8);
>+    return *((uint64_t *) buf->data);
>+}
>+
>+static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
>+{
>+    g_assert(callstack_empty(cpu->cs));
>+
>+    #define UNWIND_STACK_MAX_DEPTH 1024
>+    CallstackEntry unwind[UNWIND_STACK_MAX_DEPTH];
>+    size_t depth = 0;
>+    do {
>+        /* check we don't have an infinite stack */
>+        for (size_t i = 0; i < depth; ++i) {
>+            if (frame_pointer == unwind[i].frame_pointer) {
>+                break;
>+            }
>+        }
>+        CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
>+        unwind[depth] = e;
>+        depth++;
>+        if (frame_pointer) {
>+            frame_pointer = cpu_read_memory64(cpu, frame_pointer);
>+        }
>+        pc = cpu_read_memory64(cpu, frame_pointer + 8); /* read previous lr */
>+    } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
>+    #undef UNWIND_STACK_MAX_DEPTH
>+
>+    /* push it from bottom to top */
>+    while (depth) {
>+        callstack_push(cpu->cs, unwind[depth - 1]);
>+        --depth;
>+    }
>+}

Nice.

>+
> static struct qemu_plugin_register *plugin_find_register(const char *name)
> {
>     g_autoptr(GArray) regs = qemu_plugin_get_registers();
>@@ -102,6 +221,43 @@ static CpuOps aarch64_ops = {
> 
> static void track_callstack(unsigned int cpu_index, void *udata)
> {
>+    uint64_t pc = (uintptr_t) udata;
>+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>+    Callstack *cs = cpu->cs;
>+
>+    uint64_t fp = cpu->ops.get_frame_pointer(cpu);
>+    if (!fp && callstack_empty(cs)) {
>+        /*
>+         * We simply push current pc. Note that we won't detect symbol change as
>+         * long as a proper call does not happen.
>+         */
>+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>+        return;
>+    }
>+
>+    CallstackEntry top = callstack_top(cs);
>+    if (fp == top.frame_pointer) {
>+        /* same function */
>+        return;
>+    }
>+
>+    CallstackEntry caller = callstack_caller(cs);
>+    if (fp == caller.frame_pointer) {
>+        /* return */
>+        callstack_pop(cs);
>+        return;
>+    }
>+
>+    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
>+    if (caller_fp == top.frame_pointer) {
>+        /* call */
>+        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>+        return;
>+    }
>+
>+    /* discontinuity, exit current stack and unwind new one */
>+    callstack_clear(cs);
>+    cpu_unwind_stack(cpu, fp, pc);
> }
> 
> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>@@ -139,12 +295,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> 
>     cpu->ops.init(cpu);
>     cpu->buf = g_byte_array_new();
>+
>+    cpu->cs = callstack_new();
> }
> 
> static void vcpu_end(unsigned int vcpu_index)
> {
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>     g_byte_array_free(cpu->buf, true);
>+
>+    callstack_free(cpu->cs);
>     memset(cpu, 0, sizeof(Cpu));
> }
> 
>-- 
>2.47.2
>
Looks good I think,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

