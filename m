Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9625CE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3wZ-0001GK-6t; Tue, 07 Jan 2025 02:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3wX-0001EW-VR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:24:02 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3wW-0007eP-2G
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:24:01 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3863703258fso9407903f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234638; x=1736839438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qEkupldCw8c8chh2uJdgGm73Ctq69CVYmSH4734A6hg=;
 b=fHBJ08D37+w53hvxh5I3PdeHWZ863JFIgjwooj4J2cQboq6obDx7x0CRqxYo2f873L
 IjJcGTqEEyElmUZZrPXDNC9D9t/g90bDoi1Ic9A0xx3UkSDI7wMgnG6ADmicqiK9In6Y
 btxwkMHs1ZigBFrLmh3ZxSQ03wtp8HGok030wtnD9QkueQkwZ2r0BtclO9p9b+3wuM95
 DEIluPgYt2MRBpH39w/THu/sTntn6iJjBtleT8iFwfcmuK/eWdvtSjlu44ypM+6rmot6
 g4AmqdfYF5sV0gxQYisj+wcz3SKSVOeQHNTt0iwy/qwOsJeIJeDeISVrJHA8ZiTOK19V
 whbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234638; x=1736839438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qEkupldCw8c8chh2uJdgGm73Ctq69CVYmSH4734A6hg=;
 b=tC59LQifwfhHD7/tx8tac0IjMRnWo1CBSAKH8H5aso0t89sHlaXtuvv8M1SBC/Srsh
 +qpjgRTz4DqJZDKIfq+1Y0uBa5YWGLY2upzKOUoNlOrOQ8gmflZk9YlWqn4slj9XEJ3L
 xRMqQFJupMP1gmFlT/PshvoaRZAlEHMr3beJ6hIDpUAXHtK7wP+JjxQw5fXoEUyVhbJC
 vKufEaADAjBP/Ley401h3qORcyV/lS2ZK5+PqkMcz2XAw4G3TwRRZJCRCjD+eJ0/L6kW
 lcVL38r3hMXswm1PuJZvwKqWgcfs7ZCCM3DZQSACy8XPzDfJDnAntfAhQcp7dP07VQrI
 4S6A==
X-Gm-Message-State: AOJu0YxMnsmzhnW6Fzw0fJhDJrGh3dySrcZCIPB24MzR44Lw/Q6ail8i
 1XgQfvTbGgSAHdFXy85sueeijnadceWc07S3n541B2G28lELp/HzpBy/WiWzkSs=
X-Gm-Gg: ASbGncsRGqGqLUP4N3lcvAtp8V1G/IdbbkuCJibw+4GyajJ6y8l7/Y4Azhs8Vlucibi
 0yi1FlCMGl2sYHQnWA+DzI0rsh1b7nQ6juhYnsKQzZtKyYj5L5CJ99OlFRN2DxwOQcp4AgReWG6
 JmFCDZV10sci8jMAK+E22sVvheXY1GoRixrnBZmkALLwais3vxlmbonFbwJY8MDW/bwzocxEycH
 M1gJW8HR8YuNPSyIJbJrAsCLf1/kmXsNk5lPVNhTNUxOeX4qBPko27R9sU4lepNSOw5Vp9m6TOq
 yKzfCmDLmUDmz8ejZGv/bg5J
X-Google-Smtp-Source: AGHT+IHq0HeaEaD8AnocIepL4dfnVsx8aTsFsXLBrvsQuUsak+JUY9U+JtxvqlS8iv5PJh4nBFfF1A==
X-Received: by 2002:a5d:47c3:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38a79142277mr1410058f8f.18.1736234638137; 
 Mon, 06 Jan 2025 23:23:58 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6dd3sm49667943f8f.96.2025.01.06.23.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:23:56 -0800 (PST)
Message-ID: <5d1b8ee6-2959-42cb-9bf8-597ef63d5bed@linaro.org>
Date: Tue, 7 Jan 2025 08:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup
 value of MSR_CORE_THREAD_COUNT
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-2-xiaoyao.li@intel.com>
 <018cfbde-96be-4d95-bb29-95cdf708187e@linaro.org>
 <902568a2-8160-4265-9e2c-c4465eaa62d4@linaro.org>
 <bf435f2e-5cfb-411d-937a-6c686a0530dd@intel.com>
 <711792d0-858e-49ec-a3b5-b33d9312d542@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <711792d0-858e-49ec-a3b5-b33d9312d542@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/1/25 05:34, Xiaoyao Li wrote:
> On 1/7/2025 12:31 PM, Xiaoyao Li wrote:
>> On 1/3/2025 4:52 PM, Philippe Mathieu-Daudé wrote:
>>> On 28/12/24 18:37, Philippe Mathieu-Daudé wrote:
>>>> On 19/12/24 12:01, Xiaoyao Li wrote:
>>>>> There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
>>>>> Extract a common function for it.
>>>>>
>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - move the implementation of cpu_x86_get_msr_core_thread_count() to
>>>>>    target/i386/cpu-sysemu.c;
>>>>> ---
>>>>>   target/i386/cpu-sysemu.c             | 11 +++++++++++
>>>>>   target/i386/cpu.h                    |  2 ++
>>>>>   target/i386/hvf/x86_emu.c            |  3 +--
>>>>>   target/i386/kvm/kvm.c                |  5 +----
>>>>>   target/i386/tcg/sysemu/misc_helper.c |  3 +--
>>>>>   5 files changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>>
>>>>> +uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
>>>>> +{
>>>>> +    CPUState *cs = CPU(cpu);
>>>>> +    uint64_t val;
>>>>> +
>>>>> +    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 
>>>>> 15..0 */
>>>>> +    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 
>>>>> 31..16 */
>>>>> +
>>>>> +    return val;
>>>>
>>>> Alternatively:
>>>>
>>>>         return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
>>>>                          cs->nr_cores);
>>
>> I would rather keep it as-is as suguested by Philippe[1].
> 
> Sorry for being wrong with the name. (awkward)
> 
> s/Philippe/Igor
> 
>> (deposit64() is really a new thing for i386)
>>
>> [1] https://lore.kernel.org/qemu- 
>> devel/20241210173524.48e203a3@imammedo.users.ipa.redhat.com/

Then use deposit64() in another patch on top?

>>>>> +}
>>>>
>>>
>>> Typo "function" in patch subject.
>>
>> thanks for catching it!
>>
>>
> 


