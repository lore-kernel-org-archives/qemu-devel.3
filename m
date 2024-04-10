Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D14CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 15:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruZSX-00007e-FK; Wed, 10 Apr 2024 11:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruZS5-0008Uk-T3
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruZS1-0008T6-P0
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 11:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712761284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOMx7QHoEllo6WD1Lf9VfvRjTMMkqlxEXjGr6IWXg9Q=;
 b=KiEeWMGzOf1GP/EMcpIieaFfRq7j0SLxaHcXwDZuBAH/Z930KbczzSLZJ4NWcnyH2v6UMS
 tqn5nc8cIdYzzFDg8EcS+yhgBWu6QwP8kjubvq0gbuNGx0ylxUIAc5ZDDaNoO4BQlAHhCa
 z+F/eBY1mFQaKEMvI0slOZ8pQBdEgGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LYZ0Q7tdM12QiLLv4_XKiA-1; Wed, 10 Apr 2024 11:01:20 -0400
X-MC-Unique: LYZ0Q7tdM12QiLLv4_XKiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECBC31809EC5;
 Wed, 10 Apr 2024 15:01:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B0F1C0666C;
 Wed, 10 Apr 2024 15:01:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C68B718009BB; Wed, 10 Apr 2024 17:01:13 +0200 (CEST)
Date: Wed, 10 Apr 2024 17:01:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Daniel Berrange <berrange@redhat.com>, 
 Cole Robinson <crobinso@redhat.com>
Subject: Re: secure boot & direct kernel load (was: Re: [PATCH] x86/loader:
 only patch linux kernels)
Message-ID: <sskscm6i24dzowdpwo2devpktscpwv7gacv2z6b3r6zjvngkpl@ivrwlisbitkx>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
 <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
 <20240410070801-mutt-send-email-mst@kernel.org>
 <yndpkfhvaiclz2coihzlzsv3gjnzdtcksunvr5fvfudamc3v32@ahmxbypgk6f6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yndpkfhvaiclz2coihzlzsv3gjnzdtcksunvr5fvfudamc3v32@ahmxbypgk6f6>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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
> > > 
> > > (b) + (c) both require a fix for the patching issue.  The options
> > > I see here are:
> > > 
> > >   (A) Move the patching from qemu to the linuxboot option rom.
> > >       Strictly speaking it belongs there anyway.  It doesn't look
> > >       that easy though, for qemu it is easier to gather all
> > >       information needed ...
> > > 
> > >   (B) Provide both patched and unpatched setup header, so the
> > >       guest can choose what it needs.
> > > 
> > >   (C) When implementing (c) above we can piggyback on the -shim
> > >       switch and skip patching in case it is present.
> > > 
> > >   (D) Add a flag to skip the patching.
> > > 
> > > Comments?  Other/better ideas?
> > > 
> > > take care,
> > >   Gerd
> > 
> > So if you didn't decide whether to do b or c then I guess D is
> > easiest and covers both cases?
> 
> Easiest if you look at qemu only.  Adding a new config option adds
> burdens elsewhere though.  Users and the management stack have to
> learn to use the new option.
> 
> Both (A) and (B) work automatically and can be combined with both (b)
> and (c).  (B) is probably much easier to implement, drawback is it
> requires an firmware update too.

Sneak preview for (c) + (B) is here:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/direct-secure-boot

(well, almost, instead of unpatched setup header it exposes an unpatched
kernel binary).

Currently looking at the ovmf side of things to make sure the idea
actually works before posting patches to the list.

take care,
  Gerd


