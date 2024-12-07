Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0940DE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 09:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqv7-0003kc-L0; Sat, 07 Dec 2024 04:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJqv5-0003kL-7O
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 04:16:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJqv2-0004wu-0t
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 04:16:10 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso2417753f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733562965; x=1734167765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=unM41AAEs142gZVdeCc2g4SZa4o/O36/X/SEVcGBQ8o=;
 b=KCpv9igtpvSeb1MkHwEvriP8luGbz2po87hBAgsSTKN5gWjRaJDNTDhFhbnqzS5Pra
 oYjkTLRu09OeUU9USMZ08QglEqI7cq8z/d/tZlPHXJAE56QomjxDdf2gZ7KMYRO5oagA
 hUu1vYauQfeJJ9t8C2DNsOMX3me2LkNGsfbETXkSGm7PNbN18/DYA7Fz6k5OGtECPVKq
 +7v2+UpWrK+BNLmaUj30R4D52nzF2EIFP0xv+orNcCq5v3qof8s57/rcBfaY4tGezp8u
 pNX/NfYbu9zdlEwfLwex8EPQvLBuZq+HZgMjvca+JISk9jsC+xz4jnuZkdEPn4Z3KVF5
 bSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733562965; x=1734167765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=unM41AAEs142gZVdeCc2g4SZa4o/O36/X/SEVcGBQ8o=;
 b=H/NaayE3y/3Who2gfkyBb1yHOdJAZi+8f4sgLNSQfUmGVmBhy7XDv70IX9RawSACdG
 EYcNMNpE5b+6RlqvlFRrIeF5okbxug/ssx1x1/ZM3iNMF35crA/JTflpwzJUnWknmCwx
 0BDpDwe8wECHHxMOy/zz4ZizmDNv495Gi80ecfWU5v7V4zX4SvdQY7RN957kepS+r60n
 +IfygWpjrIqZJ7/DLWbfVRq3CgdW1KeHdvbu23sYjr+LvFrSmMklTZFhXcYLx06CJKJA
 5iKNAP5gyNdRQRj8OpTib4PZrXH2vqEqvZaXKsrtFMNQBhr5tlugfpWQny7huAIF3Hyp
 4fWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoH+kdqZPBXFUN9dHr7wkPyvokx6nw5Fltlh9HZtWKyAuqOsdEmdovbqovpI4g8kfjywbTDrK+Uq9d@nongnu.org
X-Gm-Message-State: AOJu0YwE3nYeF+Xn4gpM8Ti64Ofse4+pNIXaiI0348S8FPvhGA/Q1d3S
 iC/aG3Kr3o4ImGOlvpq34SGeFqFW9553pG9dJ7I3hAwb3TMI4HLq4RHYI57hkqg=
X-Gm-Gg: ASbGncsDhCTer6Xd/N3SHvNdfdJPpRQfYfsubw2coIAINe0lvTgjsHNuZgEdPb56/xB
 Lc8pG6d8H8GIAukGHhjYgxhgeuH7KSSBE8C3n9Ta0fXRI7HNsPEBVuO1aVfgN1LWev3aDe5wX14
 rwS/VgYuOYDDN83GWtbgOGHx0hig18kxXEyHsEmpaoAWnbmCRrS3BrWR6pzSDdMQI7nmvVmu9Ma
 sTRzDRo7Mptgbb5N+JeL2bLZ8jBWuE9+kqIfvI+tMy807yGYKNuOj882NqIiSZ5am09CDihgrif
 utKKM8jxd0h//slyW/M+NsUJCaZtxXfu
X-Google-Smtp-Source: AGHT+IF3pHdLAk8QzAMxA0WHrvjf/dAMSd1cWgozc8y9jPvQKMtY82LVCUyYMvHhe8L8CxYWkSEPeQ==
X-Received: by 2002:a05:6000:156f:b0:385:e9de:d521 with SMTP id
 ffacd0b85a97d-3862b33d366mr4067795f8f.8.1733562965102; 
 Sat, 07 Dec 2024 01:16:05 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbd42sm117660455e9.38.2024.12.07.01.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Dec 2024 01:16:04 -0800 (PST)
Message-ID: <45018b0d-d741-49a2-8680-993a2eeb285a@linaro.org>
Date: Sat, 7 Dec 2024 10:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
 <Z1GgjZOCc8vkkB3A@intel.com>
 <8cb0a692-420a-4645-b1b8-bc6e47bbb116@linaro.org>
 <CABgObfa7ojzTWOdzd9MUq76ebO8oEU24ew=N80JOOEd=7XuO5g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfa7ojzTWOdzd9MUq76ebO8oEU24ew=N80JOOEd=7XuO5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/12/24 22:19, Paolo Bonzini wrote:
> On Thu, Dec 5, 2024 at 10:18 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 5/12/24 13:46, Zhao Liu wrote:
>>> Hi Philippe,
>>>
>>> On Thu, Dec 05, 2024 at 01:04:58PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Date: Thu, 5 Dec 2024 13:04:58 +0100
>>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
>>>>
>>>> On 5/12/24 07:07, Zhao Liu wrote:
>>>>> HPET device needs to access and update hpet_cfg variable, but now it is
>>>>> defined in hw/i386/fw_cfg.c and Rust code can't access it.
>>>>>
>>>>> Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
>>>>> allows Rust HPET device implements its own global hpet_fw_cfg variable,
>>>>> and will further reduce the use of unsafe C code access and calls in the
>>>>> Rust HPET implementation.
>>>>>
>>>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>>>> ---
>>>>>     hw/i386/fw_cfg.c        |  4 +---
>>>>>     hw/timer/hpet.c         | 16 +++++++++-------
>>>>>     include/hw/timer/hpet.h |  2 +-
>>>>>     3 files changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>>
>>>>> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
>>>>> index d17a8d43199e..dbf709251a8f 100644
>>>>> --- a/include/hw/timer/hpet.h
>>>>> +++ b/include/hw/timer/hpet.h
>>>>> @@ -74,7 +74,7 @@ struct hpet_fw_config
>>>>>         struct hpet_fw_entry hpet[8];
>>>>>     } QEMU_PACKED;
>>>>> -extern struct hpet_fw_config hpet_cfg;
>>>>> +extern struct hpet_fw_config hpet_fw_cfg;
>>>>
>>>> Could this field belong to the (yet unexisting) HPETClass?
>>>
>>> Several instances would share the same class, so HPETClass could manage
>>> multiple HPETState info.
>>>
>>> But in fw_cfg.c, do you have idea about how to get the HPETClass?
>>
>> Have hpet_find() return an Object and call object_get_class()?

Implemented as 
https://lore.kernel.org/qemu-devel/20241206191124.9195-1-philmd@linaro.org/, 
hoping it simplifies the Rust model integration.

> 
> That would work, but anyhow this patch breaks compilation without HPET
> so the question is a bit moot. :)
> 
> Paolo
> 


