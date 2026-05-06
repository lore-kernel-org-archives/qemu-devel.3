Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941F0CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdzJ-0006cQ-Fj; Wed, 06 May 2026 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wKdzI-0006bL-I2
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:16:36 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wKdzG-000511-IJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:16:36 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d85152c9so2388605b6e.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 08:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778080593; cv=none;
 d=google.com; s=arc-20240605;
 b=MCsFH9F1wE+mxY7swf/CJYtWudV83CLkZsnp4oBsSVNJxyllRFY+TRJV8/7Pvw6O8M
 kWx2ZEpcwynSR9JkmxBru9E2IPbqu0qjGWL29F5C+FEL/XqrfN1KracI2oGZHhhKMYiu
 jfV6u78R3HjUP/igL7wvGZGYeRpapJpeMwdPc1KoUrhpGoBk2NmOTdWQfnW1uXq9MN1R
 h9EZP+MbU12XPdk96uMfINsxWXgQgdOjSCLWaFeOvXGbEN5zVe8bpY3YyPN8cJAdVZ5W
 T2u85khnUmCMIu4Zr9S0tdhqv1xu7ggl3ibrv2m0p3osibmd5x3nALXgoa+0YCcbNv43
 fo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XsygOVG18ySzTqtAn8sg02CFT00SWRXeZnzj/YXD+HE=;
 fh=wpJz5ijnwH6YUFQJwuk9CV7Sny9Xsl6coonhFcVV35k=;
 b=RpmkAUMNN2zdq2u7RfEKtEQOi/4dybYLYLapuP851q1dWtWbyD93vIBflR3o6dgEj1
 fRsf4WtXjIan6+Hwf7SuDS5287e/u5HGzhAq6w7w4wjRoQv9Y6ccty0lmmvAoDYhhyLp
 M7WcYuIEsptI0PLQjPiwL0KJK94CvZZJdlbBYAkPEyQt864Vz2GX0k+P8KFmjqTSC84T
 5L0L0V7W2dsuKc/bERbUJ1cm7dj5SSClK5UFtrBc5+D54d7pIDqUzV4AcGnNQP7mRkq6
 eztrFbyVtHyXnZyb7PiDze0iCHmiCffcI5MgcNsQBCShd5g5ENDrINq+iCEVqdp+PUMQ
 DKTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778080593; x=1778685393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsygOVG18ySzTqtAn8sg02CFT00SWRXeZnzj/YXD+HE=;
 b=KuDwpP3+6UTlkdGQhz1WlVYDIt/f0MlUa4AbxJQSVKmW7e7QJ7B1g8MkW0YjV2by5W
 or46QEsVVE/2zXJgW+Y6mcgSn/ax1raKw1fqCPV9hHGsvCGdaWUi/EYBkdviQRduS5Gg
 arkh0vBio4mDKtOJJ3jjUO9h/FkZiwbvbBKGVeacZr0l7y0e7tLL3zgsrPxnO14Vfn+U
 TFq+86pvpieWSgH+4cv6n2Jw3sd6ih9dfXDgfhZ9yTZ84ZpsTNRZXqpGpPilKyETG1tN
 CFL1R99usVz7ExnErxATVap9HK9ku0K0mmHUzA98YiDEzMCjXwphOYqXdt9Ctjy0ZJh7
 uVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778080593; x=1778685393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XsygOVG18ySzTqtAn8sg02CFT00SWRXeZnzj/YXD+HE=;
 b=lqu5L+Hlz+kTXgc0CCWHLgAmFYQLPy46bV31MuM2pIGPcXmfiFNyMNDKv9ztJY5kOf
 pT9gtGgQTN4GBNzEl8YBoGFFONxmvMB3nN8WLZPYT8soxiFwGmvX0G3wnNE4vWBw9nmW
 r0+hUUkPlDfGuLc5F9KflTzuMpbAgS08uQVcterFtBnSXbCqi/hO7nYoCDzt0biVhYYr
 xeHRNIIMDT0sBQ4iPVc0RJzXJNnBqelM3IkLKyeTrt8TZhoA4mm+Xkyhh+QufVz0KLPa
 myqReGTjKjvq6TArN529ZlX0b60fMmhF/RQlmg6J6dXUFwLZp+/a5D6L/fnpXCRCOMya
 38cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sjuOcy6J9OiTmg6+Cnrxfsxxc6aEyNpZQChz0fyJdfvw7j6VgBkGrTQIJO2csd7tPMXEvknBtBwqy@nongnu.org
X-Gm-Message-State: AOJu0Yyz2zsYDcgopHxAOhPZmqntmSrBq9jBe1nq3zHF+HBEuYqytqZE
 oE+dzMeZATOa8+GoAh/l7X0J//U/fsIsc4cJB0XpiOS224gKFs8ZYMxhTFUSdMW+nNuTLGuOPOc
 6CyS0ZBQmnTAGiSViQbAYIk2j4Rain7w4fd8XcYQs1g==
X-Gm-Gg: AeBDieuSp8hLusCYu3ojR67u2OrKLScM+uCu95AEaoDk3LCUaAZCQFia9Qxiet9sCZH
 iP8nyNwR2dM0chTZc/MEQkIFyM+NvWIAr+DLz1/USk7vDMZgxlhHmmzgeag0uksbeSMbXXKy1gR
 E5xnTVTz3kWurDgdpU4bh+lDzHMnjudZuL/Nx1ZG53oUSuo/ycgqeJB2bYGMZntaU8rtP2NebLa
 j9n0NI5ESpuSJ+ErqkBGEyI5M9j9xwAlr+LbkV3h2vM2hbdzTDItN5D647CQ9LXX0aKN2JxYhY6
 nJRLArZnW4ErvvIse26T+LYrNWc4
X-Received: by 2002:a05:6808:250f:b0:47b:ea3c:cd92 with SMTP id
 5614622812f47-480424a43c1mr2039539b6e.22.1778080592582; Wed, 06 May 2026
 08:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
In-Reply-To: <CAJSP0QUki9C6Nk8owfvmfyy_vfYT66mFQfsharkZ6GnDCLR5zg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Wed, 6 May 2026 17:16:21 +0200
X-Gm-Features: AVHnY4ILbcCn-s8Pm9zpqrnuI6ZTw6Y-PBOswjrg0URk7SmVKe6EeRj6wnK2aAs
Message-ID: <CAPMQPEJMDp=9TgXvKPYhGDbyiePz6Q7RLycWDsUxG3SyR8gHog@mail.gmail.com>
Subject: Re: [PULL 0/2] Build system: add stubs per target
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Stefan, Pierrick,

On Wed, 6 May 2026 at 16:42, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, May 5, 2026 at 7:07=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > The following changes since commit a85c588d07f8d3345ccad38b22026569a045=
71d1:
> >
> >   Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru=
 into staging (2026-05-05 10:11:49 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-20260505
> >
> > for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c38e=
:
> >
> >   target/arm: define stub library (2026-05-05 16:06:00 -0700)
> >
> > ----------------------------------------------------------------
> > Changes:
> > - [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier <p=
ierrick.bouvier@oss.qualcomm.com>)
> >   Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-pie=
rrick.bouvier@oss.qualcomm.com
> >
> > ----------------------------------------------------------------
> > Pierrick Bouvier (2):
> >       meson.build: define stubs library per target base architecture
> >       target/arm: define stub library
> >
> >  meson.build                | 22 +++++++++++++++++++---
> >  target/arm/meson.build     |  8 +++-----
> >  target/arm/tcg/meson.build |  2 +-
> >  3 files changed, 23 insertions(+), 9 deletions(-)
>
> Is this a pull request for Paolo's build system tree?
>
> I'm not merging this directly because I prefer to follow MAINTAINERS
> so it's clear who sends pull requests for each subsystem. That way
> maintainers won't be surprised by me merging a pull request from
> another contributor who is not officially the maintainer and it's also
> better for security.

I did not notice Pierrick's PR and actually included these 2
commits in my latest "single-binary" pull request:
https://lore.kernel.org/qemu-devel/20260506135524.20617-1-philmd@linaro.org=
/

Pierrick and I are simply reviewers on the "Build System" topic,
but it happens that I send patches there where they are related to
the overall single binary objective, and I see Pierrick as a co-maintainer
in this area. However there is no clearly defined MAINTAINERS
section, we happen to touch build system related files all over
the tree.

Regards,

Phil.

