Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA49C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 04:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rth6E-0002y5-OF; Mon, 08 Apr 2024 00:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth6D-0002xR-6D
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rth6B-0003tn-BF
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 00:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712552354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QebMAS1Q0YIAY3rMsyQPtJN0QgB6MJtwXA8M0USd1M=;
 b=HEmJL8g0mfCacMcLllDnSX+OzstUt+rDbEPDdZmlesyQfJk+l8dz3q+5DsKhTtl51QT6Ke
 8+tdEdquuKmVyTOBk0JSUUdae3Hua09jdT05A7VhJ9H9rncL2xv4rbOVAjo7sVb4AkPA19
 LZ+0iiSkXdxQl0omkzz2ynz0VCHDV74=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-yM8sL4FwOneZ_zKeK9hDAA-1; Mon, 08 Apr 2024 00:59:12 -0400
X-MC-Unique: yM8sL4FwOneZ_zKeK9hDAA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a30dc503f3so2419153a91.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 21:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712552351; x=1713157151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QebMAS1Q0YIAY3rMsyQPtJN0QgB6MJtwXA8M0USd1M=;
 b=qxwasCRALFBd+hFw0WFpf2OxwR4XXNdk51Kag0j+vsHk/9VhmNz7RGcpqn0cOAAD4R
 hk8r/gjJp7zb1owT3L9+o1fO6c3XNuMMtjzwJrup/jRHuWASG/iJeDYQNCxoPR6yWWe+
 JUUX0abA9iMdOMGF0Wi6ysMz9HCVVJo9jIvYwRmYV9tIbueyWUnlb6XslgosZ45035t/
 fAzdjuLs3vnn5hwWe2PWeuvT3LoZrr2761xfEfgypEQc2KY7G/w4NoMQa+WFEQv4GCyE
 CfHbsY9bJKLb+wnZofUyiw2l6b81t3YBy2/0yVtRXf3fYS0PhvbpYm8gyyb0IIZLYEIR
 lNvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7kYqD4VxzlhgfglkQUoxZ2nGYe51exlNg2oc3nVzZTU+OmigffuuncHDdE9hqJqx8lDjStlreAqGF4CyZhivXbT3diCc=
X-Gm-Message-State: AOJu0YyMgCFESjrS9KiZVUf568sziqZe7vs+1L/xfdu81Bd1oHV9Ggyo
 6ARQAis5ldTMwkLbK8P+8rWQ5HbjqgN+6lr+SrcLHtQDhKddT3jYgu3ZJayc4uOkXVqi+haDKBc
 BKesURUe2dcJ40GqWCw8JimkoSrsPkCKdw9N28efbVVlNzHTpmIylOMxwGlxpalFCp5mIXgzXV+
 auh4jKg9S8oE/RCMmWahw0hgmQsmGDQVMu6UM=
X-Received: by 2002:a17:90a:c215:b0:2a5:575:5f73 with SMTP id
 e21-20020a17090ac21500b002a505755f73mr1418534pjt.42.1712552351166; 
 Sun, 07 Apr 2024 21:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4obYv9+sdoKeEVeJVvMTxiYjGEkvDF8sISc15QOn4GIQNtXtmL12Debnk92fbWoMzI+5e9/IBLsq4YUa/XWA=
X-Received: by 2002:a17:90a:c215:b0:2a5:575:5f73 with SMTP id
 e21-20020a17090ac21500b002a505755f73mr1418527pjt.42.1712552350839; Sun, 07
 Apr 2024 21:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240402150218.270587-1-lulu@redhat.com>
 <20240402150218.270587-2-lulu@redhat.com>
 <CACGkMEuQc+e+JOnScUdJckP1yb1Ushu9E0VEQKhwdn26W422bw@mail.gmail.com>
 <CACLfguVs=sd+2knCn4hhCEa+qsQ84yiE6wxt+kDNz8pU=ceU=Q@mail.gmail.com>
In-Reply-To: <CACLfguVs=sd+2knCn4hhCEa+qsQ84yiE6wxt+kDNz8pU=ceU=Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 12:58:59 +0800
Message-ID: <CACGkMEu6ijH9uADA-dah9y+cp1yEQuw4WrrZY=T0yNBc4z44eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes
 back from VIRTIO_NO_VECTOR
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 7, 2024 at 3:00=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Sun, Apr 7, 2024 at 12:20=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Apr 2, 2024 at 11:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > When the guest calls virtio_stop and then virtio_reset,
> >
> > Guests could not call those functions directly, it is triggered by for
> > example writing to some of the registers like reset or others.
> >
> sure , Will fix this
> > > the vector will change
> > > to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. A=
fter that
> > > If you want to change the vector back,
> >
> > What do you mean by "change the vector back"? Something like
> >
> > assign VIRTIO_MSI_NO_VECTOR to vector 0
> > assign X to vector 0
> >
> yes, the process is something  like
> ....
> set config_vector =3D VIRTIO_MSI_NO_VECTOR
> ...
> set config_vector =3D 0
> > And I guess what you meant is to configure the vector after DRIVER_OK.
>
> >
> >
> > > it will cause a crash.
> > >
> > > To fix this, we need to call the function "kvm_virtio_pci_vector_use_=
one()"
> > > when the vector changes back from VIRTIO_NO_VECTOR
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index e433879542..45f3ab38c3 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIPro=
xy *proxy, int queue_no,
> > >      return 0;
> > >  }
> > >
> > > -static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int =
queue_no)
> > > +static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int =
queue_no,
> > > +                                         bool recovery)
> > >  {
> > >      unsigned int vector;
> > >      int ret;
> > >      EventNotifier *n;
> > >      PCIDevice *dev =3D &proxy->pci_dev;
> > > +    VirtIOIRQFD *irqfd;
> > >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> > >      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> > >
> > > @@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIO=
PCIProxy *proxy, int queue_no)
> > >      if (vector >=3D msix_nr_vectors_allocated(dev)) {
> > >          return 0;
> > >      }
> > > +    /*
> > > +     * if this is recovery and irqfd still in use, means the irqfd w=
as not
> > > +     * release before and don't need to set up again
> > > +     */
> > > +    if (recovery) {
> > > +        irqfd =3D &proxy->vector_irqfd[vector];
> > > +        if (irqfd->users !=3D 0) {
> > > +            return 0;
> > > +        }
> > > +    }
> > >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> > >      if (ret < 0) {
> > >          goto undo;
> > >      }
> > > +
> > >      /*
> > >       * If guest supports masking, set up irqfd now.
> > >       * Otherwise, delay until unmasked in the frontend.
> > > @@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOP=
CIProxy *proxy, int nvqs)
> > >          if (!virtio_queue_get_num(vdev, queue_no)) {
> > >              return -1;
> > >          }
> > > -        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no);
> > > +        ret =3D kvm_virtio_pci_vector_use_one(proxy, queue_no, false=
);
> > >      }
> > >      return ret;
> > >  }
> > >
> > >  static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
> > >  {
> > > -    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_ID=
X);
> > > +    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_ID=
X, false);
> > >  }
> > >
> > >  static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
> > > @@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaq=
ue, hwaddr addr,
> > >          } else {
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > > +        vector =3D vdev->config_vector;
> > >          vdev->config_vector =3D val;
> > > +        /*check if the vector need to recovery*/
> > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_=
VECTOR) &&
> > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_I=
DX, true);
> > > +        }
> >
> > This looks too tricky.
> >
> > Think hard of this. I think it's better to split this into two parts:
> >
> > 1) a series that disables config irqfd for vhost-net, this series
> > needs to be backported to -stable which needs to be conservative. It
> > looks more like your V1, but let's add a boolean for pci proxy.
> sure, I wll try this
>
> > 2) a series that deal with the msix vector configuration after
> > driver_ok, we probably need some refactoring to do per vq use instead
> > of the current loop in DRIVER_OK
> >
> Sorry I didn't get what you mean , Do you mean we need to move the check
> to inside kvm_virtio_pci_vector_vq_use()=EF=BC=9F
> Thanks
> cindy

I meant try to do use/release during mmio write instead of start.

Note that Michael seems to prefer the approach of this patch. Let's
fix the comment I gave in another thread and see.

Thanks

> > Does this make sense?
> >
> > Thanks
> >
> > >          break;
> > >      case VIRTIO_PCI_COMMON_STATUS:
> > >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > @@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaq=
ue, hwaddr addr,
> > >              val =3D VIRTIO_NO_VECTOR;
> > >          }
> > >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > > +
> > > +        /*check if the vector need to recovery*/
> > > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_=
VECTOR) &&
> > > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, tr=
ue);
> > > +        }
> > >          break;
> > >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> > >          if (val =3D=3D 1) {
> > > --
> > > 2.43.0
> > >
> >
>


