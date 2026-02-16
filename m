Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBD3E63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 04:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrqbA-0002ph-Vu; Sun, 15 Feb 2026 23:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrqb9-0002pP-4g
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:52:39 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrqb7-0002cJ-JH
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:52:38 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so10757655ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 20:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771217556; x=1771822356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04tymg5hP9G9ie/NCLoqkR6b1BxqLj3OWi1/XfjNmEg=;
 b=Omvj6OCJ/yqOIEv7xLLTFrcPhPaY26aNctFou/4/sYfv5itdnUc6e6mERAOSap3kUj
 KxvfUjultZTpgNS0Pxs3J52QJZH7UbDSqpD8hLQHBn5JSQVFRyCQeqZThJtwK8Vh1l2x
 JbjZYVftHcf/zLs2LtxHa2gxPHw9s16vCgwyVGft/BGcUraKHfmK1xa2rKp5bkDLO02y
 jWG8dX2d9LdWCC6p7aYiCovh/XP2Hi7L8xX0bdeXPDMDnkXQGIzCsvWxmSw0bN3D1UBQ
 /jQSThSPLkK1om2GI4nY6j+cvZjfadnoZ6I3UgVlLKYQWYfzf1CUMpAs2U5V1vRCA7vC
 1rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771217556; x=1771822356;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04tymg5hP9G9ie/NCLoqkR6b1BxqLj3OWi1/XfjNmEg=;
 b=q598m5sy0gY4aHZGdCQ8h1LGTMArmZTUEau4fUXplNmxiVWYKwnGDXeMBt6iitAs2G
 fcKgV5s0iWDaAXwxvbu+6EE8DQqA9ynTFY2CFUKkuYok+LO/m2NX/cd4sOTUdGwj8fJP
 yc2VkRGtemqXjlhVM3v0TksS+uNo1PKWCGtc3QsquD8myAt2ylo7IpKOt7KsZ/6+CL7E
 XRI5jkY6WfFvF4LjJxABpysmIJSq/NqUAr90VGFyNGmVEeYmZc1xfG9/LvovvThTbN2o
 pj9DcxDCK++0WzxwvvpiEmd+v+mVAgpRbPhg07iTxQO00UveEDD7+mJ+Hn2eTxvq6AOC
 yJag==
X-Gm-Message-State: AOJu0YwKZx5QPwZR91rIBHIg3TOxvB9v4qtAYcnfX5KIiCfeA8JnbnSj
 Hr0H+hYLZmhrNo+lKaQhmzzqayIhRRdK8XAwhJ7LS5RWPT934xOFlGKTRrfWme9e7JucoslAcKA
 xU3x8Teg=
X-Gm-Gg: AZuq6aKbFvNyq1lLlmwb/kPOu96SPFJcVbcnYV0L1sG/0VsUXs4n+qFqAC6yTGFpc/c
 lebtQXEGlu8UJZeLg/UTWAojiJOq5jgHuVLHE8mawuWey6EJWGL/09Sl5Qmf1/RcL2fWTCQKcQ+
 crXdimbBr9h23mv13WgTIJwvKuXQZz0q2C5q19WdX2mrk6/wB6LyuVckv2CgyFRN/rCWFYUB6pJ
 Xv0kKtpCnhgWZGptz/cqJ7Oe7a+P+YbhqqoDoASYu8JOsy3092cLgWOhxLIkK0wKTiOghYYXMsX
 gB9h/4n6ctdxR/T0LWaHZxCdrWD9p5qIV36jSGoTAjLdoAQnqtd1LLAU8wW7TzSMHXR1hAW8F8h
 TOEa5rxr3fn6UgOxuYgBOTGeWm5HtW1aetrBs08QYmBWt7oYbW4d8j8M9ypFb/RmnG9N7p73ePz
 biV7CoauJsgf705GI0pp6YuqaW1HFS+zCZUfEzraw56M6zjt5WbAQ989RrOhPhRbolcAYRWloiL
 8bIv61vq2anzEIXr/mFvPqj9N7IK9qGdbuifxwh8uA2vfkY6xjZ
X-Received: by 2002:a17:902:f64b:b0:2a9:2942:e15a with SMTP id
 d9443c01a7336-2ad17450767mr74472145ad.19.1771217555550; 
 Sun, 15 Feb 2026 20:52:35 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:4a1:428a:70f2:5844?
 (bg30dhzm5ftjb9d57pjq.ip6.superloop.au.
 [2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d5c3esm61327915ad.47.2026.02.15.20.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Feb 2026 20:52:35 -0800 (PST)
Message-ID: <4f06f566-c6dd-4b90-baba-342a0dbacc57@linaro.org>
Date: Mon, 16 Feb 2026 14:52:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/13] target/arm: Remove aarch64 test for kvm
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-3-richard.henderson@linaro.org>
 <D63EE934-C780-46F6-A944-0786463BE8F7@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <D63EE934-C780-46F6-A944-0786463BE8F7@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/16/26 14:23, Mohamed Mediouni wrote:
> 
>> On 16. Feb 2026, at 04:44, Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> We no longer support kvm for aarch32, therefore the aarch64
>> test is trivially true.
>>
> Hello,
> 
> Probably harmless but aren’t AArch32 guests on an AArch64 KVM host still supported?

Yes, via the aarch64=off property. Here, we are only concerned about adding or not adding 
the sve property set.

Note that all properties are processed much later when we consume the command-line.  We 
can't conditionally add properties based on other properties.


r~

> 
> aarch64_cpu_set_aarch64 in target/arm/cpu.c unsets ARM_FEATURE_AARCH64
> for being able to support that case.
> 
> Thank you,
>>
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/arm/cpu64.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 5d7c6b7fbb..10c6796548 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -767,9 +767,7 @@ static void aarch64_host_initfn(Object *obj)
>>      ARMCPU *cpu = ARM_CPU(obj);
>> #if defined(CONFIG_KVM)
>>      kvm_arm_set_cpu_features_from_host(cpu);
>> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> -        aarch64_add_sve_properties(obj);
>> -    }
>> +    aarch64_add_sve_properties(obj);
>> #elif defined(CONFIG_HVF)
>>      hvf_arm_set_cpu_features_from_host(cpu);
>> #elif defined(CONFIG_WHPX)
>> -- 
>> 2.43.0
>>
>>
> 


