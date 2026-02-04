Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177D1E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXbN-0007Gz-Q2; Wed, 04 Feb 2026 02:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vnXbM-0007Gr-FY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vnXbK-0003zL-DE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770191220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CStDQna6khUbu4FHZo1U5fH8Cxatzv2qP22LuQl7lc=;
 b=h/iVJTNMjZQK8Esrp4eRwnE6dNdGBSQpJXyjt/fYGxJi2QvaF3fJxJbWVAESTqObllniNM
 L8oRH89NTkI2oVt3hcRQ5kWdPfvKtukFElGKEFrl/gWLhoEKNUrtjfKE6gVli5zr1FZL4T
 W7V4MRq/52CBoFq5Iv8j9UFwi48/Cuo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-DE8HfzhcPAG6ZdMA-x2Zuw-1; Wed, 04 Feb 2026 02:46:59 -0500
X-MC-Unique: DE8HfzhcPAG6ZdMA-x2Zuw-1
X-Mimecast-MFC-AGG-ID: DE8HfzhcPAG6ZdMA-x2Zuw_1770191219
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-794ef1c2509so16102257b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 23:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770191219; cv=none;
 d=google.com; s=arc-20240605;
 b=NucRAnkzWNgohN5rZqclJsnDATrWY4RjeW8yiipNHUxU2WKt/ZOJX8m3aujp5Ec/n4
 Za93n3HlBAjDgTh4pbGesEGUqCqvpRS5zUuEFKeIVaSxxZhFV2Jm7q7Cf/puBpiV7Zgd
 He0ef6f0ajmYzySpVk9nHSKlhhXGo40I5/E/LsuDjXKQygZ9F09MueikXGR/En/8Xd/i
 +QfDEP1iAAK5QWS4nh4andjgbgzk0noQVxG9OqG1adZO3LZJYsmQlpyiYr2Cq/tIb/2r
 8/x46ypSRA0M2Ycpu8mcYEMUW/vzhSej3Hz5bl4TfToCYWgj2mk7X5nS41uUglVrjW1q
 F1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0CStDQna6khUbu4FHZo1U5fH8Cxatzv2qP22LuQl7lc=;
 fh=SCla5qwtivMsa9WuGACYFmsiD8ZAou9vajHYlsGjyaE=;
 b=ReM75XslkZWx1uF9iLVMwJPsKq2IqiLMnx6eiW3LHYio0J/waoIprnXAgC1MQ6YcrZ
 ItbU0FF3qdYcAoXCnRmOqBkvjKHz/Wu+jSzWDSaZbAauIPA/Ih6QIfyG37g9C552V0MT
 fL5gt0sayHsOVK8xtGCNuF8hEo0rCQ+Om4zwljv25xwZrvlyY0wAMJLjBAG88L3sIgsB
 ZBXyBlWooqCDeKnpeFNb2yNFUMDTm8bCGYnLpNN6LF3eOVlzwSa5oJt7gqV5+PrEXRgj
 s99wIgNO7DN+NVt9U1eSbWTk5Wk4QZBp2ei5VWhbG/tBfvM103dNgLdoDWoClshSxqUg
 AXOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770191219; x=1770796019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CStDQna6khUbu4FHZo1U5fH8Cxatzv2qP22LuQl7lc=;
 b=IclfPCo9Cz1JNO/v2kK3qJmgirNK4JiLxPi5hytPvZuD+Kyv9smUcFCBI03YlK6864
 SYRHXiXwAJUf6CMOfu8ePy5QFtjRVimCvYb1ut5gobrYc22TIeHdYF8Wgjz75a8/oahj
 lht0VvgrU+QHl10xKjEYeVURcu0Ev+/F2xGMMeEtQXZlQe7/SEZ7fa65eiUJLJYM/2Do
 99OPwbKDknMZOgCeg31rytLcQZAYkUCGK5lkePldAW/QWX95UdgOYhlGzoDOXq7Phv0l
 3/H8BWPE6SNq+vTJ72oJQ3ZRjFghKF6iNQjtTnJa8GRKHmLqcvCHuXONxW0gQszLjM15
 F0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770191219; x=1770796019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0CStDQna6khUbu4FHZo1U5fH8Cxatzv2qP22LuQl7lc=;
 b=HAt6+6m+PnS6LhzNUNupYK85BUMbDh9G5miaAVGIgAhB4bd11NHKdkzmfiYKDM66y/
 8WLY8eCVf5MCR3sO9rjDa5bTVsRFz07LEMtfPWzC8isedDiCM7I6VqPTgKsramBhH/5t
 lwLs2dqone3ESPV8eUw2aecoKasw1MxDDEiJxc2xo/FJI8iENmdBstygG+nbq2YTvUmD
 RWw1AHSWPSWAfu3Ubz+T7Qn0TX3QundZc4NwKi3BEd8eYVoccmnhRVN4XNteaLHMvBo8
 7gp1omQpu1yAp8fdIUq7piId0ESTRuSNWXAPf6LjnD7nsWtDLVnwnsc51F/ZkBdReDBR
 ChgQ==
X-Gm-Message-State: AOJu0YwQh1mYUwTKra7OEHuGArdvUEdtMd86sZmqLMjAb9woJN17DZB3
 1Q+C2hN2/qbpmzw0LYmUsaZkZFRq+/HSpQsyqD5kWWW0PTq2w5xnua5eckDHY9bWzfmrMdNa9WN
 aM+Y22DAPdIIwbr6kbDvgmfG7GkcNKG3r3g6nbkUSPQJdgHJ0lgHF+DUX8vMUiaTABY8wyvU9Ye
 f5ECuJIQ+aHTsLmYPRJ1Wsm8ePuu70hG8=
X-Gm-Gg: AZuq6aLov0J3Mj06SLzW8fMuT134ouzTCQXcg49WESl3hN28xMHMqi1O2RXPPGSzoo+
 OUodcVdhe9t3zjM1Zf0ujumYdDT1j1zX/Yf+BKnQ/fap7HO9i5PQn9LFK/LXu28FeCNxOs4sDhA
 /hc/sMIADNeYExpiGdmYpKsrY4F+7Uw4S6+q58XS5BMQhi73w9RoX2TQ7f9xkosA==
X-Received: by 2002:a05:690e:42dc:b0:649:b234:3905 with SMTP id
 956f58d0204a3-649d2fbe52cmr3228491d50.41.1770191218912; 
 Tue, 03 Feb 2026 23:46:58 -0800 (PST)
X-Received: by 2002:a05:690e:42dc:b0:649:b234:3905 with SMTP id
 956f58d0204a3-649d2fbe52cmr3228474d50.41.1770191218503; Tue, 03 Feb 2026
 23:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-8-aesteve@redhat.com>
 <20260203164542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203164542-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Feb 2026 08:46:47 +0100
X-Gm-Features: AZwV_QjPSg9D0mK-NzM7qAR_QFGyrh6CNX9aFzDYfUtbSMjYqMuvvBUPZPKmves
Message-ID: <CADSE00+zEmpd2w0eXuJvhrnv_8ZSnvODp9U4y6cVMfheLfP0WQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] vhost-user-device: Add shared memory BAR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, manos.pitsidianakis@linaro.org, 
 slp@redhat.com, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>,
 jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 3, 2026 at 10:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Nov 11, 2025 at 10:10:58AM +0100, Albert Esteve wrote:
> > Add shared memory BAR support to vhost-user-device-pci
> > to enable direct file mapping for VIRTIO Shared
> > Memory Regions.
> >
> > The implementation creates a consolidated shared
> > memory BAR that contains all VIRTIO Shared
> > Memory Regions as subregions. Each region is
> > configured with its proper shmid, size, and
> > offset within the BAR. The number and size of
> > regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> > message sent by vhost-user-base during realization
> > after virtio_init().
> >
> > Specifiically, it uses BAR 3 to avoid conflicts, as
> > it is currently unused.
> >
> > The shared memory BAR is only created when the
> > backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> > has configured shared memory regions. This maintains
> > backward compatibility with backends that do not
> > support shared memory functionality.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user-base.c            | 47 ++++++++++++++++++++++++--
> >  hw/virtio/vhost-user-test-device-pci.c | 39 +++++++++++++++++++--
> >  2 files changed, 81 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index ff67a020b4..82f49500e4 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -16,6 +16,7 @@
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/vhost-user-base.h"
> >  #include "qemu/error-report.h"
> > +#include "migration/blocker.h"
> >
> >  static void vub_start(VirtIODevice *vdev)
> >  {
> > @@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> > -    int ret;
> > +    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> > +    g_autofree char *name =3D NULL;
>
> This add a local variable "name" ...
>
> > +    int i, ret, nregions, regions_processed =3D 0;
> >
> >      if (!vub->chardev.chr) {
> >          error_setg(errp, "vhost-user-base: missing chardev");
> > @@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, Er=
ror **errp)
> >
> >      /* Allocate queues */
> >      vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> > -    for (int i =3D 0; i < vub->num_vqs; i++) {
> > +    for (i =3D 0; i < vub->num_vqs; i++) {
> >          g_ptr_array_add(vub->vqs,
> >                          virtio_add_queue(vdev, vub->vq_size,
> >                                           vub_handle_output));
> > @@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev, =
Error **errp)
> >                           VHOST_BACKEND_TYPE_USER, 0, errp);
> >
> >      if (ret < 0) {
> > -        do_vhost_user_cleanup(vdev, vub);
> > +        goto err;
> > +    }
> > +
> > +    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vho=
st_dev,
> > +                                                           &nregions,
> > +                                                           memory_size=
s,
> > +                                                           errp);
> > +
> > +    if (ret < 0) {
> > +        goto err;
> > +    }
> > +
> > +    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < =
nregions; i++) {
> > +        if (memory_sizes[i]) {
> > +            regions_processed++;
> > +            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> > +                error_setg(&vub->vhost_dev.migration_blocker,
> > +                       "Migration disabled: devices with VIRTIO Shared=
 Memory "
> > +                       "Regions do not support migration yet.");
> > +                ret =3D migrate_add_blocker_normal(
> > +                    &vub->vhost_dev.migration_blocker,
> > +                    errp);
> > +
> > +                if (ret < 0) {
> > +                    goto err;
> > +                }
> > +            }
> > +
> > +            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> > +                error_setg(errp, "Shared memory %d size must be a powe=
r of 2 "
> > +                                 "no smaller than the page size", i);
> > +                goto err;
> > +            }
> > +
> > +            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
> > +        }
> >      }
> >
> >      qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NUL=
L,
> >                               dev, NULL, true);
> > +    return;
> > +err:
> > +    do_vhost_user_cleanup(vdev, vub);
> >  }
> >
>
> which is never used.
>
> this results in a build error:
>
> https://gitlab.com/mstredhat/qemu/-/jobs/12974866799
>
>

Thanks. I will send a new version fixing the build errors you
mentioned. I am not sure why I did not see them myself when building
locally :/

>
>
> >  static void vub_device_unrealize(DeviceState *dev)
> > diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-u=
ser-test-device-pci.c
> > index b4ed0efb50..d010cb3205 100644
> > --- a/hw/virtio/vhost-user-test-device-pci.c
> > +++ b/hw/virtio/vhost-user-test-device-pci.c
> > @@ -8,14 +8,18 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qapi/error.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/virtio/vhost-user-base.h"
> >  #include "hw/virtio/virtio-pci.h"
> >
> > +#define VIRTIO_DEVICE_PCI_SHMEM_BAR 4
> > +
> >  struct VHostUserDevicePCI {
> >      VirtIOPCIProxy parent_obj;
> >
> >      VHostUserBase vub;
> > +    MemoryRegion shmembar;
> >  };
> >
> >  #define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-ba=
se"
> > @@ -25,10 +29,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOS=
T_USER_TEST_DEVICE_PCI)
> >  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Er=
ror **errp)
> >  {
> >      VHostUserDevicePCI *dev =3D VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
> > -    DeviceState *vdev =3D DEVICE(&dev->vub);
> > +    DeviceState *dev_state =3D DEVICE(&dev->vub);
> > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> > +    VirtioSharedMemory *shmem, *next;
> > +    uint64_t offset =3D 0, shmem_size =3D 0;
> >
> > +    vpci_dev->modern_mem_bar_idx =3D 2;
> >      vpci_dev->nvectors =3D 1;
> > -    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > +    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
> > +
> > +    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > +        if (shmem->mr.size > UINT64_MAX - shmem_size) {
> > +            error_setg(errp, "Total shared memory required overflow");
> > +            return;
> > +        }
> > +        shmem_size =3D shmem_size + shmem->mr.size;
> > +    }
> > +    if (shmem_size) {
> > +        if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
> > +            error_setg(errp, "modern-pio-notify is not supported due t=
o PCI BAR layout limitations");
> > +            return;
> > +        }
> > +        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> > +                           "vhost-device-pci-shmembar", shmem_size);
> > +        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
> > +            memory_region_add_subregion(&dev->shmembar, offset, &shmem=
->mr);
> > +            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                                   offset, shmem->mr.size, shmem->shmi=
d);
> > +            offset =3D offset + shmem->mr.size;
> > +        }
> > +        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_B=
AR,
> > +                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> > +                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> > +                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> > +                        &dev->shmembar);
> > +    }
> >  }
> >
> >  static void vhost_user_device_pci_class_init(ObjectClass *klass,
> > --
> > 2.49.0
>


