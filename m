Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC88D13595
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 08:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5KqD-0002Hb-73; Mon, 28 Oct 2024 04:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1t5KqB-0002HT-IG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1t5Kq6-0008O1-Tx
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730103058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBA1YxgDNCASIocty/4uKmofbTwSuRxTlUGVaRCDEkc=;
 b=a3fSCaL/4dTfKOMoL5O6O0a3/bskpWJEtKy/hTbgPYZVS/il4qtxfGJua4gfF2JiZO++0P
 I0dqKyOqUWbY3zKuDM+EWqn/L76IsK1G/mqJMopoRzIEBSgSeESa36OZTiDl96aQrqo/js
 3Mi7+j+TZk43QikNEHsl/ugPz4T5F40=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-BqYgpN7wMrS0Op-FR4o72Q-1; Mon, 28 Oct 2024 04:10:57 -0400
X-MC-Unique: BqYgpN7wMrS0Op-FR4o72Q-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6e321d26b38so60640227b3.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 01:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730103057; x=1730707857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBA1YxgDNCASIocty/4uKmofbTwSuRxTlUGVaRCDEkc=;
 b=f57JMq5TozPJRiswPeiB0QzYGEL44+iVsW3uHHM/WW0K/+BgE8uNxHAM05UdW9TZaH
 JU7hYpVU1iop7uGb/yUeWVeB5zQl22N/TV+rCyrqRuiBjGTrrtrpUkS8h1jbTPpgUdKZ
 FoVXHahHI1e5fp6aaQ2ykAAdMeeQy4iRVC40gKmQh+MHjGAyLMYy9YkyT4n14QZosgkX
 3qGMeJXI1QzcyHhHZkETH/eQfhq382+tgNtIrTXKVGIM5+z1LZcs8g68ZHfTRcdvS5EK
 5IUrOxdIU86rvOD6Y6LIHupkgPYoxIhpTUVbIHcP8tmUUVtCmAF9mq8wHXS/Pq8kJ2tI
 c4vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoBlGz+uvQgUWNvKUWgWizVeRYgaVOyT/tH3xyqeyiRdCsq8RUkp9JM0S9mnavVuYqDEXkLcmcQaQ0@nongnu.org
X-Gm-Message-State: AOJu0Yyi8x/3D0ON5flAuM1y8l+W8QuModLRGCTYTSjoUjMwUX5GM5V5
 YOcajNwZzOxZ88Q+fZb0mzYfs4BBpYLwpYC4r0R8bHGiV+I3GlwExghYyaAhZ+xF48sPn/e7+/b
 /EI5EfzbJthsiQV4Ch6WXYost9hJ77VRIu+BcTWcz1INfXnNAINYWcgLRPbjVT7QNr1763j6PuV
 LfVZdrlCnu1pu8p1ep0IjrYOxrSJk=
X-Received: by 2002:a05:690c:ecd:b0:6e5:d35b:ca80 with SMTP id
 00721157ae682-6e9d88fd872mr55939357b3.5.1730103056934; 
 Mon, 28 Oct 2024 01:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VWqToN+BaD2vYBcw384AOXym7dS+iRXYL63Aw4BgKISxQX+vnk857yMzm+vunA30iLHe0u2M+GIKwSfojXo=
X-Received: by 2002:a05:690c:ecd:b0:6e5:d35b:ca80 with SMTP id
 00721157ae682-6e9d88fd872mr55939217b3.5.1730103056639; Mon, 28 Oct 2024
 01:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
 <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
In-Reply-To: <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Oct 2024 09:10:20 +0100
Message-ID: <CAJaqyWePYh43fTmVSFxUS8VYijZUAg1U5mM3WhXi9fQPDG6GWw@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Oct 28, 2024 at 6:38=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> It's been a while since I gave my last update. I have one more update
> that I would like to give.
>
> > On Tue, Sep 24, 2024 at 7:31=E2=80=AFAM Sahil <icegambit91@gmail.com> w=
rote:
> > > And I booted L2 by running:
> > >
> > > # ./qemu/build/qemu-system-x86_64 \
> > > -nographic \
> > > -m 4G \
> > > -enable-kvm \
> > > -M q35 \
> > > -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> > > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdp=
a0 \
> > > -device
> > > virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-moder=
n=3Doff,ev
> > > ent_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \ -smp 4 \
> > > -cpu host \
> > > 2>&1 | tee vm.log
> >
> > With packed=3Don in the device option, I see that the packed feature bi=
t is
> > set in L2 :)
> >
> > However, I see that vhost shadow virtqueues are still not being used. I=
 am
> > currently trying to find the reason behind this. I have narrowed down t=
he
> > issue to hw/virtio/vhost-vdpa.c [1]. The "vhost_vdpa_svqs_start" functi=
on
> > is being called but in the loop, vhost_svq_start is never called. I thi=
nk it
> > might be because there's an issue with "vhost_vdpa_svq_setup".
> >
> > I'll send an update once I find something.
> >
> > Thanks,
> > Sahil
> >
> > [1] https://github.com/qemu/qemu/blob/master/hw/virtio/vhost-vdpa.c#L12=
43
>
> I spent some time tinkering with the L0-L1-L2 test environment setup,
> and understanding QEMU's hw/virtio/vhost-vdpa.c [1] as well as Linux's
> drivers/vhost/vdpa.c [2] and /drivers/vhost/vhost.c [3]. I don't think th=
ere
> is an issue with the environment itself.
>
> When I boot L2 with the following combinations of "x-svq" and
> "packed", this is what I observe:
>
> 1. x-svq=3Don and packed=3Doff
>
> The virtio device in L2 has the packed feature bit turned off. Vhost
> shadow virtqueues are used as expected.
>
> 2. x-svq=3Doff and packed=3Don
>
> The virtio device in L2 has the packed feature bit turned on. Vhost
> shadow virtqueues are not used.
>
> I don't see any issues in either of the above environment
> configurations.
>
> 3. x-svq=3Don and packed=3Don
>
> This is the configuration that I need for testing. The virtio device in
> L2 has the packed feature bit turned on. However, vhost shadow
> virtqueues are not being used. This is due to the
> VHOST_SET_VRING_BASE ioctl call returning a EOPNOTSUPP in
> hw/virtio/vhost-vdpa.c:vhost_vdpa_set_dev_vring_base() [4].
>
> I spent some time going through the ioctl's implementation in Linux.
> I used ftrace to trace the functions that were being called in the kernel=
.
> With x-svq=3Don (regardless of whether split virtqueues are used or packe=
d
> virtqueues), I got the following trace:
>
> [...]
>  qemu-system-x86-1737    [001] ...1.  3613.371358:
> vhost_vdpa_unlocked_ioctl <-__x64_sys_ioctl
>  qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl
> <-vhost_vdpa_unlocked_ioctl
>  qemu-system-x86-1737    [001] ...1.  3613.371362:
> vp_vdpa_set_vq_state <-vhost_vdpa_unlocked_ioctl
> [...]
>
> There are 3 virtqueues that the vdpa device offers in L1. There were no
> issues when using split virtqueues and the trace shown above appears
> 3 times. With packed virtqueues, the first call to VHOST_SET_VRING_BASE
> fails because drivers/vdpa/virtio_pci/vp_vdpa.c:vp_vdpa_set_vq_state_pack=
ed
> [5] returns EOPNOTSUPP.
>
> The payload that VHOST_SET_VRING_BASE accepts depends on whether
> split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost-
> vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which is
> not suitable for packed virtqueues:
>
> struct vhost_vring_state s =3D {
>         .index =3D vq_index,
> };
>
> Based on the implementation in the linux kernel, the payload needs to
> be as shown below for the ioctl to succeed for packed virtqueues:
>
> struct vhost_vring_state s =3D {
>         .index =3D vq_index,
>         .num =3D 0x80008000,
> };
>

Wow, that's a great analysis, very good catch!

> After making these changes, it looks like QEMU is able to set up the
> virtqueues
> and shadow virtqueues are enabled as well.
>
> Unfortunately, before the L2 VM can finish booting the kernel crashes.
> The reason is that even though packed virtqueues are to be used, the
> kernel tries to run
> drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() [8]
> (instead of virtqueue_get_buf_ctx_packed) and throws an "invalid vring
> head" error. I am still investigating this issue.
>

That's interesting. It's been a while since I haven't tested that
code, maybe you also discovered a regression here :).

> I'll send an update once I resolve this issue. I'll also send a patch tha=
t
> crafts the payload correctly based on the format of the virtqueue in
> vhost_vdpa_svq_setup().
>

The QEMU's vhost_vdpa_svq_setup is a valid patch so if you have the
bandwith please send it ASAP and we move it forward :).

Thanks!

> Thanks,
> Sahil
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vd=
pa.c
> [2] https://github.com/torvalds/linux/blob/master/drivers/vhost/vdpa.c
> [3] https://github.com/torvalds/linux/blob/master/drivers/vhost/vhost.c
> [4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vd=
pa.c#L1002
> [5] https://github.com/torvalds/linux/blob/master/drivers/vdpa/virtio_pci=
/vp_vdpa.c#L278
> [6] https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#front-end=
-message-types
> [7] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vd=
pa.c#L1223
> [8] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L823
>


