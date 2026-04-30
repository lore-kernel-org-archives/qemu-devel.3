Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88498CD1297
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKYU-0001Tf-1C; Thu, 30 Apr 2026 02:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKYR-0001TI-VF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:07:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKYQ-0005DJ-8u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 02:07:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so6551285e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777529237; x=1778134037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CM1QpRGwe4fxOogzXqaymSoudqNNvTlB1wkNCmr7Vo=;
 b=tpWH/YCOibqDa21TsblO1A4T9qvaxHcDJ/YKZ4fXhMhWEL4S2nciLDgNO5FAULLjkC
 WXm8MoJ1LNB5nRl6E8teeztRHDW8nmcYEgCTUg/2r5EesPMGIB4UmuS8gKY4TlNnU8jE
 Q2tG/AsXPhUpOqmPv7+MTkjsnmhlUaeMILw5+yHOo8uST6nvRvFxHcsFhcPzY9XuU6gr
 nClnjJKK3fF0yHiPBGMVKNXWF/a5o4oeNU0MUzUJqoFoykrsweFdg+ii7KQq5Jr+CLL9
 xF7wh/euG3VEBTQjJQR3too3CiVVnRE31oviP5C9DX6dmVKs5wczCwbHY85Giy5lxa8H
 zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777529237; x=1778134037;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3CM1QpRGwe4fxOogzXqaymSoudqNNvTlB1wkNCmr7Vo=;
 b=a9nCFQeGbATeVksk2UcDfwAGZQeI7swzv8/YbwLvfHBhuKAT1D5FEgxlXM2t4CnY8S
 KZDE5Bo7lemwgovqkkxbBrAc9Xhf6jOfUPbIH/s0yf9dQ9sQIvT0hxJ+apWSpGfsmY6Z
 jYcPxz1x6gM086bRAG9OAelY4Xp/wyCr2AzrSS5nd3OKODCVJ4A4jsOV9H3g21gZH2PR
 JCLb1vLm1zbGgvQc1UCrxWYAXVAcIlMLqYkBHhek1sSyJVqgZ6FHUtIyVyAW88hsFRyW
 lUxWDEDBUVB1FnW7tlKZ/r2FyDUT3YS+ZTFOtFJpctz5ycVeXa7skqUlddz70WsCnpqA
 FlJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8THR096SG8aXFUpphLKP/aaI8cUII+GgWzhng1HV5JrnKWqD0YdDpTarTPIhD1XPxhM74PVq7ssRKs@nongnu.org
X-Gm-Message-State: AOJu0YxCmz7k4bOF9BGouuqT/EkQF2vUBjhmHJcfvqahOVN0iIBrepb0
 wlshk73uNz7jbh6Y+2saL+AVkU/cx2z8+UPx81ulAKS+9LcuadqvQHV3HZ5q/YtBDpc=
X-Gm-Gg: AeBDievRs+0qGWCLtkeUoetekxsF5WzOSBqQRBtgDAHxRYOvtPiA9fJdkCAmhbGDkut
 mu1Fa0X+BcwqpRGbpyH6YPTOeDe0eUDMnnZgnTuxYRj4mJZw+vk0rs2FXTsg3XHWW1RDZtNiiTT
 e1QpzlCRk5Cc2sDT9pz3i+AMsyUm9O+RY5Wc7ZDYH7MhaS7h2F/CBoEr2oU4OlSXU3KouGom/Jy
 rRbNieBaE4KuqhpcgbwLrlTHWbbcJVfJfsa11TULSAeEIlrB/rffXpiCt1lp88AFIbcTERY8pc7
 q70Ts4ydG/+knEfO4DLjROuqHLUttTv1RwDYSVAeie5b4h8ySiTG31d15cMi5kha2or+W/g//TL
 5j+fZXp2NmXXJaECnLMHHJZjp3kUnmNCWNxHiKoA5xG/OdEI1naNp1eDZt+1n3SkruBRKeErpqT
 YZfR2VAaLeBy4WcgFlbJdEDOF08dnlsiqteXcTJ9RJFF6+kzoDxGj0MjRXbFh1RFk4L7vW+aJLU
 U1pu3Hwh5hi1z0=
X-Received: by 2002:a05:600c:a110:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48a84470807mr17284465e9.19.1777529236514; 
 Wed, 29 Apr 2026 23:07:16 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed6bafsm67918315e9.2.2026.04.29.23.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 23:07:14 -0700 (PDT)
Message-ID: <16b3c3a7-2f1c-488a-a416-36979d9901f0@linaro.org>
Date: Thu, 30 Apr 2026 08:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/vl.c: inline qemu_opts_parse_noisily() result
 checks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-4-guobin@linux.alibaba.com>
 <708ac3f4-bb55-459a-9506-77751133c973@linaro.org>
 <feda4269-fe96-4c73-a87e-c3181b43efdd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <feda4269-fe96-4c73-a87e-c3181b43efdd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/4/26 23:03, Richard Henderson wrote:
> On 4/29/26 18:04, Philippe Mathieu-Daudé wrote:
>> On 29/4/26 08:20, Bin Guo wrote:
>>> In qemu_init()'s option parsing switch, several cases assigned the
>>> return value of qemu_opts_parse_noisily() to the shared 'opts'
>>> variable solely to check for NULL, without using the pointer
>>> afterwards.  Inline the call directly into the if-condition, matching
>>> the style already used by QEMU_OPTION_action.
>>>
>>> This affects the following options:
>>>    -drive, -numa, -iscsi, -m, -mon, -chardev, -fsdev, -fwcfg
>>>
>>> Cases where the returned QemuOpts* is subsequently used (e.g.
>>> -acpitable, -smbios, -virtfs) are left unchanged.
>>>
>>> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
>>> ---
>>>   system/vl.c | 37 +++++++++++++++----------------------
>>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/system/vl.c b/system/vl.c
>>> index 0e1fc217b4..0e0d3cb761 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -2961,9 +2961,8 @@ void qemu_init(int argc, char **argv)
>>>                       break;
>>>                   }
>>>               case QEMU_OPTION_drive:
>>> -                opts = qemu_opts_parse_noisily(qemu_find_opts("drive"),
>>> -                                               optarg, false);
>>> -                if (opts == NULL) {
>>> +                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
>>> +                                             optarg, false)) {
>>>                       exit(1);
>>>                   }
>>>                   break;
>>
>> For clarity I'd also squash in this patch:
>>
>> -- >8 --
>> diff --git a/system/vl.c b/system/vl.c
>> index cab8106984a..237334236aa 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2842,3 +2842,2 @@ void qemu_init(int argc, char **argv)
>>   {
>> -    QemuOpts *opts;
>>       QemuOpts *icount_opts = NULL, *accel_opts = NULL;
>> @@ -2921,2 +2920,4 @@ void qemu_init(int argc, char **argv)
>>       for(;;) {
>> +        QemuOpts *opts;
>> +
>>           if (optind >= argc)
>> ---
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> If you're going to move the decl, the innermost block is just below with
> 
>          } else {
>              const QEMUOption *popt;
> +           QemuOpts *opts;
> 
>              popt = lookup_opt(argc, argv, &optarg, &optind);

Good catch.


