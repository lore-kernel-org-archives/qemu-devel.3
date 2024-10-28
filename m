Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60CFD13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 05:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5IS8-0005hv-Df; Mon, 28 Oct 2024 01:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t5IS2-0005hR-1b
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 01:38:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1t5IS0-00027d-9Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 01:38:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so53267805e9.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730093878; x=1730698678; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2QeJxl8yuoiGnrj6E1Xa46/Qv1cC6KPyGv/Ppjc7zI=;
 b=giV0A7ukUg5DvEMSV7KaD+dXXI8CEGiAC93sv9hr7pwP7Fwkkka6jsruV9+2Zkz57o
 2lJFpzfcjC/nQ+T0HxwBj6oVcNrkKj5tlINEqrqG92FUAj8jdBXG9XNAFhKkrUJCYVVW
 oXMn7q8BeiqpRvIZIM9z5bqm0+qODN8unAWGx4jo9vMTPwFHH9duFNBxNu0Ez8g21/DX
 SoaKi8qnQe+IqKXmxWJaymN6m3uwwVN9BOpb/NRHtApA+LScDQYtbVVuIAprvP3k03wx
 wmmH/aUGB+ZxVr7L00BITDAlUp60rP3pW6xeeyPxO6jR50gtCjED3go88O1B/BiV/icl
 6DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730093878; x=1730698678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2QeJxl8yuoiGnrj6E1Xa46/Qv1cC6KPyGv/Ppjc7zI=;
 b=lRCJi89+fieF4t4ZTBXGPc+nuSsV+CqDWhTW0aZepr98+/w/gaaP6TcoQp506d5HZu
 0PrtVJ6A5HDe4T5Yac82ajtlO3MMvA6pKz1obNzNwuI1w6PtvBaC9te+wux/3/gXT0yB
 0g59VQlJvqhieQ9qP82qCzLOF18hiqRA+GCLWnTLKqX1zmFjozuGX6SVN+KArxnjlNrJ
 Ep6v1tygaSfpNw98lLgGdV1p6dp/sx3u7ws1xyNavRoMq+6RxCkL3U/x/lMHqqaSQR0G
 ghyiWKTmVyWnsCjVRaGW+MiCsc2PGPGtWaCp1VTRvMbkumS27s4NKviySS833GvIs5Hz
 22fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Ukr1EYE1UnqgYU5Zaz7lMWM9cBN0+WcyzoIAQOuoCkHu+rSvzXYCCA8GhHkCbCqu0pRxaYVnEDec@nongnu.org
X-Gm-Message-State: AOJu0Yxa2AhV0CdIfHVO3I1gjjuquFesBpj0k4/piu/WuVzk8YsuooyE
 boy44qtwPygAYUS3JQF7Qb6Vk0SR4oJ/UqcE9VQPyBaymBHuGGRK6/zBE+me+70YOwTT7BcIXDH
 mOQItWgD5gMuuf3X42ySwOeIkIW4=
X-Google-Smtp-Source: AGHT+IHUzHs39LkKaeOfkVhUVy11RG3RwkKkAloNFQVUBimK7VecLs06XIQ6RmZ/0DamORcJ8bDmEwnXqlvUQfLbkeY=
X-Received: by 2002:adf:e78c:0:b0:37d:2ea4:bfcc with SMTP id
 ffacd0b85a97d-38061172233mr7032163f8f.13.1730093878183; Sun, 27 Oct 2024
 22:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <3311761.aeNJFYEL58@valdaarhun>
 <CAJaqyWeus1zqEqE4ZzoGOzrY=w=_vEMdPGoHrv+Gxvc6zhiNmw@mail.gmail.com>
 <1904291.tdWV9SEqCh@valdaarhun>
In-Reply-To: <1904291.tdWV9SEqCh@valdaarhun>
From: Sahil Siddiq <icegambit91@gmail.com>
Date: Mon, 28 Oct 2024 11:07:47 +0530
Message-ID: <CAFcRUGb-Nh0E0tKJkKiw7X2E+wOcA6yavRBe7Ly9WKeTK46ENA@mail.gmail.com>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=icegambit91@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

It's been a while since I gave my last update. I have one more update
that I would like to give.

> On Tue, Sep 24, 2024 at 7:31=E2=80=AFAM Sahil <icegambit91@gmail.com> wro=
te:
> > And I booted L2 by running:
> >
> > # ./qemu/build/qemu-system-x86_64 \
> > -nographic \
> > -m 4G \
> > -enable-kvm \
> > -M q35 \
> > -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
 \
> > -device
> > virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disable-modern=
=3Doff,ev
> > ent_idx=3Doff,bus=3Dpcie.0,addr=3D0x7 \ -smp 4 \
> > -cpu host \
> > 2>&1 | tee vm.log
>
> With packed=3Don in the device option, I see that the packed feature bit =
is
> set in L2 :)
>
> However, I see that vhost shadow virtqueues are still not being used. I a=
m
> currently trying to find the reason behind this. I have narrowed down the
> issue to hw/virtio/vhost-vdpa.c [1]. The "vhost_vdpa_svqs_start" function
> is being called but in the loop, vhost_svq_start is never called. I think=
 it
> might be because there's an issue with "vhost_vdpa_svq_setup".
>
> I'll send an update once I find something.
>
> Thanks,
> Sahil
>
> [1] https://github.com/qemu/qemu/blob/master/hw/virtio/vhost-vdpa.c#L1243

I spent some time tinkering with the L0-L1-L2 test environment setup,
and understanding QEMU's hw/virtio/vhost-vdpa.c [1] as well as Linux's
drivers/vhost/vdpa.c [2] and /drivers/vhost/vhost.c [3]. I don't think ther=
e
is an issue with the environment itself.

When I boot L2 with the following combinations of "x-svq" and
"packed", this is what I observe:

1. x-svq=3Don and packed=3Doff

The virtio device in L2 has the packed feature bit turned off. Vhost
shadow virtqueues are used as expected.

2. x-svq=3Doff and packed=3Don

The virtio device in L2 has the packed feature bit turned on. Vhost
shadow virtqueues are not used.

I don't see any issues in either of the above environment
configurations.

3. x-svq=3Don and packed=3Don

This is the configuration that I need for testing. The virtio device in
L2 has the packed feature bit turned on. However, vhost shadow
virtqueues are not being used. This is due to the
VHOST_SET_VRING_BASE ioctl call returning a EOPNOTSUPP in
hw/virtio/vhost-vdpa.c:vhost_vdpa_set_dev_vring_base() [4].

I spent some time going through the ioctl's implementation in Linux.
I used ftrace to trace the functions that were being called in the kernel.
With x-svq=3Don (regardless of whether split virtqueues are used or packed
virtqueues), I got the following trace:

[...]
 qemu-system-x86-1737    [001] ...1.  3613.371358:
vhost_vdpa_unlocked_ioctl <-__x64_sys_ioctl
 qemu-system-x86-1737    [001] ...1.  3613.371358: vhost_vring_ioctl
<-vhost_vdpa_unlocked_ioctl
 qemu-system-x86-1737    [001] ...1.  3613.371362:
vp_vdpa_set_vq_state <-vhost_vdpa_unlocked_ioctl
[...]

There are 3 virtqueues that the vdpa device offers in L1. There were no
issues when using split virtqueues and the trace shown above appears
3 times. With packed virtqueues, the first call to VHOST_SET_VRING_BASE
fails because drivers/vdpa/virtio_pci/vp_vdpa.c:vp_vdpa_set_vq_state_packed
[5] returns EOPNOTSUPP.

The payload that VHOST_SET_VRING_BASE accepts depends on whether
split virtqueues or packed virtqueues are used [6].  In hw/virtio/vhost-
vdpa.c:vhost_vdpa_svq_setup() [7], the following payload is used which is
not suitable for packed virtqueues:

struct vhost_vring_state s =3D {
        .index =3D vq_index,
};

Based on the implementation in the linux kernel, the payload needs to
be as shown below for the ioctl to succeed for packed virtqueues:

struct vhost_vring_state s =3D {
        .index =3D vq_index,
        .num =3D 0x80008000,
};

After making these changes, it looks like QEMU is able to set up the
virtqueues
and shadow virtqueues are enabled as well.

Unfortunately, before the L2 VM can finish booting the kernel crashes.
The reason is that even though packed virtqueues are to be used, the
kernel tries to run
drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_split() [8]
(instead of virtqueue_get_buf_ctx_packed) and throws an "invalid vring
head" error. I am still investigating this issue.

I'll send an update once I resolve this issue. I'll also send a patch that
crafts the payload correctly based on the format of the virtqueue in
vhost_vdpa_svq_setup().

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vdpa=
.c
[2] https://github.com/torvalds/linux/blob/master/drivers/vhost/vdpa.c
[3] https://github.com/torvalds/linux/blob/master/drivers/vhost/vhost.c
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vdpa=
.c#L1002
[5] https://github.com/torvalds/linux/blob/master/drivers/vdpa/virtio_pci/v=
p_vdpa.c#L278
[6] https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#front-end-m=
essage-types
[7] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vdpa=
.c#L1223
[8] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_rin=
g.c#L823

