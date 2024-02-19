Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDFC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzBH-0007Z9-4m; Mon, 19 Feb 2024 03:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbzBF-0007Yk-Nb
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:39:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbzBD-0003r8-81
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 03:39:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412698cdd77so1020355e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708331953; x=1708936753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CYXFroxxpCnwAYN1gM2WM91eHQq25PtJZrWxJ2nunuU=;
 b=GyvDvVFFcciTQP0s89o3HN6W6Wkmijx/pWfguldRGLe6UD5SJtERJUN9qTRRBG1aSp
 U3dJdZbZpk1IU4qCjrKDKweI/STTb6cS5YKOzzHR6yCvXqFVUS2gb89qF9wORvgAvqQz
 t9wohjI5nQ0Vwyj6YwVZ8sQ23cDZgQn6+pno1In4TsOGIVHUkZL79fy+rAFIJH0ymbG1
 +9WAvp8bUxsxRaC17plmN63bwMVgPiWt/xTtJX/0dwxQ+dYNpqOHNQE3VcZbBVv6WeOA
 fpkNI85dHgYnXLCChRBHT47+B3usJZcpOcIOTYIxzeBUvfOJb9AXu3+hOje7y3dU5P0L
 Tbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331953; x=1708936753;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYXFroxxpCnwAYN1gM2WM91eHQq25PtJZrWxJ2nunuU=;
 b=OJJOXS1MsKwo1HosoXcKn7S0YnXTCIu4MQkGppyHwGyu+FFxOQwfwI1hPJjRfyKBkL
 OBbol/MWiTvg4qDn/JVvarB41n3N2mX5PqxxdoZwZ0CO4nSEonJBGrWPNlAvEETsoi5M
 a2wSIfyiYGfQNZ2mkgSD5ufXL8h6aKtO76W5Ntd3pPGalNJdiusCsbjCWJB2wYevTNUg
 5eZ7qDgSlRRpSYev6zldTz3Dhcm7ASDBpGUtSn1/XaiLMCGrLo6f97cDo7BC0ea5DWJJ
 wb9O4v2g0ahPMAybCnt7wUE2uWoqPgEHZBTnw+Ggr7Vl9ZiZNDQ8+IuF7iyuqVViE6dy
 KjiQ==
X-Gm-Message-State: AOJu0Ywykvo3SmZ3oaXgj/4sef6v0XA3EIE4aIEsW/M/kFz4JwHdEPd7
 cCcSChJUWrlP713f/X9nr/jPs6uN0rNMsBoyUonnbcalFwU0k2Z+SomCk4nGgls=
X-Google-Smtp-Source: AGHT+IHHZHE2hxZImjTjtz52BTCa19x73B+ifItIOGXblR1mvSpW7ADOmJuk9lMf8fB3r9j7LKBDzQ==
X-Received: by 2002:a05:600c:3591:b0:412:41:bb3d with SMTP id
 p17-20020a05600c359100b004120041bb3dmr9611111wmq.3.1708331952833; 
 Mon, 19 Feb 2024 00:39:12 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b0040fccf7e8easm10567009wmm.36.2024.02.19.00.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 00:39:12 -0800 (PST)
Message-ID: <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
Date: Mon, 19 Feb 2024 09:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
In-Reply-To: <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/2/24 20:54, Philippe Mathieu-Daudé wrote:
> On 16/2/24 18:14, BALATON Zoltan wrote:
>> On Fri, 16 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> We want to set another qdev property (a link) for the pl110
>>> and pl111 devices, we can not use sysbus_create_simple() which
>>> only passes sysbus base address and IRQs as arguments. Inline
>>> it so we can set the link property in the next commit.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/arm/realview.c    |  5 ++++-
>>> hw/arm/versatilepb.c |  6 +++++-
>>> hw/arm/vexpress.c    | 10 ++++++++--
>>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>>> index 9058f5b414..77300e92e5 100644
>>> --- a/hw/arm/realview.c
>>> +++ b/hw/arm/realview.c
>>> @@ -238,7 +238,10 @@ static void realview_init(MachineState *machine,
>>>     sysbus_create_simple("pl061", 0x10014000, pic[7]);
>>>     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
>>>
>>> -    sysbus_create_simple("pl111", 0x10020000, pic[23]);
>>> +    dev = qdev_new("pl111");
>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
>>
>> Not directly related to this patch but this blows up 1 line into 4 
>> just to allow setting a property. Maybe just to keep some simplicity 
>> we'd rather need either a sysbus_realize_simple function that takes a 
>> sysbus device instead of the name and does not create the device 
>> itself or some way to pass properties to sysbus create simple (but the 
>> latter may not be easy to do in a generic way so not sure about that). 
>> What do you think?
> 
> Unfortunately sysbus doesn't scale in heterogeneous setup.

Regarding the HW modelling API complexity you are pointing at, we'd
like to move from the current imperative programming paradigm to a
declarative one, likely DSL driven. Meanwhile it is being investigated
(as part of "Dynamic Machine"), I'm trying to get the HW APIs right
for heterogeneous emulation. Current price to pay is a verbose
imperative QDev API, hoping we'll get later a trivial declarative one
(like this single sysbus_create_simple call), where we shouldn't worry
about the order of low level calls, whether to use link or not, etc.

For the big list of issues we are trying to improve, see:
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

