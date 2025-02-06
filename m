Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE77C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxfS-0001SQ-6Z; Thu, 06 Feb 2025 03:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfxfD-0001PA-3s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfxf8-0002q4-Mt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738832104;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7DMP8RCz4MtWOgriPg2r75pBWlGZv8A4jVtyT4iTTM=;
 b=KzlikL7NligxBy+tws/ONDnB7zjv0AvcY2IMjglF+XQIZRGGjvdtY/GLqP1xzsms/HwQDB
 KT8WEqhVV0Vr9DYb+wh3Fn80cqrUN0GpaW0eTEVgUJl2+dUs7LHqkHC6EIPZF9rJSalD/M
 HIMHg79uXqGSpkMxNaSHnpFoeqq2wfE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-tJbHVk_wPJapAgkX5lJ0Nw-1; Thu,
 06 Feb 2025 03:54:58 -0500
X-MC-Unique: tJbHVk_wPJapAgkX5lJ0Nw-1
X-Mimecast-MFC-AGG-ID: tJbHVk_wPJapAgkX5lJ0Nw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C70941955DDD; Thu,  6 Feb 2025 08:54:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9027D1800570; Thu,  6 Feb 2025 08:54:50 +0000 (UTC)
Date: Thu, 6 Feb 2025 08:54:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: eric.auger@redhat.com, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6R41tYpGR-mofbT@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
 <20250131142404.GP5556@nvidia.com>
 <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
 <20250131145411.GR5556@nvidia.com>
 <20039bbc40df453a8a41a863d74b9ff9@huawei.com>
 <c292ab40-3620-4e72-b043-4e3cbd7fd297@redhat.com>
 <5709592d-cd1c-4894-a1d4-c0c4c61a2e07@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5709592d-cd1c-4894-a1d4-c0c4c61a2e07@nvidia.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 05, 2025 at 12:53:42PM -0800, Nathan Chen wrote:
> 
> 
> On 1/31/2025 8:08 AM, Eric Auger wrote:
> > > > > > > And Qemu does some checking to make sure that the device is indeed
> > > > > > associated
> > > > > > > with the specified phys-smmuv3.  This can be done going through the
> > > > > > sysfs path checking
> > > > > > > which is what I guess libvirt is currently doing to populate the
> > > > topology.
> > > > > > So basically
> > > > > > > Qemu is just replicating that to validate again.
> > > > > > I would prefer that iommufd users not have to go out to sysfs..
> > > > > > 
> > > > > > > Or another option is extending the IOMMU_GET_HW_INFO IOCTL to
> > > > > > return the phys
> > > > > > > smmuv3 base address which can avoid going through the sysfs.
> > > > > > It also doesn't seem great to expose a physical address. But we could
> > > > > > have an 'iommu instance id' that was a unique small integer?
> > > > > Ok. But how the user space can map that to the device?
> > > > Why does it need to?
> > > > 
> > > > libvirt picks some label for the vsmmu instance, it doesn't matter
> > > > what the string is.
> > > > 
> > > > qemu validates that all of the vsmmu instances are only linked to PCI
> > > > device that have the same iommu ID. This is already happening in the
> > > > kernel, it will fail attaches to mismatched instances.
> > > > 
> > > > Nothing further is needed?
> > > -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> > > -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> > > -device arm-smmuv3-accel,bus=pcie.1,id=smmuv1 \
> > I don't get what is the point of adding such an id if it is not
> > referenced anywhere?
> > 
> > Eric
> 
> Daniel mentions that the host-to-guest SMMU pairing must be chosen such that
> it makes conceptual sense w.r.t. the guest NUMA to host NUMA pairing [0].
> The current implementation allows for incorrect host to guest numa node
> pairings, e.g. pSMMU has affinity to host numa node 0, but it’s paired with
> a vSMMU paired with a guest numa node pinned to host numa node 1.
> 
> By specifying the host SMMU id, we can explicitly pair a host SMMU with a
> guest SMMU associated with the correct PXB NUMA node, vs. implying the
> host-to-guest SMMU pairing based on what devices are attached to the PXB.
> While it would not completely prevent the incorrect pSMMU/vSMMU pairing
> w.r.t. host to guest numa node pairings, specifying the pSMMU id would make
> the implications of host to guest numa node pairings more clear when
> specifying a vSMMU instance.

You've not specified any host SMMU id in the above CLI args though,
only the PXB association.

It needs something like

 -device arm-smmuv3-accel,bus=pcie.1,id=smmuv1,host-smmu=XXXXX

where 'XXXX' is some value to identify the host SMMU

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


