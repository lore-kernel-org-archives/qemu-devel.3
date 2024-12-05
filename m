Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30673E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJEa-0005G8-WB; Thu, 05 Dec 2024 16:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJEZ-0005FR-9b
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:18:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJEX-0004Nr-MG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:18:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so16391755e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433479; x=1734038279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+3CAH4K1LfXjR+g8rB9/ewV3A11K6YOBB/0pgZTeFa0=;
 b=DyIxNpbAwZFYIErZzol8HL0BZJ6HGcWdHaWv3oQ0I2oXVWQG9TdbQvpbebGgTdiHV1
 +tN27OhKBDE1CE9eJVpHB3PWCItzqKdlfziukQAq9GcRCyYc89Yc+dJZg32KNJ+BICjo
 PZINHitSCkvb4sl64k+GuVcUFoazXYDPin8uAddTszIbSFkEyZ4ZPWDzhD34DtuqpzzM
 SoxGd+F/h9HB6RTYHFl8jzOJtUBlzcmfyqEonJ+WsHNDbtrPgCspjwrIiLbNJTL6W6+M
 ctescGwtha8gQJ0thhkPw5AEaRG6HFUPUiG8OmpsJLSA4dOR/nCUl2El2WS6Uj9YfkjP
 AQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433479; x=1734038279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3CAH4K1LfXjR+g8rB9/ewV3A11K6YOBB/0pgZTeFa0=;
 b=lU6aefMFpgVYYRAIREYqvH7RDfmeh7o8+MQcwowpaXUYxD8X+kKXQTbqM94TguuieN
 70qLzZTPwvSnYHsHjDf3jYN30MM4K+Q90Cx4kOddAsupM2EYus+/j4lvy8HLFnmtEZZy
 Q9tUPRlXjKI0KOyOoqF9vTC6BA69zoJ4wGbnXGXVb0TIX+1850QHxFNL2pqgxpdesS+w
 xW+mmanhCu7FkxTJxfeB4+wBG/w4e7rbW5kZ1gh3I/VfDiDmSG1KcroGaMkO5CyKMJhN
 Nxi7JpxJqCBlhJolTfw48jL68WiccTSUrx2GxlBEqeg4UD0ig5nCx2WVIWglXBlqVXFM
 Ujdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnSfvA0/uyeo72IqXgrrDlAW1HGA2W7/JiuCJH6qkj/aGXtbQi8GnZCMMjI2NaYRbxSmJLLAGmiEPc@nongnu.org
X-Gm-Message-State: AOJu0YxGPxkcPkFX5vy/FROUdfOs7IDs1AgT3KR/VmSb2H+M8By5O1sa
 LY+uf3YzTvSMkDhdXGS5H9DpmfG41DZSWdAhStn8j0iEBaqPLSi4O6uVqhfqSZ0=
X-Gm-Gg: ASbGncvo011OSvk9JO9uc4z/bVfpJw9LaxoIhVHflFb8C7OoEREPavEHK2CO1mRbOw6
 mXUDF5nOP6pl87rrSVnRrHHPEUBumWO5WN/PwQogMRqy8EtT6v3sfQIff++qKIWugMAfSacYkMU
 /+rheJFSeF0BZIFEA6pegpV31tMbi5EbfRX1yYOrww89K8tX0JL2pfgMtcQfrVwrqDSsVFU9V8T
 Ip/B2yo9/9B30Estj6jBfuHvHnR331hsPpFZNQzPHxa5hFZ1fHuzZQm7vF/CNa4leGZG2vEtCVa
 rFhdx2De/YE7cZOrLg==
X-Google-Smtp-Source: AGHT+IGh/kFDYyY3Yn0heX1I0fH9ZpBnoM/2lrSFYPc+xMx3Obefzuvqv07rMYZSps+MHQ6ZjkUKBw==
X-Received: by 2002:a05:600c:1f8c:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-434ddeb516emr7249625e9.12.1733433479530; 
 Thu, 05 Dec 2024 13:17:59 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526c059sm72095175e9.5.2024.12.05.13.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:17:59 -0800 (PST)
Message-ID: <8cb0a692-420a-4645-b1b8-bc6e47bbb116@linaro.org>
Date: Thu, 5 Dec 2024 22:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
 <ed49af53-4a10-4cee-829e-d5921b8aee3c@linaro.org>
 <Z1GgjZOCc8vkkB3A@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z1GgjZOCc8vkkB3A@intel.com>
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

On 5/12/24 13:46, Zhao Liu wrote:
> Hi Philippe,
> 
> On Thu, Dec 05, 2024 at 01:04:58PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Thu, 5 Dec 2024 13:04:58 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
>>
>> On 5/12/24 07:07, Zhao Liu wrote:
>>> HPET device needs to access and update hpet_cfg variable, but now it is
>>> defined in hw/i386/fw_cfg.c and Rust code can't access it.
>>>
>>> Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
>>> allows Rust HPET device implements its own global hpet_fw_cfg variable,
>>> and will further reduce the use of unsafe C code access and calls in the
>>> Rust HPET implementation.
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>    hw/i386/fw_cfg.c        |  4 +---
>>>    hw/timer/hpet.c         | 16 +++++++++-------
>>>    include/hw/timer/hpet.h |  2 +-
>>>    3 files changed, 11 insertions(+), 11 deletions(-)
>>
>>
>>> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
>>> index d17a8d43199e..dbf709251a8f 100644
>>> --- a/include/hw/timer/hpet.h
>>> +++ b/include/hw/timer/hpet.h
>>> @@ -74,7 +74,7 @@ struct hpet_fw_config
>>>        struct hpet_fw_entry hpet[8];
>>>    } QEMU_PACKED;
>>> -extern struct hpet_fw_config hpet_cfg;
>>> +extern struct hpet_fw_config hpet_fw_cfg;
>>
>> Could this field belong to the (yet unexisting) HPETClass?
> 
> Several instances would share the same class, so HPETClass could manage
> multiple HPETState info.
> 
> But in fw_cfg.c, do you have idea about how to get the HPETClass?

Have hpet_find() return an Object and call object_get_class()?

> Regards,
> Zhao
> 


