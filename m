Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D139C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLG1-0003g1-18; Fri, 09 May 2025 06:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDLFh-0003KB-1E
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDLFc-0006fy-RX
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746787603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=felenpAN8orbeY6rFLbciIpHJf8Vz1QRFBep0m9BhGg=;
 b=GHAvBAKmmrah2o4A4s8NlGEB3bPMwsclDvNvkZPIj3TvLKogcJ8jOaq/9b9N032OZr2WYH
 zIVgNjRT4ONzg4hM1yFzINjSlC1AlsUnlKnjqH3Qax8EPgED5FIfM8KhSNXMg5X9ltyuFi
 jKBqdMeOY5wiEhkTUheX181jL0jnxv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-N4wHGzPvOAar6ZMAarSFQw-1; Fri,
 09 May 2025 06:46:37 -0400
X-MC-Unique: N4wHGzPvOAar6ZMAarSFQw-1
X-Mimecast-MFC-AGG-ID: N4wHGzPvOAar6ZMAarSFQw_1746787594
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11E151800373; Fri,  9 May 2025 10:46:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAAA61955F24; Fri,  9 May 2025 10:46:27 +0000 (UTC)
Date: Fri, 9 May 2025 11:46:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Message-ID: <aB3dAPNgXj7w9-7L@redhat.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org>
 <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
 <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
 <CAFEAcA-HWuAUVhqsE7p2BMo6wg+7F273Q_J2LVLrHzFagTjxgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-HWuAUVhqsE7p2BMo6wg+7F273Q_J2LVLrHzFagTjxgg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 09, 2025 at 11:37:14AM +0100, Peter Maydell wrote:
> On Fri, 9 May 2025 at 09:00, Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> > From: Peter Maydell <peter.maydell@linaro.org>
> > > The problem here seems to me to be that in the hardware we're
> > > modelling the SMMU always exists, because it's in the SoC,
> > > but you're trying to arrange for it to be created on the
> > > command line, via -device.
> > >
> > > We don't have any of these problems with the current 'virt'
> > > board code, because we have the board code create the iommu
> > > (if the user asks for it via the iommu machine property),
> > > and it can wire it up to the PCI root complex as needed.
> >
> > Yes, currently virt creates a SMMUv3 instance and associates it with
> > pcie.0 by default. However, this setup isn't ideal once we introduce
> > support for accelerated SMMUv3, where we need to configure the
> > host SMMUv3 for nested stage translation. This is essential for VFIO-PCI
> > passthrough scenarios, where the guest manages the stage-1 page tables
> > and the host manages stage-2.
> >
> > In such cases, devices may be associated with different host SMMUv3s,
> > and having a single vSMMUv3 in the guest isn't ideal as-
> >
> > -We would need to broadcast TLBIs or perform lookups to identify the
> >  corresponding host SMMUv3.
> > -The physical SMMUv3s might differ in functionality.
> > -Some SMMUv3 implementations offer additional virtualization features (e.g., vCMDQ),
> >   where the CMDQ is is directly gets mapped to the Guest and invalidations
> >   aren't  even trapped.
> >
> > Please refer to the earlier RFC [1], which proposed a new arm-smmuv3-accel
> > device. The main feedback on that RFC was to instead convert the existing
> > arm-smmuv3 into a user-creatable device, and introduce acceleration support
> > via an optional property:
> >
> > -device arm-smmuv3,accel=on,..
> >
> > This series is the first step toward that goal—making the current arm-smmuv3 device
> > user-creatable.
> 
> (I want to start here by saying that I appreciate that I'm
> coming in without having read the previous discussion, so
> this is kind of going back over ground you've already
> been through.)
> 
> I agree that rather than having an entirely separate "SMMU with
> acceleration" it would be better to have it be a property on
> the SMMU device. But why do we need it to be user created?
> Making it user-created leads into all kinds of tricky areas
> mostly surrounding the fact that QEMU right now simply doesn't
> support having user-created sysbus devices and other kinds
> of device with complex wiring-up. -device is really intended
> for "this is a model of a device that in real hardware is
> pluggable and has basically one connection, like a PCI card
> has a PCI-slot".

In terms of "why does it need to be user created" - the goal was to expose
multiple SMMUs to the guest, each associated with a separate physical SMMU.
IIUC, each physical NUMA node would have its own SMMU.

So configuring a guest VM will require creating multiple PXBs, one for
each virtual NUMA node, and then creating SMMUs for each PXB.

Since there was a need for the user to create SMMUs for the PXBs, the
question was then raised, why shouldn't the default SMMU also be
user creatable in the same way, so that mgmt apps like libvirt have
a single way to configure the SMMUs with -device.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


