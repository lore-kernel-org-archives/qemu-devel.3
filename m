Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863FEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErHF-00074k-4Z; Wed, 05 Jun 2024 10:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sErHD-00073B-2r
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:06:07 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sErH8-0003BQ-LC
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:06:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63947so6616035a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717596360; x=1718201160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yk4d8gq6Fkdkxknhzu33LJUCVNYheyMg4rxWgXvrRXE=;
 b=WtaZQJ6ujvMBTFQIPLuADSiqBLyQGViTFAQ8TrGNCeXEzlilc0cnMxTMRnQqLghBfX
 z8IurqMBMkmhroxcpvqKkl5JO/xJ5VvAP5M95aM7sV6gjGM2L1KscaeAYipCEnZD6uFE
 VUEUQnWl2PZ0RWwLxYmXSjVZ2DTHwXAKnmUM5Ba5jZSIxfgI0eSASDmywjF02//4bLmB
 jxJxGS4VpAA4QZ6drt2tUz2C5ggjoTrYFURFEmkNmiqerXncJ8fLmfbPLtY1BVqvOtcE
 x/1Ws5iCdHBdw21KEP4gx92p41ddUKdC49jrb0YOHt0Od6VAnWNiZJJhd5a0ufsGIbmI
 UZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596360; x=1718201160;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yk4d8gq6Fkdkxknhzu33LJUCVNYheyMg4rxWgXvrRXE=;
 b=FnJCRZxU8dGhIWjp4rLG7PCMUDquttHp3qy7abWGqE/JWsdqC/WgN/6EQqlDGnuaAI
 R5XLB/6xkeKAfQ1pNF8x/Pgg4SKgEZQB5pRrILOxBqKq+1fKuT70Er/34IOqutP0TA/y
 ZaQMoUVa1uL/7Gty+StJeeucdpJsMI7yqe+7GicRyWN3L1c3Uel9RbfmK6FthOMumEtO
 +qSKNXPQvhnTBvUp2ip4Zd3ZVj8Za086JX9WPAViul3xVoNEsK0zNDUyv0ZHVMHN3Ed7
 KI+ogrd135van6DRokjdYYSYgJr0Q4AdEDyK7TtwOlcXyw1cZtJ6iQs3ulOL8tNoKzIH
 UvaQ==
X-Gm-Message-State: AOJu0YyTAgL5xBZrEmsBuNxXyc2fuYNn42HToQkwk1y/UMWRmzvAyIDT
 A06ftvVzfRhgj1NpOTo48UEek0T72U27ddYStiJ2fuVWd1Vu51BJYJpgUexB3pQ=
X-Google-Smtp-Source: AGHT+IHo1PD0McRahpuUwsJi88/pSFoWphN6c31dwQwCn2TZwQcwSbn4rMfThArA7SY382NCXDvWzg==
X-Received: by 2002:a17:906:310f:b0:a68:d2dd:e006 with SMTP id
 a640c23a62f3a-a699facafaamr172928366b.17.1717596359368; 
 Wed, 05 Jun 2024 07:05:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f668e1bfsm525001666b.176.2024.06.05.07.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:05:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D926D5F7AE;
 Wed,  5 Jun 2024 15:05:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
In-Reply-To: <CAJ+F1CKdme8dKCO3iMEZLU-uWLfk-PPCfMNwh6-vCbCLyJvYiw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 5 Jun 2024
 17:50:41 +0400")
References: <20240605133527.529950-1-alex.bennee@linaro.org>
 <CAJ+F1CKdme8dKCO3iMEZLU-uWLfk-PPCfMNwh6-vCbCLyJvYiw@mail.gmail.com>
Date: Wed, 05 Jun 2024 15:05:56 +0100
Message-ID: <878qzjfprv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Jun 5, 2024 at 5:35=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
>  As the latest features for virtio-gpu need a pretty recent version of
>  libvirglrenderer. When it is not available on the system we can use a
>  meson wrapper and provide it when --download is specified in
>  configure.
>
>  We have to take some additional care as currently QEMU will hang
>  libvirglrenderer fails to exec the render server. As the error isn't
>  back propagated we make sure we at least test we have a path to an
>  executable before tweaking the environment.
>
>  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>  Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>  ---
>   meson.build                    |  7 ++++++-
>   hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>   subprojects/virglrenderer.wrap |  6 ++++++
>   3 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 subprojects/virglrenderer.wrap
>
>  diff --git a/meson.build b/meson.build
>  index 1d7346b703..e4e270df78 100644
>  --- a/meson.build
>  +++ b/meson.build
>  @@ -1203,7 +1203,8 @@ have_vhost_user_gpu =3D have_tools and host_os =3D=
=3D 'linux' and pixman.found()
>   if not get_option('virglrenderer').auto() or have_system or have_vhost_=
user_gpu
>     virgl =3D dependency('virglrenderer',
>                        method: 'pkg-config',
>  -                     required: get_option('virglrenderer'))
>  +                     required: get_option('virglrenderer'),
>  +                     default_options: ['default_library=3Dstatic', 'ren=
der-server=3Dtrue', 'venus=3Dtrue'])
>
> So the subproject won't be used unless virgl-devel is missing on the syst=
em. Is it really so useful? maybe, I am just used to
> installing my bleeding edge libraries with stow..

While I've been messing with the VirtIO GPU stuff I've had a special
build dir with the latest version of the various components and suitable
PKG_CONFIG_PATH and LD_LIBRARY_PATH hacks to use them. It did however
keep breaking when there was a re-configure and I'd forgotten to set the
env variables.

Judging by the number of questions I keep seeing from people about
getting virtio-gpu working it does seem a bit wobly (and thats before
you start talking about the extra libs rutabaga requires).

Bundling the library with a wrapper (which I think it only does when it
can't find a new enough system one) seems a lot simpler.

So yes this is a build from source convenience that mostly helps
developers and early adopters but we can get rid of it once our baseline
distros have caught up with the latest libvirglrenderer.=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

