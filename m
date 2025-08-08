Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1029AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 18:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRkm-0001gp-M4; Fri, 08 Aug 2025 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRkj-0001c8-8i
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:23:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukRkg-0002c3-3v
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:23:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so2418549b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754677416; x=1755282216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFNhLwEhceHK85JCqQw138hckp8ocpHyaAmKlEtqU3M=;
 b=sqZyjiShuLnrht5oC6E8lm0tsmNZLJna3pBWGBaz3lEPjFJ4zZBg5XM/gf6CowQvLR
 cCa5tzNg8XVLbCJIelDO4O09qOAmiScMczrzBn6ULPx3/++JmK+3c78eIFX055+lu+tE
 mk7U5DUsfpWKh/4vxrOjyuaWAM9A5fallxNsra3b/PW/DuAfZAnn4SHuyb3xYCQeompq
 rwmmzkqvGLsgrnddsOwxMchqeqlISerLC44EfFXWQrtZvHIUlq2MdTwX/b7I3YXQz9YL
 C7I+AhbZdJ0UXfEkQGuIy0fNSM6kbYDZJPCqMFyCK03KQee7GgfZyN0af86zN+sqzYTV
 +z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677416; x=1755282216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFNhLwEhceHK85JCqQw138hckp8ocpHyaAmKlEtqU3M=;
 b=rarOrJcfVmDz4H2eHV2fClaq1yYgupe+htiQmi7ILPb5qCFrny2bZHWUlciFPbAC9m
 fiSiMX/x3ESRMuCFrDFs97HPSLAnRIhkWXVlxjsHtddWmUVjzVsDSNMwndzgrstnsgBQ
 j/9wC4MIViinVbQs0yKCIgwUJb+sHje0387ktp/WTIQzYASzRUAqQTPimG9cD7kBTKVl
 4g5JEXAEYQtTUzkO4E0dC36FzGlPnxiMowSk3BKuUT6Hl4E1xCFC/NlAMKC2UGfWD3AV
 9L7eCOPVY/7WaPiApIcrm2u1aqg2LFTtZmLCp6wNet83oyPHSGFfyV5Qn4djXzyDcnFb
 5RPA==
X-Gm-Message-State: AOJu0Yy5UFxBlbE+oA8LBeLAjYxr1pc+oKQDPbS30IP5hXptSIgRrVHC
 6eT5c/S7wOKK3R4m5bHhXWhxZK7QpBAzdp7AFnK7TSPYXv4kmyeXeSZhnge0DB+C1iY=
X-Gm-Gg: ASbGnctJQU35/v03RVNpnuRQDzmttYubKChNNFJP43oyavkXvZNgUxsL5VhvsJpK3eN
 oDQ0v3q+RDzab/qMnlvpBdoXwdV/pU0PeKIYsKNt3dxGKnUqgv9cOtfBdN7x9by4vd0CVQOAvCA
 lKJRgUMZplBtJRi0yIIHx08+FBccpiiUAMA8cjiDbXiRwAUa+DKWTytEd0Kf/9/Yulpq/h0E6Sj
 F4IcSjahQ9W7058jRkGlgpV2pmJ7l9GObnad6g3RQ/1pSgY0oBBZbU8/6RZed+bFhvYxhRb2bTl
 0EUGhxjNKjVD4WvJkXvLujU+QVQtmYET8gmo+tkR+46rwXCsKTFw5fhcu9VwFdy5q0FnkqSwQ4D
 iS62Q/m8RtUtyM1ZuexJdLR8q8MSaNxTmz5A=
X-Google-Smtp-Source: AGHT+IHz92SbuGx/VvOqRCu0tbHerCRJ9nNZrkMROPaWYsmikRlJEBCt/zV4iCFvIoKPBxJOcNAy4A==
X-Received: by 2002:a05:6a20:5493:b0:232:9530:2300 with SMTP id
 adf61e73a8af0-2405504de8cmr6297644637.18.1754677416193; 
 Fri, 08 Aug 2025 11:23:36 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bf772116asm14958046b3a.97.2025.08.08.11.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 11:23:35 -0700 (PDT)
Message-ID: <a26e72e7-aa29-4f44-97b9-f9d2ed9d47d5@linaro.org>
Date: Fri, 8 Aug 2025 11:23:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
 <401440fc-c25b-4abc-94d2-4b21593c6eac@linaro.org>
 <CAAjaMXbM_7rt_2dSjmZixcPs7=g3HU2yfJ-ZMvUJOtCeEaJZ9A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAAjaMXbM_7rt_2dSjmZixcPs7=g3HU2yfJ-ZMvUJOtCeEaJZ9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/8/25 11:13 AM, Manos Pitsidianakis wrote:
> On Fri, Aug 8, 2025 at 9:03 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
>>> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>>> We implement tracing, following uftrace format.
>>>> Trace is flushed every 32 MB, so file operations don't impact
>>>> performance at runtime.
>>>>
>>>> A different trace is generated per cpu, and we ensure they have a unique
>>>> name, based on vcpu_index, while keeping room for privilege level coming
>>>> in next commit.
>>>
>>> Suggestion (not a request): put some kind of documentation about the
>>> format this patch implements, maybe a commit sha & URL to a header file
>>> from upstream uftrace.
>>>
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>> contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
>>>> 1 file changed, 148 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>>>> index d51faceb344..402a242433e 100644
>>>> --- a/contrib/plugins/uftrace.c
>>>> +++ b/contrib/plugins/uftrace.c
>>>> @@ -12,6 +12,13 @@
>>>> #include <qemu-plugin.h>
>>>> #include <glib.h>
>>>> #include <stdio.h>
>>>> +#include <sys/stat.h>
>>>> +#include <sys/time.h>
>>>> +#include <time.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +#define MiB     (INT64_C(1) << 20)
>>>> +#define NANOSECONDS_PER_SECOND 1000000000LL
>>>>
>>>> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>>>
>>>> @@ -24,6 +31,13 @@ typedef struct {
>>>>       uint64_t frame_pointer;
>>>> } CallstackEntry;
>>>>
>>>> +typedef struct {
>>>> +    GArray *t;
>>>> +    GString *path;
>>>> +    GString *name;
>>>> +    uint32_t id;
>>>> +} Trace;
>>>> +
>>>> typedef struct Cpu Cpu;
>>>>
>>>> typedef struct {
>>>> @@ -34,6 +48,7 @@ typedef struct {
>>>> } CpuOps;
>>>>
>>>> typedef struct Cpu {
>>>> +    Trace *trace;
>>>>       Callstack *cs;
>>>>       GByteArray *buf;
>>>>       CpuOps ops;
>>>> @@ -44,9 +59,41 @@ typedef struct {
>>>>       struct qemu_plugin_register *reg_fp;
>>>> } Aarch64Cpu;
>>>>
>>>> +typedef struct {
>>>> +    uint64_t timestamp;
>>>> +    uint64_t data;
>>>> +} UftraceEntry;
>>>> +
>>>> +typedef enum {
>>>> +    UFTRACE_ENTRY,
>>>> +    UFTRACE_EXIT,
>>>> +    UFTRACE_LOST,
>>>> +    UFTRACE_EVENT
>>>> +} UftraceRecordType;
>>>> +
>>>> static struct qemu_plugin_scoreboard *score;
>>>> static CpuOps arch_ops;
>>>>
>>>> +static uint64_t gettime_ns(void)
>>>> +{
>>>> +#ifdef _WIN32
>>>> +    /*
>>>> +     * On Windows, timespec_get is available only with UCRT, but not with
>>>> +     * MinGW64 environment. Simplify by using only gettimeofday on this
>>>> +     * platform. This may result in a precision loss.
>>>> +     */
>>>> +    struct timeval tv;
>>>> +    gettimeofday(&tv, NULL);
>>>> +    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
>>>> +#else
>>>> +    /* We need nanosecond precision for short lived functions. */
>>>> +    struct timespec ts;
>>>> +    timespec_get(&ts, TIME_UTC);
>>>> +    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
>>>> +#endif
>>>> +    return now_ns;
>>>> +}
>>>> +
>>>> static Callstack *callstack_new(void)
>>>> {
>>>>       Callstack *cs = g_new0(Callstack, 1);
>>>> @@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs)
>>>>       return e;
>>>> }
>>>>
>>>> +static Trace *trace_new(uint32_t id, GString *name)
>>>> +{
>>>> +    Trace *t = g_new0(Trace, 1);
>>>> +    t->t = g_array_new(false, false, sizeof(UftraceEntry));
>>>> +    t->path = g_string_new(NULL);
>>>> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
>>>> +    t->name = g_string_new(name->str);
>>>> +    t->id = id;
>>>> +    return t;
>>>> +}
>>>> +
>>>> +static void trace_free(Trace *t)
>>>> +{
>>>> +    g_assert(t->t->len == 0);
>>>> +    g_array_free(t->t, true);
>>>> +    t->t = NULL;
>>>> +    g_string_free(t->path, true);
>>>> +    t->path = NULL;
>>>> +    g_string_free(t->name, true);
>>>> +    t->name = NULL;
>>>> +    g_free(t);
>>>> +}
>>>> +
>>>> +static void trace_flush(Trace *t, bool append)
>>>> +{
>>>> +    int create_dir = g_mkdir_with_parents("./uftrace.data",
>>>> +                                          S_IRWXU | S_IRWXG | S_IRWXO);
>>>> +    g_assert(create_dir == 0);
>>>> +    FILE *dat = fopen(t->path->str, append ? "a" : "w");
>>>> +    g_assert(dat);
>>>> +    GArray *data = t->t;
>>>> +    if (data->len) {
>>>> +        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
>>>
>>> fwrite might not write all bytes, how about using the
>>> g_file_set_contents() wrapper?
>>>
>>
>> If I see correctly, g_file_set_contents does not allow to append data,
>> which is what we need to do here (that's the point of flushing every
>> 32MB).
> 
> Ah you're right, my bad. It might be because it renames a temporary
> file to the destination filename in order to make the operation
> atomic.
>
>> I can add an assert on fwrite return to make sure we wrote
>> everything.
> 
> Or a while loop with a bytes_written counter.
> 

fwrite guarantees all data will be written (to the opposite or raw write 
calls), including if syscall is interrupted, doing a proper write loop 
until all data is written. You can check glibc source if in doubt.
Thus, the only situation where it might fail is if disk space is full. 
In this case, I think that an assert (similar to a panic!) is good 
enough because we can't really do anything to solve the problem.

> Or keep it all in memory and write it on exit? Your call

That was the first version, but it does not scale on long executions, 
where traces can reach several gb.

By the way, adding the assert caught a bug, size and num_elems were 
reversed, so definitely thanks for pointing this out.

