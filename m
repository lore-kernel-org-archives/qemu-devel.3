Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6D2D44D78
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 15:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8hWk-0007CT-Th; Wed, 06 Nov 2024 10:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1t8hWg-0007BN-Kj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1t8hWb-0002aq-By
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 10:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730905243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=el/nBzJVZRpWnu2L2U66k728SyuxmsHzzoWcU0Uy5/A=;
 b=GpiWaEK6RlIOXGAZP0HtvBbirdY12RkmkGNJ0CxUYtfuAx/C1vSmrjwcjSOIGwoAa6u+4o
 4PHZt3LfMza+OD0DJ9C9ThxRHw65PJ162kap+FBb9Kg7QEHiLo5uQbcBcbj18zz/wPGnWG
 P1ZFGZuzijTDVGGjiVr+IiOcz60NZXI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-KgXh1_BJNY6x2NXwq7Ep2Q-1; Wed, 06 Nov 2024 10:00:40 -0500
X-MC-Unique: KgXh1_BJNY6x2NXwq7Ep2Q-1
X-Mimecast-MFC-AGG-ID: KgXh1_BJNY6x2NXwq7Ep2Q
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6ea863ecfe9so83552677b3.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 07:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730905240; x=1731510040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=el/nBzJVZRpWnu2L2U66k728SyuxmsHzzoWcU0Uy5/A=;
 b=ojUs02fisnK134JecRB2/CCV0aJ5dHkfxftireHSq1DINEQ+bkRPhObZ8jbxtqEcrf
 qZ7n2TlU1MxVSG9yq/aAzCssqZplDrACVC7sbvHSKjOBvLQgaP5Yc2lDEF3hzvM/SoaX
 HMZyvXNSza+Q/HhX5eHLuj1RcLFYu5dAPrZpze4EmX9BQuWw4g67B/SlWcBavynWVp5W
 5F+TH/xSmOf+JGUGtcFhBOgzbf+5QAZXe9F65QJjhYQdudea+um6ohkh41X5c29fF/x2
 BjUNHAm6iWkakhS/N9kU7BXnH6K5dtbFmc/Db23q7noMfDz7aA74og5NB34z1X0nV9o0
 iVtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXllIon7vjRpQ1doUdOJ/GbY9EZJw5tIOhlin9miywgh7Mf7uF1lQH5YZErNSmPM1tjZj8ju8wLT869@nongnu.org
X-Gm-Message-State: AOJu0Ywo8EQ3ZSfcQ7eY3FrEJ3OSzw8uJ6rci1hl7oZ8qOA9A9NPvSk9
 MMUK27cQ0q0bpUaniXQU7Ro87aReqD0ikDJ+eNcDIcNuuF+ap6ltirY+OSK6YANZXeh9P543Nxz
 nW3iiuRm7Qqd/nGNucE8zETbe11+nsQAxLeGw+7s96A8b4sCrTqHmAejWbI+t4ag9lJG2wKy+un
 oo3xdhpVRtUO08TZwbGAlz8coBzQ8=
X-Received: by 2002:a05:690c:7207:b0:6ea:90b6:ab49 with SMTP id
 00721157ae682-6ea90b6b037mr121030317b3.5.1730905239916; 
 Wed, 06 Nov 2024 07:00:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI38Y7LjF1UqwMCvuz/ndiOIJYjQlEX6SMv0if/xBM9J0JPdI1w9rG4Na8EtcaOQlPPQAqSTJR6kZkmiGnhyw=
X-Received: by 2002:a05:690c:7207:b0:6ea:90b6:ab49 with SMTP id
 00721157ae682-6ea90b6b037mr121029717b3.5.1730905239282; Wed, 06 Nov 2024
 07:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20241104162124.49867-1-sahilcdq@proton.me>
 <k2suxbt2qy7ewjrlozlkzrhsa7bbf7xrze33outna65dejuus2@eamj5pdkvpkw>
 <77bc1be1-e4b3-46a0-a263-cc8f7d6e28fe@gmail.com>
 <pu5razer3dkaltyuwiav236sepob44mj6cmigskdcet7davn4t@6orjjrzeqtau>
In-Reply-To: <pu5razer3dkaltyuwiav236sepob44mj6cmigskdcet7davn4t@6orjjrzeqtau>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 6 Nov 2024 16:00:03 +0100
Message-ID: <CAJaqyWd6+F7PO6tjq5QtjrRkoZNQZiqEPOsrjEN9Zp3S2t7SUA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sahil Siddiq <icegambit91@gmail.com>, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 6, 2024 at 3:33=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Nov 05, 2024 at 08:24:17PM +0530, Sahil Siddiq wrote:
> >Hi,
> >
> >Thank you for the review.
> >
> >On 11/5/24 3:06 PM, Stefano Garzarella wrote:
> >>On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
> >>>Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the
> >>
> >>To refer to a commit, please use the SHA-1 id or even better the form
> >>suggested in
> >>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes
> >>
> >>So in this case I'd use:
> >>Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial stat=
e
> >>after reset")
> >
> >Understood, I'll change this in v2.
> >
> >>>vq state to the device's initial state. This works differently for
> >>>split and packed vqs.
> >>>
> >>>With shadow virtqueues enabled, vhost-vdpa sets the vring base using
> >>>the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
> >>>differs for split and packed vqs. The implementation in QEMU currently
> >>>uses the payload required for split vqs (i.e., the num field of
> >>>vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
> >>>payload is used with packed vqs.
> >>>
> >>>This patch sets the num field in the payload appropriately so vhost-vd=
pa
> >>
> >>I'm not very familiar with shadow virtqueue, so can you elaborate what
> >>"appropriately" means here?
> >
> >My understanding is that the ioctl and the payload themselves are not
> >directly related to shadow virtqueues [1]. They concern virtqueues in ge=
neral.
> >
> >In QEMU's implementation, hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_setup [2=
]
> >is called from hw/virtio/vhost-vdpa.c:vhost_vdpa_svqs_start [3] only whe=
n
> >shadow virtqueues are enabled.
> >
> >QEMU's vhost-user doc [1] states that the payload for the VHOST_SET_VRIN=
G_BASE
> >ioctl is different for split and packed vqs. The struct is the same:
> >
> >struct vhost_vring_state {
> >       unsigned int index;
> >       unsigned int num;
> >};
> >
> >The num field takes a different value depending on the virtqueue's forma=
t
> >(split vs packed). The explanation below throws more light on this.
> >
> >>>(with the vp_vdpa driver) can use packed svqs.
> >>>
> >>>Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg0510=
6.html
> >>>Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat=
.com
> >>>Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >>>---
> >>>QEMU currently does not support packed vhost shadow virtqueues. I am
> >>>working on adding support for packed svqs [1]. The test environment
> >>>that I am using [2] requires vhost-vdpa to use the relevant payload
> >>>when setting vring base.
> >>>
> >>>[1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtque=
ue
> >>>[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-=
aint-got-hardware-part-2
> >>>
> >>>hw/virtio/vhost-vdpa.c | 4 ++++
> >>>1 file changed, 4 insertions(+)
> >>>
> >>>diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>index 3cdaa12ed5..5f81945109 100644
> >>>--- a/hw/virtio/vhost-vdpa.c
> >>>+++ b/hw/virtio/vhost-vdpa.c
> >>>@@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_d=
ev *dev,
> >>>    };
> >>>    int r;
> >>>
> >>>+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
> >>>+        s.num =3D 0x80008000;
> >>
> >>Why this magic value?
> >>
> >>Looking at the kernel code it looks like we are assgining 0x8000 for
> >>both last_avail_idx and last_used_idx, but why 0x8000?
> >>
> >>Thanks,
> >>Stefano
> >>
> >
> >When I boot a VM with packed=3Don and x-svq=3Dtrue, QEMU sets the vring =
base
> >using VHOST_SET_VRING_BASE. I used ftrace to trace the functions in the
> >linux kernel and got the following trace:
> >
> >[...]
> >qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vdpa_unlocked_io=
ctl <-__x64_sys_ioctl
> >qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl <-vh=
ost_vdpa_unlocked_ioctl
> >qemu-system-x86-1737    [001] ...1.  3613.371362: vp_vdpa_set_vq_state <=
-vhost_vdpa_unlocked_ioctl
> >[...]
> >
> >In the kernel, drivers/vhost/vhost.c:vhost_vring_ioctl [4] uses
> >the vhost_vring_state payload to set the last_avail_idx. For
> >packed vqs, it also sets last_used_idx.
> >
> >    vq->last_avail_idx =3D s.num & 0xffff;
> >    vq->last_used_idx =3D (s.num >> 16) & 0xffff;
> >
> >These values are used to populate a new struct vdpa_vq_state in
> >drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl [5].
> >
> >    vq_state.packed.last_avail_idx =3D vq->last_avail_idx & 0x7fff;
> >    vq_state.packed.last_avail_counter =3D !!(vq->last_avail_idx & 0x800=
0);
> >    vq_state.packed.last_used_idx =3D vq->last_used_idx & 0x7fff;
> >    vq_state.packed.last_used_counter =3D !!(vq->last_used_idx & 0x8000)=
;
> >
> >The following check is then made in drivers/vdpa/virtio_pci/vp_vdpa.c:
> >vp_vdpa_set_vq_state_packed [6]:
> >
> >    if (packed->last_avail_counter =3D=3D 1 &&
> >        packed->last_avail_idx =3D=3D 0 &&
> >        packed->last_used_counter =3D=3D 1 &&
> >        packed->last_used_idx =3D=3D 0)
> >        return 0;
> >    return -EOPNOTSUPP;
> >
> >The most significant bit in 0x8000 is used to set the wrap counters.
> >All the other bits are 0 and so the avail and used idx are also set
> >to 0.
>
> Thanks for these great details!
>
> Okay, so IIUC the only configuration that vp_vdpa supports when
> VHOST_SET_VRING_BASE is called is idx =3D=3D 0 and wrap_couter =3D true f=
or
> both avail and used.
>

Right, it cannot set any other value as there is no standardized way
in virtio. But vp_vdpa allows the default one, as QEMU always sends
it.

> Is this okay with QEMU shadow vq? (More a question for Eugenio).
>

Yes, it is a required step to support packed vq.

I misunderstood the previous thread and I thought the problem was
somewhere else. It is hard to justify introducing this change in QEMU
by itself, as the code is not reachable. However, when you post the
whole series, you can make the two changes requested here (commit id,
no magic number) and add my acked-by directly :):

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>
> About the magic value, IMHO we should explain it in the code adding a
> comment, and maybe use VRING_PACKED_EVENT_F_WRAP_CTR, something like we
> do in virtqueue_init() in drivers/virtio/virtio_ring.c in Linux:
>
>      uint32_t last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
>      uint32_t last_avail_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR)=
;
>
>      s.num =3D (last_used_idx << 16) | last_avail_idx;

I agree, we can avoid the magic constant and the kernel's code is a
good source to follow when developing these changes.

Thanks!


