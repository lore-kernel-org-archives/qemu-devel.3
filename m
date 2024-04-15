Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB48C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 12:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwL0J-0007k2-I5; Mon, 15 Apr 2024 08:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwL0I-0007jp-0J
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwL0E-0000M3-3W
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713182397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fvU8E3B83BnGdeHugFlEaCsPpS0YttDvgUvXtVZb1sY=;
 b=Jfe7AQgfqPieDAUGZj2Pg+ohwSbdzy/up9q52jSzXo7NuSd6orABqWm57qsN4AULpb1Oo6
 7/Tvca1jIeut/gh8hWOdeKJIIdxDhF9/FZqpBbEBk7UHPcnhdU1XTgwhrgf82T5mG8WFBj
 w/qyRV5JatxKyn4MNHD20Ah5+yJ6UUA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Papqf8NGO0KHgnH3oYmTJg-1; Mon,
 15 Apr 2024 07:59:53 -0400
X-MC-Unique: Papqf8NGO0KHgnH3oYmTJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE4F1C07F20;
 Mon, 15 Apr 2024 11:59:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B26341121313;
 Mon, 15 Apr 2024 11:59:50 +0000 (UTC)
Date: Mon, 15 Apr 2024 12:59:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cole Robinson <crobinso@redhat.com>
Subject: Re: secure boot & direct kernel load (was: Re: [PATCH] x86/loader:
 only patch linux kernels)
Message-ID: <Zh0WsG3nVHgTwOkc@redhat.com>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
 <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 10, 2024 at 12:35:13PM +0200, Gerd Hoffmann wrote:
> On Wed, Apr 10, 2024 at 03:26:29AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 10, 2024 at 09:21:26AM +0200, Gerd Hoffmann wrote:
> > > If the binary loaded via -kernel is *not* a linux kernel (in which
> > > case protocol == 0), do not patch the linux kernel header fields.
> > > 
> > > It's (a) pointless and (b) might break binaries by random patching
> > > and (c) changes the binary hash which in turn breaks secure boot
> > > verification.
> > > 
> > > Background: OVMF happily loads and runs not only linux kernels but
> > > any efi binary via direct kernel boot.
> > > 
> > > Note: Breaking the secure boot verification is a problem for linux
> > > kernels too, but fixed that is left for another day ...
> > 
> > Um we kind of care about Linux ;)
> > 
> > What's the plan?  I suspect we should just add a command line flag
> > to skip patching? And once we do that, it seems safer to just
> > always rely on the flag?
> 
> Well, there are more problems to solve here than just the patching.  So
> lets have a look at the bigger picture before discussion the details ...
> 
> [ Cc'ing Daniel + Cole ]
> 
> Current state of affairs is that OVMF supports two ways to boot a linux
> kernel:
> 
>  (1) Just load it as EFI binary and boot via linux kernel EFI stub,
>      which is the modern way to load a linux kernel (which is why you
>      can boot not only linux kernels but any efi binary).
> 
>  (2) Use the old EFI handover protocol.  Which is the RHEL-6 era way to
>      boot a linux kernel on EFI.
> 
> For method (1) secure boot verification must pass.  For (2) not.  So if
> you try to use direct kernel boot with secure boot enabled OVMF will
> first try (1), which will fail, then go fallback to (2).
> 
> The reason for the failure is not only the patching, but also the fact
> that the linux kernel is typically verified by shim.efi (and the distro
> keys compiled into the binary) instead of the firmware.
> 
> Going though (2) is not ideal for multiple reasons, so we need some
> strategy how we'll go handle direct kernel load with uefi and secure
> boot in a way that (1) works.
> 
> Options I see:
> 
>   (a) Stop using direct kernel boot, let virt-install & other tools
>       create vfat boot media with shim+kernel+initrd instead.
> 
>   (b) Enroll the distro signing keys in the efi variable store, so
>       booting the kernel without shim.efi works.
> 
>   (c) Add support for loading shim to qemu (and ovmf), for example
>       with a new '-shim' command line option which stores shim.efi
>       in some new fw_cfg file.

The problem with this is that now virt-install  has to actually
find the correct a shim.efi binary. It is already somewhat hard
to find a suitable kerenl+initrd binary, and AFAIK, the places
where we get these binaries don't have shim.efi alongside.

eg for RHEL/Fedora we grab kernel+initrd from the pxeboot dir:

  https://fedora.mirrorservice.org/fedora/linux/development/rawhide/Everything/x86_64/os/images/pxeboot/

This same problem with affect both options (a) and (c).

In various forums we have discussed adding the secureboot
certs to the libosinfo database, so that we can have a
customized EFI varstore with minimized certs, even for the
ISO / HDD boot scenario. If we do that, then (b) is trivial
for direct kernel boot too. (b) kills all birds with the
same stone :-)

> 
> (b) + (c) both require a fix for the patching issue.  The options
> I see here are:
> 
>   (A) Move the patching from qemu to the linuxboot option rom.
>       Strictly speaking it belongs there anyway.  It doesn't look
>       that easy though, for qemu it is easier to gather all
>       information needed ...
> 
>   (B) Provide both patched and unpatched setup header, so the
>       guest can choose what it needs.
> 
>   (C) When implementing (c) above we can piggyback on the -shim
>       switch and skip patching in case it is present.
> 
>   (D) Add a flag to skip the patching.
> 
> Comments?  Other/better ideas?

I guess (b) + (D) is probably my preference.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


