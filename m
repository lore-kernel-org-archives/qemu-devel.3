Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5EAC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x242a-0005us-2c; Thu, 03 Sep 2026 05:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x242Y-0005uZ-Ft
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x242W-0005Ds-VE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788428843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6HIJikyFfK/pC+ch295cG82Vr1E1seYptOmkyaDQFQ=;
 b=arbpZZ3ShbL6h7KSsGyRqAyf9iu4YrSUXhwJB90WnW7qnVVi1mHHYDTCbo5wJUqsZ1uQ4z
 rTgUBI4DU/dvXClWaK41TXqjJLxo0jfdKrfYuxmbUVDlBmRT0QNjKVuIMlKjLQcqZpGLH4
 mwYIHtZn5Ci6hhTlj/4Vz1+sNWXRMLo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-SJExIVZBPPGKrs5FJtzFCQ-1; Thu,
 03 Sep 2026 05:47:20 -0400
X-MC-Unique: SJExIVZBPPGKrs5FJtzFCQ-1
X-Mimecast-MFC-AGG-ID: SJExIVZBPPGKrs5FJtzFCQ_1788428838
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4A99191F59E; Thu,  3 Sep 2026 09:47:16 +0000 (UTC)
Received: from ghoffman-na.rmtde.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59B81955F0A; Thu,  3 Sep 2026 09:47:15 +0000 (UTC)
Received: by ghoffman-na.rmtde.csb (Postfix, from userid 11758)
 id 713C840775D5; Thu, 03 Sep 2026 11:47:13 +0200 (CEST)
Date: Thu, 3 Sep 2026 11:47:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org, 
 jgg@nvidia.com, skolothumtho@nvidia.com, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <apk_QiR3FDiMndgI@ghoffman-na.rmtde.csb>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
 <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
 <37f31842-e79a-4089-82ad-8003fd47fdb8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f31842-e79a-4089-82ad-8003fd47fdb8@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> > Also note that OVMF already has an incompatible pci device driver and
> > there can be only one instance, so the code must be merged into the
> > existing driver instead of adding a second.
> 
> I checked OvmfPkg/IncompatiblePciDeviceSupportDxe -- its CheckDevice()
> is unconditional, it returns the same 64-bit-MMIO-preference descriptor
> for every device regardless of VendorId/DeviceId. Merging Fixed BAR
> design in would make it a simple dispatch: if the device has an entry in
> the fw_cfg blob we export, return our descriptor; otherwise fall through
> to the existing behavior unchanged. Does that match what you had in
> mind, or is there a different integration point you'd prefer?

For the most part yes.

I'd suggest to keep the fixed-bars code in a separate source file,
then just add a small dispatch hook to the existing CheckDevice
function.  In case there is a fixed-bars entry use that instead of the
hardcoded template.

The option rom tweak for confidential VMs should be applied to the
fixed-bars entries too, so don't return early.

take care,
  Gerd


