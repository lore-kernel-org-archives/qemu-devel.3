Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C279C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1217-0004qB-8Y; Mon, 31 Aug 2026 09:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1216-0004lj-D4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1214-0007HD-9k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788182736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEK0PmZytTXd/hQoFTmucufl0WA8TC6IEgfPXV7mS1Y=;
 b=WqkFKr3IsHJ0XsCb7pe54L41WqQkQGHalnmSmKKNcX9qBKBjYJcHTX02tPNTxHYtvu5bCB
 yORREaVPGd30HSot+cKMLnHAMcfjkMh3BdETD8biDlqtA3jUJ/3e41MAIUUyU0OVJJRQxc
 XXLAhUjGqm1mpkxg87mGhAiN5p9EtpA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605--9rHE051PyW1vX0LaqV6VQ-1; Mon,
 31 Aug 2026 09:25:30 -0400
X-MC-Unique: -9rHE051PyW1vX0LaqV6VQ-1
X-Mimecast-MFC-AGG-ID: -9rHE051PyW1vX0LaqV6VQ_1788182728
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 205CE196DFC6; Mon, 31 Aug 2026 13:25:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB33A377EB; Mon, 31 Aug 2026 13:24:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C983180060B; Mon, 31 Aug 2026 15:24:09 +0200 (CEST)
Date: Mon, 31 Aug 2026 15:24:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org, jgg@nvidia.com, 
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827074733.340aeb0c@shazbot.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 27, 2026 at 07:47:33AM -0600, Alex Williamson wrote:
> On Thu, 27 Aug 2026 09:18:50 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > I'd strongly recommend to do the same for the fixed bars:  Add a pci
> > capability to pass that information.  All the logic you have today to
> > link the information in the fw_cfg file to the correct pci device is
> > simply not needed any more then.
> 
> Placement of a VMM defined capability into a vfio-pci device is not
> such a trivial problem as it is for emulated devices.  Space may not be
> readily available and the capability may mask non-architected registers.
> 
> Does this suggestion relate to fixing the gap between mapping fw_cfg
> entries by vendor/device IDs or is there something fundamentally
> undesirable about using fw_cfg here?

Well, fw_cfg is the fallback option if we don't have any better way.
Attaching the information directly to the device by placing it in a
pci capability is at very minimum worth exploring.  If this is not
working for vfio devices, ok, we have to accept that I guess.

And, yes, the logic to match entries in the fw_cfg file with the correct
device using vendor and device id looks somewhat fragile to me too.

Existing code in qemu+firmware (for example bootorder) uses the location
in the physical device tree to identify devices, like this:

/pci@i0cf8/pci-bridge@3/*@0/*@0/*@0,0
 ^^^^^^^^^                             pcie root bus
           ^^^^^^^^^^^^                pcie root port @ slot 3
                        ^^^            virtio-scsi-pci @ slot 0
                            ^^^        scsi controller bus #0
                                ^^^^^  scsi device target 0, lun 0

> > > * fixed-bar=on on a PCIe root port marks its subordinate hierarchy for
> > >   fixed BAR placement. Every device with memory BARs in that hierarchy
> > >   must provide a complete pci-bars= configuration.  
> > 
> > Why is this needed?
> 
> AIUI, the problem space is greatly expanded if we mix user provided
> fixed-bars with firmware assigned BARs and it's possible that there is
> no solution that meets the requirements.  This option both simplifies
> the problem space and allows the resource windows to be audited to
> generate user actionable errors in QEMU.

I can see that allowing fixed and non-fixed bars mix is much harder to
handle.  Do we need to ask the user to manually set that though?  I'd
prefer pci devices propagating automatically to the parent bus that they
have fixed bars and additional constrains apply.

Also: if the main use case for this is to map vfio devices with guest
physical address == host physical address, is there a need to specify
this manually at all?  Shouldn't we have a 'vfio-pci-fixed' device which
handles this automatically?

> > > * pci-bars=barN@<addr>[,barM@<addr>]... on a PCI endpoint specifies the
> > >   required address for each memory BAR. All memory BARs on the device
> > >   must have an explicitly assigned address.  
> > 
> > fixed-bar-<nr>=<addr> ?
> 
> Could be a reasonable alternative.

Parsing (and quoting) property strings with commas in the middle is a
PITA, also when using numerical properties you can use the 'size'
property type which accepts things like '16G'.

take care,
  Gerd


