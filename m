Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586CDC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 04:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rphAF-0005yE-E6; Thu, 28 Mar 2024 00:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rphAD-0005y1-LK
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rphAC-0002y0-0x
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 00:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711599291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pg/pfqeLGLkPI3NuKZGIE0+OajqpvCEivUzhf6oAYA=;
 b=RBo/b1Qs/3/Nhu84Nwz/AKmNM+KdiG0j1EkiJXN/rpqI4o6fCIK+6dL2qsmP+l4WFU1idp
 PI5fi1yk7lBG7HuuKYeIaMWGH2H23dmcOcyV8YT3v2+bu97C/E54Y0h/qOocda8UhtaSin
 Bz//qcsdOxC/yvMOB9dryQwwUqTc+JU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-n_Ed8kobMEulkYIXLeJDFg-1; Thu, 28 Mar 2024 00:14:49 -0400
X-MC-Unique: n_Ed8kobMEulkYIXLeJDFg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a039b47c5fso1256425a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 21:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711599288; x=1712204088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pg/pfqeLGLkPI3NuKZGIE0+OajqpvCEivUzhf6oAYA=;
 b=CwD//TIL7FbnJDzwocW8ESgLGyjp9mf1ywCtAn9N759gwsxDJLocRXISOtP7cJiwRK
 pjyL7gbelVnXBPAOJWuuMJr3WP1m1b26VJFFrHLZQ3F2pI77MACXBbQHu+lOaBK9pvms
 sVoMhTUxzVIkuu6NllcR5h1FRtNc17x0h3vsBU1jYRD5YoC9pd0DVwHVBaINo+SpCMvA
 tO2Uwz16d5CO8pdA2mx8a25fDAjCDa10EcE1vx92Ta8V0Bd8XoyyLSwptXFg299lERrJ
 Oa7TiiD5V/An/HpiGMy02GeGaKQCGQkDTPLZjt/qJ3C5BtPX8NGdnfERCG/U1uQSAxnl
 1N8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJWEE/TqpoF1XWt6UUgNp67H+j3GOdStKuSL9yqmvL4GQXr7o+mQfcgo9FPc04qWLDLDnznFMMrr7TbmJEVpQMx5vUtRU=
X-Gm-Message-State: AOJu0YwLHkUZ6Gdk+qM3zpY31DCKOcbnX1vQACZXjgFnNNV1VuC3F986
 2ydRj9xcMgo7pMVut3s7I/JMsCskeQVd5TMnNknsZPzCNROdrt/aWUbE7/btvxVklyqiRu9AGvm
 W1TOJ0ZXGtzs3D5G5QpB/ec/dzWluZSLJiRQBC0+kWYEwSbeSQDY4GfbEqH6troUqRaakdN59Oi
 t2Ywjb8ay0WtTXrqQlvoK4T7SPKOZP11BjUE8=
X-Received: by 2002:a17:90b:3b8b:b0:2a0:4465:6f9d with SMTP id
 pc11-20020a17090b3b8b00b002a044656f9dmr1776681pjb.11.1711599287788; 
 Wed, 27 Mar 2024 21:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGjRBUZDOyKxPRBAoRKIHs+yKHK8+64l5REiZkDCHm2dJ0hD3McMJ9AwNajH1U5R217jcOv/SCQmCQA/uQGJc=
X-Received: by 2002:a17:90b:3b8b:b0:2a0:4465:6f9d with SMTP id
 pc11-20020a17090b3b8b00b002a044656f9dmr1776668pjb.11.1711599287450; Wed, 27
 Mar 2024 21:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
 <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
 <CACGkMEu67pZKApDkcBi4XSuS+ss001GKyapUkNNkwnSRcgPZqw@mail.gmail.com>
 <CACLfguXFn9aNUwh_aBkNsLZ79EWPRnXRNws95t6ySgE7b+4HPQ@mail.gmail.com>
 <CACGkMEuP71EWSC33gj2diABaDk4sYexBbskq9ZfpZMBoB1aBbQ@mail.gmail.com>
 <CACGkMEvRo4Q2Of7cwTNmR6mgapMWYQ79D4fErJ8AoqPrsc+ncA@mail.gmail.com>
 <CACLfguWfOpwGktTaDOQ=fFMjvFJ4L9i42kJiPess85OJSw0QFA@mail.gmail.com>
In-Reply-To: <CACLfguWfOpwGktTaDOQ=fFMjvFJ4L9i42kJiPess85OJSw0QFA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:14:36 +0800
Message-ID: <CACGkMEuX37wzRiO4T-7d1yE76_YxdFK9eh0cChRdAhVJ4iY5Vw@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 27, 2024 at 5:44=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Mar 27, 2024 at 5:13=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 27, 2024 at 5:12=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 4:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Mar 27, 2024 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Mar 27, 2024 at 2:03=E2=80=AFPM Cindy Lu <lulu@redhat.com=
> wrote:
> > > > > >
> > > > > > On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > Hi Cindy:
> > > > > > >
> > > > > > > On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat=
.com> wrote:
> > > > > > > >
> > > > > > > > we need a crash in Non-standard image, here is the jira for=
 this https://issues.redhat.com/browse/RHEL-28522
> > > > > > > > The root cause of the issue is that an IRQFD was used witho=
ut initialization..
> > > > > > > >
> > > > > > > > During the booting process of the Vyatta image, the behavio=
r of the called function in qemu is as follows:
> > > > > > > >
> > > > > > > > 1. vhost_net_stop() was called, this will call the function
> > > > > > > > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > > > > > > > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the i=
rqfd for vector 0
> > > > > > >
> > > > > > > Before vhost_net_stop(), do we know which vector is used by w=
hich queue?
> > > > > > >
> > > > > > before this stop, vdev->config_verctor is get from
> > > > > > virtio_pci_common_read/virtio_pci_common_write
> > > > > > it was set to vector 0
> > > > >
> > > > > I basically meant if vector 0 is shared with some virtqueues here=
.
> > > > >
> > > > Really sorry for this, vq's vector is 1,2, and will not share with =
the
> > > > configure vector
> > > > > > > >
> > > > > > > > 2. virtio_reset() was called -->set configure vector to VIR=
TIO_NO_VECTORt
> > > > > > > >
> > > > > > > > 3.vhost_net_start() was called (at this time the configure =
vector is
> > > > > > > > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notif=
iers() with
> > > > > > > > assgin=3D true, so the irqfd for vector 0 was not "init" du=
ring this process
> > > > > > >
> > > > > > > How does the configure vector differ from the virtqueue vecto=
r here?
> > > > > > >
> > > > > > All the vectors are VIRTIO_NO_VECTOR (including vq). any
> > > > > > msix_fire_vector_notifier()
> > > > > > been called will cause the crash at this time.
> > > > >
> > > > > Won't virtio_pci_set_guest_notifiers() will try to allocate irqfd=
 when
> > > > > the assignment is true?
> > > > >
> > > > It will allocate, but  the vector is VIRTIO_NO_VECTOR (0xffff)
> > > >
> > > > then it will called kvm_virtio_pci_vector_use_one()
> > > >
> > > > in this function, there is a check for
> > > >
> > > >     if (vector >=3D msix_nr_vectors_allocated(dev))
> > > >
> > > > {         return 0;     }
> > > >
> > > > So it will return.
> > >
> > > How about let's just fix this?
> >
> > Btw, another question, how does vDPA work here?
> >
> > Thanks
> >
> the rhel/fedroa guest image will not call  vrtio_stop and virtio_reset
> during the boot
> So vector will not change to  VIRTIO_NO_VECTOR. So the vdpa's
> configure interrupt
> Should work ok and there is no crash

I mean:

1) if vDPA can work with the image you used to reproduce the issue
2) if current Qemu can work on old kernel without configure interrupt
support for vDPA

Thanks

> Thanks
> cindy
>
> > >
> > > Btw, it's better to explain in detail like the above in the next vers=
ion.
> > >
> > > Thanks
> > >
> > > >
> > > > > > So I think this should
> > > > > > be a bug in this guest image
> > > > >
> > > > > The point is Qemu should not crash even if the guest driver is bu=
ggy.
> > > > >
> > > > > It would be nice if we can have a qtest for this on top.
> > > > >
> > > > > Thanks
> > > > >
> > > > sure, got it, I have done the Qtest, and it passed
> > > > here is the result
> > > >
> > > > Ok:                 794
> > > > Expected Fail:      0
> > > > Fail:               0
> > > > Unexpected Pass:    0
> > > > Skipped:            32
> > > > Timeout:            0
> > > >
> > > > > > > >
> > > > > > > > 4. The system continues to boot and msix_fire_vector_notifi=
er() was
> > > > > > > > called unmask the vector 0 and then met the crash
> > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > > > > > > > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> > > > > > > >
> > > > > > > > The reason for not reproducing in RHEL/fedora guest image i=
s because
> > > > > > > > REHL/Fedora doesn't have the behavior of calling vhost_net_=
stop and then virtio_reset, and also won't call msix_fire_vector_notifier f=
or vector 0 during system boot.
> > > > > > > >
> > > > > > > > The reason for not reproducing before configure interrupt s=
upport is because
> > > > > > > > vector 0 is for configure interrupt,  before the support fo=
r configure interrupts, the notifier process will not handle vector 0.
> > > > > > > >
> > > > > > > > For the device Vyatta using, it doesn't support configure i=
nterrupts at all, So we plan to disable the configure interrupts in unsuppo=
rted device
> > > > > > >
> > > > > > > Btw, let's tweak the changelog, it's a little bit hard to und=
erstand.
> > > > > > >
> > > > > > sure will do
> > > > > > thanks
> > > > > > Cindy
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > >
> > > > > > > > Cindy Lu (2):
> > > > > > > >   virtio-net: disable the configure interrupt for not suppo=
rt device
> > > > > > > >   virtio-pci: check if the configure interrupt enable
> > > > > > > >
> > > > > > > >  hw/net/virtio-net.c        |  5 ++++-
> > > > > > > >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----=
------------
> > > > > > > >  hw/virtio/virtio.c         |  1 +
> > > > > > > >  include/hw/virtio/virtio.h |  1 +
> > > > > > > >  4 files changed, 29 insertions(+), 19 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>


