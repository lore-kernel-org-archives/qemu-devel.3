Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF4AC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfTt-0007Gq-5s; Wed, 24 Jul 2024 13:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfTr-0007Fz-OV
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWfTn-0007JI-6L
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721840920;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5Jr5u+b0bzeOndNhfttyAnz118n/aU6K0UsPc/Z9H4g=;
 b=J8c8MKqysA7SJE7VgJvUEWwEQ4+U1lsUkwGgPWft6kyAdlqeb37Np8oZ4mfmTgGBiO89Dm
 ZRJF5uh4nNtyESle5YGtB9S0XSfnd2aZxJp/7lqxjE5tEBs9Yxyowb6naS234QFNdSgL8n
 x+/UiELCK13zyEIIw0qlCgB4Fy1XGTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-9cjdErXTN8CZw4dYb1tEAw-1; Wed,
 24 Jul 2024 13:08:37 -0400
X-MC-Unique: 9cjdErXTN8CZw4dYb1tEAw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 719A51944A84; Wed, 24 Jul 2024 17:08:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B192D19560AE; Wed, 24 Jul 2024 17:08:28 +0000 (UTC)
Date: Wed, 24 Jul 2024 18:08:24 +0100
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
Subject: Re: [PATCH v4 04/17] hw/i386: Add igvm-cfg object and processing for
 IGVM files
Message-ID: <ZqE1CF0nhvE9vQ5G@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <f8cd2ee02a96d48ce835a552b5a31c2cc63790fc.1720004383.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8cd2ee02a96d48ce835a552b5a31c2cc63790fc.1720004383.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Jul 03, 2024 at 12:05:42PM +0100, Roy Hopkins wrote:
> An IGVM file contains configuration of guest state that should be
> applied during configuration of the guest, before the guest is started.
> 
> This patch allows the user to add an igvm-cfg object to an X86 machine
> configuration that allows an IGVM file to be configured that will be
> applied to the guest before it is started.
> 
> If an IGVM configuration is provided then the IGVM file is processed at
> the end of the board initialization, before the state transition to
> PHASE_MACHINE_INITIALIZED.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  include/hw/i386/x86.h |  3 +++
>  hw/i386/pc.c          | 12 ++++++++++++
>  hw/i386/pc_piix.c     | 10 ++++++++++
>  hw/i386/pc_q35.c      | 10 ++++++++++
>  qemu-options.hx       | 25 +++++++++++++++++++++++++
>  5 files changed, 60 insertions(+)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index d43cb3908e..4abe3afaba 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -25,6 +25,7 @@
>  #include "hw/intc/ioapic.h"
>  #include "hw/isa/isa.h"
>  #include "qom/object.h"
> +#include "sysemu/igvm-cfg.h"
>  
>  struct X86MachineClass {
>      /*< private >*/
> @@ -97,6 +98,8 @@ struct X86MachineState {
>       * which means no limitation on the guest's bus locks.
>       */
>      uint64_t bus_lock_ratelimit;
> +
> +    IgvmCfgState *igvm;
>  };
>  
>  #define X86_MACHINE_SMM              "smm"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 77415064c6..03d29e9e48 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1825,6 +1825,18 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "fd-bootchk",
>          pc_machine_get_fd_bootchk,
>          pc_machine_set_fd_bootchk);
> +
> +#if defined(CONFIG_IGVM)
> +    object_class_property_add_link(oc, "igvm-cfg",
> +                                   TYPE_IGVM_CFG,
> +                                   offsetof(X86MachineState, igvm),
> +                                   object_property_allow_set_link,
> +                                   OBJ_PROP_LINK_STRONG);
> +    object_class_property_set_description(oc, "igvm-cfg",
> +                                          "Set IGVM configuration");
> +#endif
> +
> +
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9445b07b4f..d537dd50fb 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -365,6 +365,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>                                 x86_nvdimm_acpi_dsmio,
>                                 x86ms->fw_cfg, OBJECT(pcms));
>      }
> +
> +#if defined(CONFIG_IGVM)
> +    /* Apply guest state from IGVM if supplied */
> +    if (x86ms->igvm) {
> +        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> +                ->process(x86ms->igvm, machine->cgs, &error_fatal) == -1) {
> +            return;

g_assert_not_reached() instead of return, since &error_fatal should
ensure we never get this far.  Also suggest "< 0" rather than "== -1"
as the more common QEMU pattern.

> +        }
> +    }
> +#endif
>  }
>  
>  typedef enum PCSouthBridgeOption {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 71d3c6d122..d4d66be5a5 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -329,6 +329,16 @@ static void pc_q35_init(MachineState *machine)
>                                 x86_nvdimm_acpi_dsmio,
>                                 x86ms->fw_cfg, OBJECT(pcms));
>      }
> +
> +#if defined(CONFIG_IGVM)
> +    /* Apply guest state from IGVM if supplied */
> +    if (x86ms->igvm) {
> +        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> +                ->process(x86ms->igvm, machine->cgs, &error_fatal) == -1) {
> +            return;

Same note as for piix above.

> +        }
> +    }
> +#endif
>  }
>  
>  #define DEFINE_Q35_MACHINE(major, minor) \
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0..fd36390416 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5719,6 +5719,31 @@ SRST
>                   -machine ...,memory-encryption=sev0 \\
>                   .....
>  
> +    ``-object igvm-cfg,file=file``
> +        Create an IGVM configuration object that defines the initial state
> +        of the guest using a file in that conforms to the Independent Guest
> +        Virtual Machine (IGVM) file format.
> +
> +        The ``file`` parameter is used to specify the IGVM file to load.
> +        When provided, the IGVM file is used to populate the initial
> +        memory of the virtual machine and, depending on the platform, can
> +        define the initial processor state, memory map and parameters.
> +
> +        The IGVM file is expected to contain the firmware for the virtual
> +        machine, therefore an ``igvm-cfg`` object cannot be provided along
> +        with other ways of specifying firmware, such as the ``-bios``
> +        parameter on x86 machines.
> +
> +        e.g to launch a machine providing the firmware in an IGVM file
> +
> +        .. parsed-literal::
> +
> +             # |qemu_system_x86| \\
> +                 ...... \\
> +                 -object igvm-cfg,id=igvm0,file=bios.igvm \\
> +                 -machine ...,igvm-cfg=igvm0 \\
> +                 .....
> +
>      ``-object authz-simple,id=id,identity=string``
>          Create an authorization object that will control access to
>          network services.
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


