Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4896C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txME8-0002om-My; Wed, 26 Mar 2025 04:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txME2-0002nM-DD
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txMDz-00040j-C6
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 04:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742978098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lC/i9b+rrLInrfb1CAQqFaNrV4DucAAU7t1STN5P2Q=;
 b=F6sE6JpZlNfT5XAgflzEzOeLwr/tn7fbMu73j6m05LzP6OymcSYsKzo0UKscHBDpu3xCq6
 nqHIreZ2AV3YPHyi1IzbJrdm/GArbJf7cypSD57TWOuuOJv0zYET6CmyZbDfQuHdff2Fh0
 9AAzj/Ax3/2jCTFbb5yZv1M760VcNjc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-xkuXiYk8NkOB1CF9afxzag-1; Wed, 26 Mar 2025 04:34:55 -0400
X-MC-Unique: xkuXiYk8NkOB1CF9afxzag-1
X-Mimecast-MFC-AGG-ID: xkuXiYk8NkOB1CF9afxzag_1742978095
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff799be8f5so11710096a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 01:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742978095; x=1743582895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lC/i9b+rrLInrfb1CAQqFaNrV4DucAAU7t1STN5P2Q=;
 b=lDQaJ9CxlSuU0OMBVPreQKZffiP5y0A8IQfgaG3LtxNapEh7C2/OD6sRDTRvmvUigz
 y8iFHECInPavXFNKhOCUeaAhJP++NS3EGMimjiiTnqlQGU07B8r9p7Ym0aaigP66vIT+
 COr4eM0t5PqyMyinnEn+tT9RZZCwTWFvSe1DfrINcwzwaOop5vSkw10mJDD1GNIEuLUl
 zsi3EO0wOFr/L7q3xb6nxhLxWCZsmH/jgXJbgX1JT6oY9frQtM0diwYP72R67LqMqXve
 OPzyeVaYVmErmpSWErUptzq1CrK0JTMgfqXmPKZzQqHSDoacId4j9vsVVxLkre1geJGH
 HIdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuXbLYCn3D1EZp46DaPRZBhi0tmgqb8lxwk9zms6T5iWQAgmL8i1dgl5utIHRovBCjWwicUBuk9r56@nongnu.org
X-Gm-Message-State: AOJu0YzaDXy+LqdvLI/rDllyBqVgo5FMt8LHTd8FYhZ0vZG9/wuilnGG
 U4m4cmlUchDtkeu8CLXw6kbyGnl6KlPoCTdtFZfZH4otQjDx2SbDoRIiWhwmRnYA4vDpjNu3tG+
 R3rQ6/cgGDwxlG8eD9jqEiSwEVI06+iMKnPZr/eBo9zn5AJKeE6uLqKOUeh9d89atq4Gd0oua/r
 9W7O43V7AQ5J+81/B2zuZ+JmEjMl0=
X-Gm-Gg: ASbGnctQdoDnleu6WjA+9tjGjry6yfsuEBJvhFCcuB8BY/0Cg/LFe8+vRp9RcLC8d3Z
 +8vtpH95sd9Ec2K971TqF74AgEGr0grd27Mp8vsqrnrkOpNfEd8E+8sNcNEKnikR09TQ7/5s=
X-Received: by 2002:a17:90b:510e:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-3030fee56bdmr29901517a91.27.1742978094482; 
 Wed, 26 Mar 2025 01:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRrzJenaeZn4sP3eL9RjYIDaOA2Q3Bcv1sezVd1TXXYP6xPutJNj/ZjbYJz05e7TpOMxSjwicTZk69po7kZ3s=
X-Received: by 2002:a17:90b:510e:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-3030fee56bdmr29901483a91.27.1742978093955; Wed, 26 Mar 2025
 01:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-6-sahilcdq@proton.me>
 <49e5e2e1-4715-4949-93d5-b4e0f5425bbf@gmail.com>
In-Reply-To: <49e5e2e1-4715-4949-93d5-b4e0f5425bbf@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 09:34:17 +0100
X-Gm-Features: AQ5f1JobSyqD5t0sfVCJHUmfHq4AwtYps84TurYiX-bymmneX5wa2KXadBAeS2M
Message-ID: <CAJaqyWckqkkE=sB6yk1RhV8DVoPBAODqdNfgq5Vc0DLGo2_TNw@mail.gmail.com>
Subject: Re: [RFC v5 5/7] vhost: Forward descriptors to guest via packed vqs
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 24, 2025 at 3:34=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> I had a few more queries here as well.
>
> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> > Detect when used descriptors are ready for consumption by the guest via
> > packed virtqueues and forward them from the device to the guest.
> >
> > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> > ---
> > Changes from v4 -> v5:
> > - New commit.
> > - vhost-shadow-virtqueue.c:
> >    (vhost_svq_more_used): Split into vhost_svq_more_used_split and
> >    vhost_svq_more_used_packed.
> >    (vhost_svq_enable_notification): Handle split and packed vqs.
> >    (vhost_svq_disable_notification): Likewise.
> >    (vhost_svq_get_buf): Split into vhost_svq_get_buf_split and
> >    vhost_svq_get_buf_packed.
> >    (vhost_svq_poll): Use new functions.
> >
> >   hw/virtio/vhost-shadow-virtqueue.c | 121 ++++++++++++++++++++++++++--=
-
> >   1 file changed, 110 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index 126957231d..8430b3c94a 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -463,7 +463,7 @@ static void vhost_handle_guest_kick_notifier(EventN=
otifier *n)
> >       vhost_handle_guest_kick(svq);
> >   }
> >
> > -static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
> > +static bool vhost_svq_more_used_split(VhostShadowVirtqueue *svq)
> >   {
> >       uint16_t *used_idx =3D &svq->vring.used->idx;
> >       if (svq->last_used_idx !=3D svq->shadow_used_idx) {
> > @@ -475,6 +475,22 @@ static bool vhost_svq_more_used(VhostShadowVirtque=
ue *svq)
> >       return svq->last_used_idx !=3D svq->shadow_used_idx;
> >   }
> >
> > +static bool vhost_svq_more_used_packed(VhostShadowVirtqueue *svq)
> > +{
> > +    bool avail_flag, used_flag, used_wrap_counter;
> > +    uint16_t last_used_idx, last_used, flags;
> > +
> > +    last_used_idx =3D svq->last_used_idx;
> > +    last_used =3D last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR=
);
>
> In the linux kernel, last_used is calculated as:
>
> last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>
> ...instead of...
>
> last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)
>
> Isn't the second option good enough if last_used_idx is uint16_t
> and VRING_PACKED_EVENT_F_WRAP_CTR is defined as 15.
>

I think it is good enough with the u16 restrictions but it's just
defensive code.

> > +    used_wrap_counter =3D !!(last_used_idx & (1 << VRING_PACKED_EVENT_=
F_WRAP_CTR));
> > +
> > +    flags =3D le16_to_cpu(svq->vring_packed.vring.desc[last_used].flag=
s);
> > +    avail_flag =3D !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> > +    used_flag =3D !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> > +
> > +    return avail_flag =3D=3D used_flag && used_flag =3D=3D used_wrap_c=
ounter;
> > +}
> > +
>
> Also in the implementation of vhost_svq_more_used_split() [1], I haven't
> understood why the following condition:
>
> svq->last_used_idx !=3D svq->shadow_used_idx
>
> is checked before updating the value of "svq->shadow_used_idx":
>
> svq->shadow_used_idx =3D le16_to_cpu(*(volatile uint16_t *)used_idx)
>

As far as I know this is used to avoid concurrent access to guest's
used_idx, avoiding cache sharing, the memory barrier, and the
potentially costly volatile access.


