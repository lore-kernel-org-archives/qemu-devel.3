Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3CBC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x23re-0002Nb-Lf; Thu, 03 Sep 2026 05:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x23rd-0002NF-1n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x23rb-0002uK-H1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788428166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EecrlBQ6CcZhNOXjt9jo7loyZhW1/8BR41VDT/VzEjw=;
 b=Ah7MAG9noCbI/bF9VsimyOuHuEi12djoildPD1cfC4xa0bOvFCFnWoccvI1p+WH4Swa91Y
 Y1gDT8faa4/bRgZPYp5k8PAwJQCZOAhnJqpBW7f1Clam1KnEGnuFnfq5nVkGLLEuKDmawt
 38ejI9JFOCG10MSmRegVCjqM2QVtvU8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-c4MHt4UVOpKK09fxc7H8nw-1; Thu,
 03 Sep 2026 05:34:49 -0400
X-MC-Unique: c4MHt4UVOpKK09fxc7H8nw-1
X-Mimecast-MFC-AGG-ID: c4MHt4UVOpKK09fxc7H8nw_1788428081
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35CB4195F175; Thu,  3 Sep 2026 09:34:41 +0000 (UTC)
Received: from ghoffman-na.rmtde.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C1CE1956049; Thu,  3 Sep 2026 09:34:40 +0000 (UTC)
Received: by ghoffman-na.rmtde.csb (Postfix, from userid 11758)
 id 0C11740775D5; Thu, 03 Sep 2026 11:34:37 +0200 (CEST)
Date: Thu, 3 Sep 2026 11:34:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org, jgg@nvidia.com, 
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
Message-ID: <apk3NaZe9DQFzSDu@ghoffman-na.rmtde.csb>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
 <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
 <20260902092426.4906e932@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902092426.4906e932@shazbot.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> > You still can have fixed-bar-<nr>=<addr> properties to override the
> > auto-discovered address for some or all pci bars.
> 
> If QEMU is willing to accept both a generic PCI mechanism to specify
> this, AND a vfio-pci shortcut, sure, we can create the shortcut.

I think this makes sense, but at the end of the day I'm not the pci
maintainer, so this is not my call.

> As above though, it's also something the caller can construct
> relatively easily (maybe not by hand, but with a trivial script)

Then everybody who wants / needs this reinvents such a script.
Do we really want that?

> > Nevertheless I'd tend to only expose the properties for devices where an
> > actual use case exists.  Which is obviously vfio-pci(-fixed).  Also
> > pci-testdev for development / testing / CI.  I can't see much beyond
> > that though.
> 
> I always imagined the properties would live on the core PCI device and
> at best vfio-pci would have a shortcut to prefill those properties
> based on physical BAR address.  pci-testdev is pretty limited and we
> can't fully test arbitrary device functionality with it.  We'd also
> lose the ability to diverge from the host programming if we need to
> debug a layout generated on another system.
> 
> IMO, the artificial restriction isn't worth it, especially in the
> proposed environment where we enforce and validate fixed BAR
> configurations for an entire PCI sub-tree.  I think that already
> eliminates the most common usage failures we'd see otherwise.

Fair enough.

take care,
  Gerd


