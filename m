Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3831C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 08:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYLe2-0004nr-5L; Mon, 29 Jul 2024 04:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sYLe1-0004nN-1f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sYLdx-00077W-MA
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722241326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+1fH29FBDl2TxsiiVOxEM2550DR6CgQez/L+2KB+ro=;
 b=T19R6Ac3VHjXMXpYodl+eoM7O0h7WQG468pnjyvQTYLdpFkcyCbgUHrUEKZsY7BM+NvEMB
 kMfLuVNhSR7r1mkVPuLK6z2XhVaR4aQ5+T7e4N72hxP6732VfI7nFPI3FPTfJf8/cHAx7T
 ebvazAU6bdTdQvu2XGxaONiX9s9iLW0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-YTbEJ_hHM2a6ViBplNMlhA-1; Mon, 29 Jul 2024 04:22:04 -0400
X-MC-Unique: YTbEJ_hHM2a6ViBplNMlhA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-66af35f84a3so62776987b3.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 01:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722241323; x=1722846123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+1fH29FBDl2TxsiiVOxEM2550DR6CgQez/L+2KB+ro=;
 b=KOwE9/Z0+drQFKGc7u0ygzEM3uxf/NJWYdeqYyfwxfYvtkOz++xW6ZAuImNYFWPqGf
 UqkEVHxPeH0YdB5T9+wJ1LcvKIuaHf7vquX/AQgGeTaMTmQCbLkQItv/qgW9AWwHFd2h
 SV69vgyWpQgy1wNG3/LucQcYG1vWv3pXRK1/ChzAXFJcnQ6RcvHKIW6QyKQOwuF01SM9
 /VMKqdr+C+7eyM7zur1vzndGC01YfI3Ujp9fZT90avOMNxNDDhhGxFnvWYlnARVGUEVF
 4PqJAWsmy5IxeFhtDfQ2ZyuMggf5juGWrC3WkSr9e90pYbeNXcNMHkuRvW7vgAq1/K8m
 g+ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBklYExNZBAB8iW+jlY4jTHlIwaRWp84I1vYVYt7BHiuWLE21SUcgDHdFRxo+OZUzBEY0HZqB5R9VjgX17TznBSQxwmeQ=
X-Gm-Message-State: AOJu0YyxL9gYvf3iKsymn74b5Oyo3K9lZJX4Oe59xFOhYa6AkU2rHxbg
 p6MoDLlpWGHVvXU+wicJV8jS7mFGW4Ix7u+a3VIq2fZoA+ljL0+Njl2lNZEcI2zQxewPF+b9lBL
 8eIFVjnCl/9WwTsiwiXuxE7M2tn1b4JjprmwxZRqc2SBq1ujtxWgIVLs2nQK7VbjkCWQEgHFoIn
 /wwQrRfmxuZbOOEJUJH7NpHBUAmaI=
X-Received: by 2002:a05:690c:c07:b0:615:10f8:124a with SMTP id
 00721157ae682-67a097867b3mr101899017b3.29.1722241323653; 
 Mon, 29 Jul 2024 01:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/zdA049V9PW5vjtqr8H7qaQdt6m2nuxg6IYzwKD1BCYMrD5jvcOvI+4A6zNXaeuf8QwrmDyAWKIpEHFPbFuc=
X-Received: by 2002:a05:690c:c07:b0:615:10f8:124a with SMTP id
 00721157ae682-67a097867b3mr101898897b3.29.1722241323397; Mon, 29 Jul 2024
 01:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <20240726095822.104017-2-sahilcdq@proton.me>
 <CAJaqyWdkbPd-zjbtn2JE9B-p6wx5f-sK1Ziv6bTqwSosLMpZfA@mail.gmail.com>
 <2957475.e9J7NaK4W3@valdaarhun>
In-Reply-To: <2957475.e9J7NaK4W3@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Jul 2024 10:21:27 +0200
Message-ID: <CAJaqyWd4Ts-JMofDeZ4Uv8Azdi3s_NaYmATd7ezJxwMG+HiPUw@mail.gmail.com>
Subject: Re: [RFC v2 1/3] vhost: Introduce packed vq and add buffer elements
To: Sahil <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 28, 2024 at 7:37=E2=80=AFPM Sahil <icegambit91@gmail.com> wrote=
:
>
> Hi,
>
> On Friday, July 26, 2024 7:18:28=E2=80=AFPM GMT+5:30 Eugenio Perez Martin=
 wrote:
> > On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> > > This is the first patch in a series to add support for packed
> > > virtqueues in vhost_shadow_virtqueue. This patch implements the
> > > insertion of available buffers in the descriptor area. It takes
> > > into account descriptor chains, but does not consider indirect
> > > descriptors.
> > >
> > > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> > > ---
> > > Changes v1 -> v2:
> > > * Split commit from RFC v1 into two commits.
> > > * vhost-shadow-virtqueue.c
> > >
> > >   (vhost_svq_add_packed):
> > >   - Merge with "vhost_svq_vring_write_descs_packed()"
> > >   - Remove "num =3D=3D 0" check
> > >
> > >  hw/virtio/vhost-shadow-virtqueue.c | 93 ++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 92 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > > b/hw/virtio/vhost-shadow-virtqueue.c index fc5f408f77..c7b7e0c477 100=
644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -217,6 +217,91 @@ static bool vhost_svq_add_split(VhostShadowVirtq=
ueue *svq,
> > >      return true;
> > >
> > >  }
> > >
> > > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > > +                                const struct iovec *out_sg, size_t o=
ut_num,
> > > +                                const struct iovec *in_sg, size_t in=
_num,
> > > +                                unsigned *head)
> > > +{
> > > +    bool ok;
> > > +    uint16_t head_flags =3D 0;
> > > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> > > +
> > > +    *head =3D svq->vring_packed.next_avail_idx;
> > > +
> > > +    /* We need some descriptors here */
> > > +    if (unlikely(!out_num && !in_num)) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                      "Guest provided element with no descriptors");
> > > +        return false;
> > > +    }
> > > +
> > > +    uint16_t id, curr, i;
> > > +    unsigned n;
> > > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc=
;
> > > +
> > > +    i =3D *head;
> > > +    id =3D svq->free_head;
> > > +    curr =3D id;
> > > +
> > > +    size_t num =3D out_num + in_num;
> > > +
> > > +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
> > > +    if (unlikely(!ok)) {
> > > +        return false;
> > > +    }
> > > +
> > > +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_nu=
m);
> > > +    if (unlikely(!ok)) {
> > > +        return false;
> > > +    }
> > > +
> >
> > (sorry I missed this from the RFC v1) I think all of the above should
> > be in the caller, isn't it? It is duplicated with split.
>
> I don't think this will be straightforward. While they perform the same l=
ogical
> step in both cases, their implementation is a little different. For examp=
le, the
> "sgs" pointer is created a little differently in both cases.

Do you mean because MAX() vs in_num+out_num? It is ok to convert both
to the latter.

> The parameters to
> "vhost_svq_translate_addr" is also a little different. I think if they ar=
e moved to
> the caller, they will be in both "svq->is_packed" branches (in "vhost_svq=
_add").
>

I don't see any difference apart from calling it with in and out sgs
separately or calling it for all of the array, am I missing something?

> > Also, declarations should be at the beginning of blocks per QEMU
> > coding style [1].
>
> Sorry, I missed this. I'll rectify this.
>

No worries!

You can run scripts/checkpatch.pl in QEMU for the next series, it
should catch many of these small issues.

Thanks!


