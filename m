Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F4C04FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMQ6-00047x-Rc; Mon, 15 Apr 2024 09:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rwMQ3-00047i-VY
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rwMPz-0002y7-PS
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713187842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rqVjjTtTygb49WdcsR/QtMO3T69J6pmxsmOvGBIuTHw=;
 b=PtmjzdUM1BJFRRlFnyIAYEUwOvyrtxxPhQZm4tF3pjj7X8ePH9tQlYMmKnw5p2DUvrAYI0
 ERhC503NtU996NaiEyte3iiaGJKwySSuOjPPMNdfOSYVsMCMrNxJ7Fp9nYk70kuQycc+4s
 qOwlR5DO0Tzfwqg9K9tkRuQLjSiNg7s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-_eOsGaqAMH2I0H_Yuds-zg-1; Mon,
 15 Apr 2024 09:30:38 -0400
X-MC-Unique: _eOsGaqAMH2I0H_Yuds-zg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10BEC28C97DC;
 Mon, 15 Apr 2024 13:30:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D0FE1C066BB;
 Mon, 15 Apr 2024 13:30:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5CE8318014BC; Mon, 15 Apr 2024 15:30:32 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:30:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cole Robinson <crobinso@redhat.com>
Subject: Re: secure boot & direct kernel load (was: Re: [PATCH] x86/loader:
 only patch linux kernels)
Message-ID: <asxsrqicnilb5wszzz23ebuidyqacmasb4ggtflcksdlufrspc@23x4k2gqge6r>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
 <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
 <Zh0WsG3nVHgTwOkc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh0WsG3nVHgTwOkc@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > Options I see:
> > 
> >   (a) Stop using direct kernel boot, let virt-install & other tools
> >       create vfat boot media with shim+kernel+initrd instead.
> > 
> >   (b) Enroll the distro signing keys in the efi variable store, so
> >       booting the kernel without shim.efi works.
> > 
> >   (c) Add support for loading shim to qemu (and ovmf), for example
> >       with a new '-shim' command line option which stores shim.efi
> >       in some new fw_cfg file.
> 
> The problem with this is that now virt-install  has to actually
> find the correct a shim.efi binary. It is already somewhat hard
> to find a suitable kerenl+initrd binary, and AFAIK, the places
> where we get these binaries don't have shim.efi alongside.
> 
> eg for RHEL/Fedora we grab kernel+initrd from the pxeboot dir:
> 
>   https://fedora.mirrorservice.org/fedora/linux/development/rawhide/Everything/x86_64/os/images/pxeboot/

shim is https://fedora.mirrorservice.org/fedora/linux/development/rawhide/Everything/x86_64/os/EFI/BOOT/BOOTX64.EFI

> In various forums we have discussed adding the secureboot
> certs to the libosinfo database, so that we can have a
> customized EFI varstore with minimized certs, even for the
> ISO / HDD boot scenario.

Well.  It's not that easy unfortunately.  At least the "minimized certs"
part.  shim often is signed with the microsoft keys only, so you can't
drop that without rendering the install.iso unbootable.

Only adding the distro certs without removing the microsoft certs works
of course.

> If we do that, then (b) is trivial for direct kernel boot too.

Yep.

> (b) kills all birds with the same stone :-)

See above.  I'd love this being true but it is not.

> > (b) + (c) both require a fix for the patching issue.  The options
> > I see here are:
> > 
> >   (A) Move the patching from qemu to the linuxboot option rom.
> >       Strictly speaking it belongs there anyway.  It doesn't look
> >       that easy though, for qemu it is easier to gather all
> >       information needed ...
> > 
> >   (B) Provide both patched and unpatched setup header, so the
> >       guest can choose what it needs.
> > 
> >   (C) When implementing (c) above we can piggyback on the -shim
> >       switch and skip patching in case it is present.
> > 
> >   (D) Add a flag to skip the patching.
> > 
> > Comments?  Other/better ideas?
> 
> I guess (b) + (D) is probably my preference.

I prefer (B) over (D) because that doesn't require a new config option
(which probably needs support in libvirt and possibly higher up in the
management stack too ...).

Patch series implementing (B) and the -shim switch:
https://lore.kernel.org/qemu-devel/20240411094830.1337658-1-kraxel@redhat.com/

Using -shim is optional, so it's up to virt-install whenever it wants go
for (b) or (c).

take care,
  Gerd


