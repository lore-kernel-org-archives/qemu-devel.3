Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0751C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty4Y8-0001C0-QM; Fri, 28 Mar 2025 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4Y6-0001BH-Ij
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4Y4-0005Pp-P6
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 03:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743148479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwzAUbpwlv4rc3tyiWvz4Lzh2MBD2bnnMEGFgBHoEA0=;
 b=ZZJvsKG5seFcEwURv0Gynn6GPFVLgR16XuXERz0n1lMLHBHK1q8WcGOeVTtaUI/0WRIquW
 yEiloJgVtPtNct5Zg7/olsSp8jld0gtLY6tpvw4v/RNcaWCGJmsRFhWDw2NA5TlvJeE6u/
 URWUOv3+BHjhvheGJ7eCWqI4W8pupHA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-LYJN6eL8NjqfX-YT916YzA-1; Fri, 28 Mar 2025 03:54:38 -0400
X-MC-Unique: LYJN6eL8NjqfX-YT916YzA-1
X-Mimecast-MFC-AGG-ID: LYJN6eL8NjqfX-YT916YzA_1743148477
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3032f4eca83so3218598a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 00:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148477; x=1743753277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwzAUbpwlv4rc3tyiWvz4Lzh2MBD2bnnMEGFgBHoEA0=;
 b=iHF1gZNCw5Ly/ZYBPMbd2YASInqCsEEgyimR+2KatBR5uO9jF47tWEnGkyHz0hpOsy
 sD1Lrkace79MNkyGMou5i2ZoJ72dPVRteEKhyW5lBBu0HJBPai7VhaGBFjZ1aGoINPcj
 IUuKZ9YrhIUKg6n0EtYRyjqORo98BIq2TsTkcDCrmEfBofPlF2/iFum8E7pXTANjYgK/
 C4689DDe4Aeb4ibpRkp6cgCVGbCyfcSY3PUrykI8qkvwFT/afb5SKnQF1FfzOmqa7XgP
 go8w3WKrQuHCoM/ZjE2CDCJnItK/XMrqLv4W5q8Do6df/zOQ82nEqBFHv8U2F1+mxEGI
 HoVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOdYZlDd6xun9MrfTuecJJx4kz10VfoMqKPPex6IK7om3c2KZqMHKIMfM5pWo1VhKEc8JZrbLf3Khs@nongnu.org
X-Gm-Message-State: AOJu0Yz9Y2UtuXgb1oSztEseFUWIDs8NyrgfNtVwcJcWXo+gxqBZa9Dt
 6i9Iw5JvKYI/aTZ2QrEF7603rMHB9SrxIL7pPB1h17SBMKTsaelZl/bA80y4OMUKqX7YRDU+Is/
 fct1RAeSC2zLR8Kb+loLUVvjk4GwM641U26ZasaMBxT/GEBiQT48jGIWaSCYuHeiaU35OsSJSLE
 MDDfb+oXrU6lYl7xVax6B5DKEO5WH6wsdNW6o=
X-Gm-Gg: ASbGncsigJx4dbSAZyhGLa3o7MFh2MCkOK7WX/LxcLHl+G/QJ3+/q+ZuWhUQB61UnwA
 5jWkb7rDDPZCeqvdsiBjRRGbP2LvZ9DC3gHdIhjHebcs7ooSjliI6M8dt/6zQ+R4c09yZqMc=
X-Received: by 2002:a17:90b:520f:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-303a916d67dmr10981305a91.33.1743148476841; 
 Fri, 28 Mar 2025 00:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtLO+8CaBUb5NZRwlXDesJG8cIm+Ei7Hlx8SsQkR7Z/O8sXrpJTVWor3AWpEXc6ZV2uLwde0/OMuIJHoeNRC0=
X-Received: by 2002:a17:90b:520f:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-303a916d67dmr10981282a91.33.1743148476376; Fri, 28 Mar 2025
 00:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-6-sahilcdq@proton.me>
 <49e5e2e1-4715-4949-93d5-b4e0f5425bbf@gmail.com>
 <CAJaqyWckqkkE=sB6yk1RhV8DVoPBAODqdNfgq5Vc0DLGo2_TNw@mail.gmail.com>
 <5a3f55be-5b5d-4a77-9e3d-0dbf1f4c7705@gmail.com>
In-Reply-To: <5a3f55be-5b5d-4a77-9e3d-0dbf1f4c7705@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Mar 2025 08:53:59 +0100
X-Gm-Features: AQ5f1JpCG0TD5Tttvi9M1aDH9wFwxExWkBQfiuJZO6aNq-qwkk3q5055Qc_a47A
Message-ID: <CAJaqyWcR0-mtfx=o127gCFFkuAzqRWto-Nusq1TDm=tK7OnK7w@mail.gmail.com>
Subject: Re: [RFC v5 5/7] vhost: Forward descriptors to guest via packed vqs
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 28, 2025 at 6:22=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 3/26/25 2:04 PM, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 3:34=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>
> >> Hi,
> >>
> >> I had a few more queries here as well.
> >>
> >> On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> >>> Detect when used descriptors are ready for consumption by the guest v=
ia
> >>> packed virtqueues and forward them from the device to the guest.
> >>>
> >>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >>> ---
> >>> Changes from v4 -> v5:
> >>> - New commit.
> >>> - vhost-shadow-virtqueue.c:
> >>>     (vhost_svq_more_used): Split into vhost_svq_more_used_split and
> >>>     vhost_svq_more_used_packed.
> >>>     (vhost_svq_enable_notification): Handle split and packed vqs.
> >>>     (vhost_svq_disable_notification): Likewise.
> >>>     (vhost_svq_get_buf): Split into vhost_svq_get_buf_split and
> >>>     vhost_svq_get_buf_packed.
> >>>     (vhost_svq_poll): Use new functions.
> >>>
> >>>    hw/virtio/vhost-shadow-virtqueue.c | 121 +++++++++++++++++++++++++=
+---
> >>>    1 file changed, 110 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> >>> index 126957231d..8430b3c94a 100644
> >>> --- a/hw/virtio/vhost-shadow-virtqueue.c
> >>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> >>> @@ -463,7 +463,7 @@ static void vhost_handle_guest_kick_notifier(Even=
tNotifier *n)
> >>>        vhost_handle_guest_kick(svq);
> >>>    }
> >>>
> >>> -static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
> >>> +static bool vhost_svq_more_used_split(VhostShadowVirtqueue *svq)
> >>>    {
> >>>        uint16_t *used_idx =3D &svq->vring.used->idx;
> >>>        if (svq->last_used_idx !=3D svq->shadow_used_idx) {
> >>> @@ -475,6 +475,22 @@ static bool vhost_svq_more_used(VhostShadowVirtq=
ueue *svq)
> >>>        return svq->last_used_idx !=3D svq->shadow_used_idx;
> >>>    }
> >>>
> >>> +static bool vhost_svq_more_used_packed(VhostShadowVirtqueue *svq)
> >>> +{
> >>> +    bool avail_flag, used_flag, used_wrap_counter;
> >>> +    uint16_t last_used_idx, last_used, flags;
> >>> +
> >>> +    last_used_idx =3D svq->last_used_idx;
> >>> +    last_used =3D last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_C=
TR);
> >>
> >> In the linux kernel, last_used is calculated as:
> >>
> >> last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))
> >>
> >> ...instead of...
> >>
> >> last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)
> >>
> >> Isn't the second option good enough if last_used_idx is uint16_t
> >> and VRING_PACKED_EVENT_F_WRAP_CTR is defined as 15.
> >>
> >
> > I think it is good enough with the u16 restrictions but it's just
> > defensive code.
> >
>
> Got it. I think it'll be better then to follow the implementation in
> the kernel to keep it more robust.
>
> >>> +    used_wrap_counter =3D !!(last_used_idx & (1 << VRING_PACKED_EVEN=
T_F_WRAP_CTR));
> >>> +
> >>> +    flags =3D le16_to_cpu(svq->vring_packed.vring.desc[last_used].fl=
ags);
> >>> +    avail_flag =3D !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> >>> +    used_flag =3D !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> >>> +
> >>> +    return avail_flag =3D=3D used_flag && used_flag =3D=3D used_wrap=
_counter;
> >>> +}
> >>> +
> >>
> >> Also in the implementation of vhost_svq_more_used_split() [1], I haven=
't
> >> understood why the following condition:
> >>
> >> svq->last_used_idx !=3D svq->shadow_used_idx
> >>
> >> is checked before updating the value of "svq->shadow_used_idx":
> >>
> >> svq->shadow_used_idx =3D le16_to_cpu(*(volatile uint16_t *)used_idx)
> >>
> >
> > As far as I know this is used to avoid concurrent access to guest's
> > used_idx, avoiding cache sharing, the memory barrier, and the
> > potentially costly volatile access.
> >
>
> By concurrent access, do you mean in case one thread has already updated
> the value of used_idx?
>

Yes, concurrent access by the driver and the device. This could be the
case of different threads if the device is virtual in QEMU. The two
CPU threads are accessing the same memory region.


