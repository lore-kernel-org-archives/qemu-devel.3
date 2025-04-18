Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985DAC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5p48-00049D-A1; Fri, 18 Apr 2025 12:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5p46-00048O-0n
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:59:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5p43-0004Ha-C8
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:59:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1317344f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744995581; x=1745600381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6c7AkqTlQOlOV9iHN9LCbSUaTJnfsYNhSEPhHBD4h/w=;
 b=oxsSO/jvq8EE1hy9flWRYJjCYx6RGgQVCFMPdAt8qDMUfhIP6j8L4cXL0jtjX6HxEW
 EQrty97FlgcOu4nnbOkpKyMCy0TXqfLNJZlB8buNaNBQaMtP3dLGbvZaYu+WhgbYqD2U
 EzwqwUD6Fs+dJFjrKS1MWeCRlVQUntv1y4NdGRQsGkJIiNchyXLXvRpNji4GdXssHTV3
 at/RjWVYhIBdQSJDDdzWcag1/F9YhfeshxnlpEz+mIwuRFLtMzCblZsVSZJDDVDLIOtO
 OQII9YJcw8yKrhkQb9ZCgULgnerp1/1gdE5NqUZsjthDZ8RvTiLUGQldEsBw+e9ixgT3
 ILfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744995581; x=1745600381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6c7AkqTlQOlOV9iHN9LCbSUaTJnfsYNhSEPhHBD4h/w=;
 b=rggBChcKZ9DNlfexWLxpKd1dLFh4jkQXlPZF7r8t8kWJcw6ZdclNwP+591laDXNtxZ
 ZqojZl579rW1VjpJLlQVZW0JScPmFskuOlrMeP9/vOyzuFo1pR2Fj5I2E6wcIW0QEOyq
 bCgybREGunJCl1mUrz/TguY53g3/8SyuUn71tOPJ6dwcYFIMi5+nVioFOuqX+G9GOj+x
 JCFwHnXnQsAXt7vwFz/OgYSG2fNMdZFcUrkNoYr4/UwR0qCLgIFzZRBPd/HWOj0Zdhwd
 EIZG2DMX+8E9pcLMLFjvKxJ00H0JmTDFRn6/7kBIjafd+Argq3oL4ckbJd2dyPWzH4Qt
 c10Q==
X-Gm-Message-State: AOJu0Yy9FtLKxkUDe6N1Crw+nFXler+xtowd7HEdTwimgD7wEmH04ylI
 7qm3C6PtGOAsJlKoH84v9UTwDtsSTLzYGLxzMfSWVF/u3/PqqkixiUMDRHv+7ZE=
X-Gm-Gg: ASbGncsDVswKyjEMlnPxmNBxdLwa2F0pXl0xgjBgFdsKOj8hiHaW6RrKLB6EIGm8PmU
 tqx1lMzNrXWfJoM0r28xOBpiayTJ0CDtQ+GAw0EqkHxiYc2xm9COQ+m7XBv29pYu2h+FYa8ncO5
 GgInZnELM+2nWXErT+h7RXwbxfE7klLSVNiFm0+Fd8oPRW5wIXQ6FIXRzGk17T8I/VDm5QeHjkE
 hISdH7vwtMFEYyVLmxDtj7WaFNbGeWz2B4raZroO+VBDL7xX3TkMjMZ+bXuIacTwvVv2oY8I2Pr
 ISqgbOCDMcgCBZu6YmpAxXDqm91tNcWbUOX5UZsGbxmMVSTU8gRWYLAVKIi4n4+PW7iFWpUZaCd
 elUbWjmEheMlTYgOlIR4=
X-Google-Smtp-Source: AGHT+IGuJ/FczpahEL+f4A1mB18NwXK16rmFOXDAkgC1BWUdgVZU0xjjhSpobBSMrenYp0iIIe8KnA==
X-Received: by 2002:a05:6000:2481:b0:390:e535:8750 with SMTP id
 ffacd0b85a97d-39efbd60d22mr2946285f8f.9.1744995580691; 
 Fri, 18 Apr 2025 09:59:40 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4330bfsm3250187f8f.23.2025.04.18.09.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 09:59:40 -0700 (PDT)
Message-ID: <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
Date: Fri, 18 Apr 2025 18:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Felipe Balbi
 <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250417235814.98677-1-philmd@linaro.org>
 <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
 <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 18/4/25 18:33, Pierrick Bouvier wrote:
> On 4/18/25 01:53, BALATON Zoltan wrote:
>> On Fri, 18 Apr 2025, Philippe Mathieu-Daudé wrote:
>>> While DEFINE_MACHINE() is a succinct macro, it doesn't
>>> allow registering QOM interfaces to the defined machine.
>>> Convert to the generic DEFINE_TYPES() in preparation to
>>> register interfaces.
>>>
>>> Philippe Mathieu-Daudé (11):
>>>   hw/core/null-machine: Define machine as generic QOM type
>>>   hw/arm/bananapi: Define machine as generic QOM type
>>>   hw/arm/cubieboard: Define machine as generic QOM type
>>>   hw/arm/digic: Define machine as generic QOM type
>>>   hw/arm/imx: Define machines as generic QOM types
>>>   hw/arm/integratorcp: Define machine as generic QOM type
>>>   hw/arm/kzm: Define machine as generic QOM type
>>>   hw/arm/msf2: Define machine as generic QOM type
>>>   hw/arm/musicpal: Define machine as generic QOM type
>>>   hw/arm/orangepi: Define machine as generic QOM type
>>>   hw/arm/stm32: Define machines as generic QOM types
>>>
>>> hw/arm/bananapi_m2u.c      | 13 +++++++++++--
>>> hw/arm/cubieboard.c        | 13 +++++++++++--
>>> hw/arm/digic_boards.c      | 14 ++++++++++++--
>>> hw/arm/imx25_pdk.c         | 14 ++++++++++++--
>>> hw/arm/imx8mp-evk.c        | 15 +++++++++++++--
>>> hw/arm/integratorcp.c      | 16 +++++++++++++---
>>> hw/arm/kzm.c               | 14 ++++++++++++--
>>> hw/arm/mcimx6ul-evk.c      | 15 +++++++++++++--
>>> hw/arm/mcimx7d-sabre.c     | 15 +++++++++++++--
>>> hw/arm/msf2-som.c          | 13 +++++++++++--
>>> hw/arm/musicpal.c          | 16 +++++++++++++---
>>> hw/arm/netduino2.c         | 13 +++++++++++--
>>> hw/arm/netduinoplus2.c     | 13 +++++++++++--
>>> hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
>>> hw/arm/orangepi.c          | 13 +++++++++++--
>>> hw/arm/sabrelite.c         | 14 ++++++++++++--
>>> hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
>>> hw/core/null-machine.c     | 14 ++++++++++++--
>>> 18 files changed, 213 insertions(+), 38 deletions(-)
>>
>> This is much longer and exposing boiler plate code. Is it possible 
>> instead
>> to change DEFINE_MACHINE or add another similar macro that allows
>> specifying more details such as class state type and interfaces like we
>> already have for OBJECT_DEFINE macros to keep the boiler plate code 
>> hidden
>> and not bring it back?
>>
> 
> We can eventually modify DEFINE_MACHINES, to take an additional 
> interfaces parameter, and replace all call sites, with an empty list for 
> all boards out of hw/arm.
> 
> As long as we avoid something like:
> DEFINE_MACHINES_WITH_INTERFACE_1(...)
> DEFINE_MACHINES_WITH_INTERFACE_2(...)
> DEFINE_MACHINES_WITH_INTERFACE_3(...)
> I'm ok with keeping the macro.
> 
> Would that work for you folks?

But then we'll want DEFINE_PPC32_MACHINE() -> 
DEFINE_MACHINES_WITH_INTERFACE_1() etc...

We want to eventually use declarative file to structure most of the
machine boiler plate code. Maybe being momentarily verbose is
acceptable...

