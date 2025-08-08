Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F19C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ5D-0001X6-84; Fri, 08 Aug 2025 12:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ5B-0001WM-Q3
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:36:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ59-0004rY-Hb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:36:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-240763b322fso26242255ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754670998; x=1755275798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmRoOPjo3vzk+LrjKXfqm/l9OFuWP7yK7UbYtyWLxw8=;
 b=FlMdYd2AngQxZtnjwZbmq+NDxjS49yVbgADVLOqcAiI7iEgzU5GaMpGtqPtvMAqZ0H
 3C3vOU8bWsuusKJheXfnYccHCfzWKIjzg7E+fRJiHTvAln/bhkG+gQjyg1VomKspm4zs
 xgFx6Rs32mXoJtVtn6wQsZtRHvqAkq2WkXCSKqw2vYYp6//Vge4or3BMNRnVzNPa8s/5
 SmvvZ5TpgR0LFxuGxksDm5rZT8jXFlXpi3dt+xoKqPSBkMNMgEtidJT/siRtEYrGX6ek
 kfachKXHiq3/VfGBL29HSjp9Pwpew2RHZUVYgr20f5zF/JBsZAEKjMcD11C1fzhDhzNm
 fzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670998; x=1755275798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmRoOPjo3vzk+LrjKXfqm/l9OFuWP7yK7UbYtyWLxw8=;
 b=KlXEcGxnyzwlCpgv9DkYjbnV4bs4UU91Fardi30zQk4kVYaHxs/YB9MMTb7wiONC1U
 CN+gks0AX4S0ZAHsSB+k3cPcKxoPah+EOTuL5hSDqIXcDtoso8XV/z2PfEidGUk5Nh0j
 xbPfcRF5iUh1gHvI1OWh07lgo+trHMXxo706nzYCYtgWaEiwtICjGrnI99olfT2XXZiK
 CKfYQUzP0tnM8XXBN8iSCPlfyTJYJZfuoZgQ0Xg7yK+n+H61H6Wi1rEmkIhJEc3hhlUS
 VmUZ1DHUnngc4RpfbkLPVuMq7f/uSMN0P3L3jLMB8PoiVRLDmv36wjON0TTbJPBTrxaH
 zCQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRsUWM90fekSlwlp9xIkTqZwtDeAnJnks3y2/YuejVMdWu2Abt5fR91rrGOA/7O95Yyt2o/t34NAm3@nongnu.org
X-Gm-Message-State: AOJu0Yz7SL19lWVQAq8S2J8oJoZk4cEbCkrdYQ4WoOo/IWqVrgtHbk14
 3cjRKTaClzmH2I+smvOVV7CJ1qiMWQCtklShopFyFUomwqHSn6B4GMxmn/XjF3BPamw=
X-Gm-Gg: ASbGncuIsNbW8o9MUWDNDOvPlT2TKpV/rsFMDkVX0gGJ+iOYO5KVkX7Kd5tOYPLlEqe
 v3jDkJiIhoya1cXF3RYZhrK6n91gHrEID1oemRvDyfiMAZKDq8eHvgGIJzJsWX+THwYPf34XYk5
 lrzOC1LRZe2VoGmk4ZbhSj93QzYE8ifnOOQZ/KdPSHlcNxm2PA8aFeikQoEhiAStq8/WkHpYSy4
 m+FUcpEqGxga+8+HPxutNyuARESbbXlspeUJBvazDzJnAqw9hHvdHsnNB2J+lpuJn1j+hw1vfNX
 RTMX1F0/XnnrojYZskxZzrLSKMI4u+p/Bj/BgaIQ7WSNzPHQVVkXzf8WXdybusgcVNr5MXq1wpl
 F+9jgoR7meTGCSvtY5/AUDWWMbneI7uW8ppE=
X-Google-Smtp-Source: AGHT+IFMdAR5+/yg2bwYYKE0V6Q/WHJKsx6qdmKH/lzCVBswEeYnYei8LDDHjY9+ZzNoYqgf/ER/lg==
X-Received: by 2002:a17:903:1b43:b0:240:2145:e527 with SMTP id
 d9443c01a7336-242c204c492mr42945425ad.25.1754670997510; 
 Fri, 08 Aug 2025 09:36:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aab0b3sm213558075ad.161.2025.08.08.09.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:36:37 -0700 (PDT)
Message-ID: <7fba89cc-d96a-432b-b228-326379729fa9@linaro.org>
Date: Fri, 8 Aug 2025 09:36:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] contrib/plugins/uftrace: track callstack
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-4-pierrick.bouvier@linaro.org>
 <t0o41z.23tpc2iz8vjf3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o41z.23tpc2iz8vjf3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 8/8/25 1:49 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We now track callstack, based on frame pointer analysis. We can detect
>> function calls, returns, and discontinuities.
>> We implement a frame pointer based unwinding that is used for
>> discontinuities.
> 
> 
> Nit: Never heard of the "discontinuity" term for program execution
> before :D Maybe "async control flow (signals, interrupts)"?
>

Someone posted a series to detect discontinuities in program execution.
I asked the same question as you:
[1] 
https://lore.kernel.org/qemu-devel/51ac04eea17a6c5b59a240d3c57ce54a851e4989@nut.email/

Since we'll probably have this series merged in the future, I though it 
was nice to reuse it.
As well, it's not only async control flow, a setjmp/longjmp will 
generate a discontinuity too. That's why I picked this name compared to 
"exceptional/async control flow".
That said, I don't have strong opinion, and as the name appears only in 
comments and commit message, it can be changed to anything.

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 160 ++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 160 insertions(+)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 4b1a2f38143..d51faceb344 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -15,6 +15,15 @@
>>
>> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>
>> +typedef struct {
>> +    GArray *s;
>> +} Callstack;
>> +
>> +typedef struct {
>> +    uint64_t pc;
>> +    uint64_t frame_pointer;
>> +} CallstackEntry;
>> +
>> typedef struct Cpu Cpu;
>>
>> typedef struct {
>> @@ -25,6 +34,7 @@ typedef struct {
>> } CpuOps;
>>
>> typedef struct Cpu {
>> +    Callstack *cs;
>>      GByteArray *buf;
>>      CpuOps ops;
>>      void *arch;
>> @@ -37,6 +47,71 @@ typedef struct {
>> static struct qemu_plugin_scoreboard *score;
>> static CpuOps arch_ops;
>>
>> +static Callstack *callstack_new(void)
>> +{
>> +    Callstack *cs = g_new0(Callstack, 1);
>> +    cs->s = g_array_new(false, false, sizeof(CallstackEntry));
>> +    return cs;
>> +}
>> +
>> +static void callstack_free(Callstack *cs)
>> +{
>> +    g_array_free(cs->s, true);
>> +    cs->s = NULL;
>> +    g_free(cs);
>> +}
>> +
>> +static size_t callstack_depth(const Callstack *cs)
>> +{
>> +    return cs->s->len;
>> +}
>> +
>> +static size_t callstack_empty(const Callstack *cs)
>> +{
>> +    return callstack_depth(cs) == 0;
>> +}
>> +
>> +static void callstack_clear(Callstack *cs)
>> +{
>> +    g_array_set_size(cs->s, 0);
>> +}
>> +
>> +static const CallstackEntry *callstack_at(const Callstack *cs, size_t depth)
>> +{
>> +    g_assert(depth > 0);
>> +    g_assert(depth <= callstack_depth(cs));
>> +    return &g_array_index(cs->s, CallstackEntry, depth - 1);
>> +}
>> +
>> +static CallstackEntry callstack_top(const Callstack *cs)
>> +{
>> +    if (callstack_depth(cs) >= 1) {
>> +        return *callstack_at(cs, callstack_depth(cs));
>> +    }
>> +    return (CallstackEntry){};
>> +}
>> +
>> +static CallstackEntry callstack_caller(const Callstack *cs)
>> +{
>> +    if (callstack_depth(cs) >= 2) {
>> +        return *callstack_at(cs, callstack_depth(cs) - 1);
>> +    }
>> +    return (CallstackEntry){};
>> +}
>> +
>> +static void callstack_push(Callstack *cs, CallstackEntry e)
>> +{
>> +    g_array_append_val(cs->s, e);
>> +}
>> +
>> +static CallstackEntry callstack_pop(Callstack *cs)
>> +{
>> +    g_assert(!callstack_empty(cs));
>> +    CallstackEntry e = callstack_top(cs);
>> +    g_array_set_size(cs->s, callstack_depth(cs) - 1);
>> +    return e;
>> +}
>> +
>> static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>> {
>>      GByteArray *buf = cpu->buf;
>> @@ -47,6 +122,50 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>>      return *((uint64_t *) buf->data);
>> }
>>
>> +static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
>> +{
>> +    g_assert(addr);
>> +    GByteArray *buf = cpu->buf;
>> +    g_byte_array_set_size(buf, 0);
>> +    bool read = qemu_plugin_read_memory_vaddr(addr, buf, 8);
>> +    if (!read) {
>> +        return 0;
>> +    }
>> +    g_assert(buf->len == 8);
>> +    return *((uint64_t *) buf->data);
>> +}
>> +
>> +static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
>> +{
>> +    g_assert(callstack_empty(cpu->cs));
>> +
>> +    #define UNWIND_STACK_MAX_DEPTH 1024
>> +    CallstackEntry unwind[UNWIND_STACK_MAX_DEPTH];
>> +    size_t depth = 0;
>> +    do {
>> +        /* check we don't have an infinite stack */
>> +        for (size_t i = 0; i < depth; ++i) {
>> +            if (frame_pointer == unwind[i].frame_pointer) {
>> +                break;
>> +            }
>> +        }
>> +        CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
>> +        unwind[depth] = e;
>> +        depth++;
>> +        if (frame_pointer) {
>> +            frame_pointer = cpu_read_memory64(cpu, frame_pointer);
>> +        }
>> +        pc = cpu_read_memory64(cpu, frame_pointer + 8); /* read previous lr */
>> +    } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
>> +    #undef UNWIND_STACK_MAX_DEPTH
>> +
>> +    /* push it from bottom to top */
>> +    while (depth) {
>> +        callstack_push(cpu->cs, unwind[depth - 1]);
>> +        --depth;
>> +    }
>> +}
> 
> Nice.
>

I noticed at some point, during the boot sequence, we had a chain of 
frame pointers that looked like this:
A, B, A, B, A, B...
Thus the need to check we don't have an infinite stack.
It was in code without symbols, but I wonder why we had such a situation 
happening.

>> +
>> static struct qemu_plugin_register *plugin_find_register(const char *name)
>> {
>>      g_autoptr(GArray) regs = qemu_plugin_get_registers();
>> @@ -102,6 +221,43 @@ static CpuOps aarch64_ops = {
>>
>> static void track_callstack(unsigned int cpu_index, void *udata)
>> {
>> +    uint64_t pc = (uintptr_t) udata;
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>> +    Callstack *cs = cpu->cs;
>> +
>> +    uint64_t fp = cpu->ops.get_frame_pointer(cpu);
>> +    if (!fp && callstack_empty(cs)) {
>> +        /*
>> +         * We simply push current pc. Note that we won't detect symbol change as
>> +         * long as a proper call does not happen.
>> +         */
>> +        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        return;
>> +    }
>> +
>> +    CallstackEntry top = callstack_top(cs);
>> +    if (fp == top.frame_pointer) {
>> +        /* same function */
>> +        return;
>> +    }
>> +
>> +    CallstackEntry caller = callstack_caller(cs);
>> +    if (fp == caller.frame_pointer) {
>> +        /* return */
>> +        callstack_pop(cs);
>> +        return;
>> +    }
>> +
>> +    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
>> +    if (caller_fp == top.frame_pointer) {
>> +        /* call */
>> +        callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        return;
>> +    }
>> +
>> +    /* discontinuity, exit current stack and unwind new one */
>> +    callstack_clear(cs);
>> +    cpu_unwind_stack(cpu, fp, pc);
>> }
>>
>> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> @@ -139,12 +295,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>
>>      cpu->ops.init(cpu);
>>      cpu->buf = g_byte_array_new();
>> +
>> +    cpu->cs = callstack_new();
>> }
>>
>> static void vcpu_end(unsigned int vcpu_index)
>> {
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>>      g_byte_array_free(cpu->buf, true);
>> +
>> +    callstack_free(cpu->cs);
>>      memset(cpu, 0, sizeof(Cpu));
>> }
>>
>> -- 
>> 2.47.2
>>
> Looks good I think,
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


