Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97521C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3zoU-0001Jx-CP; Sun, 13 Apr 2025 12:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u3znn-0000px-H1
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 12:03:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u3znk-0006T2-Qs
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 12:03:23 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso2907235b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Apr 2025 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744560199; x=1745164999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=bHxYHEWozWzxBFkIBUdNPOYPTPhvE7WDVk/u0Ip6emU=;
 b=neQuEUJvmfG3q8faKmSuIVwuyA3nxS02nlrjlELXze4fqulnFVOg/UMSXi8I4YwQds
 ppJysOeO0216HPNUGkYqBLGUBvCksXXpBw8lbKPNIhov0I/xKlUC32Epr0g4ZdHyHONX
 BWR3CJGEZlbjuFw+V+PtIRtONSL5Ie0eLFEhZyALmdRGOurTg6nyCTorg3AxGKDgeMBT
 VgChkPEa1MBgrw2LW+P5Ge1Z03cUGD13dQ0NOhF8bUJtTZMqIfydN/Dh82MwBn0ZNF0V
 XvE87gMW9DUhv3+pj3ohq8FwHihixc+uEb3YCdzm1S9cQogAuJFfY9JPmauxS01w+PR7
 eGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744560199; x=1745164999;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHxYHEWozWzxBFkIBUdNPOYPTPhvE7WDVk/u0Ip6emU=;
 b=aNaJHM+7vz0GcZ4GmxrI1c+ePZb3Fn6Uvf1cC4suCIm02VvOeBBRzebHYThUuClbj5
 ds73kxQBSx56OK46dDRPo99QH1xZHauKU9GkARfmmOBPV52OqpX2GPgWKnYZIT/THd4f
 qo0LMHn69eIZWIAy9TGw8ggymoR6RVZn58lXckEMdS4chUvO3HnMbR7eNly/ZZa+MWFu
 jnKVoTvMLNG/7/VvjyzUx89QlDQ/8tZAjrpL7pXPh33WawNigIWZy9fvm9AbwG4MwH0F
 yzLMjNsocIHXSRomGxvwo4/5HMlAlNZBHNzf1ZzPpBNVjXfuUN8+vVqb0JMZS6G72zoS
 Is/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0l29cx0bRPNTLgFGyQx71Nq+u9qbOxg26v+aQGWFpXsL5BeUqMdsAa7D4zfOq4/Irhe3BR34/07ci@nongnu.org
X-Gm-Message-State: AOJu0Ywl48tXLOV1E/L37GuK7otK5jBzBzC6ZmLgAuyRJGn1H6MRjG6u
 8eA5G/6XMRZSAXj2T3eRIOt8VbuHazTH3+uFiyNv/e81NzU2UTCa
X-Gm-Gg: ASbGncuAzqEHKJyBmPGnULY/tr8TQfromSj6RMRNkl/msL8sIb1NEX1vqVPeRrdLArt
 Y2yykbajmcJqavBS4NgI0Z68TSrUTvgAwrsibVu5HYdJQVNti96rMwlBlcXNSMT0FRqomFleqxQ
 CFZjjMjQPxDAz/TL8+W+a2+CJg+5Qg1X6T3AtDXVavTmtwn4owSIMtRcPaXBAu+v2R3Xa5f8kKd
 slsypYQoKEzXI7rgN3I9G8TIvOHDNFjyMEDM0VvzV2xabXLDhr8wD3p+57SLBKe3M7owTpNtQQN
 +ViRyPM2Myyw+/xrp3enXZ0GEeCOk9jMsz+5Um/6q6yjMv43kDd7lv3uKcauslmDyAmSjZ0QivJ
 sknsjCa2P+8Z3hcr6XGML+pYy
X-Google-Smtp-Source: AGHT+IFWmOe4wFdjffDoftSOl+ftbxb/7RiXLaH6IwtDXqbDzQdU2oR+YgkfCAmYhYuHkWZ1LPrnbg==
X-Received: by 2002:a05:6a00:1941:b0:736:57cb:f2aa with SMTP id
 d2e1a72fcca58-73bd1209ecamr11014501b3a.13.1744560198457; 
 Sun, 13 Apr 2025 09:03:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233553fsm5278353b3a.172.2025.04.13.09.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Apr 2025 09:03:17 -0700 (PDT)
Message-ID: <41a54c58-25df-4027-bc93-45a817c2d570@roeck-us.net>
Date: Sun, 13 Apr 2025 09:03:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw: usb: xhci: Add property to support writing ERSTBA
 in high-low order
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <groeck7@gmail.com>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-2-linux@roeck-us.net>
 <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/11/25 00:40, Nicholas Piggin wrote:
> On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
>> According to the XHCI specification, ERSTBA should be written in Low-High
>> order. The Linux kernel writes the high word first. This results in an
>> initialization failure.
> 
> This should probably be reworded, it's not so much that Linux does it,
> this kind of implies a Linux bug. It is that the hardware requires it
> and Linux works around such quirk.
> 
>    According to the XHCI specification, ERSTBA should be written in Low-High
>    order, however some controllers have a quirk that requires the low
>    word to be written last.
> 
>>
>> The following information is found in the Linux kernel commit log.
>>
>> [Synopsys]- The host controller was design to support ERST setting
>> during the RUN state. But since there is a limitation in controller
>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>> It is supported when the ERSTBA is programmed in 64bit,
>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>
>> [Synopsys]- The internal initialization of event ring fetches
>> the "Event Ring Segment Table Entry" based on the indication of
>> ERSTBA_LO written.
> 
> Could you include a reference to the commit in the normal form?
> 
> The following information is found in the changelog for Linux kernel
> commit sha ("blah").
> 
>>
>> Add property to support writing the high word first.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/usb/hcd-xhci.c | 8 +++++++-
>>   hw/usb/hcd-xhci.h | 1 +
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 64c3a23b9b..8c0ba569c8 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
>>           } else {
>>               intr->erstba_low = val & 0xffffffc0;
>>           }
>> +        if (xhci->erstba_hi_lo) {
>> +            xhci_er_reset(xhci, v);
>> +        }
>>           break;
>>       case 0x14: /* ERSTBA high */
>>           intr->erstba_high = val;
>> -        xhci_er_reset(xhci, v);
>> +        if (!xhci->erstba_hi_lo) {
>> +            xhci_er_reset(xhci, v);
>> +        }
>>           break;
>>       case 0x18: /* ERDP low */
>>           if (val & ERDP_EHB) {
>> @@ -3636,6 +3641,7 @@ static const Property xhci_properties[] = {
>>       DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
>>       DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
>>                        DeviceState *),
>> +    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, false),
>>   };
>>   
>>   static void xhci_class_init(ObjectClass *klass, void *data)
>> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
>> index 9c3974f148..cf3f074261 100644
>> --- a/hw/usb/hcd-xhci.h
>> +++ b/hw/usb/hcd-xhci.h
>> @@ -189,6 +189,7 @@ typedef struct XHCIState {
>>       uint32_t numports_3;
>>       uint32_t numintrs;
>>       uint32_t numslots;
>> +    bool erstba_hi_lo;
> 
> Could you use the "quirk" prefix for the device and property name?
> 

Done all, except then I noticed that you want me to prepend "quirk"
and I appended it out of habit. So I'll need to start over :-(.

Guenter


