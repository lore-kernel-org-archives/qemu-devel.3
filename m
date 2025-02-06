Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43134C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfzGP-0001c9-Jv; Thu, 06 Feb 2025 05:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfzGO-0001bY-5H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfzGM-0001rm-6k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738838256;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwRcckK+8zgNcBJitELOtOH3ui9fvJbiGQAm1rOkKzE=;
 b=HGHLRLDUXKUyjZa50mARLExzOqdL58QeEZ7qbK1PvZRthrfIgvYkiQw+urSPQx7xceYsVK
 G0fr4yanOqxU9BL7Evsmx3p+uKhOh624QmetK0fXtv1nB128lFW5NB1TXqBfYWHifK7TPy
 /npaVB56Qd1xKhXK5jxVwPCxvaTz0Mw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-WyS2MNE3Nr2b8WO3Lne9ww-1; Thu,
 06 Feb 2025 05:37:32 -0500
X-MC-Unique: WyS2MNE3Nr2b8WO3Lne9ww-1
X-Mimecast-MFC-AGG-ID: WyS2MNE3Nr2b8WO3Lne9ww
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7841B19560B7; Thu,  6 Feb 2025 10:37:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B671800872; Thu,  6 Feb 2025 10:37:23 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:37:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6SQ3_5bcqseyzVa@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 06, 2025 at 10:02:25AM +0000, Shameerali Kolothum Thodi wrote:
> Hi Daniel,
> 
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: Friday, January 31, 2025 9:42 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> > nicolinc@nvidia.com; ddutile@redhat.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> > nested SMMUv3
> > 
> > On Thu, Jan 30, 2025 at 06:09:24PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > >
> > > Each "arm-smmuv3-nested" instance, when the first device gets attached
> > > to it, will create a S2 HWPT and a corresponding SMMUv3 domain in
> > kernel
> > > SMMUv3 driver. This domain will have a pointer representing the physical
> > > SMMUv3 that the device belongs. And any other device which belongs to
> > > the same physical SMMUv3 can share this S2 domain.
> > 
> > Ok, so given two guest SMMUv3s,   A and B, and two host SMMUv3s,
> > C and D, we could end up with A&C and B&D paired, or we could
> > end up with A&D and B&C paired, depending on whether we plug
> > the first VFIO device into guest SMMUv3  A or B.
> > 
> > This is bad.  Behaviour must not vary depending on the order
> > in which we create devices.
> > 
> > An guest SMMUv3 is paired to a guest PXB. A guest PXB is liable
> > to be paired to a guest NUMA node. A guest NUMA node is liable
> > to be paired to host NUMA node. The guest/host SMMU pairing
> > must be chosen such that it makes conceptual sense wrt to the
> > guest PXB NUMA to host NUMA pairing.
> > 
> > If the kernel picks guest<->host SMMU pairings on a first-device
> > first-paired basis, this can end up with incorrect guest NUMA
> > configurations.
> 
> Ok. I am trying to understand how this can happen as I assume the
> Guest PXB numa node is picked up by whatever device we are
> attaching to it and based on which numa_id that device belongs to
> in physical host.
> 
> And the physical smmuv3 numa id will be the same to that of the
> device numa_id  it is associated with. Isn't it?
> 
> For example I have a system here, that has 8 phys SMMUv3s and numa
> assignments on this is something like below,
> 
> Phys SMMUv3.0 --> node 0
>   \..dev1 --> node0
> Phys SMMUv3.1 --> node 0
> \..dev2 -->node0
> Phys SMMUv3.2 --> node 0
> Phys SMMUv3.3 --> node 0
> 
> Phys SMMUv3.4 --> node 1
> Phys SMMUv3.5 --> node 1
> \..dev5 --> node1
> Phys SMMUv3.6 --> node 1
> Phys SMMUv3.7 --> node 1
> 
> 
> If I have to assign say dev 1, 2 and 5 to a Guest, we need to specify 3
>  "arm-smmuv3-accel" instances as they belong to different phys SMMUv3s.
> 
> -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_id=0 \
> -device pxb-pcie,id=pcie.2,bus_nr=2,bus=pcie.0,numa_id=0 \
> -device pxb-pcie,id=pcie.3,bus_nr=3,bus=pcie.0,numa_id=1 \
> -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
> -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2 \
> -device arm-smmuv3-accel,id=smmuv3,bus=pcie.3 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.3,chassis=2 \
> -device pcie-root-port,id=pcie.port3,bus=pcie.2,chassis=3 \
> -device vfio-pci,host=0000:dev1,bus=pcie.port1,iommufd=iommufd0 \
> -device vfio-pci,host=0000: dev2,bus=pcie.port2,iommufd=iommufd0 \
> -device vfio-pci,host=0000: dev5,bus=pcie.port3,iommufd=iommufd0
> 
> So I guess even if we don't specify the physical SMMUv3 association
> explicitly, the kernel will check that based on the devices the Guest
> SMMUv3 is attached to (and hence the Numa association), right?

It isn't about checking the devices, it is about the guest SMMU
getting differing host SMMU associations.

> In other words how an explicit association helps us here?
> 
> Or is it that the Guest PXB numa_id allocation is not always based
> on device numa_id?

Lets simplify to 2 SMMUs for shorter CLIs.

So to start with we assume physical host with two SMMUs, and
two PCI devices we want to assign

  0000:dev1 - associated with host SMMU 1, and host NUMA node 0
  0000:dev2 - associated with host SMMU 2, and host NUMA node 1

So now we configure QEMU like this:

 -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_id=0
 -device pxb-pcie,id=pcie.2,bus_nr=2,bus=pcie.0,numa_id=1
 -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1
 -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2
 -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1
 -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2
 -device vfio-pci,host=0000:dev1,bus=pcie.port1,iommufd=iommufd0
 -device vfio-pci,host=0000:dev2,bus=pcie.port2,iommufd=iommufd0

For brevity I'm not going to show the config for host/guest NUMA mappings,
but assume that guest NUMA node 0 has been configured to map to host NUMA
node 0 and guest node 1 to host node 1.

In this order of QEMU CLI args we get

  VFIO device 0000:dev1 causes the kernel to associate guest smmuv1 with
  host SSMU 1.

  VFIO device 0000:dev2 causes the kernel to associate guest smmuv2 with
  host SSMU 2.

Now consider we swap the ordering of the VFIO Devices on the QEMU cli


 -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_id=0
 -device pxb-pcie,id=pcie.2,bus_nr=2,bus=pcie.0,numa_id=1
 -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1
 -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2
 -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1
 -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2
 -device vfio-pci,host=0000:dev2,bus=pcie.port2,iommufd=iommufd0
 -device vfio-pci,host=0000:dev1,bus=pcie.port1,iommufd=iommufd0

In this order of QEMU CLI args we get

  VFIO device 0000:dev2 causes the kernel to associate guest smmuv1 with
  host SSMU 2.

  VFIO device 0000:dev1 causes the kernel to associate guest smmuv2 with
  host SSMU 1.

This is broken, as now we have inconsistent NUMA mappings between host
and guest. 0000:dev2 is associated with a PXB on NUMA node 1, but
associated with a guest SMMU that was paired with a PXB on NUMA node 0.

This is because the kernel is doing first-come first-matched logic for
mapping guest and host SMMUs, and thus is sensitive to ordering of the
VFIO devices on the CLI. We need to be ordering invariant, which means
libvirt must tell  QEMU which host + guest SMMUs to pair together, and
QEMU must in turn tell the kernel.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


