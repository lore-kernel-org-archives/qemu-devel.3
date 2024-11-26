Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9F9D6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2wN-0001Ti-As; Tue, 26 Nov 2024 16:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG2wJ-0001TO-Ht
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:17:44 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG2wH-0001W9-Ke
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:17:43 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cfa90e04c2so6710156a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732655857; x=1733260657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUxJ7gUtdImLe+r67+S/T9efEdLM4vkUnzT/eiTY9og=;
 b=El0cOtOEFi03D+g+3S6Ps2FZxebYM8caMnIYsD8wOgQXjHvKIjFqOk3XAa9Py8YAQq
 fNAd4BqyRV7I3hup3BfmtVouoYlgGzPI5Ue8l4oVrAnknzZiToPHyAYM5lqgWFADfRF3
 iAC4ROGYdurenkXmsqv4diFSTQzE3qXSojsPxaNQ4Y68h11j3f7oqP3vipWDg3iYvrSf
 AypLRAoTduwp4uhaaJ5Gz5Yvt6wuXiuyXkIDn/kokemn1VuvaRuWOGuuf3EDHAXyMUMB
 q0OGLsp7saNMvBTcaWgim6NBer1/JoDOOZuu42Wn5z9G2FuLY1y6geIn4xD/X8qbM2ob
 iDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655857; x=1733260657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUxJ7gUtdImLe+r67+S/T9efEdLM4vkUnzT/eiTY9og=;
 b=CviF9XyMWUkeh/wE+hNNGj/DaJl68jrFcce6mlZXUHhLmqrUQqV6JN/OZITZo3ww2s
 ie+JZD7P3yuG+2cUaLj2Kl5BqFhW5fJJxD/FxnMbLtTxC8xp6EJVAzGXqEYWTYiU765J
 KkVtGswalz3tTfdWrQKzxL1rXFDMgSLgYqxvJQf6ws04/2FSXFUcGzPabHGo3KtVTUvp
 zed3lVvK02fwCTJgpzBtYOPstMm6PMCViXYDj5erGohl+iK4a+NkVzFZ3oHigWO4pRVk
 FI1bus/mNM9aFXxVvATH16JKWvrey1X56nJuaQgm854lNxSWgPbRgvQluUHSUF4Hqpmk
 c7tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoG5hvfpNSJsBVrCFtvypvRZwffLcmBv+UY7xUqd7/1SbRn+CuWdG7pFdoma/EpsaLGSoQ+7wAsrky@nongnu.org
X-Gm-Message-State: AOJu0YyKKcOy9Fmox309M4NYVdj2w9Ocb76ohemAnb/cY3zaBR3yNSsV
 TcgIZTMwrmQLgiP1ZMvWOuSICmxsRCy4XX2TJXM42OFIPLXk0FdVBOuavB6Rh/xGGXIpN/wo7lC
 dugJk7of6rYwZIWirkr3wAUOYG3cscQaC8nI1Eg==
X-Gm-Gg: ASbGnctAMdYGbNgOU6P7orF1d6fF2/7l1i0sZOVLeumIn7BA/IbpY/mFuX0AvDtLdbH
 HUY7gF8f7RmN02BzaCKqmhYviH+qnfGKf
X-Google-Smtp-Source: AGHT+IGhuiRHgyaocyMsig71QG/iFX8yOKfg3+iy/u2Wjb84Xp5fGnyD5uaCTZFB8RtH69OGXPC5iujVlYsf/STFK2g=
X-Received: by 2002:a05:6402:27d2:b0:5cf:db7d:76e2 with SMTP id
 4fb4d7f45d1cf-5d080b8ae1dmr635858a12.2.1732655856729; Tue, 26 Nov 2024
 13:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <Z0YLvQWVHL_uDA1U@redhat.com>
In-Reply-To: <Z0YLvQWVHL_uDA1U@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 21:17:24 +0000
Message-ID: <CAFEAcA_J+YP9U63H25v0sRHwj4oUmZnDDHf-wvhNbJ=JPgSHsw@mail.gmail.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Camilla Conte <cconte@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 26 Nov 2024 at 17:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Nov 26, 2024 at 06:52:57PM +0100, Thomas Huth wrote:
> > On 26/11/2024 18.46, Peter Maydell wrote:
> > > On Tue, 26 Nov 2024 at 17:31, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > >
> > > > On Tue, Nov 26, 2024 at 05:44:29PM +0100, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > > > > Hi,
> > > > >
> > > > > On 4/9/24 12:38, Thomas Huth wrote:
> > > > > fetch() can fail [*] (see previous patch, various Exceptions retu=
rned).
> > > > >
> > > > > What should we do in this case? If we ignore a missing artifact,
> > > > > the tests will eventually fail. Better bail out early and save
> > > > > credit minutes?
> > > >
> > > > We already do what you describe - 'fetch' will raise an exception
> > > > which causes the precache task to fail, and the CI job gets marked
> > > > as failed. We don't attempt to run tests if assets are missing.
> > > >
> > > >
> > > > > > @@ -58,6 +59,12 @@ def tearDown(self):
> > > > > >        def main():
> > > > > >            path =3D os.path.basename(sys.argv[0])[:-3]
> > > > > > +
> > > > > > +        cache =3D os.environ.get("QEMU_TEST_PRECACHE", None)
> > > > > > +        if cache is not None:
> > > > > > +            Asset.precache_suites(path, cache)
> > > > > > +            return
> > > > > > +
> > > > > >            tr =3D pycotap.TAPTestRunner(message_log =3D pycotap=
.LogMode.LogToError,
> > > > > >                                       test_output_log =3D pycot=
ap.LogMode.LogToError)
> > > > > >            unittest.main(module =3D None, testRunner =3D tr, ar=
gv=3D["__dummy__", path])
> > > > >
> > > > > [*] Peter reported the following CI failure:
> > > > >
> > > > >    https://gitlab.com/qemu-project/qemu/-/jobs/8474928266
> > > > >
> > > > > 2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download =
https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_=
24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.=
deb:
> > > >
> > > > This looks to be working as intended. We failed to cache
> > > > the asset, and so we stopped the job, without trying to
> > > > run the tests.
> > >
> > > The job ended up in state "failed", with a red X mark in
> > > the gitlab UI. If we intend that not being able to fetch
> > > the assets doesn't count as a test failure, that didn't
> > > work here. If we do intend that fetch failures should be
> > > CI failures, we need to make our process of fetching and
> > > caching the images more robust, because otherwise the result
> > > is flaky CI jobs.
> >
> > I think we want to continue to maek failing downloads as test failures,
> > otherwise we'll never notice when an asset is not available from the
> > internet anymore (since SKIPs just get ignored).
> >
> > What we really need is a working cache for the private CI runners to ea=
se
> > the pain when the host just has a networking hiccup.
>
> Right, if the cache was working, once the cache is primed, then the only
> time we would see a fail is if the commit introduces a /new/ URL that is
> genuinely invalid.
>
> We absolutely need the caching for runners to be fixed as a high priority
> task. It also breaks our ability to use ccache, which means our pipelines
> are needlessly slower than they should be.

The other awkward part of the current setup, incidentally, is that if
we fail to download one image file, we immediately stop the whole
CI job, so we don't get any information about whether the other
tests the job would have run would have passed or not. In situations
like the current one where I'm basically ignoring this job as temporarily
broken, that means we get less coverage than we might have had.

-- PMM

