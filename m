Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A71CFC28C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 15:16:35 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMOoA-0001a5-KW; Fri, 21 Nov 2025 05:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMOWh-0003zA-UX; Fri, 21 Nov 2025 05:38:04 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMOWX-0002JN-Al; Fri, 21 Nov 2025 05:37:59 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5ALAbASp074664
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 19:37:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fXuVz71uzKkMD6s5XD0qIx2g6uYHZuOpMWhK178pPTM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763721431; v=1;
 b=B8BJ4RsEIYqOAWJKwm2AN9ZZu8mhPspw6z+gm5cbHONrV0+EesrAoc57mj8e4WDr
 krGosBnUsoIwKQwyAgdbDXENH80IxsUTM915E5OMdG95c2lnjn1tqTDxjq2qCYAf
 HlhdqTVfoInu2iu1L2BQfYJs/jcvrZjR5lPqOYydjvZJwuGwNRUhkYeOLCfmzSTF
 hO3x1uvg5749eMxpYWvoBA08nrJcpcKaTPyOL0txh92hhVrOMVeETcG8f00yXwwV
 E94pRd7+qNFI4+jy+SaPmz1cnIQPaTUi4aV6lzxi1E3R+o0oaKHvkiP5+Rch1aD/
 9jf18z9PQnw4ei2xiFWqaw==
Message-ID: <95237630-e3b4-4787-a1f8-8eb8e50929f5@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 19:37:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/28] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
 <20251121100240.89117-5-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251121100240.89117-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/21 19:02, Mohamed Mediouni wrote:
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
> 
> As such, support a GICv3 w/ GICv2m for that scenario.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/virt-acpi-build.c | 4 +++-
>   hw/arm/virt.c            | 8 ++++++++
>   include/hw/arm/virt.h    | 2 ++
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 200e2a1da7..e2062f5d21 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -960,7 +960,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>               build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>               build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>           }
> -    } else {
> +    }
> +
> +    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) && !vms->no_gicv3_with_gicv2m) {
>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>   
>           /* 5.2.12.16 GIC MSI Frame Structure */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 25fb2bab56..f2a924ed26 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -959,6 +959,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>   
>       if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
>           create_its(vms);
> +    } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->no_gicv3_with_gicv2m) {
> +        create_v2m(vms);
>       } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
>           create_v2m(vms);
>       }

Shorter:
if (vms->gic_version == VIRT_GIC_VERSION_2 ||
     !vms->no_gicv3_with_gicv2m) {
     create_v2m(vms);
}

> @@ -2444,6 +2446,8 @@ static void machvirt_init(MachineState *machine)
>       vms->ns_el2_virt_timer_irq = ns_el2_virt_timer_present() &&
>           !vmc->no_ns_el2_virt_timer_irq;
>   
> +    vms->no_gicv3_with_gicv2m = vmc->no_gicv3_with_gicv2m;
> +
>       fdt_add_timer_nodes(vms);
>       fdt_add_cpu_nodes(vms);
>   
> @@ -3488,6 +3492,7 @@ static void virt_instance_init(Object *obj)
>       vms->its = true;
>       /* Allow ITS emulation if the machine version supports it */
>       vms->tcg_its = !vmc->no_tcg_its;
> +    vms->no_gicv3_with_gicv2m = false;
>   
>       /* Default disallows iommu instantiation */
>       vms->iommu = VIRT_IOMMU_NONE;
> @@ -3540,9 +3545,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
>   
>   static void virt_machine_10_1_options(MachineClass *mc)
>   {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>       virt_machine_10_2_options(mc);
>       mc->smbios_memory_device_size = 2047 * TiB;
>       compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
> +    vmc->no_gicv3_with_gicv2m = true;
>   }
>   DEFINE_VIRT_MACHINE(10, 1)
>   
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c77a33f6df..3ff83aaabe 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -130,6 +130,7 @@ struct VirtMachineClass {
>       bool no_cpu_topology;
>       bool no_tcg_lpa2;
>       bool no_ns_el2_virt_timer_irq;
> +    bool no_gicv3_with_gicv2m;
>       bool no_nested_smmu;
>   };
>   
> @@ -178,6 +179,7 @@ struct VirtMachineState {
>       char *oem_id;
>       char *oem_table_id;
>       bool ns_el2_virt_timer_irq;
> +    bool no_gicv3_with_gicv2m;
>       CXLState cxl_devices_state;
>       bool legacy_smmuv3_present;
>   };


