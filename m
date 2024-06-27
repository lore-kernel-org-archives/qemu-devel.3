Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398ECC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMolw-000193-Ie; Thu, 27 Jun 2024 09:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMols-00018u-F6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:02:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMolq-0006K5-CR
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:02:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3658197cdbbso4233835f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719493356; x=1720098156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nTxJdwZzoCmm5TK5yyHJ7yBR0kvfNA+yBcm6LxQ4jNw=;
 b=ecGUaTA7z8Ai6l3F9pxISQfFsoAkBRPVN1qjDe5djT3mhTQOj91oskforCoRi4lYTi
 Ollw1Gnx1wr9vUGVQxkm2tqWmjIOWAnVh1R05Zi+ZApxeUlBIOfujVu24nb1BYWf6Vsp
 OPbT9IZAsIEQec1votUPQ8bJJHMM+fPOmCfIlJtEyXbSuG3qZu0f7t9/rMP5SB1PD0W4
 gAIMUNnTROhr/Cd9iS8YduEl9pfP57RHXL74Cc2+E6jxnbaGk4UIg30Jhp3NMj9l2+aB
 rLZos6XuYhIIjn2QBrjoUG9ao44nua03EnRgKqpIkrntrE57HXwxp3fAcHXi312e60n5
 FmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719493356; x=1720098156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTxJdwZzoCmm5TK5yyHJ7yBR0kvfNA+yBcm6LxQ4jNw=;
 b=RYYbph68n/bQH7I7TQ9OGmLoChTu36F1FgbBKtuD4/wYTUgBRfnX5qB29X4c6cWZ2i
 duGGqFEdhJPW11m6gOyWxk9VpeqWdavDBbDrL+BNl+RBZV0s8LURHxODga73hbbrv/2w
 jpvyrJ5LXU7eWUkpOm5b+wPCtWGF2MPHirLV3Byguiwlm9eRxA7ztlFr1+EGKqvISqpb
 NGJEE1TNgahtx8Pj2LtdmULiKPKeFBdU634lApTRqyUhPBeWM9fr7Ya3EaJ59Dt9gKNy
 aeTnHP4ALo+DdMbzkM5x47D5ZdsHr7lo64VJy3fkO0KW63lmZh65PatukMfJ6R+BuVY2
 GKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT+7OQgnVystJ8mrWTE7htYY5tLjzIISYOr63/TSlCV6RtZus30u5gO7AGEyQAPuaGJsNfgwfrM/gd1fKI1EHZHdn5UjM=
X-Gm-Message-State: AOJu0YxgnNgcf13n0jv0URT5dq3456syVcbQgmM9IOEFloFKujFFa/Ku
 LKKMHHI0sM07OrpJfGntL9LmnGdAE2d6tfv4I9TY4GbmjJZeO2/j7B3nliUohTk=
X-Google-Smtp-Source: AGHT+IGAHFELykuV9NkNMpQL2kwFo6joQxbCsYOMLau8P642ML6JT6159E8tjXFJ4Evu4mjFyqnASA==
X-Received: by 2002:a05:6000:546:b0:360:7c63:53cf with SMTP id
 ffacd0b85a97d-366e948d09amr10350362f8f.19.1719493356108; 
 Thu, 27 Jun 2024 06:02:36 -0700 (PDT)
Received: from [192.168.23.175] (72.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c14fsm1809785f8f.16.2024.06.27.06.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:02:35 -0700 (PDT)
Message-ID: <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
Date: Thu, 27 Jun 2024 15:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: gaosong <gaosong@loongson.cn>, maobibo <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
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

On 27/6/24 04:44, gaosong wrote:
> 在 2024/6/26 下午8:10, Philippe Mathieu-Daudé 写道:
>> Hi Bibo,
>>
>> On 26/6/24 06:11, maobibo wrote:
>>>
>>>
>>> On 2024/6/5 上午10:15, Jiaxun Yang wrote:
>>>> It was missed out in previous commit.
>>>>
>>>> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> ---
>>>>   hw/intc/loongarch_ipi.c | 347 
>>>> ------------------------------------------------
>>>>   1 file changed, 347 deletions(-)
>>
>>
>>>> -static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
>>>> -{
>>>> -    LoongArchIPI *s = LOONGARCH_IPI(dev);
>>>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>> -    int i;
>>>> -
>>>> -    if (s->num_cpu == 0) {
>>>> -        error_setg(errp, "num-cpu must be at least 1");
>>>> -        return;
>>>> -    }
>>>> -
>>>> -    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), 
>>>> &loongarch_ipi_ops,
>>>> -                          s, "loongarch_ipi_iocsr", 0x48);
>>>> -
>>>> -    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
>>>> -    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
>>>> -
>>>> -    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>>>> -
>>>> -    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>>>> -                          &loongarch_ipi64_ops,
>>>> -                          s, "loongarch_ipi64_iocsr", 0x118);
>>>> -    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>>> It is different with existing implementation.
>>>
>>> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however 
>>> on loongarch ipi machine, there is no ipi_mmio_mem memory region.
>>>
>>> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory 
>>> regions. In function sysbus_init_mmio(), memory region can not exceed
>>> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
>>> region search speed also.
>>>
>>> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>>> {
>>>      int n;
>>>
>>>      assert(dev->num_mmio < QDEV_MAX_MMIO);
>>>      n = dev->num_mmio++;
>>>      dev->mmio[n].addr = -1;
>>>      dev->mmio[n].memory = memory;
>>> }
>>>
>>> Can we revert this patch? We want to do production usable by real 
>>> users rather than show pure technology.
>>
>> Since commit b4a12dfc2132 this file is not built/tested anymore:
>>
>> -specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: 
>> files('loongarch_ipi.c'))
>> +specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: 
>> files('loongson_ipi.c'))
>>
>> We don't want to maintain dead code.
>>
> Hi,  Philippe
> 
> It is commmit 49eba52a5 that causes Loongarch to fail to start.
> 
> What bibao means is that LoongArch and mips do not share "lloongson_ipi.c".
> This avoids mutual influence.
> 
> 
> My understanding of the next sentence is as follows.
> 
> Nowadays, most of the open source operating systems in China use the 
> latest QEMU.
> e.g. OpenEuler/OpenAnolis/OpenCloudOS, etc. These operating systems have 
> a large
>   number of real users. so we need to maintain the stability of the 
> LoongArch architecture
> of the QEMU community as much as possible. This will reduce maintenance 
> costs.

I'm glad there is a such large number of users :)

> Therefore, we would like to restore the 'loongarch_ipi.c' file. what do 
> you think?

My preference on "reducing maintenance cost" is code reuse instead of
duplication.

Before reverting, lets try to fix the issue. I suggested a v2:
https://lore.kernel.org/qemu-devel/20240627125819.62779-2-philmd@linaro.org

That said, both current patch and the suggested fix pass our
Avocado CI test suite (running tests/avocado/machine_loongarch.py).

Is your use case not covered? Could you expand the CI tests so
we don't hit this problem again? (Also we could reproduce and
fix more easily).

Thanks,

Phil.

