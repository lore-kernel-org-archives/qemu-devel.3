Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC7D2F7C0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1B9F-0006xN-Qv; Wed, 16 Oct 2024 17:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t1B9C-0006wM-LE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 17:01:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t1B97-00072F-QN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 17:01:32 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so170977a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729112487; x=1729717287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nHlGF3uwwQsKfeXKdvjHdRtK0r/TpN1816UdNGavwgY=;
 b=H9KZQc5+ZZqcOLCOgz9ItKQiqMdfeg4Bt9OREgYZ4C9VoQ/s8DXebrMG1FgKkKnfG4
 9ftk+Oji9AxpNpadWGZSPymMjpJTf3KaGfltBP/TbH0YAKQ6Qlg7SB/Ie7PknUABbLxV
 kd6fgsVHMQLT9eXBwRB9mte9ibQFJY/upnYM0i/uHwcATshWe+ROrN8NiEHL+I8x5pu5
 ykcdh849iM9xattg8zXRHuPAjF0Jswl+QFICtblUxqVbgWblPQJqANO7fPDNJgDxUiiW
 5rBAguxzNhfAOXHfxo3qf7i1EGJAHqa4pe8rGmKhD04bMjHRs50g3nXpjJXae3MjOIsd
 cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729112487; x=1729717287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nHlGF3uwwQsKfeXKdvjHdRtK0r/TpN1816UdNGavwgY=;
 b=ezC5adHQnD1LsSs0R6z8qLPyIBVoyQARWVg77XLzValp3hDKWdsLzM4svjp/k1cib7
 bUze+MPHDY3TIY5w1fW2PloJ/enQfJpYB+QcDoGlbFaAnmJqV8OLECPHHMFLzvZfBEIZ
 j2LAZajHxLLUlrwgwym/JBqUZOpafViaKOCuqN90T05S5oVI2hGGy1Z7tK8YSvObPXxJ
 x0kD/Dp48wj7K7702b9eMQEjn851r2/VARzaBql0Ybz6rXZHiwhiIW7lKokK2JmCts8a
 Xq7pTzWc+EkQMyO4E3MSGb7ms6TRHw40ufxVcGICaS1cuRg9/JbfvIX4k5Hs/u3/OoZI
 6HZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/QpEarLOHiAi5lDhoXHh3XHfBauLf7SZ8ejMMEIGSMpuJr7tEJO2ZlTJKVRjm75tTRrPEruG4g4bL@nongnu.org
X-Gm-Message-State: AOJu0YwRxWBiedGhr2gkbapehN5/Ho3g2+P9gkA8h5ok7IwZ6yUTFSRe
 H+jSjuocXD1m3Z2ilp2/MntaVd5HA7hjbDdJRABRVFZn+wuEok4zU6TG8/KARsU=
X-Google-Smtp-Source: AGHT+IHyCpYZ0ayZYlWfmKixvWOYqKSZ3M4HRtMYnPcqlVoUXfkOr+XIDiNVv7cWnpb+fZ4g+hAgSg==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:3f2a:d1dd with SMTP id
 adf61e73a8af0-1d905ec0a73mr7650410637.12.1729112486667; 
 Wed, 16 Oct 2024 14:01:26 -0700 (PDT)
Received: from [192.168.0.102] ([187.121.94.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6c403csm3743942a12.35.2024.10.16.14.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 14:01:26 -0700 (PDT)
Message-ID: <2d4a0d78-f3cc-4644-a9ea-d02114c242b8@linaro.org>
Date: Wed, 16 Oct 2024 18:01:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/4] hw/acpi: Initialize ACPI Hotplug CPU Status with
 Support for vCPU `Persistence`
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, linuxarm@huawei.com
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-2-salil.mehta@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241014192205.253479-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Salil,

On 10/14/24 16:22, Salil Mehta wrote:
> Certain CPU architecture specifications [1][2][3] prohibit changes to CPU
> presence after the kernel has booted. This limitation exists because many system
> initializations rely on the exact CPU count at boot time and do not expect it to
> change later. For example, components like interrupt controllers, which are
> closely tied to CPUs, or various per-CPU features, may not support configuration
> changes once the kernel has been initialized. This presents a challenge for
> virtualization features such as vCPU hotplug.
> 
> To address this issue, introduce an `is_enabled` state in the `AcpiCpuStatus`,
> which reflects whether a vCPU has been hot-plugged or hot-unplugged in QEMU,
> marking it as (un)available in the Guest Kernel. The `is_present` state should
> be set based on the `acpi_persistent` flag. In cases where unplugged vCPUs need
> to be deliberately simulated in the ACPI to maintain a persistent view of vCPUs,
> this flag ensures the guest kernel continues to see those vCPUs.
> 
> Additionally, introduce an `acpi_persistent` property that can be used to
> initialize the ACPI vCPU presence state accordingly. Architectures requiring
> ACPI to expose a persistent view of vCPUs can override its default value. Refer
> to the patch-set implelenting vCPU hotplug support for ARM for more details on

nit: implementation


Cheers,
Gustavo

> its usage.
> 
> References:
> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
>      architectures that don’t Support CPU Hotplug (like ARM64)
>      a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>      b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
>      SoC Based Systems (like ARM64)
>      Link: https://kvmforum2020.sched.com/event/eE4m
> [3] Check comment 5 in the bugzilla entry
>      Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   cpu-target.c          |  1 +
>   hw/acpi/cpu.c         | 35 ++++++++++++++++++++++++++++++++++-
>   include/hw/acpi/cpu.h | 21 +++++++++++++++++++++
>   include/hw/core/cpu.h | 21 +++++++++++++++++++++
>   4 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 499facf774..c8a29ab495 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -200,6 +200,7 @@ static Property cpu_common_props[] = {
>        */
>       DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
> +    DEFINE_PROP_BOOL("acpi-persistent", CPUState, acpi_persistent, false),
>   #endif
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 5cb60ca8bc..083c4010c2 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -225,7 +225,40 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>       state->dev_count = id_list->len;
>       state->devs = g_new0(typeof(*state->devs), state->dev_count);
>       for (i = 0; i < id_list->len; i++) {
> -        state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
> +        struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
> +        /*
> +         * In most architectures, CPUs that are marked as ACPI 'present' are
> +         * also ACPI 'enabled' by default. These states remain consistent at
> +         * both the QOM and ACPI levels.
> +         */
> +        if (cpu) {
> +            state->devs[i].is_enabled = true;
> +            state->devs[i].is_present = true;
> +            state->devs[i].cpu = cpu;
> +        } else {
> +            state->devs[i].is_enabled = false;
> +            /*
> +             * In some architectures, even 'unplugged' or 'disabled' QOM CPUs
> +             * may be exposed as ACPI 'present.' This approach provides a
> +             * persistent view of the vCPUs to the guest kernel. This could be
> +             * due to an architectural constraint that requires every per-CPU
> +             * component to be present at boot time, meaning the exact count of
> +             * vCPUs must be known and cannot be altered after the kernel has
> +             * booted. As a result, the vCPU states at the QOM and ACPI levels
> +             * might become inconsistent. However, in such cases, the presence
> +             * of vCPUs has been deliberately simulated at the ACPI level.
> +             */
> +            if (acpi_persistent_cpu(first_cpu)) {
> +                state->devs[i].is_present = true;
> +                /*
> +                 * `CPUHotplugState::AcpiCpuStatus::cpu` becomes insignificant
> +                 * in this case
> +                 */
> +            } else {
> +                state->devs[i].is_present = false;
> +                state->devs[i].cpu = cpu;
> +            }
> +        }
>           state->devs[i].arch_id = id_list->cpus[i].arch_id;
>       }
>       memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 32654dc274..bd3f9973c9 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -26,6 +26,8 @@ typedef struct AcpiCpuStatus {
>       uint64_t arch_id;
>       bool is_inserting;
>       bool is_removing;
> +    bool is_present;
> +    bool is_enabled;
>       bool fw_remove;
>       uint32_t ost_event;
>       uint32_t ost_status;
> @@ -75,4 +77,23 @@ extern const VMStateDescription vmstate_cpu_hotplug;
>       VMSTATE_STRUCT(cpuhp, state, 1, \
>                      vmstate_cpu_hotplug, CPUHotplugState)
>   
> +/**
> + * acpi_persistent_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU state should always be reflected as *present* via ACPI
> + * to the Guest. By default, this is False on all architectures and has to be
> + * explicity set during initialization.
> + *
> + * Returns: True if it is ACPI 'persistent' CPU
> + *
> + */
> +static inline bool acpi_persistent_cpu(CPUState *cpu)
> +{
> +    /*
> +     * returns if 'Presence' of the vCPU is persistent and should be simulated
> +     * via ACPI even after vCPUs have been unplugged in QOM
> +     */
> +    return cpu && cpu->acpi_persistent;
> +}
>   #endif
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 04e9ad4996..299e96c45b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -542,6 +542,27 @@ struct CPUState {
>       CPUPluginState *plugin_state;
>   #endif
>   
> +    /*
> +     * To implement the vCPU hotplug feature (which simulates CPU hotplug
> +     * behavior), we need to dynamically create and destroy QOM vCPU objects,
> +     * and (de)associate them with pre-existing KVM vCPUs while (un)parking the
> +     * KVM vCPU context. One challenge is ensuring that these dynamically
> +     * appearing or disappearing QOM vCPU objects are accurately reflected
> +     * through ACPI to the Guest Kernel. Due to architectural constraints,
> +     * changing the number of vCPUs after the guest kernel has booted may not
> +     * always be possible.
> +     *
> +     * In certain architectures, to provide the guest kernel with a *persistent*
> +     * view of vCPU presence, even when the QOM does not have a corresponding
> +     * vCPU object, ACPI may simulate the presence of vCPUs by marking them as
> +     * ACPI-disabled. This is achieved by setting `_STA.PRES=True` and
> +     * `_STA.Ena=False` for unplugged vCPUs in QEMU's QOM.
> +     *
> +     * By default, this flag is set to `FALSE`, and it must be explicitly set
> +     * to `TRUE` for architectures like ARM.
> +     */
> +    bool acpi_persistent;
> +
>       /* TODO Move common fields from CPUArchState here. */
>       int cpu_index;
>       int cluster_index;


