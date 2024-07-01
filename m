Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D9CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEKf-0002Ie-Jo; Mon, 01 Jul 2024 06:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOEKZ-0002Fw-R9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:32:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sOEKY-0004PJ-3y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:32:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f9b364faddso14557305ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719829936; x=1720434736;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LaKMDmSJyDBeKwe5zEq/XIaHPyFkoDGd40m3meJj5V8=;
 b=cdbzZySKiqD9BD/b7Fv57S0Zq68RkXRRtRy5gyq3YAhzx08J2nLnPjTL1XqlCrncy0
 nqv/wBtlmsfuM8MEErhfUuanfcPgCANdJ+5sMG/ZQloRchdcReos9k3adZm8pyBZrDb/
 ZaS0TVT73LiKdNmgIixOzucMIN7TupR6wJTskt7A+dS2mh7F7oDImWT9qG4793GWqgoY
 nDMqepT8hGaLciywbvIOz4Emsl2YEluGuPtq79zKRbSe7ThhCmr8O0+5Gk33AeCkWI3G
 SZYgXlf1aENNIfkoFBmUCGtJndCE69Be3XRrPXtKzGxZ49tZ7+tobqisQ+fFX3CaP0Ve
 b7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719829936; x=1720434736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaKMDmSJyDBeKwe5zEq/XIaHPyFkoDGd40m3meJj5V8=;
 b=v8XcFMC2mUQHMIQfUa86sfWiEK2dYXBGaqDv/CeihcCwl4cSXBmqQiawIbbY/3cH+i
 1/kwkAK0fpptiJ1wxZ+VLOOGxvM3zMCQIJIwFqi8gZ1ILoNB4r5l5g4FY90pqvw0Jqha
 4P2EmjtT+fEGoZyuGYYPEXDJMN+nHZryPnMsCIk8qc07wwgxOqSfPT9OFp2Ib4GNFhg9
 36afsY81GCsl+PMfyudDLjD+QflfkBtlO6jLtTL332gyJNcfRW27p1+etpipagw7+f68
 7aY63VTlHKBr+Ca+GWUPD3OL3t/Wwdgs0voYPXmwhcb9zK3syqLsIJLG058bnYONnv6x
 YG8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVINRtBHurmUfjP64T+05Hfw8z+ukXj+tgwa3trO6pwI7Vgim48k+digqjETMuEqicPTtcvLd1i5+K/OSVP+992TkxF0WA=
X-Gm-Message-State: AOJu0YwgAZs6ut+RuBDcHKsmxCadw6/rsCuO9j+iYyZPLaMPZp4gv4eE
 si8kAXLu7yK+wIpJr4lvu6e940nJUsDmty2DPoeREh6/WGFhicd3ZIdjKCtQHdk=
X-Google-Smtp-Source: AGHT+IEKmVqkY2e8wsen9HhuYMx8+Mym0zdEZOfbKZBz/hhr4wDZgrMJTesTt5cSS4dIaQpKY4F2aw==
X-Received: by 2002:a17:90b:3787:b0:2c7:f3de:27ef with SMTP id
 98e67ed59e1d1-2c93d7b13a6mr2604313a91.42.1719829936172; 
 Mon, 01 Jul 2024 03:32:16 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3d6179sm6415163a91.48.2024.07.01.03.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 03:32:15 -0700 (PDT)
Message-ID: <a2bc1690-c539-4f85-abaf-7284047acc94@daynix.com>
Date: Mon, 1 Jul 2024 19:32:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] hw/isa/vt82c686: Define a GPIO line between
 vt82c686 and i8259
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-4-750bb0946dbd@daynix.com>
 <1e00690f-5c1e-671f-3ba4-57f16eaa9fc4@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1e00690f-5c1e-671f-3ba4-57f16eaa9fc4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/29 22:08, BALATON Zoltan wrote:
> On Thu, 27 Jun 2024, Akihiko Odaki wrote:
>> This fixes qemu_irq array leak.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> hw/isa/vt82c686.c | 7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>> index 8582ac0322eb..629d2d568137 100644
>> --- a/hw/isa/vt82c686.c
>> +++ b/hw/isa/vt82c686.c
>> @@ -715,13 +715,14 @@ static void via_isa_realize(PCIDevice *d, Error 
>> **errp)
>>     ViaISAState *s = VIA_ISA(d);
>>     DeviceState *dev = DEVICE(d);
>>     PCIBus *pci_bus = pci_get_bus(d);
>> -    qemu_irq *isa_irq;
>> +    qemu_irq isa_irq;
>>     ISABus *isa_bus;
>>     int i;
>>
>>     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
>>     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
>> -    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
>> +    qdev_init_gpio_in_named(dev, via_isa_request_i8259_irq, "i8259", 1);
> 
> The chip has no such pin so this is a QEMU internal connection that I 
> think should not be modelled with a named gpio. I think we really need a 
> function to init a qemu_irq (for now we only have one that also 
> allocares it) so then we can put this in ViaISAState and init in place. 
> I'll make a patch.

According to qdev_pass_gpios(), it is valid to have a GPIO line even if 
a QOM device to be connected with the GPIO line is actually included in 
one chip package. I didn't use qdev_pass_gpios() because it cannot 
expose a subset of the GPIO array.

Regards,
Akihiko Odaki

