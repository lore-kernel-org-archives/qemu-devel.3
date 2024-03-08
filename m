Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62DCC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaIe-000261-8M; Fri, 08 Mar 2024 08:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1riaIb-00025R-DY
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1riaIV-0003kh-HA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709904602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBigzBSsPRz1gtnNtjGrUVoZLDHAEsI3bQhOrzQ8Bp8=;
 b=KdL467fXz5BxRSiux88zwDlsPw6C1ggahhpJJ97RTOkwiQpMRLWMovJpjYzcYHmvVvL19J
 ClCQjGOGkm28dbfDYyMe57aNT9GAsJRtzKcyqgHRwmPUvlUfOo3p613TZveMbNsRYKEvL6
 5mrMECoUgJdird+38E0gHV3kB7qP+MM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-9fID9KitNPyvCNTlI5zwIA-1; Fri, 08 Mar 2024 08:28:43 -0500
X-MC-Unique: 9fID9KitNPyvCNTlI5zwIA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a45ac612a4dso334097266b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709904522; x=1710509322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBigzBSsPRz1gtnNtjGrUVoZLDHAEsI3bQhOrzQ8Bp8=;
 b=SGtr+rivQuakAegT+m67+Sek5iI6sws0XKIUBDH+1gE3FjNoX3k5xUD8IaqyI3hr9s
 cLzU1eH4D66KK5fJQ57U5gkZfhK3OQApEfKci+NjvDZAr8u4Bx+ilAx1QEribLcp5Dph
 QL6gB+/FmVfXEFvelbF8Xn6E1/Q/UOvHEQ8O3xpyP0Z84QvLOusQOAjMs7n9kvQOJV5b
 RW48xZDJiF3280tWRX9ZQ6nH57LMg8eEDw50OVLFfAQxnOsFdczSZ2T/MT04UlVZCL4+
 T3XpCvoLmC9wOSaZsK+XDLGB2jsyZOez7semwyALRWR+haV6Y+tnXagLQcElJtStnIMz
 KrVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJY7lezjCrbmyPgiD36AWdJntwxbgZMVt8oCLCD/uOnYKrWkweE793JuRtfedfF6djtE/b5Kdw3OIOS1AMif1hEWrkESY=
X-Gm-Message-State: AOJu0Yx1oYPkZhDA1faxM9kuSdSEvI6WTBfEPVPgHhmfosLwOGEvv+x7
 +a1fL09++9EfW9vwKvMq/1auRN7FCpXwWAofbSpiMAdoa/HuEcuAALCaxeknUVVqi3oZyHgXRUc
 f4rfjVikRMasPJO2+pdgqaMW/efhnNxYKruBixh9ks066bct0nORUrFQuBLoclWQ4l4SthInLhq
 F22g3dnH+++nzZTaA8FgroguxZNh8=
X-Received: by 2002:a17:907:7e86:b0:a45:beca:9a08 with SMTP id
 qb6-20020a1709077e8600b00a45beca9a08mr310289ejc.27.1709904522351; 
 Fri, 08 Mar 2024 05:28:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfx/3uXJlMf9MhArXSSO/IkGtohfpuSXGmAN32UGS+/7c3ftDx1ymntm75Ds5kpgXsS0zXzkgTWvJ6dimiIaE=
X-Received: by 2002:a17:907:7e86:b0:a45:beca:9a08 with SMTP id
 qb6-20020a1709077e8600b00a45beca9a08mr310255ejc.27.1709904522013; Fri, 08 Mar
 2024 05:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
 <CAJaqyWdAFTkjGBJBmxvmTZT8UUiH86UGgE74X_bcq22nd-WwHA@mail.gmail.com>
 <20240306023143-mutt-send-email-mst@kernel.org>
 <CAJaqyWcDMu58H6P3FvyTM7L-GphLB1kj7fcOTBw6FC-O2DcpZA@mail.gmail.com>
In-Reply-To: <CAJaqyWcDMu58H6P3FvyTM7L-GphLB1kj7fcOTBw6FC-O2DcpZA@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 8 Mar 2024 21:28:05 +0800
Message-ID: <CAPpAL=xRiVfr4tObY_MwudQ0qyhWOqMzaHQaCdx7YtMnZc7GDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] virtio,
 vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, Eugenio Perez Martin <eperezma@redhat.com>,
 pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Jonah

QE tested this series v1 with a tap device with vhost=3Doff with
regression tests, everything works fine. And QE also add
"notification_data=3Dtrue" to the qemu command line then got "1" when
performing the command [1] inside the guest.
[1] cut -c39 /sys/devices/pci0000:00/0000:00:01.3/0000:05:00.0/virtio1/feat=
ures

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 7, 2024 at 7:18=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Mar 6, 2024 at 8:34=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Wed, Mar 06, 2024 at 08:07:31AM +0100, Eugenio Perez Martin wrote:
> > > On Wed, Mar 6, 2024 at 6:34=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Tue, Mar 5, 2024 at 3:46=E2=80=AFAM Jonah Palmer <jonah.palmer@o=
racle.com> wrote:
> > > > >
> > > > > The goal of these patches are to add support to a variety of virt=
io and
> > > > > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport featur=
e. This
> > > > > feature indicates that a driver will pass extra data (instead of =
just a
> > > > > virtqueue's index) when notifying the corresponding device.
> > > > >
> > > > > The data passed in by the driver when this feature is enabled var=
ies in
> > > > > format depending on if the device is using a split or packed virt=
queue
> > > > > layout:
> > > > >
> > > > >  Split VQ
> > > > >   - Upper 16 bits: shadow_avail_idx
> > > > >   - Lower 16 bits: virtqueue index
> > > > >
> > > > >  Packed VQ
> > > > >   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> > > > >   - Lower 16 bits: virtqueue index
> > > > >
> > > > > Also, due to the limitations of ioeventfd not being able to carry=
 the
> > > > > extra provided by the driver, ioeventfd is left disabled for any =
devices
> > > > > using this feature.
> > > >
> > > > Is there any method to overcome this? This might help for vhost.
> > > >
> > >
> > > As a half-baked idea, read(2)ing an eventfd descriptor returns an
> > > 8-byte integer already. The returned value of read depends on eventfd
> > > flags, but both have to do with the number of writes of the other end=
.
> > >
> > > My proposal is to replace this value with the last value written by
> > > the guest, so we can extract the virtio notification data from there.
> > > The behavior of read is similar to not-EFD_SEMAPHORE, reading a value
> > > and then blocking if read again without writes. The behavior of KVM
> > > writes is different, as it is not a counter anymore.
> > >
> > > Thanks!
> >
> >
> > I doubt you will be able to support this in ioeventfd...
>
> I agree.
>
> > But vhost does not really need the value at all.
> > So why mask out ioeventfd with vhost?
>
> The interface should not be able to start with vhost-kernel because
> the feature is not offered by the vhost-kernel device. So ioeventfd is
> always enabled with vhost-kernel.
>
> Or do you mean we should allow it and let vhost-kernel fetch data from
> the avail ring as usual? I'm ok with that but then the guest can place
> any value to it, so the driver cannot be properly "validated by
> software" that way.
>
> > vhost-vdpa is probably the only one that might need it...
>
> Right, but vhost-vdpa already supports doorbell memory regions so I
> guess it has little use, isn't it?
>
> Thanks!
>
> >
> >
> >
> > > > Thanks
> > > >
> > > > >
> > > > > A significant aspect of this effort has been to maintain compatib=
ility
> > > > > across different backends. As such, the feature is offered by bac=
kend
> > > > > devices only when supported, with fallback mechanisms where backe=
nd
> > > > > support is absent.
> > > > >
> > > > > Jonah Palmer (8):
> > > > >   virtio/virtio-pci: Handle extra notification data
> > > > >   virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DAT=
A
> > > > >   virtio-mmio: Handle extra notification data
> > > > >   virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DA=
TA
> > > > >   virtio-ccw: Handle extra notification data
> > > > >   virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DAT=
A
> > > > >   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost featu=
re bits
> > > > >   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
> > > > >
> > > > >  hw/block/vhost-user-blk.c    |  1 +
> > > > >  hw/net/vhost_net.c           |  2 ++
> > > > >  hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
> > > > >  hw/s390x/virtio-ccw.c        |  6 ++++--
> > > > >  hw/scsi/vhost-scsi.c         |  1 +
> > > > >  hw/scsi/vhost-user-scsi.c    |  1 +
> > > > >  hw/virtio/vhost-user-fs.c    |  2 +-
> > > > >  hw/virtio/vhost-user-vsock.c |  1 +
> > > > >  hw/virtio/virtio-mmio.c      | 15 +++++++++++----
> > > > >  hw/virtio/virtio-pci.c       | 16 +++++++++++-----
> > > > >  hw/virtio/virtio.c           | 18 ++++++++++++++++++
> > > > >  include/hw/virtio/virtio.h   |  5 ++++-
> > > > >  net/vhost-vdpa.c             |  1 +
> > > > >  13 files changed, 68 insertions(+), 17 deletions(-)
> > > > >
> > > > > --
> > > > > 2.39.3
> > > > >
> > > >
> >
>
>


