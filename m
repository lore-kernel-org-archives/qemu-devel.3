Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8BDC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWmP-0007M5-TY; Tue, 30 Jun 2026 07:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWmN-0007LI-So
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWmL-00032W-P4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782819443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sf6p9G9j8A43sIXPltAi3N3cQ9omvNQXTuwOprLsRA0=;
 b=TbfO0rnGNth9lSckk8wF6Wic+12cIkbFkBi14jOxUEXO3z0Nm55FwZVOta9A3jss2hYLp0
 ssb5JoIElrsnRd43tv6HudJW1as2d5TKsXXN+sy4VfqPDB+CpPHvPqFPMleBGYM2qBu+8l
 JCegSMeG4IwLPh6EMphjWieweJE+IyY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-JrxEqm8iOcWTqx-VT3XG6Q-1; Tue, 30 Jun 2026 07:37:21 -0400
X-MC-Unique: JrxEqm8iOcWTqx-VT3XG6Q-1
X-Mimecast-MFC-AGG-ID: JrxEqm8iOcWTqx-VT3XG6Q_1782819440
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-495ec502618so1116067b6e.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782819440; cv=none;
 d=google.com; s=arc-20260327;
 b=INTS4V0eb5SUacQ3DMRyp9+CMt6M9+rs+rECeboa1BPEOw7h6kFfxeMKrRMBKlkdGa
 AaB/NnIkvY5GPApdXlJvtz1A9/DvQ/AulZI8p7dzLH3Tv2hFv13Z2ZxRI0zDGKGHmeXv
 Hlc0YsPEvP0okdP0QkV15KmSi2HKjv55vJXNT6BJCCG0PbpDm5x2tBGucz3b2EkPRlY3
 BSm52tWzpE5XW5EDQXlHlKiGuFrTP06f664fg1ol9h4kdpx7BAtJGXWfddId5XRl7KFx
 9L4VeQ+r7HPEEIUF1m0eszyLCt7KcBPwrMK7EYu0chRp9aZPZ5EbqhSorocqvgAwBmgy
 86Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Sf6p9G9j8A43sIXPltAi3N3cQ9omvNQXTuwOprLsRA0=;
 fh=bWPxEW+ITVZKDZFiS9Q8TNY6/NdWgKU3j6S30HsfT7U=;
 b=Z5jNDCzGevAgri6OzVRTvdL0fBVm++btk9lJts9yLzfVNND28/HiXkZBQClGoWzQz6
 mXZCC8GAycR9dv/A0zacu7NJSCMerJLj6QavM1yLCozShgGsmWk3gwZrW/QVRKMkA3xq
 MdIj5E6yNAUbQjUc2jp8nLcyxxVwqCpf3HS3yTXwI3yPQsq5zfmpOB6uZaQ4UTgQboUY
 3nTzEL3gT+XZ6MPoASrS0iRVTOGdf3ltvOBpmWTOTOD4xg1CyHO/i6m15+iMNJh9UQlf
 xwJKQDQT6Q4I3Npuufe127xAW4oRv2dngvuocNNCLR7z4CTl9buF+iD3b/AJ/7sT8wDF
 waSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782819440; x=1783424240; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sf6p9G9j8A43sIXPltAi3N3cQ9omvNQXTuwOprLsRA0=;
 b=olaqTMyK1BS2KqDgTOqDuEjDIGU942sLWokoQNF43I3D7AtG7ksxuQSkG91ZjT19GP
 COPJw0kD6/kAEkEewoCrw812OSlUyUCxIbgtauoCNhV/WMfkNG830ArC+LnUGCuk80p7
 hRg70Y9qdIpRlGzZATo1Rn4hitfsd+K2QXEVFRgDYRntZuCpWRZvJI030FPiHncEWrrF
 HIi6Aoj1mqunh/da8TD7fH3ihA6a+gfb5uDLVMU/gnO1bi9KRL0zU/UVIRYumYbP+NMB
 8NjU7usoGYXCS7QX9+Mxc2gIU4ZHwOt61QQi1s39vkM4yBbd0GkuK0z4WLOEkri3dlL1
 mZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782819440; x=1783424240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sf6p9G9j8A43sIXPltAi3N3cQ9omvNQXTuwOprLsRA0=;
 b=pynSEyJGAj1GhNWqwWLrDkh4iDNGfgftANpC5RkYx4MzHrHiejdy9iG7BCv9phMAWX
 xu0Qd99/t5WnHg2+ZiwS1GoeOY3atYN6lXel+eA/WwoPhjUmGGtVpUucAtfkGUl41Epa
 ObCR8trQNVlWP1LDn82eYdcFmh8CUQVtREbx2DL9vrkU2kjmRZMO+y17+aFtAnMURgQB
 SwqEZJTDN9iSKiHyTFJ7X74oJS+jz5e3NbhB2ZfZsVsZHUVW6yzeDfJv5tx1NGy6k8IE
 MsEeuwBk6hXbwmc/QHRxYOL1BQIUY/pyYlzJuUNyWtGJLL2qYkBogJWyWOw/f4POGv6q
 xc0Q==
X-Gm-Message-State: AOJu0YwyEs9lCmbgdUgOFcC+OPDLj5IQqKpOt4b74GVqO6LVKxLWPMWp
 d4i2LhY5JRWkqfz3BYK/prsTDyjEdOi9bIID3nqW4ZPRQKi9KSOzOOnpWYv37C4t066Oe1MxlHu
 V4syxYnbI1//28ZJ9x969JcGdTszp808S8bR2moiUD+6wsacQVghkv+0cEawlbbkjM1FyIHorTz
 UAfbrSb54YeCy74na2iL18sYDPG3L8EbQ=
X-Gm-Gg: AfdE7ckh5EmY0pToNI7nRcX9lVNaGkCWBkV0JkoaoAPR+a35nCeRDMx/3JFTTGzcpGI
 HdMtbMfVuNPMq60MSCyukzYXM30Msa1pdp/dwR/mKZ+/svF8Q/BqWT3R7fEt6HA52c/Yv4uE0GI
 BHl5AwuDAKTrtISe/UcJiThSRhJstLk0tItYwKYSeY5CuCtNdK5cPT1FUvm5BehItb
X-Received: by 2002:a05:6808:2224:b0:492:5b42:ab02 with SMTP id
 5614622812f47-495eaddc57bmr3100476b6e.0.1782819440193; 
 Tue, 30 Jun 2026 04:37:20 -0700 (PDT)
X-Received: by 2002:a05:6808:2224:b0:492:5b42:ab02 with SMTP id
 5614622812f47-495eaddc57bmr3100436b6e.0.1782819439634; Tue, 30 Jun 2026
 04:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260630112310.552606-1-aesteve@redhat.com>
 <20260630112310.552606-3-aesteve@redhat.com>
 <akOoPD_P51HDn-Jo@redhat.com>
In-Reply-To: <akOoPD_P51HDn-Jo@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 30 Jun 2026 13:37:07 +0200
X-Gm-Features: AVVi8CeKEX9tdcLIZOFMIEKJ6TC3AZ4oMlPxd_lWjRPXN8GERhdVdGtIccgjew8
Message-ID: <CADSE00LM5d9oNSvRVy3ebsteH0mJJXS-VLVLJyATeM+1m4ab8A@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/display: add vhost-user-media device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 1:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Jun 30, 2026 at 01:23:09PM +0200, Albert Esteve wrote:
> > Add the QEMU side of the vhost-user-media device, which connects to a
> > virtio-media vhost-user backend daemon implementing the V4L2 API over
> > the virtio-media protocol.
> >
> > The virtio-media device is specified in the VirtIO specification v1.4,
> > section 5.22:
> >     https://docs.oasis-open.org/virtio/virtio/v1.4/cs01/virtio-v1.4-cs0=
1.html
> >
> > Tested with the rust-vmm vhost-device-media backend [1]:
> >
> >     cargo run -- -s /path/to/media.sock -d /dev/video0 --backend v4l2-p=
roxy
> >
> > Example invocation:
> >
> >     qemu-system-x86_64 \
> >         -chardev socket,path=3D/tmp/media.sock,id=3Dmedia \
> >         -device vhost-user-media-pci,chardev=3Dmedia,id=3Dmedia
> >
> > [1] https://github.com/rust-vmm/vhost-device/pull/944
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/display/Kconfig                   |   5 +
> >  hw/display/meson.build               |   3 +
> >  hw/display/vhost-user-media-pci.c    |  77 ++++++
> >  hw/display/vhost-user-media.c        | 393 +++++++++++++++++++++++++++
> >  hw/virtio/virtio.c                   |   3 +-
> >  include/hw/virtio/vhost-user-media.h |  47 ++++
> >  6 files changed, 527 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/display/vhost-user-media-pci.c
> >  create mode 100644 hw/display/vhost-user-media.c
> >  create mode 100644 include/hw/virtio/vhost-user-media.h
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index b3593fe981..060274b1e6 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -120,6 +120,11 @@ config VHOST_USER_VGA
> >      default y
> >      depends on VIRTIO_VGA && VHOST_USER_GPU
> >
> > +config VHOST_USER_MEDIA
> > +    bool
> > +    default y
> > +    depends on VIRTIO && VHOST_USER
> > +
> >  config DPCD
> >      bool
> >      select AUX
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index ffecedbf70..214c047df6 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -37,6 +37,9 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files=
('next-fb.c'))
> >  system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> >  system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c')=
)
> >  system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
> > +system_ss.add(when: 'CONFIG_VHOST_USER_MEDIA', if_true: files('vhost-u=
ser-media.c'))
> > +system_ss.add(when: ['CONFIG_VHOST_USER_MEDIA', 'CONFIG_VIRTIO_PCI' ],
> > +  if_true: files('vhost-user-media-pci.c'))
> >
> >  stub_ss.add([files('acpi-vga-stub.c'), pixman])
> >  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
> > diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-=
media-pci.c
> > new file mode 100644
> > index 0000000000..ad9e3900a4
> > --- /dev/null
> > +++ b/hw/display/vhost-user-media-pci.c
> > @@ -0,0 +1,77 @@
> > +/*
> > + * Vhost-user MEDIA virtio device PCI glue
> > + *
> > + * Copyright Red Hat, Inc. 2024
>
> Have you really been hanging on to this new code for 2 years
> before posting ? Should this be 2026 ?

Yup! Rebasing/updating has been painful a few times. But it was
waiting for the specs to land, and the shared memory mapping patch.
And other developments in parallel (e.g., virtio_ids.h kernel header
is still in the process).

But to your point, yes, I will update the copyright in the next
version. It makes sense to match the copyright year to when it is
upstreamed.

BR,
Albert.

>
> > + * Authors: Albert Esteve <aesteve@redhat.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
>
> > diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-medi=
a.c
> > new file mode 100644
> > index 0000000000..5c627437e7
> > --- /dev/null
> > +++ b/hw/display/vhost-user-media.c
> > @@ -0,0 +1,393 @@
> > +/*
> > + * Vhost-user Media device
> > + *
> > + * Copyright Red Hat, Inc. 2024
>
> Same Q
>
> > + *
> > + * This is the boilerplate for instantiating a vhost-user device
> > + * implementing a virtio-media device.
> > + *
> > + * Authors:
> > + *     Albert Esteve <aesteve@redhat.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
>
> > diff --git a/include/hw/virtio/vhost-user-media.h b/include/hw/virtio/v=
host-user-media.h
> > new file mode 100644
> > index 0000000000..30bdef8ce1
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-user-media.h
> > @@ -0,0 +1,47 @@
> > +/*
> > + * vhost-user-media virtio device
> > + *
> > + * Copyright Red Hat, Inc. 2024
>
> Again
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


