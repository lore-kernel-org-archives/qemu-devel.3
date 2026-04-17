Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA29F8E491
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcT0-00043N-OM; Fri, 17 Apr 2026 02:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcSy-00042C-J6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:14:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcSw-0004It-PH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:14:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d73422431so177410f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776406449; x=1777011249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rW11V5zDTwy2B7OJTm1WksE7+SGkCE7a3F0LalLLwJ4=;
 b=Sywxd6xejkuEiHVrg2Li+0hzCZUftvCdYTLbVCEluuC+20Gd+gJbDDo/UOKJplREzz
 j/19obVA4dvyOhN/T0g/41O5+LVQam5i+zP1At2yQ+bBsYSvaPzBDqhZzsvGQehuWt2B
 e+TgU8TU3+PVWJ0f9La3/2Kyef+TRVkyWp+kLUBgoSzqCBCdF3mKkCW1VBnwM7XUv92i
 NvG0ldj+9Nf0l91OP0Tgh52YpLiz80M0cLOqJNcPqcoQTM0vKv/PG1/EyhjkbuxQiWKu
 aQGMU2acq4Ksyzc/k7c2nQTFcV0yWh+x1qMYKvM13MRXZ6oZj4VY5KR0cMpDyv9boFBX
 wzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406449; x=1777011249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW11V5zDTwy2B7OJTm1WksE7+SGkCE7a3F0LalLLwJ4=;
 b=o4895Cvm+p4LVeIowDuJaz9YnghK/9jnNIkL2tTzz4a4CNnrvbmvr7pHsCOXIu0Clz
 3ER2a7EmJGxbTqbFTMLyeQtaBrVCuOr5ocAZBLwtvH96HPOFtAnOb1KwGnYtTjCaZPhg
 lTljUARB0VzBLvfbt9pcm299SSN43Wv7PAIyM8ipvFBfiE5e135KD9fJ/ymZw20Auqxp
 aAVbJOP6dBDycdCx/Dd4GP6YGb6oUht7eUM0LHklZUkEB77iiODAPRMHYP5chof1wWVf
 q9eS53KXyt8Ui1COByBNEywS2hXuidw3PG6Nb48TsOaYKnrUQyC9pJYfHG9z5KgBCLq2
 blxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dyv28IX6K8lSlNRWO6DSpHY3IIenwml6+FdlWX06JcPd+r4a/zpYyTLnTFs/y2E/Hjkit+scHp8SF@nongnu.org
X-Gm-Message-State: AOJu0Ywlay+kZ1mM4ZNB/4Jijp/z/+oCLvUbYu2SR4inalD/cJxHAMVz
 APRvHEOR4lehfo2wxUdlcVs/5EpCIK6wUBsg2ULV/83RU46Pdukx7fuXx3TOxGfZ6cY=
X-Gm-Gg: AeBDievJjfhTU2N6KJnVpBN1uxCnDYSgZPQ/rFTX8DH/E+f0JZVlGVFKnEC1VfQHg8O
 hs60qfQjZ2tniTTyMSB4dNpC2h2pXMJifiWvvHseDGZcnWsQQT2zy+uAZ4JsYdHfr949Bf4hvuK
 RbQn7BNeXp0mgn1WvVprDaPfgo51rEeOl9eodHdj0A4t7lfn1ye0oJIW9HpccKAxOP5gxdlfwkO
 eC6qGjhVUAPKxV4M/fRB1VC5ARA8saIpM79W1+xROcV4gLNmyiBhpJFfNYR+DJuPobv2av17g6u
 z5EAQhQnPDjFPbWNeTqraoYcPFoMp8eh4XIcd/v3SQf19iCG9Js3Z59W+uJ6kibvXHQdpv/mXeg
 DlEDBQ5VbY1W3vQoLV+bdu83EBnWqeb7Y+S1zfzzQkjD76+TizSyTyKsOiTQYcSmSOVQ58wT5S2
 K5xXc2Ac7dh7OgepJyw7kqMmu3BXoUhrBJ0793B6ABUhgu71iOUUtNsJbSuFrtpjyh0nGoKTOOw
 bzV
X-Received: by 2002:a05:6000:4283:b0:43d:7ea1:fb53 with SMTP id
 ffacd0b85a97d-43fe3e15f7emr1942438f8f.33.1776406448867; 
 Thu, 16 Apr 2026 23:14:08 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm1976533f8f.2.2026.04.16.23.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:14:08 -0700 (PDT)
Message-ID: <34bf26b3-298c-4c40-bf10-fd0e29058a5c@linaro.org>
Date: Fri, 17 Apr 2026 08:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-10-jamin_lin@aspeedtech.com>
 <c03af2eb-c7e9-4954-9a53-b1575c7073f6@linaro.org>
 <TYPPR06MB82062B89BEDF49BA637CDC02FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <TYPPR06MB82062B89BEDF49BA637CDC02FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 17/4/26 07:40, Jamin Lin wrote:
> Hi Philippe,
> 
>> Subject: Re: [PATCH v3 09/17] hw/usb/hcd-ehci: Implement 64-bit QH
>> descriptor addressing
>>
>> On 16/4/26 03:49, Jamin Lin wrote:
>>> EHCI supports 64-bit control data structure addressing when the 64-bit
>>> Addressing Capability bit in HCCPARAMS is set. In that mode, the
>>> CTRLDSSEGMENT register supplies the upper 32 bits which are
>>> concatenated with 32-bit link pointer fields to form full 64-bit
>>> descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).
>>>
>>> The current implementation assumes 32-bit QH descriptor addresses and
>>> directly uses link pointer values without applying the CTRLDSSEGMENT
>>> upper dword.
>>>
>>> Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit
>>> descriptor addresses when 64-bit capability is enabled. Update QH
>>> traversal paths (async list walk, horizontal QH link, and periodic
>>> schedule entry handling) to use the translated 64-bit addresses.
>>>
>>> EHCI 64-bit buffer pointer fields are defined in Appendix B as split
>>> 32-bit low/high parts located at separate offsets, rather than a
>>> single contiguous 64-bit field. Therefore, the buffer pointers cannot
>>> be represented as uint64_t bufptr[5] without violating the descriptor
>>> layout defined by the specification.
>>>
>>> Introduce ehci_get_buf_addr() to construct full 64-bit buffer
>>> addresses from bufptr[] and bufptr_hi[] fields. Use this helper when
>>> calculating transfer buffer addresses so that data buffers above 4GB
>>> are correctly handled.
>>>
>>> Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer
>>> fields as defined in Appendix B.
>>>
>>> When 64-bit capability is disabled, descriptor addresses remain 32-bit
>>> and existing behaviour is unchanged.
>>>
>>> Note: Similar split 64-bit buffer pointer handling is required for
>>> qTD, iTD and siTD descriptors, which will be addressed in follow-up
>>> changes.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/usb/hcd-ehci.h   |  4 ++++
>>>    hw/usb/hcd-ehci.c   | 48
>> ++++++++++++++++++++++++++++++++++-----------
>>>    hw/usb/trace-events |  2 +-
>>>    3 files changed, 42 insertions(+), 12 deletions(-)


>>> +static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,
>>> +                                  uint32_t mask)
>>
>> Rename @mask as @low_mask? Or directly use 64-bit?
>>
>> static uint64_t ehci_get_buf_addr(const EHCIState *s,
>>                                     uint32_t hi, uint32_t lo,
>>                                     uint64_t mask) {
>>       uint64_t addr = s->caps_64bit_addr ? deposit64(lo, 0, 32, hi): lo;
>>
>>       return addr & mask;
>> }
>>
> Thanks for the review and suggestion.
> 
> In the current code, the mask (e.g. QTD_BUFPTR_MASK) is defined as a 32-bit value and is intended to apply only to the low 32 bits of the buffer pointer.
> If we change the function to take a 64-bit mask and apply it to the full 64-bit address (as in the proposed version),
> the upper 32 bits (bits 63–32) may be unintentionally cleared when the mask is only 32-bit wide.

Right.

> 
> For example:
> 
> #define QTD_BUFPTR_MASK 0xfffff000
> 
> In this case, applying "addr & mask" after combining hi/lo would zero out the high 32 bits, which breaks 64-bit addressing.
> To preserve the original semantics, the mask should only be applied to the low part before combining with the high 32 bits.
> So I suggest renaming the parameter to make this explicit. I will change this function as below. What do you think?
> 
> static uint64_t ehci_get_buf_addr(

"const"

EHCIState *s, uint32_t hi, uint32_t lo,
>                                    uint32_t lo_mask)
> {
>      uint64_t addr = lo & lo_mask;
> 
>      if (s->caps_64bit_addr) {
>          addr = deposit64(addr, 32, 32, hi);
>      }
> 
>      return addr;
> }
Perfect, using "const":

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


