Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC65CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnNe-0005cW-7m; Thu, 25 Jun 2026 12:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wcnNH-0005bp-3n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wcnNF-0000e1-5y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782406579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNy3HAdSiOgrRl/nawawEJ1z90Vjuw9QjhpJlYeBLPk=;
 b=R5vcKDTrbe61vj82/zmNhx5zwQm3GHzQQh8ObvXDgy/Hd2dnUwffvSVoLGx8FxJdmvuM4k
 nOK2QRf5oPs0ZeaLPGlGqnBeddCFCOlkt6Ygt5aVaQWFgZAn2W8UAIwKQc9DD/exF7nIkR
 3knutFZfNMfS2NY7Qp7o/GFD2YNRtpU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-AfTPczKaPZe-qaC7wkOctA-1; Thu, 25 Jun 2026 12:56:18 -0400
X-MC-Unique: AfTPczKaPZe-qaC7wkOctA-1
X-Mimecast-MFC-AGG-ID: AfTPczKaPZe-qaC7wkOctA_1782406577
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84531eaf8a8so3610417b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782406577; cv=none;
 d=google.com; s=arc-20260327;
 b=AoZ/u8449RooaHU28hq8S7pAbnI0ujeAicI98KcOK7HiyHFN6TONjZxlrjFkDwOfDS
 NhNa6XM3FUieh/+P7DywJXvyvzBuBHBDtfzEBeTSS2w7wi1ysUHf/IM17rD7iM+i/7E6
 jC5Ty8rSwQrtVAxB0qkcaXAQ5nio0Lcvr+kW2scrZStZRDkL8cwIqXORFDlMoHCtqB3y
 pfBQuzQXYQn6YDRTyTKAJCcHEdE91MDUlHK1sVy7Q+PEih/wh+bbEmzxkR2hUWs+5YAD
 jXnHgXj1aowsKba/XUQwIqHqUKEEbx0ZKZ2dC/j4yUvkKPBP6pV0E4BamyS93+Hj7tGh
 C6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gNy3HAdSiOgrRl/nawawEJ1z90Vjuw9QjhpJlYeBLPk=;
 fh=OYDRjMZhGsb5AY/vlEaloJh7mxCoqYR8Z60TM+ctMhw=;
 b=OWAF0yLQGqziQQGeRKG8EZtgSxwb0eLImrYHCWDnbcEzO/9yvC3Eee8dBuMF63afcf
 fXiocFjLskdJPf5Fi8nwlRvmsbpDXqsuwSoAWypPRxiciqUdK2vRx4BsO5scLy2DYBg3
 L8QCpIyU3Cgs1mh55VsqNRh2Osm/gfmglym15ujLoXh3U58io4+e0GgXCG7k6lBT+urn
 uSTBkJV4tBE1oICC/bzpROhLRU1D+vLS/fhaWzMfhNh1cG6IbrLD+/Rh60zDlb0flELq
 syd+TQ4c2eMVQk6NAH5eNRTzkfL7lGhd1ZmxLFcew97EMmEgJsnVk56Ah8qh+mBc51Mc
 eR/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782406577; x=1783011377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNy3HAdSiOgrRl/nawawEJ1z90Vjuw9QjhpJlYeBLPk=;
 b=bduW2boJFdwXbcify97TSF40QFOqeljaDx/Ylc4Zkii+RZ9qCG+zzdobSZp6QCHvBk
 Nu5j1bA1PgACOw2h8gMsrfBQWldu5lI9i22KtHhIytppZv2qpE9+gQBawCJTtMNJSf0E
 Kh3Aja9fJsnKngdzujVEZef5tybsxbTeqEWuBe2zKvyDi4aqXiBX1ThUPGHLMJFcgl44
 cZZzQAB/i9ozogzFqOoqQiJLqHjJ7IMyvfQdMOabmxuiIPjZ5nOaoOGTA60+WlCk3h4V
 oepACS3anwVscuy38YFMnRvheG0Hhs1dj/zOSBKpm7uKyeM5mOSWAWuy5uPXSAjjmFx0
 FAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782406577; x=1783011377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNy3HAdSiOgrRl/nawawEJ1z90Vjuw9QjhpJlYeBLPk=;
 b=hx2d9gGKvGuDPICTyAwyESxYHBfWmjg+tYzHWOiWBAOcoLTWHGowC/vwJvkapo+E22
 CrmBU2nYjPSpAKE2ZWFJB4KA4V7FTfQqDE94PVcYc2yZR/uSQeFki7hIfKUXsksE+2QK
 8v2KkpXOZsz5CswxUdxcekCpbfZmujOPgmT+XqjxZwb2FEk3rIqMLLV/7xT9pFwFhnjW
 C5J2++ySlirh0xUXxXRFBvwEUDYx/IHhvNuPlunCFC0D3Pu0KdaIXgnPfiKcX8VO/SAB
 bW6n2ak6SXgDeOZEINpwcUi9tCJ2s24cUo1auAwmwzHS2fYUgeeQUiCCk04/CGGQDAx/
 Rk7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyDhj9Nv48PcCmMEcn1ShIEbWTgrFvzUo83g9H2THbTMC5E0X7WAvkleRRWTbcx3S0i9/5Gx/W9vHJ@nongnu.org
X-Gm-Message-State: AOJu0Yxw0i4kezxSiqlC3BIK00oF4Zg4EUIXDq+2iNraRP9waMqUEoVJ
 8LNg32mDAdPV4K7H755uVhlzLEWgj2R8cIyY2ce3KLhq/WM8stm6WyeLvRcalGJcVryqx45AJSC
 KB694SZv/qfzBBRFMl9chJxP4iGqluJyEim6ta1bAR8iGgT3/S2nbesDJWE8yqwvfQVZ27T14hX
 P2aaPJsIti7prLFaYaRvlkvYoyww0mVbI=
X-Gm-Gg: AfdE7cliqv6Yi4Z+zgI2icKdmmtpuPHa3kXb2sq2ixbOugxzUBoKlfcrlaPO69/9AmQ
 2qD1DUEaRilO09uTnGDZvYu0bVJZC4wOGrK1iMAFuvpCS3cuj67ATX8BxdnrSQr4Hb4jwyCRtdj
 d3rK91scV1bwsXOAP60m5lql+xAkiKrfoIlCCVGckNRxVpiA0DuT8RToBFkZmsn5U4/g==
X-Received: by 2002:a05:6a00:189c:b0:842:5d9b:d590 with SMTP id
 d2e1a72fcca58-845b3af7dc9mr4027635b3a.30.1782406576785; 
 Thu, 25 Jun 2026 09:56:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:189c:b0:842:5d9b:d590 with SMTP id
 d2e1a72fcca58-845b3af7dc9mr4027605b3a.30.1782406576260; Thu, 25 Jun 2026
 09:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
In-Reply-To: <ajljKftAKpkoiN7w@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 25 Jun 2026 18:56:05 +0200
X-Gm-Features: AVVi8Cep5a-WWUkeSPmx41u5LWUYNK-YmdaDWBjSqB0o5J9K_mlKep3-uUxLaDA
Message-ID: <CAA8xKjXARvc3m7F30Us-57BMqaCo1qqZMp8c_wBzMAs_cvFj=Q@mail.gmail.com>
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
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

On Mon, Jun 22, 2026 at 6:30=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > A malicious guest can craft virtqueue descriptors with arbitrary length=
s.
> > control_out() calls iov_size() on the guest-supplied scatter-gather lis=
t
> > and passes the result directly to g_malloc(), allowing a guest to force
> > QEMU to attempt multi-gigabyte allocations and crash the host process.
> >
> > Fix this by copying at most sizeof(struct virtio_console_control) into =
a
> > stack-local variable instead of allocating a buffer sized by the guest.
> > handle_control_message() only accesses the fixed-size id, event, and
> > value fields, so no data beyond the struct was ever needed.
>
> Does anyone have thoughts on whether we should treat guest initiated
> unbounded allocs as a security issue ?
>
> IIUC, this flaw would require root in the guest OS in order to craft
> the malicious virtqueue descriptors.
>
> A self-initiated crash triggered by root would not historically
> be enough justification for CVE. We would require it to be triggered
> by unprivileged user.
>
> Nested virt with device assignment could change that equation though
> as the L2 guest could be considered an unpriv user from the L1 POV.
>
> Also in theory the large alloc might be large enough to consume all
> host RAM but not large enough to trigger OOM kill of QEMU. This might
> impact operation of other co-located VMs on the same host.
>
> Anyone think this is bad enough to justify a CVE ? Or should we treat
> these OOM scenarios maerely as "hardening" bugs, where they require
> 'root' in the L1 guest ?

I'd lean toward classifying these as hardening bugs. I don't see the
point in assigning Low CVEs to these kinds of issues nowadays. Under
current vulnerability management standards, they would definitely be
pushed down the priority list and likely skipped or deferred.

> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3585
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  hw/char/virtio-serial-bus.c | 34 +++++++---------------------------
> >  1 file changed, 7 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > index cd234dc6db1d..c1973f0248fc 100644
> > --- a/hw/char/virtio-serial-bus.c
> > +++ b/hw/char/virtio-serial-bus.c
> > @@ -344,22 +344,16 @@ void virtio_serial_throttle_port(VirtIOSerialPort=
 *port, bool throttle)
> >  }
> >
> >  /* Guest wants to notify us of some event */
> > -static void handle_control_message(VirtIOSerial *vser, void *buf, size=
_t len)
> > +static void handle_control_message(VirtIOSerial *vser,
> > +                                   struct virtio_console_control *gcpk=
t)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(vser);
> >      struct VirtIOSerialPort *port;
> >      VirtIOSerialPortClass *vsc;
> > -    struct virtio_console_control cpkt, *gcpkt;
> > +    struct virtio_console_control cpkt;
> >      uint8_t *buffer;
> >      size_t buffer_len;
> >
> > -    gcpkt =3D buf;
> > -
> > -    if (len < sizeof(cpkt)) {
> > -        /* The guest sent an invalid control packet */
> > -        return;
> > -    }
> > -
> >      cpkt.event =3D virtio_lduw_p(vdev, &gcpkt->event);
> >      cpkt.value =3D virtio_lduw_p(vdev, &gcpkt->value);
> >
> > @@ -457,41 +451,27 @@ static void control_in(VirtIODevice *vdev, VirtQu=
eue *vq)
> >
> >  static void control_out(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> > +    struct virtio_console_control cpkt;
> >      VirtQueueElement *elem;
> >      VirtIOSerial *vser;
> > -    uint8_t *buf;
> >      size_t len;
> >
> >      vser =3D VIRTIO_SERIAL(vdev);
> >
> > -    len =3D 0;
> > -    buf =3D NULL;
> >      for (;;) {
> > -        size_t cur_len;
> > -
> >          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> >          if (!elem) {
> >              break;
> >          }
> >
> > -        cur_len =3D iov_size(elem->out_sg, elem->out_num);
> > -        /*
> > -         * Allocate a new buf only if we didn't have one previously or
> > -         * if the size of the buf differs
> > -         */
> > -        if (cur_len > len) {
> > -            g_free(buf);
> > -
> > -            buf =3D g_malloc(cur_len);
> > -            len =3D cur_len;
> > +        len =3D iov_to_buf(elem->out_sg, elem->out_num, 0, &cpkt, size=
of(cpkt));
> > +        if (len =3D=3D sizeof(cpkt)) {
> > +            handle_control_message(vser, &cpkt);
> >          }
> > -        iov_to_buf(elem->out_sg, elem->out_num, 0, buf, cur_len);
> >
> > -        handle_control_message(vser, buf, cur_len);
> >          virtqueue_push(vq, elem, 0);
> >          g_free(elem);
> >      }
> > -    g_free(buf);
> >      virtio_notify(vdev, vq);
> >  }
> >
> > --
> > 2.54.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


