Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C62C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 12:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9Ze-00058N-LZ; Thu, 05 Jun 2025 08:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uN9ZV-00057X-1i
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uN9ZK-0002ZH-Bu
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 08:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749125976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P15UNYtaWqC98xkia4uszjquNEcwMlFZgR/PvlOmpIk=;
 b=gS90AynjZnXIc88szqiraHXdg/QZdYrCLGy24fCwv76kXCTiHfVp/maqvvitvXxKOLdLy0
 gdJL4XfhQMkKerkIyEjecSDJdD/gE56/uAmaUWizR1CIMkFrFaK/bS2XbMEeKgTub0Xfnj
 dS8memT33b8IHo/vXbB1kDXSNpSG/OM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ZkvD3wLjPZ-zI2hQrHodmA-1; Thu, 05 Jun 2025 08:19:35 -0400
X-MC-Unique: ZkvD3wLjPZ-zI2hQrHodmA-1
X-Mimecast-MFC-AGG-ID: ZkvD3wLjPZ-zI2hQrHodmA_1749125974
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so516794f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 05:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749125974; x=1749730774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P15UNYtaWqC98xkia4uszjquNEcwMlFZgR/PvlOmpIk=;
 b=daoKKU3Yx8NEDO03xCznLY17C0l2Xz4+wwA3u3pi6rDxeY0DvDlYVt1IRLHsW7cGye
 R+lM3WgIiU7KiZ5V5mx8b8kKVdYN0Yqss4K2iXaBj/XrypK1q+4IPQgCTPvVhz2ezZY1
 r8dni6sodbFksiZfVmtYJXPeaik4NipnSokrGAZJuKlaZfkSvkwJqLx2eqsnU1ZtVcpE
 vNqoWyY5b3S4WPDJ48viO10a+wqr07iWszDZ9m3WkaMNUiIKxxxODOa3mIezB1lKixQb
 gkgLjaIRzwOjVrDtTt0eb1sYdxgh+i+mSDirvsi5+YNNNkl11Me6bYpphU4QhHYCZWy4
 3m2g==
X-Gm-Message-State: AOJu0Yw/3hhUKutzCAThwWIbEsnfCOV+SKZC6AEdnB1RBytB//beCLfH
 nTLYK1u9AfjrzeN/AGI+93r1CpKidwtAlOfGbdirFgeZVqieU6S/7/qYgWoAlO7UiLQpkpHeGNI
 SbaeugeO8yR9nxHvuNMlKSO0wVwE4YXOSGONBheeOv+6sKu2ixSaVp/33
X-Gm-Gg: ASbGncsW5dZRZY0HCeJlvk9ndtpDyi6tmdYWoDZZEg0TjCIRV5DPahJiR8yd9v0KJBJ
 ugBViR4KHVjvcBHF4nFXLuGFI/4VGnzECRSg1bNRbu5NK2LAH7HOu0Ax9Eb2Dgr13KE8dEUkE6H
 W9DOnFvs/GBGzTSGiJhu475X1biYZyOLB3BOEkFVDFNNRWe69B/DxWktG8kQrroLwTff07cFA4h
 k7qIUuQ7suaGEPtA1ihV5YyoPFm7+W9yrK4PonPtaOf9li9/OK/bJ9WwU8qdWgLHPFHU/P9Ueio
 1myQyPwd2DfhG1Ao0PcE0mu9tcCUTt3Z
X-Received: by 2002:a05:6000:144e:b0:3a4:f607:a5ad with SMTP id
 ffacd0b85a97d-3a526e0cc7bmr3033432f8f.19.1749125973760; 
 Thu, 05 Jun 2025 05:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElML9sr2srhmhIUCJyt2TvAU18mUm8eQ1A0TpG0YrurUY5t7NbyXej345Qgd2WdlEDUPqhGw==
X-Received: by 2002:a05:6000:144e:b0:3a4:f607:a5ad with SMTP id
 ffacd0b85a97d-3a526e0cc7bmr3033406f8f.19.1749125973382; 
 Thu, 05 Jun 2025 05:19:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe740bbsm24463605f8f.54.2025.06.05.05.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 05:19:32 -0700 (PDT)
Date: Thu, 5 Jun 2025 14:19:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
 Complex association
Message-ID: <20250605141931.1704c6a5@imammedo.users.ipa.redhat.com>
In-Reply-To: <065bbd4ee15442b58e15b298614cf5dd@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
 <20250605125518.138f5172@imammedo.users.ipa.redhat.com>
 <065bbd4ee15442b58e15b298614cf5dd@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 5 Jun 2025 11:29:59 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Thursday, June 5, 2025 11:55 AM
> > To: Shameer Kolothum via <qemu-devel@nongnu.org>
> > Cc: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> > nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
> > nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
> > Complex association
> > 
> > On Mon, 2 Jun 2025 16:41:05 +0100
> > Shameer Kolothum via <qemu-devel@nongnu.org> wrote:
> >   
> > > Although this change does not affect functionality at present, it is
> > > required when we add support for user-creatable SMMUv3 devices in
> > > future patches.
> > >
> > > Signed-off-by: Shameer Kolothum  
> > <shameerali.kolothum.thodi@huawei.com>  
> > > ---
> > >  hw/arm/smmuv3.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > > index ab67972353..7e934336c2 100644
> > > --- a/hw/arm/smmuv3.c
> > > +++ b/hw/arm/smmuv3.c
> > > @@ -24,6 +24,7 @@
> > >  #include "hw/qdev-properties.h"
> > >  #include "hw/qdev-core.h"
> > >  #include "hw/pci/pci.h"
> > > +#include "hw/pci/pci_bridge.h"
> > >  #include "cpu.h"
> > >  #include "exec/target_page.h"
> > >  #include "trace.h"
> > > @@ -1881,6 +1882,13 @@ static void smmu_realize(DeviceState *d, Error  
> > **errp)  
> > >      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
> > >      SysBusDevice *dev = SYS_BUS_DEVICE(d);
> > >      Error *local_err = NULL;
> > > +    Object *bus;
> > > +
> > > +    bus = object_property_get_link(OBJECT(d), "primary-bus",  
> > &error_abort);
> > I'd replace this with direct field access like in smmu_base_realize  
> 
> Ok.
>  
> > in QEMU with PCI, usually we specify bus to attach to with 'bus' property,
> > wouldn't it better to rename "primary-bus" to 'bus' to be consistent with
> > the rest of PCI code (and before "primary-bus" shows up as a CLI option,
> > so far (before this series) it looks like it's an internal property)?  
> 
> That was tried in v2 and since SMMUv3 is not a pci device by itself(it is a 
> sysbus device) reusing the default "bus" property to establish an association
> with a PCI bus created problems,
> https://lore.kernel.org/qemu-devel/877c2ut0zk.fsf@pond.sub.org/

that was an approach was trying to workaround by patching dc->bus_type,
which is obviously wrong.

I'm not talking about changing device type or something similar,
but about renaming 'primary-bus' property name to 'bus'
so it would be consistent interface wise with PCI or other QEMU devices
that are attached to a bus.

> > > +    if (!bus || !object_dynamic_cast(bus->parent,  
> > TYPE_PCI_HOST_BRIDGE)) {
> > Also looking at smmu_base_realize, it has NULL pointer check already.
> > Which also rises question, shouldn't smmu_base_realize check for
> > TYPE_PCI_HOST_BRIDGE as well (aka can smmu be attached to anything
> > else but a host bridge)?  
> 
> Not at the moment in Qemu. Though the SMMUv3 specification allows it to
> be associated with non-pci devices as well.

then perhaps move, the check to smmu_base_realize() for now?

if smmu + non-pci ever materialize, it can be refactored at that time. 
 
> Thanks,
> Shameer
> 


