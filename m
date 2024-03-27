Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C46C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPpr-0008RO-SM; Wed, 27 Mar 2024 05:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpPpq-0008R2-9X
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpPpo-0005Aw-D4
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711532678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jr9McWCxgvsyZgn5oSBGdFDqVgbCPncBjEktgyBcIWc=;
 b=iDlIf/wOf15Do2PYH8F0W0QxbIJIQQGLsQ0H19Yk7e9es/25odiAJqcSzNi1WC+/peK1gC
 iATuAzs79rOQruylMQYigMOhVQPxjztaYaVkDLtZjp9yDqks0H+mT8zxWR5rGKrb8HsIzV
 gjL6PsTZ5UWVyOqYb4dTQoQdfBBCqx4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Wh5rQ-pgOEOqpC_q0Lih2g-1; Wed, 27 Mar 2024 05:44:36 -0400
X-MC-Unique: Wh5rQ-pgOEOqpC_q0Lih2g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56bf2d59fceso4330164a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711532675; x=1712137475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jr9McWCxgvsyZgn5oSBGdFDqVgbCPncBjEktgyBcIWc=;
 b=bbFNuxjBrFwirep2vcFaiRqTxDi+tHA+p2NL7Yc58fwTBjptFY3/mmF+Q2ubJ8CYZn
 x3hjkrx9YrhTSq5xQ3I4NO4+1UPh+r+KIum3IOyMzJ4/mz/ePJqxaSKDnlP3I/NpwRTB
 KdsPyGRWUfJ3YAXhdWI3yhwblwmORtj7QS2Er/LifQ7vYP1xf8zO1GVn9TQcEJt36s1K
 I1PnA/YKPoZ3HG3qqPLLcBUqLIwUZ7RDYZ8D5/1vUBz02anZ806GPR7G+E3sI4YlAj9W
 K68WcLSkeT2k94wlv4kXk2L8yySiKdj5k5QWZoMn3PhJA9YCa5qBuJFxWCAbJx/YHTaP
 wrJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKrPvFxTdmB0rxPOFaE8mV4Z5AYQ56LheHUrOiC08kizzzPp0/KdSq91TyT7iRTCLV9dKQU/ETWvZINbxNueesadnZjVk=
X-Gm-Message-State: AOJu0YwFblPSQRmg/aFrgwFvPkiaGSqcENnzO4HG+UtuNBavTOeL+QLP
 gwqtGcMp2yaDuH0RcfhM5kOMtHEPIr8+tXpdlYxEXAD4tzPg2Urn5B/VwzLKOuKlrUcMKYIUuSz
 7bgkrNRTQm88nJXesBk/QOKiBC1o8aPisM5gREX8JVoEXqlXEn5m7zHqiqtb0RRR6GO4Co57T7/
 f3oHg+KLht4XTHDuZzSRkuEVxmjYw=
X-Received: by 2002:a17:906:a2c7:b0:a46:4d76:106b with SMTP id
 by7-20020a170906a2c700b00a464d76106bmr3540510ejb.34.1711532675009; 
 Wed, 27 Mar 2024 02:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0k2qk2PAV5PmG6oc/BaHldMfgw3U6v0TjuffkW67qpH5SS10f5hYffmDBHaZpYdcHB1Szc8j9pnYRpQADlzw=
X-Received: by 2002:a17:906:a2c7:b0:a46:4d76:106b with SMTP id
 by7-20020a170906a2c700b00a464d76106bmr3540504ejb.34.1711532674570; Wed, 27
 Mar 2024 02:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
 <CACGkMEvRo4Q2Of7cwTNmR6mgapMWYQ79D4fErJ8AoqPrsc+ncA@mail.gmail.com>
In-Reply-To: <CACGkMEvRo4Q2Of7cwTNmR6mgapMWYQ79D4fErJ8AoqPrsc+ncA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Mar 2024 17:43:56 +0800
Message-ID: <CACLfguWfOpwGktTaDOQ=fFMjvFJ4L9i42kJiPess85OJSw0QFA@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Wed, Mar 27, 2024 at 5:13=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com> =
wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > Hi Cindy:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.c=
om> wrote:
> > > > > > >
> > > > > > > we need a crash in Non-standard image, here is the jira for t=
his https://issues.redhat.com/browse/RHEL-28522
> > > > > > > The root cause of the issue is that an IRQFD was used without=
 initialization..
> > > > > > >
> > > > > > > During the booting process of the Vyatta image, the behavior =
of the called function in qemu is as follows:
> > > > > > >
> > > > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irq=
fd for vector 0
> > > > > >
> > > > > > Before vhost_net_stop(), do we know which vector is used by whi=
ch queue?
> > > > > >
> > > > > before this stop, vdev->config_verctor is get from
> > > > > virtio_pci_common_read/virtio_pci_common_write
> > > > > it was set to vector 0
> > > >
> > > > I basically meant if vector 0 is shared with some virtqueues here.
> > > >
> > > Really sorry for this, vq's vector is 1,2, and will not share with th=
e
> > > configure vector
> > > > > > >
> > > > > > > 2. virtio_reset() was called -->set configure vector to VIRTI=
O_NO_VECTORt
> > > > > > >
> > > > > > > 3.vhost_net_start() was called (at this time the configure ve=
ctor is
> > > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifie=
rs() with
> > > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" duri=
ng this process
> > > > > >
> > > > > > How does the configure vector differ from the virtqueue vector =
here?
> > > > > >
> > > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > > msix_fire_vector_notifier()
> > > > > been called will cause the crash at this time.
> > > >
> > > > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd w=
hen
> > > > the assignment is true?
> > > >
> > > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> > >
> > > then it will called kvm_virtio_pci_vector_use_one()
> > >
> > > in this function, there is a check for
> > >
> > >     if (vector >=3D msix_nr_vectors_allocated(dev))
> > >
> > > {         return 0;     }
> > >
> > > So it will return.
> >
> > How about let's just fix this?
>
> Btw, another question, how does vDPA work here?
>
> Thanks
>
the rhel/fedroa guest image will not call  vrtio_stop and virtio_reset
during the boot
So vector will not change to  VIRTIO_NO_VECTOR. So the vdpa's
configure interrupt
Should work ok and there is no crash
Thanks
cindy

> >
> > Btw, it's better to explain in detail like the above in the next versio=
n.
> >
> > Thanks
> >
> > >
> > > > > So I think this should
> > > > > be a bug in this guest image
> > > >
> > > > The point is Qemu should not crash even if the guest driver is bugg=
y.
> > > >
> > > > It would be nice if we can have a qtest for this on top.
> > > >
> > > > Thanks
> > > >
> > > sure, got it, I have done the Qtest, and it passed
> > > here is the result
> > >
> > > Ok:                 794
> > > Expected Fail:      0
> > > Fail:               0
> > > Unexpected Pass:    0
> > > Skipped:            32
> > > Timeout:            0
> > >
> > > > > > >
> > > > > > > 4. The system continues to boot and msix_fire_vector_notifier=
() was
> > > > > > > called unmask the vector 0 and then met the crash
> > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > > > >
> > > > > > > The reason for not reproducing in RHEL/fedora guest image is =
because
> > > > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_st=
op and then virtio_reset, and also won't call msix_fire_vector_notifier for=
 vector 0 during system boot.
> > > > > > >
> > > > > > > The reason for not reproducing before configure interrupt sup=
port is because
> > > > > > > vector 0 is for configure interrupt,  before the support for =
configure interrupts, the notifier process will not handle vector 0.
> > > > > > >
> > > > > > > For the device Vyatta using, it doesn't support configure int=
errupts at all, So we plan to disable the configure interrupts in unsupport=
ed device
> > > > > >
> > > > > > Btw, let's tweak the changelog, it's a little bit hard to under=
stand.
> > > > > >
> > > > > sure will do
> > > > > thanks
> > > > > Cindy
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > >
> > > > > > > Cindy Lu (2):
> > > > > > >   virtio-net: disable the configure interrupt for not support=
 device
> > > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > > >
> > > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-------=
----------
> > > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>


