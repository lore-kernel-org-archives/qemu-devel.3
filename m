Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A33C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 06:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpMNr-0001cd-At; Wed, 27 Mar 2024 02:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpMNn-0001cC-8g
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 02:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rpMNl-0005A0-0Y
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 02:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711519407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKfNn15MocWSA8Fi5e21Jcah10OEosZGaCmM8eoPCB0=;
 b=Tjyrh7Y35rpHN3o2hT/OgI2WiUvz83X4+0k3r7Qti1srTBfCF6wv3hT4Nxn8cYPSOBShzo
 TgWFxF/sP34XNuwSHJgr9rEEm2bJ1eVH9yaZaTJ+6P3J/cOMlCI7xYYhPLgD1QRFUHK9Lp
 Us+ZRNLvehNVwzTNkXWbCdAhEJrUYQM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Ls2_f4rOMmC6qAFIlv79xg-1; Wed, 27 Mar 2024 02:03:25 -0400
X-MC-Unique: Ls2_f4rOMmC6qAFIlv79xg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5681b29771fso4996739a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 23:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711519404; x=1712124204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKfNn15MocWSA8Fi5e21Jcah10OEosZGaCmM8eoPCB0=;
 b=g5pw/VufxPgakLJVSblJmoTyWEWyRBTM0KZboZhiJsG/uYAQ+cLnFKcnuxDFNKzRZl
 oeIVS6QxRVBg90VyAg9rjDUHLK3CpNT+tJDiG6frGMqMVMFamDrehF4Hti3HOSqpvn8i
 mgRC/3i9kdu7CbpVnmvex/5wFCIH0ldoCPcGQLcMLRb+1esC/CKIbNFA+4ahkaf0aeA2
 Ed0LHbmmsyift52y6f7De18fxhYWg3lxXPUK+MoWmOfySD9CyQm88A1tLaYR8Jbxs85u
 DU5RBAslyJbg+daWG6qPYRXjLP+XpgYlSbSX7vQuVQ2lsxR5MRFfDB4Uq0pQuis/4X8+
 2Gcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGkwxHPNAGPk1gl1PVGFQU3PJtSYJ6eMOdaVombszJ/IUd6gUfFdSzu7upE4MPONkDJnahrRXEh+pWbaEvwUN4AJt9AY=
X-Gm-Message-State: AOJu0Yxpw9xSa1OMEBfBGoqHG8SaGLZe3ooHdDMnab0Qx1diWQzPm7CM
 l2xvMw+4yHljY5bOBANbig/T1MzkUBOPUk3Tq0RYDAnNbq26XOSjm/+I/Pp1X9+Gav+TXt5qQp4
 Kb5XerQWd5Pqww3TFIrXBleT8BgR15xSd8+/SJy99Cz7pj28CEXY8P0jKfiJli0cwtKuBkdh4j/
 8GjC5xhaXrZVBl1MUmzkRSAqUl0lk=
X-Received: by 2002:a17:906:b18f:b0:a46:da84:471a with SMTP id
 w15-20020a170906b18f00b00a46da84471amr146626ejy.63.1711519404141; 
 Tue, 26 Mar 2024 23:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMQz8PaLRQZdUMzU3iJuVg6arPRv5YZ9fQqAzT5lGn0AGusfFnLmKXAvKz39c7Y4nDGr9EsF5FL7iKaA0NQbk=
X-Received: by 2002:a17:906:b18f:b0:a46:da84:471a with SMTP id
 w15-20020a170906b18f00b00a46da84471amr146616ejy.63.1711519403839; Tue, 26 Mar
 2024 23:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240327012905.70188-1-lulu@redhat.com>
 <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
In-Reply-To: <CACGkMEt5fTtwmeb18Yj0xDT_bCjsJQM2nB-u1GJDfFKnEtSSHA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 27 Mar 2024 14:02:46 +0800
Message-ID: <CACLfguVY-yNWDAETt6gpUF7Ce5wbmLVXbpocsm7GW2mKRKukqQ@mail.gmail.com>
Subject: Re: [RFC 0/2] disable the configuration interrupt for the unsupported
 device
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
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

On Wed, Mar 27, 2024 at 11:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> Hi Cindy:
>
> On Wed, Mar 27, 2024 at 9:29=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > we need a crash in Non-standard image, here is the jira for this https:=
//issues.redhat.com/browse/RHEL-28522
> > The root cause of the issue is that an IRQFD was used without initializ=
ation..
> >
> > During the booting process of the Vyatta image, the behavior of the cal=
led function in qemu is as follows:
> >
> > 1. vhost_net_stop() was called, this will call the function
> > virtio_pci_set_guest_notifiers() with assgin=3D false, and
> > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vec=
tor 0
>
> Before vhost_net_stop(), do we know which vector is used by which queue?
>
before this stop, vdev->config_verctor is get from
virtio_pci_common_read/virtio_pci_common_write
it was set to vector 0
> >
> > 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTO=
Rt
> >
> > 3.vhost_net_start() was called (at this time the configure vector is
> > still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
> > assgin=3D true, so the irqfd for vector 0 was not "init" during this pr=
ocess
>
> How does the configure vector differ from the virtqueue vector here?
>
All the vectors are VIRTIO_NO_VECTOR (including vq). any
msix_fire_vector_notifier()
been called will cause the crash at this time.  So I think this should
be a bug in this guest image
> >
> > 4. The system continues to boot and msix_fire_vector_notifier() was
> > called unmask the vector 0 and then met the crash
> > [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> > [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
> >
> > The reason for not reproducing in RHEL/fedora guest image is because
> > REHL/Fedora doesn't have the behavior of calling vhost_net_stop and the=
n virtio_reset, and also won't call msix_fire_vector_notifier for vector 0 =
during system boot.
> >
> > The reason for not reproducing before configure interrupt support is be=
cause
> > vector 0 is for configure interrupt,  before the support for configure =
interrupts, the notifier process will not handle vector 0.
> >
> > For the device Vyatta using, it doesn't support configure interrupts at=
 all, So we plan to disable the configure interrupts in unsupported device
>
> Btw, let's tweak the changelog, it's a little bit hard to understand.
>
sure will do
thanks
Cindy
> Thanks
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > Cindy Lu (2):
> >   virtio-net: disable the configure interrupt for not support device
> >   virtio-pci: check if the configure interrupt enable
> >
> >  hw/net/virtio-net.c        |  5 ++++-
> >  hw/virtio/virtio-pci.c     | 41 +++++++++++++++++++++-----------------
> >  hw/virtio/virtio.c         |  1 +
> >  include/hw/virtio/virtio.h |  1 +
> >  4 files changed, 29 insertions(+), 19 deletions(-)
> >
> > --
> > 2.43.0
> >
>


