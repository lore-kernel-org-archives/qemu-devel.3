Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2FACA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpsS-0003J9-6q; Tue, 26 Aug 2025 05:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqpsP-0003IA-0i
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:22:01 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqpsF-0006R5-6p
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756200111; x=1787736111;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=OpSBory3olZYVeJo7xvJG/y5BVJG+TbiJTNaBTF1klI=;
 b=MTAXC9dP+YI47m67pEVDI14CQM30UQaT7dzxz5HD4Ee7ojzoEF5V6aGA
 mPzSvfNd7c92a/+fiCHnDjL/Gzt6mUTm/VeU2CSHKL8BSOKun28vPLoBY
 X++NwhJwsJtUyiFVxK3DQRwU3bRzwIWwxoCFzReqv3eSO7EeQyP8oigQr
 PCuQOenjaeNdp1T49qhYbPJ8dA1NpGoN7sRyHypwlfQ0twwOAJgrkFtx6
 kKtlPLbnbBvfp93fim8pQIh/Xz/qG/QBIurs8ZkGWCKNQquHuflNSPJwN
 EASh80FYALgm4DQS2Kxvje4V1kAayEfR9kwHo4qg8n9Bv00LZtJvN4s/H g==;
X-CSE-ConnectionGUID: Jo4qVwwIRbiv9KW4cW+MEA==
X-CSE-MsgGUID: fFXAB9FUR/2rt1wklhKh6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58347497"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58347497"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:21:46 -0700
X-CSE-ConnectionGUID: yu7KJY14TtOFxtV86ZGcXg==
X-CSE-MsgGUID: ypNEKOthRdGOov3ylz7Q4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169030649"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:21:44 -0700
Message-ID: <010b2b2e-7d88-42b1-ad5e-ccd1518777af@intel.com>
Date: Tue, 26 Aug 2025 17:21:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/19] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-5-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-5-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> This is to prepare for splitting the isapc machine into its own separate file.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 260 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 071bf7412e..5b97ad2cea 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c

...

> +    if (piix4_pm) {
> +        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
> +
> +        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
> +        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
> +        /* TODO: Populate SPD eeprom data.  */
> +        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
> +
> +        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
> +                                 TYPE_HOTPLUG_HANDLER,
> +                                 (Object **)&x86ms->acpi_dev,
> +                                 object_property_allow_set_link,
> +                                 OBJ_PROP_LINK_STRONG);
> +        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
> +                                 piix4_pm, &error_abort);
> +    }
> +
> +    if (machine->nvdimms_state->is_enabled) {
> +        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> +                               x86_nvdimm_acpi_dsmio,
> +                               x86ms->fw_cfg, OBJECT(pcms));
> +    }

IGVM support was merged recently and the rebase of this series doesn't 
catch it.

I think we need to copy the IGVM related code as well, in this patch.
We can remove it later in a separate patch if it's unnecessary for isapc.

>   }
>   #endif
>   


