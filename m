Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E238C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCPF-0001lI-9k; Wed, 17 Jul 2024 17:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCPE-0001kK-2S
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:41:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCPB-0000st-Vz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:41:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-367aa05bf9dso97001f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252503; x=1721857303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mnrg09Ze/fm0oX+OkrIFOw2+On8NYEEwI7ZeIAdZKw=;
 b=C3YtoddzwtwdW2ZJIiWB6LjqVgDnhovkou6fHht5QHhgRvSrj0KYsqDtwBLjfTCiI8
 3jGg456aV9ZhOJe/YAM8p3jfVZuW0jraarsjE6KT6wLwgeFKMjKzNigxwZj89ZFj0DTh
 W139hEi9G8VLylYHvU/0s42vgQ+ZUJnxoRFMTp3oqs1LBVF6+cWTwDCxb0v7UcOaRAAo
 RrDYgDURuAv3Cn8CUKKK11WIoNNRjCs9fXylTZLDb8IiSgJCVZfVXhd0afgkXALFUUHf
 LzZy83ROrM9jS/kRtub70pXjo/krJQhXs180u1mKbt7EH7haYCdbTq0E9yFo9PF3Ey31
 47TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252503; x=1721857303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mnrg09Ze/fm0oX+OkrIFOw2+On8NYEEwI7ZeIAdZKw=;
 b=OyFW05iT2dObKhttrVi8YG1ZvnEJ+ocRmkAImnZtNGRXfM5e6cQRVYyn0UweUmWA1p
 6/D1WLwI66YtSVMedtyrP/PFsP9bMBxrOp+IcXu9KcJ6bZ/6Eg3pk5xD83qeXGuHuFrT
 9IruCmk5+0YkYPGsRWAhBNhMHPUXZB3K/wSSB/oYpxVn3VAv1nIAGUXgK0a751i9fTRi
 D75qgvFrAgXvYuctBN1oUJuvrParoxmprTCW75jqhBRHQL9JhoCTdcp6DoeX3dpcd2qW
 zs+5Z40gq7G9qK296s0xv/RzO059ztqIGhlpjHHvNzHEH7WVCIz1UocJ9QYjot9aCY4W
 wPhg==
X-Gm-Message-State: AOJu0Yzn5kff+Y8MfP0rr0u2zbMUtFTXI97yZBgKIDxjgA5ERv3SJGDo
 7fc84/tIXaDZEGvvi7wjGUDBFHIz9bvOMlwZVeAVQiijq1ZjE8sJ3DmVaGjV+lD2ZZEIK6STs3a
 jrkY=
X-Google-Smtp-Source: AGHT+IFEukZna4R3bRhuiGmiqY5MxAdZRIjB6X2Gu1coN2XfT2ewDpZXBT+kkFSusUI0IwZODEeQZA==
X-Received: by 2002:adf:e503:0:b0:367:905c:823e with SMTP id
 ffacd0b85a97d-368315fdbcemr1821372f8f.24.1721252503077; 
 Wed, 17 Jul 2024 14:41:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368356df2aasm2229009f8f.37.2024.07.17.14.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 14:41:42 -0700 (PDT)
Message-ID: <6039b2fe-ea15-422d-843e-22aa23692375@linaro.org>
Date: Wed, 17 Jul 2024 23:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>
References: <20240704033802.3838618-1-maobibo@loongson.cn>
 <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
 <d26cf86a-2247-b5d9-3674-64cead2fa816@loongson.cn>
 <b4a9e1e9-467c-2d50-0d24-174fc9e5c5fe@loongson.cn>
 <4061a31e-1cd8-4cd7-96f3-3e5208e12a87@linaro.org>
 <51574a26-9f62-e069-f8db-d7f243f89b44@loongson.cn>
 <80bdfa26-8638-4022-bbd4-e93b6132fc8a@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <80bdfa26-8638-4022-bbd4-e93b6132fc8a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/7/24 13:53, Jiaxun Yang wrote:
> 
> 
> 在2024年7月17日七月 下午5:22，maobibo写道：
>> On 2024/7/16 下午2:40, Philippe Mathieu-Daudé wrote:
>>> On 16/7/24 03:29, maobibo wrote:
>>>>
>>>>
>>>> On 2024/7/16 上午9:04, maobibo wrote:
>>>>>
>>>>>
>>>>> On 2024/7/15 下午11:17, Philippe Mathieu-Daudé wrote:
>>>>>> On 4/7/24 05:37, Bibo Mao wrote:
>>>>>>> Now loongson ipi and loongarch ipi share the same code with different
>>>>>>> macro, loongson ipi has its separate function such mmio region,
>>>>>>> loongarch ipi has other requirement such as irqchip in kernel.
>>>>>>>
>>>>>>> Interrupt irqchip has strong relationship with architecture, since
>>>>>>> it sends irq to vcpu and interfaces to get irqchip register is also
>>>>>>> architecture specific.
>>>>>>>
>>>>>>> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
>>>>>>> is added, it comes from loongson ipi mostly. And it defined four
>>>>>>> abstract
>>>>>>> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000
>>>>>>> machine,
>>>>>>> also can be used for 3A5000 irqchip in kernel mode soon.
>>>>>>>
>>>>>>> Also Loongarch ipi and loongson ipi device are added here, it inherits
>>>>>>> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
>>>>>>> loongson ipi device only passes to compile and make check, it is not
>>>>>>> tested.
>>>>>>>
>>>>>>> Bibo Mao (4):
>>>>>>>     hw/intc/loongson_ipi_common: Add loongson ipi common class
>>>>>>>     hw/intc/loongarch_ipi: Add loongarch ipi support
>>>>>>>     hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>>>>>>>     hw/intc/loongson_ipi: reconstruct driver inherit from common class
>>>>>>
>>>>>> I'll try to respin a clearer v3.
>>>>> I am ok with it since it solve the problem, and it is suitable for
>>>>> 9.1 release. Only that in the long time we hope that intc emulation
>>>>> driver has common base class + tcg/kvm driver, similar with other
>>>>> architecture.
>>>>>
>>>> Sorry for the confusion, I had thought it was another topic.
>>>>
>>>> Thanks for pointing out the problem and welcome the v3 version.
>>>
>>> Please do not post v3, let me post it.
>> Hi Philippe,
>>
>> QEMU 9.1 is coming to soft frozen stage, do you have enough time working
>> on it?  Is it ok to use bugfix patch for 9.1 release version?

Yeah, trying to do my best here. Again I expect splitting your work
in multiple commits would have accelerated the review process.

> 
> Bug fix is always qualified between soft freeze and release.
> 
> I tested the series for MIPS yesterday and can confirm it do work.
> 
> Will give my tags on v3.

Thanks, I think I'm getting sick so I'll post what I did so far,
only build-tested so far, but my brain is not working well (fever?)
so I'll let Bibo/you resolve any issues with v3 (respinning if
required) and then either Song or me can queue the result next
week before the freeze.

Regards,

Phil.

>> https://lore.kernel.org/all/20240627125819.62779-2-philmd@linaro.org/
>>
>> After 9.1 is released, there will be enough time for patch v3.
>>
>> Regards
>> Bibo, Mao
> 


