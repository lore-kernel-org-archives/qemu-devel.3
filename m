Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089A8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkF3-000091-Ja; Mon, 24 Jun 2024 10:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkF2-00006D-6g
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkF0-0007IT-6m
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719237617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mLHfDXKSrKqhYh3f8aFtZIchb/9IE+gQujYLkVmzn0o=;
 b=Su/1T4Rgws34URoux4ruvsoVb52YecXQg0AmL4dfuPiyz76VyLAwmip90mpSwl0U7HnP7z
 4hdeb2/bnXaDoN6X36EqByQxpLc0WSf7yRMMDkz/r/UGxMi8bakxf9jcmM6l2uJGA7sVCp
 /O/OOZ1XKHAJHd+l57aMt44+rYtYKSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-VcvCVBVUOBe5Xsppqcuk1w-1; Mon,
 24 Jun 2024 10:00:13 -0400
X-MC-Unique: VcvCVBVUOBe5Xsppqcuk1w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A2B19560A3; Mon, 24 Jun 2024 14:00:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95FB31956051; Mon, 24 Jun 2024 14:00:05 +0000 (UTC)
Date: Mon, 24 Jun 2024 15:00:02 +0100
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
Subject: Re: [PATCH v3 04/15] hw/core/machine: Add igvm-cfg object and
 processing for IGVM files
Message-ID: <Znl74gNWUQQxR_oE@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1b2fe6b03cba51f2f64c899163b9a0b7eea35b47.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b2fe6b03cba51f2f64c899163b9a0b7eea35b47.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 21, 2024 at 03:29:07PM +0100, Roy Hopkins wrote:
> An IGVM file contains configuration of guest state that should be
> applied during configuration of the guest, before the guest is started.
> 
> This patch allows the user to add an igvm-cfg object to the machine
> configuration that allows an IGVM file to be configured that will be
> applied to the guest before it is started.
> 
> If an IGVM configuration is provided then the IGVM file is processed at
> the end of the board initialization, before the state transition to
> PHASE_MACHINE_INITIALIZED.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  include/hw/boards.h |  2 ++
>  hw/core/machine.c   | 20 ++++++++++++++++++++
>  qemu-options.hx     | 25 +++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 73ad319d7d..4c1484ba0b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -4,6 +4,7 @@
>  #define HW_BOARDS_H
>  
>  #include "exec/memory.h"
> +#include "sysemu/igvm-cfg.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/blockdev.h"
>  #include "qapi/qapi-types-machine.h"
> @@ -382,6 +383,7 @@ struct MachineState {
>      bool suppress_vmdesc;
>      bool enable_graphics;
>      ConfidentialGuestSupport *cgs;
> +    IgvmCfgState *igvm;
>      HostMemoryBackend *memdev;
>      /*
>       * convenience alias to ram_memdev_id backend memory region
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 655d75c21f..f9f879172c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1094,6 +1094,16 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "confidential-guest-support",
>                                            "Set confidential guest scheme to support");
>  
> +#if defined(CONFIG_IGVM)
> +    object_class_property_add_link(oc, "igvm-cfg",
> +                                   TYPE_IGVM_CFG,
> +                                   offsetof(MachineState, igvm),
> +                                   object_property_allow_set_link,
> +                                   OBJ_PROP_LINK_STRONG);
> +    object_class_property_set_description(oc, "igvm-cfg",
> +                                          "Set IGVM configuration");
> +#endif
> +
>      /* For compatibility */
>      object_class_property_add_str(oc, "memory-encryption",
>          machine_get_memory_encryption, machine_set_memory_encryption);
> @@ -1582,6 +1592,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>  
>      accel_init_interfaces(ACCEL_GET_CLASS(machine->accelerator));
>      machine_class->init(machine);
> +
> +#if defined(CONFIG_IGVM)
> +    /* Apply guest state from IGVM if supplied */
> +    if (machine->igvm) {
> +        if (IGVM_CFG_GET_CLASS(machine->igvm)
> +                ->process(machine->igvm, machine->cgs, &error_abort) == -1) {

Perhaps use error_fatal rather than error_abort, since failures here are
more likely to be user errors (incompatible igvm config), rather than QEMU
programmer bugs.

> +            return;
> +        }
> +    }
> +#endif
>      phase_advance(PHASE_MACHINE_INITIALIZED);
>  }
>  

This adds igvm-cfg for all machines, regardless of architecture target.

Are igvm files fully cross-platform portable, or should we just put
this into the TYPE_X86_MACHINE base class to limit it ?

It at least reports errors if I try to load an IGVM file with
qemu-system-aarch64 + virt type

$ ./build/qemu-system-aarch64 -object igvm-cfg,file=../buildigvm/ovmf-sev.igvm,id=igvm -machine virt,igvm-cfg=igvm
qemu-system-aarch64: IGVM file does not describe a compatible supported platform

so that's good.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


