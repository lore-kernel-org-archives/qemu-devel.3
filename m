Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34530D3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVh5-0007Wl-8B; Mon, 25 Nov 2024 04:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFVh3-0007Wc-0O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:47:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFVh0-0005RC-Do
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732528061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0g1lORZLriE0WE15MbaCvCtDy8BO0zUIG1q9btuAG8=;
 b=HnZGgDIQJQn5nW5d5n2nIZCDHqZWJLsGWVyB7tXYOAijbtp7O1wbTZNeqmLVlavpNw9kGQ
 WxbgBdcpcS2AwZXsp/e60ELwUINiMtdlTmG693L5apQ3zK49YwGANTLNiiW3VyxWR5J5pP
 wkDavy3372RaF8nYEm5RBfKVhtHIcIs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-HJZZ0vE2MjmT33bmDJ4R4A-1; Mon,
 25 Nov 2024 04:47:38 -0500
X-MC-Unique: HJZZ0vE2MjmT33bmDJ4R4A-1
X-Mimecast-MFC-AGG-ID: HJZZ0vE2MjmT33bmDJ4R4A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 447651955EE7; Mon, 25 Nov 2024 09:47:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92EAD195E481; Mon, 25 Nov 2024 09:47:35 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:47:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Anne Macedo <retpolanne@posteo.net>, qemu-devel@nongnu.org
Subject: Re: Onboarding QEMU Firmware Configuration to other machines
Message-ID: <Z0RHs89WxRFnZs2M@redhat.com>
References: <m2wmgsiudo.fsf@posteo.net>
 <CAFEAcA_ROEC7UkEzZ5v7FKYHajhLVKZuMAtzA2M8_Fj7KSZO0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_ROEC7UkEzZ5v7FKYHajhLVKZuMAtzA2M8_Fj7KSZO0A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, Nov 24, 2024 at 05:41:08PM +0000, Peter Maydell wrote:
> On Sun, 24 Nov 2024 at 14:24, Anne Macedo <retpolanne@posteo.net> wrote:
> > How should one port fw_cfg to other QEMU machines?
> >
> > Context:
> >
> > - I found a possible bug on the Debian builds for Raspberry Pi 4 that is
> >   only triggered when I try to launch it on QEMU;
> >
> > - I wrote an issue on systemd (I thought it had something to do with
> >   logind) and they requested me to only fill bugs if they show up on the
> >   upstream.
> >
> > - I tried baking systemd with mkosi – however, to test with mkosi and
> >   qemu, it uses fw_cfg [1] which seems specific to the virt machine on
> >   ARM.
> >
> > - Opened an issue [2] and started working on that [3]
> >
> > However, I still don't understand exactly how fw_cfg works. My current
> > understanding is that it is a device that, when connected some memory
> > mapping will happen on the guest so that it can access this memmap.
> >
> > TL;DR which steps should I take to onboard fw_cfg to machines such as
> > raspi4b?
> 
> fw_cfg is a device that is intended for setups where the guest
> knows it is running as a virtual machine. It provides a way
> for the guest to ask for e.g. particular files like a kernel
> for direct kernel boot, among other things. It's present on
> the Arm "virt" machine and on the x86 PC machine.
> 
> It doesn't and should not exist on the raspi4b model, because
> almost all QEMU machine types are supposed to model the real
> hardware, which doesn't have a fw_cfg.

To expand on this, by chance fw_cfg is visible to the guest OS, and thus
apps developers have (mis-)used this as a way to config data to the OS.
This should *not* be relied upon to work everywhere/anywhere. Adding it
to other targets / machines for general purpose application usage is a
non-goal for QEMU.

> I'm not sure exactly what mkosi is or does, but if it's supposed to be
> able to produce images that work with the raspberry pi then
> it needs to not require fw_cfg to exist (because on a real
> rpi it doesn't).

mkosi is a simple python tool for creating virtual disk images aka acronym
"MaKe Operating System Image".

What they need is a way to pass configuration metadata into the guest.

They already support a range of options, in order of preference looking
for SMBIOS (OEM strings),  fw_cfg, kernel command line:

  https://github.com/systemd/mkosi/blob/6c33859a1b445e0bff19d9e7f28158140893a3e4/mkosi/qemu.py#L1336

If none of those 3 options are viable, then a further option is to create
a virtual disk image containing a JSON file of the data needed and pass
that in. There are other options available too, virtiofs, 9p, usb-mtp,
virtio-serial, virtio-sock, all of which provide a ways to communicate
with the guest OS, with varying pros & cons. It is upto mkosi devs to
decide which best serve their needs, if they think their current 3 options
are insufficient.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


