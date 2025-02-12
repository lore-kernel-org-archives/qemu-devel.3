Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiECM-0003W3-BI; Wed, 12 Feb 2025 09:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiECL-0003VO-0m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:58:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiECJ-0003sd-0c
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:58:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso6160795e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739372321; x=1739977121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y0cXZBivovxP8ijksatPfPKzIFHRx4Z7abcU1oSJGVA=;
 b=AV+1q7H5+LyDbwnvguY4bK5W5QxZJZSxE4bgZ6IhTJTtt56CKTD275UiVLH4kcTsFX
 XS0jbxaRonhlla8OkoY+PY9LBygNAvtf1cORAmqSR34FdgAjEjXBnqzDJIYcQUQ8sGtz
 Nu9ZaZegQbeTjK/upnkFWw1288ql143aHebpo6j6CppCS6hZkeyUFH9jOi2C9D95k+9G
 VmqF3PUvISN6XKmN3LjegFBQzGA88syOq1ZzBPYrN/VM7korOgzkekT9wYNPfZ1xl11x
 DGr4nDSwjB/FGosMFoY098wPjgr/LUflzoRNZlUoR7HrzQX8wfV0jqjaxzKHO5VNAzqb
 pcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372321; x=1739977121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0cXZBivovxP8ijksatPfPKzIFHRx4Z7abcU1oSJGVA=;
 b=LBoOrusFWUDc0BP6uh88Naq6Smay0j3gEOyRNn2iKxnrAbXcHCTCwTclqQnyWRHiKc
 rhG3Sd56lUjBBuKXlaKUiHO++KSkR5hJ2+ZWJ7adUeE/96BEzXiu3KRUg8XT7TNxOQwk
 WAY+WR0ow6sfmMBr6r4OYXNecgQjEmQjEp3IuS02vvNpLzj7ObIIIO9Jxqc9UjisXuVn
 5n+xuCGatYIX79ozKTZ/VNPuJVPwaGw0Qy+AFJqH/jhKZO9sIkmvskqCR3UP22DQ05dg
 BQeVlyPtOPwDwHn8XE7vUXYRlO2BXpV34jpnivu4APb5RGG1IX1S7EokXj2OXb2Gy3Vm
 +s0g==
X-Gm-Message-State: AOJu0Yw+qJMzO2GNSaTa3gfrIrl7CIeNlTdImEWhYTmxDpWk1QlA862i
 JljZHIfnf7HrR2x+HVk+yvZ7PiWd9c2w2SQxCIfLNSaHTreHyUP/IOm4U4n84fuq4G4CIgUsEKn
 08Wk=
X-Gm-Gg: ASbGncsUfhqOsVZDSZXa/YLL+NEy0dupyic/Dl6fCI9RpLR911ZEwJsvwEfjxZApF5A
 HizHKIax2UZdrvPfhwrFgdJ7K7rVUGuDk043RMMf2G4twuRhiRa/lU4UfRrDV3yqBIJSDY8h0f5
 4yS37SqsuAOgKKP4inRpImXJ+mf07wAeD3EDW3sgLiEFje752MlC5mtiVR9OFjqJvQNDyRhhh8N
 pd4umZp1X+oPq9DZlw61q2VaO6YjzdTQzxMaZ+yOfFIlPfC7Cq43ULgONvUxaHaM+wspnInnoRg
 1JRNY92SQVQRVXB5CG+F7cTr0GMMRLzMQwVlicnhEQ+npfNbWNTIZA4kxaE=
X-Google-Smtp-Source: AGHT+IGa4d2gp8gQYkknmdWFTOiB1lnIJwNN/E9J3WJm88c2c3WCBSXNdjgEky76h9tBuM7BDbJBLw==
X-Received: by 2002:a05:600c:468c:b0:434:ff08:202e with SMTP id
 5b1f17b1804b1-439583b4d4bmr30639625e9.8.1739372321223; 
 Wed, 12 Feb 2025 06:58:41 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7bcsm21972115e9.28.2025.02.12.06.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:58:40 -0800 (PST)
Message-ID: <824c0c10-8aba-4778-b653-d0e2eb6115ea@linaro.org>
Date: Wed, 12 Feb 2025 15:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/arm/realview: Explicit number of GIC external IRQs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-4-philmd@linaro.org>
 <CAFEAcA_PFSBdB0Uhb8K5aog0kj-HN=s_EBL=pQCkkNLuwUO42g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_PFSBdB0Uhb8K5aog0kj-HN=s_EBL=pQCkkNLuwUO42g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/1/25 19:36, Peter Maydell wrote:
> On Thu, 30 Jan 2025 at 18:25, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> When not specified, Cortex-A9MP configures its GIC with 64 external
>> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
>> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
>> to make that explicit.
>>
>> Except explicitly setting a property value to its same implicit
>> value, there is no logical change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/realview.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>> index 9900a98f3b8..4a62c83506b 100644
>> --- a/hw/arm/realview.c
>> +++ b/hw/arm/realview.c
>> @@ -35,6 +35,14 @@
>>   #define SMP_BOOT_ADDR 0xe0000000
>>   #define SMP_BOOTREG_ADDR 0x10000030
>>
>> +/*
>> + * The Cortex-A9MP may have anything from 0 to 224 external interrupt
>> + * IRQ lines (with another 32 internal). We default to 64+32, which
>> + * is the number provided by the Cortex-A9MP test chip in the
>> + * Realview PBX-A9 and Versatile Express A9 development boards.
>> + */
> 
> On the other hand, this really *is* the Realview PBX-A9
> development board. So we can just say that that's the right
> number (and the vexpress is irrelevant, and the range of
> settings the CPU itself can have isn't very important either).
> 
> (PS: there's no verb "to explicit" in English (ignoring some
> obscure obsolete ones); French "expliciter" => English "to make
> explicit"; or you in the case of the subject line here,
> "specify explicitly" is probably most natural.)

TIL, thanks :)


