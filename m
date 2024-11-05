Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D00D1CA09
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 00:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t870d-0004si-Kp; Mon, 04 Nov 2024 19:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t870b-0004sN-F8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t870Y-00054m-Ig
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730764875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gV9jHlw5Jh9lqJcAHu9xVE4uUAv+rl+7FzS+6Dgam6s=;
 b=cTCZKaG1cDO7FtKgZJJiM5OyhhDDjHs9xKtugEpqTmDl2xztB1IROm1ogbhERptVBL9ef1
 KCsiJuYw0bgDpk6Bu3+mZLuK185Q8Rdjld4nPwNRMSg+BC8SygPBLQd48sUhDs7wrmbAC4
 pbPcBadkYFDGE6WhdHMfi626ILXOJuI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-DVM8Uaw_NNy2ywE2k9-sxQ-1; Mon, 04 Nov 2024 19:01:14 -0500
X-MC-Unique: DVM8Uaw_NNy2ywE2k9-sxQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7203cdc239dso5843694b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 16:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730764873; x=1731369673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gV9jHlw5Jh9lqJcAHu9xVE4uUAv+rl+7FzS+6Dgam6s=;
 b=b2uLP4v7bHlNTGxqFt3OQUydPXOL7a+1FN5pjbOt++X7GFykrzIvdV8l9SXXe4apoo
 vu7PaC3w8wBHEsqPaB3vUsJ6cURv+Ww8trXozmmW1U9zhNKPVmieaMplOgue4UyPdMth
 Mb7SGEZTVhGVs5oX+IcuITkzhWoxRQZp/JE1eip8KTmxF/P6Hgu8QFzQ6GLAe0moppMC
 VezC6rqg82Z5N+9A2xKaOZYIbnAPAL4jzRYtTdwm6ZkmPP1EnLDuVfA4YcAHSiSg0AYB
 gCrF5Ilrvfl7z/LtwhZ8kd9fNOMklSGkOi35QsJwO9W9fBjC6iiKgecLzsou3y1zPPV5
 VgVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1DmkKIqum390xzMiy8HFa2fzBv46aN/sJlvzUyvjedeqG316DSClfUiSXM7c1Je6BSvhK+ixWoHqZ@nongnu.org
X-Gm-Message-State: AOJu0YzKA0vMKltOV7ruqbsFlAD1hxDiQSegTvfiAYKmsr75uxPvOrZ5
 XzCSUdJl8I3f0hRn4iZI4UUC+THs4TrUG2jhf65T8BAXgrNazvD4vmQh47mwfLcj/XQUDqCOwjg
 ETz+Nv9Fs6748Y+2mwnIBSQPrMTPOttx4Sv1RH22CmRDC+rBMxwxL
X-Received: by 2002:a05:6a00:27a0:b0:71d:f510:b791 with SMTP id
 d2e1a72fcca58-720ab3c6d19mr29623723b3a.12.1730764872851; 
 Mon, 04 Nov 2024 16:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuGbQq0wfZrNCPQbtv9JYwRaGDo/oUmcjLn5AqoFGjg9qyctRIksJznO1cAE25XUsjL6CFCQ==
X-Received: by 2002:a05:6a00:27a0:b0:71d:f510:b791 with SMTP id
 d2e1a72fcca58-720ab3c6d19mr29623655b3a.12.1730764872279; 
 Mon, 04 Nov 2024 16:01:12 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc3152fesm8204479b3a.195.2024.11.04.16.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 16:01:11 -0800 (PST)
Message-ID: <c2d13dad-8e43-43b1-9502-323da08d6720@redhat.com>
Date: Tue, 5 Nov 2024 10:00:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Move common vCPU properties in a function
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: jonathan.cameron@huawei.com, alex.bennee@linaro.org, imammedo@redhat.com, 
 pbonzini@redhat.com, maz@kernel.org, will@kernel.org,
 oliver.upton@linux.dev, jean-philippe@linaro.org, lpieralisi@kernel.org,
 david@redhat.com, philmd@linaro.org, andrew.jones@linux.dev,
 eric.auger@redhat.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com,
 gustavo.romero@linaro.org
References: <20241103152256.202444-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241103152256.202444-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/4/24 1:22 AM, Salil Mehta wrote:
> Refactor vCPU properties code from the `machvirt_init()` main loop with
> the following goals:
> 
> 1. Enable code reuse in future patch sets.
> 2. Improve code readability.
> 3. Separate out the one-time initialization of (secure-)Tagged memory,
>     handling potential failures early.
> 
> Note: This is a cosmetic change only; *no* functional changes are
>        intended here.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c         | 238 +++++++++++++++++++++++++-----------------
>   include/hw/arm/virt.h |   4 +
>   2 files changed, 147 insertions(+), 95 deletions(-)
> 

With the following nitpicks addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1a381e9a2b..a0d3bef875 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2091,16 +2091,126 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>       }
>   }
>   
> +static void virt_cpu_set_properties(Object *cpuobj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    const CPUArchIdList *possible_cpus;
> +    Error *local_err = NULL;
> +    VirtMachineClass *vmc;
> +
> +    vmc = VIRT_MACHINE_GET_CLASS(ms);
> +
> +    possible_cpus = mc->possible_cpu_arch_ids(ms);


virt_cpu_set_properties() is only called by machvirt_init() where MachineState
is passed in as parameter. So MachineState can be passed down as a parameter
instead of retriving it by qdev_get_machine(). Besides, the chunk of code can
be further compact.

static void virt_cpu_set_properties(MachineState *ms, Object *cpuobj, Error **errp)
{
     VirtMachineState *vms = VIRT_MACHINE(ms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
     Error *local_err = NULL;
       :

}


> +    object_property_set_int(cpuobj, "mp-affinity",
> +                            possible_cpus->cpus[CPU(cpuobj)->cpu_index].arch_id,
> +                            NULL);
> +
> +    numa_cpu_pre_plug(&possible_cpus->cpus[CPU(cpuobj)->cpu_index],
> +                      DEVICE(cpuobj), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (!vms->secure) {
> +        object_property_set_bool(cpuobj, "has_el3", false, NULL);
> +    }
> +
> +    if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> +        object_property_set_bool(cpuobj, "has_el2", false, NULL);
> +    }
> +
> +    if (vmc->kvm_no_adjvtime &&
> +        object_property_find(cpuobj, "kvm-no-adjvtime")) {
> +        object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> +    }
> +
> +    if (vmc->no_kvm_steal_time &&
> +        object_property_find(cpuobj, "kvm-steal-time")) {
> +        object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> +    }
> +
> +    if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> +        object_property_set_bool(cpuobj, "pmu", false, NULL);
> +    }
> +
> +    if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> +        object_property_set_bool(cpuobj, "lpa2", false, NULL);
> +    }
> +
> +    if (object_property_find(cpuobj, "reset-cbar")) {
> +        object_property_set_int(cpuobj, "reset-cbar",
> +                                vms->memmap[VIRT_CPUPERIPHS].base,
> +                                &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    object_property_set_link(cpuobj, "memory", OBJECT(vms->sysmem), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (vms->secure) {
> +        object_property_set_link(cpuobj, "secure-memory",
> +                                 OBJECT(vms->secure_sysmem), &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    if (vms->mte) {
> +        if (tcg_enabled()) {
> +            /*
> +             * The property exists only if MemTag is supported.
> +             * If it is, we must allocate the ram to back that up.
> +             */
> +            if (!object_property_find(cpuobj, "tag-memory")) {
> +                error_report("MTE requested, but not supported "
> +                             "by the guest CPU");
> +                exit(1);
> +            }
> +
> +            object_property_set_link(cpuobj, "tag-memory",
> +                                     OBJECT(vms->tag_sysmem), &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +
> +            if (vms->secure) {
> +                object_property_set_link(cpuobj, "secure-tag-memory",
> +                                         OBJECT(vms->secure_tag_sysmem),
> +                                         &local_err);
> +                if (local_err) {
> +                    goto out;
> +                }
> +            }
> +        } else if (kvm_enabled()) {
> +            kvm_arm_enable_mte(cpuobj, &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +    }
> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +}
> +
>   static void machvirt_init(MachineState *machine)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(machine);
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       const CPUArchIdList *possible_cpus;
> -    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *secure_tag_sysmem = NULL;
>       MemoryRegion *secure_sysmem = NULL;
>       MemoryRegion *tag_sysmem = NULL;
> -    MemoryRegion *secure_tag_sysmem = NULL;
> +    MemoryRegion *sysmem;
>       int n, virt_max_cpus;
>       bool firmware_loaded;
>       bool aarch64 = true;

Unnecessary change caused after the defination of @secure_tag_sysmem is moved around. Also,
I personally prefer to keep the order to define @sysmem, @secure_sysmem, @tag_sysmem and
@secure_tag_system. So this chunk of code would be something like below:

     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem = NULL;
     MemoryRegion *tag_sysmem = NULL;
     MemoryRegion *secure_tag_sysmem = NULL;

> @@ -2140,6 +2250,8 @@ static void machvirt_init(MachineState *machine)
>        */
>       finalize_gic_version(vms);
>   
> +    sysmem = vms->sysmem = get_system_memory();
> +
>       if (vms->secure) {
>           /*
>            * The Secure view of the world is the same as the NonSecure,
> @@ -2147,7 +2259,7 @@ static void machvirt_init(MachineState *machine)
>            * containing the system memory at low priority; any secure-only
>            * devices go in at higher priority and take precedence.
>            */
> -        secure_sysmem = g_new(MemoryRegion, 1);
> +        secure_sysmem = vms->secure_sysmem = g_new(MemoryRegion, 1);
>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                              UINT64_MAX);
>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> @@ -2220,6 +2332,33 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (vms->mte && !kvm_enabled() && !tcg_enabled()) {
> +        error_report("MTE requested, but not supported ");
> +        exit(1);
> +    }
> +
> +    if (vms->mte && kvm_enabled() && !kvm_arm_mte_supported()) {
> +        error_report("MTE requested, but not supported by KVM");
> +        exit(1);
> +    }
> +
> +    if (vms->mte && tcg_enabled()) {
> +        /* Create the memory region only once, but link to all cpus later */
> +        tag_sysmem = vms->tag_sysmem = g_new(MemoryRegion, 1);
> +        memory_region_init(tag_sysmem, OBJECT(machine),
> +                           "tag-memory", UINT64_MAX / 32);
> +
> +        if (vms->secure) {
> +            secure_tag_sysmem = vms->secure_tag_sysmem = g_new(MemoryRegion, 1);
> +            memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                               "secure-tag-memory", UINT64_MAX / 32);
> +
> +            /* As with ram, secure-tag takes precedence over tag.  */
> +            memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> +                                                tag_sysmem, -1);
> +        }
> +    }
> +
>       create_fdt(vms);
>   
>       assert(possible_cpus->len == max_cpus);
> @@ -2232,104 +2371,13 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           cpuobj = object_new(possible_cpus->cpus[n].type);
> -        object_property_set_int(cpuobj, "mp-affinity",
> -                                possible_cpus->cpus[n].arch_id, NULL);
>   
>           cs = CPU(cpuobj);
>           cs->cpu_index = n;
>   
> -        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
> -                          &error_fatal);
> -
>           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>   
> -        if (!vms->secure) {
> -            object_property_set_bool(cpuobj, "has_el3", false, NULL);
> -        }
> -
> -        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> -            object_property_set_bool(cpuobj, "has_el2", false, NULL);
> -        }
> -
> -        if (vmc->kvm_no_adjvtime &&
> -            object_property_find(cpuobj, "kvm-no-adjvtime")) {
> -            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> -        }
> -
> -        if (vmc->no_kvm_steal_time &&
> -            object_property_find(cpuobj, "kvm-steal-time")) {
> -            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> -        }
> -
> -        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> -            object_property_set_bool(cpuobj, "pmu", false, NULL);
> -        }
> -
> -        if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> -            object_property_set_bool(cpuobj, "lpa2", false, NULL);
> -        }
> -
> -        if (object_property_find(cpuobj, "reset-cbar")) {
> -            object_property_set_int(cpuobj, "reset-cbar",
> -                                    vms->memmap[VIRT_CPUPERIPHS].base,
> -                                    &error_abort);
> -        }
> -
> -        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
> -                                 &error_abort);
> -        if (vms->secure) {
> -            object_property_set_link(cpuobj, "secure-memory",
> -                                     OBJECT(secure_sysmem), &error_abort);
> -        }
> -
> -        if (vms->mte) {
> -            if (tcg_enabled()) {
> -                /* Create the memory region only once, but link to all cpus. */
> -                if (!tag_sysmem) {
> -                    /*
> -                     * The property exists only if MemTag is supported.
> -                     * If it is, we must allocate the ram to back that up.
> -                     */
> -                    if (!object_property_find(cpuobj, "tag-memory")) {
> -                        error_report("MTE requested, but not supported "
> -                                     "by the guest CPU");
> -                        exit(1);
> -                    }
> -
> -                    tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(tag_sysmem, OBJECT(machine),
> -                                       "tag-memory", UINT64_MAX / 32);
> -
> -                    if (vms->secure) {
> -                        secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                           "secure-tag-memory",
> -                                           UINT64_MAX / 32);
> -
> -                        /* As with ram, secure-tag takes precedence over tag. */
> -                        memory_region_add_subregion_overlap(secure_tag_sysmem,
> -                                                            0, tag_sysmem, -1);
> -                    }
> -                }
> -
> -                object_property_set_link(cpuobj, "tag-memory",
> -                                         OBJECT(tag_sysmem), &error_abort);
> -                if (vms->secure) {
> -                    object_property_set_link(cpuobj, "secure-tag-memory",
> -                                             OBJECT(secure_tag_sysmem),
> -                                             &error_abort);
> -                }
> -            } else if (kvm_enabled()) {
> -                if (!kvm_arm_mte_supported()) {
> -                    error_report("MTE requested, but not supported by KVM");
> -                    exit(1);
> -                }
> -                kvm_arm_enable_mte(cpuobj, &error_abort);
> -            } else {
> -                    error_report("MTE requested, but not supported ");
> -                    exit(1);
> -            }
> -        }
> +        virt_cpu_set_properties(cpuobj, &error_abort);
>   
>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>           object_unref(cpuobj);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index aca4f8061b..239f3678af 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -143,6 +143,10 @@ struct VirtMachineState {
>       DeviceState *platform_bus_dev;
>       FWCfgState *fw_cfg;
>       PFlashCFI01 *flash[2];
> +    MemoryRegion *sysmem;
> +    MemoryRegion *secure_sysmem;
> +    MemoryRegion *tag_sysmem;
> +    MemoryRegion *secure_tag_sysmem;
>       bool secure;
>       bool highmem;
>       bool highmem_compact;

Thanks,
Gavin


