Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBFBFD9E22
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkla-0007j3-A3; Thu, 26 Feb 2026 18:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvklX-0007iN-14
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:27:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvklT-0007d6-VD
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:27:29 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65c0e2cbde1so3007156a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 15:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148445; cv=none;
 d=google.com; s=arc-20240605;
 b=YR2LyfmVAVSemZVfo1bf3cjaG1dwA543A/5Du94jAz5TSXzb0Uv3Wuchn/hFhaW6X7
 Jvvquz8AO0EevVngr9sOwvsZOOxnJHePuMXQ9hH8LVBEPZcGbnCvh74GkIUdNI6Af4Qw
 dUtHyx2ty80LOXrDqQfweLHCMsfC+VllGx5DbTGiFCE4+rNfhS0nnqya6vozLqmvM7m6
 LfqAA8kmavz6+uVEOrhMkHIBs6NfMnugyRjbgZD13GzCCIdDlP9hUOInZ7mAjGaIvLis
 9MudwwY2Ld7ZHIgN/bQ/gzPA9GSXi3gMVYZ8l7h5l4iUxG7l+xRIwjhRjqPRwFhvYgpj
 /2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8vhK/szmxMUe+/GfN8Da00C8tuSThBSFLyznHXrPZgk=;
 fh=1GR3ZbDEWJDX08ZGB5wfzFoJlMqYXfgEkXUL5FMv3Ks=;
 b=SKBbGX/DP/ojXviGqtuc5vwlI+ZtOAyuEw92JZs+5AG53TsmgrTLJyTaV0gl2wRiPi
 MmEm+Z0ETsp0JLKsm5lYYC2nlM8wqc+jDEo7cbRSiapt3jhxUmNMrMlSMmzR79pTaq3i
 hRa57d7ymWRVS3imE2+WXNLqSGx/CwzncVbAouJNmaW44/K4xKZxOXiwlNp3xK0hjOId
 7WgLwKyg09IVmzJzo8/Z6BqPmUoiqcfL+aRj+J2aH2/qYh8IlYi4xZj1QfNQXNpoq/LK
 Qary7ZCj9kVV0d3ZcuM8kJ9vhKabHkLaecHvQxw+cCijcIPl5lygTpa60+JKhI6icwxl
 pNBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772148445; x=1772753245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vhK/szmxMUe+/GfN8Da00C8tuSThBSFLyznHXrPZgk=;
 b=RhOsADFw/PB2D3c8TDl/nJrZcNn5UFX7bNCu/BCPbmycpYrTG9JMS6JfEmDc+DQtWk
 /wM3p37eFXXzNfCP7KxwXkGvfl8qEo7yInTnl2pWCQNNzk61+vEfVrL8meQ0ZWVsICkh
 gQx51q11nghWwjM1TKlwvrBhV/fJe6kCuDxWsjqAH9C/ZXYeDnOTmxJIMwf25eEmsOWv
 0Nt43aXWQRFHHuWyDwXtUkq5JcA+0saH6f4Z4+1cXJyauLn3vILfqJnSH+2os2D8BR4x
 Y92UbYY8Fv54IW+4Ny9NnbgYateN1Vl/GGENQlm/5JenAifAdiaYOkKpDJN1UQnXxLLL
 NBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772148445; x=1772753245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8vhK/szmxMUe+/GfN8Da00C8tuSThBSFLyznHXrPZgk=;
 b=Cwh6uupID3TkwmjTEXOAks5rtcMO21GxhAvUCl8kZnoMN/ePCXMz4yoh6nCrCpVlUU
 nOL3X4s/JGCDY1jWCoKoTdWb0MQYFEx3A0CVCoNx4O6Ojkd5wVENFa80G8iVOYlv1LOD
 C9KjwPDNxEtUDtf4KtzlqrEW54XRe6XIReC7939nTfAsjxd81ipDF/oPgfKsmr9QIyfO
 ThIfMwlV/6kE1Wc6lgeQnyji7orY+2u14VFxlp6WavUdhlRiXEl/as6B+raRiR9aDl9D
 KpirzyhmgePu1PhZ5qTCsoXjDX+jt+6cjJMZeIA3MxZS3RWqBjkk0evxUaL4FKboq3lJ
 JKjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf/e+vmyo9U5UPD5ALNFCzssb3sMpsja8yTAs8EMT0wAnFrN1mMwYfn/Q5fb+662tSx666cu7NGSC5@nongnu.org
X-Gm-Message-State: AOJu0Yz2QK75ilyIkJmL1PDS+v+d9Sd0k3Kp007YCGSv+nK2QyvkEb0E
 zKcBAZv6pXXBV8Y/dHdZMt6cYe1VEVKuB4MDI/JGlW+nuL+S1lvL4WV54dsDYBcRTRqu5zc3MQu
 p5O29VToEeu/gpnKgdi4QFgF1p2L/5Mo=
X-Gm-Gg: ATEYQzw5TDXmW59WHcnN9cqUG9n82PkZgyyDpJ28akMMdoNAdFfiNIOWwzmrxg5kdUc
 12rcdGJ4p2s1hhE7b9hN+h7MjYGhhUT3oZkscgoK5NGs2LVCyLraYmEyaYCTtHs+E89OMZkIKkZ
 LWSk57Qx50elgwSKASYg8JmDLUtR8Wz1TE390nBy1hFGL1WTGJL97DoZJzQG3JFM27AQPMcEjSB
 WecpeNb3XUgUyYoJEoV1nlA34LFZHxng6O6oySQn3WKDznsOGbmKS7kukpkYpuf6bdzR+0ahOCA
 x8Pq+bdAInEEoA0aKWZ3aNU699KQ6bFS/qVFEQ==
X-Received: by 2002:a05:6402:3506:b0:65f:a428:dffe with SMTP id
 4fb4d7f45d1cf-65fdd6b628fmr654034a12.7.1772148444497; Thu, 26 Feb 2026
 15:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-2-djordje.todorovic@htecgroup.com>
 <d03c5416-14a2-425f-a96c-ba340cf79617@redhat.com>
 <aZ7rchFnUwL9XGBL@redhat.com>
In-Reply-To: <aZ7rchFnUwL9XGBL@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 09:26:58 +1000
X-Gm-Features: AaiRm51f5LmaiWkeCC6Qb04xzQi3rlSUw4hj5W8bpsk1GQnt0s9_t0oM7oQEg5g
Message-ID: <CAKmqyKPrrk9ick=PJpPLyj1xfgU-ZaCGZsc4EW+oomkRP26FDA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] meson: Add BE RISCV targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 25, 2026 at 10:30=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, Feb 25, 2026 at 11:39:50AM +0100, Thomas Huth wrote:
> > On 25/02/2026 11.20, Djordje Todorovic wrote:
> > > Add options to compile riscv64be-softmmu and riscv32be-softmmu
> > > ---
> > >   meson.build | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/meson.build b/meson.build
> > > index 8c6c0a9a32..41ad38d184 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -55,6 +55,11 @@ supported_cpus =3D ['ppc64', 's390x', 'riscv64', '=
x86_64',
> > >   cpu =3D host_machine.cpu_family()
> > > +# Unify riscv64be to riscv64.
> > > +if cpu =3D=3D 'riscv64be'
> > > +  cpu =3D 'riscv64'
> > > +endif
> > > +
> > >   target_dirs =3D config_host['TARGET_DIRS'].split()
> > >   # type of binaries to build
> > > @@ -281,7 +286,7 @@ elif cpu =3D=3D 'ppc64'
> > >   elif cpu =3D=3D 'mips64'
> > >     kvm_targets =3D ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmm=
u', 'mips64el-softmmu']
> > >   elif cpu =3D=3D 'riscv64'
> > > -  kvm_targets =3D ['riscv64-softmmu']
> > > +  kvm_targets =3D ['riscv32-softmmu', 'riscv64-softmmu', 'riscv32be-=
softmmu', 'riscv64be-softmmu']

We really don't want a 32-bit KVM target at all

> >
> > I really dislike the idea of having yet another target like mips where =
we
> > have 4 different flavours (32/64 bits x big/little endian). That increa=
ses
> > the compile- and testing time a lot. Couldn't you do it the ppc64 way? =
The
> > ppc64-softmmu target can handle both, big and little endian, no need fo=
r a
> > separate binary here. And we are going the same way with microblaze now=
 -
> > the microblaze target recently got support for little endian, so we can
> > finally get rid of the microblazeel target now.
>
> Also with the ongoing work to make a single QEMU binary that can
> support any target, it feels like any problems with handling big
> and little endian in a single binary will need to be solved
> regardless, so if practical we should align with that direction
> from the start.

Exactly. We are working towards a single RISC-V  binary for all bit
lengths. Big endian would have to start out included in the existing
builds

Alistair

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

