Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F9C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hw0-0003id-F0; Wed, 02 Sep 2026 06:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1hvz-0003iR-9a
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:11:11 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1hvx-0004Cs-FM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:11:11 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-85a50f6a7f7so11996017b3.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 03:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343868; cv=none;
 d=google.com; s=arc-20260327;
 b=TGKDIiFdR+euLhccdvl14I/Q6fWPHGRxmsyIz/Q7EfKIPpn+ILvCBUQ+yl7haIfatK
 WJqz/OIK+EteDY0TBvu4wRtrbGa3jpn8fzsBMfC5rB+MPRpPjrkFv2aCilxgqC9jxX1e
 IOXWTsVbOXSY4fOpkNjBiiaombmHad84AZf1UeTwMtn04t0qskMvB7p3qAU9J9hEsquK
 IX6hZicBurXofRYBmahSPxAFxMxlFaJm3de9TbNl8liWPWP2BAGfww3Ziajsy6lFKRpy
 W8ykZX5lOsIh3Q8ril1ubnO7HlBc+ktGexqOnqICXAwsGaZVCYoMGZKuXt5+M9b8nzd3
 aj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4IRGvjFu94f5q/QjZWPHwTXxMpstkGpeKXwjWwjNhwI=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=b5wpJjUyyd6Q/DApF7GPiwFxdLDAhW4OWREYT21sBrPapiziHh2IssAssyGiXTrZop
 czClWiRVTlTnhTBAb6wwG/dl5HpPrHAx1Bw3NpF7Tl7AdFsH/hbFCJeRus1Ar+jjUMcW
 U2CVrFR+TIR4o6g2O9dLjTdjpwMKuvcHhp5oq8NjZt38NgmfXxaAG8hRywv+DUTg2jXb
 DZ5Ux8yuocTWAX1GFQUXl/i/9Fr+STPpHn9s802pVEWxsNRRAyDl0rWgdYO5P0js6rzH
 nL/AHIRO3ZCIK6yflHWgsKuYgaBoVfZKFUKEgjqG/1jSexhxefNkfiecYW2Cf6hIF1od
 X4mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788343868; x=1788948668; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4IRGvjFu94f5q/QjZWPHwTXxMpstkGpeKXwjWwjNhwI=;
 b=yYu311F6mp6GJRzVewG/NkW+9GC2+QeGueSU7jBhyMvKTxzDlexrOuL08n8dTjuhzh
 zwBhuclNAWjj5OAkPvG4QweN33cmykeT1YEgZAAI1XKJGGnLeywmKTxrXfzEtjUhLK7t
 IQ5HpPauPSzEM+UFOOZC6+NI9+EMEqQd+gPzWrVzyfRsCjGwYF2YGtDqVVuFGQNVT0dR
 BKzxaQI7/sil6XYB9f0qjeGSOyRL5mXBR7pg72gxo2rUKj++QIJKOIKtc8rZpTvFP0XC
 r4S8yR/TA2Wqvb4D3jt+ix5DGXiQcUjG8H3f93vcccqzH5aAZ8YQdHywCqDeO9vAjJcJ
 5/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343868; x=1788948668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4IRGvjFu94f5q/QjZWPHwTXxMpstkGpeKXwjWwjNhwI=;
 b=lr4xrWqgPVbpcBhvNDQ/aPOO9r/P7JiLkgRzjEREp6q/X7gltQK/+PLz25wFqcP8+W
 myKeQrubmPlPHrWRZADmy/E7wI8zySZO35h8Ln59H8XfOKFci/rQLHwPPwk4ow3DHAhz
 4nHICwCG4NiyKPtFM0ebSpK1QtQmSQa15TJHJSCzjx1PEHw4KH9wMN74OWNxlUwsyR0a
 CAvhM9/Hyp6bf+GZ0YOeqo7fwOcC5W8hHADQj0RJ2Bj585lPudJES0o3KtgbcwZQM3zn
 sCz+RHnoiQxnsjsYGH5YRtmcjTqo5xQtK8nXYA5Z+7z35peWkg13M51AxnEnct+GocTf
 TPXQ==
X-Gm-Message-State: AFuF++nh6zqa1YZh7NWBCYGGHzez6kXUfxuBriUbg/gm255ZYkD+1E5b
 1M+vRNsWkJEwyKuUXv1lvfNw6Ho5bsborjm70cRV8dgq6BasmRURX/EWPZw4N2EVDbzuEK6BAAh
 DV8yTbsv7A7pUOyyRylAkMr4l5iWcAq4TJUG00LR8lt2tNGhf4UmCLEk=
X-Gm-Gg: AYBFou17PZda7KRwbHE1ti4EANDdCn3qZjII+vPfAoc4IlgRxSj9UPQucfeW3y172N0
 rxoMjkJVW/2wZ3fSlbClAq4rrH2BzpDxMiz8rNTTqrSm56XbwXrNri48P45UxAM2MXimeyok80e
 pLgsc1OicmvgTVUWD9wOWYxisUerIRioTreC93v6YizJb8ApmTdPaSgyI0dzoHiMPWUqjq+JLPU
 vssxl9CCwtXgMnnUDzAssp+obFcuCFR/UTGKxVRGOk7OEYRmTYPc0COC/WyTqZZ4UUUTM+/GZLb
 5P3ByDfkdE740XmA73PqiWAld5wzua4nJ+kqQoK/UT7F1opBAFyEGsQtCPiPWs6zMh1Skd+SxUS
 vOvdD2aO9a1MOpFp0LUokuIg2/2uY
X-Received: by 2002:a05:690c:112:b0:861:67b4:9660 with SMTP id
 00721157ae682-86c4db3cd11mr18091997b3.3.1788343867416; Wed, 02 Sep 2026
 03:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
 <20260829-nohmp-v2-0-c5bf7b766fe7@redhat.com>
 <CAFEAcA95yjf_qr8hkPvdxj+kpF9KuU7UHkDMLWfOvfa3WqhmTQ@mail.gmail.com>
 <CAMxuvaxvSdA8jJyg76ejSNetGiScFqtZ2Nu1ZGig5h8ZcSAnjw@mail.gmail.com>
In-Reply-To: <CAMxuvaxvSdA8jJyg76ejSNetGiScFqtZ2Nu1ZGig5h8ZcSAnjw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 11:10:54 +0100
X-Gm-Features: AcwNN1UASc8pazzxabfmMRGFmoH5U-bUKLPbRY_9tTyi0-Z6gaA_K2gzkRPoGr0
Message-ID: <CAFEAcA_HiZ-86Wf86G4TDJ9jYKQ8pkSGRS7U9t6arnZLaNoW=w@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/50] Make HMP optional
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 1 Sept 2026 at 11:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Sep 1, 2026 at 1:10=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Sat, 29 Aug 2026 at 10:15, <marcandre.lureau@redhat.com> wrote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f59=
98b475:
> > >
> > >   Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshp=
b/qemu into staging (2026-08-28 15:17:04 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v2
> > >
> > > for you to fetch changes up to 7ef933e532a5f86778a16f5b0074f1c2d7b874=
59:
> > >
> > >   gitlab: --disable-hmp in build-without-defaults (2026-08-29 12:08:2=
1 +0400)
> > >
> > > ----------------------------------------------------------------
> > > Make HMP optional
> > > v2:
> > >  - rebased, skip one new test
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> >
> > This still fails "make check" on a local "--without-hmp" build:
> >
> >  118/1082 qtest+qtest-i386+slow - qemu:qtest-i386/ahci-test
> >                 ERROR            4.86s   killed by signal 6 SIGABRT
> >  119/1082 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/ahci-test
> >                 ERROR            5.58s   killed by signal 6 SIGABRT
> >
> > Assertion failure is
> >  ERROR:../../tests/qtest/libqtest.c:998:qtest_vhmp: assertion failed: (=
ret)
> >
> > "make check-functional" also fails:
> >
> >  23/361 func-thorough+func-s390x-thorough+thorough -
> > qemu:func-s390x-ccw_virtio               FAIL             22.99s
> > exit status 1
> > 292/361 func-thorough+func-m68k-thorough+thorough -
> > qemu:func-m68k-nextcube                   FAIL              0.17s
> > exit status 1
> > 311/361 func-thorough+func-ppc-thorough+thorough - qemu:func-ppc-ppe42
> >                        FAIL              0.20s   exit status 1
> > 359/361 func-thorough+func-x86_64-thorough+thorough -
> > qemu:func-x86_64-nvme_migration         FAIL             34.99s   exit
> > status 1
> >
> > The first three all fail because the test does
> >  self.vm.cmd('human-monitor-command', command_line=3D'something')
> > and this throws an exception. I think the nvme one is unrelated
> > and is probably some existing intermittent failure.
> >
> > This suggests we need to add coverage of this config to CI.
>
> I don't see those failure immediately on my build either.

This is a build on Ubuntu 24.04 host with "configure --disable-hmp"
and no other arguments.

> Can we adress those remaining issues after the merge if it doesn't break =
CI?

OK, I think that's reasonable, so I have merged this PR.
Please do work on fixing the tests and getting some CI coverage
for the --disable-hmp config.

Probably for qtest in a --disable-hmp config the qtest_hmp() and
qtest_vhmp() functions should assert with a useful message, just to
make the failure cause a little clearer than the one you get when
it sends the command to the QEMU instance and gets back the error.
Perhaps they could g_test_skip(), but I'm not sure whether that's
safe to do at that level down in the middle of trying to run a test.
We should also update the doc comments for those two functions to
say "don't use these unless absolutely necessary and you have the
code to skip the test when HMP isn't available" (just in case
anybody writing a new test reads doc comments ;-)).

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

