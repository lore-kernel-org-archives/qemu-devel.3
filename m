Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2C1C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ7P-0006Zj-T9; Fri, 08 Aug 2025 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ7O-0006Yv-7t
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:38:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ7L-0005IE-Kz
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:38:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso2864100b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754671133; x=1755275933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXHaRY5GUkrbvRxz99p4RjxkrRHVkcb4imQ/egA/4xg=;
 b=vPzAOe9tC0tmLq70BKrIehKG/YaQH/RCpY/3cwO1PCgBaHVlOku55mm6T9MjshjYZY
 X5nes9sOxpWMGalOtj3tWSQ9hsMnzlg+gWxrnI8v9jFbu9OyXi4lAxr8yUmmqOQoYHbZ
 /aPn4NMw0ZA9k/l4P/g0WeeA26dlMUd89u6f57MHZvicwhggbC49yPkW1u95Innulof9
 w4LJzl06v2ANt/8WChGdNnes7ERLDQ8J8jTOAK47auqAGNCUY7BOQ+hKBw97AnB0i2j0
 4eDddPRQ0YME7g4dLfi1h3X8H7uo2gxrTWzH1Q49L/uwwN7NPdCsrEBQFj4ZWsrH0u3G
 Vfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671133; x=1755275933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXHaRY5GUkrbvRxz99p4RjxkrRHVkcb4imQ/egA/4xg=;
 b=t7VUOQQZmGjK8W+pPiYMLRtWze8ZzAnRljC636nl1oDpiw8KlIEBR4tJBGTZwGuWdT
 Ob+P8U1GpPwMzPDvqnzffNUFmRwnnbX7snIzNiMcmucRdUcQPw/5ygbw+TCqlRg6K7RC
 iXTfRx9yLdpXaxVGWI4fx/ouo4KKGpuS7ZVObzLWvBDhpI4zsZoOfKun6vmM83gMe3iZ
 VOEDBaR9HZ1cI7EV+X2I7N2erdWNCuWTXbOdVXeJhKOEFqdxPHRaZk3I5p/frHG7vuiJ
 XFgAGJo3h1snGS/Yi6vTN92yZ+JUr+fQ9mEI6wlIjgPSxYNPLk4YPcxh2sxaYFL/sQf4
 RvMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZf9qDVRGVqMd/WK0WDlWhKYCUdIpIRqBquSClIPxzXdfbj61oynUvgmMGEtkjDCqgQgDavUhAqaTy@nongnu.org
X-Gm-Message-State: AOJu0Ywo6XH0lYikx/YfWUrnMaEGxSQU67HA4nkJZc98R8m67z52wZvQ
 mnMm0ruZFJFBxUlo7a1UvQFxbbg2i9LMZl8szsp3O9TVM3WEuixjEts1ytmcMI+xJfoR4WsbgYU
 Wq0mcHiVdBg==
X-Gm-Gg: ASbGncvFpIVUpeb+BXq9J/Oqcvu2u1Q8VrWCzS12UFfJJ6dVYW8Z6AcyyIWS0yySrsF
 tQ3ppf0FUsDu4zd/EnD2iVA4XYNB2clJOHnRqhYj6wcp4Iit5S2kuqbWOxTOY9tAsg+hiq1V/J4
 KBIQwFlt9AOSjNkFciuvp22OTtSq9VI6lb1JermbRh9TfWGAE1Fotn0Qj0cBOS64eqX3XQDOpvb
 +lZTyarD/DdaNY0wJ1dRruNsTjmPMTL48tOeDvWZuQz1xBUYiY6dsqFsD6w+PIhflPI1m6Ocgc5
 Yfz120wWsz4EUH1CsIIyvD5q1uoNFX21fR6d9CjwAlO2mvq6AVGW+a7JcDnH+EIOOZRWMOWv1WV
 lpNtmmoNxNLTjgvZHZWVZuuK8ZYNrvjVQglg=
X-Google-Smtp-Source: AGHT+IGUL3Hp34GhYK+HAtHnx/TZXX/Qz9FhIvqaFphGEs8Ecsov//dA9adVeK2Df3FEscFt/w2xmA==
X-Received: by 2002:a05:6a00:852:b0:76b:42e5:fa84 with SMTP id
 d2e1a72fcca58-76c460af27bmr5068059b3a.7.1754671133133; 
 Fri, 08 Aug 2025 09:38:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcceaae02sm20676573b3a.59.2025.08.08.09.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:38:52 -0700 (PDT)
Message-ID: <7743dbd7-ed11-442b-b301-8d0ca7b81b1e@linaro.org>
Date: Fri, 8 Aug 2025 09:38:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
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
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o4ts.nym46t847yx5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We implement tracing, following uftrace format.
>> Trace is flushed every 32 MB, so file operations don't impact
>> performance at runtime.
>>
>> A different trace is generated per cpu, and we ensure they have a unique
>> name, based on vcpu_index, while keeping room for privilege level coming
>> in next commit.
> 
> Suggestion (not a request): put some kind of documentation about the
> format this patch implements, maybe a commit sha & URL to a header file
> from upstream uftrace.
> 

This is the comment /* libmcount/record.c:record_event */ in 
trace_add_entry() function.
I can add this to commit message also, so maybe it's easier to find.

There is no official documentation for that on uftrace side, but source 
code is quite readable, and uftrace provides a convenient "dump --debug" 
command.

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index d51faceb344..402a242433e 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -12,6 +12,13 @@
>> #include <qemu-plugin.h>
>> #include <glib.h>
>> #include <stdio.h>
>> +#include <sys/stat.h>
>> +#include <sys/time.h>
>> +#include <time.h>
>> +#include <unistd.h>
>> +
>> +#define MiB     (INT64_C(1) << 20)
>> +#define NANOSECONDS_PER_SECOND 1000000000LL
>>
>> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>
>> @@ -24,6 +31,13 @@ typedef struct {
>>      uint64_t frame_pointer;
>> } CallstackEntry;
>>
>> +typedef struct {
>> +    GArray *t;
>> +    GString *path;
>> +    GString *name;
>> +    uint32_t id;
>> +} Trace;
>> +
>> typedef struct Cpu Cpu;
>>
>> typedef struct {
>> @@ -34,6 +48,7 @@ typedef struct {
>> } CpuOps;
>>
>> typedef struct Cpu {
>> +    Trace *trace;
>>      Callstack *cs;
>>      GByteArray *buf;
>>      CpuOps ops;
>> @@ -44,9 +59,41 @@ typedef struct {
>>      struct qemu_plugin_register *reg_fp;
>> } Aarch64Cpu;
>>
>> +typedef struct {
>> +    uint64_t timestamp;
>> +    uint64_t data;
>> +} UftraceEntry;
>> +
>> +typedef enum {
>> +    UFTRACE_ENTRY,
>> +    UFTRACE_EXIT,
>> +    UFTRACE_LOST,
>> +    UFTRACE_EVENT
>> +} UftraceRecordType;
>> +
>> static struct qemu_plugin_scoreboard *score;
>> static CpuOps arch_ops;
>>
>> +static uint64_t gettime_ns(void)
>> +{
>> +#ifdef _WIN32
>> +    /*
>> +     * On Windows, timespec_get is available only with UCRT, but not with
>> +     * MinGW64 environment. Simplify by using only gettimeofday on this
>> +     * platform. This may result in a precision loss.
>> +     */
>> +    struct timeval tv;
>> +    gettimeofday(&tv, NULL);
>> +    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
>> +#else
>> +    /* We need nanosecond precision for short lived functions. */
>> +    struct timespec ts;
>> +    timespec_get(&ts, TIME_UTC);
>> +    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
>> +#endif
>> +    return now_ns;
>> +}
>> +
>> static Callstack *callstack_new(void)
>> {
>>      Callstack *cs = g_new0(Callstack, 1);
>> @@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs)
>>      return e;
>> }
>>
>> +static Trace *trace_new(uint32_t id, GString *name)
>> +{
>> +    Trace *t = g_new0(Trace, 1);
>> +    t->t = g_array_new(false, false, sizeof(UftraceEntry));
>> +    t->path = g_string_new(NULL);
>> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
>> +    t->name = g_string_new(name->str);
>> +    t->id = id;
>> +    return t;
>> +}
>> +
>> +static void trace_free(Trace *t)
>> +{
>> +    g_assert(t->t->len == 0);
>> +    g_array_free(t->t, true);
>> +    t->t = NULL;
>> +    g_string_free(t->path, true);
>> +    t->path = NULL;
>> +    g_string_free(t->name, true);
>> +    t->name = NULL;
>> +    g_free(t);
>> +}
>> +
>> +static void trace_flush(Trace *t, bool append)
>> +{
>> +    int create_dir = g_mkdir_with_parents("./uftrace.data",
>> +                                          S_IRWXU | S_IRWXG | S_IRWXO);
>> +    g_assert(create_dir == 0);
>> +    FILE *dat = fopen(t->path->str, append ? "a" : "w");
>> +    g_assert(dat);
>> +    GArray *data = t->t;
>> +    if (data->len) {
>> +        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
> 
> fwrite might not write all bytes, how about using the
> g_file_set_contents() wrapper?
> 
>> +    }
>> +    fclose(dat);
>> +    g_array_set_size(data, 0);
>> +}
>> +
>> +static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
>> +                            size_t depth, UftraceRecordType type)
>> +{
>> +    /* libmcount/record.c:record_event */
>> +    const uint64_t record_magic = 0x5;
>> +    uint64_t data = type | record_magic << 3;
>> +    data += depth << 6;
>> +    data += pc << 16;
>> +    UftraceEntry e = {.timestamp = timestamp, .data = data};
>> +    g_array_append_val(t->t, e);
>> +    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
>> +        trace_flush(t, true);
>> +    }
>> +}
>> +
>> +static void trace_enter_function(Trace *t, uint64_t timestamp,
>> +                                 uint64_t pc, size_t depth)
>> +{
>> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
>> +}
>> +
>> +static void trace_exit_function(Trace *t, uint64_t timestamp,
>> +                                uint64_t pc, size_t depth)
>> +{
>> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
>> +}
>> +
>> +static void trace_enter_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>> +{
>> +    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
>> +        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>> +    }
>> +}
>> +
>> +static void trace_exit_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>> +{
>> +    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
>> +        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>> +    }
>> +}
>> +
>> static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>> {
>>      GByteArray *buf = cpu->buf;
>> @@ -223,7 +349,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>> {
>>      uint64_t pc = (uintptr_t) udata;
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>> +    uint64_t timestamp = gettime_ns();
>>      Callstack *cs = cpu->cs;
>> +    Trace *t = cpu->trace;
>>
>>      uint64_t fp = cpu->ops.get_frame_pointer(cpu);
>>      if (!fp && callstack_empty(cs)) {
>> @@ -232,6 +360,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>           * long as a proper call does not happen.
>>           */
>>          callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>>          return;
>>      }
>>
>> @@ -244,7 +373,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>      CallstackEntry caller = callstack_caller(cs);
>>      if (fp == caller.frame_pointer) {
>>          /* return */
>> -        callstack_pop(cs);
>> +        CallstackEntry e = callstack_pop(cs);
>> +        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
>>          return;
>>      }
>>
>> @@ -252,12 +382,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>>      if (caller_fp == top.frame_pointer) {
>>          /* call */
>>          callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>>          return;
>>      }
>>
>>      /* discontinuity, exit current stack and unwind new one */
>> +    trace_exit_stack(t, cs, timestamp);
>>      callstack_clear(cs);
>> +
>>      cpu_unwind_stack(cpu, fp, pc);
>> +    trace_enter_stack(t, cs, timestamp);
>> }
>>
>> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> @@ -296,6 +430,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>      cpu->ops.init(cpu);
>>      cpu->buf = g_byte_array_new();
>>
>> +    g_assert(vcpu_index < UINT32_MAX / 100);
>> +    /* trace_id is: cpu_number * 100 */
>> +    uint32_t trace_id = (vcpu_index + 1) * 100;
>> +
>> +    g_autoptr(GString) trace_name = g_string_new(NULL);
>> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>> +    cpu->trace = trace_new(trace_id, trace_name);
>> +    /* create/truncate trace file */
>> +    trace_flush(cpu->trace, false);
>> +
>>      cpu->cs = callstack_new();
>> }
>>
>> @@ -304,6 +448,7 @@ static void vcpu_end(unsigned int vcpu_index)
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>>      g_byte_array_free(cpu->buf, true);
>>
>> +    trace_free(cpu->trace);
>>      callstack_free(cpu->cs);
>>      memset(cpu, 0, sizeof(Cpu));
>> }
>> @@ -311,6 +456,8 @@ static void vcpu_end(unsigned int vcpu_index)
>> static void at_exit(qemu_plugin_id_t id, void *data)
>> {
>>      for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>> +        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>> +        trace_flush(cpu->trace, true);
>>          vcpu_end(i);
>>      }
>>
>> -- 
>> 2.47.2
>>
> 
> Looks good overall.


