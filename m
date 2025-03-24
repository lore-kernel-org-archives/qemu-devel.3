Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE6FC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjKe-0005kY-IF; Mon, 24 Mar 2025 11:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twjKX-0005jy-2E
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1twjKT-00052B-1a
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742828584;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWqRSVIKizCJtcAJeyRCndgaRT+ZmfVGOUXgg/6yicE=;
 b=Vhb/wp0V8eBh4GZGejU1jUhsRmC3ez65/rm5liMiTlmGbI4ntaGj/TTcZawCdacaA1xfR5
 TF3v8dvutfPwiC9gUo5pbmaiIgpK7xG4XcBtf7Cf/v5QASgh2jzTdllTtvfD0iXKwuM6Uz
 Qxk2tZzKxm/wExJ9hIV36F1wYuLUtE0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-Mp0OYYwEPDulFFsH8C_tTg-1; Mon,
 24 Mar 2025 11:03:00 -0400
X-MC-Unique: Mp0OYYwEPDulFFsH8C_tTg-1
X-Mimecast-MFC-AGG-ID: Mp0OYYwEPDulFFsH8C_tTg_1742828578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051F618011C1; Mon, 24 Mar 2025 15:02:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C97661800268; Mon, 24 Mar 2025 15:02:50 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:02:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Message-ID: <Z-F0F1-zpI4kvO-j@redhat.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <1c603ab2-4fbb-4838-a544-d88bc2608506@redhat.com>
 <44ed64f0-8e8b-4a87-9a85-074b9d283bc8@redhat.com>
 <1b838258-7d30-4d9e-b350-3950617419e2@redhat.com>
 <b7201a78-f2ea-4aee-a973-b02e4dc78652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7201a78-f2ea-4aee-a973-b02e4dc78652@redhat.com>
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 24, 2025 at 03:56:12PM +0100, Eric Auger wrote:
> 
> 
> On 3/21/25 1:59 AM, Donald Dutile wrote:
> >
> >
> > On 3/19/25 2:21 PM, Eric Auger wrote:
> >> Hi Don,
> >>
> >>
> >> On 3/19/25 5:21 PM, Donald Dutile wrote:
> >>>
> >>>
> >>> On 3/19/25 5:26 AM, Shameerali Kolothum Thodi wrote:
> >>>> Hi Don,
> >>>>
> >>> Hey!
> >>>
> >>>>> -----Original Message-----
> >>>>> From: Donald Dutile <ddutile@redhat.com>
> >>>>> Sent: Tuesday, March 18, 2025 10:12 PM
> >>>>> To: Shameerali Kolothum Thodi
> >>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
> >>>>> qemu-devel@nongnu.org
> >>>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> >>>>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
> >>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
> >>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> >>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
> >>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
> >>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a
> >>>>> pxb-
> >>>>> pcie bus
> >>>>>
> >>>>> Shameer,
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> On 3/11/25 10:10 AM, Shameer Kolothum wrote:
> >>>>>> User must associate a pxb-pcie root bus to smmuv3-accel
> >>>>>> and that is set as the primary-bus for the smmu dev.
> >>>>>>
> >>>>>> Signed-off-by: Shameer Kolothum
> >>>>> <shameerali.kolothum.thodi@huawei.com>
> >>>>>> ---
> >>>>>>     hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
> >>>>>>     1 file changed, 19 insertions(+)
> >>>>>>
> >>>>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> >>>>>> index c327661636..1471b65374 100644
> >>>>>> --- a/hw/arm/smmuv3-accel.c
> >>>>>> +++ b/hw/arm/smmuv3-accel.c
> >>>>>> @@ -9,6 +9,21 @@
> >>>>>>     #include "qemu/osdep.h"
> >>>>>>
> >>>>>>     #include "hw/arm/smmuv3-accel.h"
> >>>>>> +#include "hw/pci/pci_bridge.h"
> >>>>>> +
> >>>>>> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
> >>>>>> +{
> >>>>>> +    DeviceState *d = opaque;
> >>>>>> +
> >>>>>> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
> >>>>>> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
> >>>>>> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus-
> >>>>>> name)) {
> >>>>>> +            object_property_set_link(OBJECT(d), "primary-bus",
> >>>>>> OBJECT(bus),
> >>>>>> +                                     &error_abort);
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>>
> >>>>>>     static void smmu_accel_realize(DeviceState *d, Error **errp)
> >>>>>>     {
> >>>>>> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d,
> >>>>>> Error
> >>>>> **errp)
> >>>>>>         SysBusDevice *dev = SYS_BUS_DEVICE(d);
> >>>>>>         Error *local_err = NULL;
> >>>>>>
> >>>>>> +    object_child_foreach_recursive(object_get_root(),
> >>>>>> +                                   smmuv3_accel_pxb_pcie_bus, d);
> >>>>>> +
> >>>>>>         object_property_set_bool(OBJECT(dev), "accel", true,
> >>>>>> &error_abort);
> >>>>>>         c->parent_realize(d, &local_err);
> >>>>>>         if (local_err) {
> >>>>>> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass
> >>>>> *klass, void *data)
> >>>>>>         device_class_set_parent_realize(dc, smmu_accel_realize,
> >>>>>>                                         &c->parent_realize);
> >>>>>>         dc->hotpluggable = false;
> >>>>>> +    dc->bus_type = TYPE_PCIE_BUS;
> >>>>>>     }
> >>>>>>
> >>>>>>     static const TypeInfo smmuv3_accel_type_info = {
> >>>>>
> >>>>> I am not seeing the need for a pxb-pcie bus(switch) introduced for
> >>>>> each
> >>>>> 'accel'.
> >>>>> Isn't the IORT able to define different SMMUs for different RIDs?
> >>>>> if so,
> >>>>> itsn't that sufficient
> >>>>> to associate (define) an SMMU<->RID association without introducing a
> >>>>> pxb-pcie?
> >>>>> and again, I'm not sure how that improves/enables the device<->SMMU
> >>>>> associativity?
> >>>>
> >>>> Thanks for taking a look at the series. As discussed elsewhere in
> >>>> this thread(with
> >>>> Eric), normally in physical world (or atleast in the most common
> >>>> cases) SMMUv3
> >>>> is attached to PCIe Root Complex and if you take a look at the IORT
> >>>> spec, it describes
> >>>> association of ID mappings between a RC node and SMMUV3 node.
> >>>>
> >>>> And if my understanding is correct, in Qemu, only pxb-pcie allows you
> >>>> to add
> >>>> extra root complexes even though it is still plugged to
> >>>> parent(pcie.0). ie, for all
> >>>> devices downstream it acts as a root complex but still plugged into a
> >>>> parent pcie.0.
> >>>> This allows us to add/describe multiple "smmuv3-accel" each
> >>>> associated with a RC.
> >>>>
> >>> I find the qemu statements a bit unclear here as well.
> >>> I looked at the hot plug statement(s) in docs/pcie.txt, as I figured
> >>> that's where dynamic
> >>> IORT changes would be needed as well.  There, it says you can hot-add
> >>> PCIe devices to RPs,
> >>> one has to define/add RP's to the machine model for that plug-in.
> >>>
> >>> Using libvirt, it could auto-add the needed RPs to do dynmaic smmuv3
> >>> additions,
> >> I am not sure I understand your statement here. we don't want "dynamic"
> >> SMMUv3 instantiation. SMMUv3 is a platform device which is supposed to
> >> be coldplugged on a pre-existing PCIe hierarchy. The SMMUv3 device is
> >> not something that is meant to be hotplugged or hotunplugged.
> >> To me we hijack the bus= property to provide information about the IORT
> >> IDMAP
> >>
> > Dynamic in the sense that if one adds smmuv3 for multiple devices,
> > libvirt will dynamically figure out how to instantiate one, two,
> > three... smmu's
> > in the machine at cold boot.
> > If you want a machine to be able to hot-plug a device that would
> > require another smmu,
> > than the config, and smmu, would have to be explicilty stated; as is
> > done today for
> > hot-plug PCIe if the simple machine that libvirt would make is not
> > sufficient to
> > hot-add a PCIe device.
> 
> Hum this will need to be discussed with libvirt guys but I am not sure
> they will be inclined to support such kind of policy, esp because vIOMMU
> is a pretty marginal use case as of now. They do automatic instantiation
> for pcie, usb controllers but I am not sure they will take care of the
> vIOMMU tbh

Honestly I've lost track of what's going on this thread design-wise.

As general precedence though, the PCI(e) hierarchies libvirt auto-creates
are very flat - no PXBs for example, no association of host/guest NUMA,
etc. Libvirt does as little as possible in order to get PCI devices
working and anything even slightly "fancy" is left upto the mgmt app
to define. IIRC we have a few scenarios where IOMMUs get auto-added,
but mostly we expect the mgmt app to define them.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


