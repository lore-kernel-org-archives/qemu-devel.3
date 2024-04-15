Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEE5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMh8-0000L8-DR; Mon, 15 Apr 2024 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwMh7-0000Ih-4d
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwMgx-00065R-US
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713188894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XQhqI9hqCGfHwEpmyUUmTqBtqO74H2Di1XbdcnFk704=;
 b=bSBvOMhZnh9STxK/p2OeY1+LrNee2mBzw6Bije3AY4XiMplGEHnih8G47x9kCHdOiyhqZx
 z8KQTmze4tXusVbsEyUQjsClSDgxcE9QYvzL6Q1xmCdvqPTcEGHoRMLqU1fAmNbjUPj846
 nMUtUZg154QBC8oQPalUr8K1j3MlT+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-wuNxy6YrP4mnrLD4go1Cng-1; Mon, 15 Apr 2024 09:48:11 -0400
X-MC-Unique: wuNxy6YrP4mnrLD4go1Cng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C3D680D626;
 Mon, 15 Apr 2024 13:48:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3CE82026D06;
 Mon, 15 Apr 2024 13:48:09 +0000 (UTC)
Date: Mon, 15 Apr 2024 14:48:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cole Robinson <crobinso@redhat.com>
Subject: Re: secure boot & direct kernel load (was: Re: [PATCH] x86/loader:
 only patch linux kernels)
Message-ID: <Zh0wExsBiH4NxLcn@redhat.com>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
 <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
 <Zh0WsG3nVHgTwOkc@redhat.com>
 <asxsrqicnilb5wszzz23ebuidyqacmasb4ggtflcksdlufrspc@23x4k2gqge6r>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asxsrqicnilb5wszzz23ebuidyqacmasb4ggtflcksdlufrspc@23x4k2gqge6r>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Mon, Apr 15, 2024 at 03:30:32PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > Options I see:
> > > 
> > >   (a) Stop using direct kernel boot, let virt-install & other tools
> > >       create vfat boot media with shim+kernel+initrd instead.
> > > 
> > >   (b) Enroll the distro signing keys in the efi variable store, so
> > >       booting the kernel without shim.efi works.
> > > 
> > >   (c) Add support for loading shim to qemu (and ovmf), for example
> > >       with a new '-shim' command line option which stores shim.efi
> > >       in some new fw_cfg file.
> > 
> > The problem with this is that now virt-install  has to actually
> > find the correct a shim.efi binary. It is already somewhat hard
> > to find a suitable kerenl+initrd binary, and AFAIK, the places
> > where we get these binaries don't have shim.efi alongside.
> > 
> > eg for RHEL/Fedora we grab kernel+initrd from the pxeboot dir:
> > 
> >   https://fedora.mirrorservice.org/fedora/linux/development/rawhide/Everything/x86_64/os/images/pxeboot/
> 
> shim is https://fedora.mirrorservice.org/fedora/linux/development/rawhide/Everything/x86_64/os/EFI/BOOT/BOOTX64.EFI
> 
> > In various forums we have discussed adding the secureboot
> > certs to the libosinfo database, so that we can have a
> > customized EFI varstore with minimized certs, even for the
> > ISO / HDD boot scenario.
> 
> Well.  It's not that easy unfortunately.  At least the "minimized certs"
> part.  shim often is signed with the microsoft keys only, so you can't
> drop that without rendering the install.iso unbootable.
> 
> Only adding the distro certs without removing the microsoft certs works
> of course.

In that scenario libosinfo would report that the given OS
requires both the microsoft & $distro certs to be
enrolled.

Only if shim were signed by the $distro certs, would
libosifo omit reporting the microsoft certs.

Basically libosinfo would have to report whatever set
of 'n' certs are required to make boot work.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


