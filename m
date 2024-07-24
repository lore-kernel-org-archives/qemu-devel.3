Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2108C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfYn-0003x8-F5; Wed, 24 Jul 2024 13:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfYh-0003uw-BD
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfYf-0001Vj-6l
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721841222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTj5PhXP1RKnUxaMEJEfE8to1wEGqjRSyCYdXK8vl70=;
 b=jBgIua4PXdKOzcbpU3DyFDPElicHn8M0kblXxDZt+x5TRGdPbwkcN7anzPNrKTM2OWVbGA
 zFmYaIsdq2xuwSsayqxJesLWyWs7rFODMZLPM75o5Eg8vQpCD7OPg1oJ0Et0xH9mKbZH3J
 JWLxQBOD8H+vinINgslwMUHZs1RhZDE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-tyCtaQ4iM3W-LHrMHmLsBg-1; Wed,
 24 Jul 2024 13:13:39 -0400
X-MC-Unique: tyCtaQ4iM3W-LHrMHmLsBg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21E891955D4B; Wed, 24 Jul 2024 17:13:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE153000192; Wed, 24 Jul 2024 17:13:31 +0000 (UTC)
Date: Wed, 24 Jul 2024 18:13:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 05/17] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
Message-ID: <ZqE2N3tXTOMi7dgP@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <c58c4b5cc8a35245b7ef31fefcc67a72e6346a07.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c58c4b5cc8a35245b7ef31fefcc67a72e6346a07.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 03, 2024 at 12:05:43PM +0100, Roy Hopkins wrote:
> When using an IGVM file the configuration of the system firmware is
> defined by IGVM directives contained in the file. In this case the user
> should not configure any pflash devices.
> 
> This commit skips initialization of the ROM mode when pflash0 is not set
> then checks to ensure no pflash devices have been configured when using
> IGVM, exiting with an error message if this is not the case.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ef80281d28..f5e40b3ef6 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -219,7 +219,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>  
>      if (!pcmc->pci_enabled) {
> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
> +        /*
> +         * If an IGVM file is specified then the firmware must be provided
> +         * in the IGVM file.
> +         */
> +        if (!X86_MACHINE(pcms)->igvm) {
> +            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
> +        }

IIUC from looking at x86_bios_rom_init, the 'firmware' machine property
will be NULL if no -bios arg is given, and non-NULL if -bios is set,
so we can give an error message is -bios is set, while doing the right
thing if unset.

IOW I think this could look more like

        X86MachineState *x86ms = X86_MACHINE(pcms);
	if (x86ms->igvm) {
	    if (x86ms->firmware) {
                error_report("Firmware ROM cannot be configured when "
                             "using IGVM");
                exit(1);
	    }
	} else {
            x86_bios_rom_init(x86ms, "bios.bin", rom_memory, true);
        }

>          return;
>      }
>  
> @@ -239,8 +245,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>      }
>  
>      if (!pflash_blk[0]) {
> -        /* Machine property pflash0 not set, use ROM mode */
> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
> +        /*
> +         * Machine property pflash0 not set, use ROM mode unless using IGVM,
> +         * in which case the firmware must be provided by the IGVM file.
> +         */
> +        if (!X86_MACHINE(pcms)->igvm) {
> +            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
> +        }

Same as earlier

>      } else {
>          if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>              /*
> @@ -256,6 +267,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
>      }
>  
>      pc_system_flash_cleanup_unused(pcms);
> +
> +    /*
> +     * The user should not have specified any pflash devices when using IGVM
> +     * to configure the guest.
> +     */
> +    if (X86_MACHINE(pcms)->igvm) {
> +        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +            if (pcms->flash[i]) {
> +                error_report("pflash devices cannot be configured when "
> +                             "using IGVM");
> +                exit(1);
> +            }
> +        }
> +    }
>  }
>  
>  void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


