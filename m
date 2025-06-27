Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E85C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 07:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV3Jj-0004yD-K9; Fri, 27 Jun 2025 03:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uV3Jh-0004xu-Kg
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 03:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uV3Ja-0001UZ-5a
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751008559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUX86QuLkGfEhzHI3W2THyEIAS6wLpO8cXysEh9kOCU=;
 b=hxmMCboCgfv3+qH7mNkXfhFUEAMlr4Fvj/rghtdf4bGgUI2uWZpquUCq9coAx4VOlWbsd4
 geJ7gdXq3XmBE6fGaWD2E/GN/qfhoaf0WSb9ndLBZHQJxTDOb9MXyVRz8Vkt1GwtUMobfn
 37YwJxefOxuFk3RIY1ZR004iePew8BM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-tZyOmKDYPjqTFiE8l8QesA-1; Fri,
 27 Jun 2025 03:15:55 -0400
X-MC-Unique: tZyOmKDYPjqTFiE8l8QesA-1
X-Mimecast-MFC-AGG-ID: tZyOmKDYPjqTFiE8l8QesA_1751008553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 501AB1955F38; Fri, 27 Jun 2025 07:15:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA01C180035C; Fri, 27 Jun 2025 07:15:47 +0000 (UTC)
Date: Fri, 27 Jun 2025 08:15:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
Message-ID: <aF5FD-mvsh5-eMcX@redhat.com>
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
 <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
 <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
 <0d59875a-88a0-41f2-99d4-4e7a19de0e14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d59875a-88a0-41f2-99d4-4e7a19de0e14@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 27, 2025 at 01:37:55PM +0800, Shaoqin Huang wrote:
> Hi Eric,
> 
> On 6/26/25 4:01 PM, Eric Auger wrote:
> > 
> > 
> > On 6/26/25 4:05 AM, Shaoqin Huang wrote:
> > > Hi Eric,
> > > 
> > > On 6/23/25 5:20 PM, Eric Auger wrote:
> > > > 
> > > > 
> > > > On 6/17/25 5:05 AM, Shaoqin Huang wrote:
> > > > > Set the "use-legacy-x86-rom" property to false by default, and only set
> > > > > it to true on x86 since only x86 will need it.
> > > > s/compatatibility/compatibility in the title
> > > 
> > > Ok. Will fix it.
> > > 
> > > > > 
> > > > > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > > > > ---
> > > > >    hw/display/ramfb-standalone.c | 2 +-
> > > > >    hw/i386/pc_q35.c              | 3 +++
> > > > >    hw/vfio/pci.c                 | 2 +-
> > > > >    3 files changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-
> > > > > standalone.c
> > > > > index af1175bf96..ddbf42f181 100644
> > > > > --- a/hw/display/ramfb-standalone.c
> > > > > +++ b/hw/display/ramfb-standalone.c
> > > > > @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
> > > > >      static const Property ramfb_properties[] = {
> > > > >        DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,
> > > > > true),
> > > > > -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
> > > > > use_legacy_x86_rom, true),
> > > > > +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
> > > > > use_legacy_x86_rom, false),
> > > > >    };
> > > > >      static void ramfb_class_initfn(ObjectClass *klass, void *data)
> > > > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > > > index fd96d0345c..f6d89578d0 100644
> > > > > --- a/hw/i386/pc_q35.c
> > > > > +++ b/hw/i386/pc_q35.c
> > > > > @@ -45,6 +45,7 @@
> > > > >    #include "hw/i386/pc.h"
> > > > >    #include "hw/i386/amd_iommu.h"
> > > > >    #include "hw/i386/intel_iommu.h"
> > > > > +#include "hw/vfio/pci.h"
> > > > >    #include "hw/virtio/virtio-iommu.h"
> > > > >    #include "hw/display/ramfb.h"
> > > > >    #include "hw/ide/pci.h"
> > > > > @@ -67,6 +68,8 @@
> > > > >      static GlobalProperty pc_q35_compat_defaults[] = {
> > > > >        { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
> > > > > +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> > > > > +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
> > > > this will only keep the legacy behavior along with q35 machine type but
> > > > not on other machines being used for x86. what about pc-i440fx? Doesn't
> > > > it apply to it as well? Are there other machine types also impacted.
> > > 
> > > Ok I will also add it with pc-i440fx. I think only q35 and i440fx are
> > > impacted.
> > > 
> > > > 
> > > > Also what about Daniel's comment in v3:
> > > > https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
> > > > "For non-x86, historical versioned machine types will need
> > > > likely it set to true, in order to avoid the memory layout
> > > > being changed IIUC."
> > > > 
> > > > Is it actually needed?
> > > 
> > > If those machine types need to set it to true. I think they can set it
> > > after they have this property.
> > nope it does not work like that. In case we really need to take care of
> > this, this must be handled by compats.
> 
> If so. Why don't we still keep the "use-legacy-x86-rom" default to true, and
> only set it to false to those arch which doesn't need it just like my
> original implementation.
> 
> Because I don't really know how other arch's memoery layout was impacted by
> this property set to false. I think keep their original behavior and only
> change it on arm64 is a good idea.
> 
> How do you think about it?

No, the default value of the property shoudl reflect the long
term desired behaviour - in this case 'use-legacy-x86-rom = false'.

We must then reverse this default to 'true' for ALL historical versioned
machine types on ALL architectures, where this device is built, or any
specific machines where we want to keep the historical behaviour going
forward.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


