Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B97FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAn3-0007Zd-3K; Wed, 12 Nov 2025 08:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJAbp-0001HM-LJ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:10:01 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJAbn-0003ZA-B7
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:10:01 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640c6577120so1373897a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762952997; x=1763557797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYEOXrQvBELfB5xA12p0ddXFkF8nZ4s8IwLzvJKGD28=;
 b=FJ+F8fHi+Ge72bWJR28HmVUPelZtkhTkEmC95OMnPfxKfxF2NQND3cym1uEpJwLyQ4
 Pg+6Ox4Au+JY6TXvM9761GpsOo6HIdB1/ezrvVyRTzExBElJtmY5Vl/rtKxp3l7TLn0+
 UxaLt7iLs1ix81PVAUwjdzdCXZSaU6OiDBEoaxc/yRnVnuJqcfOUjmzYfyilj69x/D4Z
 sAVOwDmzLSmhU2wZQlmZsRnNs7q74fLu/JmGxMLBHE1kW3cFZboH0KoM1rW20MT/Q/7C
 T9JE6C6X6jPfuzKU5n0Fkdket2uzbC7EzoAjQpgT4d2czlftT6F9Cfz7Dsrvh6Eg29+p
 G4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762952997; x=1763557797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OYEOXrQvBELfB5xA12p0ddXFkF8nZ4s8IwLzvJKGD28=;
 b=IK+Yr3QnVorlChzcFj4oq5LPVHXCZ1ZkF1UGvXEtt8wAyr0NmkdiS0eZFnySLxEcgP
 4i8UltRprCpwRHEzChykJM3jSyC1gJrxLSNZcacShQXc0eNg1ngeOH5bd/byfUhyODEP
 ANwY8rV4RVnV6ql7TvlJ11lG+nuisxAPhYez66oBzQsOD/TJmT7/VZUkXYrdhKWmHpNe
 W/HgnfvLQDPqumkIhSfHHsWQ+khOXoIp3R5OpYIsDfoqubKR2hoCPLbeb3hOoTCJxSo+
 uZ5ABFuRcNfPDGbI083Ls49+6Le6pxBchUnwDkr6KCvksA48pbOGgzXW3JOkeIvfwyvb
 cwoQ==
X-Gm-Message-State: AOJu0Yxp2cWRT+dD96tq3DyiNcbJS6wm9ruVT8XqY/rnmO8srHvVOeot
 EldJNxux8HlHDtou9pWJl3rpg1KUJxLYl2qCyMPbDAXBLT6tBTGC7s1sJSaT7ZY6/fEvbYdaBPd
 NSqTYPxqx90vfQQEbmki0pwjcvKWmhAxVqqtDPJAl
X-Gm-Gg: ASbGncufUoJkrTDLG2SHBGi/uVXh6k+BjK2IKxMZ334CLYB2rqnqTs1RGt9x3PFY6GW
 nlS5TXRUy8Qx2449T+Qdy5f70tjnGlXIP6vm1F2LzexdSbwmtnSyok2HAZI+cABqBve2N3N9IEE
 1x8o3E8SmAEdtw3MmsFEQwtBDqLbupsPPpsPKmNueg7jTMX8HkxgHfe1mXtfKGW+30NFGNDwT9q
 j6UtFuSgYwmQzhoSDfaQgqvFf8hPW07AlTY8011AvTZKG6hAgLAs4qQOzPlwyds+alkxkI=
X-Google-Smtp-Source: AGHT+IG35bl6Ppq7RPvCC5WbOeD8fhJbMdnU6itKys/jvgz2Z2AoN9T/DIzbBQXxKoMICOZmVW1nMPWDswLgLsDUuXc=
X-Received: by 2002:a17:907:60d3:b0:b28:b057:3958 with SMTP id
 a640c23a62f3a-b7331aec36cmr285486666b.48.1762952997470; Wed, 12 Nov 2025
 05:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20251112123844.GA14264@redhat.com>
In-Reply-To: <20251112123844.GA14264@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 12 Nov 2025 14:09:46 +0100
X-Gm-Features: AWmQ_bm18Jmz0UZ7VVRTZILXbmhV9n3ck1399Rhdnw_pWgOEs786k0M3yn5s2yQ
Message-ID: <CAJ307Eiph7Ms0-pgXpOZkPN7Wg+xRsa5nYzVPHvWB_rs+waNkQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] block/vvfat: introduce "size" option
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 12, 2025 at 1:38=E2=80=AFPM Richard W.M. Jones <rjones@redhat.c=
om> wrote:
>
> On Wed, Sep 03, 2025 at 09:57:16AM +0200, Cl=C3=A9ment Chigot wrote:
> > The main goal of this series is to introduce a new option "size" within
> > the vvfat backend (patch 5). It allows more control over SD cards' size=
.
> > The value for "Number of Heads" and "Sectors per track" are based on SD
> > specifications Part 2.
> >
> > This series also includes minor patches:
> >  - patch 1 introduces another option to remove the Master Boot Record
> >    (this is mandatory for QNX)
> >  - patch 2-4 are minor improvements easing the introducing of "size"
> >    option
> >
> > This was tested on with a aarch64-linux kernel taken from
> > functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> > workaround, not included here (the SD bus must be associated to the EMM=
C2
> > port instead of through GPIOs).
> >
> > Cl=C3=A9ment Chigot (5):
> >   vvfat: introduce no-mbr option
> >   vvfat: move fat_type check prior to size setup
> >   vvfat: add a define for SECTOR_SIZE
> >   vvfat: move size parameters within driver structure
> >   vvfat: add support for "size" options
> >
> >  block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 213 insertions(+), 66 deletions(-)
>
> (Thanks Markus for bringing this thread up)
>
> I just wanted to say that a long time ago I wrote an nbdkit plugin
> that was intended as a more sane replacement for vfat.  Since then
> several more nbdkit plugins have been added.  They support arbitrary
> sizes already.  The first one is the most direct replacement for vvfat
> (although it doesn't support writes to the backing directory, because
> that feature is insane).

Thanks for bringing that solution. I'll take a look though I'm not
sure it'll fit our needs. That insane feature is required for us... We
need ways to retrieve files generated by the binaries run within QEMU.
Moreover, we'll probably soon replace all that setup by some SSH
commands once we have implemented a few missing network devices (at
least the raspi4b one). But as I think those patches make vvfat block
a bit better, I still find them worth merging.
Nonetheless, I appreciate your feedback and will keep it in mind the
next time we have to deal with emulations without network devices.

Thanks,

> https://libguestfs.org/nbdkit-floppy-plugin.1.html
> https://libguestfs.org/nbdkit-iso-plugin.1.html
> https://libguestfs.org/nbdkit-linuxdisk-plugin.1.html
> https://libguestfs.org/nbdkit-tmpdisk-plugin.1.html
>
> Very easy to use from qemu as documented here:
>
> https://libguestfs.org/nbdkit-client.1.html#ATTACHING-NBD-DEVICES-TO-A-VI=
RTUAL-MACHINE
>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org
>

