Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A54C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgRk-0002Re-HJ; Fri, 21 Mar 2025 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvgRK-0002MP-OR
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:45:51 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvgRI-0006fy-TN
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:45:50 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac25520a289so408486166b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742579147; x=1743183947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sI9t0i9ADPpZuJlZOU//Aqrmvdl9kCFaurXbu/j+ndM=;
 b=v8A0gv6WwKPDObuIagfbdvhv1YcCvJyPzsGJoyPyar/pE+RStksGWeL07fx9xwXt+q
 8IHdVDjt/L3hfHIDcEQOBTBTKuc+ueUfWEkOVN/dAt73GRVH7X4X5kDRU4Igx5P0yiG1
 17T/7BRUfbTMnc44X9FQygb1zPxPmbDQ8XlBHc6AUMQ/VbogHS5tUNU9CbXg50YNq8tL
 o2b45C7iEDkg3SA+NHeMlYjNSBEC7KrN1MdpRJOEBnL+aTAeOnI1SEgeFjTh1k6ryVJC
 cddETQTj84skdmbtx4p55I9k+Gfu9JyvVwVE4rY0HlYdgjtuoVInZsaDCCbQCGmAuSt8
 zNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742579147; x=1743183947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sI9t0i9ADPpZuJlZOU//Aqrmvdl9kCFaurXbu/j+ndM=;
 b=pIeY961o4MhESU9VhD3qAKucGU6UfZSIbXDjrCkJBD4Q0u601i0I2rAu0CZQr96m8Y
 IYaJ+Yhde1pY3yHt1cEcHbztGu2xJVpTk57hC19bVvUlgi5vsVHafMWdsK3LyBUBK6kN
 jmtv24E6Xjrw+kK6Zx6fd1WJTc3ZMFwc2ahfTrTAXm12n88EqfKCti8oemtRxktzIJRB
 8ILTXvIwoBvtLcnqGfGNlJbXu1Qs3qTukN3L1csWdpIJhb9nxaVsDJQWO7UZ+QduqvGf
 DSGfI/NYnd+/z9DxO8Pg+TB0OAnBfbhzqQLvmHMDmIzoOhNzFmAfk8F0VdCp5rGUTCqu
 jP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkUutfyPtaBZnV4Xb9qRk2skemrlAuTGoiRT4rXx6nzxbZJI3pkTtyLBe618tGdMQSLaBwMbl0y8sB@nongnu.org
X-Gm-Message-State: AOJu0YyWpYVptKx6HgulP6mWdwR5PsIiOEekCDzau+u67RAgEyM2FVYY
 HCHbvYs1gJZCM2e0LjgspErcKb2yjtocW/lMIlPqSIgT0UzgES6AgQRXMo64Xbo2mnswOyZqXto
 V
X-Gm-Gg: ASbGncu7zY8OzyklvgfMt1/y+XZ1viZvPacGcFKOOuVCgGI+8MoZdkF2IO/gY+h8JsN
 kqSu4WEzcyAZVZhYPqGSsKEo0vw06nfRQ18zJ75HY91RtLXaHnEm1+Xcdcz4vYVkSv2L96uHipU
 pgleGV8QCmt35BezG7tRhDBMbIWAbA8vkzATXYmJzHG3o98ImMdvEatVR6OLcbMwFbJhuq63uco
 YSWFJfpboxc8GtMYDkGvv6dn2qH4NojtUWsz7h2YQ7u4mpB0eTmjqp64BEBfkpVaWgTKph5LRUR
 3EX5rh9Q1IDZ3nx+YVvS/rl+lvR5aYL5ZwFWT9SsoYwtmsQ+Oj9xDF6feP0yv4W25C26dASvpzl
 6mGVFjwORhQds
X-Google-Smtp-Source: AGHT+IEwaQWFzZ7GBCribKNyD1ni02/yLz/JKTJKOdpsm1F9h2yXOz52K0900jDEx6K3G8un+0hL4A==
X-Received: by 2002:a17:906:fe48:b0:ac3:154e:1386 with SMTP id
 a640c23a62f3a-ac3f2087e96mr414367066b.6.1742579146977; 
 Fri, 21 Mar 2025 10:45:46 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef86e529sm188907866b.21.2025.03.21.10.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:45:46 -0700 (PDT)
Message-ID: <486d1a0a-3822-4106-920f-3173bd5f8818@linaro.org>
Date: Fri, 21 Mar 2025 18:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
To: Anton Johansson <anjo@rev.ng>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-4-philmd@linaro.org>
 <3woeoqgwnmksex36kytsasvlidqoviyogmbjjko4e5mlrnureo@3bdqaducdkjs>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3woeoqgwnmksex36kytsasvlidqoviyogmbjjko4e5mlrnureo@3bdqaducdkjs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 21/3/25 18:01, Anton Johansson wrote:
> On 21/03/25, Philippe Mathieu-Daudé wrote:
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
>>   accel/tcg/tcg-all.c | 68 ++++++++++++++++++++++-----------------------
>>   1 file changed, 33 insertions(+), 35 deletions(-)
>>
>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>> index d75ecf531b6..2b7f89eaa20 100644
>> --- a/accel/tcg/tcg-all.c
>> +++ b/accel/tcg/tcg-all.c
>> @@ -32,6 +32,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/accel.h"
>>   #include "qemu/atomic.h"
>> +#include "qapi/qapi-types-common.h"
>>   #include "qapi/qapi-builtin-visit.h"
>>   #include "qemu/units.h"
>>   #if defined(CONFIG_USER_ONLY)
>> @@ -47,7 +48,7 @@
>>   struct TCGState {
>>       AccelState parent_obj;
>>   
>> -    bool mttcg_enabled;
>> +    OnOffAuto mttcg_enabled;
>>       bool one_insn_per_tb;
>>       int splitwx_enabled;
>>       unsigned long tb_size;


>> -/*
>> - * We default to false if we know other options have been enabled
>> - * which are currently incompatible with MTTCG. Otherwise when each
>> - * guest (target) has been updated to support:
>> - *   - atomic instructions
>> - *   - memory ordering primitives (barriers)
>> - * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
>> - *
>> - * Once a guest architecture has been converted to the new primitives
>> - * there is one remaining limitation to check:
>> - *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>> - */
>> -
>> -static bool default_mttcg_enabled(void)
>> -{
>> -    if (icount_enabled()) {
>> -        return false;
>> -    }
>> -#ifdef TARGET_SUPPORTS_MTTCG
>> -    return true;
>> -#else
>> -    return false;
>> -#endif
>> -}
>> -
>>   static void tcg_accel_instance_init(Object *obj)
>>   {
>>       TCGState *s = TCG_STATE(obj);
>>   
>> -    s->mttcg_enabled = default_mttcg_enabled();
>> -
>>       /* If debugging enabled, default "auto on", otherwise off. */
>>   #if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
>>       s->splitwx_enabled = -1;
>> @@ -117,9 +91,37 @@ static int tcg_init_machine(MachineState *ms)
>>   #else
>>       unsigned max_cpus = ms->smp.max_cpus;
>>   #endif
>> +#ifdef TARGET_SUPPORTS_MTTCG
>> +    bool mttcg_supported = true;
>> +#else
>> +    bool mttcg_supported = false;
>> +#endif
>>   
>>       tcg_allowed = true;
>>       mttcg_enabled = s->mttcg_enabled;
>> +    if (mttcg_enabled == ON_OFF_AUTO_AUTO) {
>> +        /*
>> +         * We default to false if we know other options have been enabled
>> +         * which are currently incompatible with MTTCG. Otherwise when each
>> +         * guest (target) has been updated to support:
>> +         *   - atomic instructions
>> +         *   - memory ordering primitives (barriers)
>> +         * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
>> +         *
>> +         * Once a guest architecture has been converted to the new primitives
>> +         * there is one remaining limitation to check:
>> +         *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>> +         */
>> +        if (icount_enabled()) {
>> +            mttcg_enabled = ON_OFF_AUTO_OFF;
>> +        } else {
>> +            mttcg_enabled = mttcg_supported;
>> +        }
>> +    }
>> +    if (mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
>> +        warn_report("Guest not yet converted to MTTCG - "
>> +                    "you may get unexpected results");
>> +    }
> 
> [...]
> 
>>   
>>   static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>> @@ -155,14 +157,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>>           if (icount_enabled()) {
>>               error_setg(errp, "No MTTCG when icount is enabled");
>>           } else {
>> -#ifndef TARGET_SUPPORTS_MTTCG
>> -            warn_report("Guest not yet converted to MTTCG - "
>> -                        "you may get unexpected results");
>> -#endif
> 
> Patch itself looks good!  My only concern is moving the warning, would
> it be worthwhile to have a mttcg_supported field in TCGState as well?
> I.e in a heterogeneous setup it would correspond to wether or not all
> targets support mttcg.

OK, I'll update s->mttcg_enabled then.

> 
> Otherwise:
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!

