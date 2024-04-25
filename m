Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B59C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 22:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s07W4-0005Sl-EF; Thu, 25 Apr 2024 18:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1s07Vy-0005S7-6r; Thu, 25 Apr 2024 18:24:27 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1s07Vu-0003WJ-Sg; Thu, 25 Apr 2024 18:24:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a55b2f49206so453816666b.1; 
 Thu, 25 Apr 2024 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714083859; x=1714688659; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1sq1M1IdA6l4jz9NLe7FavLKAvFuX36wa3xNQxGO0mU=;
 b=CIF+SZ+6JCybS0Zs+LHxR6wTKgDZzFiuV9/T6WTPtddu4QeEXwPgDFkTXYo8sR5dMt
 AKYNGzDCeNodJ+GClIQwfpl1QKmuk0jtLw9dE5TrIxagOphAi7PTX680WxuTQKZ65gwa
 iJ1AdmmRBOrRKZmUVOnQv1UCHo5PX2XT7z9xPbS6A8sZ4/a/GQ6A4woIeQwJa+A2iepT
 QL0TSKcuL9xmcO81LtCfx2uPqaQeZjdr71LXexFMnlXMVUY8KpC+xcGtvfrdV9wjYNP2
 6n8wF+5xrpGE6KUB4otk/UXGTLAVinq2xxVAhdO9IlojSn6Mz0Mc13B6kJTB4idSjH8z
 /Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714083859; x=1714688659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sq1M1IdA6l4jz9NLe7FavLKAvFuX36wa3xNQxGO0mU=;
 b=JrUSoW/0KgmQFHPCmnBV0eloGnCq8hgw6y3vGmPK0QVw+ddlCVzBv9+EiTCXfcnh/R
 u1TjjbA3xnsGRIg0E8gU9RxpWTX0ydlF18LQQCM48pXd/CE/oVeoz+seI7oxKayN4ZFR
 IZte/6c8ToXU0wE2wVCsslRWYv5WgJNdMRUVmUXreMAbTtQ+/yX/pN+c1u42aUYW7MM8
 AThxaR2+TQW3tE713usnOr4N0sR/lg1ZigqwrVUjI+lMs3qxtCRZv5ih/PPEdC7ym/iS
 FRZuEOwUVlbr9CS/s6INYgZ+StbfUn9djLNKagtxz+yyiuvlWAk610bk0x83C1AelaaF
 CEXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC5edKDxekhGKryDlb0qurnJMGFn82tzKbPkUyPbVA1F8F+JgeyBqLQOw8n+CF/Eg7lOC2CPQZ8g1lqta50GrpjHRSrrYlWOGaojVU0BLoNceBpYkOXpkLEVtHi/s=
X-Gm-Message-State: AOJu0YzZMOhekojsBAsHLdYDkWKgJwftK8CHmc8l8T7ASEHZp6B3IKo6
 krBTcd/Yro7OD6xNs30qzkr+PghgCF5kv6sZWzWc+oc4U9JyNXTjtHwIpYXYI1GyFDHI6NTyJZN
 MOTwWdWVbCUZA6vbv3n13MRRLWUBiM/bY
X-Google-Smtp-Source: AGHT+IFL0RpJDIUigBU0jzf+ZzjZpIgPosaYkTnEGLTIYGOvspyPlCl60Fb4NhEKY3zPPxvw/Svfa0b9drb6ATv8hS4=
X-Received: by 2002:a17:906:d193:b0:a55:b2c0:a103 with SMTP id
 c19-20020a170906d19300b00a55b2c0a103mr681640ejz.33.1714083858261; Thu, 25 Apr
 2024 15:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240415151845.1564201-1-peter.maydell@linaro.org>
 <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
In-Reply-To: <CAFEAcA86Frw=GcWdjOgXsbP+9dgGjQpxP79k=nKshPm9LK0QVQ@mail.gmail.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Fri, 26 Apr 2024 00:24:06 +0200
Message-ID: <CABtshVRrPv8uUuX3C2k1BPkS4-_0HQH6aKiMFmLr1B1bck-+Pg@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: update sunxi kernel from armbian to 6.6.16
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007cae4f0616f33fef"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007cae4f0616f33fef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

I ran the avocado tests and this patch looks good to me.
The only comment I have would be that the `test_arm-Orangepi_bionic_20_08`
is not executed anymore since the image is not available, but I guess that
can be another patch.



On Thu, Apr 25, 2024 at 9:31=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> Whoops, forgot to cc the allwinner maintainers/reviewers on this.
> Ping for review, please?
>
> thanks
> -- PMM
>
> On Mon, 15 Apr 2024 at 16:18, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > The Linux kernel 5.10.16 binary for sunxi has been removed from
> > apt.armbian.com. This means that the avocado tests for these machines
> > will be skipped (status CANCEL) if the old binary isn't present in
> > the avocado cache.
> >
> > Update to 6.6.16, in the same way we did in commit e384db41d8661
> > when we moved to 5.10.16 in 2021.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2284
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > At this point in the release cycle I don't think I really want
> > to put this into 9.0, though I could just about squeeze it in.
> >
> > cc'ing stable as an FYI -- since the tests fall back to the
> > CANCEL status this doesn't break CI, so it's not a requirement
> > to backport to any stable branches. But it would probably be
> > preferable to get the coverage back on the stable branches so
> > we can detect if we get something wrong on a backport of a
> > patch that affects these machines.
> > ---
> >  tests/avocado/boot_linux_console.py | 70 ++++++++++++++---------------
> >  tests/avocado/replay_kernel.py      |  8 ++--
> >  2 files changed, 39 insertions(+), 39 deletions(-)
> >
> > diff --git a/tests/avocado/boot_linux_console.py
> b/tests/avocado/boot_linux_console.py
> > index 989b65111c0..d0ab5aaa83a 100644
> > --- a/tests/avocado/boot_linux_console.py
> > +++ b/tests/avocado/boot_linux_console.py
> > @@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):
> >          :avocado: tags=3Daccel:tcg
> >          """
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> >                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> > @@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):
> >          :avocado: tags=3Daccel:tcg
> >          """
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          rootfs_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> >                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> > @@ -872,13 +872,13 @@ def test_arm_bpim2u(self):
> >          :avocado: tags=3Dmachine:bpim2u
> >          :avocado: tags=3Daccel:tcg
> >          """
> > -        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >
> > @@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):
> >          :avocado: tags=3Daccel:tcg
> >          :avocado: tags=3Dmachine:bpim2u
> >          """
> > -        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> > @@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):
> >          """
> >          self.require_netdev('user')
> >
> > -        deb_url =3D ('
> https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/'
> > -                   'linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D ('/usr/lib/linux-image-current-sunxi/'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D ('/usr/lib/linux-image-6.6.16-current-sunxi/'
> >                      'sun8i-r40-bananapi-m2-ultra.dtb')
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          rootfs_url =3D ('
> http://storage.kernelci.org/images/rootfs/buildroot/'
> > @@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):
> >          :avocado: tags=3Daccel:tcg
> >          """
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >
> >          self.vm.set_console()
> > @@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):
> >          :avocado: tags=3Dmachine:orangepi-pc
> >          """
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> >                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> > @@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):
> >          self.require_netdev('user')
> >
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          rootfs_url =3D ('
> http://storage.kernelci.org/images/rootfs/buildroot/'
> >
> 'buildroot-baseline/20221116.0/armel/rootfs.ext2.xz')
> > diff --git a/tests/avocado/replay_kernel.py
> b/tests/avocado/replay_kernel.py
> > index 10d99403a4c..0474f7b7c8e 100644
> > --- a/tests/avocado/replay_kernel.py
> > +++ b/tests/avocado/replay_kernel.py
> > @@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):
> >          :avocado: tags=3Dmachine:cubieboard
> >          """
> >          deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > -
>  'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
> > -        deb_hash =3D '9fa84beda245cabf0b4fa84cf6eaa7738ead1da0'
> > +
>  'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a=
-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
> > +        deb_hash =3D 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
> >          deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> >          kernel_path =3D self.extract_from_deb(deb_path,
> > -
> '/boot/vmlinuz-5.10.16-sunxi')
> > -        dtb_path =3D
> '/usr/lib/linux-image-current-sunxi/sun4i-a10-cubieboard.dtb'
> > +
> '/boot/vmlinuz-6.6.16-current-sunxi')
> > +        dtb_path =3D
> '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> >                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> > --
> > 2.34.1
> >
>

Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


Best regards,
Strahinja

--0000000000007cae4f0616f33fef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Peter,<div><br></div><div>I ran the av=
ocado tests and this patch looks good to me.</div><div>The only comment I h=
ave would be that the `test_arm-Orangepi_bionic_20_08` is not executed anym=
ore since the image is not available, but I guess that can be another patch=
.</div><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 25, 2024 at 9:31=E2=80=AFP=
M Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayde=
ll@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Whoops, forgot to cc the allwinner maintainers/reviewers on th=
is.<br>
Ping for review, please?<br>
<br>
thanks<br>
-- PMM<br>
<br>
On Mon, 15 Apr 2024 at 16:18, Peter Maydell &lt;<a href=3D"mailto:peter.may=
dell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<=
br>
&gt;<br>
&gt; The Linux kernel 5.10.16 binary for sunxi has been removed from<br>
&gt; <a href=3D"http://apt.armbian.com" rel=3D"noreferrer" target=3D"_blank=
">apt.armbian.com</a>. This means that the avocado tests for these machines=
<br>
&gt; will be skipped (status CANCEL) if the old binary isn&#39;t present in=
<br>
&gt; the avocado cache.<br>
&gt;<br>
&gt; Update to 6.6.16, in the same way we did in commit e384db41d8661<br>
&gt; when we moved to 5.10.16 in 2021.<br>
&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/228=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2284</a><br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; At this point in the release cycle I don&#39;t think I really want<br>
&gt; to put this into 9.0, though I could just about squeeze it in.<br>
&gt;<br>
&gt; cc&#39;ing stable as an FYI -- since the tests fall back to the<br>
&gt; CANCEL status this doesn&#39;t break CI, so it&#39;s not a requirement=
<br>
&gt; to backport to any stable branches. But it would probably be<br>
&gt; preferable to get the coverage back on the stable branches so<br>
&gt; we can detect if we get something wrong on a backport of a<br>
&gt; patch that affects these machines.<br>
&gt; ---<br>
&gt;=C2=A0 tests/avocado/boot_linux_console.py | 70 ++++++++++++++---------=
------<br>
&gt;=C2=A0 tests/avocado/replay_kernel.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++-=
-<br>
&gt;=C2=A0 2 files changed, 39 insertions(+), 39 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_=
linux_console.py<br>
&gt; index 989b65111c0..d0ab5aaa83a 100644<br>
&gt; --- a/tests/avocado/boot_linux_console.py<br>
&gt; +++ b/tests/avocado/boot_linux_console.py<br>
&gt; @@ -646,12 +646,12 @@ def test_arm_cubieboard_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -690,12 +690,12 @@ def test_arm_cubieboard_sata(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -872,13 +872,13 @@ def test_arm_bpim2u(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;<br>
&gt; @@ -899,13 +899,13 @@ def test_arm_bpim2u_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:bpim2u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt; @@ -946,13 +946,13 @@ def test_arm_bpim2u_gmac(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_netdev(&#39;user&#39;)<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/linux-5.10.16-sunxi/" rel=3D"noreferrer" target=3D"=
_blank">https://apt.armbian.com/pool/main/l/linux-5.10.16-sunxi/</a>&#39;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https://apt.=
armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https://apt.=
armbian.com/pool/main/l/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-c=
urrent-sunxi/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D (&#39;/usr/lib/linux-image-6=
.6.16-current-sunxi/&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &#39;sun8i-r40-bananapi-m2-ultra.dtb&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
://storage.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=
=3D"_blank">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<b=
r>
&gt; @@ -1049,12 +1049,12 @@ def test_arm_orangepi(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Daccel:tcg<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; @@ -1075,12 +1075,12 @@ def test_arm_orangepi_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:orangepi-pc=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; @@ -1121,12 +1121,12 @@ def test_arm_orangepi_sd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.require_netdev(&#39;user&#39;)<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun8i-h3-orangepi-pc.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rootfs_url =3D (&#39;<a href=3D"http=
://storage.kernelci.org/images/rootfs/buildroot/" rel=3D"noreferrer" target=
=3D"_blank">http://storage.kernelci.org/images/rootfs/buildroot/</a>&#39;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;buildroot-baseline/20221116.0/armel/rootfs.ext2.xz&#39;)=
<br>
&gt; diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_ker=
nel.py<br>
&gt; index 10d99403a4c..0474f7b7c8e 100644<br>
&gt; --- a/tests/avocado/replay_kernel.py<br>
&gt; +++ b/tests/avocado/replay_kernel.py<br>
&gt; @@ -203,12 +203,12 @@ def test_arm_cubieboard_initrd(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:cubieboard<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_url =3D (&#39;<a href=3D"https:/=
/apt.armbian.com/pool/main/l/" rel=3D"noreferrer" target=3D"_blank">https:/=
/apt.armbian.com/pool/main/l/</a>&#39;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb&#39;)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;9fa84beda245cabf0b4fa84=
cf6eaa7738ead1da0&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&#39;linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4=
a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_hash =3D &#39;f7c3c8c5432f765445dc6e7=
eab02f3bbe668256b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deb_path =3D self.fetch_asset(deb_ur=
l, asset_hash=3Ddeb_hash)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.extract_from_de=
b(deb_path,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-5.10.16-sunxi&#39;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-cu=
rrent-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;/boot/vmlinuz-6.6.16-current-sunxi&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D &#39;/usr/lib/linux-image-6.=
6.16-current-sunxi/sun4i-a10-cubieboard.dtb&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dtb_path =3D self.extract_from_deb(d=
eb_path, dtb_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_url =3D (&#39;<a href=3D"http=
s://github.com/groeck/linux-build-test/raw/" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/groeck/linux-build-test/raw/</a>&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/&#39;<br=
>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br></blockquote><div><br><span class=3D"gmail-il">Reviewed</span>-<spa=
n class=3D"gmail-il">by</span>: Strahinja Jankovic &lt;<a href=3D"mailto:st=
rahinja.p.jankovic@gmail.com">strahinja.p.jankovic@gmail.com</a>&gt;=C2=A0<=
br><br><br>Best regards,<br>Strahinja</div><div><br></div></div></div>

--0000000000007cae4f0616f33fef--

