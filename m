Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A185BD3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 02:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1clw-0002mj-55; Thu, 17 Oct 2024 22:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1clu-0002mQ-My
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 22:31:22 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1cls-00067C-ST
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 22:31:22 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-50d431b0ae2so1520499e0c.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729218679; x=1729823479; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lm2c4vZTjn9mKSDBxE+rQj3vIsDk0dYb/iEZdDHVDM=;
 b=RglQnNRBPtCdxq9Pv8p+d8ZslDju69jwgGtns16vT2tKcoLfZQZssp3aHUh1lP5W+M
 3PeWhpTdVOKKBsYcFkMeIDe5nL/rQ1n2sJtUa89oes+qVDyjdvC18Jl/Lq2vd0EjAdhg
 nuR9tSePfeF0cwB0xJkNFgbzTi4SmuaMLuxre7je/QAmwfi51LubfZfkbJZYYgMezYCQ
 VGX5+wyIhSo2vZDK/8px3vq3hyXNQYv5WqYk7uyCOBaTesXDmlrvveLs/zVw8IcKe2Wd
 xRA1hJAygiEZTPrzY65lHBg/UuwL4SELzhIoLNUq2WtIyBJcXVrIL1PqEaRFTIKkdjtI
 K6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729218679; x=1729823479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lm2c4vZTjn9mKSDBxE+rQj3vIsDk0dYb/iEZdDHVDM=;
 b=QtoQP4/zpbdbgMw41bJrLDsxCvWh4FkLyQRJBCiqGIQNmdee5jf2BzZ6bPwl9FB0de
 U2BHkEzsqrhTRKQ2kcdlBYODr9NeJ+CTjoTyyy6DbRx0C1tIE1FeTJ2GQR+Btcu9KRBU
 7FWY7v4sXEurjfezkxIUo0uIds7OdXBnN4RG8OWMGw5mb4wwToA4ZWCKQ8OFLVmYigIl
 Bnr4fpNuZN4WgAWtiSiM1D22gSXh4GT/fc7SA7CsFH1/sqhOlc3PdY8OOzso7djThjIg
 /RLrSdJ/rtKsHb2hRhYRmh7rjk3QfyJkYWGchE4fFC5OI578Fnx3qJJwtaPeDxKon2VE
 iI4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqdDU4S0u2DZCw3kCKULNSHtN9Tb0nYuvayIbBYMhkgzeQd3/eA7GfFSzj123OinsIZ/BpwbAd+t3B@nongnu.org
X-Gm-Message-State: AOJu0YyjyZOz6Tt5QaNm/RZEjnzUujrky3RDmngSi2kKv6rNa5k4NK1v
 i/I+MGWOsqSK7SoQOldIlSNvMGG+mSkxg0jsMQEQMiWVDLR/65Ph2XdRcveyKZ7NdQM5sKiUvrl
 wr6Q0o2MMbUTsO+FwjQdwjlYozQw=
X-Google-Smtp-Source: AGHT+IEHSWeEHxWNA9GZ1Wei9EspFwXICGROlbsyeyGgLov3SrIA+NPWq2qu8SlMuHPHrD9lD624C8WdOnX/raaF8tU=
X-Received: by 2002:a05:6122:caa:b0:50d:6cfc:ac4d with SMTP id
 71dfb90a1353d-50dda3f6f01mr412592e0c.5.1729218679090; Thu, 17 Oct 2024
 19:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241016163439.1130168-1-htafreit@gmail.com>
 <CAKmqyKPUUgF1tLKCFF1FiT5HHEDDDg+=Yha2e38wSto4mKh_BA@mail.gmail.com>
 <ZxDgGsjRkLEA8r6_@redhat.com>
 <CALKrZCJ6cnocjddg4uu=0q0+vtVCzkEzC0=scnRWhLpGX4zQ8w@mail.gmail.com>
In-Reply-To: <CALKrZCJ6cnocjddg4uu=0q0+vtVCzkEzC0=scnRWhLpGX4zQ8w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 Oct 2024 12:30:52 +1000
Message-ID: <CAKmqyKOTvf-PL++dp3iv=L1OefcLmSb+oXqh65s2EM9JVsHwKA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Insert LibSPDM in QEMU enabling in-tree compilation
To: =?UTF-8?Q?=C3=81gatha_Freitas?= <htafreit@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Oct 17, 2024 at 11:37=E2=80=AFPM =C3=81gatha Freitas <htafreit@gmai=
l.com> wrote:
>
>
>
> On Thu, Oct 17, 2024 at 7:00=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>>
>> On Thu, Oct 17, 2024 at 02:00:35PM +1000, Alistair Francis wrote:
>> > On Thu, Oct 17, 2024 at 2:35=E2=80=AFAM htafr <htafreit@gmail.com> wro=
te:
>> > >
>> > > (I) Summary
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > >
>> > > This patch is the beginning of the support of the Security Protocol =
and
>> > > Data Model (SPDM). There are some known issues (see II), but it's
>> > > usable and not many users are going to use this functionality for no=
w,
>> > > but for those who will it may facilitate the development.
>> > >
>> > > There are some people working with LibSPDM to implement the SPDM on
>> > > emulated devices, however current works that use QEMU compile LibSPD=
M
>> > > out-of-tree [1][2][3]. This patch enables the compilation of LibSPDM=
 when
>> > > user pass the parameter '--enable-libspdm' to configure file, this o=
ption
>> > > is disabled by default. The following parameters were also added:
>> > >
>> > >   --libspdm-crypto=3DCHOICE  set LibSPDM crypto algorithm [mbedtls] =
(choices:
>> > >                            mbedtls/openssl)
>> > >   --libspdm-toolchain=3DVALUE
>> > >                            toolchain to use for LibSPDM compilation =
[GCC]
>> > >
>> > > In order to facilitate future code development using LibSPDM API, th=
is
>> > > patch also provides the definition of the macro 'CONFIG_LIBSPDM'.
>> >
>> > We have talked about this before, see
>> > https://patchew.org/QEMU/cover.1691509717.git.alistair.francis@wdc.com=
/
>> >
>> > The general agreement seemed to be that it will be hard to do SPDM
>> > configuration inside QEMU, hence the external library (like the QEMU
>> > TPM support).
>>
>> More generally, seeing this libspdm proposed for QEMU, without any
>> corresponding usage of it it dubious. It is hard to judge whether
>> it makes any sense, without seeing how it will be used in real
>> device code inside QEMU.
>
>
> Currently, I'm working with EDK2 and QEMU so I have a branch [1] with ong=
oing
> modifications in files backends/spdm.c and hw/nvme/auth.c. Although the c=
urrent
> modifications are able to exchange SPDM messages, it's far from being com=
plete
> and it's not following better code practices yet. I'm making use of Alist=
air's and
> Mallawa's previous work in NVMe to authenticate it through PCI [2].
>
> [1]  WIP: SPDM integration
>       Link: https://github.com/htafr/qemu/tree/libspdm-dev
> [2] WIP: SPDM in OVMF
>       Link: https://github.com/htafr/edk2/tree/ovmf-spdm

I also started working on this, see
https://github.com/tianocore/edk2/pull/5715 .
I was working towards SPDM communication over DOE as well.

Unfortunately it stalled with the EDK2 review process being so incredibly s=
low

>
>>
>>
>> On the cryptography side, I'm not a fan of linking another
>> crypto library to QEMU, that's different from what we already
>> support in our crypto layer. openssl in particular is a problem
>> due to its licensing - people tend to hand-waive away the
>> licensing incompatibility by pretending openssl is a "system library"
>> but I disagree with that interpretation.
>>
>> > > (II) Known Limitations
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > >
>> > > 1. This patch enables LibSPDM in-tree compilation for Linux systems =
only.
>> > > 2. LibSPDM compilation uses CMake, so meson build system is making u=
se
>> > >    of the CMake module [4].
>> > > 3. Some problems may occur when compiling LibSPDM with MbedTls such =
as:
>> > >     error: "_GNU_SOURCE" redefined [-Werror]
>> > >       10 | #define _GNU_SOURCE
>> > >
>> > >    It's possible to compile using --disable-werror.
>> > >
>> > > (III) Sample configuration
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > >
>> > > ../configure \
>> > >   --disable-werror \
>> > >   --enable-libspdm \
>> > >   --libspdm-crypto=3Dmbedtls \
>> > >   --enable-gcov
>> > >
>> > > References:
>> > > [1] riscv-spdm
>> > >   Link: https://github.com/htafr/riscv-spdm
>> > > [2] spdm-benchmark
>> > >   Link: https://github.com/rcaalves/spdm-benchmark
>> > > [3] qemu-spdm-emulation-guide
>> > >   Link: https://github.com/twilfredo/qemu-spdm-emulation-guide
>> >
>> > This one has been merged upstream and mainline QEMU supports it now:
>> >
>> > https://www.qemu.org/docs/master/specs/spdm.html
>>
>> So with that merged, is this proposal for linking to libspdm redundant ?
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>
>
> I'm not sure if I understood the redundancy. Would it be against QEMU pra=
ctices
> to have another openssl as well as mbedtls linked inside it?
>
> Also, I didn't know the LibSPDM insertion was already discussed previousl=
y as
> Alistair pointed out. I think I should have sent this patch as RFC instea=
d. As this is
> my first interaction in any mail list, I'm sorry for any mistakes I made.

No worries, there were no mistakes made. I was just pointing out that
we have had this discussion before and settled on an external SPDM
implementation.

That doesn't mean we can't change that in the future, but I think it
needs a good justification and like Daniel says at least a partial
implementation to go with it

Alistair

