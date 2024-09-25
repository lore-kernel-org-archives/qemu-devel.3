Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF0CCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU54-0005nB-Oa; Wed, 25 Sep 2024 11:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU53-0005l4-Mi
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1stU52-0004FI-1o
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mwo0nQN6p28vdtVCeKttppdlVcc5ZqRPU3vfHB9F/VM=;
 b=SXc+S2ya0tUY6NoExdH2PG30VxHzHE0HHiyV7gRroX24eACJxriBRVHQNXY2Z9eNZNc+o0
 J8zbjZ9dT3/PeMTDeotwWNcjsJgmDvjUkiRYyOIEB9ICBN+B3LLq1HQoBB4ZFOxnHBfy05
 VuPIv37PKrfz2/BLOmUMoAmu3rITij0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-FQ8sVqQZM2GBvs5YT1OVKg-1; Wed, 25 Sep 2024 11:37:26 -0400
X-MC-Unique: FQ8sVqQZM2GBvs5YT1OVKg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb374f0cdso170015e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278645; x=1727883445;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwo0nQN6p28vdtVCeKttppdlVcc5ZqRPU3vfHB9F/VM=;
 b=c2S6voqiWWFFJbBFwQLh4Z+xqTGt6YnVXRSvsUuztDnGCLA4sw/4QQyZY71GeMiGcS
 zo7PtDYH9QSBlC+Wq0bVIn+gIaA8b12ciEekjqlTgSEI1cn0htBbsl8wk2LrvoSlrytu
 dO3jUmIaTSWHvwekOz4tg9DXr56cpc1KM+wP4yq27e+NtBW/xwOn6a+cipY5aBb44JVH
 8OJpL5tllKpJZMZr4fzZnEpn4TbcBhDE52gfAPA2rB1JicpKEdYceUjvJRVzzHBC4A+c
 Nvb/Lai7KyAwhMwHBxaUOKvIz2Ms6m6Rw+ofe9AkArI9RxNx/MJZljWsL719NZ3NYYnK
 kvKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX++WfHgxTBCBSQJQxMIKOFXUttZA6707PfbhfnVQoiXMruP/q/jlfrbIX7ySIdNoiL0tfJvfVjPsc5@nongnu.org
X-Gm-Message-State: AOJu0Yx//p2Iwl7zZG8+g5a/AlBkgjTGww1fGEBrdw5+V5hnKHG/DS2r
 jxSemWgQZvyLsIjCMDwuXfBAGZCRDsVPSaPFdIjONoH26fU/o13vRg6PYkQRvuLrsp/Iv6QHvEc
 sehBbX6UsPkHy1buBMjNn59n4+wg5rxQ2YdfK6OjuX4M1HMYaqRKs
X-Received: by 2002:a05:600c:3b21:b0:42c:b2a2:af3a with SMTP id
 5b1f17b1804b1-42f521d94damr264185e9.9.1727278644653; 
 Wed, 25 Sep 2024 08:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHwl6thZEGPydbvS4ICk5EFO8ZNZJlN78DL3XxyJzjA9Rj6HcVhWupvBeB1okCMzyNr6FFXA==
X-Received: by 2002:a05:600c:3b21:b0:42c:b2a2:af3a with SMTP id
 5b1f17b1804b1-42f521d94damr264015e9.9.1727278644253; 
 Wed, 25 Sep 2024 08:37:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cc60ecbccsm1564331f8f.38.2024.09.25.08.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:37:23 -0700 (PDT)
Message-ID: <9ee5b660-c3d1-49a4-8123-e15219fe2d60@redhat.com>
Date: Wed, 25 Sep 2024 17:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 02/23] hw/ppc/e500: Reduce scope of env pointer
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-3-shentey@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20240923093016.66437-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/24 11:29, Bernhard Beschow wrote:
> The env pointer isn't used outside the for loop, so move it inside. After that,
> the firstenv pointer is never read, so remove it.

Just wondering, have you considered introducing an PowerPCCPU array
under the machine state ?

This would be an intermediate step towards the introduction of an SoC
model (in the long term)

Thanks,

C.



> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ppc/e500.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 75b051009f..f68779a1ea 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
>       const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
>       MachineClass *mc = MACHINE_CLASS(pmc);
>       PCIBus *pci_bus;
> -    CPUPPCState *env = NULL;
>       uint64_t loadaddr;
>       hwaddr kernel_base = -1LL;
>       int kernel_size = 0;
> @@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
>       IrqLines *irqs;
>       DeviceState *dev, *mpicdev;
>       DriveInfo *dinfo;
> -    CPUPPCState *firstenv = NULL;
>       MemoryRegion *ccsr_addr_space;
>       SysBusDevice *s;
>       PPCE500CCSRState *ccsr;
> @@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
>       irqs = g_new0(IrqLines, smp_cpus);
>       for (i = 0; i < smp_cpus; i++) {
>           PowerPCCPU *cpu;
> +        CPUPPCState *env;
>           CPUState *cs;
>   
>           cpu = POWERPC_CPU(object_new(machine->cpu_type));
> @@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
>                                    &error_abort);
>           qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>   
> -        if (!firstenv) {
> -            firstenv = env;
> -        }
> -
>           irqs[i].irq[OPENPIC_OUTPUT_INT] =
>               qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
>           irqs[i].irq[OPENPIC_OUTPUT_CINT] =
> @@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
>           }
>       }
>   
> -    env = firstenv;
> -
>       if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
>           error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_ALIGN);
>           exit(EXIT_FAILURE);


