Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC4C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 14:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiYOo-0003Pw-FT; Sat, 11 Jul 2026 10:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiYOm-0003Pj-8h; Sat, 11 Jul 2026 10:09:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiYOj-0007Wf-Ev; Sat, 11 Jul 2026 10:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783778967; bh=FfrgjJwnoykgjOyFK0F2md3l8gPjAb5a/0gdwYt/UEU=;
 h=Date:From:Subject:To:References:Cc:In-Reply-To;
 b=IXvUVT1JdcYnoQnH+ZIDc9x9rDVUjWwW/QHATr6/FNnwxL0FtTFZ1UOHis302OsvY
 m6zyHGpByOZFVF3oWYMYacb1C7TY0tkLE+xfnGkJwp1EGduBZiZqb4BZNVTEZnngum
 /sJoiLYbBjpg+hZ2a3yvYP4ZTLNKlAdPWII62s18J7KIOMvsFDjN/rX8dtC6eRb3qI
 3kPIQfGgKbG/1K2eTEJVyybRWLPrqke7QHh5iXoQN+16gNVdXK9XqU+jka5FgmuxnJ
 OjvoxPS4/RAauEx/9vlDIh52osKfkDEYRygQZZS928csB7ay+C2svs1iz7WasqbHRK
 8QGElYNukrPOA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 43AD41C0999;
 Sat, 11 Jul 2026 17:09:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3D2193EAD10;
 Sat, 11 Jul 2026 17:09:36 +0300 (MSK)
Message-ID: <ec748831-869f-4b14-892b-d5e7b5ac8dfd@tls.msk.ru>
Date: Sat, 11 Jul 2026 17:09:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 2/3] hw/pci-host/q35.c: Factor out creation of SMRAM MRs
To: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
 <20260708121011.1653365-3-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260708121011.1653365-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/8/26 15:10, Peter Maydell wrote:
> mch_realize has a large section that deals with initializing the
> SMRAM-specific MemoryRegions.  Currently we do an early return from
> the realize function if mch->has_smm_ranges is false, but this has
> the potential for bugs if somebody adds new code at the end of the
> function that isn't SMM-specific.  Pull the MR init code out into its
> own function, so we can do the smm-ranges specific handling in the
> realize function in a more obvious way.

Thank you for this refactoring, Peter.  It's exactly what I had in
mind at the time, - to split this long function with early return
to smaller logical parts.

> This commit shouldn't change behaviour at all.

Yeah, just move a bunch of code to a new function and call it in
the place where that code has been before.

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks,

/mjt

>   hw/pci-host/q35.c | 91 ++++++++++++++++++++++++-----------------------
>   1 file changed, 47 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 47e726c41d..e42b84b978 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -572,49 +572,9 @@ static void mch_reset(DeviceState *qdev)
>       mch_update(mch);
>   }
>   
> -static void mch_realize(PCIDevice *d, Error **errp)
> +static void mch_init_smram_regions(MCHPCIState *mch)
>   {
> -    int i;
> -    MCHPCIState *mch = MCH_PCI_DEVICE(d);
> -
> -    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
> -        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
> -                   mch->ext_tseg_mbytes);
> -        return;
> -    }
> -
> -    /* setup pci memory mapping */
> -    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
> -
> -    /* PAM */
> -    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
> -             mch->system_memory, mch->pci_address_space,
> -             PAM_BIOS_BASE, PAM_BIOS_SIZE);
> -    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
> -        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
> -                 mch->system_memory, mch->pci_address_space,
> -                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
> -    }
> -
> -    /*
> -     * This memory region looks like it's SMM specific, but it is not.
> -     * It's an alias that makes the pci_address_space appear in system
> -     * memory at the SMRAM_C_BASE address. The alias is enabled when the
> -     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
> -     * visible. So for non-SMM configs we need to create the alias, and
> -     * leave it permanently enabled.
> -     */
> -    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
> -                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
> -                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
> -    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
> -                                        &mch->smram_region, 1);
> -    memory_region_set_enabled(&mch->smram_region, true);
> -
> -    if (!mch->has_smm_ranges) {
> -        return;
> -    }
> -
> +    /* Initialize all the SMRAM specific MemoryRegions */
>       memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
>                                mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
>                                MCH_HOST_BRIDGE_SMRAM_C_SIZE);
> @@ -670,9 +630,52 @@ static void mch_realize(PCIDevice *d, Error **errp)
>       memory_region_set_enabled(&mch->smbase_window, false);
>       memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
>                                   &mch->smbase_window);
> +}
>   
> -    object_property_add_const_link(qdev_get_machine(), "smram",
> -                                   OBJECT(&mch->smram));
> +static void mch_realize(PCIDevice *d, Error **errp)
> +{
> +    int i;
> +    MCHPCIState *mch = MCH_PCI_DEVICE(d);
> +
> +    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
> +        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
> +                   mch->ext_tseg_mbytes);
> +        return;
> +    }
> +
> +    /* setup pci memory mapping */
> +    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
> +
> +    /* PAM */
> +    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
> +             mch->system_memory, mch->pci_address_space,
> +             PAM_BIOS_BASE, PAM_BIOS_SIZE);
> +    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
> +        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
> +                 mch->system_memory, mch->pci_address_space,
> +                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
> +    }
> +
> +    /*
> +     * This memory region looks like it's SMM specific, but it is not.
> +     * It's an alias that makes the pci_address_space appear in system
> +     * memory at the SMRAM_C_BASE address. The alias is enabled when the
> +     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
> +     * visible. So for non-SMM configs we need to create the alias, and
> +     * leave it permanently enabled.
> +     */
> +    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
> +                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
> +                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
> +    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
> +                                        &mch->smram_region, 1);
> +    memory_region_set_enabled(&mch->smram_region, true);
> +
> +    if (mch->has_smm_ranges) {
> +        mch_init_smram_regions(mch);
> +        object_property_add_const_link(qdev_get_machine(), "smram",
> +                                       OBJECT(&mch->smram));
> +    }
>   }
>   
>   static const Property mch_props[] = {


