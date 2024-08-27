Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC466C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyTb-0000fd-6k; Tue, 27 Aug 2024 11:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siyTY-0000Ry-BF
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:51:20 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siyTV-00058E-Fa
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:51:20 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f43de7ad5eso72916361fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724773873; x=1725378673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHE92zBIX+0D6N7NheH9EaVSZNf7+Gk5JQmWmIhX+D8=;
 b=w0aQ8czMmhYuATz2DvIL0MlkDxrtjHKc7UJoQEC0f55HwrSNn2j2MY1C9VMzPRc9k8
 3OB7UPuldeMtQhM8jLMc/ALcVW+lxSo+6DcR1xznH9aKJPi0BYHE35A1hAzHAGULopsM
 j13s5MNmtH0xpFwRLLodKg3775867HpCrxgG2qHcw/sRA2nKmUblUF0D2x96S3qCBkxn
 xpSsA0fbmu+WX1VrGsCImSru4gNsELqv6VL1zpKfQVMfpcJWS6DbSQQYFkEGHFVvvFy5
 6RIuWePMPol1ghmLP0KhPo98vxxBoWNytmr8QxnuC196jf4tbEAOU8J+u0MaNhg0AXKi
 piMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773873; x=1725378673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHE92zBIX+0D6N7NheH9EaVSZNf7+Gk5JQmWmIhX+D8=;
 b=O9O5vg5ifgwtkTfd1GadFr177Pqdc6TQiEE7Bjvw4WySn/fKWebJmLEpNq69pAU3Vs
 a8NPQBoLmgTc37+DOp5UJJy7GY4S+nM35MzhwApxEseZ1z4FzDcIXgEdXGMS1C7bV27j
 UNSyM0Y/HXzEsRogj8ulO0Sc9FINbN9VAIy1+04K1U+1GvRkXek0LYJbp+FhUI3OqtdN
 q6lQDZzoHyRJk+l9+PEo4zX7yylHIzmsvFEAmF/3YYY0yh4uBjyQiCJGluU6yoXAQIK0
 unzwoko9PyRQDg3fFcgAUC7ck+NJtHE1lQnNHH+2tXubgx6SyENFC0e84dW4w8eLuVv3
 nOpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7jC6O3APLtl+MUM0SGHmCPc3GR/VTw5qOOli79tu44njTafHedsaZur0aSSsuZCgBHOIlLtK4MYS@nongnu.org
X-Gm-Message-State: AOJu0Yy0iyOG2pCx8KRvGbPiLedyl9Zg1sW0QgIZvY/v7LMjVY7NRzGg
 GoCT9YxNHBKh36r7/+ofya+cT74vOMhfqrdkoaRsVfgA0ztMJ0p4IRE28niVr+w=
X-Google-Smtp-Source: AGHT+IF4GUdaPViHZ3ADimfTBiE5aSLDpKRURt2AV65N4vrVSW52LncA9AeI9P92ECTRolq8WJHuaw==
X-Received: by 2002:a2e:811:0:b0:2f3:ed84:9e66 with SMTP id
 38308e7fff4ca-2f4f48eeebemr81128081fa.13.1724773873253; 
 Tue, 27 Aug 2024 08:51:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb471e0csm1132497a12.78.2024.08.27.08.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 08:51:12 -0700 (PDT)
Message-ID: <1db29701-e4f3-4376-b79d-cb7ea303a129@linaro.org>
Date: Tue, 27 Aug 2024 17:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240715084639.983127-1-chigot@adacore.com>
 <CAJ307EhvEYa6owtcXmjnBp_9k3HQXbbpbQck9pgS5d9wXgxfGw@mail.gmail.com>
 <CAJ307Eh8aKvdi7kifGO0RoEpmyEXt9b7oYmYvFtw7KjgyepGxg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ307Eh8aKvdi7kifGO0RoEpmyEXt9b7oYmYvFtw7KjgyepGxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Adding Cédric

On 27/8/24 13:49, Clément Chigot wrote:
> Hey,
> 
> Gentle ping
> 
> Thanks Clément
> 
> On Mon, Jul 29, 2024 at 10:33 AM Clément Chigot <chigot@adacore.com> wrote:
>>
>> Hi,
>>
>> Gentle ping + CC missing maintainers.
>>
>> Thanks Clément
>>
>> On Mon, Jul 15, 2024 at 10:46 AM Clément Chigot <chigot@adacore.com> wrote:
>>>
>>> The BookE decrementer stops at 0, meaning that it won't decremented
>>> towards "negative" values.
>>> However, the current logic is inverted: decr is updated solely when
>>> the resulting value would be negative.
>>>
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>> Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
>>> ---
>>>   hw/ppc/ppc.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>>> index e6fa5580c0..9fc85c7de0 100644
>>> --- a/hw/ppc/ppc.c
>>> +++ b/hw/ppc/ppc.c
>>> @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
>>>       int64_t decr;
>>>
>>>       n = ns_to_tb(tb_env->decr_freq, now);
>>> -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
>>> +
>>> +    /* BookE timers stop when reaching 0.  */
>>> +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
>>>           decr = 0;
>>>       } else {
>>>           decr = next - n;
>>> --
>>> 2.25.1
>>>
> 


