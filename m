Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3CD15DBC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqRd-0002DI-PG; Wed, 03 Dec 2025 12:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqRS-0002Ab-45
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:15:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqRQ-0001Wa-GP
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:15:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so38929465e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782099; x=1765386899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xYjtRJcO/yadDKzGxT7iIjwvDnBt2aZscqf7XVPkH+E=;
 b=cvUCx8kSogDLv6EkfnViWRgAE1XFhhD+7wr1flbfQ79kXkFKscXDh+REQfs6wpQjYX
 6ZKCbwZb0xPbpLn1fkpYbBDdqbZl3pl3CJNOM6ODRlh7WrfVaAMVpC6wPxiOcnwy6pfi
 iiLIweBufcZOM24uOou5x34Eg4iJA4IYcUT9Lxx1rKQtPMgMUTbBDKaDelLLXIvWwqbT
 4EiZQztxOOeESXVcKxKvNHTeqt7xIo30YurMGC83oa+J0fLd207hnD3SjgMrptXlmmbd
 hKWeKAWhsgRCQwFaTYVW9iavoMcLWfEXzikSJSjeWMpEhJvPXkxgn8NQdnR/nb76j8T8
 Su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782099; x=1765386899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYjtRJcO/yadDKzGxT7iIjwvDnBt2aZscqf7XVPkH+E=;
 b=VNXb0GSKx8ZVVSjmktK1SOqEiB4rZiBymM6dU70PVgbK82MDyIokDHlm69p52zTmf0
 KHHRSqaVMmiTJBDY1Vp7Khq5PUbZwMwzfMl//mcjB9jAul1IStdR9sImg0X12sPQzAYs
 mfaDCtD1vWi5dU+qweQf4meoKukpsiJnuXTrFNKBOW4zoz4mQ2upLC9jS1yMWWdzt7zR
 LUmCRPqNchKup4d6ZkYLp9A2Vix9DnKObEyIqMcay5ozsFD5CMAflJ+GDQNqRNb4ygZU
 v2RjVhgwOZhSCMHdYKxxTM7kb3guE8NA09HqE8vxwXMJzH5n7OcwM5kMepX+YKEq6eaj
 HL2w==
X-Gm-Message-State: AOJu0YxmlL+7mSEbIQlnUuQy8tP0YJUlmzMocQTsKq+JxPwsLwY4Fm/K
 mS0OJdxJfMeIIJWgmGSdFBoNZPDxXzZAiEpnwICr8Z+NE85Ahpf+Z2H0/zN3iSQp34k=
X-Gm-Gg: ASbGncvyJ5Fd9hJ1fV4JAaRIyAMswsepVv+fKvdNRfyiZstomF+Om+msdpIWhYnux6i
 1vKdh2kIH6ZFvtSSrJDJxtSlO9ac+eShRO+KTc6r3CSaTDvBSw/Pk+125uCdTHc/OJtWQk78Z+7
 8zSJ08NZp413ArddeE0sJQKAikm267VuOXDZp+dTJ5fiR0xzfHW7rLtff7ex8LZ9HVU1HJ2Xyi8
 3goxKk/L6GoAypy10fH+kJYS0aDcKD9UnKrjHhKTXJOz/ErXaX+8a/0wRtqRENBLlAaUwueMD5X
 wbNPdGrEjX+U8+jGR8DlaVT8+Pnr8j/s56wTX0t1ElRhH/1sXT/adVmbo5SYcgoCyysaLeuP6ba
 Ud/AX6fmLFayBXMC0B+tTJ/jJj2LFPjZvHiaDpoqDQwfkxtR43odXmn0x6HkSws02yA8NoYdL3O
 9HiLORj1tj9zlbYMCpOQhRAbKM1e62hdbV5aDIJ6FbhDsj7MZ1B3IP0w==
X-Google-Smtp-Source: AGHT+IH2uld1GK2UW8XysRayYNpv1eKff5zuPCQ7YVvMA9aNyP7FlxXLLpzLDmVavezq9yCYEbEGaA==
X-Received: by 2002:a05:600c:4f90:b0:479:1348:c65b with SMTP id
 5b1f17b1804b1-4792af34f30mr27163395e9.26.1764782098874; 
 Wed, 03 Dec 2025 09:14:58 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5168acsm37255423f8f.0.2025.12.03.09.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:14:58 -0800 (PST)
Message-ID: <05f92a77-7587-4441-a252-01e4705a6892@linaro.org>
Date: Wed, 3 Dec 2025 18:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org> <aTBccn2LIv7puGzR@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aTBccn2LIv7puGzR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/12/25 16:51, Zhao Liu wrote:
> Hi Philippe,
> 
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 82c3e7c855b..6dc9f64b74d 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -683,14 +683,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>                              graphic_width, graphic_height, graphic_depth,
>>                              (uint8_t *)&macaddr);
>>   
>> -    dev = qdev_new(TYPE_FW_CFG_IO);
>> -    qdev_prop_set_bit(dev, "dma_enabled", false);
>> -    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
> 
> There's another difference: fw_cfg_init_io_nodma() uses `machine` as the
> parent and here sun4uv uses `ebus`.

Ah yeah I wanted to comment it but forgot :facepalm:

> 
> I think maybe one reason to use `ebus` is because...
> 
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> -    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
> ... because the parent region is managed by ebus.
> 
> Perhaps we should add another argument: Object *parent?

I thought about it but don't think so, all instances but this one use
the machine container.

I'll improve the description.

> 
>> -                                &FW_CFG_IO(dev)->comb_iomem);
>> -
> 
> Thanks,
> Zhao
> 


