Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CF5C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg39b-0005bD-W6; Thu, 06 Feb 2025 09:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg39Z-0005aK-NP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg39X-0008AE-Po
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738853209;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTWnLZ7ZsqpHPB7SWUp/KJbXvK8lp77mmoGEGHxKNc8=;
 b=JBKS2QiSxhZNRjpH/D6Sh5CW+WMQRstvE1SMsaCKP8/oCFCCvajUrU3iBCncBet8HectCp
 gymJR6Mob0hyE6bG+BpKXEr79eOR1i1Fa7/+V2vOz7Uc0bbtJclPAUYHM0Zq3eNuKgm8Rl
 F4RwvSa8e4d5BHAhmNX6nPRin8/ozxs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-w-yhJ0T8OJ6xol3F73baeQ-1; Thu,
 06 Feb 2025 09:46:46 -0500
X-MC-Unique: w-yhJ0T8OJ6xol3F73baeQ-1
X-Mimecast-MFC-AGG-ID: w-yhJ0T8OJ6xol3F73baeQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50BA61955D53; Thu,  6 Feb 2025 14:46:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E69180087A; Thu,  6 Feb 2025 14:46:36 +0000 (UTC)
Date: Thu, 6 Feb 2025 14:46:33 +0000
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
Message-ID: <Z6TLSdwgajmHVmGH@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f898b6de4a664fe8810b06b7741e3120@huawei.com>
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

On Thu, Feb 06, 2025 at 01:51:15PM +0000, Shameerali Kolothum Thodi wrote:
> Hmm..I don’t think just swapping the order will change the association with
> Guest SMMU here. Because, we have,
> 
> >  -device arm-smmuv3-accel,id=smmuv2,bus=pcie.2
> 
> During smmuv3-accel realize time, this will result in, 
>  pci_setup_iommu(primary_bus, ops, smmu_state);
> 
> And when the vfio dev realization happens,
>  set_iommu_device() 
>    smmu_dev_set_iommu_device(bus, smmu_state, ,)
>       --> this is where the guest smmuv3-->host smmuv3 association is first
>             established. And any further vfio dev to this Guest SMMU will
>             only succeeds if it belongs to the same phys SMMU.
> 
> ie, the Guest SMMU to pci bus association, actually make sure you have the
> same Guest SMMU for the device.

Ok, so at time of VFIO device realize, QEMU is telling the kernel
to associate a physical SMMU, and its doing this with the virtual
SMMU attached to PXB parenting the VFIO device.

> smmuv2 --> pcie.2 --> (pxb-pcie, numa_id = 1)
> 0000:dev2 -->  pcie.port2 --> pcie.2 --> smmuv2 (pxb-pcie, numa_id = 1)
> 
> Hence the association of 0000:dev2 to Guest SMMUv2 remain same.

Yes, I concur the SMMU physical <-> virtual association should
be fixed, as long as the same VFIO device is always added to
the same virtual SMMU.

> I hope this is clear. And I am not sure the association will be broken in any
> other way unless Qemu CLI specify the dev to a different PXB.

Although the ordering is at least predictable, I remain uncomfortable
about the idea of the virtual SMMU association with the physical SMMU
being a side effect of the VFIO device placement.

There is still the open door for admin mis-configuration that will not
be diagnosed. eg consider we attached VFIO device 1 from the host NUMA
node 1 to  a PXB associated with host NUMA node 0. As long as that's
the first VFIO device, the kernel will happily associate the physical
and guest SMMUs.

If we set the physical/guest SMMU relationship directly, then at the
time the VFIO device is plugged, we can diagnose the incorrectly
placed VFIO device, and better reason about behaviour.

I've another question about unplug behaviour..

 1. Plug a VFIO device for host SMMU 1 into a PXB with guest SMMU 1.
      => Kernel associates host SMMU 1 and guest SMMU 1 together
 2. Unplug this VFIO device
 3. Plug a VFIO device for host SMMU 2 into a PXB with guest SMMU 1.

Does the host/guest SMMU 1<-> 1 association remain set after step 2,
implying step 3 will fail ? Or does it get unset, allowing step 3
to succeed, and establish a new mapping host SMMU 2 to guest SMMU 1.

If step 2 does NOT break the association, do we preserve that
across a savevm+loadvm sequence of QEMU. If we don't, then step
3 would fail before the savevm, but succeed after the loadvm.

Explicitly representing the host SMMU association on the guest SMMU
config makes this behaviour unambiguous. The host / guest SMMU
relationship is fixed for the lifetime of the VM and invariant of
whatever VFIO device is (or was previously) plugged.

So I still go back to my general principle that automatic side effects
are an undesirable idea in QEMU configuration. We have a long tradition
of making everything entirely explicit to produce easily predictable
behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


