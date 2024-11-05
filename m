Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0071BD12678
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Gem-0004qh-QT; Tue, 05 Nov 2024 05:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8Gef-0004qQ-CN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8Gec-0001BC-Pf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730801956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6ZC6370UWBg4YtvmjDXxHcFg+06eNs7J9tIqjeHqP8g=;
 b=bxL5cy7OFO5lKAbzMYv1mJKfjY4VsZ8EmF1/yj5xJ5USV0Ed5x/lmZHMe2pU8/lfVehPEJ
 JQmwSzk/K2wy2EVd9ApYhJpBbUejgl2i9E8r3tx6QUEIwe6LqUvZcdYWIjbnA6CK70JiaG
 hzEmhrQkAw3hsWj3htqrBfo2tbNGbCc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-1tYzfYwlP-2I4FZ3zui1uA-1; Tue,
 05 Nov 2024 05:19:10 -0500
X-MC-Unique: 1tYzfYwlP-2I4FZ3zui1uA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF8CA19560AF; Tue,  5 Nov 2024 10:19:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0138E19560A3; Tue,  5 Nov 2024 10:18:59 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:18:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 02/60] i386: Introduce tdx-guest object
Message-ID: <ZynxD6crcL5Qouhe@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-3-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 01:23:10AM -0500, Xiaoyao Li wrote:
> Introduce tdx-guest object which inherits X86_CONFIDENTIAL_GUEST,
> and will be used to create TDX VMs (TDs) by
> 
>   qemu -machine ...,confidential-guest-support=tdx0	\
>        -object tdx-guest,id=tdx0
> 
> It has one QAPI member 'attributes' defined, which allows user to set
> TD's attributes directly.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Chanegs in v6:
>  - Make tdx-guest inherits X86_CONFIDENTIAL_GUEST;
>  - set cgs->require_guest_memfd;
>  - allow attributes settable via QAPI;
>  - update QAPI version to since 9.2;
> 
> Changes in v4:
>  - update the new qapi `since` filed from 8.2 to 9.0
> 
> Changes in v1
>  - make @attributes not user-settable
> ---
>  configs/devices/i386-softmmu/default.mak |  1 +
>  hw/i386/Kconfig                          |  5 +++
>  qapi/qom.json                            | 15 ++++++++
>  target/i386/kvm/meson.build              |  2 ++
>  target/i386/kvm/tdx.c                    | 45 ++++++++++++++++++++++++
>  target/i386/kvm/tdx.h                    | 19 ++++++++++
>  6 files changed, 87 insertions(+)
>  create mode 100644 target/i386/kvm/tdx.c
>  create mode 100644 target/i386/kvm/tdx.h
> 
> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
> index 4faf2f0315e2..bc0479a7e0a3 100644
> --- a/configs/devices/i386-softmmu/default.mak
> +++ b/configs/devices/i386-softmmu/default.mak
> @@ -18,6 +18,7 @@
>  #CONFIG_QXL=n
>  #CONFIG_SEV=n
>  #CONFIG_SGA=n
> +#CONFIG_TDX=n
>  #CONFIG_TEST_DEVICES=n
>  #CONFIG_TPM_CRB=n
>  #CONFIG_TPM_TIS_ISA=n
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 32818480d263..86bc10377c4f 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -10,6 +10,10 @@ config SGX
>      bool
>      depends on KVM
>  
> +config TDX
> +    bool
> +    depends on KVM
> +
>  config PC
>      bool
>      imply APPLESMC
> @@ -26,6 +30,7 @@ config PC
>      imply QXL
>      imply SEV
>      imply SGX
> +    imply TDX
>      imply TEST_DEVICES
>      imply TPM_CRB
>      imply TPM_TIS_ISA
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 321ccd708ad1..129b25edf495 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1008,6 +1008,19 @@
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool' } }
>  
> +##
> +# @TdxGuestProperties:
> +#
> +# Properties for tdx-guest objects.
> +#
> +# @attributes: The 'attributes' of a TD guest that is passed to
> +#     KVM_TDX_INIT_VM
> +#
> +# Since: 9.2
> +##

Since QEMU soft-freeze for 9.2 is today, you've missed the
boat for that. Please update any version tags in this series
to 10.0, which is the first release of next year.

> +{ 'struct': 'TdxGuestProperties',
> +  'data': { '*attributes': 'uint64' } }
> +
>  ##
>  # @ThreadContextProperties:
>  #
> @@ -1092,6 +1105,7 @@
>      'sev-snp-guest',
>      'thread-context',
>      's390-pv-guest',
> +    'tdx-guest',
>      'throttle-group',
>      'tls-creds-anon',
>      'tls-creds-psk',
> @@ -1163,6 +1177,7 @@
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
>        'sev-snp-guest':              'SevSnpGuestProperties',
> +      'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',
> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> index 3996cafaf29f..466bccb9cb17 100644
> --- a/target/i386/kvm/meson.build
> +++ b/target/i386/kvm/meson.build
> @@ -8,6 +8,8 @@ i386_kvm_ss.add(files(
>  
>  i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>  
> +i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
> +
>  i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
>  
>  i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> new file mode 100644
> index 000000000000..166f53d2b9e3
> --- /dev/null
> +++ b/target/i386/kvm/tdx.c
> @@ -0,0 +1,45 @@
> +/*
> + * QEMU TDX support
> + *
> + * Copyright Intel
> + *
> + * Author:
> + *      Xiaoyao Li <xiaoyao.li@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory

FYI, since KVM Forum we decided that we would prefer newly
created files to just use SPDX tags for license info.

> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object_interfaces.h"
> +
> +#include "tdx.h"
> +
> +/* tdx guest */
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
> +                                   tdx_guest,
> +                                   TDX_GUEST,
> +                                   X86_CONFIDENTIAL_GUEST,
> +                                   { TYPE_USER_CREATABLE },
> +                                   { NULL })
> +
> +static void tdx_guest_init(Object *obj)
> +{
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    cgs->require_guest_memfd = true;
> +    tdx->attributes = 0;
> +
> +    object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +}
> +
> +static void tdx_guest_finalize(Object *obj)
> +{
> +}
> +
> +static void tdx_guest_class_init(ObjectClass *oc, void *data)
> +{
> +}
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> new file mode 100644
> index 000000000000..de687457cae6
> --- /dev/null
> +++ b/target/i386/kvm/tdx.h
> @@ -0,0 +1,19 @@
> +#ifndef QEMU_I386_TDX_H
> +#define QEMU_I386_TDX_H

Missing license info.

> +
> +#include "confidential-guest.h"
> +
> +#define TYPE_TDX_GUEST "tdx-guest"
> +#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
> +
> +typedef struct TdxGuestClass {
> +    X86ConfidentialGuestClass parent_class;
> +} TdxGuestClass;
> +
> +typedef struct TdxGuest {
> +    X86ConfidentialGuest parent_obj;
> +
> +    uint64_t attributes;    /* TD attributes */
> +} TdxGuest;
> +
> +#endif /* QEMU_I386_TDX_H */
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


