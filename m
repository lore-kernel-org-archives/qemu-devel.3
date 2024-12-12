Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E83E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpaD-0001WS-Ee; Thu, 12 Dec 2024 15:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLpa5-0001W0-HA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:14:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLpa2-0000XH-Pv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:14:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so10958765e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734034476; x=1734639276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcMdh8cqoXMcKf5bh19K8M/QQOI3MjTsc7kIr//a3cY=;
 b=pYjk4zvAP7P8HuEUSlA1KKCSyka7iJmduWVGqUcuyMk7BFik2wZI+iSlrp9fFnafBo
 PWoubw71iqymRlWLzRqWVgwnjoOabyS2t5/5HZTbPyZD4jXioTu0kkbVY/a2hQCTLIDt
 5lblSOHs72g/oCyi+hIx7P3pZhzOCvOi6+vDt3mmJuFpqfNlDLW1S1dYp8uLRBbfxkdd
 TvjcEMrsefhfdv/EDbsHxkPqTNwuCjvHWNco95etkFL+Ts3CoapFaTzhsP+VowlOu7lY
 kxZeAB6vYFHvrWDeLmL2Oz+5LsrxKRH0symIuV868Ev2bf7tKrusUVHiegnPApk7vzFk
 zMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734034476; x=1734639276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcMdh8cqoXMcKf5bh19K8M/QQOI3MjTsc7kIr//a3cY=;
 b=CGa8Zlntt53Er++sUyW+ZVYL8vvVcs/t2un11pYD5VrPpDcJ7zOdFLZDO5w/RWdwbg
 YYCmKNek77G1jw2EE316Nd0fncFFEUbSLe3SjGLsojTMFTCd1FhZWYsawZP7j0355KL+
 aJSJM36bJZshtpYSmSUNFnQ9OqKBH4JwEkviasGDqtfsDE6xPrQzMT+ukm4mMiENSmlr
 fUDk21E7u2LUdN7duHtlTvQvLnv8ok9EtBxYJjk42jY/Kcb1I1xtYyv1AeLzTviCbLPL
 J1o6Qs+K2bRp/sWO3L082foAzc2XHkFnxHkoomCZFIOEjMLZQZlY8Wr2CMtXA0bAELjs
 u/kg==
X-Gm-Message-State: AOJu0YwNLVTUsgvE8Go4NYChiiWc1Q75plWGAsEEiHajSLK6ksWtxsJz
 KfL0iYGX2RXSZcuqGJiyMUgmlQ7raEIzIo0PVTXTVnrBt63wwqX2O7UO0PFetuI=
X-Gm-Gg: ASbGncvgcr6HsarXisep+V16s/NHXyf98zvQyY7NRQMYyCwkYumlnBapZS9ZK5gkn75
 de9mS69AT/rlQpWPDCumJe3p3qdWc0esVPgmkW/kp7rvhakr8dfBtLdPl0HDnmeo28qEQ2G9jWP
 QKVs6w0V5ZjZnv9bO1vB7pvni9L+NuSmgmrk9Gj7bciQ2ogbstUvNJhxk6Dl1sd/+Ibt4b7MGu2
 9u1GQddl4TAX+0fhIP213g4d3h0H+tQXxf/EyoIzE3LsXRvHNZhIxGAzc7Y6a6/CCBTzY7NYr4z
 IQhg4CZAZHszULi8rTYFlR6u
X-Google-Smtp-Source: AGHT+IEbgLtp5g9RUoJIVnVj4as6vKCQbYtjLo+ANvj+fENp2ffSM9yetapvhiSBNUcN/uwYf4qk/w==
X-Received: by 2002:a05:6000:4705:b0:386:4312:53ec with SMTP id
 ffacd0b85a97d-3878769113emr3893051f8f.17.1734034474715; 
 Thu, 12 Dec 2024 12:14:34 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251db4asm4812766f8f.96.2024.12.12.12.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 12:14:33 -0800 (PST)
Message-ID: <f410fcaa-ea8c-4168-b119-5a73f9ecbc0f@linaro.org>
Date: Thu, 12 Dec 2024 21:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-3-philmd@linaro.org>
 <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
 <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
 <1a36f9f9-3783-9d40-7e85-b0ff290e3857@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1a36f9f9-3783-9d40-7e85-b0ff290e3857@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 12/12/24 19:55, BALATON Zoltan wrote:
> On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
>> On 12/12/24 14:11, BALATON Zoltan wrote:
>>> On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
>>>> Only physmem.c includes libpmem and libdaxctl headers.
>>>> No need to pass them to all system_ss[] files.
>>>
>>> I think doing this patch first would leave the other one unnecessary so 
>>
>> This one is about libpmem / libdaxctl in physmem.c,
>> the previous one is about libsdl in vl.c. I'm missing
>> what inverting the order would change.
> 
> It seems odd to add the libpmem, libdaxctl libs to one set in the first 
> patch then remove it right away in the next patch. Swapping patches 
> would avoid that and move these to the final place without churn then 
> the sdl change is simpler.
> 
>> Besides in 2 patches it is simpler to check what CPPFLAGS are applied.
>>
>> Anyhow if you insist, I can squash. I don't care much as long as
>> we reduce the flags applied to system_ss[].
> 
> I don't insist and don't mind much either but I see others also 
> suggested squashing patches so this will be resolved by that.

Nah, you are right, I didn't notice. Besides, Paolo and Richard
showed me I don't understand clearly meson dependencies. My bad.

> 
> Regards,
> BALATON Zoltan
> 
>>> you could do both in one patch with less churn and maybe reduce this 
>>> series to a single patch.
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> system/meson.build | 7 +++++--
>>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/system/meson.build b/system/meson.build
>>>> index f7e2c8b826f..50d915bd80c 100644
>>>> --- a/system/meson.build
>>>> +++ b/system/meson.build
>>>> @@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', 
>>>> if_true: [files(
>>>>   'arch_init.c',
>>>>   'ioport.c',
>>>>   'memory.c',
>>>> -  'physmem.c',
>>>>   'watchpoint.c',
>>>> )])
>>>>
>>>> +specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>>>> +  'physmem.c',
>>>> +), libpmem, libdaxctl])
>>>> +
>>>> system_ss.add(files(
>>>>   'balloon.c',
>>>>   'bootdevice.c',
>>>> @@ -23,7 +26,7 @@ system_ss.add(files(
>>>>   'runstate-hmp-cmds.c',
>>>>   'runstate.c',
>>>>   'tpm-hmp-cmds.c',
>>>> -), libpmem, libdaxctl)
>>>> +))
>>>>
>>>> system_ss.add(files(
>>>>   'vl.c',
>>>>
>>
>>


