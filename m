Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF7C35FEB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSDQ-0006xe-Ad; Tue, 17 Sep 2024 03:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=F3tl=QP=kaod.org=clg@ozlabs.org>)
 id 1sqSDN-0006wV-J6; Tue, 17 Sep 2024 03:01:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=F3tl=QP=kaod.org=clg@ozlabs.org>)
 id 1sqSDL-0003Xy-25; Tue, 17 Sep 2024 03:01:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X7CPC5nx3z4xZg;
 Tue, 17 Sep 2024 17:01:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X7CP967xZz4xYP;
 Tue, 17 Sep 2024 17:01:17 +1000 (AEST)
Message-ID: <6ed1b5e4-cdd4-4805-ae24-36810ef11fe3@kaod.org>
Date: Tue, 17 Sep 2024 09:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: remove deprecated machines specific code
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20240917060300.943496-1-harshpb@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240917060300.943496-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=F3tl=QP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Harsh,

On 9/17/24 08:03, Harsh Prateek Bora wrote:
> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
> deprecated with reasons mentioned in its commit log.
> Removing the arch specific code for the now deprecated machine types.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

There is more to it :/

Some machine versions have their own set of properties, like the
"pre-*-migration" ones, and the associated code should be removed
also. It impacts more models than just the machine model.

I suggest one patch per machine version, or one patch per complex
machine version and a combo patch for the simple ones.

Thanks,

C.


> ---
>   hw/ppc/spapr.c | 235 -------------------------------------------------
>   1 file changed, 235 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8aa3ce7449..04f06377b4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5157,241 +5157,6 @@ static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
>   
>   DEFINE_SPAPR_MACHINE_TAGGED(2, 12, sxxm);
>   
> -/*
> - * pseries-2.11
> - */
> -
> -static void spapr_machine_2_11_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -
> -    spapr_machine_2_12_class_options(mc);
> -    smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
> -    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 11);
> -
> -/*
> - * pseries-2.10
> - */
> -
> -static void spapr_machine_2_10_class_options(MachineClass *mc)
> -{
> -    spapr_machine_2_11_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 10);
> -
> -/*
> - * pseries-2.9
> - */
> -
> -static void spapr_machine_2_9_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
> -    };
> -
> -    spapr_machine_2_10_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    smc->pre_2_10_has_unused_icps = true;
> -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 9);
> -
> -/*
> - * pseries-2.8
> - */
> -
> -static void spapr_machine_2_8_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pcie-extended-configuration-space", "off" },
> -    };
> -
> -    spapr_machine_2_9_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    mc->numa_mem_align_shift = 23;
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 8);
> -
> -/*
> - * pseries-2.7
> - */
> -
> -static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
> -                              uint64_t *buid, hwaddr *pio,
> -                              hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns, Error **errp)
> -{
> -    /* Legacy PHB placement for pseries-2.7 and earlier machine types */
> -    const uint64_t base_buid = 0x800000020000000ULL;
> -    const hwaddr phb_spacing = 0x1000000000ULL; /* 64 GiB */
> -    const hwaddr mmio_offset = 0xa0000000; /* 2 GiB + 512 MiB */
> -    const hwaddr pio_offset = 0x80000000; /* 2 GiB */
> -    const uint32_t max_index = 255;
> -    const hwaddr phb0_alignment = 0x10000000000ULL; /* 1 TiB */
> -
> -    uint64_t ram_top = MACHINE(spapr)->ram_size;
> -    hwaddr phb0_base, phb_base;
> -    int i;
> -
> -    /* Do we have device memory? */
> -    if (MACHINE(spapr)->device_memory) {
> -        /* Can't just use maxram_size, because there may be an
> -         * alignment gap between normal and device memory regions
> -         */
> -        ram_top = MACHINE(spapr)->device_memory->base +
> -            memory_region_size(&MACHINE(spapr)->device_memory->mr);
> -    }
> -
> -    phb0_base = QEMU_ALIGN_UP(ram_top, phb0_alignment);
> -
> -    if (index > max_index) {
> -        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
> -                   max_index);
> -        return false;
> -    }
> -
> -    *buid = base_buid + index;
> -    for (i = 0; i < n_dma; ++i) {
> -        liobns[i] = SPAPR_PCI_LIOBN(index, i);
> -    }
> -
> -    phb_base = phb0_base + index * phb_spacing;
> -    *pio = phb_base + pio_offset;
> -    *mmio32 = phb_base + mmio_offset;
> -    /*
> -     * We don't set the 64-bit MMIO window, relying on the PHB's
> -     * fallback behaviour of automatically splitting a large "32-bit"
> -     * window into contiguous 32-bit and 64-bit windows
> -     */
> -
> -    return true;
> -}
> -
> -static void spapr_machine_2_7_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
> -        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
> -    };
> -
> -    spapr_machine_2_8_class_options(mc);
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
> -    mc->default_machine_opts = "modern-hotplug-events=off";
> -    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    smc->phb_placement = phb_placement_2_7;
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 7);
> -
> -/*
> - * pseries-2.6
> - */
> -
> -static void spapr_machine_2_6_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
> -    };
> -
> -    spapr_machine_2_7_class_options(mc);
> -    mc->has_hotpluggable_cpus = false;
> -    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 6);
> -
> -/*
> - * pseries-2.5
> - */
> -
> -static void spapr_machine_2_5_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    static GlobalProperty compat[] = {
> -        { "spapr-vlan", "use-rx-buffer-pools", "off" },
> -    };
> -
> -    spapr_machine_2_6_class_options(mc);
> -    smc->use_ohci_by_default = true;
> -    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 5);
> -
> -/*
> - * pseries-2.4
> - */
> -
> -static void spapr_machine_2_4_class_options(MachineClass *mc)
> -{
> -    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -
> -    spapr_machine_2_5_class_options(mc);
> -    smc->dr_lmb_enabled = false;
> -    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
> -}
> -
> -DEFINE_SPAPR_MACHINE(2, 4);
> -
> -/*
> - * pseries-2.3
> - */
> -
> -static void spapr_machine_2_3_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
> -    };
> -    spapr_machine_2_4_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -DEFINE_SPAPR_MACHINE(2, 3);
> -
> -/*
> - * pseries-2.2
> - */
> -
> -static void spapr_machine_2_2_class_options(MachineClass *mc)
> -{
> -    static GlobalProperty compat[] = {
> -        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
> -    };
> -
> -    spapr_machine_2_3_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_2, hw_compat_2_2_len);
> -    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
> -}
> -DEFINE_SPAPR_MACHINE(2, 2);
> -
> -/*
> - * pseries-2.1
> - */
> -
> -static void spapr_machine_2_1_class_options(MachineClass *mc)
> -{
> -    spapr_machine_2_2_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len);
> -}
> -DEFINE_SPAPR_MACHINE(2, 1);
> -
>   static void spapr_machine_register_types(void)
>   {
>       type_register_static(&spapr_machine_info);


