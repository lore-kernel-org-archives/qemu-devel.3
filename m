Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC824C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAi8-0001Zr-4u; Fri, 10 Jul 2026 08:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wiAi0-0001ZZ-9J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wiAhw-0004dY-DW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783687915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hL4FnZyN6daSqKYgIN14TAROTFTV6MHl4gO95rMlBZU=;
 b=hyVcPy4fIsLunK+VESiDxrjZDEmEUIR+nwVtyIw6MRIPDxzkYStSaicNA4lE0HeYni9Bv8
 I2qCU/BQtoiXNcUjQ9WD/HyeKDn4D4hAVOTzcBY2OX3ly32u4CqFa3xKNcBcfAahlJ1gQx
 8zkKNtRzMQWr9rEq8K/ur6r7t/LcBNc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-2DTu0Na6PVWDQssuIvKg0Q-1; Fri, 10 Jul 2026 08:51:53 -0400
X-MC-Unique: 2DTu0Na6PVWDQssuIvKg0Q-1
X-Mimecast-MFC-AGG-ID: 2DTu0Na6PVWDQssuIvKg0Q_1783687913
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493ce08a6b4so7137655e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783687912; x=1784292712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hL4FnZyN6daSqKYgIN14TAROTFTV6MHl4gO95rMlBZU=;
 b=D+8WuSfVcKhwACEoSR/SWGkYlNdEVNVkjkGdsjMfIosZz726Vv0Ylq/iuJ5jUFbwYN
 yG2UANnEFEzfTHFZkgdwwFF4m3A7y5/eU2er+WCrNaDKeTqj7otszjfaW596fD+9WKH5
 C0WoWuzCColmLkL2c/UPcJdoFmK5L/bJjkPP/mBuOwaIUorgf35nXEIeayP4MG2efGRj
 oh+7lprQwCSOKC5jT60tDJ+Tu9x7kd/p4qEEEL0tonIqJc1GAHQodvkD5jMoBB2pxrLY
 FWKc24eKC/U0Bw36eYbzNq0e4XxLGixHXR9xUO1o7gM1NoMOA4f9P1WMe+ybeSVNHuF/
 CZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783687912; x=1784292712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hL4FnZyN6daSqKYgIN14TAROTFTV6MHl4gO95rMlBZU=;
 b=NergBcIWr5NVClTAF/CDg/QAw4zstIYHs3oX7bG38v23uhn3rCD0UJBI6lk+LwJLmr
 DQSvybfxsNXYmsOQIf8Q2hEz2a7OoP4nSDAofar1m/2v4uQ9uMF4IzkXY6Ophm+L1fI5
 HN5qkWSsMP8zBYnmaSmQflQ0Z/ujf1RRv7a+qw5dEbo8ROewgPXLUmCEPWBNxbSXhukN
 XBmLldCVIV9d/FlUWeDLPFXSOzFUM8Xv+dUSPPLbhB/OXHo59DyBxrakbQJBgv9TsbB9
 2NZCl6DnrvjtZUkJa1Q2N7n7SPZ39OGHlHR63/pSIizCbylAmAPuJ8hTtpjuO/bWBUDD
 DU5Q==
X-Gm-Message-State: AOJu0Yw0roFULO4FucNHLLbTfr9bSzmHY36qsYGI6/gqOocvBYV8M7kZ
 8CBBaQsrv3v12v0R8fYb+K51a4zwL2j5NqZ/JPDMH+hdIp2Y94sWzt49Y+MRyRRs/ZCRuCffQ76
 DWWmo4iN2HlF9MdYYssSlMqg2Mc2W0Fe5WYs7ziA4t8yNO73X9SNjXmLBsEyqBow3
X-Gm-Gg: AfdE7cl07DZ9v5bIiUK88D783lIbF3cLc+RLmjiOW7BBKmTS3EKOih5HjA0hQZfedKp
 ppis7DsUrusv+SQ0N+sW04fsUO2XFp2BIQ7Roa2zXS0Bz987GP/hUq55xrnNBpCpC55RljInSkt
 n0q5/+d5vCCGwktUjMvhRBLYHWYfgz7Z/QFt9whOtFaoCD1IZr9zJbM4K8owQdEcgX49+qN1Gif
 6GQt8a+r0srP9qHXZSRhMdeTzVKbBvThOhlFL3OHIRkBBF9/vqxOVUcUo3BYukST+dqGtsneFfh
 iremSm65nicRWCBX1ibUoFB8pB82IWviI7vKJGTJQQPd3WHCnHT0oZKOQdFexGpy9Sck/W4=
X-Received: by 2002:a05:600c:c16d:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-493f4fd4a72mr22406445e9.7.1783687912452; 
 Fri, 10 Jul 2026 05:51:52 -0700 (PDT)
X-Received: by 2002:a05:600c:c16d:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-493f4fd4a72mr22406175e9.7.1783687911932; 
 Fri, 10 Jul 2026 05:51:51 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm61058638f8f.22.2026.07.10.05.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:51:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:51:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Jia Jia
 <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <20260710145149.6e077fdd@imammedo>
In-Reply-To: <2355649.iZASKD2KPV@weasel>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <6008134.DvuYhMxLoT@weasel> <20260710122345.6a6dd56e@imammedo>
 <2355649.iZASKD2KPV@weasel>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 10 Jul 2026 12:49:06 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
> > On Fri, 10 Jul 2026 10:06:29 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:  
> > > On Friday, 10 July 2026 09:37:37 CEST Igor Mammedov wrote:  
> > > > On Thu, 9 Jul 2026 15:50:36 +0200
> > > > 
> > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:  
> > > > > Harden security by disabling hotpluggable property, to prevent
> > > > > issues like fixed in the previous commit.
> > > > > 
> > > > > Virtio-9p is a pass-through file-sharing device that provides a
> > > > > guest mount of a host filesystem tree. Unlike block or network
> > > > > devices, guest-triggered hotplug of the 9p device has no practical
> > > > > use case: the guest cannot recover from the device removal, and there
> > > > > is no protocol-level device-loss scenario as with block or ethernet
> > > > > devices.  
> > > > 
> > > > hmh, I'm no maintainer of 9pfs, but to me it looks like any other
> > > > storage device.
> > > > One should be able to unmount/stop using it and unplug
> > > > (it doesn't really matter if unplug is triggered by guest or host side).  
> > > 
> > > Guest could still unmount and stop using the 9pfs device. But why should
> > > guest be able to unrealize the 9pfs device at any time? What should be
> > > the purpose for this particular device?  
> > 
> > unrealize is part of unplug process, at the end of unplug no device should
> > be left attached. You might not need/use it but others might be using it
> > actively.  
> 
> I got that, but my question was: why would they want to do that with an 9pfs 
> device? Can you make up any real-life scenario why a guest might want to 
> remove a 9p device, given there is no way for them to bring the device back?

note: I'm looking from pov of hotpluggable PCI device and generic hotplug infra, only.

it's not guest users directly, it's how hotplug flow works for various guest OSes:

1. host plugs device in (-device or device_add)
2. guest OS get's notified one way or another and does what ever guest side
   init needed (incl. mounting share in 9pfs case)

opposite flow:
1. host does device_del (basically notify guest to remove device)
2. guest OS frees resources and tells qemu to delete device 
3. qemu process remove event (which incl. unrealize as part of destroying device)

Of cause guest if free to eject device without signal from host,
(I could imagine: get some file from share once and then guest releases
no longer need resource).
 
> Looking at the fixed issue (patch 1), my impression was that original 9p 
> server developers were unaware that guest can actually trigger a device 
> unrealize via ACPI eject.

I'd say it's a bug, and you are trying to fix it in patch #1

> Most probably because hotplugging is enabled by 
> default for all devices in QEMU

it is on by default for PCI devices but also heavily depends on used
configuration (where/what is plugged).

> Independent of this patch here, I'm therefore currently investigating whether 
> enabling hotplugging by default in QEMU actually make sense. To me, this 
> should be an opt-in, not the other way around. Because device developers 
> should make sure that ejecting a device a) makes sense for the device type in 
> the first place and most importantly b) that ejecting the device works 
> (without data loss and without negative security impact, as it was the case 
> here).

well, hotplug is on by default for PCI devices. It is unlikely we would
flip default now.

It might make sense to disable hotplug in mmio frontend if such exists,
but then it's pointless as there is no way to trigger unplug for it
(both host or guest side)

> 
> > ---
> > 
> > In QEMU impl. it's cooperative process (we don't do surprise removal of PCI
> > devices), where host triggers plug/unplug process and guest side completes
> > it, by: 1. freeing resources on its side 1st (hopefully)
> >   2. issuing eject/poweroff (either via ACPI or native PCIE-HP/SHPC
> > interface)
> > 
> > If guest fails to do #1 it is able to abort process, or it might continue
> > and do #2 with a risk of loosing data but it's guest's business/policy.
> > 
> > If you need to disable hotplug for a specific PCI device instance,
> > use 'hotplug' CLI option on pcie bridge. If you use other than PCI variant
> > of virtio device, then unplug as you describe it isn't reachable, and if it
> > should be disabled in code, it's up to actual frontend device that exposes
> > underlying virtio one.  
> 
> What does that have to do with this issue here? The normal 9pfs live-cycle is 
> to create the 9p device at QEMU startup, and unrealizing the 9p device at QEMU 
> shutdown.
> 
> If guest does an ACPI eject, then the only way to bring the 9p device back is 
> to restart QEMU with the required -virtfs / -fsdev -device CLI options.

one can use device_add to put it back into running machine.

given mention of ACPI eject, 9pfs flavor actually used is PCI variant =>
all PCI device features apply incl. hot(un)plug.
If hotplug is not desirable for particular device instance, one can disable
it on CLI.

that said,
if 9pfs maintainer deem that it shouldn't be hotpluggable and it's
safe to remove capability, I'm fine with that too, just fix commit message
section wrt QMP removal and perhaps move the flag into front-end impl of
the device.

BTW: always describe a way to reproduce problem (cover letter and/or patch)
so that reviewer could see whole flow. Otherwise one has to guess what/how it gets
broken based on context.
 
> The Linux 9p client (guest) does never trigger an ACPI reject on unmount. It 
> just marks the virtio channel as unused. If client would eject it, it would 
> not be possible for guest to re-mount it later on.

no argument here

> /Christian
> 
> 
> 
> 


