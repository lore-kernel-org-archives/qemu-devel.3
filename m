Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E136C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7Uv-0005yW-8B; Thu, 22 Feb 2024 06:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7Ut-0005y7-E8
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:44:15 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7Uq-0007mR-Jm
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:44:15 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5654621d62dso431237a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 03:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708602251; x=1709207051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4JoJUOpaLjEuldvsh0KvTsEDQYZ2Zk/vfAS3pyEwGQ=;
 b=PTUMEYi2k4aKxQWMYr3lXcW0zN/OiIw8OX8u1H/Z0ZgY/y6qFnkOYhQL20nmfc5NYs
 q2MCoD2YDCrbGP7znpa1H1AY9enMZpv58VuI4PbRfU/JuGxGVts2hqHqDLydR+WoRD+m
 PVlQiYMXanQyr7pV7MROjfaEKOtYkbefCF66jI4bGBo+qqueveiiFtQhzH1V2Mm0MEa5
 WPP+K4SvlSWs60KSStu2eSyPywswVhvZKZzfOo9N5izaPZCWz4mIbqeLlEefsv2cNoCs
 2eUvFVxoJuEfP+WfWcQ216lY1BnxwyZ5AE9H47/kCJZeZjvJ7WYDk635MkkeLzqUXIKH
 JKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708602251; x=1709207051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4JoJUOpaLjEuldvsh0KvTsEDQYZ2Zk/vfAS3pyEwGQ=;
 b=oi/jvBMm9KHC0h/GXt+TLe5QPCiGeQALvON5VtJBeHr0zguqMB19b890PLnUC6vp2K
 nBOHspWn5+BvxYQeJWtniKwd+h9AXi0fAI0TkD9svGCsUnzapKj/pcth3ygdOD8NW/ex
 Wy7bZPw9iz9o6T1slh17nbyS8UI9XO8KQL3k0JgHEMpAeluB7A2I5vSIZk5DVOLaXqyK
 HgzmuCozbxlLoO35uNmRi7J0Znk0hBar7pvXnSWaCiQM9jXHHHpuWrHLKhQJAQA1FY3k
 UYfBvAOSIjGJm0DWTl5vjKtvc7kXAN1rJoWWTVU9Mx8ANCLDjujnmvE9w1wntJ9lmwxn
 HRug==
X-Gm-Message-State: AOJu0Yx7FPphyxhTmNanEecV5I1fJekXhNhuYVFI6Qq9kwCfW2+TypsE
 hQ8HXBTC0b4idVieNTocDeyDv1tqyroIXQBLzZLwKzoE2eICNviUUB+wroDY6RW5NDCArMLwq64
 qRlY3jVJ0SYcIOSGqMEv0srydjRq9DAmBNJfgmA==
X-Google-Smtp-Source: AGHT+IHUP3jpQYvkDhXG6njBhm//e1cMcpVm3Mm5t1Li3MM9XQSCBWPrmKK/qsNeiZJpTgZ5g2KSObLdPqmCrTEun5k=
X-Received: by 2002:a05:6402:1d1a:b0:565:210a:34b9 with SMTP id
 dg26-20020a0564021d1a00b00565210a34b9mr1976979edb.38.1708602250842; Thu, 22
 Feb 2024 03:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
 <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
In-Reply-To: <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 11:44:00 +0000
Message-ID: <CAFEAcA_1zEQ-bT8bE=74FC24fz7HYN6j8ZLZVaDn7C47vraNAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 20 Feb 2024 at 18:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/2/24 18:44, Peter Maydell wrote:
> > We don't support 32-bit Windows any more, so we don't need to defend it
> > with this CI job.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   .gitlab-ci.d/container-cross.yml              |   5 -
> >   .gitlab-ci.d/crossbuilds.yml                  |  14 ---
> >   .../dockerfiles/fedora-win32-cross.docker     | 111 -----------------=
-
> >   tests/lcitool/refresh                         |   5 -
> >   4 files changed, 135 deletions(-)
> >   delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
>
>
> > diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.ym=
l
> > index d19d98cde05..987ba9694ba 100644
> > --- a/.gitlab-ci.d/crossbuilds.yml
> > +++ b/.gitlab-ci.d/crossbuilds.yml
> > @@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
> >       IMAGE: debian-mips64el-cross
> >       EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=3Dmips64el-soft=
mmu
> >
> > -cross-win32-system:
> > -  extends: .cross_system_build_job
> > -  needs:
> > -    job: win32-fedora-cross-container
> > -  variables:
> > -    IMAGE: fedora-win32-cross
> > -    EXTRA_CONFIGURE_OPTS: --enable-fdt=3Dinternal
> > -    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-so=
ftmmu
> > -                        microblazeel-softmmu mips64el-softmmu nios2-so=
ftmmu
>
> Thomas, is it possible to add mips64el-softmmu to the cross-win64-system
> job or is it already at the timeout limit?

This is a skip, i.e. exclude, list, not an include list. So dropping
this job is not removing mips64el-softmmu from coverage.
The Windows build coverage we lose will be the targets we
are skipping in the cross-win64-system job and weren't
skipping here:
 or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
 tricore-softmmu xtensaeb-softmmu

which then fall into the same bucket as
   alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
   microblazeel-softmmu nios2-softmmu

which are already not built in either cross-win*-system job.

Is there a reason why we aren't covering those in Windows
builds?

thanks
-- PMM

