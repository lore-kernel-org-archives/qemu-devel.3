Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A99CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aOR-000656-KX; Wed, 24 Sep 2025 21:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aOQ-00064s-2p
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:03:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aON-00066a-4Q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:03:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so237307f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758762201; x=1759367001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GR9b4WdERGW/b99tsTZpR6GFrl4nZbTPIjhSJ1iP1U4=;
 b=B4fF9Qo31VUbloEnN/ofUONi3yOCLZkbrIryrZJ6Y/wTqw9uQ5oh8dhQRksfDz5KVL
 0gJx+YeoNZcfhHUrO/Qd1oYCFHCTV/fubKfwhWH3usiIAcLlNw733ojbFHsrNbL3KVC+
 oINS4qn4abREkqbu318IIXRuvlvz/Zr6Doq2vLtmoLC5eLRKA2kOApM+EG5tSBsMueh5
 EwGaTham5Gn/feXSiw73gVa9a3fg4y6ibF2LEbCkkKddw08itBjxVXBR150xCq6xCNf2
 jAIcQCLoBJNQ6ll8YXxA6wu9UmE+eJJpdpYIxbs5wK4yhMMyOfFU3oyUoFM/h4yB1/tM
 IzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762201; x=1759367001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GR9b4WdERGW/b99tsTZpR6GFrl4nZbTPIjhSJ1iP1U4=;
 b=O2JJCtVnV4vatbqAHFQiqhW5bWhXzDb3/7cwSpCpZbT5S1KdpFAY/sdXzsIBULjn71
 yY0N6TcMz0zAqEnB/67OPAVgiwW8h9KcmqdYZrSeMk4ndwXmFQQbEektNDkNsGMMalHu
 4NUVGhz34XTV4Fu/9eu1ReiAw9i7MRsbYOeP79VqgjOo2YUcY6Gex0BIm6OXbuiM4jEy
 UIh1LuIIOli8kO9k84UaUoftgsRglNZjXceAmTgb+jZWRLKLLY/8lOUNvmDGehtYxSU7
 PNpXGg99AKmAe4R6JHq8OUpqTxC5Q2vZL+7umLOD+YSE4a8oTPNThoXknbxkWw5W6erD
 cgfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCL/FvQ/jn17jfvFg/ch5G4g80+iXO0FVfSf4PvYiT6t5BqLejQ06OZgEvSaNlhDjpY1Azc/VZeYj+@nongnu.org
X-Gm-Message-State: AOJu0YyNZs3Fziq01TII+i3P2TN+bcUaIbR3FwS5Pbjc3cRqqBVkVuej
 PwCsjMgdSesqZVF1rd9uxSgt6RLbGwZd/J6OTXSPCygrwmHtDzaX3TIGIqtbJbPMNsM=
X-Gm-Gg: ASbGncuTPFZYuJGUFsEcWUswpaNbBxw3ttDslv1qnvzVJ/6Egl3Vyvv8ZkZpdmL6HfR
 PYu4/zGfqET+RtP7jIlWOC+kTZJscVLhnW06k+2fZBi0leh8IaK7Oo7mr/0QwwrR+yjGb/OIR7b
 471EknsF5TSGA8DakapMO1pDLa/kDu2BjYfQhbwQsOHVCEBAJXIGF0WajF/I9SSAWFnRinVElCo
 9H49mFw3nFAP4zndPfNmgxC5euwWwzG/d23IFt7GYSDzgPpCNhJINImNvsCqVqNilZZsO+Krwfo
 zNi20N2toOZkbaKo88L+3vfMPTkO0SUYVQmJXXaADI3+mcR3x8sq+D+M/l47QWjq0v8xFzTOM1D
 CJpp4AZUWxmylXTrq6hiAOvj2hm5XX9rUSvBOenXOxvvBdnX3QwFRa+krhYfe9dREdffMjHoNTM
 4X
X-Google-Smtp-Source: AGHT+IGMmw1aUOXBsgzsLwZjUNoTIxp7t59yf32e+Wap+utt4Mom7lmG+SwvDZZkIsydXDXKuAAH0Q==
X-Received: by 2002:a05:6000:2388:b0:3c7:df1d:3d9 with SMTP id
 ffacd0b85a97d-40e4a05bf20mr1622543f8f.39.1758762201597; 
 Wed, 24 Sep 2025 18:03:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm52075615e9.17.2025.09.24.18.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 18:03:21 -0700 (PDT)
Message-ID: <61136e91-13ee-4937-b112-1eeffca33612@linaro.org>
Date: Thu, 25 Sep 2025 03:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Access CPUState::cpu_index via helper
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20250924170103.52585-1-philmd@linaro.org>
 <792456cc-6cea-4e97-a1c0-d4dfa8d37482@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <792456cc-6cea-4e97-a1c0-d4dfa8d37482@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 24/9/25 21:30, Richard Henderson wrote:
> On 9/24/25 10:01, Philippe Mathieu-Daudé wrote:
>> CPUState::cpu_index is a target agnostic field, meant
>> for common code (i.e. accel/ and system/ folders).
>>
>> Target specific code should use the CPUClass::get_arch_id()
>> helper, even if there is a 1:1 mapping.
>>
>> In preparation of generic changes around CPU indexing,
>> introduce the whoami helper to access the generic
>> CPUState::cpu_index field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/alpha/helper.h     | 1 +
>>   target/alpha/sys_helper.c | 5 +++++
>>   target/alpha/translate.c  | 3 +--
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/alpha/helper.h b/target/alpha/helper.h
>> index d60f2087031..604af4213c9 100644
>> --- a/target/alpha/helper.h
>> +++ b/target/alpha/helper.h
>> @@ -93,6 +93,7 @@ DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, 
>> i64)
>>   DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
>>   DEF_HELPER_1(halt, void, i64)
>> +DEF_HELPER_1(whoami, i64, env)
> 
> The PALcode function name doesn't contain the 'O'.
> 
> Hooray for 1970's abbreviations still hanging on:
> http://www.bitsavers.org/pdf/dec/pdp11/1160/AA-C815A- 
> TC_1160_MIcroprogramming_Tools_V1.0_Nov77.pdf
> 
> I think WHAMI was a pdp10 instruction even before that, but I can't find 
> docs.  :-)

I read a bit on PDP-11, but never on PDP-10. Thanks, this was
interesting! I understand 8 extra bits in names were expensive back
then =)

> 
>>   DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
>>   DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
>> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
>> index 51e32544287..a757a558900 100644
>> --- a/target/alpha/sys_helper.c
>> +++ b/target/alpha/sys_helper.c
>> @@ -73,3 +73,8 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t 
>> expire)
>>           timer_del(cpu->alarm_timer);
>>       }
>>   }
>> +
>> +uint64_t HELPER(whoami)(CPUAlphaState *env)
>> +{
>> +    return env_cpu(env)->cpu_index;
>> +}
> 
> It's a correct transformation of the current code,

This also makes the code simpler to review for those not born with
ability to compile TCG mentally :P And ease adding tracing & co
(the performance gain for not calling an helper is not relevant here).

> though hard to evaluate without further context.

I'll post v2 removing the extra 'O' for completeness, but don't mind
to keep carying locally until more effort is posted.

> 
> Aside from the extra 'O',
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


