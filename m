Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37FFC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujSGm-0001F0-0u; Tue, 05 Aug 2025 20:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujSGg-0001Dv-T0
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:44:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujSGf-00017l-2f
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:44:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-240763b322fso60440005ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754441071; x=1755045871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rsP6X1y1Cj+bnIdXHZ4EG3yJbcPKriXTh1lr6VN6CdU=;
 b=oDbZMEY2K+2pBAr5iVXlby2chWkk97SIUzcWy3CNroELvJyHLdRnOhY5XjNLIrYSEp
 UX+vhFAUzoC0lx2sPt1JFL1bz7hiGZ5KZsOMEKP6NTCXtj3I8iyMsgBqIBrW8DDOh9OD
 LJy7SYbaKWeWCNL/ndeXP/5P7VpbDStAblxsdAv7wQU5jrbWRow7yDEcYNSUVd2q2mye
 Aexkgbbdmu7FisKFTVnPT6n7yFS5NvfQrL8IzHKJeHH91WSO0NctutByCvbz7sBk2S2J
 78MhHjMAxgqJnRtfZgeHlVKyatZnykKGcYxj2HtyuTKtTU210FvnI9j/fc3CWg8Sfn9H
 Nf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754441071; x=1755045871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsP6X1y1Cj+bnIdXHZ4EG3yJbcPKriXTh1lr6VN6CdU=;
 b=rq3HvfmPglzG7mRYJbxPDO4ynEkFS922L+H4cWKQesge3FWphc4hUXw3eIoKnA5blV
 k7/AsZ52KKhaDFHkhYjdqiFpncQcfV7fZq98ZOd0KQfxEYEv8iajXCWH2URPlzK75SG+
 g5XDzCdOU9zl72h9qsHPLSgUOs7h3GGEsmz/65RoXjPa25aelZ5kiQ29BCaKYlXzbvxR
 BK/oGmTZwlVod3QmqZCTOVTcMB1h73W2lBoz6jCxHMYn1lHlIqaEN8ScUgSOU6A/eihc
 uXH1MZX9HIHUYmFRMCi/uWmrZVduhqwSxqbptaHJ3CCtiWCGNr+3DI4r8YOX594C5LQx
 /CYA==
X-Gm-Message-State: AOJu0Yy/E/O5VaZiixxNjqrJYR5EIZu3kyKV+BHRi4QF7YgF6tRZVrYa
 y8C5tk5NmcZ5bbuLA3sFP5pgV7jXHcSqA7uI1WTw1eGHEBVmXfJhjlMSkKwQlnJspOY=
X-Gm-Gg: ASbGncsb/93wdlChpR1PcCyPk3vhEB3qFOzYwgO2KE4Subq32R0ndMJs7NhZJng2fm1
 btFxT1sjtEyc2CgS/hALQjPaNpxkPnWENWP/Zhi5MZFAqHsgljjdDSUyg385LuZab11xEM+3zoz
 mVvbKU54n81/qQHipTri1EC7Zt1CFQgEPWyTTGwFSL2gQFhqDDdhCiUZjkzz0z5Jg/dJSmGg01l
 BcximK3ZtkqbY+Wrpk68JDZx0ZBZnGrWFL7PTNxP01z36DX7gW5Y+eLxCbxfpU8CjAG0LqvtQEF
 hxQx01O3IE3jE8QXXl8oaNDkmPFvy4ttvSlL1r8nITU2ID7lfBO7guVOx5F44sNOaKz6DuVO1gO
 UyMmR94Qec//KqwqRzf/akJpykJxrBBmew3o=
X-Google-Smtp-Source: AGHT+IFsZAsYrpS4Gl+DrfnlfMSAvcjzMf6oIIsGgjh7embR0WDeU7bb4WKE0V/q16rybXud+2V8bQ==
X-Received: by 2002:a17:903:2447:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-2429f5aecc6mr12831195ad.53.1754441071040; 
 Tue, 05 Aug 2025 17:44:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e945sm143024485ad.56.2025.08.05.17.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 17:44:30 -0700 (PDT)
Message-ID: <955bddee-fdf7-491c-b267-d0b3d77869d1@linaro.org>
Date: Tue, 5 Aug 2025 17:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] contrib/plugins/uftrace: add
 timestamp-based-on-real-time option
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
 <20250724204527.3175839-5-pierrick.bouvier@linaro.org>
 <87v7n23w4n.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v7n23w4n.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/5/25 3:23 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> usage: timestamp-based-on-real-time=[on|off]
>>
>> Instead of using number of instructions executed (which is per vcpu), we
>> use the wall time for timestamps. This is useful when tracing user mode
>> programs as well.
> 
> Arguably it is the more useful default when examining flame graphs. The
> instruction count is entirely artificial and wouldn't map onto real
> execution time anyway.
> 
> Maybe use-icount-for-ts and default to off?
>

I don't mind changing the default if you prefer so.

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/uftrace.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index bd4219db693..9211f273700 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -94,8 +94,28 @@ enum uftrace_record_type {
>>   static struct qemu_plugin_scoreboard *score;
>>   static uint64_t trace_sample;
>>   static bool trace_privilege_level;
>> +static bool timestamp_based_on_real_time;
>>   static CpuOps arch_ops;
>>   
>> +static uint64_t gettime_ns(void)
>> +{
>> +#ifdef _WIN32
>> +    /*
>> +     * On Windows, timespec_get is available only with UCRT, but not with
>> +     * MinGW64 environment. Simplify by using only gettimeofday on this
>> +     * platform.
>> +     */
>> +    struct timeval tv;
>> +    gettimeofday(&tv, NULL);
>> +    uint64_t now_ns = tv.tv_sec * 1000 * 1000 * 1000 + tv.tv_usec * 1000;
>> +#else
>> +    struct timespec ts;
>> +    timespec_get(&ts, TIME_UTC);
>> +    uint64_t now_ns = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
> 
> Why use timspec_get here, QEMU's own timer uses:
> 
>    /* get host real time in nanosecond */
>    static inline int64_t get_clock_realtime(void)
>    {
>        struct timeval tv;
> 
>        gettimeofday(&tv, NULL);
>        return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
>    }
>

We need nanoseconds timestamps (which timespec offers and not 
gettimeofday), or we lose precision for short lived functions, resulting 
in bad shaped traces.

> 
>> +#endif
>> +    return now_ns;
>> +}
>> +
>>   static void uftrace_write_map(bool system_emulation)
>>   {
>>       const char *path = "./uftrace.data/sid-0.map";
>> @@ -454,6 +474,9 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
>>   
>>   static uint64_t cpu_get_timestamp(const Cpu *cpu)
>>   {
>> +    if (timestamp_based_on_real_time) {
>> +        return gettime_ns();
>> +    }
>>       return cpu->insn_count;
>>   }
>>   
>> @@ -866,6 +889,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>>                   return -1;
>>               }
>> +        } else if (g_strcmp0(tokens[0], "timestamp-based-on-real-time") == 0) {
>> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
>> +                                        &timestamp_based_on_real_time)) {
>> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>> +                return -1;
>> +            }
>>           } else {
>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>               return -1;
> 


