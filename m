Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34702C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc29S-0005lM-DZ; Mon, 19 Feb 2024 06:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc29Q-0005kW-IM
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:49:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc29O-0003g9-Ib
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:49:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4125e435b38so15185475e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708343372; x=1708948172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YngC5yhQXscsRLlNrXXGSMc1GCmCcfETUmdOlmq3fbI=;
 b=cdqNv+J12Mc5zXrP1BEdfFZwCgi+ddTUgvY4FRPgarK64CKe4Z3LBNzJ7C4zoPciT8
 pTcg53cLOX44H5OUM0xcY2Wi5hbiKkQFSWiJXIXx5DdByxCQkR6uH1+bA68Jw9Ui8kB1
 MqplwKGy3C2PP3x9XuJD8wIi9uvO/vZN02Gyljec4NycYdjMP79ymf+QPeZei9yjQNok
 EqDYl2lvP2j2MRbk/Pq6thmz+J3ck1V9Jjm8HVeTinz1CsZf/+6xoRI00I8ryElS2pfV
 V1mJx9oR056l/crRsNq62QQshav5tY9YJ8xS1NpBlnjh2BH85ArCp6spgi19QiGFGDBQ
 +E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343372; x=1708948172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YngC5yhQXscsRLlNrXXGSMc1GCmCcfETUmdOlmq3fbI=;
 b=O2n8IAtscCaOLuIIHr1P5sOf7X8QAqtrayTj06AqwWr5uN0k+QNBT3G42SuK6XnG6y
 PU0Ld6mDNo2zz9c/enJjntPHE95Md/t/SUpfQYTbWyVDd7c2I8RCBKxK82Olw3G99AsT
 NpENqBm9H1DzP1DDnUrghJF2kiyMilVcRsIUmnFlMl3jIPwGlLV6QTBtwOFjHUKmBqRR
 T7qCt0dmzWY1BdTNdx16SuKMKcDfx8M71ScJ9nG/P1ZuMcEsTGkntU8CjoD1xaeIpZsh
 +HeEPkqeTvZyyef3fLm+HxolthgUu284owlCThVd4qmn7l8YMLFNkgO8u7G1JF7wJull
 Fskw==
X-Gm-Message-State: AOJu0YyX2JJO/D1nR6zF6ax1JI/Xf3jeYzaFPp9SUGXlOngsReDqVgVS
 AOwb3+WcaSnzI+63TFrEz0hnORCu/B/qcbk3AoFvER9JjfCTK+i8fObwCudJf8M=
X-Google-Smtp-Source: AGHT+IE8KNo6h9P+hO82/XMMmYdvNPlUxhLjsn8Bh7xGr43q6/gL/9uAehuo7PCZY4KC/Ns/Cr8pTg==
X-Received: by 2002:a05:6000:a07:b0:33d:4e4:686e with SMTP id
 co7-20020a0560000a0700b0033d04e4686emr10084893wrb.68.1708343371946; 
 Mon, 19 Feb 2024 03:49:31 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 w2-20020adfec42000000b0033d13530134sm10088512wrn.106.2024.02.19.03.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 03:49:31 -0800 (PST)
Message-ID: <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
Date: Mon, 19 Feb 2024 12:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
Content-Language: en-US
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
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
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

On 19/2/24 12:27, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>> On 16/2/24 20:54, Philippe Mathieu-Daudé wrote:
>>> On 16/2/24 18:14, BALATON Zoltan wrote:
>>>> On Fri, 16 Feb 2024, Philippe Mathieu-Daudé wrote:
>>>>> We want to set another qdev property (a link) for the pl110
>>>>> and pl111 devices, we can not use sysbus_create_simple() which
>>>>> only passes sysbus base address and IRQs as arguments. Inline
>>>>> it so we can set the link property in the next commit.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> hw/arm/realview.c    |  5 ++++-
>>>>> hw/arm/versatilepb.c |  6 +++++-
>>>>> hw/arm/vexpress.c    | 10 ++++++++--
>>>>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>>>>> index 9058f5b414..77300e92e5 100644
>>>>> --- a/hw/arm/realview.c
>>>>> +++ b/hw/arm/realview.c
>>>>> @@ -238,7 +238,10 @@ static void realview_init(MachineState *machine,
>>>>>     sysbus_create_simple("pl061", 0x10014000, pic[7]);
>>>>>     gpio2 = sysbus_create_simple("pl061", 0x10015000, pic[8]);
>>>>>
>>>>> -    sysbus_create_simple("pl111", 0x10020000, pic[23]);
>>>>> +    dev = qdev_new("pl111");
>>>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x10020000);
>>>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[23]);
>>>>
>>>> Not directly related to this patch but this blows up 1 line into 4 
>>>> just to allow setting a property. Maybe just to keep some simplicity 
>>>> we'd rather need either a sysbus_realize_simple function that takes 
>>>> a sysbus device instead of the name and does not create the device 
>>>> itself or some way to pass properties to sysbus create simple (but 
>>>> the latter may not be easy to do in a generic way so not sure about 
>>>> that). What do you think?
>>>
>>> Unfortunately sysbus doesn't scale in heterogeneous setup.
>>
>> Regarding the HW modelling API complexity you are pointing at, we'd
>> like to move from the current imperative programming paradigm to a
>> declarative one, likely DSL driven. Meanwhile it is being investigated
>> (as part of "Dynamic Machine"), I'm trying to get the HW APIs right
> 
> I'm aware of that activity but we're currently still using board code to 
> construct machines and probably will continue to do so for a while. Also 
> because likely not all current machines will be converted to new 
> declarative way so having a convenient API for that is still useful.
> 
> (As for the language to describe the devices of a machine and their 
> connections declaratively the device tree does just that but dts is not 
> a very user friendly descrtiption language so I haven't brought that up 
> as a possibility. But you may still could get some clues by looking at 
> the problems it had to solve to at least get a requirements for the 
> machine description language.)
> 
>> for heterogeneous emulation. Current price to pay is a verbose
>> imperative QDev API, hoping we'll get later a trivial declarative one
>> (like this single sysbus_create_simple call), where we shouldn't worry
>> about the order of low level calls, whether to use link or not, etc.
> 
> Having a detailed low level API does not prevent a more convenient for 
> current use higher level API on top so keeping that around for current 
> machines would allow you to chnage the low level API without having to 
> change all the board codes because you's only need to update the simple 
> high level API.

So what is your suggestion here, add a new complex helper to keep
a one-line style?

DeviceState *sysbus_create_simple_dma_link(const char *typename,
                                            hwaddr baseaddr,
                                            const char *linkname,
                                            Object *linkobj,
                                            qemu_irq irq);

I wonder why this is that important since you never modified
any of the files changed by this series:

$ git shortlog -es hw/arm/realview.c hw/arm/versatilepb.c 
hw/arm/vexpress.c hw/display/pl110.c hw/arm/exynos4210.c 
hw/display/exynos4210_fimd.c hw/i386/kvmvapic.c
     66  Peter Maydell <peter.maydell@linaro.org>
     34  Markus Armbruster <armbru@redhat.com>
     29  Philippe Mathieu-Daudé <philmd@linaro.org>
     28  Paolo Bonzini <pbonzini@redhat.com>
     17  Andreas Färber <afaerber@suse.de>
     13  Eduardo Habkost <ehabkost@redhat.com>
      8  Greg Bellows <greg.bellows@linaro.org>
      7  Krzysztof Kozlowski <krzk@kernel.org>
      6  Gerd Hoffmann <kraxel@redhat.com>
      5  Richard Henderson <richard.henderson@linaro.org>
      5  Jan Kiszka <jan.kiszka@siemens.com>
      5  Igor Mammedov <imammedo@redhat.com>
      4  Xiaoqiang Zhao <zxq_yx_007@163.com>
      4  Thomas Huth <thuth@redhat.com>
      4  Anthony Liguori <anthony@codemonkey.ws>
      3  Stefan Weil <sw@weilnetz.de>
      3  Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
      3  Guenter Roeck <linux@roeck-us.net>
      3  Daniel P. Berrangé <berrange@redhat.com>
      3  Alistair Francis <alistair.francis@xilinx.com>
      2  Roy Franz <roy.franz@linaro.org>
      2  Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>
      2  Marcel Apfelbaum <marcel.a@redhat.com>
      2  Linus Walleij <linus.walleij@linaro.org>
      2  Like Xu <like.xu@linux.intel.com>
      2  Juan Quintela <quintela@trasno.org>
      2  Igor Mitsyanko <i.mitsyanko@samsung.com>
      2  Hu Tao <hutao@cn.fujitsu.com>
      2  David Woodhouse <dwmw@amazon.co.uk>
      1  Zongyuan Li <zongyuan.li@smartx.com>
      1  Wen, Jianxian <Jianxian.Wen@verisilicon.com>
      1  Vincent Palatin <vpalatin@chromium.org>
      1  Tao Xu <tao3.xu@intel.com>
      1  Sergey Fedorov <serge.fdrv@gmail.com>
      1  Prasad J Pandit <ppandit@redhat.com>
      1  Prasad J Pandit <pjp@fedoraproject.org>
      1  Pranith Kumar <bobby.prani@gmail.com>
      1  Peter Crosthwaite <peter.crosthwaite@xilinx.com>
      1  Nikita Belov <zodiac@ispras.ru>
      1  Martin Kletzander <mkletzan@redhat.com>
      1  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
      1  Marcelo Tosatti <mtosatti@redhat.com>
      1  Marcel Apfelbaum <marcel@redhat.com>
      1  Marc-André Lureau <marcandre.lureau@redhat.com>
      1  Laurent Vivier <lvivier@redhat.com>
      1  Laszlo Ersek <lersek@redhat.com>
      1  Kevin Wolf <kwolf@redhat.com>
      1  Jean-Christophe Dubois <jcd@tribudubois.net>
      1  Igor Mitsyanko <i.mitsyanko@gmail.com>
      1  Grant Likely <grant.likely@linaro.org>
      1  Gonglei (Arei) <arei.gonglei@huawei.com>
      1  Frederic Konrad <konrad.frederic@yahoo.fr>
      1  Fabian Aggeler <aggelerf@ethz.ch>
      1  Eric Auger <eric.auger@linaro.org>
      1  Emilio G. Cota <cota@braap.org>
      1  Dirk Müller <dirk@dmllr.de>
      1  David Gibson <david@gibson.dropbear.id.au>
      1  Chen Qun <kuhn.chenqun@huawei.com>
      1  Chen Fan <chen.fan.fnst@cn.fujitsu.com>
      1  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
      1  Anthony Liguori <aliguori@amazon.com>
      1  Alexander Graf <agraf@csgraf.de>
      1  Alex Chen <alex.chen@huawei.com>
      1  Alex Bennée <alex.bennee@linaro.org>


