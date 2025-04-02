Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C92CC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyGx-0001X8-5z; Wed, 02 Apr 2025 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzyGt-0001Uu-Os
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:36:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzyGq-0007Zf-DS
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:36:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso47045475e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743601001; x=1744205801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJfVCNOyKlIn5SjHIiikLpbH+IBtLpw1jWMX+o/dVSU=;
 b=w2a9jxw2XaFDt466865oWY+9sfFB0HcT/qyhrcmUVDYaVgTcc60hTzCjModLYXqHhf
 Darzzr/DaY/g+UaNFS5zF5lrJrkP/l0JGdK/s7aif5AtpK8wNrNftgzTe4QyyRG9X0Rp
 UGfMcTdNqjDX5sEc4WcG4DOkD40OEjwF3+fD3ScLxY/bKwQ2olzkuA17Gn165/Arl4m5
 P2l7wJ+dQ32p8wZd5vu5Bros93++1IdJt42BY/Jv+PV5w2J4JddafdZSEWjC6vsW98HH
 UO58cjQNAS9mnrTYnvYUqSeaGY4PE/6TqAH6yYpzWpYG3L/IA02V8p9t1is+u0i9mbku
 P+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743601001; x=1744205801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJfVCNOyKlIn5SjHIiikLpbH+IBtLpw1jWMX+o/dVSU=;
 b=qMumkQTZ30nlwJNjB2wNmRTtbv+ecK+VNiov+dewlT9eNRqXp54EcrzaktBtPOSka7
 QIBILW7+KU5222jKFWXELBkZa+YtSbkR+0Vk6vZhsvVxz/nYD4+kLmFNoq+K8k7LjEtE
 UnsKmxlswMXXmGl/mBjOEcseAcdsJ10wVb5O7GMgV3GtjTyX4VDkSIKaIC+tcIqV/bOP
 VrYdPwJ9ae41PLyPg7rvhJg/QpdwMATxwywAb6OlFN3HR5etGKKd5+5Rb9JzDixbVB1U
 tUcwhqrTuvxr9t151Tqqw8hYb0fDkTfDTI3AbpyrRzbpL12TiMeLRSf04g/QUTdBX6aA
 Y2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqLTLQGe5NkPw4WXqAwjr/hOQQZYcJvIKrTgAYRXZcxDYc3mgBrFdUkv8sxkUoAVKZ2fvT6jzoOlkZ@nongnu.org
X-Gm-Message-State: AOJu0YxAZrziP0XVOZeLCoxE2Ku/CoAj2ifWFZdJYh3Upz321UtiXm78
 dg1Xqx9DH6mTmKbxRZXMZ+iv+m+9D0ulqUuKvfEC4XtxCBeWoOa1jN/Wci5g+dM=
X-Gm-Gg: ASbGncu92W38KpXWLY9saJweLUFGEMEuSkG2TKhmlBLqfEyRufZx8+sC4D4Aa68Xrvp
 djv8UeTTwFmZ1/o1Ga1geA00F1gWrvmsf4aoXQPXtQJh9jpM9SapcGkFR97LgZxlRmVXEUAAgO4
 s68coqU4SzrYLCsKkXrIVmVepAKYv357wlYVjEQQFCfXEn1+QTDcwE9jKnFJYJ4+dYRX+URSc1K
 TCTrss0FXyBzM674etDKM2ltPJdrEqOobii9SZ3giLrlxaR+TVlWg93bDzIEG6dv8H8fi/cbOEm
 F0eMJWjR34K8pcjtz+a2mv6YJ3l8CQ/wlGiIB2/vVKsLhlcd1Y6YdtqUsiptwiFW51qNIBw3MHE
 qi9Bmaf1Hx9cg
X-Google-Smtp-Source: AGHT+IHoyscVn8p5jxvX72Ru3UvDJ2OXxx0IAldkyjAZ5Adle9QLCIrr4AZ9ithEY6/SyYpc+bvqUQ==
X-Received: by 2002:a05:600c:1e22:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-43db8526564mr178633115e9.30.1743601000940; 
 Wed, 02 Apr 2025 06:36:40 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6588e9sm17432591f8f.14.2025.04.02.06.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 06:36:40 -0700 (PDT)
Message-ID: <ca52ecb4-6c1d-4299-9764-5839db2d013e@linaro.org>
Date: Wed, 2 Apr 2025 15:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] target/arm/cpu: always define kvm related
 registers
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
 <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
 <11b5441f-c7c0-4b4c-8061-471a49e8465a@linaro.org>
 <428e6fdb-24b9-47a2-9d3f-4ef5c2e1a0ae@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <428e6fdb-24b9-47a2-9d3f-4ef5c2e1a0ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/3/25 02:24, Richard Henderson wrote:
> On 3/24/25 14:11, Pierrick Bouvier wrote:
>> On 3/23/25 12:37, Richard Henderson wrote:
>>> On 3/20/25 15:29, Pierrick Bouvier wrote:
>>>> This does not hurt, even if they are not used.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    target/arm/cpu.h | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>>> index a8a1a8faf6b..ab7412772bc 100644
>>>> --- a/target/arm/cpu.h
>>>> +++ b/target/arm/cpu.h
>>>> @@ -971,7 +971,6 @@ struct ArchCPU {
>>>>         */
>>>>        uint32_t kvm_target;
>>>> -#ifdef CONFIG_KVM
>>>>        /* KVM init features for this CPU */
>>>>        uint32_t kvm_init_features[7];
>>>> @@ -984,7 +983,6 @@ struct ArchCPU {
>>>>        /* KVM steal time */
>>>>        OnOffAuto kvm_steal_time;
>>>> -#endif /* CONFIG_KVM */
>>>>        /* Uniprocessor system with MP extensions */
>>>>        bool mp_is_up;
>>>
>>> I'm not sure what this achieves?   CONFIG_KVM is a configure-time 
>>> selection.
>>>
>>
>> CONFIG_KVM is a poisoned identifier.
>> It's included via config-target.h, and not config-host.h.
> 
> Whoops, yes.

If we go this way, can we consistently allow CONFIG_${HW_ACCEL}
(read "remove poisoned defs in config-poison.h)?

