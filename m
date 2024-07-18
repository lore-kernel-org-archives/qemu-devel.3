Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AB2C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUM5W-0006LW-3L; Thu, 18 Jul 2024 04:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUM5Q-00063f-81
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:02:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUM5O-0002e5-Kg
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:02:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-368380828d6so344846f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721289717; x=1721894517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZP6Dg8kIAyTqmZXIo8IROyrLu7CcfMIYA4R/ekbn6g=;
 b=f60hVZ1hzrbYAi3Taur/7TYW8Dv0XQ5ivcik43IJqsoA6KHkUZwV8tVGkhjiCSwz78
 L+PdbNlYAbW5UcJplWtKceK1nR57t6KrRWeHHI/SncuT4GttRz2tuMgWkBFq7rQeOVUz
 /tpVAXRrf2txrrn5dWuqbrH7pOxRl/DTpQvoKBpLEjk7xUkuo026YcVPLO5UVaa0m80Z
 +axaBWK2ED6zD9rJnqmD0o9K8MgSJYhxNnryL5wW322nQ347QhZB9TLdecacv/vdUYrH
 dYkUpOujt+sKnSOwDQBXRFp9+2Fk7b99POh3RIC9gaI45622xpZIKanO92nA8HmRlHS1
 xj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721289717; x=1721894517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZP6Dg8kIAyTqmZXIo8IROyrLu7CcfMIYA4R/ekbn6g=;
 b=Z0ZCnxERbE6lU/3N9h/KTwEraHo+zRLIWQ2TW1dxIYPvfC6MdShjAJFZfeezmHWul6
 cAMtQBU7VMVRO5tcnROWx8BRiokyxHzqJDG4Wgof+PdxvbDYsjDs/XR/QxROP3c1NuL2
 S+kIWIufRng0y7/Mq61Ezku/sLIMcuV4CNebZRXnPPU4IkGW8LFtciYmY7Ve4anAjRvl
 YZzB9OfrLGsZjaA+NGhyegT4CXLi61CV2VoNh2SReFqFQYR4/fIGlGWzsNsdqg4qJCk+
 MZjUDLrjDpho3Esab3gw90c6t0l97UwUUo6f8z6mQS/ZrSwoSBASAc7Ma8R8uXgZosdl
 11cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFi4s70Uitk8Gg4qQqoJBtMH+68369HRFrUGubHphZ6oTnC5Tc6lD6wAjNKeROBdSIaAaMl6n6c0nPBL9AM9diXN2FJ6I=
X-Gm-Message-State: AOJu0YwUbIfUB/z+bUBBtZ7lALXoxnDf7Vq0zwJDQ041fIjAZBdNksJe
 O1/WSEgz6ZYXxDdjU1J+vjffnyb454U18T4KaWiu4oqy0C12KNybEHh1Tsby3vs=
X-Google-Smtp-Source: AGHT+IHOSiPBhjsCMq5ncbUubTWeRxAqCJScNsbSq1tkHV47fcu8dQ5Rftz/HwsUGjBjfDyK6BencA==
X-Received: by 2002:a5d:60cf:0:b0:367:9cb6:8fc5 with SMTP id
 ffacd0b85a97d-36831652581mr2802693f8f.26.1721289716734; 
 Thu, 18 Jul 2024 01:01:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368307e2015sm3475875f8f.5.2024.07.18.01.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 01:01:56 -0700 (PDT)
Message-ID: <0f354171-ac6b-4fd8-b0e7-937e87b50a26@linaro.org>
Date: Thu, 18 Jul 2024 10:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_realize()
To: maobibo <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20240717214708.78403-1-philmd@linaro.org>
 <20240717214708.78403-5-philmd@linaro.org>
 <94592136-8e6b-0b99-07f3-e98ea0c4d658@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94592136-8e6b-0b99-07f3-e98ea0c4d658@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 18/7/24 04:11, maobibo wrote:
> 
> 
> On 2024/7/18 上午5:46, Philippe Mathieu-Daudé wrote:
>> From: Bibo Mao <maobibo@loongson.cn>
>>
>> In preparation to extract common IPI code in few commits,
>> extract loongson_ipi_common_realize().
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> [PMD: Extracted from bigger commit, added commit description]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/intc/loongson_ipi.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
>> index 3b3481c43e..40ac769aad 100644
>> --- a/hw/intc/loongson_ipi.c
>> +++ b/hw/intc/loongson_ipi.c
>> @@ -275,7 +275,7 @@ static const MemoryRegionOps loongson_ipi64_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>> -static void loongson_ipi_realize(DeviceState *dev, Error **errp)
>> +static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
>>   {
>>       LoongsonIPIState *s = LOONGSON_IPI(dev);
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> @@ -301,20 +301,31 @@ static void loongson_ipi_realize(DeviceState 
>> *dev, Error **errp)
>>       sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
>>       s->cpu = g_new0(IPICore, s->num_cpu);
>> -    if (s->cpu == NULL) {
>> -        error_setg(errp, "Memory allocation for IPICore faile");
> Philippe,
> 
> Thanks for the whole series, it looks to me. It is split into small 
> patches and adds new option CONFIG_LOONGSON_IPI_COMMON, it is easier to 
> review and compile for multiple targets.
> 
> One small nit, do we need keep checking sentence for if (s->cpu == NULL)?

No because g_new0() can not fail. Checking return value only
makes sense for g_try_new0() which returns.

> Overall, for the whole series it is ok for me and works well on 
> LoongArch machine.

Thanks!

> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Tested-by: Bibo Mao <maobibo@loongson.cn>

Jiaxun, do you mind re-testing the series for your MIPS machine?

Regards,

Phil.

