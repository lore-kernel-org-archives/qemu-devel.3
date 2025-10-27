Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A52CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHQj-0007lT-2w; Mon, 27 Oct 2025 03:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDHQg-0007kz-RC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:14:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDHQe-0005ic-DQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:14:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso12318485e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761549245; x=1762154045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eKT9zBBZCgaN3iJB6X4Q0ab8Z0yNK5YFsQi+vSRE6qs=;
 b=IfmEQzYSGWwKx8K5iv+VI5CKU1OOhVUgo6h2aTUxZx7lVBXQL7Exv5y8KUj8xc7rH9
 HSPThBqm/i8H5fsC7oknjqCQwaFenbTDSIQiPBkIvYovX95zUEP98z1FG5ESepEqeqkq
 zBQa9t/SEtC67z7xzJ5OT6r+EuvtqWsVVa/5ooDrlPCJ52OZbtPTbnYhNUlyuKVtSe0E
 4foPp5f8vkoMzinCfPolFlc1M8zuCLFx3wSf+woY5pUB8LOzVeEsff/ZcSR6IdMAKg9T
 Hd91r/4doftcVsW4ATDTWxX/rMXDGMthOh+PGY8xjbuG2fYulR7CG40GAJb2cMJSDw+l
 C+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761549245; x=1762154045;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKT9zBBZCgaN3iJB6X4Q0ab8Z0yNK5YFsQi+vSRE6qs=;
 b=RShHW0jeJz/ZMdH812NgsBTHR5Bgc1pobMSi8OXh8Rzufc+tB36cm8hkH2eNHMwW/3
 40vIneFA59QHisZIKhRJMv7TWugvDt584HWFiaWLvUVotTXuD1r5I5HkN6DxnI0Bqge6
 PQJ1c/EhDbKT1v2qkqt+hiWg+lPkvYhKIk6kK1F8hzNdMmElfro/dWS2z88yv3BCn15+
 nEWdHdF8P+4M837K/Zmhz1QovlxXgWDKZhGQnVPbvy1h3fvqCMUhradJ/VSQxboeOBCy
 +RFwBqnhrMdOD9IiwwGMa83pJkJlLaBH4aygtbgoFFNzObHJQm6DMnXubOkvQq5opJ9t
 lKfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl2Xhzxilu07oBkilQHi2/ySbqLLIzveJEqS1tz7hu9eYNe3WnwMBLAYRlsf//LIHerax0IeSBONP7@nongnu.org
X-Gm-Message-State: AOJu0Yzss1V4DYfc+910VRkKqP4uZUfpLHQNSR2zE9imPMMlPoUnnoQs
 2vhjbEkN65pA1268cSwKCP4Dw4HpsKOhzHcihoKBsTV+fBxWmtDu+2sXNYo41Vxy7Yc=
X-Gm-Gg: ASbGncvCOwPJSfWm8WYOA+cofAzsxAF2ESRaeoz4cpuufwGzAdTtaQxHLacxE7Y0I5T
 T8Q6bzpG3sOK+f1dyyq8hGjm4S7Av99xiJxCruSv6V9zlbahjSJbdHMIuUH1vddd+1SpAbzXw0Z
 71UNG3AmGHRJ5MJgnPmCwKDeOpmE2Dz5RZGSsNnwv2827U/ISdS9s3w1XXo/jsotN/lNjbX43lk
 93G1oyPyOp63qj6xaDZ/oevMqWJouBURlCA6M6cmuM1Gd1Vy4bsl/e6YbAnRApd69HO70hkgw3f
 meFXpEWYOMut0OO1tx2tyNtkwCFcZ+GdXBW28XOkBwMUhXViipn/6TLkRL0fYWxezxAI2oGxI99
 Q2IxqB+rRXO45jF32dQfHTjq83BIGSsMXIqDgLeDgAuBptW8IrZaGcS1EAL9VA4FdayH/G9GA1Q
 /e+lfx1m7bdioxO0zAWL/RiE/xx4lvEHqz8KW7xLR1TPvr2mUZ1Ag2CsY=
X-Google-Smtp-Source: AGHT+IEIhTe+BxOVW2fMofFmq6XWGEe64UhxXgiz1F5gL0/WAWz8mYUX/3g+/RY4StC6f0aKhuIMRw==
X-Received: by 2002:a05:600c:1da7:b0:46e:4be1:a423 with SMTP id
 5b1f17b1804b1-4711786d630mr245959165e9.1.1761549245178; 
 Mon, 27 Oct 2025 00:14:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dcb9d92esm62033295e9.0.2025.10.27.00.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 00:14:04 -0700 (PDT)
Message-ID: <881d4aaf-2a75-4941-869a-076334650bf7@linaro.org>
Date: Mon, 27 Oct 2025 08:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH V2 1/2] linux-user: add a plugin API to filter syscalls
To: Richard Henderson <richard.henderson@linaro.org>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 alex bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 Yun Wang <yunwang94@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
 <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
 <80029288-4571-4e5a-ab99-b3c5c8daf8b6@linaro.org>
Content-Language: en-US
In-Reply-To: <80029288-4571-4e5a-ab99-b3c5c8daf8b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Richard and Alex,

On 2025-10-22 18:00, Richard Henderson wrote:
> On 10/22/25 01:53, Ziyang Zhang wrote:
>> @@ -165,6 +166,10 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>>                             uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
>>                             uint64_t a6, uint64_t a7, uint64_t a8);
>>    void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
>> +bool
>> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>> +                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
>> +                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret);
> 
> The second and third lines should indented just past the ( on the first line, i.e. with
> CPUState.
> 
>> +static inline bool
>> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>> +                                uint64_t a2, uint64_t a3, uint64_t a4,
>> +                                uint64_t a5, uint64_t a6, uint64_t a7,
>> +                                uint64_t a8, uint64_t *ret)
> 
> Like this.
> 
>> +typedef bool
>> +(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
>> +                                unsigned int vcpu_index,
>> +                                int64_t num, uint64_t a1, uint64_t a2,
>> +                                uint64_t a3, uint64_t a4, uint64_t a5,
>> +                                uint64_t a6, uint64_t a7, uint64_t a8,
>> +                                uint64_t *ret);
> 
> Likewise.
> 
>> +static inline bool send_through_syscall_filters(CPUState *cpu, int num,
>> +                                  abi_long arg1, abi_long arg2,
>> +                                  abi_long arg3, abi_long arg4,
>> +                                  abi_long arg5, abi_long arg6,
>> +                                  abi_long arg7, abi_long arg8, abi_long *ret)
> 
> Do not mark inline; let the compiler decide.
> 
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d78b2029fa..b8225f838f 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -14084,8 +14084,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>>            print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
>>        }
>>    
>> -    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>> -                      arg5, arg6, arg7, arg8);
>> +    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, arg5,
>> +        arg6, arg7, arg8, &ret)) {
> 
> Incorrect indent.
> 
>> +        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>> +                        arg5, arg6, arg7, arg8);
> 
> Likewise.
> 
>> diff --git a/plugins/core.c b/plugins/core.c
>> index ead09fd2f1..1b2f875fb1 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -538,6 +538,40 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
>>        }
>>    }
>>    
>> +/*
>> + * Disable CFI checks.
>> + * The callback function has been loaded from an external library so we do not
>> + * have type information
>> + */
>> +QEMU_DISABLE_CFI
>> +bool
>> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
>> +                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
>> +                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret)
> 
> Likewise.
> 
>> +{
>> +    struct qemu_plugin_cb *cb, *next;
>> +    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
>> +
>> +    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
>> +        return false;
>> +    }
>> +
>> +    bool filtered = false;
>> +    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>> +        qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
>> +
>> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>> +        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
>> +            a5, a6, a7, a8, ret)) {
>> +            filtered = true;
>> +            qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>> +            break;
>> +        }
>> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>> +    }
>> +    return filtered;
>> +}
> 
> The loop is better written
> 
>       QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>           bool filtered;
> 
>           qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>           filtered = cb->f.vcpu_syscall_filter(cb->ctx->id, cpu->cpu_index,
>                                                num, a1, a2, a3, a4, a5,
>                                                a6, a7, a8, ret);
>           qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> 
>           if (filtered) {
>               return true;
>           }
>       }
>       return false;
> 
> 
> r~

Thanks for the review.
Beyond the code style, are you open to accept such a functionality as 
part of API plugins?

I think it's simple and powerful enough to justify having it upstream. 
Plus, it will solve other issues than integration with Lorelei.

Regards,
Pierrick

