Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIsm-0004ld-Dg; Fri, 09 May 2025 04:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDIsd-0004k7-QJ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDIsa-0001ws-Ib
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746778485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8MAwnkQzHH8nuVJQNG0jeKb218M3ZgM99kwjysGqgG4=;
 b=iIbryudGkimRpRXEaojF1TVXRh+KRhJu6Jrn7RFGIxuVTV7p4EF9VmJ24iaCMPHp51boGo
 DauS2yAtBbo+NFFDyi3NjwjHEqQwIOy1LUcPXn4K0DUXj8S/rI7W/Yz64dOzJC0YT4CxnP
 2yMLTzL97G5/xNZn46ZbXxYo7KK4hR4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-GemdPNb5Pk6ayAcQAYatqQ-1; Fri,
 09 May 2025 04:14:42 -0400
X-MC-Unique: GemdPNb5Pk6ayAcQAYatqQ-1
X-Mimecast-MFC-AGG-ID: GemdPNb5Pk6ayAcQAYatqQ_1746778480
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B945419560A1; Fri,  9 May 2025 08:14:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5751956095; Fri,  9 May 2025 08:14:32 +0000 (UTC)
Date: Fri, 9 May 2025 09:14:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum via <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
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
Message-ID: <aB25ZRu7pCJNpamt@redhat.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org>
 <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <c0ab36fc56ff498196b359f5aee3746b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0ab36fc56ff498196b359f5aee3746b@huawei.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Fri, May 09, 2025 at 07:29:28AM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Donald Dutile <ddutile@redhat.com>
> > Sent: Thursday, May 8, 2025 2:45 PM
> > To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; Markus Armbruster
> > <armbru@redhat.com>
> > Cc: Shameer Kolothum via <qemu-devel@nongnu.org>; qemu-
> > arm@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> > jgg@nvidia.com; nicolinc@nvidia.com; berrange@redhat.com;
> > nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com; Linuxarm
> > <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> > jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> > Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
> > PCIe RC
> > 
> > 
> > 
> > On 5/7/25 4:50 AM, Shameerali Kolothum Thodi wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Markus Armbruster <armbru@redhat.com>
> > >> Sent: Wednesday, May 7, 2025 8:17 AM
> > >> To: Donald Dutile <ddutile@redhat.com>
> > >> Cc: Shameer Kolothum via <qemu-devel@nongnu.org>; qemu-
> > >> arm@nongnu.org; Shameerali Kolothum Thodi
> > >> <shameerali.kolothum.thodi@huawei.com>; eric.auger@redhat.com;
> > >> peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
> > >> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > >> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou
> > (B)
> > >> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> > >> Jonathan Cameron <jonathan.cameron@huawei.com>;
> > >> zhangfei.gao@linaro.org
> > >> Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a
> > >> PCIe RC
> > >>
> > >> Donald Dutile <ddutile@redhat.com> writes:
> > >>
> > >> [...]
> > >>
> > >>> In this series, an iommu/smmu needs to be placed -BETWEEN- a sysbus
> > >> and a PCIe-tree,
> > >>> or step-wise, plug an smmuv3 into a sysbus, and a pcie tree/domain/RC
> > >> into an SMMUv3.
> > >>
> > >> RC = root complex?
> > >
> > > Yes.
> > >
> > +1.
> > 
> > >>
> > >>> So, an smmu needs to be associated with a bus (tree), i.e., pcie.0,
> > pcie.1...
> > >>> One could model it as a PCIe device, attached at the pcie-RC ... but
> > that's
> > >> not how it's modelled in ARM hw.
> > >>
> > >> Physical ARM hardware?
> > >>
> > yes, physical hw.
> > 
> > >> Assuming the virtual devices and buses we're discussing model physical
> > >> devices and buses:
> > >>
> > >> * What are the physical devices of interest?
> > >>
> > >> * How are they wired together?  Which of the wires are buses, in
> > >>    particular PCI buses?
> > >
> > > SMMUv3 is a platform device and its placement in a system is typically as
> > below
> > > for PCI devices,
> > >
> > > +------------------+
> > > |   PCIe Devices   |
> > > +------------------+
> > >           |
> > >           v
> > >    +-------------+      +---------------+
> > >    |  PCIe RC A  |<---->| Interconnect  |
> > >    +-------------+      +---------------+
> > >                                 |
> > >                                 |
> > >                          +------v---+
> > >                          | SMMUv3.A |
> > >                          | (IOMMU)  |
> > >                          +----+-----+
> > >                               |
> > >                               v
> > >                       +-------+--------+
> > >                       |   System RAM   |
> > >                       +----------------+
> > >
> > > This patch is attempting to establish that association between the PCIe
> > RC and
> > > the SMMUv3 device so that Qemu can build the ACPI tables/DT iommu
> > mappings
> > > for the SMMUv3 device.
> > >
> > I would refer to the ARM SMMU spec, Figure 2.3 in the G.a version, where
> > it's slightly different; more like:
> 
> That's right. The spec does indeed cover all possible scenarios, whereas my earlier
> comments were focused more specifically on the common case of systems using
> SMMUv3 with PCIe devices.
> 
> Currently, QEMU doesn't support non-PCI devices with SMMUv3, neither the
> more complex distributed SMMU cases you have described below. And this series
> doesn't aim to add those supports either. If needed, we can treat those as a separate
> efforts—similar to what was attempted in [1]. That said, agree that the design
> choices we make now should not hinder adding such support in the future.
> 
> And as far as I can see, nothing in this series would prevent that and if anything,
> the new device type SMMUv3 model actually makes it easier to support those.
> 
> >   +------------------+
> >   |   PCIe Devices   | (one device, unless a PCIe switch is btwn the RC &
> > 'Devices';
> >   +------------------+   or, see more typical expansion below)
> >             |
> >      +-------------+
> >      |  PCIe RC A  |
> >      +-------------+
> >             |
> >      +------v---+    +-----------------------------------+
> >      | SMMUv3.A |    | Wide assortment of other platform |
> >      | (IOMMU)  |    |   devices not using SMMU          |
> >      +----+-----+    +-----------------------------------+
> >           |                      |   |   |
> >    +------+----------------------+---+---+-+
> >    |         System Interconnect           |
> >    +---------------------------------------+
> >                                 |
> >    +-------+--------+     +-----+-------------+
> >    |   System RAM   |<--->| CPU (NUMA socket) |
> >    +----------------+     +-------------------+
> > 
> > In fact, the PCIe can be quite complex with PCIe bridges, and multiple Root
> > Ports (RP's),
> > and multiple SMMU's:
> > 
> >      +--------------+   +--------------+   +--------------+
> >      | PCIe Device  |   | PCIe Device  |   | PCIe Device  |
> >      +--------------+   +--------------+   +--------------+
> >            |                  |                  |        <--- PCIe bus
> >       +----------+       +----------+      +----------+
> >       | PCIe RP  |       | PCIe RP  |      | PCIe RP  |  <- may be PCI Bridge, may
> > not
> >       +----------+       +----------+      +----------+
> >           |                  |                  |
> >       +----------+       +----------+       +----------+
> >       |  SMMU    |       |  SMMU    |       |  SMMU    |
> >       +----------+       +----------+       +----------+
> >           |                  |                  |   <- may be a bus, may not(hidden from OS)
> >           +------------------+------------------+
> >                              |
> >              +--------------------------+
> >              |          PCI RC A        |
> >              +--------------------------+
> > 
> > where PCIe RP's could be represented (even virtually) in -hw-
> > as a PCIe bridge, each downstream being a different PCIe bus under
> > a single PCIe RC (A, in above pic) -domain-.
> > ... or the RPs don't have to have a PCIe bridge, and look like
> > 'just an RP' that provides a PCIe (pt-to-pt, serial) bus, provided
> > by a PCIe RC. ... the PCIe architecture allows both, and I've seen
> > both implementations in hw (at least from an lspci perspective).
> > 
> > You can see the above hw implementation by doing an lspci on most
> > PCIe systems (definitely common on x86), where the RP's are represented
> > by 'PCIe bridge' elements -- and lots of them.
> > In real hw, these RP's effectively become (multiple) up & downstream
> > transaction queues
> > (which implement PCI ordering, and deadlock avoidance).
> > SMMUs are effectively 'inserted' in the (upstream) queue path(s).
> > 
> > The important take away above: the SMMU can be RP &/or device-specific -
> > - they
> > do not have to be bound to an entire PCIe domain ... the *fourth* part of
> > an lspci output for a PCIe device: Domain:Bus:Device.Function.
> > This is the case for INTEL & AMD IOMMUs ... and why the ACPI tables have
> > to describe which devices (busses often) are associated with which
> > SMMU(in IORT)
> > or IOMMU(DMAR/IVRS's for INTEL/AMD IOMMU).
> > 
> > The final take away: the (QEMU) SMMU/IOMMU must be associated with a
> > PCIe bus
> > OR, the format has to be something like:
> >    -device smmuv3, id=smmuv3.1
> >    -device <blah>, smmu=smmuv3.1
> 
> Agree. For PCie devices with SMMUv3 we need to associate it with a PCIe bus
> and for non-pci cases probably needs a per device association.
> 
> > where the device <-> SMMU (or if extended to x86, iommu) associativity is
> > set w/o bus associativity.
> > It'd be far easier to tag an entire bus with an SMMU/IOMMU, than a per-
> > device format, esp. if
> > one has lots of PCIe devices in their model; actually, even if they only have
> > one bus and 8 devices
> > (common), it'd be nice if a single iommu/smmu<->bus-num associativity
> > could be set.
> > 
> > Oh, one final note: it is possible, although I haven't seen it done this way
> > yet,
> > that an SMMU could be -in- a PCIe switch (further distributing SMMU
> > functionality
> > across a large PCIe subsystem) and it -could- be a PCIe device in the switch,
> > btwn the upstream and downstream bridges -- actually doing the SMMU
> > xlations
> > at that layer..... for QEMU & IORT, it's associated with a PCIe bus.
> > But, if done correctly, that shouldn't matter -- in the example you gave wrt
> > serial,
> > it would be a new device, using common smmu core: smmuv3-pcie.
> > [Note: AMD actually identifies it's IOMMU as a PCIe device in an RC ... but
> > still uses
> >         the ACPI tables to configure it to the OS.. so the PCIe-device is basically
> > a
> >         device w/o a PCIe driver. AMD just went through hoops dealing with
> > MS
> >         and AMD-IOMMU-identification via PCIe.]
> > 
> > So, stepping back, and looking at a broad(er) SMMU -or- IOMMU QEMU
> > perspective,
> > I would think this type of format would be best:
> > 
> > - bus pcie, id=pcie.<num>
> > - device iommu=[intel_iommu|smmuv3|amd_iommu], bus=[sysbus |
> > pcie.<num>], id=iommu.<num>
> > [Yes, I'm sticking with 'iommu' as the generic naming... everyone thinks of
> > device SMMUs as IOMMUs,
> >   and QEMU should have a more arch-agnostic naming of these system
> > functions. ]
> 
> Ok. But to circle back to what originally started this discussion—how important
> is it to rely on the default "bus" in this case? As Markus pointed out, SMMUv3
> is a platform device on the sysbus, so its default bus type can’t point to something
> like PCIe. QEMU doesn’t currently support that.
> 
> The main motivation for using the default "bus" so far has been to have better
> compatibility with libvirt. Would libvirt be flexible enough if we switched to using
> something like a "primary-bus" property instead?

Sorry if my previous comments misled you, when I previously talked about
linking via a "bus" property I was not considering the fact that "bus"
is a special property inside QEMU. From a libvirt POV we don't care what
the property is call - it was just intended to be a general illustration
of cross-referencing the iommu with the PCI bus it needed to be associated
with.

> -device arm-smmuv3,primary-bus=pcie.0
> -device virtio-net-pci,bus=pcie.0
> -device pxb-pcie,id=pcie.1,bus_nr=2
> -device arm-smmuv3,primary-bus=pcie.1
> ...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


