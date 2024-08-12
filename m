Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32FBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 05:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdNJj-0004Em-Qx; Mon, 12 Aug 2024 01:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdNJh-0004DH-5l
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sdNJc-0003bo-9q
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 01:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723439394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1ivEWNhs1z53BitTen3mlLbhlu/8FPyYX1oRe5evH4=;
 b=c/AEvYQAvaUu65JKZFjkM+vgass2x4DRZMznXAklI9PYQAEXadwTCF1eHTe1NHvN0EPoqy
 yWYkDXWweNglkwA148vcidrYIvm7FoOTR51bohw68cVnuqSEEV7KSMDe3+cXWqqLaSkhR8
 eaoEs52rDaiR+hKCzTK7dYxlgez5PHI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-yDBeCch_OF2ddbmkOBKyvQ-1; Mon, 12 Aug 2024 01:09:52 -0400
X-MC-Unique: yDBeCch_OF2ddbmkOBKyvQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cfe9270d4aso5468073a91.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 22:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723439392; x=1724044192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H1ivEWNhs1z53BitTen3mlLbhlu/8FPyYX1oRe5evH4=;
 b=MaNq2JxWa+gNze/sxDYvC6Pt/3zX3zWZF/NB3q92RubwEoqJz85GM9RKQihUIwsJ6E
 r5OyHnDvC508m3OANGYtnurelpmdv4YmIth27y7fGh9ge5pbn/DdDCBLX0gax5dN6Ra6
 xbfug/hutuKqbaOM09ShdZeeDA3v0Wq9ZW2fJ3FRsFqGwPmtGfwjTLilcPQg/jdkAN8x
 R1yVjLn6wsZWjP9nDg+40KGo4XC0eHjEn5PGZkxXuq5n73STrNJiaUlXBDqLsmeqSZ6Y
 QcZvvLcNVqv6N4Efl/k0YQZuxa1UkouyDhPVDf5QgTE7IfAsoZs3AvPab434eidTXIIw
 pkQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsiS90imOXnInx09HUxMf4Pk8625XRwoCAJeUp55CEyrNeY92rXmm83JDX0jMG8HNakzY6kSUiKOzAnXIkMASA1ySSh+c=
X-Gm-Message-State: AOJu0YzlLlJpT4qtdvaO7HHtWdZYs2bgxRhJ0iby1jyd2Ku7l+ZBkrHk
 4QYIpFrtcHAfX2d9r8qB/F/4CXiONdBn6a2JskrABSQh3oHzzJNJ75U5Jdi0k7GHLYG6qD0ZKjf
 2xZ8pPDkzSbUly7nOhyP2k3xBM0ed6yj4vrnBP728HXwjnEUMpdkN
X-Received: by 2002:a17:90b:e83:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2d1e80671d1mr9642360a91.37.1723439391651; 
 Sun, 11 Aug 2024 22:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE69iKXP9Po7eJIGbLC5giSBARZso6DiWFL1yv3ylbXoqpjGGWiOJtaAQdsKmKGklMkd8i7Cg==
X-Received: by 2002:a17:90b:e83:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2d1e80671d1mr9642316a91.37.1723439391266; 
 Sun, 11 Aug 2024 22:09:51 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fd0217dcsm3942433a91.54.2024.08.11.22.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 22:09:50 -0700 (PDT)
Message-ID: <a7fa47aa-c960-4897-bcb4-41ec74b72804@redhat.com>
Date: Mon, 12 Aug 2024 15:09:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 03/29] hw/arm/virt: Limit number of possible vCPUs
 for unsupported Accel or GIC Type
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-4-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240613233639.202896-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/14/24 9:36 AM, Salil Mehta wrote:
> If Virtual CPU Hotplug support does not exist on a particular Accel platform or
> ARM GIC version, we should limit the possible vCPUs to those available during
> boot time (i.e SMP CPUs) and explicitly disable Virtual CPU Hotplug support.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 66 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 38 insertions(+), 28 deletions(-)
> 

Most of the code changes are moving the check between @max_cpus and @max_supported_cpus.
It would make the review easier if the code movement can be put into a preparatory patch
if you agree.

Thanks,
Gavin

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 11fc7fc318..3e1c4d2d2f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2082,8 +2082,6 @@ static void machvirt_init(MachineState *machine)
>       unsigned int smp_cpus = machine->smp.cpus;
>       unsigned int max_cpus = machine->smp.max_cpus;
>   
> -    possible_cpus = mc->possible_cpu_arch_ids(machine);
> -
>       /*
>        * In accelerated mode, the memory map is computed earlier in kvm_type()
>        * to create a VM with the right number of IPA bits.
> @@ -2098,7 +2096,7 @@ static void machvirt_init(MachineState *machine)
>            * we are about to deal with. Once this is done, get rid of
>            * the object.
>            */
> -        cpuobj = object_new(possible_cpus->cpus[0].type);
> +        cpuobj = object_new(machine->cpu_type);
>           armcpu = ARM_CPU(cpuobj);
>   
>           pa_bits = arm_pamax(armcpu);
> @@ -2113,6 +2111,43 @@ static void machvirt_init(MachineState *machine)
>        */
>       finalize_gic_version(vms);
>   
> +    /*
> +     * The maximum number of CPUs depends on the GIC version, or on how
> +     * many redistributors we can fit into the memory map (which in turn
> +     * depends on whether this is a GICv3 or v4).
> +     */
> +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +        virt_max_cpus = GIC_NCPU;
> +    } else {
> +        virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
> +        if (vms->highmem_redists) {
> +            virt_max_cpus += virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
> +        }
> +    }
> +
> +    if (tcg_enabled() || hvf_enabled() || qtest_enabled() ||
> +        (vms->gic_version < VIRT_GIC_VERSION_3)) {
> +        max_cpus = machine->smp.max_cpus = smp_cpus;
> +        mc->has_hotpluggable_cpus = false;
> +        if (vms->gic_version >= VIRT_GIC_VERSION_3) {
> +            warn_report("cpu hotplug feature has been disabled");
> +        }
> +    }
> +
> +    if (max_cpus > virt_max_cpus) {
> +        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
> +                     "supported by machine 'mach-virt' (%d)",
> +                     max_cpus, virt_max_cpus);
> +        if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->highmem_redists) {
> +            error_printf("Try 'highmem-redists=on' for more CPUs\n");
> +        }
> +
> +        exit(1);
> +    }
> +
> +    /* uses smp.max_cpus to initialize all possible vCPUs */
> +    possible_cpus = mc->possible_cpu_arch_ids(machine);
> +
>       if (vms->secure) {
>           /*
>            * The Secure view of the world is the same as the NonSecure,
> @@ -2147,31 +2182,6 @@ static void machvirt_init(MachineState *machine)
>           vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
>       }
>   
> -    /*
> -     * The maximum number of CPUs depends on the GIC version, or on how
> -     * many redistributors we can fit into the memory map (which in turn
> -     * depends on whether this is a GICv3 or v4).
> -     */
> -    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> -        virt_max_cpus = GIC_NCPU;
> -    } else {
> -        virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
> -        if (vms->highmem_redists) {
> -            virt_max_cpus += virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
> -        }
> -    }
> -
> -    if (max_cpus > virt_max_cpus) {
> -        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
> -                     "supported by machine 'mach-virt' (%d)",
> -                     max_cpus, virt_max_cpus);
> -        if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->highmem_redists) {
> -            error_printf("Try 'highmem-redists=on' for more CPUs\n");
> -        }
> -
> -        exit(1);
> -    }
> -
>       if (vms->secure && (kvm_enabled() || hvf_enabled())) {
>           error_report("mach-virt: %s does not support providing "
>                        "Security extensions (TrustZone) to the guest CPU",


