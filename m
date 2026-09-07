Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6867FC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WOg-0006IV-UO; Mon, 07 Sep 2026 06:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3WOf-0006Hf-HM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:16:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3WOc-0001DG-Mq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:16:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cc1c8d4a959so2197369a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776172; cv=none;
 d=google.com; s=arc-20260327;
 b=isBliTAg/npsQzIf4/y+WvFrFGm+eXClb/UVnBLuzMTmy8wc3/JaIIllaQX/ZKFcCh
 Eh+jmsaG+K1iMiq++oHh143873iJ1OWnFya9LM16bzYOUfuEOaafixLpj+s5P6treqU2
 M48kS0VvgBZLodf8PwezlIWbmcLvo4KevBcR2pUyL5BUIiEdpBwwq3EXUzYRhoKnAghl
 75QC/5ZLUkHWJEsqdrlWxSmSLrHOL8tYxW5GOgkmXlh+LqsQcPKwacgVurUU9LqjqecA
 7JpopKCIeeWNE/8VC232MTYQ2TcSi5JANrPlNiS+vasNDki+K1MYo3SrzF9n8UfymJHt
 1Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=imnYvxmVFLPolgSKPTG89lYbtpJMcua5FiADRdGXlfQ=;
 fh=Os9eyw0dNf+Ua4eh306S5etea3WRdTLLuD4/1ah2bsA=;
 b=BFa/ELoHzOFUAksqB2A9ThEi0qnVJc3ZkYKb5dAgAbTdW54gSpS5E0Y4ZrzvMQlivC
 r8ScJwZ9HiOxLH7F9VWR1Py3b9Nbi5GlJSVpwBrLWRsWwg3W8da7S+ufGM/c6pC/uiM/
 F6ip0BAcU0geHi0wwwVG0JdikRS9nFwNa+j4hp4iMPWHXeM9o9Vgr0xweaf3MOeDyglf
 MAsUOY7EgTnjBaI9TbPrv4ICpMirI6RWFpYg+sjMDnbZ6LU27eklM2E1hAWwuumlPqSs
 5/9EMbO56mWoPhOASA6XNfsqI2HCcZlg1m1Yl39qpF0za8CtDv+q83+WQzGUu634Lj19
 pyKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788776172; x=1789380972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=imnYvxmVFLPolgSKPTG89lYbtpJMcua5FiADRdGXlfQ=;
 b=ot9Mp7amyGxct+11fzHYeAepew0rphZe+32JHgCnY1J7r0PXmApe9YVvD4dtxXjSHY
 YeP0pbWlEKyR3Y2ZEM7lCSxUGhSrD/KaxUdE3t4eDX9DpVcuhod0W/xDFR4hRFJ2FsEP
 gmkio4jz5a4DSJ1kwTb3sPryvDaGDU2Ua9UyCTwnNzjtz7c+UYxBsU0deZz7SasMIJJ0
 P9vXNpOhQsDizBVjp700QRGK8SBGNgnYAMIB1Uro6Raovb9zFOJ6hrtKYx8ycCbb6v2q
 6F4ijdOIFWMe/6Eycyi/3Gg8Ptnj53XfIzJWt9joL/82vUx+cxjCkqK8K32Sy5RcBySM
 6flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788776172; x=1789380972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=imnYvxmVFLPolgSKPTG89lYbtpJMcua5FiADRdGXlfQ=;
 b=VX5JiDKOwwTcWKdDZgFom0SrtwOKbJXdV4PHy3Ogu5PWvv3ph+Dibx62PpVHJucte+
 DdmA0bssF6wuM70DQV+Abx8B70McvucHHLGgNwJzPOZHtTvLOSwMwwFIW9EHfdtQOzE/
 4EU92Pfp89dT2W6pjtjazdGGTfhiuemVFA2ulZMm+GtP6uP1Y6Pxtuak7P/C286mgv5B
 UhXiyNhpRAm05m79sfgwAKXVp5av2tG07FZ8gTOALXSaCxUN3XKvqWffe1cMnOYfYOvm
 5pbZNC2N3H5qexHDRiRe4/lfDk2w/V8qjJcCAevdE5wG3ID+Bm8LpK5ASSUsl5ApOpoa
 Wv9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyOXUo85LBtTlz8Rjl99ZN/hotxRbQnekuy/gE29LLjzrxzcprGuKMN/QXkzyXOl1YjL0aOdtRDYUu@nongnu.org
X-Gm-Message-State: AFuF++nV0J75a1u+Y9xIVIM+oKwT9+7kUx5Y26ePw78FHo0x1ccmtSbw
 j4JLhrh4w/vMldl/9ErLaYMSR0sB/4RgQSf7kpZYNYi0Enyth4RCiOtgH90XyEYI/oRWrr9m462
 evrzpvrVI3TAs9R7YPmGsmtNT0yNedJM=
X-Gm-Gg: AYBFou3KmrfZNwHtxPgLh10ouZcJFtDKzmGk4QWe7sa993o/c1cGKPU9ZIgdhX7QKY2
 np9z720vIB9Jo3XS0WUgnPHq+KF/MiyniMagj6cSFNVeiQkfTNw4Tw9eyX8t2P1QchwgVMRI4xh
 Vocu58w+ng3s3W0TZ8v/7UqWLpv5MRQy2mi+jxVIa+o4kZd6bRuxBWGo3GblN/riTxEA10+GMrH
 uC9hy25ImY4AzP+EZ8mKp2CER1G70vLCrZnWGlJqgmR/h6O/LKqcd5RjdSn6VN+jQDALQFd/W59
 rssJj9F2oKJ2r9+5FrBio+8YQn1kzWAae189VJSmw4Pdt4ezMCUkpqLV4/qRLvAHqYzUQuZItDI
 n
X-Received: by 2002:a17:90b:4c86:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39b25f78ab8mr31373847a91.0.1788776172513; Mon, 07 Sep 2026
 03:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-2-daee96491c43@redhat.com>
 <20260906130649.6fafc3c4@tpx1>
In-Reply-To: <20260906130649.6fafc3c4@tpx1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Sep 2026 14:16:00 +0400
X-Gm-Features: AcwNN1UZZFQjFTmbeqR5-kDss6ekzU0jbl5OOsYJJEi1F57fYS63p11RxJwaN_w
Message-ID: <CAJ+F1CJT+jdKArkc-xge=mU=zbR3GuU1XEttJ2ArPZeHCXEd=A@mail.gmail.com>
Subject: Re: [PATCH 2/9] tests/functional: replace HMP with QMP
To: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Sun, Sep 6, 2026 at 3:08=E2=80=AFPM Thomas Huth <th.huth+qemu@posteo.eu>=
 wrote:
>
> Am Sun, 06 Sep 2026 12:42:33 +0400
> schrieb Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>:
>
> > Replace HMP with QMP equivalent.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/functional/arm/test_integratorcp.py | 7 ++-----
> >  tests/functional/m68k/test_nextcube.py    | 5 +----
> >  tests/functional/mips64el/test_malta.py   | 7 ++-----
> >  3 files changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/tests/functional/arm/test_integratorcp.py b/tests/function=
al/arm/test_integratorcp.py
> > index 23ae919359d5..fefed26266f4 100755
> > --- a/tests/functional/arm/test_integratorcp.py
> > +++ b/tests/functional/arm/test_integratorcp.py
> > @@ -72,11 +72,8 @@ def test_framebuffer_tux_logo(self):
> >          self.boot_integratorcp()
> >          framebuffer_ready =3D 'Console: switching to colour frame buff=
er device'
> >          wait_for_console_pattern(self, framebuffer_ready)
> > -        self.vm.cmd('human-monitor-command', command_line=3D'stop')
> > -        res =3D self.vm.cmd('human-monitor-command',
> > -                          command_line=3D'screendump %s' % screendump_=
path)
> > -        if 'unknown command' in res:
> > -            self.skipTest('screendump not available')
> > +        self.vm.cmd('stop')
> > +        self.vm.cmd('screendump', filename=3Dscreendump_path)
>
> screendump is an optional command - it is only available if CONFIG_PIXMAN
> is enabled. That's why there was a check for "unknown command" here.
> Does your new code still works if pixman is disabled?

My bad, let's skip the test when PIXMAN is not available. See upcoming v2.
thanks

