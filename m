Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAB2C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeRz-0002bq-MB; Tue, 29 Jul 2025 03:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeRr-0002XD-Ch
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:08:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeRp-0003gy-A7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:08:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so3075465e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753772907; x=1754377707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQsoWVcLmr+p3kIIOanzx3DpHawq4rcCd+hxNgflkQ8=;
 b=RdLo18AvSjAlKTXgQMLNRL1G8cSUYqBTEDeLXQIt6L3ENzct34bqASBInSwhR1Vur8
 5whiW98q8zTyzb3fYVHcfZ1LAlw5h/Z7+F2CsLCRuatAVyRgoTdmbrB4E5zMgP7vlEUc
 D4i9E7tsAhLZ8H7KhJBPDPDoOgGEKLPhWXlrnB4vLIGklMuIOkqNs2bmqzNCdD/zPhq+
 2b5LdO7YWm96nSog3l3rf90lwpraILyhB5P1N8TIgvQICSdvL80RXhDpt+ds9gcjmHP7
 /5GqbYzIhkxvvzToaZ3XTycdZnWGyhWk2NGl63YiRven7h/6Sv2cnIByr3gJBaKvD0+t
 rVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753772907; x=1754377707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQsoWVcLmr+p3kIIOanzx3DpHawq4rcCd+hxNgflkQ8=;
 b=ed8KRHGxb/EvGdbXIwYBgHgzHKTbO7qPfWjfvUefm1+KUl0GlTTtxQ724jKlkcKxS0
 q+VJW0jeyKnescI+CzcjWgYA9XLhf59rP1p7D1iokRnLckkX7uSVRFNpQei8Jft9115n
 oHfyYuYhu+dNdxBCiynmKDgfNVXryz+9NTznszDVWNtVeDp5trYYZklZYXBQVFdw2Kjk
 Akksoqf2Y2kR75BIzaYKYyzsUF/pZIErCZxTyrV3WEoAfb+4vwzq5MMg6ccZMsbEqhx3
 yRRn4cevluo/mPnmYVfqf+sKpaTNC5UApy7xAKNC4gGfPaB7hHSqv3vl0jD0aNz7KeHc
 ICBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ5EsxpiNq/tPn2dfLPMpKNUWF7irqELgo+1RTxQ95mppemZtz7OIa7zp+7aWPPxFBoej3hhQA7Y23@nongnu.org
X-Gm-Message-State: AOJu0YyGS0ksEthZychhMjHDsVS8xc75Wry6UjVEC7i2F6inkBvs3Wxv
 pJBH49zunh9vHyUQ/+gbAJImbmDSjR4f0KkK/q4MUSV+KWX3P90uP6C1R7kdbZyxMuA=
X-Gm-Gg: ASbGnctDJh2z4Jd0jn7mX59qfS4Ks9PFAmfeZDsFc1c5OtQ3PWWUKdtELZbLgDYQP4d
 +hnc/sHXaTcijDkl4wJtUEcXuF1E2C46Kc4ip4pW02aOxU3xTko9j9wcItorPziqBqyFararE0U
 xctxPzgd5bcFmtLa77BrjYQvsZz4yYzAzYamqBPnf+oteNEFDlDwNGApUddfomDC4XFx1DEoC38
 0BCYG1knvk4S57x2zYQTwHByekN+U+CMxyl5BI8owj8rhAon/5Y6+7vYWd6xGxK5wf1pe2Wbh9f
 UjjxL7OMHbOkPnZvgtC4xtHGz6xM3lNYxz8/0/U1xeKYNAdZUL6uPX6wzPpChvBnGsRna2NfQ6B
 StkjyDZA77rRjms87slUfAzQf2+SJ7wmjo/IrWrtPAM1/peOTyDD12AI1QCw45eLF0A==
X-Google-Smtp-Source: AGHT+IEQDaVzyJv5MFUVVpN+0qp/66R2DhmP6bI0zZbsKor7S3PtXH5HYqnVUifmcT7Dl/Qb7qdS7Q==
X-Received: by 2002:a05:600c:4447:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-4588d13677bmr17895975e9.7.1753772906847; 
 Tue, 29 Jul 2025 00:08:26 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1ad7sm11574535e9.10.2025.07.29.00.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:08:26 -0700 (PDT)
Message-ID: <8f7f5bf7-594c-4ccf-bf1b-086f4c0b5035@linaro.org>
Date: Tue, 29 Jul 2025 09:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250729054023.1668443-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 29/7/25 07:40, Xiaoyao Li wrote:
> Kirill Martynov reported assertation in cpu_asidx_from_attrs() being hit
> when x86_cpu_dump_state() is called to dump the CPU state[*]. It happens
> when the CPU is in SMM and KVM emulation failure due to misbehaving
> guest.
> 
> The root cause is that QEMU i386 never enables the SMM addressspace for cpu

"address space"

> since kvm SMM support has been added.
> 
> Enable the SMM cpu address space under KVM when the SMM is enabled for
> the x86machine.
> 
> [*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1-stdcalllevi@yandex-team.ru/
> 
> Reported-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   system/physmem.c          |  5 -----
>   target/i386/kvm/kvm-cpu.c | 10 ++++++++++
>   target/i386/kvm/kvm.c     |  5 +++++
>   3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 130c148ffb5c..76e1c33aab5c 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -795,9 +795,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>           cpu->as = as;
>       }
>   
> -    /* KVM cannot currently support multiple address spaces. */
> -    assert(asidx == 0 || !kvm_enabled());
> -
>       if (!cpu->cpu_ases) {
>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
>           cpu->cpu_ases_count = cpu->num_ases;
> @@ -820,8 +817,6 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
>   
>       assert(cpu->cpu_ases);
>       assert(asidx >= 0 && asidx < cpu->num_ases);
> -    /* KVM cannot currently support multiple address spaces. */
> -    assert(asidx == 0 || !kvm_enabled());
>   
>       cpuas = &cpu->cpu_ases[asidx];
>       if (tcg_enabled()) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 89a795365945..aa657c2a4627 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -13,6 +13,7 @@
>   #include "qapi/error.h"
>   #include "system/system.h"
>   #include "hw/boards.h"
> +#include "hw/i386/x86.h"
>   
>   #include "kvm_i386.h"
>   #include "accel/accel-cpu-target.h"
> @@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>           kvm_set_guest_phys_bits(cs);
>       }
>   
> +    /*
> +     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
> +     *
> +     * Only init address space 0 here, the second one for SMM is initialized at
> +     * register_smram_listener() after machine init done.
> +     */
> +    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
> +    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);

Typo "memory".

> +
>       return true;
>   }
>   
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8d7..47fb5c673c8e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
>   
>   static void register_smram_listener(Notifier *n, void *unused)
>   {
> +    CPUState *cpu;
>       MemoryRegion *smram =
>           (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>   
> @@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
>       address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
>       kvm_memory_listener_register(kvm_state, &smram_listener,
>                                    &smram_address_space, 1, "kvm-smram");
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
> +    }
>   }
>   
>   static void *kvm_msr_energy_thread(void *data)


