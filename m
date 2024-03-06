Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F47FC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 07:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhlOA-0001gB-0g; Wed, 06 Mar 2024 02:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhlNw-0001eR-5M
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhlNu-0003B6-Cb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709708890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Bg+9nnBnQiKUhfPvTXxHylY5Z2AaFb8qG98b0TNEv8=;
 b=OXDvq8AvXHPutCB5HPwYq7fDJ/bG9rUAlfYfwjSVXjsk0reE5lRwnqSRuaebkUMPeRQBi5
 NUD94fVi/tTdlVs9LCyh7VYSH+0QhBybVX2yJ8F1KOUcKRnsPmWdNDkffVOX60A3w2wt/Z
 NAZaqThih36AUw562CNFq/3TBhRs9fI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-iCyIXA_3P6K0DFpvNoqyFg-1; Wed, 06 Mar 2024 02:08:08 -0500
X-MC-Unique: iCyIXA_3P6K0DFpvNoqyFg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dced704f17cso11083109276.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 23:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709708887; x=1710313687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Bg+9nnBnQiKUhfPvTXxHylY5Z2AaFb8qG98b0TNEv8=;
 b=EqMOrWKXcULNc69GBwozxWdEweImnE9DUg7Y3fhmubuCYiN/0Bru43qSsL/yS5qtR6
 h8V30ACdY4AAZ25kta0lZMxYPB8RQKmZ4TeFSPGrwMZo/jp3LpiEYIr/rPgsFH+pV94b
 H+eu+MUIFUOhiAwJ+hO0qrfFuGDS2QNIa+o8L5byPDZFjMd+tRIbEYtHULmsnQCpJI45
 KtM1hdfUtW6h+Y+a0u3PgrmN2pb5sS9t8LgK7JVto0zUiiTfxXJ8CUakKTjhoaR+TZ/D
 k2dwxputhK3vtJmc4p20GFwstnZggsKOIu+3Gon3F9ALqL11zCG/xzmPAcJ21zPY4pwk
 TWIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwoMhiKIIYkf6DMmarIrpjqyBPQKKwfpZ90FdPv9h9QRMfZ/iOtyFQlyyNtWLNq00dUrRyg5bw4K5xk+x4mhCavQ9IKqc=
X-Gm-Message-State: AOJu0Yw1XlY3q16il3dePfWyo8qcbvsMKyNnIRX/wtqTZK7Hf4CyoYnE
 6GagEgfb5L0K8Jy5FxJJ23+UIsbLIo/l/D4n5hKCsUANcVq/TRj/ebe5XwJGvlQtlWbkQVZjJT+
 OlnlpZ/Zisa1a14TdayOfgIzeEPlS42DEJxKvDa8xMQjKAv6o7oWb1tk8GG+qE4D0Gh9fOuYTYp
 Wt6x5gWwQZZir+PNfbIGNDTiHZccE=
X-Received: by 2002:a5b:8c1:0:b0:dcb:effc:47e5 with SMTP id
 w1-20020a5b08c1000000b00dcbeffc47e5mr12915552ybq.40.1709708887439; 
 Tue, 05 Mar 2024 23:08:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMWaVYkacC6lidYWtTzztgN5S8Cz7zoQPfPQlfnE3TRyu8QU9qfiMTicWHaN9f+E5Y/Q7o3Yj3qfrkDfK5CgE=
X-Received: by 2002:a5b:8c1:0:b0:dcb:effc:47e5 with SMTP id
 w1-20020a5b08c1000000b00dcbeffc47e5mr12915529ybq.40.1709708887176; Tue, 05
 Mar 2024 23:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
In-Reply-To: <CACGkMEtoA3SN9e9WnNpFyR32rkf_pWUNj-6uj2TZBzjB0E+3SQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 6 Mar 2024 08:07:31 +0100
Message-ID: <CAJaqyWdAFTkjGBJBmxvmTZT8UUiH86UGgE74X_bcq22nd-WwHA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] virtio,
 vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: Jason Wang <jasowang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 6, 2024 at 6:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Mar 5, 2024 at 3:46=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
> >
> > The goal of these patches are to add support to a variety of virtio and
> > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. Thi=
s
> > feature indicates that a driver will pass extra data (instead of just a
> > virtqueue's index) when notifying the corresponding device.
> >
> > The data passed in by the driver when this feature is enabled varies in
> > format depending on if the device is using a split or packed virtqueue
> > layout:
> >
> >  Split VQ
> >   - Upper 16 bits: shadow_avail_idx
> >   - Lower 16 bits: virtqueue index
> >
> >  Packed VQ
> >   - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> >   - Lower 16 bits: virtqueue index
> >
> > Also, due to the limitations of ioeventfd not being able to carry the
> > extra provided by the driver, ioeventfd is left disabled for any device=
s
> > using this feature.
>
> Is there any method to overcome this? This might help for vhost.
>

As a half-baked idea, read(2)ing an eventfd descriptor returns an
8-byte integer already. The returned value of read depends on eventfd
flags, but both have to do with the number of writes of the other end.

My proposal is to replace this value with the last value written by
the guest, so we can extract the virtio notification data from there.
The behavior of read is similar to not-EFD_SEMAPHORE, reading a value
and then blocking if read again without writes. The behavior of KVM
writes is different, as it is not a counter anymore.

Thanks!

> Thanks
>
> >
> > A significant aspect of this effort has been to maintain compatibility
> > across different backends. As such, the feature is offered by backend
> > devices only when supported, with fallback mechanisms where backend
> > support is absent.
> >
> > Jonah Palmer (8):
> >   virtio/virtio-pci: Handle extra notification data
> >   virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> >   virtio-mmio: Handle extra notification data
> >   virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> >   virtio-ccw: Handle extra notification data
> >   virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
> >   vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bit=
s
> >   virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition
> >
> >  hw/block/vhost-user-blk.c    |  1 +
> >  hw/net/vhost_net.c           |  2 ++
> >  hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
> >  hw/s390x/virtio-ccw.c        |  6 ++++--
> >  hw/scsi/vhost-scsi.c         |  1 +
> >  hw/scsi/vhost-user-scsi.c    |  1 +
> >  hw/virtio/vhost-user-fs.c    |  2 +-
> >  hw/virtio/vhost-user-vsock.c |  1 +
> >  hw/virtio/virtio-mmio.c      | 15 +++++++++++----
> >  hw/virtio/virtio-pci.c       | 16 +++++++++++-----
> >  hw/virtio/virtio.c           | 18 ++++++++++++++++++
> >  include/hw/virtio/virtio.h   |  5 ++++-
> >  net/vhost-vdpa.c             |  1 +
> >  13 files changed, 68 insertions(+), 17 deletions(-)
> >
> > --
> > 2.39.3
> >
>


