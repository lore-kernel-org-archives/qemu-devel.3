Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C79C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg69N-0002K4-OD; Fri, 01 Mar 2024 11:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg69M-0002Jg-2A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rg69K-0008O9-BH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709312057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rvG1AaFU2bUdSoiZFVOefK0Fv+7syIEDMEeScnqZOi4=;
 b=WRDQKBhM2e3PmnabPDsXLsHjyR2kcSQ/lUKq9ZbjqA3sVAIii+y7QJLAbETw38WLxI7ZID
 UKSpaRIzrlb/VJ8PyAnNV5PPxuJZl6lC//vEKTbPM6ddiJMYNwF0d6DGAocqsDYbRSWk1i
 tfbrH9ZhFcYbX/jS78GYpmOdXLU312c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-f7N3-wx5ONirw4IcQSt7NA-1; Fri, 01 Mar 2024 11:54:14 -0500
X-MC-Unique: f7N3-wx5ONirw4IcQSt7NA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D1F84AE47;
 Fri,  1 Mar 2024 16:54:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 022F540C6EBA;
 Fri,  1 Mar 2024 16:54:09 +0000 (UTC)
Date: Fri, 1 Mar 2024 16:54:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 6/9] i386/pc: Skip initialization of system FW when using
 IGVM
Message-ID: <ZeIIMOu8_lBd622x@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 02:50:12PM +0000, Roy Hopkins wrote:
> When using an IGVM file the configuration of the system firmware is
> defined by IGVM directives contained in the file. Therefore the default
> system firmware should not be initialized when an IGVM file has been
> provided.
> 
> This commit checks to see if an IGVM file has been provided and, if it
> has then the standard system firmware initialization is skipped and any
> prepared flash devices are cleaned up.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  hw/i386/pc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8eb684a49..17bb211708 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -63,6 +63,7 @@
>  #include "e820_memory_layout.h"
>  #include "trace.h"
>  #include CONFIG_DEVICES
> +#include "exec/confidential-guest-support.h"
>  
>  #ifdef CONFIG_XEN_EMU
>  #include "hw/xen/xen-legacy-backend.h"
> @@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
>          }
>      }
>  
> -    /* Initialize PC system firmware */
> -    pc_system_firmware_init(pcms, rom_memory);
> +    /*
> +     * If this is a confidential guest configured using IGVM then the IGVM
> +     * configuration will include the system firmware. In this case do not
> +     * initialise PC system firmware.
> +     */
> +    if (!cgs_is_igvm(machine->cgs)) {
> +        /* Initialize PC system firmware */
> +        pc_system_firmware_init(pcms, rom_memory);
> +    }

If the user has given explicit pflash config I think we should be
reporting an error for the invalid configuration, rather than
silently ignoring their mistake.

>  
>      option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>      memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


