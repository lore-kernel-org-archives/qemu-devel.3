Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEFDC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6ID-0001IJ-3j; Mon, 03 Jun 2024 07:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE6IB-0001Gw-3g
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE6I6-0006PI-U1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717415753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=W62f82UZMHf0uefYVTTrEL80HQVAl8hkE/O4iaXRMVs=;
 b=KNrFaHzeMnSNOdmjlfr26nTM8xVSqupk2Gf1N4MfpJeEVNIe5R6PV6wirpHKs3cL7LRHkh
 a/YDROFXL/xhGJQZ52vhDWnKfwGws6ep//xzZ9/bthml1PYK2lX/IKFhbd1D3pv1ymEdtf
 dc1figE45vyS+/2pU5xFDZ5jnKffH40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-q5seXqRnOj6S-ekv4jK37Q-1; Mon,
 03 Jun 2024 07:55:47 -0400
X-MC-Unique: q5seXqRnOj6S-ekv4jK37Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75371C0512B;
 Mon,  3 Jun 2024 11:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AD76C15C04;
 Mon,  3 Jun 2024 11:55:45 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:55:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com,
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com,
 pbonzini@redhat.com, thomas.lendacky@amd.com,
 isaku.yamahata@intel.com, kvm@vger.kernel.org, anisinha@redhat.com
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
Message-ID: <Zl2vP9hohrgaPMTs@redhat.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530111643.1091816-30-pankaj.gupta@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 30, 2024 at 06:16:41AM -0500, Pankaj Gupta wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> SEV-ES and SEV-SNP support OVMF images with non-volatile storage in
> cases where the storage area is generated as a separate image as part
> of the OVMF build process.

IIUC, right now all OVMF builds for SEV/-ES/-SNP should be done as so
called "stateless" image. ie *without* any separate NVRAM image, because
that image will not be covered by the VM boot measurement and thus the
NVRAM state is liable to undermine  trust of the VM.

Using NVRAM for SNP is theoretically possible in future but would be
reliant on SVSM providing a secure encryption mechanism on the storage.



> 
> Currently these are exposed with unit=0 corresponding to the actual BIOS
> image, and unit=1 corresponding to the storage image. However, pflash
> images are mapped guest memory using read-only memslots, which are not
> allowed in conjunction with guest_memfd-backed ranges. This makes that
> approach unusable for SEV-SNP, where the BIOS range will be encrypted
> and mapped as private guest_memfd-backed memory. For this reason,
> SEV-SNP will instead rely on -bios to handle loading the BIOS image.
> 
> To allow for pflash to still be used for the storage image, rework the
> existing logic to remove assumptions that unit=0 contains the BIOS image
> when SEV-SNP, so that it can instead be used to handle only the storage
> image.

Mixing both BIOS and pflash is pretty undesirable, not least because
that setup cannot be currently represented by the firmware descriptor
format described by docs/interop/firmware.json.

So at the very least this patch is incomplete, as it would need to
propose changes to the firmware.json to allow this setup to be expressed.

I really wish we didn't have to introduce this though - is there really
no way to make it possible to use pflash for both CODE & VARS with SNP,
as is done with traditional VMs, so we don't diverge in setup, needing
yet more changes up the mgmt stack ?

> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  hw/i386/pc_sysfw.c | 47 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index def77a442d..7f97e62b16 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -125,21 +125,10 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>      }
>  }
>  
> -/*
> - * Map the pcms->flash[] from 4GiB downward, and realize.
> - * Map them in descending order, i.e. pcms->flash[0] at the top,
> - * without gaps.
> - * Stop at the first pcms->flash[0] lacking a block backend.
> - * Set each flash's size from its block backend.  Fatal error if the
> - * size isn't a non-zero multiple of 4KiB, or the total size exceeds
> - * pcms->max_fw_size.
> - *
> - * If pcms->flash[0] has a block backend, its memory is passed to
> - * pc_isa_bios_init().  Merging several flash devices for isa-bios is
> - * not supported.
> - */
> -static void pc_system_flash_map(PCMachineState *pcms,
> -                                MemoryRegion *rom_memory)
> +static void pc_system_flash_map_partial(PCMachineState *pcms,
> +                                        MemoryRegion *rom_memory,
> +                                        hwaddr offset,
> +                                        bool storage_only)
>  {
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> @@ -154,6 +143,8 @@ static void pc_system_flash_map(PCMachineState *pcms,
>  
>      assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>  
> +    total_size = offset;
> +
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>          hwaddr gpa;
>  
> @@ -192,7 +183,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(system_flash), &error_fatal);
>          sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0, gpa);
>  
> -        if (i == 0) {
> +        if (i == 0 && !storage_only) {
>              flash_mem = pflash_cfi01_get_memory(system_flash);
>              if (pcmc->isa_bios_alias) {
>                  x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
> @@ -211,6 +202,25 @@ static void pc_system_flash_map(PCMachineState *pcms,
>      }
>  }
>  
> +/*
> + * Map the pcms->flash[] from 4GiB downward, and realize.
> + * Map them in descending order, i.e. pcms->flash[0] at the top,
> + * without gaps.
> + * Stop at the first pcms->flash[0] lacking a block backend.
> + * Set each flash's size from its block backend.  Fatal error if the
> + * size isn't a non-zero multiple of 4KiB, or the total size exceeds
> + * pcms->max_fw_size.
> + *
> + * If pcms->flash[0] has a block backend, its memory is passed to
> + * pc_isa_bios_init().  Merging several flash devices for isa-bios is
> + * not supported.
> + */
> +static void pc_system_flash_map(PCMachineState *pcms,
> +                                MemoryRegion *rom_memory)
> +{
> +    pc_system_flash_map_partial(pcms, rom_memory, 0, false);
> +}
> +
>  void pc_system_firmware_init(PCMachineState *pcms,
>                               MemoryRegion *rom_memory)
>  {
> @@ -238,9 +248,12 @@ void pc_system_firmware_init(PCMachineState *pcms,
>          }
>      }
>  
> -    if (!pflash_blk[0]) {
> +    if (!pflash_blk[0] || sev_snp_enabled()) {
>          /* Machine property pflash0 not set, use ROM mode */
>          x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
> +        if (sev_snp_enabled()) {
> +            pc_system_flash_map_partial(pcms, rom_memory, 3653632, true);
> +        }
>      } else {
>          if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>              /*
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


