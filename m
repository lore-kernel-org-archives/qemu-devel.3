Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E791EB7EBA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjOZ-00083F-Gx; Wed, 04 Mar 2026 05:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxjOY-000825-Qv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxjOX-0002g6-3P
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pr0dojQzMNRrsYn2MOYI6enPanfx1YdiGGLkfL1Cx4E=;
 b=UoHNs2yajLp7lwIEcD3ZsDhY7ZPBUKGRJ5q2onw2DXpgExS8MLK2We+cwD0ce6TiABS8Nf
 YOPnQcSKGaVVgBZ6f5Ko1uM8DM5pJkqN6rUK8LOtyuB7Vp9SoDm/XVWi/qs5gjVecsyoG+
 ZgSgkS27d/3D0Cm8x8wB1+nrS5nuvpA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-j5DRzvvAMPud5WUsomO5zQ-1; Wed, 04 Mar 2026 05:23:55 -0500
X-MC-Unique: j5DRzvvAMPud5WUsomO5zQ-1
X-Mimecast-MFC-AGG-ID: j5DRzvvAMPud5WUsomO5zQ_1772619835
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-798080635ceso76782637b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 02:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772619835; cv=none;
 d=google.com; s=arc-20240605;
 b=IxBjgVUaMm5F8s2DSc5U97lkVU7zJzHPp46sDSTFAloWSHdvcjBixkBtT/tHEy4+bu
 3Xw5GEyMWfKUhDIadvSJXTseEgbnnciynOIVeZxRBcPIcSOI9VK6jZVUx5Ohlh1zXgtw
 vX+dxvhdv5yPFq5+g3djidX6s2ZtBdcHK2DcyyCBciWrMc0KqxxjYmIltXSgu+z7LCF5
 /CBrE2tULHWm+uAixd6Hx84hUYVTtUhYmgu466Mdqqyad0jtbTTCvhZqQJ1gNlvLmLmS
 2zBK816vmivLGx/xpRdnKwZgc5GdVx5b0ExlbZDa8ZFF5ZD2YL5K5s6Xbm2vvOXeWuSh
 qrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pr0dojQzMNRrsYn2MOYI6enPanfx1YdiGGLkfL1Cx4E=;
 fh=/+XR4WOjNW1VKJ2gGmSXII/te/TjZO5mQ455a1KsGjQ=;
 b=lzdDz9SAvkRlpi1RfUyRakSzWhOHbwSx/RE9omM5tdNxuE0/LVxjfjk+lLCYNnArvQ
 f5ADWB7uN6T3Z612AqQ9iQl0nOIufv4BxxFni13CKcgYOM0RnGbdFnvV6Uv56uxwsr5V
 jpC1oWkm4qWuLrtCLg3Vm7v2Y6Jm7BaC5/sY2Ja5khoZv9uHf7/Md9/QXUKVBHJ/VOoX
 wcLG+zrPcGchCmsI+o59TduDqEG6MUDI2IlAi1mroigGEfY2GZW2N4l/4saAek/pfGWz
 SXIMuxUQZVZcPhS4cEo3kBSvSgPhQhHMvefnJmoiSWmcAuCwiCpk60fP/U5aOmaSPyoS
 i2aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772619835; x=1773224635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pr0dojQzMNRrsYn2MOYI6enPanfx1YdiGGLkfL1Cx4E=;
 b=rZ/yvK5kmgrAAOI2gmfiCsB1C/IwbWkNV70KKgMSpkjaNVjVY2iUfojNlDSTgD4cr4
 ReWLPfrziDN8bT7WoeU7gVIuzu/lUJZ/+I636POzHwBdqyBczFGqjhDN9uTAdqegYYZC
 1VYtpdSw9YSI8kO8UEwJlcL0Kz+IFXo98bPAYZ4vcBP9Hqnb4ysmf1TPiAZOeQXFjVMn
 YAlvF7I78YHWXuWRHFWeSYkeNhhfvoogbIPCK7RELSqgkM9nwaRZOSocNRDZUiyZoxFS
 S6qt6CXyCdAy4KVpTjVYV1tZy8a5k5sb447LTQ32Bb1rAu1ex0TkoVR5LrnpcpCYxaDb
 4V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772619835; x=1773224635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pr0dojQzMNRrsYn2MOYI6enPanfx1YdiGGLkfL1Cx4E=;
 b=izqG0cFxTdihKt4SuGQ42vBMMLHpHW5IYPZDAYN7LlT7uZVCcd+5+1Oi4awBlvKW5x
 Nn7Snvcz92flEEN1reVR72GaWJg85hkFMN294w3YVHjcyA6r4DQo8azNDcoiZAlnh1Bz
 7M+GURtVb/+kS1oqpfJQV4zEc0dpoZlECXI8WBdCG2zxv+SwbREGYZI8OmZalxOEVZjk
 w4MhLLfcNlP8ei9BGGxOnJFRWRzBrXJyM4L3yOTWXPGJFyg2nbMrdUxm7lgOU4w8uVwu
 bKm5a/YfI4j4XJGCl0OKCk2sf8O0etWUxcYJaSqHtVW3BjwE7mkapdGEyL4v/rROMj9z
 O0OA==
X-Gm-Message-State: AOJu0YwJ7vJHB/0mN6DISHxBWkHFAZno8Sk3vwX4AYooPJdoHnnN0/gV
 MssrXb4tEDN7v/b3vPmihyrqVfGOvRC0P0WUCDzFpSmXNZPRh5w5qqv9bNiCMJInwoseZCmY88w
 091aKIt3V+g1UCKIvGt1R+rxLlbybcZFYxywO3lE5X/GRRwAx+OcEpCo9bTRMYGxJcq3br6o0HA
 d0gPsEwNIYSNSTGKqBXZNJBljHtHUrz9AgTSlpgM5g9zZt
X-Gm-Gg: ATEYQzw+E/38PnFKiuyTlgX83oJeQEWVPijgvpTxn+1GaZCitNIqXBlfN7v0wLdJDOy
 ab4vFw6BdSpI8g859Yg6QHIOCoZG/ij94/XDzQmYVl5hbW2rlhQcFZuGjzSr4OTDILcpo/lpPIv
 TJ275bVCNxBMO06FgruG4rXjIJTNs1YpFaO0hyY6hQyz+hXS1irjSf/DF/GIMzG3vgBKxpvfw/Z
 w==
X-Received: by 2002:a05:690c:6611:b0:798:c347:ccfd with SMTP id
 00721157ae682-798c6b85141mr10098437b3.11.1772619834641; 
 Wed, 04 Mar 2026 02:23:54 -0800 (PST)
X-Received: by 2002:a05:690c:6611:b0:798:c347:ccfd with SMTP id
 00721157ae682-798c6b85141mr10098237b3.11.1772619834210; Wed, 04 Mar 2026
 02:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-4-aesteve@redhat.com>
 <CADSE00KJdqPp=mnC0zxPsZucWD+6-0zdiFM3XbZmSsTU1oMang@mail.gmail.com>
In-Reply-To: <CADSE00KJdqPp=mnC0zxPsZucWD+6-0zdiFM3XbZmSsTU1oMang@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 11:23:42 +0100
X-Gm-Features: AaiRm51s3smspaurs7BZnmD712iRvAvkJ704g2_RGPixapmC9TajdCISnO5NRZk
Message-ID: <CADSE00+YH8LKdEWOy2edh6D2geaaGutN8X+pjkEhNmmgWj=M3Q@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com, 
 dbassey@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, 
 manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, hi@alyssa.is,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 4, 2026 at 10:46=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Thu, Feb 19, 2026 at 2:04=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > Add SHMEM_MAP/_UNMAP request to the vhost-user
> > spec documentation.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 61 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 17a68a62eb..ae4ad6f441 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -350,6 +350,27 @@ Device state transfer parameters
> >    In the future, additional phases might be added e.g. to allow
> >    iterative migration while the device is running.
> >
> > +MMAP request
> > +^^^^^^^^^^^^
> > +
> > ++-------+---------+-----------+------------+-----+-------+
> > +| shmid | padding | fd_offset | shm_offset | len | flags |
> > ++-------+---------+-----------+------------+-----+-------+
> > +
> > +:shmid: a 8-bit shared memory region identifier
> > +
> > +:fd_offset: a 64-bit offset of this area from the start
> > +            of the supplied file descriptor
> > +
> > +:shm_offset: a 64-bit offset from the start of the
> > +             pointed shared memory region
> > +
> > +:len: a 64-bit size of the memory to map
> > +
> > +:flags: a 64-bit value:
> > +  - 0: Pages are mapped read-only
> > +  - 1: Pages are mapped read-write
> > +
> >  C structure
> >  -----------
> >
> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserInflight inflight;
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> > +          VhostUserMMap mmap;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1064,6 +1086,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
>
> Commit cda83adc62b6108afc8a82d0f54d9a9a861e7aa8 got upstream first and
> took feature number 20, so this should be 21 now.
>
> @Michael Tsirkin Is it worth sending a new version or will you handle
> the change?

Sorry, I meant e0822e6085aecc15e2cfb2914d8cd827abae0249 (vhost-user:
introduce protocol feature for skip drain on GET_VRING_BASE).

But the question remains.

>
> >
> >  Front-end message types
> >  -----------------------
> > @@ -1872,6 +1895,44 @@ is sent by the front-end.
> >    when the operation is successful, or non-zero otherwise. Note that i=
f the
> >    operation fails, no fd is sent to the backend.
> >
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> > +  Upon receiving the message, the front-end will mmap the given fd int=
o the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> > +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> > +  must respond with zero when operation is successfully completed,
> > +  or non-zero otherwise.
> > +
> > +  Mapping over an already existing map is not allowed and requests sha=
ll fail.
> > +  Therefore, the memory range in the request must correspond with a va=
lid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mapp=
ings
> > +  consume resources and that the request can fail when there are no re=
sources
> > +  available. Lastly, mappings are automatically unmapped by the front-=
end
> > +  across device reset operation.
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds so
> > +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) =
in the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that =
the
> > +  given range shall correspond to the entirety of a valid mapped regio=
n.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-e=
nd
> > +  sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond =
with
> > +  zero when operation is successfully completed, or non-zero otherwise=
.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > --
> > 2.52.0
> >
> >


