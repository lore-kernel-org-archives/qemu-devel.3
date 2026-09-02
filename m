Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED350C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1eG6-0001fY-EW; Wed, 02 Sep 2026 02:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1eG4-0001eL-Mx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1eG3-0003SL-0B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788329737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c67ZLIePHPxQ8MjjcKoUytIhrkoCYu3zTPbGL0OnzyA=;
 b=jLoCnxbA9LhSOoMw4g9+zqHHwzcu5MxeY5MZUOSB9A1Iwlya6hPi+VfSOKvFROL2dJBYNP
 dP7ThAmhNRsQMWq1bIqov3/JsNY8giENxeIdOs4J0cUzv1Py6gGEdbHDOtwiTZBiED7Crp
 j7nXl2tIqV0qLwEyDHuX+eRwX2eSFl8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-L4pevW_vNpyTZRNMzehZJw-1; Wed,
 02 Sept 2026 02:15:34 -0400
X-MC-Unique: L4pevW_vNpyTZRNMzehZJw-1
X-Mimecast-MFC-AGG-ID: L4pevW_vNpyTZRNMzehZJw_1788329732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45656183F9CE; Wed,  2 Sep 2026 06:15:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 368331956044; Wed,  2 Sep 2026 06:15:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1CD4118007B6; Wed, 02 Sep 2026 08:15:30 +0200 (CEST)
Date: Wed, 2 Sep 2026 08:15:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org, 
 jgg@nvidia.com, skolothumtho@nvidia.com, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > And, yes, the logic to match entries in the fw_cfg file with the correct
> > device using vendor and device id looks somewhat fragile to me too.
> > 
> > Existing code in qemu+firmware (for example bootorder) uses the location
> > in the physical device tree to identify devices, like this:
> > 
> > /pci@i0cf8/pci-bridge@3/*@0/*@0/*@0,0
> >  ^^^^^^^^^                             pcie root bus
> >            ^^^^^^^^^^^^                pcie root port @ slot 3
> >                         ^^^            virtio-scsi-pci @ slot 0
> >                             ^^^        scsi controller bus #0
> >                                 ^^^^^  scsi device target 0, lun 0
> 
> Good point but the problem is CheckDevice()'s own signature, which is
> fixed by UEFI PI spec (only passes
> VendorId/DeviceId/RevisionId/SubsystemVendorId/SubsystemDeviceId). Even
> though the path exists internally, the standard protocol interface
> doesn't pass it to the callback.

Hmm, yes.  Seems to be designed to apply quirks to device classes, not
individual devices.

Also note that OVMF already has an incompatible pci device driver and
there can be only one instance, so the code must be merged into the
existing driver instead of adding a second.

> Therefore, we prepare the blob entries
> in the same order PciBusDxe discovers devices, so matching by VID:DID
> inherently works.

Question is whenever we want have that edk2 limitation and the knowledge
about edk2 internals (pci scan order) encoded in the qemu <-> firmware
protocol.  I think it makes sense to (additionally) pass the complete
device path even if the current edk2 implementation doesn't use it, so
we have the option to improve things later on without having to change
the qemu <-> firmware protocolS for that.

> > I can see that allowing fixed and non-fixed bars mix is much harder to
> > handle.  Do we need to ask the user to manually set that though?  I'd
> > prefer pci devices propagating automatically to the parent bus that they
> > have fixed bars and additional constrains apply.
> 
> I looked at this again, and technically nothing actually needs the flag
> to exist. The real reason I kept it is closer to a usability one; it's
> meant to be a visible signal in the launch script itself, so anyone
> reading or writing the qemu command line sees up front that every device
> under that root port is expected to have pci-bars= configured, rather
> than that requirement only surfacing as a runtime error if something's
> missing.

I'm not sure how much of a usability win that actually is, if you forget
to set the flag you still get a runtime error.

In general I like things which can be done automatically actually happen
automatically as this simplifies things for the user in most cases.

> > Also: if the main use case for this is to map vfio devices with guest
> > physical address == host physical address, is there a need to specify
> > this manually at all?  Shouldn't we have a 'vfio-pci-fixed' device which
> > handles this automatically?
> 
> VFIO GPA == HPA is the primary motivation, but I don't think fixed-bar
> should be tied to VFIO or automatically derive guest addresses from the
> host.

Why not?  It is a great usability improvement IMHO.

> For the VFIO use case, the admin can choose to specify the host
> BAR addresses as the fixed-bar configuration to get GPA == HPA, but the
> mechanism itself doesn't assume or enforce that -- the desired guest
> layout isn't always just a copy of the host's, so having fixed-bar
> auto-derive it on its own would be incorrect in some cases, not just
> less general.

You still can have fixed-bar-<nr>=<addr> properties to override the
auto-discovered address for some or all pci bars.

> The mechanism remains a generic way to explicitly specify
> PCI BAR addresses.

Yes, the code which creates the fw_cfg files is generic and it makes
sense to have that in the core pci code, so it can be used for every pci
device.

Nevertheless I'd tend to only expose the properties for devices where an
actual use case exists.  Which is obviously vfio-pci(-fixed).  Also
pci-testdev for development / testing / CI.  I can't see much beyond
that though.

take care,
  Gerd


