Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75199CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slo6V-0005Ws-2H; Wed, 04 Sep 2024 07:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slo6T-0005P2-36
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slo6P-00029m-Nd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725448988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmylSsDXAxT+Pv/FJeIhD2/vlBnxT0mo79GWr7E19Pg=;
 b=SwTkhtBnKv/qs7+QyDHkmNy1a0VBvXJMY1pj4O2/YTaQbs4nU+dWncFk5XjA/X/i9oFFBZ
 +IgNnpZXwU+OizYcuISJ8wlrnD83xbxHG9JqvkXGJK0pshbeumbwzmnNZHO8rgTalvcZpi
 RtojGY3TZvgfNlap8kmOeUN1hltI84s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-MzgJqLTQPxe8c4A-Mxu0-w-1; Wed, 04 Sep 2024 07:20:22 -0400
X-MC-Unique: MzgJqLTQPxe8c4A-Mxu0-w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d876431c4aso4676048a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 04:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725448821; x=1726053621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PmylSsDXAxT+Pv/FJeIhD2/vlBnxT0mo79GWr7E19Pg=;
 b=ffA8Y1e2M2CRs6jVt4AffGvv9u5yBFnm6unUZ0W81d36F9Rv9NNS/wCbaxraIGrCE/
 uLgQLIoFCLdQGJ6pjw5sL0H1WpXqIuWB26Ii2HPOGzRXlrPGKPEUZFeRdFaeRdX+qZaU
 sBObQxBtv5n5WJdu9xuzwqfKus5Lne2IoZwthlARrgzbyL+bu+DzinaMYi5bnwCt6xbQ
 kn53N92rF5BH+3LK8KqK4nC764E7M/x7Mt997A0S1poGiE5oe7CD+D3xZ8M6l0PJYQgv
 XpAOU4WnA69t++9RUA6iFcwk4w/+goLx8waHw9c7KKZ1qrCWGmAYL5hNWSlIajFBFb2A
 Jpxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIy435aHgu3ZMhsIQSvII39q4qk8z3cihAjGsPZ4+/hIfT16FBwy/YRKA2Pjvdj4UtYo2/XT2F36ZH@nongnu.org
X-Gm-Message-State: AOJu0Yx5lv9WGhQaNHrT4qt9hzwud48py0QD2MUA+DaIHSQxl23zejov
 KGxLjydDd1ZeLu7UETArnydSgaL8WGmKOOlPbMR7b2BW7MgCQq9TCXqJOBQI4kD/NiRWWG+7/N9
 ZGAjLRakWjByYesLw8+1ryYxSONsiaWnxb4MiA/NiHP7hdMI5iAuYkpbKfPyr8MTL+uzIL39EhP
 br/Zjytgvza9c+Md8+40FzYcjmM6uC4GldchU=
X-Received: by 2002:a17:90b:2250:b0:2d8:d849:37fc with SMTP id
 98e67ed59e1d1-2da62ccd704mr5362851a91.2.1725448821079; 
 Wed, 04 Sep 2024 04:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEX4k3AHTao0rS2mfbMZjKWRk3V60sKJlxgYpILdIu5P75kOsTaCk+iyFBBKjSasEF/igy1rL7mLCLecg5geQ=
X-Received: by 2002:a17:90b:2250:b0:2d8:d849:37fc with SMTP id
 98e67ed59e1d1-2da62ccd704mr5362823a91.2.1725448820638; Wed, 04 Sep 2024
 04:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-4-aesteve@redhat.com>
 <20240711082538.GE563880@dynamic-pd01.res.v6.highway.a1.net>
In-Reply-To: <20240711082538.GE563880@dynamic-pd01.res.v6.highway.a1.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Sep 2024 13:20:09 +0200
Message-ID: <CADSE00Js39MbwLxaN5F5kxDVnRcxa5KHjrA3R-nzRS4k5jtsLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] vhost-user-dev: Add cache BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000085bbd0621495cb7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000085bbd0621495cb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:25=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> On Fri, Jun 28, 2024 at 04:57:08PM +0200, Albert Esteve wrote:
> > Add a cache BAR in the vhost-user-device
> > into which files can be directly mapped.
> >
> > The number, shmid, and size of the VIRTIO Shared
> > Memory subregions is retrieved through a get_shmem_config
> > message sent by the vhost-user-base module
> > on the realize step, after virtio_init().
> >
> > By default, if VHOST_USER_PROTOCOL_F_SHMEM
> > feature is not supported by the backend,
> > there is no cache.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> Michael: Please review vhost_user_device_pci_realize() below regarding
> virtio-pci BAR layout. Thanks!
>
> > ---
> >  hw/virtio/vhost-user-base.c       | 39 +++++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 37 ++++++++++++++++++++++++++---
> >  2 files changed, 71 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index a83167191e..e47c568a55 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -268,7 +268,9 @@ static void vub_device_realize(DeviceState *dev,
> Error **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > -    int ret;
> > +    uint64_t memory_sizes[8];
> > +    void *cache_ptr;
> > +    int i, ret, nregions;
> >
> >      if (!vub->chardev.chr) {
> >          error_setg(errp, "vhost-user-base: missing chardev");
> > @@ -311,7 +313,7 @@ static void vub_device_realize(DeviceState *dev,
> Error **errp)
> >
> >      /* Allocate queues */
> >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > +    for (i =3D 0; i < vub->num_vqs; i++) {
> >          g_ptr_array_add(vub->vqs,
> >                          virtio_add_queue(vdev, vub->vq_size,
> >                                           vub_handle_output));
> > @@ -328,6 +330,39 @@ static void vub_device_realize(DeviceState *dev,
> Error **errp)
> >          do_vhost_user_cleanup(vdev, vub);
> >      }
> >
> > +    ret =3D
> vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
> > +                                                           &nregions,
> > +                                                           memory_size=
s,
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        do_vhost_user_cleanup(vdev, vub);
> > +    }
> > +
> > +    for (i =3D 0; i < nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            if (!is_power_of_2(memory_sizes[i]) ||
> > +                memory_sizes[i] < qemu_real_host_page_size()) {
>
> Or just if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0)?


I like both options. The original is more explicit, your proposal is more
concise.
I will change it.


>
> > +                error_setg(errp, "Shared memory %d size must be a powe=
r
> of 2 "
> > +                                 "no smaller than the page size", i);
> > +                return;
> > +            }
> > +
> > +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_READ,
>
> Should this be PROT_NONE like in
> vhost_user_backend_handle_shmem_unmap()?
>

Since this is supposed to be blank memory, I think you may be
right. But I am not completely certain. I'll change it and check if
everything works as expected on my side.


>
> > +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +            if (cache_ptr =3D=3D MAP_FAILED) {
> > +                error_setg(errp, "Unable to mmap blank cache: %s",
> > +                           strerror(errno));
>
> error_setg_errno() can be used here.
>
> > +                return;
> > +            }
> > +
> > +            virtio_new_shmem_region(vdev);
> > +            memory_region_init_ram_ptr(&vdev->shmem_list[i],
> > +                                    OBJECT(vdev), "vub-shm-" + i,
> > +                                    memory_sizes[i], cache_ptr);
> > +        }
> > +    }
> > +
> >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NUL=
L,
> >                               dev, NULL, true);
> >  }
> > diff --git a/hw/virtio/vhost-user-device-pci.c
> b/hw/virtio/vhost-user-device-pci.c
> > index efaf55d3dd..314bacfb7a 100644
> > --- a/hw/virtio/vhost-user-device-pci.c
> > +++ b/hw/virtio/vhost-user-device-pci.c
> > @@ -8,14 +8,18 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qapi/error.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/virtio/vhost-user-base.h"
> >  #include "hw/virtio/virtio-pci.h"
> >
> > +#define VIRTIO_DEVICE_PCI_CACHE_BAR 2
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion cachebar;
> >  };
> >
> >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > @@ -25,10 +29,37 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI,
> VHOST_USER_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev,
> Error **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > -
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    uint64_t offset =3D 0, cache_size =3D 0;
> > +    int i;
> > +
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +        if (vdev->shmem_list[i].size > UINT64_MAX - cache_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        cache_size =3D cache_size + vdev->shmem_list[i].size;
> > +    }
> > +    if (cache_size) {
> > +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-cachebar", cache_size);
> > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +            memory_region_add_subregion(&dev->cachebar, offset,
> > +                                        &vdev->shmem_list[i]);
> > +            virtio_pci_add_shm_cap(vpci_dev,
> VIRTIO_DEVICE_PCI_CACHE_BAR,
> > +                                   offset, vdev->shmem_list[i].size, i=
);
> > +            offset =3D offset + vdev->shmem_list[i].size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev,
> VIRTIO_DEVICE_PCI_CACHE_BAR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->cachebar);
> > +    }
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass, void
> *data)
> > --
> > 2.45.2
> >
>

--000000000000085bbd0621495cb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 11, 2024 at 10:25=
=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Fri, Jun 28, 2024 at 04:57:08PM +0200, Albert Esteve wrot=
e:<br>
&gt; Add a cache BAR in the vhost-user-device<br>
&gt; into which files can be directly mapped.<br>
&gt; <br>
&gt; The number, shmid, and size of the VIRTIO Shared<br>
&gt; Memory subregions is retrieved through a get_shmem_config<br>
&gt; message sent by the vhost-user-base module<br>
&gt; on the realize step, after virtio_init().<br>
&gt; <br>
&gt; By default, if VHOST_USER_PROTOCOL_F_SHMEM<br>
&gt; feature is not supported by the backend,<br>
&gt; there is no cache.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
<br>
Michael: Please review vhost_user_device_pci_realize() below regarding<br>
virtio-pci BAR layout. Thanks!<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 +++++=
++++++++++++++++++++++++--<br>
&gt;=C2=A0 hw/virtio/vhost-user-device-pci.c | 37 +++++++++++++++++++++++++=
+---<br>
&gt;=C2=A0 2 files changed, 71 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c=
<br>
&gt; index a83167191e..e47c568a55 100644<br>
&gt; --- a/hw/virtio/vhost-user-base.c<br>
&gt; +++ b/hw/virtio/vhost-user-base.c<br>
&gt; @@ -268,7 +268,9 @@ static void vub_device_realize(DeviceState *dev, E=
rror **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHostUserBase *vub =3D VHOST_USER_BASE(dev);<br>
&gt; -=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 uint64_t memory_sizes[8];<br>
&gt; +=C2=A0 =C2=A0 void *cache_ptr;<br>
&gt; +=C2=A0 =C2=A0 int i, ret, nregions;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!vub-&gt;chardev.chr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;vhost-user-ba=
se: missing chardev&quot;);<br>
&gt; @@ -311,7 +313,7 @@ static void vub_device_realize(DeviceState *dev, E=
rror **errp)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Allocate queues */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vub-&gt;vqs =3D g_ptr_array_sized_new(vub-&gt;num_=
vqs);<br>
&gt; -=C2=A0 =C2=A0 for (int i =3D 0; i &lt; vub-&gt;num_vqs; i++) {<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; vub-&gt;num_vqs; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_ptr_array_add(vub-&gt;vqs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 virtio_add_queue(vdev, vub-&gt;vq_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vub_handle_output));<br>
&gt; @@ -328,6 +330,39 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_vhost_user_cleanup(vdev, vub);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 ret =3D vub-&gt;vhost_dev.vhost_ops-&gt;vhost_get_shmem=
_config(&amp;vub-&gt;vhost_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;nreg=
ions,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_si=
zes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_vhost_user_cleanup(vdev, vub);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; nregions; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memory_sizes[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_power_of_2(memory_s=
izes[i]) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_sizes[=
i] &lt; qemu_real_host_page_size()) {<br>
<br>
Or just if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0)?</blockquo=
te><div><br></div><div>I like both options. The original is more explicit, =
your proposal is more concise.</div><div>I will change it.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;Shared memory %d size must be a power of 2 &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;no smaller than the =
page size&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cache_ptr =3D mmap(NULL, me=
mory_sizes[i], PROT_READ,<br>
<br>
Should this be PROT_NONE like in<br>
vhost_user_backend_handle_shmem_unmap()?<br></blockquote><div><br></div><di=
v>Since this is supposed=C2=A0to be blank memory, I think you may be</div><=
div>right. But I am not completely certain. I&#39;ll change it and check if=
</div><div>everything works as expected on my side.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cache_ptr =3D=3D MAP_FA=
ILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(er=
rp, &quot;Unable to mmap blank cache: %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errno));<br>
<br>
error_setg_errno() can be used here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_new_shmem_region(vde=
v);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram_ptr(=
&amp;vdev-&gt;shmem_list[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT(vdev), &quo=
t;vub-shm-&quot; + i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_sizes[i], c=
ache_ptr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;vub-&gt;chardev, NUL=
L, NULL, vub_event, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev, NULL, true);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-=
device-pci.c<br>
&gt; index efaf55d3dd..314bacfb7a 100644<br>
&gt; --- a/hw/virtio/vhost-user-device-pci.c<br>
&gt; +++ b/hw/virtio/vhost-user-device-pci.c<br>
&gt; @@ -8,14 +8,18 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost-user-base.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/virtio-pci.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +#define VIRTIO_DEVICE_PCI_CACHE_BAR 2<br>
&gt; +<br>
&gt;=C2=A0 struct VHostUserDevicePCI {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIOPCIProxy parent_obj;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHostUserBase vub;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion cachebar;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define TYPE_VHOST_USER_DEVICE_PCI &quot;vhost-user-device-pci-b=
ase&quot;<br>
&gt; @@ -25,10 +29,37 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHO=
ST_USER_DEVICE_PCI)<br>
&gt;=C2=A0 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(=
vpci_dev);<br>
&gt; -=C2=A0 =C2=A0 DeviceState *vdev =3D DEVICE(&amp;dev-&gt;vub);<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev_state =3D DEVICE(&amp;dev-&gt;vub);<br=
>
&gt; +=C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);<br>
&gt; +=C2=A0 =C2=A0 uint64_t offset =3D 0, cache_size =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 vpci_dev-&gt;nvectors =3D 1;<br>
&gt; -=C2=A0 =C2=A0 qdev_realize(vdev, BUS(&amp;vpci_dev-&gt;bus), errp);<b=
r>
&gt; +=C2=A0 =C2=A0 qdev_realize(dev_state, BUS(&amp;vpci_dev-&gt;bus), err=
p);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; vdev-&gt;n_shmem_regions; i++) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vdev-&gt;shmem_list[i].size &gt; UINT=
64_MAX - cache_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Tota=
l shared memory required overflow&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cache_size =3D cache_size + vdev-&gt;shme=
m_list[i].size;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (cache_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init(&amp;dev-&gt;cachebar,=
 OBJECT(vpci_dev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vhost-device-pci-cachebar&quot;, cache_si=
ze);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; vdev-&gt;n_shmem_reg=
ions; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion=
(&amp;dev-&gt;cachebar, offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;vdev-&gt;shmem_list[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_pci_add_shm_cap(vpci=
_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset, vdev-&gt;sh=
mem_list[i].size, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D offset + vdev-&g=
t;shmem_list[i].size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_register_bar(&amp;vpci_dev-&gt;pci_de=
v, VIRTIO_DEVICE_PCI_CACHE_BAR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCI_BASE_ADDRESS_SPACE_MEMORY |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCI_BASE_ADDRESS_MEM_PREFETCH |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCI_BASE_ADDRESS_MEM_TYPE_64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &amp;dev-&gt;cachebar);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void vhost_user_device_pci_class_init(ObjectClass *klass,=
 void *data)<br>
&gt; -- <br>
&gt; 2.45.2<br>
&gt; <br>
</blockquote></div></div>

--000000000000085bbd0621495cb7--


