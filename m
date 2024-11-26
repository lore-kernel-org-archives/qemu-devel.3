Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AD1D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 12:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFv2v-0001fD-KJ; Tue, 26 Nov 2024 07:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFv2o-0001eq-Qo
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tFv2n-0006Ri-0G
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732625509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orpffyMTwEFu7/WBdW1WShgDDpdhLDOJGiD7DeHc8CY=;
 b=GxTlD29QTR4xiccgR6pfkbw6cBLExN8keleRzD3iS+FoFbnB8efl08pdKgfb+4ykFqeo9n
 5EzqgJX3XN449jprOUe69Gnkk6/w3CNuDhZnym7nxF1+iXGyXweEmG0BsGTfKPmR5KJfn0
 GmAAUcA0V70pDYNREq7s4hXSdeOBmgQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-wcMr4khmOK-qFF6oiEgxDg-1; Tue, 26 Nov 2024 07:51:48 -0500
X-MC-Unique: wcMr4khmOK-qFF6oiEgxDg-1
X-Mimecast-MFC-AGG-ID: wcMr4khmOK-qFF6oiEgxDg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ea50590a43so6532893a91.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 04:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732625507; x=1733230307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orpffyMTwEFu7/WBdW1WShgDDpdhLDOJGiD7DeHc8CY=;
 b=a8Z0hq9U18PTLXqk562h4pIU3PIteFsPK0KKKtnkFsM+Tstyfack2Z1VLFQyPMCMVg
 pCSF6HlwzRwJptXrJgUcDPK8wQ2l8m1r1G4zLMjQYMFaZDDH14Jz4qO7Sykg11eLGDQ2
 KQtBaNoP9mExE6IT1LsNtYwqlJyzx79AOglJVSQtQ4n8k1z53stGh08F3lnilAa0XR/k
 Rl1yBg8eoEBW70um6utRnOo77mT6MEm/bGQxQrvxJs+pwetKSgbnamrGT3DCDhBpY3nW
 RBPEnZNMwic9ygVWn9Cn+w9+2Vygkifr5qze+NthreTtvtxJzPBKptaD2auRdndaHLZA
 dNOw==
X-Gm-Message-State: AOJu0Yy0s5FzDBXDOsCZmMPLcbUxZRdxVSv4P5oKx9utgqBmU2+57eCc
 ecaV5HsCN2a1uE8m3cOkB5mq028oFm4pTjWMvJoUdFiIx2axLqUvQ1tcxnZO4r/wOTcrqPjtFIo
 qPxxyEM7tvLm9dFcAxMQ2fkcq+feiSrb3VU1Wi/pePepxZcKjfwEFSWuno6ZZxgikgzukDqxyd2
 LrQKw+ca76WQMCRk9HtpNeC6Efnp8=
X-Gm-Gg: ASbGncvefUa2e7aRIZUhR4NGwo5xsF4K4r7xgvD4Sd0WrZ0BftllJnj1BKos3gqAer0
 OJ+i2c9vHKX8VJJkxfn8GV/GUtCKJSeER
X-Received: by 2002:a17:90b:1c08:b0:2ea:b4c0:75b8 with SMTP id
 98e67ed59e1d1-2eb0e8881b1mr20494094a91.37.1732625507333; 
 Tue, 26 Nov 2024 04:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg+N+iYFuKSD3TNzcV5e6VnYVJQKmNx7SBnQ7CxyCQgrQ6cj44smqwOROkgp0wYvt/NIXOSdFOEZmbEpdbedw=
X-Received: by 2002:a17:90b:1c08:b0:2ea:b4c0:75b8 with SMTP id
 98e67ed59e1d1-2eb0e8881b1mr20494059a91.37.1732625506952; Tue, 26 Nov 2024
 04:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-5-aesteve@redhat.com>
 <20240917082751.GD575885@fedora.redhat.com>
In-Reply-To: <20240917082751.GD575885@fedora.redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 26 Nov 2024 13:51:35 +0100
Message-ID: <CADSE00LZaaQHXc59qQ3wRcP1NTxpJNsMKvBVJ9NDV4=WpMC41w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com, 
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 17, 2024 at 10:27=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Sep 12, 2024 at 04:53:34PM +0200, Albert Esteve wrote:
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
> > ---
>
> Not all devices derive from vhost-user-base.c so this does not offer
> full coverage. I think that's okay since few devices currently use
> VIRTIO Shared Memory Regions. A note about this in the commit
> description would be useful though. Which vhost-user devices gain VIRTIO
> Shared Memory Region support and what should you do if your device is
> not included in this list?
>
> >  hw/virtio/vhost-user-base.c       | 37 +++++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-device-pci.c | 39 ++++++++++++++++++++++++++++---
> >  2 files changed, 71 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index 2bc3423326..f2597d021a 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -271,7 +271,9 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
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
> > @@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >
> >      /* Allocate queues */
> >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > +    for (i =3D 0; i < vub->num_vqs; i++) {
> >          g_ptr_array_add(vub->vqs,
> >                          virtio_add_queue(vdev, vub->vq_size,
> >                                           vub_handle_output));
> > @@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, E=
rror **errp)
> >          do_vhost_user_cleanup(vdev, vub);
>
> Missing return statement.
>
> >      }
> >
> > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vho=
st_dev,
> > +                                                           &nregions,
> > +                                                           memory_size=
s,
>
> Buffer overflow. vhost_get_shmem_config() copies out up to 256
> memory_sizes[] elements. Please introduce a constant in the VIRTIO
> header and use it instead of hardcoding uint64_t memory_sizes[8] above.
>
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        do_vhost_user_cleanup(vdev, vub);
>
> Missing return statement.
>
> > +    }
> > +
> > +    for (i =3D 0; i < nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> > +                error_setg(errp, "Shared memory %d size must be a powe=
r of 2 "
> > +                                 "no smaller than the page size", i);
> > +                return;
>
> Missing do_vhost_user_cleanup().
>
> > +            }
> > +
> > +            cache_ptr =3D mmap(NULL, memory_sizes[i], PROT_NONE,
> > +                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>
>
>
> > +            if (cache_ptr =3D=3D MAP_FAILED) {
> > +                error_setg_errno(errp, errno, "Unable to mmap blank ca=
che");
> > +                return;
>
> Missing do_vhost_user_cleanup().
>
> > +            }
> > +
> > +            virtio_new_shmem_region(vdev);
> > +            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
> > +                                       OBJECT(vdev), "vub-shm-" + i,
> > +                                       memory_sizes[i], cache_ptr);
>
> I think memory_region_init_ram_ptr() is included in live migration, so
> the contents of VIRTIO Shared Memory Regions will be transferred to the
> destination QEMU and written to the equivalent memory region there. I'm
> not sure this works:
> 1. If there are PROT_NONE memory ranges, then live migration will
>    probably crash the source QEMU while trying to send this memory to
>    the destination QEMU.
> 2. If the destination vhost-user device has not yet loaded its state and
>    sent MAP messages setting up the VIRTIO Shared Memory Region, then
>    receiving migrated data and writing it into this memory will fail.
>
> QEMU has a migration blocker API so that devices can refuse live
> migration. For the time being a migration blocker is probably needed
> here. See migrate_add_blocker()/migrate_del_blocker().

I did not even think about migration. Also, did not know about these
functions. Thanks, I have explicitly called migrate_add_blocker
from the realize function. The migrate_del_blocker will be done
implicitly within the vhost_dev_cleanup call.

>
> > +        }
> > +    }
> > +
> >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NUL=
L,
> >                               dev, NULL, true);
> >  }
> > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-d=
evice-pci.c
> > index efaf55d3dd..abf4e90c21 100644
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
>
> "Cache" is ambigous. Call it shmem_bar here and everywhere else?
>
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion cachebar;
> >  };
> >
> >  #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> > @@ -25,10 +29,39 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOS=
T_USER_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Er=
ror **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > -
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    MemoryRegion *mr;
> > +    uint64_t offset =3D 0, cache_size =3D 0;
> > +    int i;
> > +
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +        mr =3D vdev->shmem_list[i].mr;
> > +        if (mr->size > UINT64_MAX - cache_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        cache_size =3D cache_size + mr->size;
> > +    }
> > +    if (cache_size) {
> > +        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-cachebar", cache_size);
> > +        for (i =3D 0; i < vdev->n_shmem_regions; i++) {
> > +            mr =3D vdev->shmem_list[i].mr;
> > +            memory_region_add_subregion(&dev->cachebar, offset, mr);
> > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_B=
AR,
> > +                                   offset, mr->size, i);
> > +            offset =3D offset + mr->size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_CACHE_B=
AR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->cachebar);
> > +    }
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass, void =
*data)
> > --
> > 2.45.2
> >


