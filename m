Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA48D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYRi-0004Pe-B0; Thu, 27 Nov 2025 04:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOYRf-0004P0-Rm
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:37:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOYRd-0001cX-GB
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:37:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso423781f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764236263; x=1764841063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aV9iA0fqbIWmmeGD4DmNrXoNJ4DDWFmQV1y96XwQ2Q8=;
 b=yvYhGXCAywronuebldbIU2mdDTGYqvEs7LF6qguDMB5fhBbn5sLPkHgiMCdhPL3Szo
 srs2FlGcGUbTEdAQAR+PAsqZ6cUE93JHDKUyoctRr04HJXNkZJmBrhW9vdfhpZMtN0G8
 hReZZF8fq4fifgxuNIuOUyiyIP+cZZw15lPC/x+yJZypO/ETiyBEDahO5ah4JhOt5yMo
 NlgP19CaO4oTYV3+Sg0Ufo3/s+5/jaVvTZiaw1Sw60N2V9yV4IgUkVRX8CM7vQglxWnp
 h4EWWrYYmZnh+LFM9l9KUPOV5IC5f4ftay+YRVv8UeVdzOY2KxVy47UxmrIMxHBmh1L/
 P16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764236263; x=1764841063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aV9iA0fqbIWmmeGD4DmNrXoNJ4DDWFmQV1y96XwQ2Q8=;
 b=E8CwzSmwYqyoB33qNVLjccWq3d9UaZmWR+tu6Qlyvf7YQJOXNoA12AOjqfg74kh3OW
 V9uv1gsFZaDRmiet/bB+nZRU+JDNRyNvHpW9c9SAiBuf11T71EiSyIaQSzTbT3Hoyb0s
 qgK0VZcqGUXQdQ39dPHiQ9rZAd0kj4hbmPC1yvq8+911Mq9l+oZPktYePAerjiSWkGJU
 00oW+nJdlxg8BE4OSA2SsbKPeMHIKYUA2+Lj6Ejrf77bSV6vHu/Z9wLC78UTSclKT0pW
 k4CBKp7jAeXMa5k/gmn5jb03AxIDs1S9xfeDHQNvZ6lhylW3iIMpXpsbHFKZqiU64Ikd
 6vkw==
X-Gm-Message-State: AOJu0Yxf7Xl7spD4pIRqTcQIDzmb9HbzPkZfkhB6WsPEHq4ApowCW3vZ
 rMD5/KdiFvnc59C17dnrCOJgpGXgsPzuMuT3XRWhNoKpm15nRMjP4vmd452VD1GuYbA=
X-Gm-Gg: ASbGncufT68snt/iCPUbxFvUNR4Flo388nI19zu1rkiQeqdr/Gtm0soZBscdiSD/T/a
 hg29om6sbht3hqMugpHRL5+YBtKXQ9UwHhW+kiUV+guF9A7Iv8hFxv9CD0fF/2e5wpQzC3fmM2j
 SNeqLxvmXq1fTB2Hq8TZ5VBKQhiX/JE78j6mbqcj8pFOOHFNLHdol8rgNVSJ+JyAjlIwfyovrMx
 hHtiv6+qYj7vxWp7oMbJCsOPrbChcKFODsM2oFXdwqB7NnwZhGV+y294DGICj6NZeyzAc+fZtco
 LWVNizTylinf8Nvf1hB3f7os0KrpoEyQuvHodCnb2JopJ3HHhUymO52tOoAKw0UZrdI9BJ4P3G3
 KeS9gd9rteRzzFB1BPCgdrWXC6w19fFiEaAsHNdNyCTd5LM2/bfxoqkDzn1QFO49QwC88q7ue1W
 rzqBauHj1w/KFog1PnNjaQkZuqzGXHPyWtF+GxYW92XBZcWEUR1GJtuVzVFhTHuVVa
X-Google-Smtp-Source: AGHT+IF1YkLHAV8k5WeKHn5PCmOwl57wvYilZ70OtdIIB5JnGzCehIDuI5znjAzuzkeQf2zkHYDK+A==
X-Received: by 2002:a05:6000:184d:b0:42b:2de5:251e with SMTP id
 ffacd0b85a97d-42cc1cbe567mr23304697f8f.26.1764236263152; 
 Thu, 27 Nov 2025 01:37:43 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca8bae9sm2321476f8f.33.2025.11.27.01.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 01:37:42 -0800 (PST)
Message-ID: <509fe01f-cb50-4428-b085-25b026e15287@linaro.org>
Date: Thu, 27 Nov 2025 10:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/xtensa: Implement xtensa_isa_is_big_endian()
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241205232437.85235-1-philmd@linaro.org>
 <20241205232437.85235-2-philmd@linaro.org>
 <CAMo8Bf+621bwyf523i_P11q7rgr=DgpcPPdyh2vaiixZRqN3_Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMo8Bf+621bwyf523i_P11q7rgr=DgpcPPdyh2vaiixZRqN3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Max,

On 6/12/24 13:35, Max Filippov wrote:
> On Thu, Dec 5, 2024 at 3:24 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Xtensa internal fields are opaque, only accessible by
>> the Xtensa libisa. Implement xtensa_isa_is_big_endian()
>> to get vCPU endianness. This should be implemented in
>> libisa, not QEMU, but I couldn't figure out where to
>> contribute this.
> 
> This is a beautified version of what xtensa has in binutils, but
> binutils is also
> just another user of that internal Tensilica library. Perhaps I should make
> an artificial "upstream" for this library just to track this kind of changes.
> Let me look at it.

Could you add this method to the Tensilica library?

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/xtensa/xtensa-isa.h | 1 +
>>   target/xtensa/xtensa-isa.c     | 7 +++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
>> index a289531bdc8..1cb8e6ccb66 100644
>> --- a/include/hw/xtensa/xtensa-isa.h
>> +++ b/include/hw/xtensa/xtensa-isa.h
>> @@ -829,6 +829,7 @@ const char *xtensa_funcUnit_name(xtensa_isa isa, xtensa_funcUnit fun);
>>
>>   int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
>>
>> +bool xtensa_isa_is_big_endian(xtensa_isa isa);
> 
> This file doesn't include stdbool.h and other boolean functions in it
> (e.g. xtensa_opcode_is_branch()) return int. I'd suggest sticking with
> that. With that change:
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> 
>>   #ifdef __cplusplus
>>   }
>> diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
>> index 630b4f9da1b..36eb4bcf3d4 100644
>> --- a/target/xtensa/xtensa-isa.c
>> +++ b/target/xtensa/xtensa-isa.c
>> @@ -1741,3 +1741,10 @@ int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun)
>>       CHECK_FUNCUNIT(intisa, fun, XTENSA_UNDEFINED);
>>       return intisa->funcUnits[fun].num_copies;
>>   }
>> +
>> +bool xtensa_isa_is_big_endian(xtensa_isa isa)
>> +{
>> +    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
>> +
>> +    return intisa->is_big_endian;
>> +}
> 


