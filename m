Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78121CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAgo-0002ul-Se; Sun, 10 May 2026 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wMAgn-0002ua-90
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:23:49 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wMAgl-0008I7-DU
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:23:49 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso4729475eec.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778444624; cv=none;
 d=google.com; s=arc-20240605;
 b=IDEtxHhgETBY0XeSbW11d+CRVNPxGaFfmKEHJjaDe+QaOedWg81WEKHBcUa6DNcp5B
 Zyr/HbBwWPV8aucAb5b1KHhK2ZiqRCFZB76toeZXemWTJ0zYCDhU6Pmo/XH6y0ONH5X9
 k7BBt8EYuvl4cpA2YmjsgA6nHLS4/rTuIjDSGOi+q37o5OUysOw7XWPg7h/vqAuRv+vm
 n6PQddqsaPxohU0VdJtBQPwqEa0qxZVeQvATs5w62VpMAhsj6aFeeB01OHAMrFKCsXtw
 4wXJ6hyn5/PywrvJeKds+VH1JSw1MzLt2uH8fopw+nezvJI9nZjrtqjghm+ZQipI5T95
 DrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jkh1uL1rgPpDJYzB8P2TQ/rVAk5fcg+k9t8zp/yZ2zE=;
 fh=XKfMv48PXgm//5sA40RdF01wGGjLzCVfJBOCZgVsECs=;
 b=isbarvTypw2P5FWTfKXjVdlv9GG1nrLpvT42v0rNLcZQVzcu02lfNjnkDbPHStwsSd
 rwRBmhiYVaWa7IvZ4M79bxhNdos+/NgwrHnNgyfuMb+fywVahbk8b4+PW+xwQRx6VBbL
 BtS/nnHTZNQAD3ovioIsxIZchaW4RTQBEg8iToIFuJ2PLeJX/YxYOaF52yPQWFpgbxAq
 nEBbAEwk/+r1IwcgVj0GpLkPkLI2tGOgV8vcXlf/Y9o44F7WYTGq4mkRea1wNoV1zgcX
 3D4Ra83EyMtWK4D4JBAKn5N8Yrg7iZzc6aW7UcLCjBhZdDewg7cFKJVbwxWLmJpm3xS5
 QrtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778444624; x=1779049424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jkh1uL1rgPpDJYzB8P2TQ/rVAk5fcg+k9t8zp/yZ2zE=;
 b=SfLHaMXjLysDwc7sF3Xe6vRjzHL0cxDBkFavpGgogg0lwWOlMOyjYj5tfUk8cJ8B3O
 UL1gPYRvUygdZcc6CNiBYsq5E24Zr5693e4V2gX1gSXVfnmB71UIsMwnUvukD+62fP6a
 7zmokfvFfJkJ77Hn8LIo86QzmLlP2XgDzwtFajm+YFFBegrDF+aJAru0bYT5o3QCBdij
 peSdtzSPM4a5TYgD/sMILnCf2ILzxUbwCRXPcwEh40E4JNd2FMCYI6Hs4xxrn9zLt3Th
 GcBm6kONAusRy0h32vpfyrrZx0KJ6hl4avZ3dvWxoDWs2UcbNg+YrQTmlaPKGdFaBNVy
 OGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778444624; x=1779049424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jkh1uL1rgPpDJYzB8P2TQ/rVAk5fcg+k9t8zp/yZ2zE=;
 b=MlNGebPw2IxH7QSvSAy7WHMG8V6VN7z8YMTlsgIhCD6EditP5twnykWrEqGfGlK0NY
 abAQnlWwFQJHqG4DJoQCRaanHE3MRWrv+Bx6DTyEiauzgGLQxM4TGquLByXuEiNOvM7Z
 QXSUnijsI1L8d3HcGpq7FAvmPjAZyu5zo6S+OfbwjoekhhRRZHtQbCVPFSY32DvFzwjC
 EwV+iNv74tZn5wheB1sqWz55rClBg/NUUstuxyOsEcFidnkyZdM+HRKoYzRrvxZifyRt
 RFC6L+OMuW/RRaieh4Spq09a+03AizcTQqKktIfsWsr3soMvfgu1V5DzO6Fr3jIzac4U
 DGLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+N/iwjnZmMgOT6BUSvCC4sumR0YQsFB4TIjXljeFqzNY5br7mOp7di2OaWR2mQJzYBW8WeAI595Dwl@nongnu.org
X-Gm-Message-State: AOJu0YwDOXf2qCa/pF19o18mftvjJHtGULHlTPPbYKpivk+RlPCwTnzN
 OGPcIHuz1xGbzbLV4AKZMb7iPTZvc09paP4MQBFMmYmDz4JnXIc3eltHzOM0Vmf8qoWzBKlTQ7M
 rec1lcgIygxHqNTUZuVW8U+NZkxVGQzA=
X-Gm-Gg: Acq92OGzRaO+ttwqMu5oH8XVhmxJETpGhiqyn3/qJ4QqO2Tisjhe8ObWKF7Qfjzya91
 9+qYxubJZvpuQdyJTln9jBHvQZ6ygMJBQbFzhNAznskm1XrcHo51vqhCi/OFbDSybV64ajTyYWW
 S+zzV1GeI+KGVXVSHIH4pXb/EB91jwI+jZ4jnB8Cu94LZoQN4snUmRANGR3gbcTiKe5Bv/f7+7m
 ehsBoj5vKVYg5m6rP/lD97tyHIuheuUisuZgCpoZCpNSqO2uoY5pmopT4uJJYWun4wz1qD1Q2E6
 3skinbBxGyfjB8oVLpK96Ny/uFiIJefo2EBVAWM=
X-Received: by 2002:a05:7300:dc14:b0:2da:2ec2:64fe with SMTP id
 5a478bee46e88-2f55034e591mr8974252eec.24.1778444624056; Sun, 10 May 2026
 13:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
 <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
In-Reply-To: <CAFEAcA8eKM_DNK4kWX0DNudMiq__uZ-MQM0L-2CfWL39CgCyJw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 May 2026 00:23:32 +0400
X-Gm-Features: AVHnY4Ipntbl5HYZ5HUcQUpDcY2st1qNhYG08CbSlCYgER1CW52yGMI9jy-HfSI
Message-ID: <CAJ+F1C+XzzsGRwLjUCYiDaS9OGXMq5oc3QM5pm4obZAgLP7Z1w@mail.gmail.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 8, 2026 at 8:23=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 8 May 2026 at 17:00, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > On 5/8/2026 8:24 AM, Peter Maydell wrote:
> > > We have a set of binaries that we call "tools": they're built based o=
n
> > > the --enable-tools/--disable-tools configure setting, they're
> > > documented in docs/tools, and they're standalone executables of one
> > > form or another.
> > >
> > > Currently the sources for these are a bit scattered: many still in th=
e
> > > top level source directory, some in contrib, one or two actually in
> > > the tools directory.
> > >
> > > As an initial attempt at cleanup, this patchset moves the sources for
> > > qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> > > qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> > >
> > > The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> > > to ebpf/bpf-src/, because this isn't a tool by the above definition.
> > >
> > > As per my thread from a while back, I would ultimately like us to
> > > clean up contrib/:
> > > https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv=
7yuM2kThv=3DrfOSZQA@mail.gmail.com/
> > > But parts of that clearly need more discussion. So this is just doing
> > > some parts that I hope are not controversial.
> > >
> > > Annoyingly, meson doesn't seem to provide any way for a subdirectory
> > > meson.build to say "the foo.c in this subdir builds into a foo
> > > executable that lives at the top level of the builddir". And we have =
a
> > > lot of test harness stuff plus user muscle memory that assumes that
> > > qemu-img and qemu-io live there. So the build runes for these tools
> > > have to stay in the top level meson.build (and tools/meson.build
> > > remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> > > is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> > > running that from the build directory will be small.
> > >
> >
> > It's a deliberate design more than an annoyance. It pushes users to mak=
e
> > things explicit at top level, which is good to understand what is built
> > and how, and hide details in subdirs in variables. QEMU's top level
> > meson.build is over complex, so it may appear more as a burden than a
> > benefit though.
>
> Personally I think if the build system doesn't let you do a
> pretty normal and reasonable thing that's annoying. Meson
> annoys me because it has a tendency to be over-opinionated.
>

I have to agree that meson is sometimes lacking. In this case, it
would be convenient to have a link created at build time. But you have
to resort to fairly annoying custom_target python code today. In the
meantime, there is also fs.copyfile() that could work (although it's
also somewhat limited or buggy). For later, we could try adding
fs.symlink() perhaps. Paolo might have better chances than me getting
it accepted ;)

--=20
Marc-Andr=C3=A9 Lureau

