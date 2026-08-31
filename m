Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA6C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12Hc-0001qE-3p; Mon, 31 Aug 2026 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x12Ha-0001pw-JO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x12HY-0002HK-NZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788183760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KW+EfrcAlAZxDlB3wkAXnWrAGUZNFmQDm4PwFH/MxKY=;
 b=ijj/M6nNfE4fvRvOckkj6u8rDBF7KVdb1zL/3bh0G4LZKquxfMCtRFIBvQQIX2qIbMUb2p
 Pn31xuf/YupU9vI6F+FUrTjirWpDx+BdWHji70OAMLJ7Z/wh+vX+uJBFR4noisDBpDk1lH
 qtagFx7mg7WHWdsZXPg8cuERfUzO7eY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-7ULG_3YJPfCW0aRwavHRuQ-1; Mon,
 31 Aug 2026 09:42:35 -0400
X-MC-Unique: 7ULG_3YJPfCW0aRwavHRuQ-1
X-Mimecast-MFC-AGG-ID: 7ULG_3YJPfCW0aRwavHRuQ_1788183754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9C2A197768E; Mon, 31 Aug 2026 13:42:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F9021955F03; Mon, 31 Aug 2026 13:42:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C72D2180060B; Mon, 31 Aug 2026 15:42:31 +0200 (CEST)
Date: Mon, 31 Aug 2026 15:42:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alex@shazbot.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [edk2-devel] [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI
 BAR placement
Message-ID: <apWAprXWglNIWjdp@sirius.home.kraxel.org>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <46b4544a-6e97-4433-b3e2-60cf43e62c7b@app.fastmail.com>
 <f2fe3c7f-4a8f-4025-ac09-777eb5cfc31c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2fe3c7f-4a8f-4025-ac09-777eb5cfc31c@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

  Hi,

> > Is this the reason we cannot rely on the Enhanced Allocation (EA)
> > capability here?
> 
> AFAICT, this was explored on RFC v1.

> EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL was suggested as the
> shorter path at the time, which is what this series uses.

Essentially we have *two* problems to solve here.  The first is how do
we get the fixed bar information from qemu to the firmware, and the
second is how we integrate that into edk2.

So we could have a driver which parses EA and passes along the
information found to PciDxe using
EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL.

Not sure how much of a win that would be compared to adding EA support
to PciDxe directly given that the PciDxe bridge window logic needs
enhancements to properly handle fixed bars (as discussed below).

> > Agreed - if the bridge windows are not programmed correctly on the first
> > pass, there is something in the code that needs to be fixed. I don't think
> > papering over it like this is the right approach.
> 
> That's a fair point. I did the window-sizing after PciBusDxe because I
> didn't want to touch existing PciBusDxe code too much.
> 
> As per my understanding, PciBusDxe's enumeration splits into three phases:
> 
> Phase 1 (PciHostBridgeEnumerator) walks the whole tree and calls
> CheckDevice() per device — by the time this phase finishes, every fixed
> BAR address is already known and cached on the device
> (PciBar[Bar].FixedBaseAddress).
> 
> Phase 2 (PciHostBridgeResourceAllocator) prepares an address for every
> resource node in the tree — both individual BARs and bridge windows
> alike — purely from size and alignment; PCI_RESOURCE_NODE has no address
> field at all, so this is entirely blind to whether a fixed address was
> already required.
> 
> Phase 3 (ProgramResource) then writes the actual PCI config-space
> registers, and by default it just writes whatever address Phase 2
> prepared, for both BARs and bridge windows. The one exception is
> ProgramBar() — it specifically checks whether that particular BAR was
> marked fixed back in Phase 1, and if so, overrides Phase 2's prepared
> base address with the real fixed one. However, ProgramPpbApperture(),
> which writes the bridge's own window registers, has no equivalent
> override — it always writes whatever Phase 2 prepared, with no awareness
> of a fixed BAR anywhere underneath it. And that needs fixing, and for
> that I have to change the existing code.
> 
> I think the fix would be to extend Phase 2's own sizing step
> (CalculateResourceAperture() in PciResourceSupport.c) to check for the
> already-known fixed address on each child and, when present, size and
> position the window as the exact union of those addresses instead of the
> blind size-only sum. Does that match the direction you had in mind, or
> is there a different integration point you'd suggest?

Sounds about right, when propagating resource requirements up from
devices to bridges looking only at the size is not enough if we want
properly support pci bars at fixed locations.

take care,
  Gerd


