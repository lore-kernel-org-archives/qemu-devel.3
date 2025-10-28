Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1043ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDbpb-0005Fk-UK; Tue, 28 Oct 2025 01:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDbpa-0005FF-48
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:01:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDbpX-0005D3-LR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:01:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso547715e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761627669; x=1762232469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AoLEj6A/DGBWwzlmTYiiD3gq3iqwt5rV7Bg4bmyO1Nc=;
 b=uLKRlkyZaL+JKg9w65ovvhhhB5uNZeD6WNctookCyUWng3IieF+2kDeEVY+rIKSKhD
 19OLHM1kicjQ/KBZCgunaDLY953x6O4FfWRLaPy20HZQxqnaeBlo0n08jzJjtO5CN9Ob
 xZGBoMR1/RbweK58TEQGgNNDy+yhAD5AeiHH+j+8osmbeACiVHKB/hmTEgRgoOo5RjEe
 CxzFdlUMPqRSsuyYoqrfizDYzvp66d3JBm0/t0smfv9ce5LhQR8S23vsklDVTQsp/jqm
 dEvrtFpM3yEX/k6PMxKwMMdXrB3e0fQL2DIsnpC0HyATPRVaQPUlTj00I2DQBw2Lhkyt
 sEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761627669; x=1762232469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AoLEj6A/DGBWwzlmTYiiD3gq3iqwt5rV7Bg4bmyO1Nc=;
 b=Fvxfgvf+WryErEYC4b23OltO1Ox+mScX1qdLI2gMRL4TcRV5IpzN5Gr+58g0xScS2n
 FDfF/omoHAdp5bF6RBvuSY1SrozjOFnCHjPrr/I797aBqR+UtqyPb14PlDYtIlXkJkR5
 f2z/MpY6dO4Kh3Z8tgD+Ja0GgZQBSybf+MjxJfYDm+YkX31er3ZHWFKwWBCYwDVeEzQw
 DtKdm5wJFCJmRzep4d17kbrW5gXStwAq/saMLrno+R2hkukB0fzGxifppb/2cj2d25zr
 bX8KfNsHreXP3gmbNDi20mjNuO40ldE+FD8R43RfyVRddT0O+DLU7uhVQxnyR3LLb+57
 QxwQ==
X-Gm-Message-State: AOJu0YxtJskaRECbMgK3LQ7c3CS5d1KYO/4BmpEOLFmDJeQjaQymvH9a
 SnKnO2nWvVo8GaGOTmgU8VilZ5Mqfb/9JCws0yvDh0Tk/ObYBXDairun33aR60zqhgo=
X-Gm-Gg: ASbGncviUKrJFMKy9qhCFfwH7KEBNtq96FuObhQAxrTCnJPXxMYZTQ+PvoHH+5vdptr
 nOJ2Tw0bW2I8ldQMdtenMrTY3poPFL8QOwlJdmBP+OM05FACrL5nbJcKVsTUZXfprDwE4EjfI8C
 SvSjWUX+/ZCUQfrI9d+mz1gzOBwXkGSIDnI9wcllR/xjavcdWgzHeWXBN2H5BY7cROhmM2SsGbB
 InbKpKwMUuWvC1Qy9XtT9egftZprK8xYOO21h9DX2Pp3dhCkfIASe3tuQDplPM0aMhyJ3e5LFMu
 7uBXwCvt5aqzrqY4+UvxooAFdq+4EhV0FGhaI2LWwWKtEiFX44KrSttZhVs6qKbaOQ9z5bs6YWr
 ZrfApVPQz1k5X2oMEQFC6hJDjyME+p1EK+bRakzCwcpcphEFlzwQxs7J5BtjEbapPziX+U//Fwr
 plH0yYe26db86fccECMzRFzEGQBtjUYoXSOkIGWOCXXF0KBFCn
X-Google-Smtp-Source: AGHT+IHPrUU7J5FFBzqtBoHbXk2y0YVui5cx8E/QGc6KjgIqN6YPglyd3Xbhnssy5QShqAYD4na7GQ==
X-Received: by 2002:a05:600c:3b24:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47717df7c8emr17406335e9.4.1761627668728; 
 Mon, 27 Oct 2025 22:01:08 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771832f372sm11830375e9.0.2025.10.27.22.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 22:01:07 -0700 (PDT)
Message-ID: <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
Date: Tue, 28 Oct 2025 06:01:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/10/25 20:47, BALATON Zoltan wrote:
> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>> These memory windows are a result of the address decoding in the
>>> Articia S north bridge so better model it there and not in board code.
>>>
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>
>>
>>> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, 
>>> Error **errp)
>>>   {
>>>       ArticiaState *s = ARTICIA(dev);
>>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>>> +    MemoryRegion *mr;
>>>       PCIDevice *pdev;
>>>         bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
>>> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, 
>>> Error **errp)
>>>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>>>                             TYPE_ARTICIA, 0x1000000);
>>>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
>>> +    mr = g_new(MemoryRegion, 1);
>>
>> Won't Coverity or other analysis tools complain about the leak?
>> (this is why we usually keep a reference in the device state, here
>> ArticiaState). Otherwise:
> 
> According to https://www.qemu.org/docs/master/devel/memory.html#region- 
> lifecycle
> there should be no leak and keeping a reference should not be necessary 
> as the lifetime is managed by attaching it to the owner object so no 
> need to keep a reference when it's not needed otherwise. Not littering 
> the state struct with unneded references makes it easier to comprehend 
> so I'd only keep things there that are necessary.

IIUC this doc is about what happens within the allocated MemoryRegion,
regardless of where it is allocated.

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Can I keep this R-b considering the above?
> 
> Regards,
> BALATON Zoltan
> 
>>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", &s->mem,
>>> +                             0, PCI_LOW_SIZE);
>>> +    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
>>> +    mr = g_new(MemoryRegion, 1);
>>> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", &s->mem,
>>> +                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
>>> +    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, 
>>> mr);
>>
>>


