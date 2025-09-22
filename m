Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F816CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 06:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0aPa-0004Qm-7a; Mon, 22 Sep 2025 02:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0aPW-0004Q6-OM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:52:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0aPU-0007Bg-QT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:52:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45f2b062b86so25473805e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758523946; x=1759128746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O15pUFN44EBBvvic0bwYnBgdRrmu/dIHgOV9XSqXOFA=;
 b=xgk5w1B0f2ZIKfVQ0JCVuNKr4N41KfN/kmO8e//h0hgFoRNh3kSVM/G9ros2K/DJ2/
 GDHNDmUavEew8Eu7mNy4jqZe/EZZMeAYL/yjiYx/n+JIypIir8UyiKvKcaNXyKB0huZ0
 +E9nD64JCkt6r4ulZPN+fT78OStW/dUTWrv8tkTTXNGfpjZiq025JerjtM5E+JCQ9bHA
 1zsURvYHmQkPiX5y4CO6h4liQCce4BTHlAxJ/RmVqMtu/qSZ8IOaIB2z2bLlLX+qXfH9
 Q1TXlJwpGnGxTQ++t8ICsM6w1lWHjV3n4E9wsFQohGeipz7fIJ3c2cnv0/4MjUpxKCRR
 CUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758523946; x=1759128746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O15pUFN44EBBvvic0bwYnBgdRrmu/dIHgOV9XSqXOFA=;
 b=JIb3WKUbiOfDfBvTvMz9kGgn7wFn8QvcDC0Ht8gXP1zIRuk2RSZABrCfm5ZMmvObRw
 RzZHsbTfv3o//37RnS5SkmA4vBu/9Ozd6UZ+T61FgEhvF3lk9sxtkSoEL+5IrewCuNaP
 zpStu9DwveBS3w/f4Jx9NplF1Gb7HRzYsd7Lwxrc1yYtWlzTqWV/Rijvp7LLJXyNFJNs
 kUAu0/VaZdtTNkzp8yDe0t9PQd9vxbusq27IiCLXeV3Tb4yaESpIKNQDatrYb1uDXL6p
 yXGqSSvSHJJj9vDbZp8iUviCrA5Ib3v1/MxgCvl34IIs7Ia7kwxXjPZ9Cr7tl1wXmRGC
 2e7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5jUAGF0SbH1n2Sa4h0ktA8ylF17e7rOK7tG4/7uv4WPdidFVtuSLmMx1xdQGohb5+BBvc/eOzAJTN@nongnu.org
X-Gm-Message-State: AOJu0YwPRND5PMlAnd5JcVq5FyS6u92/YJxe1kOjLfh9wcYLF70/va/G
 79DcfQv3tdawEYb4+wUHFSOfK5yuFB96mQkpg1JJW13LlI9lvMOzZiKVw65xLh0kOBI=
X-Gm-Gg: ASbGncv0/hI6yYvz9XgzwRM1gjn4R4WFdFnrAkEFUWFMo8l8nvnnRnuYBGxswWp9gwG
 99fCzn4pSlYEFYxzUE9y8mEie/TBjMmGsGWU2xm2A6H4V3ENwvzqYmpjPfFT7h7dq5gsxKl9Enh
 Hx7JvjXkQYlgUfUl3TKrJzu2l4Fa3iToZn0PYEn44/wUH+bf8QlbqzWafpbyDX+4kNeoJmDZ41I
 +KeYgZmZY/4KytFPbemh6itXi0pXjfRy5KpkbHLvxcP+dR8KzlsdelC3h3XRjHn07CZ6PH1Xu68
 nVJ0JqIn4CyR9B90hsk6v5q/oMx9IXGiKh5RuBamApg37BuC2VPLpAFn0zXMbSUavdKVeLhLPsG
 J9ddUL4zIVvy8VJI1y9LwA5z/mTnewVWd4ZFvql8489wZL7eD6Gt6bLhz+UjNKr0xvjpGSaEG5h
 or
X-Google-Smtp-Source: AGHT+IG4p+DLWO2umkHbnADn+/WbRqxRnEL5SA+Jp8wxQ1O77q7vLv/Lq4R7DZ8xFLqL8sLgzJ2k6g==
X-Received: by 2002:a05:600c:4656:b0:45d:2ac9:4240 with SMTP id
 5b1f17b1804b1-467f2242a93mr91909665e9.17.1758523946355; 
 Sun, 21 Sep 2025 23:52:26 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f61703b206sm8375993f8f.6.2025.09.21.23.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Sep 2025 23:52:25 -0700 (PDT)
Message-ID: <0a27b044-e7c2-4621-a2ad-e028d5ef31ec@linaro.org>
Date: Mon, 22 Sep 2025 08:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
 <5f0fb254-fa9c-4e29-a848-6e9b3bc8274d@linaro.org>
 <046d60ed-aa62-4357-a812-721de3412573@htecgroup.com>
 <ca5816d3-a0e7-4460-aead-8f0dbcb4bc92@linaro.org>
 <4d1e75d9-13b1-4fb8-b1f9-4917dbfb2415@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d1e75d9-13b1-4fb8-b1f9-4917dbfb2415@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 3/9/25 14:35, Djordje Todorovic wrote:
> 
> On 1. 9. 25. 13:05, Philippe Mathieu-Daudé wrote:
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you recognize the sender
>> and know the content is safe.
>>
>>
>> On 1/9/25 10:17, Djordje Todorovic wrote:
>>> On 8. 8. 25. 17:52, Philippe Mathieu-Daudé wrote:
>>>
>>>> CAUTION: This email originated from outside of the organization. Do
>>>> not click links or open attachments unless you recognize the sender
>>>> and know the content is safe.
>>>>
>>>>
>>>> On 17/7/25 11:38, Djordje Todorovic wrote:
>>>>> This is needed for riscv based CPUs by MIPS since those may have
>>>>> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
>>>>> range, and if a hart is missing, this causes NULL derefs.
>>>>>
>>>>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>>>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>>>> ---
>>>>>     hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
>>>>>     hw/intc/riscv_aplic.c  | 11 ++++++++---
>>>>>     2 files changed, 27 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
>>>>> index b0139f03f5..22ac4133d5 100644
>>>>> --- a/hw/intc/riscv_aclint.c
>>>>> +++ b/hw/intc/riscv_aclint.c
>>>>> @@ -292,7 +292,13 @@ static void
>>>>> riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>>>>>         s->timecmp = g_new0(uint64_t, s->num_harts);
>>>>>         /* Claim timer interrupt bits */
>>>>>         for (i = 0; i < s->num_harts; i++) {
>>>>> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base +
>>>>> i));
>>>>> +        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
>>>>> +        if (cpu_by_hartid == NULL) {
>>>>> +            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid
>>>>> hartid: %u",
>>>>> +                          s->hartid_base + i);
>>>>
>>>> DeviceRealize() handlers are part of machine modelling, not guest uses.
>>>>
>>>> IOW, triggering this is a programming mistake, so we should just
>>>> abort() here.
>>>
>>> Well, if we do it that way, our Boston board target for P8700 cannot
>>> run.
>>
>> So the problem is elsewhere :)
> 
> 
> I see. Would something like this be acceptable:
> 
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -279,7 +279,7 @@ static const Property
> riscv_aclint_mtimer_properties[] = {
>    static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>    {
>        RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
> -    int i;
> +    CPUState *cpu;
> 
>        memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_aclint_mtimer_ops,
>                              s, TYPE_RISCV_ACLINT_MTIMER, s->aperture_size);
> @@ -291,18 +291,15 @@ static void
> riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>        s->timers = g_new0(QEMUTimer *, s->num_harts);
>        s->timecmp = g_new0(uint64_t, s->num_harts);
>        /* Claim timer interrupt bits */
> -    for (i = 0; i < s->num_harts; i++) {
> -        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
> -        if (cpu_by_hartid == NULL) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid
> hartid: %u",
> -                          s->hartid_base + i);
> -            continue;
> -        }
> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
> -        if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
> -            error_report("MTIP already claimed");
> -            exit(1);
> -        }
> +    CPU_FOREACH(cpu) {
> +      if (cpu == NULL)
> +        abort();

Why do you end having a NULL vcpu in the global cpus_queue?
(this is the 'elsewhere problem').

> +
> +      RISCVCPU *cpu_riscv = RISCV_CPU(cpu);
> +      if (riscv_cpu_claim_interrupts(cpu_riscv, MIP_MTIP) < 0) {
> +        error_report("MTIP already claimed");
> +        exit(1);
> +      }
>        }
>    }
> 
> 
> Thanks,
> 
> Djordje
> 
> 



