Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E86D2AB1C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5jky-0000Nh-Lf; Tue, 29 Oct 2024 06:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5jkx-0000NX-Cb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5jkv-0006AM-CI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730198838;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UPqKpRx5HMUdVVVLLpOt3awRChRdkNU4KIJ06L7B8KY=;
 b=L/TfnoYyRyeo8ZJ/jyL9YMRBNZwTRjDqw9/z+CLbps/6DsJF5YUZ0oiku5/rf+VTLwVDa9
 ThLxZxB1e4KrzO4SoV8EmvARe80seHPswxvN+Qd5Aj2BVUIgy4gADh/ZzC3mfvcn2xgtbE
 Ib8iQcf+N3MEFX6nahFl9h8zpSWBgfg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-K5ipStexNUalZyBtMz1zrw-1; Tue,
 29 Oct 2024 06:47:15 -0400
X-MC-Unique: K5ipStexNUalZyBtMz1zrw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AFD01955EEA; Tue, 29 Oct 2024 10:47:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72E1719560AA; Tue, 29 Oct 2024 10:47:08 +0000 (UTC)
Date: Tue, 29 Oct 2024 10:47:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] x86/iommu: Make x86-iommu a singleton object
Message-ID: <ZyC9KsmomvRAP1EP@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024165627.1372621-3-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Oct 24, 2024 at 12:56:25PM -0400, Peter Xu wrote:
> X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> singleton so it guards the system from accidentally create yet another
> IOMMU object when one already presents.
> 
> Now if someone tries to create more than one, e.g., via:
> 
>   ./qemu -M q35 -device intel-iommu -device intel-iommu
> 
> The error will change from:
> 
>   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> 
> To:
> 
>   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> 
> Unfortunately, yet we can't remove the singleton check in the machine
> hook (pc_machine_device_pre_plug_cb), because there can also be
> virtio-iommu involved, which doesn't share a common parent class yet.

Presumably the 'class' reported is the one that the user requested,
but this would imply if we were to do

  qemu-system-x86_64 -device intel-iommu -device virtio-iommu

Then QEMU would report

   "Class 'virtio-iommu' only supports one instance"

at which point the user is wondering, huh, I only requested one virtio-iommu
instance ?

IOW, the current error message would be better as it is not referring to a
specific subclass, but rather to the more general fact that only a single
IOMMU is permitted, no matter what it's impl is.

> 
> But with this, it should be closer to reach that goal to check singleton by
> QOM one day.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/x86-iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 60af896225..4bfeb08705 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -26,6 +26,7 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  #include "sysemu/kvm.h"
> +#include "qom/object_interfaces.h"
>  
>  void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
>                                       iec_notify_fn fn, void *data)
> @@ -133,10 +134,19 @@ static Property x86_iommu_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static Object *x86_iommu_get_instance(Error **errp)
> +{
> +    return OBJECT(x86_iommu_get_default());
> +}
> +
>  static void x86_iommu_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    SingletonClass *singleton = SINGLETON_CLASS(klass);
> +
>      dc->realize = x86_iommu_realize;
> +    singleton->get_instance = x86_iommu_get_instance;
> +
>      device_class_set_props(dc, x86_iommu_properties);
>  }
>  
> @@ -152,6 +162,10 @@ static const TypeInfo x86_iommu_info = {
>      .class_init    = x86_iommu_class_init,
>      .class_size    = sizeof(X86IOMMUClass),
>      .abstract      = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_SINGLETON },
> +        { }
> +    }
>  };
>  
>  static void x86_iommu_register_types(void)
> -- 
> 2.45.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


