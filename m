Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRTx-0000d0-Gh; Wed, 26 Jun 2024 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRTh-0000cL-91
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:10:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRTa-0002sw-Gh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:10:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-364b2f92388so4627981f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719403812; x=1720008612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5xPIXawE0m6oSGds4xe16QOy61gJ3mWJ2/mnt4hhRXU=;
 b=CnynPO5CdcdP/0MHOAtKCroQpP2je4+43NwtY9Q3pwGjWgzFPWpItmygY1rfpURyav
 rKK2H5zQ6CvOM0gqmlwG2pyu48MeoxJw7E0cCDUC7k2LmexhATiUKVNieGZaQrvsC65k
 SPom5Q4MHTJyZp6s8jyUgeMtrZuEy9sOAlJ5Ij+ey0SnpSG+XqGUb7z8av4R3QbLQ7MW
 ALKEZyy64fWhbHH4zZQ7LMF3yqJzoIeDzF5friDQI1y633O0EOoa5mkWH0NP08UqopQI
 hmffjJY/fg9RDkMJb9hyWW+whlPO+KAo20ke/VCAL9hp8yV0+ADLOv8HwW4dHzc634bZ
 jyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719403812; x=1720008612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xPIXawE0m6oSGds4xe16QOy61gJ3mWJ2/mnt4hhRXU=;
 b=I6JojJD5urANqgqE+DObRe2Cc9VyOexTr/ba3wWwTPJlaQejshulqPxeH2SrtFPNtX
 x5Y0EkcBGuKaNlyvfR5hTSWiQTTIs2Ro28S4Z/aPEL4peSzDngtKg8M3dgnrTdXr+oUT
 AKYl8s0T9kRZVUlO30L0C/75HvF9MQYh6CxVYBf5QSGbNofRYg3dkxaAoBkN8V+J2805
 McKfg9OhvAgh0rusmHHEdvlhfmm8Rlc7OC6XvZTMRNwA8Gi+YVu0Njd1Pok2BMMS9nyt
 KhX9FLDiSEgkukYr5ShbHPclHXJ0ek4Jo6Z+HROwE2ttBnSZ01RxG53rOpS/mcn22O9T
 CVtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOosVcbaFoBAAtsfKkPCfEdeJJFsZ4QpynW8qL14Rr/kdes5DiYWgxUDk1TGEwsjasvYpcbMXXP7AMqIfyb+BcsjaYD3M=
X-Gm-Message-State: AOJu0YzjNBLxTVTGuW/FAuNFuOlN3+chSjJ7MuR5uGbm4ffP8Ob40oG5
 W1gc0rLY3UGuS9vNzXImcO6Jgp/0PSvmWBedlmQb0iusqt5MbGjtI0VIQAym+vA=
X-Google-Smtp-Source: AGHT+IEjOZCuOPl9JTASD6bgSdxL6OCE1wh1eHIAmag4/sB2s2EzZTB+bPIlibGRgcXMSPGw/Xm7Fg==
X-Received: by 2002:adf:a382:0:b0:362:f291:6f90 with SMTP id
 ffacd0b85a97d-366e9652bcemr6164036f8f.60.1719403811976; 
 Wed, 26 Jun 2024 05:10:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c1d1sm15629375f8f.51.2024.06.26.05.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:10:11 -0700 (PDT)
Message-ID: <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
Date: Wed, 26 Jun 2024 14:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: maobibo <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Bibo,

On 26/6/24 06:11, maobibo wrote:
> 
> 
> On 2024/6/5 上午10:15, Jiaxun Yang wrote:
>> It was missed out in previous commit.
>>
>> Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   hw/intc/loongarch_ipi.c | 347 
>> ------------------------------------------------
>>   1 file changed, 347 deletions(-)


>> -static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
>> -{
>> -    LoongArchIPI *s = LOONGARCH_IPI(dev);
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> -    int i;
>> -
>> -    if (s->num_cpu == 0) {
>> -        error_setg(errp, "num-cpu must be at least 1");
>> -        return;
>> -    }
>> -
>> -    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), 
>> &loongarch_ipi_ops,
>> -                          s, "loongarch_ipi_iocsr", 0x48);
>> -
>> -    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
>> -    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
>> -
>> -    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
>> -
>> -    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
>> -                          &loongarch_ipi64_ops,
>> -                          s, "loongarch_ipi64_iocsr", 0x118);
>> -    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
> It is different with existing implementation.
> 
> With hw/intc/loongson_ipi.c, every vcpu has one ipi_mmio_mem, however on 
> loongarch ipi machine, there is no ipi_mmio_mem memory region.
> 
> So if machine has 256 vcpus, there will be 256 ipi_mmio_mem memory 
> regions. In function sysbus_init_mmio(), memory region can not exceed
> QDEV_MAX_MMIO (32).  With so many memory regions, it slows down memory
> region search speed also.
> 
> void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
> {
>      int n;
> 
>      assert(dev->num_mmio < QDEV_MAX_MMIO);
>      n = dev->num_mmio++;
>      dev->mmio[n].addr = -1;
>      dev->mmio[n].memory = memory;
> }
> 
> Can we revert this patch? We want to do production usable by real users 
> rather than show pure technology.

Since commit b4a12dfc2132 this file is not built/tested anymore:

-specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: 
files('loongarch_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: 
files('loongson_ipi.c'))

We don't want to maintain dead code.

Regards,

Phil.

