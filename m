Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24535CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvkV-0006kp-0T; Wed, 17 Jun 2026 15:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wZvkA-0006j8-Vx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:16:16 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wZvk8-0006pX-GE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:16:10 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so523236eec.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781723766; cv=none;
 d=google.com; s=arc-20240605;
 b=dv7Kd3KRzmu6Musa/R7zxnT/bhCSqxuqHfC8TLRDj/GAt4/bFJVa/Hc5Nt9ngYWFZB
 tj6ak/1SNOgtjiwrlbSHg9NCh6VKzKQttF1SELIP2Z8CokefLDWqMohbBS08D4ndPvMv
 6QyBrl3I98Ec+nJjmTXFCWo4MSZ4Qx0PsSxVaRN9WP4ASdJOJgM5CZuFqj1Z1tazRk+2
 KhoijoZPNAlGpEqTMaBGWBin2k3sKTCNpNe+EkMqXz5yqGEYOyXDn4zIl92aQ7M4sWsP
 cY1dYpdv7iXbSZRxBOYJ7LYmFPT//Pug1Smiwp/5gOBa5sdzScIffMEU2YCvW5YqqXLU
 Thlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KNYsDO8RavXOfAfkFFJV2yxJGbgScI4+vbAIXXFlQsw=;
 fh=/I1gSr7aVPS0xsTkFZ6v2ERtrmTjbPJzIY7Fn7S0DvU=;
 b=KOPsLU38/Nb+QoxcsS+3M6SogRE3gexklwvR9E6eA/nVEUveV0yDk1ChqyX7g2H8EM
 pv/FsPLY08vEuwotGMcSQmVeNcGS4JQ+OcXVrnqw6UeON7B6fEAX6gSA1YdiYeAsdsSX
 p+U4PMqO9+LnkXIwqDO2WU3itO0EksdHmmKIgtBEOkl8UBcwOqhNzVWXSy6QHbdi8U5p
 joGeBe7u3RrDrG72L7lmmN4LkaPDHxSC7aytUiT/8ecxb6yBQTKSd1aAhE324Oa8cXxG
 Xo0A5vyShHU8fv7ObRlGHuIZFQ2Cd+Uq6qW62s2obSOtv7rr1cxD4aC3EM3wC78cjO/B
 6fyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781723766; x=1782328566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNYsDO8RavXOfAfkFFJV2yxJGbgScI4+vbAIXXFlQsw=;
 b=pI4yqbScW74BtAPMea4d8f5KCUvB6SKsALp3QHjCf4VTvANFLCDoPOzTbUFNdXWGiT
 GZk97wMZrbA92G3KQvrRyjwBswi39jIacxVSCyoytKha1CK9vdlLOrfl8N/XDjizUHCT
 ouMpySauCI+YRowTGcLwEF9sl/gpDb9D+hMFxaKZ+KY2PqCPVEw16IaZH9jgQ2iygoT7
 gY3f3ocdyOU2QQbXuYHRVBn3v907n4OAC5Uwo/iFPn7CqxAIlxgtAAzmbpa1PNP6eAWD
 Cm81jb0MTsPamPtBTb4Jjn8H9TQVLFuSSXJqZAduHIrToD6BlGD6EawAGM74sC7AYPxP
 A2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723766; x=1782328566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNYsDO8RavXOfAfkFFJV2yxJGbgScI4+vbAIXXFlQsw=;
 b=BDpoWpph/gzGa2lU5r8mS2VuMtp78RPQPlJ3eeONUwvgw6N5SbrBvrzNwYBQ3JJXi0
 Fp1Y9fCCJyOPelyc2DSPPDWOVXtL/Zv9SSDvZOZPwPEBWToO0FMpMPmOcfFuUdaBLce9
 2pGbQQriTLd2vI6SdfGeji3Byq4SFwvmadrqWtOSCZj4Da60uZIpeQL3LqHYVpgaJr6q
 akJVIfcvi/C6/n0tC+dt63Le9fn7m42IhR83XQGK3Z5XouMqLTyAXEQ0/vl2a03Uevcr
 QE++GecJ/WTSiqj5TwM1ArHW7lRLsXn2qpIEOwMe6z3boJqqgVH7GMwaiNSJOrmMejCj
 Hykg==
X-Gm-Message-State: AOJu0Yx66G8o+l+BR5dG65GHr0MKrLC/KO3xBd1yCuZ2CQbajlZ4v+0U
 kksLfMoqeXSWhcmLiHpYG9eneppl/nNiiYdJHtirJusa7MZdwAXULt4dTb6kr5BsY3Z2vYRsOp2
 aw4FG+vsJqwC5bdxxaoz1EfkqogJKB9k=
X-Gm-Gg: AfdE7cldufCaUHLN8ClWS/k4vQoq7kz7BJ8oLVpbHpqpUpwK8x09sicdcKPKt9Dl1hQ
 dhanFdJz3VkMjrG76dKMQfZr3Evffip/e3tExYwzN32vQFzjOdh0JPgAH618/pMmZ+W1a2qJQkt
 iyLNqA4jgLC+DpNdYHIQxLmSrT7NHMcz2ZU3WOEZ4Gp5YWPDOpxbw9Dlcg4lre3vZevISH2JDR+
 R7FtrQeRAERePlh7Op+hIIeoFqDtVyOtBjbcZjceB+WIgHgkWYvA9FVJr9PeUt+c2PDx4Jj
X-Received: by 2002:a05:693c:3105:b0:30a:e531:3141 with SMTP id
 5a478bee46e88-30bca0a1628mr2987541eec.17.1781723765786; Wed, 17 Jun 2026
 12:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
 <20260611-b4-ui-v3-6-72bcbbea0fae@redhat.com>
 <2f6725d5-3b35-4a12-9f18-2812fe6bed27@redhat.com>
In-Reply-To: <2f6725d5-3b35-4a12-9f18-2812fe6bed27@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 23:15:53 +0400
X-Gm-Features: AVVi8CeAm5ESCK7ID1-FGghUuqA5-EW9tTIJamOJWVKWV8SoWNc_UrH4cglP3OY
Message-ID: <CAJ+F1CLK98bGTPYJ4V8GAmJ9-L8t4=baWYg8m7oqtta5TYFtvw@mail.gmail.com>
Subject: Re: [PATCH v3 06/35] docs: start a vfio-pci document
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Tue, Jun 16, 2026 at 8:29=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello,
>
> Subject could be :
>
>    docs: add mdpy mdev vfio display testing guide ?

yes, I was too ambitious at first :)

>
> On 6/11/26 11:03, Marc-Andr=C3=A9 Lureau wrote:
> > Add a section to help me remember how to test vfio display hotplug.
>
> May be :
>
> Document how to test VFIO display hotplug using the kernel mdpy mdev
> sample
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   docs/devel/index-internals.rst |  1 +
> >   docs/devel/vfio-mdpy.rst       | 83 +++++++++++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 84 insertions(+)
> >
> > diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internal=
s.rst
> > index 7a0678cbdd3..198f155247a 100644
> > --- a/docs/devel/index-internals.rst
> > +++ b/docs/devel/index-internals.rst
> > @@ -22,6 +22,7 @@ Details about QEMU's various subsystems including how=
 to add features to them.
> >      tracing
> >      uefi-vars
> >      vfio-iommufd
> > +   vfio-mdpy
> >      writing-monitor-commands
> >      virtio-backends
> >      crypto
> > diff --git a/docs/devel/vfio-mdpy.rst b/docs/devel/vfio-mdpy.rst
> > new file mode 100644
> > index 00000000000..14cddd11d81
> > --- /dev/null
> > +++ b/docs/devel/vfio-mdpy.rst
> > @@ -0,0 +1,83 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Testing VFIO display with mdev mdpy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. contents:: Table of Contents
> > +
> > +The kernel provides a sample mediated device driver, ``mdpy``
> > +(``samples/vfio-mdev/mdpy.c``), that exposes a fake framebuffer throug=
h the VFIO
> > +display region interface. It can be used to test VFIO display support,=
 including
> > +hotplug, without any real GPU hardware.
> > +
> > +The kernel modules
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The ``mdpy`` driver depends on the ``mdev`` subsystem. Enable, build a=
nd load
> > +the modules.
>
> The minimal set is:
>
>      CONFIG_SAMPLE_VFIO_MDEV_MDPY=3Dm
>      CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=3Dm   # guest framebuffer driver
>
> CONFIG_VFIO_MDEV is selected automatically.
>

ok

>
> > +
> > +Verify that the driver registered successfully:
> > +
> > +.. code-block:: bash
> > +
> > +    ls /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/
> > +
> > +Creating an mdev instance
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +Available types correspond to different resolutions (e.g. ``mdpy-vga``
> > +for 640x480, ``mdpy-xga`` for 1024x768, ``mdpy-hd`` for 1920x1080).
> > +
> > +Each mdev instance is identified by a UUID:
> > +
> > +.. code-block:: bash
> > +
> > +    uuid=3D$(uuidgen)
> > +    echo "$uuid" > /sys/devices/virtual/mdpy/mdpy/mdev_supported_types=
/mdpy-xga/create
> > +
> > +To remove the instance later:
> > +
> > +.. code-block:: bash
> > +
> > +    echo 1 > /sys/bus/mdev/devices/$uuid/remove
> > +
> > +Make sure your user has the necessary permissions to access the vfio g=
roup.
> > +(ex: chmod 666 /dev/vfio/16)
> > +
> > +Starting QEMU
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Boot-time attachment
> > +--------------------
> > +
> > +.. code-block:: bash
> > +
> > +    qemu-system-x86_64 -machine q35 -m 1G \
> > +        -device vfio-pci,sysfsdev=3D/sys/bus/mdev/devices/$uuid,displa=
y=3Don \
> > +        -display gtk,gl=3Don
> > +
> > +Hotplug via HMP
> > +---------------
> > +
> > +Start QEMU with a PCIe root port (required for PCIe hotplug) and a
> > +monitor:
> > +
> > +.. code-block:: bash
> > +
> > +    qemu-system-x86_64 -machine q35 -m 1G \
> > +        -device pcie-root-port,id=3Drp0,slot=3D1 \
> > +        -display gtk,gl=3Don \
> > +        -monitor stdio
> > +
> > +Then at the ``(qemu)`` prompt:
> > +
> > +.. code-block:: none
> > +
> > +    device_add vfio-pci,sysfsdev=3D/sys/bus/mdev/devices/<uuid>,displa=
y=3Don,bus=3Drp0,id=3Dmdpy0
> > +
> > +To hot-unplug:
> > +
> > +.. code-block:: none
> > +
> > +    device_del mdpy0
> >
>
> Thanks,
>
> C.
>
>

