Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE88C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdymA-0006Ht-8x; Fri, 31 Jan 2025 16:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdym8-0006HT-Qn
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:42:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tdym6-0006tg-VA
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738359724;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5Bf7CBp1o/bfAswNA9w4yLehk2bzKwAEJ06KBTm5bqw=;
 b=hFknOkinBQIlAlPRKfh7QrHs0QTURzpsw8cL6RDpckZld0V7ccfsskMz7uvxyMuyx/EAYk
 +hpIYzCS4qjrF9WnONqU0lIPwa1U975nRB7yHJyD4tu2Nl4iwaMF5b0AUAhuuGpf1h65VP
 yfeO8iLDU4N4CHL7NBKugn3ZKktzUmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-oj4hG7dGMLmGtRDhPgmjJA-1; Fri,
 31 Jan 2025 16:42:00 -0500
X-MC-Unique: oj4hG7dGMLmGtRDhPgmjJA-1
X-Mimecast-MFC-AGG-ID: oj4hG7dGMLmGtRDhPgmjJA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65CB51801F15; Fri, 31 Jan 2025 21:41:58 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B64119560A3; Fri, 31 Jan 2025 21:41:50 +0000 (UTC)
Date: Fri, 31 Jan 2025 21:41:46 +0000
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
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z51DmtP83741RAsb@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ecabe74e0514367baf28d67675e5db8@huawei.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 30, 2025 at 06:09:24PM +0000, Shameerali Kolothum Thodi wrote:
> 
> Each "arm-smmuv3-nested" instance, when the first device gets attached
> to it, will create a S2 HWPT and a corresponding SMMUv3 domain in kernel
> SMMUv3 driver. This domain will have a pointer representing the physical
> SMMUv3 that the device belongs. And any other device which belongs to
> the same physical SMMUv3 can share this S2 domain.

Ok, so given two guest SMMUv3s,   A and B, and two host SMMUv3s,
C and D, we could end up with A&C and B&D paired, or we could
end up with A&D and B&C paired, depending on whether we plug 
the first VFIO device into guest SMMUv3  A or B.

This is bad.  Behaviour must not vary depending on the order
in which we create devices.

An guest SMMUv3 is paired to a guest PXB. A guest PXB is liable
to be paired to a guest NUMA node. A guest NUMA node is liable
to be paired to host NUMA node. The guest/host SMMU pairing
must be chosen such that it makes conceptual sense wrt to the
guest PXB NUMA to host NUMA pairing.

If the kernel picks guest<->host SMMU pairings on a first-device
first-paired basis, this can end up with incorrect guest NUMA
configurations.

The mgmt apps needs to be able to tell QEMU exactly which
host SMMU to pair with each guest SMMU, and QEMU needs to
then tell the kernel.

> And as I mentioned in cover letter, Qemu will report,
> 
> "
> Attempt to add the HNS VF to a different SMMUv3 will result in,
> 
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: Unable to attach viommu
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: vfio 0000:7d:02.2:
>    Failed to set iommu_device: [iommufd=29] error attach 0000:7d:02.2 (38) to id=11: Invalid argument
> 
> At present Qemu is not doing any extra validation other than the above 
> failure to make sure the user configuration is correct or not. The
> assumption is libvirt will take care of this.
> "
> So in summary, if the libvirt gets it wrong, Qemu will fail with error.

That's good error checking, and required, but also insufficient
as illustrated above IMHO.

> If a more explicit association is required, some help from kernel is required
> to identify the physical SMMUv3 associated with the device.

Yep, I think SMMUv3 info for devices needs to be exposed to userspace,
as well as a mechanism for QEMU to tell the kernel the SMMU mapping.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


