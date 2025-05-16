Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CEDC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 11:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFtOD-0007Kt-CQ; Fri, 16 May 2025 07:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtOA-0007K6-OV
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:38:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtO8-00015P-8e
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:38:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso11829405e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747395481; x=1748000281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZiL7C8ZZIe5yuMZECibEb9dEBxmu+cL20UcsLUd9p8=;
 b=xd6bnWnxbn7i8N0WbrT0fG29BpjHFLyJrEHYHPY/S+vSMcwI+ucn3usb6XcNt4DWBZ
 HlOf2Z5ShlgKZ95q1i9weHK1u5lJ3hP/dRZMh8ccMOdlciRBwXkwHTEU7Nf1r0FprtMO
 z/d0z3AgwK0lrwIT+jZngK+R/blWFzeD9kG2/lnfMEtWoYzfaubaklA83lGQSyyZ8L/k
 2QxyjVN+RnFsXHVaNB9isMgKyCCpuBT4SY8Sbwli8glz/UzmFlWu7H/1WGvf0nS0hpYX
 PEbATF/WyCFZbUIOAliLbO5dXJ0S0pT+8d7W41BzRKDqz+kjBaBeN3626wLK2c3S/El4
 pcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747395481; x=1748000281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZiL7C8ZZIe5yuMZECibEb9dEBxmu+cL20UcsLUd9p8=;
 b=uI+kHw0hk/aEAifxYoerbnrtYVv8uyV3NmY/aPIKJR2/MtHUhX1DCPJpjojLdgiVY1
 vO0xnVWbm0wLF32GVO/m5bW2d2yvKwSdXXMXHtNJoeT6fAAK9g9jS1Ij9OK0pO7QoAjl
 5ovT676If6PW69bc/vqaMHywIYKY/TbBntmKtbJ+oLMhCyiTlc9PZt0t8Z0J3UsIU5Pi
 OJvBmDt9axueiui07h0rLCvH43tmn6tdkc22KNbWS3CvsGxGswNXyHLveHRpm2fCWrvM
 GwqXD3WAewF7b/YjUssFba1W/Flmfmwa4R0VvDaNIFKJgeHAI83E/SUJvYDR7ozMNNN+
 8GFg==
X-Gm-Message-State: AOJu0YyFMV2F/w5zw+qXu/WfA2gimhTPBos74US8ZHLuuYXYcGOF1bg9
 LocIoq0VVU8qq34VcbwVUfFNyOEq/vQOZW5QyYw95AFC1p831y6m4fV6i7y3DImugg4=
X-Gm-Gg: ASbGncun8FhnNhum5aK9/JLl9Bt49bM1UzC+0+K99DTAVhh88XSB00rl/jj8V75wb8o
 YGyDXa1nFuAc283fq5x4BAfj52m4hKSqkjxLXehxFK6tNTcsNBAT1JE6jhSK9hVfqRt93lNQ3Em
 7KUUaO/27eKSgAnf3qdT7m0x9MsjMoiJPFQUfP33I+bDK7XRPpMVRfnZSKSCsI7EPxLEpIrL69N
 lAo2sJWUd7uyyxURqzOh+KpG9wTEcOFGpTtrBQ7o2jtlHKKsPfEaZu1fuDV8KgNT293U1mzHVNP
 zam0xMk/lSVUiuGwFMCDrjfFbh9oTXOAMxIWB9orB1ObkO1581accI617VxFuSWFFjlRFA9OFHZ
 6BYZirDm1hN8I
X-Google-Smtp-Source: AGHT+IEt++IYfAwAgy/p0mGCIpiGVu6ZbdEkhIRUNlQI7QE7w9hTaADhSZmeDAsJShw4CODCsY8X3g==
X-Received: by 2002:a05:600c:1c86:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-442feff8596mr23249605e9.15.1747395481000; 
 Fri, 16 May 2025 04:38:01 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f33690f0sm102074085e9.1.2025.05.16.04.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 04:38:00 -0700 (PDT)
Message-ID: <ecde12de-3e81-4d81-839c-7e97b6a2f668@linaro.org>
Date: Fri, 16 May 2025 12:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-3-chigot@adacore.com>
 <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
 <CAJ307EjyFBDLMe6EaeNUTWSwNTkSxSYJq5VxAD5u0BwZVu4Fqw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ307EjyFBDLMe6EaeNUTWSwNTkSxSYJq5VxAD5u0BwZVu4Fqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Clément,

On 14/5/25 14:41, Clément Chigot wrote:
> On Tue, May 13, 2025 at 5:39 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 13/5/25 16:14, Clément Chigot wrote:
>>> From: Frederic Konrad <konrad.frederic@yahoo.fr>
>>>
>>> This introduces a first-cpu-index property to the arm-gic, as some SOCs
>>> could have two separate GIC (ie: the zynqmp).
>>>
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>> ---
>>>    hw/intc/arm_gic.c                | 2 +-
>>>    hw/intc/arm_gic_common.c         | 1 +
>>>    include/hw/intc/arm_gic_common.h | 2 ++
>>>    3 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>>> index d18bef40fc..899f133363 100644
>>> --- a/hw/intc/arm_gic.c
>>> +++ b/hw/intc/arm_gic.c
>>> @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] = {
>>>    static inline int gic_get_current_cpu(GICState *s)
>>>    {
>>>        if (!qtest_enabled() && s->num_cpu > 1) {
>>> -        return current_cpu->cpu_index;
>>> +        return current_cpu->cpu_index - s->first_cpu_index;
>>
>> Note, CPUState::cpu_index is meant for accelerators code and shouldn't
>> be used in hw/ (in particular because it vary when using hotplug).
> 
> Is there another way to perform that then ? As you can see `cpu_index`
> is already present prior to my patch. I don't mind improving it as a
> prerequisite for that series though.

Yeah it is a pre-existing design issue, I was just thinking loudly,
no need to worry for your use: if we ever clean it, we'll also
clean here.

> 
>>>        }
>>>        return 0;
>>>    }
>>> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
>>> index 0f0c48d89a..ed5be05645 100644
>>> --- a/hw/intc/arm_gic_common.c
>>> +++ b/hw/intc/arm_gic_common.c
>>> @@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
>>>
>>>    static const Property arm_gic_common_properties[] = {
>>>        DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
>>> +    DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
>>>        DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
>>>        /* Revision can be 1 or 2 for GIC architecture specification
>>>         * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
>>> diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
>>> index 97fea4102d..93a3cc2bf8 100644
>>> --- a/include/hw/intc/arm_gic_common.h
>>> +++ b/include/hw/intc/arm_gic_common.h
>>> @@ -129,6 +129,8 @@ struct GICState {
>>>        uint32_t num_lrs;
>>>
>>>        uint32_t num_cpu;
>>> +    /* cpu_index of the first CPU, attached to this GIC.  */
>>> +    uint32_t first_cpu_index;
>>>
>>>        MemoryRegion iomem; /* Distributor */
>>>        /* This is just so we can have an opaque pointer which identifies
>>
>> Alternative series motivated to remove &first_cpu / qemu_get_cpu():
>> https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/

(Just an observation, not an objection to this simple work-around).

Regards,

Phil.

