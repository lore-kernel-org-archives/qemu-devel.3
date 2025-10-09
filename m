Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8423BCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uOF-00047s-Ur; Thu, 09 Oct 2025 13:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6uOC-00044I-3A
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:25:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6uO8-0002sU-7f
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:25:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so6275865e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760030707; x=1760635507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4CWR6Dqa5t6AnqwaKPk6brm/OwdP60uMV2JauDuWsU=;
 b=SkVQ2M2eP3BhGHNzKgqpTH5Vh2RcoeeW5WLEzpKox9CEq0JC7XcK3zCti0IpyPZD51
 NtiWpJvZH/Eo0qC/ZtI8kKiQK3nEgvmSdaG5fRBZV/WPgbwRxLLrvQjVkhLjXggS0Cd8
 Z6wZxdoDLB+Xu3gE4cg7qoSPg0IlNB8+ZplpuWUXIEFZ92DRU05OY1jn452LwFYrxw+q
 pQOYBr+PyTj788ZLbF2fxMG9uyc9b3j0r3tAQ281RednQ8qdPJbMDrOxFXCyt5SwGhl9
 kAatp14oYUYNWPnDpc6k3vl9/1U6adoftfCVZ3Yt53AOHldWt8hdD8caeCsVd501+P6m
 XKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760030707; x=1760635507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4CWR6Dqa5t6AnqwaKPk6brm/OwdP60uMV2JauDuWsU=;
 b=Tc+8Ge486gkvVr4jzD2ou4z4zJKQNAqZnlsowubyKLhiIDHTJTNt3fDP21luLnDXDK
 98fMTU/5CybtyJCTlEk0QCXOyvdbIVWXkbWoGOrtqQIkkpgQM+qLCs3zGGptiJ2Mct0I
 9Dl1ZWn4tbL6qmJurKbh44hDQN/zzIrrmwb5YyffTzEANP/sSyPSiBG0iXT3HKE8Kib2
 sFQsEjL5xJNZB9K/KYorqKzMQIUlkeMLrVfQ+XKuQyYXdjclg5Ldv9XCjU6dRG0o66VO
 TmW0WuKmVAxt+0dnr4YUXACWj8GBxSUxp3Ah/QyBYF7xDHuwANCXDGjDE/0XtJEcTqSZ
 VlDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNNJf5Lgfw7aKy5eEj2OgTHJKVPh9zUSNIxAblxbYlN0o3CbV27/fPcjo4ZaO53BKJkY5L+A0CUSd@nongnu.org
X-Gm-Message-State: AOJu0Yx5aH0n7j6+lVu/R3CNGm1oGmMtQpHy4XOFhiSYp+w+qvR3vpF0
 CtCxVodX/GC9RV//lw38g0dwJyFnanpi/EtsQTrIL9dUKU840NNiGdxNP4aWVRvesuY=
X-Gm-Gg: ASbGnctTgamamu8s0kMI+kEa8S4zc4kQXdqbomw3VMTZmZtctizQSebZU894p4+wKu+
 6VlgNkOvwtV8LJ/bkn7THfDnt78mhTx7Okhy0TxJLCq1CIOrQjT6HciItz/ktxaLiRVoxIMtWCo
 2QvEuFgIxv/e+CJ8F0pc4Mug0l9Y2KyyXEHAD0mqPGPdoEpM+NDurv2YKjA8Zmvr51zIlOgjNod
 cGeoQEo5tkWVydC6uJcVVxXpmjCW4NFqASvMSXE6omd04Qp5UGZQs4nGN4F9B073jQDIIZkTPgv
 ArAmdtguCPruwuPUEQIXm77ZcQwmGyBgzq0FSm7Y/MY9CTcQqlWx3Mlvn/1WPCRZYzRIeu/CBYL
 gplrp0QncCPl0hrzdWZPVwh4YZDPSm6yYx2aU4RHbnekvMWIem4juQZbzsSNONDza/JTW/FQT1d
 AyZyrcx3OADgOpPWYNLQOQnfKCmCdQ
X-Google-Smtp-Source: AGHT+IGuOw4/6+3Zr1DlPoizcGznvLfHnlHcsIJ8BgyYYCZX3cjVph8r4sRr0D2pOD4q3EWpOGml6g==
X-Received: by 2002:a05:600d:42f2:b0:46e:4341:7302 with SMTP id
 5b1f17b1804b1-46fb15396d6mr17984015e9.34.1760030707043; 
 Thu, 09 Oct 2025 10:25:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c4027sm4866645e9.17.2025.10.09.10.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:25:06 -0700 (PDT)
Message-ID: <895ac1bb-99cd-457a-817d-8fdf2d2e90ce@linaro.org>
Date: Thu, 9 Oct 2025 19:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/hppa: Introduce
 HppaMachineState::boot_info::firmware structure
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009143106.22724-1-philmd@linaro.org>
 <20251009143106.22724-5-philmd@linaro.org>
 <bba7ba47-cb69-4bcc-9dce-bee9cc4b9bf2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bba7ba47-cb69-4bcc-9dce-bee9cc4b9bf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 9/10/25 19:20, Richard Henderson wrote:
> On 10/9/25 07:31, Philippe Mathieu-Daudé wrote:
>> Current code uses CPUHPPAState::@kernel_entry to hold either:
>>   - kernel entry virtual address
>>   - firmware interactive mode
>> and CPUHPPAState::@cmdline_or_bootorder to hold either:
>>   - kernel &cmdline physical address
>>   - firmware boot order
>>
>> Besides, these variables don't belong to CPUHPPAState, they
>> depend on how the machine is started, and only apply to the
>> first CPU.
>>
>> Introduce firmware specific fields in HppaMachineState, using
>> their correct type. Introduce the @is_kernel field, to allow
>> distinguishing between firmware or kernel mode.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/hppa/machine.c | 36 ++++++++++++++++++++++++++++--------
>>   1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index a2996ef7682..138cd97efd9 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -41,6 +41,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, 
>> HPPA_COMMON_MACHINE)
>>   struct HppaMachineState {
>>       MachineState parent_obj;
>> +
>> +    struct {
>> +        bool is_kernel; /* kernel:1 firmware:0 */
>> +        union {
>> +            struct {
>> +                char bootorder;
>> +                bool interactive_mode;
>> +            } firmware;
>> +        };
>> +    } boot_info;
> 
> I think this is more complicated than necessary.

Certainly...

>> @@ -481,6 +492,7 @@ static void 
>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>                         "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
>>                         ", size %" PRIu64 " kB\n",
>>                         kernel_low, kernel_high, kernel_entry, size / 
>> KiB);
>> +        hms->boot_info.is_kernel = true;
>>           if (kernel_cmdline) {
>>               cpu[0]->env.cmdline_or_bootorder = 0x4000;
>> @@ -519,13 +531,15 @@ static void 
>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>           }
>>       }
>> -    if (!kernel_entry) {
>> +    if (!hms->boot_info.is_kernel) {
>>           /* When booting via firmware, tell firmware if we want 
>> interactive
>> -         * mode (kernel_entry=1), and to boot from CD 
>> (cmdline_or_bootorder='d')
>> -         * or hard disc (cmdline_or_bootorder='c').
>> +         * mode (interactive_mode=1), and to boot from CD 
>> (bootorder='d')
>> +         * or hard disc (bootorder='c').
>>            */
>> -        kernel_entry = machine->boot_config.has_menu ? machine- 
>> >boot_config.menu : 0;
>> -        cpu[0]->env.cmdline_or_bootorder = machine- 
>> >boot_config.order[0];
>> +        hms->boot_info.firmware.interactive_mode = machine- 
>> >boot_config.has_menu
>> +                                                  ? machine- 
>> >boot_config.menu
>> +                                                  : 0;
>> +        hms->boot_info.firmware.bootorder = machine- 
>> >boot_config.order[0];
> ...
>> @@ -668,8 +683,12 @@ static void hppa_machine_reset(MachineState *ms, 
>> ResetType type)
>>       }
>>       cpu[0]->env.gr[26] = ms->ram_size;
>> -    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
>> -    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
>> +    cpu[0]->env.gr[25] = hms->boot_info.is_kernel
>> +                         ? cpu[0]->env.kernel_entry
>> +                         : hms->boot_info.firmware.interactive_mode;
>> +    cpu[0]->env.gr[24] = hms->boot_info.is_kernel
>> +                         ? cpu[0]->env.cmdline_or_bootorder
>> +                         : hms->boot_info.firmware.bootorder;
> 
> 
> I think you'd be better served by placing
> 
>      uint64_t boot_gr24;
>      uint64_t boot_gr25;

Clever :)

> in HppaMachineState and set them in machine_HP_common_init_tail.
> 
>> @@ -679,7 +698,8 @@ static void hppa_machine_reset(MachineState *ms, 
>> ResetType type)
>>       cpu[0]->env.kernel_entry = 0;
>>       cpu[0]->env.initrd_base = 0;
>>       cpu[0]->env.initrd_end = 0;
>> -    cpu[0]->env.cmdline_or_bootorder = mc->default_boot_order[0];
>> +    cpu[0]->env.cmdline_or_bootorder = 0;
>> +    hms->boot_info.firmware.bootorder = mc->default_boot_order[0];
> 
> Setting hms in reset seems wrong.

Yes, a pre-existing issue. I couldn't figure that piece of code (and
comment) myself.


