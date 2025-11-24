Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FA4CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 11:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNUQB-0007Ff-CN; Mon, 24 Nov 2025 06:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNUPd-000762-Se
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:07:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNUPY-0003z2-5K
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:07:13 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so2141174f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763982430; x=1764587230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/upjQ9H0SVSCgM+bbXBuwZe839PMqXM0bsd8OKlLlL0=;
 b=nft7OhBy4UA60lfty0ZxVjZcTUYi5gqlEdmWnDEhfQvPpgtfV/be+xF+t3RLGQ4kAI
 sBBeZ8p4vhLMKNbSN6HkxIXl5A/TxbWHCj/f1weEOtR1y6Y/UbyBuqFGeYs8dzdSXB+f
 BR9bVh2XilXTn5iEI8VzOmTLGk71OS8D49YVws6dr6gEtDoqWYw0eWhRciZeZt1mZnpo
 alaAUWnjJZcqu0Xr1Oj+uiWMHUVx5iOa0oHwHf8H/aIlIXVM9UDJdCAGGDGdsbURLmvj
 MVoX85CpstKr6zJp8hq3ZnGBp3faYQOnEV2Jwhlm/G5cSQxYhPlXOHb3amumWKkAq21V
 m1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763982430; x=1764587230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/upjQ9H0SVSCgM+bbXBuwZe839PMqXM0bsd8OKlLlL0=;
 b=aPvRuBDkUFDEpwBPxuQhH3vATYdXRGbFRpGfe7IoP8dHzELJrv7JxgQ+Vdi4KapWeo
 e7+oOXURYhkQlGG35VeBFP0LijhiR9wKCvbdq66kxuh332ib9/XPw7YHYJGLCId0uBeV
 jueKVvNrsuAQ/7FgNdftMtC3dV8BijbuwaHoL6d16ZAEfA7jOedoQ0iesLd/tA6EnPK/
 KXLX853qLD4vqc3/FlQs2EoJC3pPVJJfMlRbyatGoO9Cwko5rD29O/jmf4lspNV1/Pv8
 saRDOfMuHwbwiSDzSqUYwCm6VIaKV+zTO9uYKixj9CrP5pYGoFy21b2njd9xhKfaVZL8
 1DBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1Xct6fctCu5kdYSul18cdLamiGbds17OfB7ll89U4XZnT4aMGlPzW9levTCi28kpwdW0f4Yj6f7h@nongnu.org
X-Gm-Message-State: AOJu0YwXZakfqDfNMJ3G1X+DtBGQmSsq0q2EWpjy70UMY+y0mcVftO0I
 1U6XrmLo5sLjxG4wxLLOsMT5FBqQmXkaUQO1i62WMtw3REN2dH9fyT2cjZ44XSr8XUukgd4vmp1
 is5VuasrCugXs
X-Gm-Gg: ASbGncvruoW/cK9eR1Hwa7bgP75LIhZhbVKeXUksgcF0RD0jVb5FEncjK/D9J+XA0Um
 oIEIcLUilHjmJsRM27iv7rAhgF6zIm/yRMRt5Qf5n4r2Xgi9BFIbF14tNaiBlcvEBjwCzSj85rR
 VPi/u0x0kDJOjFr5xvbEbWkXKlD8cC54v8RtzLjvQ8HYJWw2HhcACql/7UWO6+cWP85IIFQE4tG
 2A1r+AiKnVKzMR+2vvbKQ3/rOtLQeGwWAlvrbFRc752TRR0sWTM+U3hUlCoiTqiPOjFoQIt8PbB
 lsetc8aAeJo6Hew6a1ZKUWOUkvCTRqVTghZFTo/QXj7vc4ymAmf6XSdWpylNXBr0Asktk6ErVfb
 hm9TzkwOSm/6KSabWHrtO+ugKqKGHnEvGKcYuUFtbQGyRUAf2BFFk7AgDzMY9zcO9v++e+WZAt+
 wUl7RyonOb/cB3D+JpUvpNutUQ2b5Z8Z8020EXlP18rvxAc4dDhBKdyw==
X-Google-Smtp-Source: AGHT+IGEnMVZZwNHPNq9S194krqfxY5EzZns/dSIyOWDta8DjbBG9k2g9N/EkMMC3EMX0Vm562Ebwg==
X-Received: by 2002:a05:6000:4305:b0:42b:3592:1b88 with SMTP id
 ffacd0b85a97d-42cc1d20dddmr11249650f8f.50.1763982430293; 
 Mon, 24 Nov 2025 03:07:10 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm27384662f8f.5.2025.11.24.03.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 03:07:09 -0800 (PST)
Message-ID: <39f5f781-398b-4974-8b1e-e7061ed9194f@linaro.org>
Date: Mon, 24 Nov 2025 12:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc: Remove dead Xen code
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20251123185832.53802-1-philmd@linaro.org>
 <066cb998-e89a-4cd1-a89b-865f4a6dcbbd@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <066cb998-e89a-4cd1-a89b-865f4a6dcbbd@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 24/11/25 11:27, Mark Cave-Ayland wrote:
> On 23/11/2025 18:58, Philippe Mathieu-Daudé wrote:
> 
>> We don't use Xen on the isapc machine: let's remove
>> pointless code.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/isapc.c | 27 ++++-----------------------
>>   1 file changed, 4 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>> index 1ba9ae22cc3..1e13a30c505 100644
>> --- a/hw/i386/isapc.c
>> +++ b/hw/i386/isapc.c
>> @@ -17,8 +17,6 @@
>>   #include "hw/ide/ide-bus.h"
>>   #include "system/kvm.h"
>>   #include "hw/i386/kvm/clock.h"
>> -#include "hw/xen/xen-x86.h"
>> -#include "system/xen.h"
>>   #include "hw/rtc/mc146818rtc.h"
>>   #include "target/i386/cpu.h"
>> @@ -37,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>>       ISABus *isa_bus;
>>       uint32_t irq;
>>       GSIState *gsi_state;
>> -    MemoryRegion *ram_memory;
>>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>       int i;
>> @@ -77,15 +74,9 @@ static void pc_init_isa(MachineState *machine)
>>       /*
>>        * There is no RAM split for the isapc machine
>>        */
>> -    if (xen_enabled()) {
>> -        xen_hvm_init_pc(pcms, &ram_memory);
>> -    } else {
>> -        ram_memory = machine->ram;
>> -
>> -        pcms->max_ram_below_4g = 3.5 * GiB;
>> -        x86ms->above_4g_mem_size = 0;
>> -        x86ms->below_4g_mem_size = machine->ram_size;
>> -    }
>> +    pcms->max_ram_below_4g = 3.5 * GiB;
>> +    x86ms->above_4g_mem_size = 0;
>> +    x86ms->below_4g_mem_size = machine->ram_size;
>>       x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> @@ -94,17 +85,7 @@ static void pc_init_isa(MachineState *machine)
>>       }
>>       /* allocate ram and load rom/bios */
>> -    if (!xen_enabled()) {
>> -        pc_memory_init(pcms, system_memory, system_memory, 0);
>> -    } else {
>> -        assert(machine->ram_size == x86ms->below_4g_mem_size +
>> -                                    x86ms->above_4g_mem_size);
>> -
>> -        if (machine->kernel_filename != NULL) {
>> -            /* For xen HVM direct kernel boot, load linux here */
>> -            xen_load_linux(pcms);
>> -        }
>> -    }
>> +    pc_memory_init(pcms, system_memory, system_memory, 0);
>>       gsi_state = pc_gsi_create(&x86ms->gsi, false);
> 
> FWIW I did contact upstream about this (see https://patchew.org/ 
> QEMU/20250618112828.235087-1- 
> mark.caveayland@nutanix.com/20250618112828.235087-13- 
> mark.caveayland@nutanix.com/#91b96b24-af60-4a89-91ec- 
> d0e660a76a0a@nutanix.com) and they mentioned that it should work, which 
> is why I left it in.
> 
> Unfortunately I don't currently have any way to test it here :/

OK :| IMHO upstream Xen maintainers should provide us a test, otherwise
we can not make our code base evolve.

