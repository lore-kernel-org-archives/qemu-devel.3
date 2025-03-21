Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E6C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvh5A-00054c-18; Fri, 21 Mar 2025 14:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvh57-00054G-Uu
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:26:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvh50-0003XE-E0
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:26:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1237333f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742581607; x=1743186407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2LSH3OioFz3asKtQ3GQmUNyHdIhlvycQFg6o7yJhyA=;
 b=fqzdOsmXwXlqUso4QQ5NxxKLGIMtLHl0FFoHtaFBBCrwV+wFBXOjcPwmTr7daoiNQf
 p0R+/l+u0/SzoLsKqr/aEkR6KuzEg+iuFCJVAZ3MUjF511R84XVHlILItfwdrSqB9wI0
 4u/29jsO6rMZCKiSVs90qiG+EjCmLgJ04r9O+WectKjpOwbDyGuBS5APgHWEBGNBXvM1
 eyzBgcfXKheBWNQiTA1OgwjNT4+z7/rPjXgZYI+KMzRwmGDJ0vjR3j+KSnh+2zZZkLC+
 9wqFx0187WvZVK6PtPmKWCs++sfVet+vFgzUWqoQCqt2UMMb2UEDYIFTSfSRl7VdkBVX
 mt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742581607; x=1743186407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2LSH3OioFz3asKtQ3GQmUNyHdIhlvycQFg6o7yJhyA=;
 b=dUgBMnvIAwempQx7GShAWv6C311wutoOJ/ewPymNIMJvudOfEUWXMc6H5QB3HcGzbd
 RKvrxYaoDMjPl2dyQxCXK5ZW0ZkCI+hGlXNBcNTHYO+8hAKRuplgnUwiABWpvp0HiYRx
 fSZWu35lTn4p9A/7D5xjpBbiqUnCkRBkIjrKLMm61Iz5VOqTDdjrL69TiGH6AD6DLvoX
 fdvlwcrNuMtUsVskWvuygy6XbURnYCE942x37aipaBVrlY6uZdkhlwe2HyUxug8SLsGl
 g2tiAC9xGJ6Ps38X0ODuRZUpkOZkMGCEetqxrAPBk1eQsf3BH14VLt36pnAOFvIjsbnu
 oiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkvYPOER0raiyAGBxjNQYAIICnCn6M1P3D/kf7Ikg7PWOOIz/XMnzhZ09PkmzsMuUSs6wIiHu5AFkb@nongnu.org
X-Gm-Message-State: AOJu0Yw+O73axqQ9QV0ms6H2NT7GjunUxpgNLp5L2Zmj8aFOleHm0V5G
 8bitpcWBSPVwTdytqAd8EUb+wFlkG5LDJz00P5RJxeipZO4IS/LhHKT6HQaQapBCFrqKWKLaMwv
 T
X-Gm-Gg: ASbGnctpCfA6lumqEkwn68zAkxzVDDD1kbc3R5VvZ6hKJwSWX61KLrLJMl+vHW7hSoy
 uteHoMSjw/Z/pW8hjWTmDsvGstGJmvyRUxd2w+Nj89Tatbqe1hXBrEN8SMyL3uUgrqiCZjgBBD9
 YHLXRdR2aGV7TR1Xw8tmTd0KZshgYvOrQmSpC61mBotmOxwtlGlWrwtt4DKN0MQC8G3oe3exNk0
 hRpPSIkon+s/o2AYceC040wAOqZ5APQd0YQWdwGIMT/DFosGYXjiYUfcXeBDSB0Tun2xWBx++RG
 SRSRweSToWZoDW3+zgCjURK8fmhFojybz6YwblcmADZNV0A7bVUPPY3SmFUUFC+O8zs6F+4Ohui
 PAzKQ8Ji/0F/2
X-Google-Smtp-Source: AGHT+IEKGJ5IBe+TvLIzJuLIlt/BpawZzaz44fZGC/EYjgm7Tz44bM8P8GLB6aOLqvR7PyytCwJAdQ==
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-3997f8fc43dmr4159785f8f.15.1742581606670; 
 Fri, 21 Mar 2025 11:26:46 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b4cd3sm3102886f8f.57.2025.03.21.11.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:26:46 -0700 (PDT)
Message-ID: <9f76b15e-ec1e-450c-872e-2efce79e30b4@linaro.org>
Date: Fri, 21 Mar 2025 19:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-4-philmd@linaro.org>
 <471fb556-e3db-423a-96c3-8f6c33b6fbb7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <471fb556-e3db-423a-96c3-8f6c33b6fbb7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 21/3/25 18:36, Pierrick Bouvier wrote:
> On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
>> Use the OnOffAuto type as 3-state.
>>
>> Since the TCGState instance is zero-initialized, the
>> mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).
>>
>> In tcg_init_machine(), if mttcg_enabled is still AUTO,
>> set a default value (effectively inlining the
>> default_mttcg_enabled() method content).
>>
>> Instead of emiting a warning when the 'thread' property
>> is set in tcg_set_thread(), emit it in tcg_init_machine()
>> where it is consumed.
>>
>> In the tcg_get_thread() getter, consider AUTO / OFF states
>> as "single", otherwise ON is "multi".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-all.c | 68 ++++++++++++++++++++++-----------------------
>>   1 file changed, 33 insertions(+), 35 deletions(-)
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index d75ecf531b6..2b7f89eaa20 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -32,6 +32,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/accel.h"
>>   #include "qemu/atomic.h"
>> +#include "qapi/qapi-types-common.h"
>>   #include "qapi/qapi-builtin-visit.h"
>>   #include "qemu/units.h"
>>   #if defined(CONFIG_USER_ONLY)
>> @@ -47,7 +48,7 @@
>>   struct TCGState {
>>       AccelState parent_obj;
>> -    bool mttcg_enabled;
>> +    OnOffAuto mttcg_enabled;
>>       bool one_insn_per_tb;
>>       int splitwx_enabled;
>>       unsigned long tb_size;
>> @@ -68,37 +69,10 @@ bool qemu_tcg_mttcg_enabled(void)
>>   }
>>   #endif
>> -/*
>> - * We default to false if we know other options have been enabled
>> - * which are currently incompatible with MTTCG. Otherwise when each
>> - * guest (target) has been updated to support:
>> - *   - atomic instructions
>> - *   - memory ordering primitives (barriers)
>> - * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
>> - *
>> - * Once a guest architecture has been converted to the new primitives
>> - * there is one remaining limitation to check:
>> - *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>> - */
>> -
>> -static bool default_mttcg_enabled(void)
>> -{
>> -    if (icount_enabled()) {
>> -        return false;
>> -    }
>> -#ifdef TARGET_SUPPORTS_MTTCG
>> -    return true;
>> -#else
>> -    return false;
>> -#endif
>> -}
>> -
>>   static void tcg_accel_instance_init(Object *obj)
>>   {
>>       TCGState *s = TCG_STATE(obj);
>> -    s->mttcg_enabled = default_mttcg_enabled();
>> -
>>       /* If debugging enabled, default "auto on", otherwise off. */
>>   #if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
>>       s->splitwx_enabled = -1;
>> @@ -117,9 +91,37 @@ static int tcg_init_machine(MachineState *ms)
>>   #else
>>       unsigned max_cpus = ms->smp.max_cpus;
>>   #endif
>> +#ifdef TARGET_SUPPORTS_MTTCG
>> +    bool mttcg_supported = true;
>> +#else
>> +    bool mttcg_supported = false;
>> +#endif
>>       tcg_allowed = true;
>>       mttcg_enabled = s->mttcg_enabled;
>> +    if (mttcg_enabled == ON_OFF_AUTO_AUTO) {
>> +        /*
>> +         * We default to false if we know other options have been 
>> enabled
>> +         * which are currently incompatible with MTTCG. Otherwise 
>> when each
>> +         * guest (target) has been updated to support:
>> +         *   - atomic instructions
>> +         *   - memory ordering primitives (barriers)
>> +         * they can set the appropriate CONFIG flags in ${target}- 
>> softmmu.mak
>> +         *
>> +         * Once a guest architecture has been converted to the new 
>> primitives
>> +         * there is one remaining limitation to check:
>> +         *   - The guest can't be oversized (e.g. 64 bit guest on 32 
>> bit host)
>> +         */
>> +        if (icount_enabled()) {
>> +            mttcg_enabled = ON_OFF_AUTO_OFF;
>> +        } else {
>> +            mttcg_enabled = mttcg_supported;
>> +        }
>> +    }
>> +    if (mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
>> +        warn_report("Guest not yet converted to MTTCG - "
>> +                    "you may get unexpected results");
>> +    }
>>       page_init();
>>       tb_htable_init();
>> @@ -144,7 +146,7 @@ static char *tcg_get_thread(Object *obj, Error 
>> **errp)
>>   {
>>       TCGState *s = TCG_STATE(obj);
>> -    return g_strdup(s->mttcg_enabled ? "multi" : "single");
>> +    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : 
>> "single");
>>   }
>>   static void tcg_set_thread(Object *obj, const char *value, Error 
>> **errp)
>> @@ -155,14 +157,10 @@ static void tcg_set_thread(Object *obj, const 
>> char *value, Error **errp)
>>           if (icount_enabled()) {
>>               error_setg(errp, "No MTTCG when icount is enabled");
>>           } else {
>> -#ifndef TARGET_SUPPORTS_MTTCG
>> -            warn_report("Guest not yet converted to MTTCG - "
>> -                        "you may get unexpected results");
>> -#endif
>> -            s->mttcg_enabled = true;
>> +            s->mttcg_enabled = ON_OFF_AUTO_ON;
>>           }
>>       } else if (strcmp(value, "single") == 0) {
>> -        s->mttcg_enabled = false;
>> +        s->mttcg_enabled = ON_OFF_AUTO_OFF;
>>       } else {
>>           error_setg(errp, "Invalid 'thread' setting %s", value);
>>       }
> 
> What are we gaining by moving this warning?

Before: default_mttcg_enabled() was directly using TARGET_SUPPORTS_MTTCG 
definition, so we could call it to initialize a default value in
tcg_accel_instance_init().

After: considering the next patch where we need a CPUState initialized
to get TCGCPUOps::mttcg_supported, we can not use instance_init(), so
we defer to tcg_init_machine() where we access &first_cpu.

> Are there cases where it was not reported before?

No idea, I'll let Alex answer that.

