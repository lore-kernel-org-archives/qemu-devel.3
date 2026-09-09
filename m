Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC60C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F6X-0004ua-Ln; Wed, 09 Sep 2026 06:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4F6W-0004uI-K8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:00:32 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4F6V-0005YA-0s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:00:32 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ecf499af9so75970557b3.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 03:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788948029; cv=none;
 d=google.com; s=arc-20260327;
 b=W10UHNwJYMtlzd6HUzxyemqYKGrWRVI+n7JnftRjg7DM/ltSMGQ8NBKDefw9EFYMem
 PjCTIDyiqzlN07GMjLbRHF3WUqjDLTZzhYzWYLX7dKDDQue96/ioM2YwPd10w4Qb60nG
 I0LGWizKUYuI2GgH+laiiYDycrq3Z7VwzXToJGLhSmYS6q0Q7szxJD9KvmmWWe2fbKy9
 YEMuLP1eYmiHT9RyRfOSwF/MBdDeRZ+6EQ8Qxt0ozp6DVeA7Dd4OP4JIO8HJWF0UoJr2
 y8GB6xA1JkLP3ILeaXIv72Ix7ukix2tsKFoe5AhUDHWRVy/AfXPdqQHW2Fw3zHlzCR/g
 ftIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YvhlOk0MOJ+QuUItIcojInPoluBjHV/jpXh0EOEhoCU=;
 fh=g+CQ1dgp1Xssg2+beQJi2IMTq48vFVaSB4T0IV4iV+w=;
 b=P4k/MKOqrlf61/drKALPAZoSgHwBiXCkk6vce3yMGLGW848G/K+03RlRdSLcn76EM7
 6x1dloVhZGL+HoJ/AKAbcLom3CraKF+h/cki+ebnsqvuCBsSnMnTaAVjPFZjdCrUF3EG
 c/+quSg3ZJAUw7L0PF0svKvjPHHp1ub4G/i7fwA0KI9wP67Znb63uk8miphPCPQCw62X
 GfqPP61hkBiVupixYiOagu6s7VyHZ3lqK78WCTH0LAXYhjwCyhGpp/KuHNmrZJHHQdDQ
 uWzQG2xcKNaaUtUx95eymF4N/eslIm3Lq5NwgExFzrMF2iXki2+Fbq5biDslw7Dpzm7e
 TvCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788948029; x=1789552829; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YvhlOk0MOJ+QuUItIcojInPoluBjHV/jpXh0EOEhoCU=;
 b=an4iQl/j/EilDGx8xnCV+idMsEyhU4Sbb0bkT30k3hkFo9y4syMJ0H4N5kIMUFpNtZ
 NlRECi/nNagZVfDTLdbbxQGp9YdN+7ev4J67pKXCmkGOTQ2tieYiPEurVJpPrmrXifOL
 xOWv9927TZZZEV25q74W9pdEDIyDccAjeIzApsUzivjGTUw309F+22NHisWm2lATmjbD
 8abjcdeM/QWjG08yx+jvYyxWM5++U9VvN+G+8A29fOeH3R1YzwoB6JqfY7jhGxOqiSZv
 QAdrcgm6kP7WMiSkgLsQ6DCYtMNH9E8hkcyyHmAXyi9YiLiGRAdMJ+EXc0Ygdw+RmEFP
 ASfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788948029; x=1789552829;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YvhlOk0MOJ+QuUItIcojInPoluBjHV/jpXh0EOEhoCU=;
 b=H/RRcQsOunq4ZEFfqX6yaxXqqDBVNGWvdKLRg4ic1HIepWU5wFAB8JIY2vT7faHf11
 AhFBsfrV2rZib76s0bvkTlN8TWe9LxH6wCgqlwws8ynKFP73w3TzMBC4n6Zm9LFhngxe
 Tv1XT1fcK7XG7J17/0sXPzbx/pL07aex6FkN3CPFHJ77cVh3oWfB9qJcKpIZdE1wJ4DI
 Bd66wzPPcvqkqc67qFb753vj1fHiw9g9jDMEN0pz5vtYlNDKlwAB+1wqchSC/bwtIow5
 4jWR7+Z8002O/MpvBjFQH9pXE+V4qsZjRsehngQ2d/xb8IeApAqLxH99Epqbe1/rXf4/
 GH1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBpu7qjsS+n9q0LkUQtIpoznjplc+7zeVoDd1IcjGDVWL4ayUI+7ykr/1dQUDZXFsNiDiX29ViEJ9T@nongnu.org
X-Gm-Message-State: AFuF++kUEsOhSatexJWmgQzJPQZEhJuyJhDxrGYgMiUNcqgiNx/Q76Ms
 wvN74qxsCsNquo3pAqMuLMJmrZKu2h1q9sRA7gnkN1QcuGM13EOwf7F88XUTXCQuJlUJVywM8eu
 PtuJyih6MEAK0jBq/BX7EqTMVkzwTlvVfMXk0Z1ZeZqpWTCejcGH8LL4=
X-Gm-Gg: AYBFou3PTuSr4B7+Hur0rM3Y35OoogjeVP97pehlEPb9AUQGUpFqd8JIU8Yhukqp7qj
 wNSta3k4I4BMW5v/9KBJ1y9BmqRIENmj4sY82rl2NiSclQcoBElG1rno3DMon+Ghy6ynbMhgDVy
 4o/to8dcy6NqwwjKFA+pO72AKGvCS+OlNcxFn70pvM6KQITLLkznTvseuNXxXkEUXuYSLxLIlqD
 c+rMdgLb+mkd+yR+xkc86Y0RYVVJhqybaP3YBtP33a/UAwaftXvkWfWBcw3Wav5Pbvfj/35IeWB
 Le7wf9kTamwa98hkcQN6jvpWgDveLwd9ye+t0f7RnBA7rSxowj4Qnxn7qZubmyWZTGIMBlbpoil
 8Rv3KJ1KhvJyO1aPI9oqAGR0C+eqCFwI/basA1pg=
X-Received: by 2002:a05:690c:6808:b0:86f:c1db:1499 with SMTP id
 00721157ae682-871266c53d5mr119596187b3.20.1788948029343; Wed, 09 Sep 2026
 03:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
 <762d160e-974a-47d4-8f0a-6cd7f6a4c0b5@nutanix.com>
In-Reply-To: <762d160e-974a-47d4-8f0a-6cd7f6a4c0b5@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2026 11:00:15 +0100
X-Gm-Features: AcwNN1VBd05RocftqFSmO0Q6xwMhSI0wHuWf7qFSGtAlClmlfaIXpugtZT3UJ3E
Message-ID: <CAFEAcA-cTaqgDi3NTiqZVvU+iNA4udw6umoAFHFk=raXmxvhBQ@mail.gmail.com>
Subject: Re: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 9 Sept 2026 at 10:56, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 06/09/2026 23:29, Brian Cain wrote:
>
> > pythondeps.toml and docs/requirements.txt pin sphinx==7.2.6 alongside
> > sphinx_rtd_theme==1.2.2, but 1.2.2 requires sphinx<7 on PyPI.
> >
> > A fresh install of the docs group silently downgrades Sphinx to 6.2.1 to
> > satisfy that cap, which then fails Sphinx's own >=7.2.6 runtime check
> > in docs/meson.build.
> >
> > sphinx_rtd_theme==2.0.0 is the first release that drops the sphinx<7 cap
> > and resolves cleanly against sphinx==7.2.6.
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   docs/requirements.txt | 2 +-
> >   pythondeps.toml       | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/requirements.txt b/docs/requirements.txt
> > index c10c4cf7c91..509d56bd1e8 100644
> > --- a/docs/requirements.txt
> > +++ b/docs/requirements.txt
> > @@ -2,4 +2,4 @@
> >   # Should be in sync with the "installed" key of pythondeps.toml
> >
> >   sphinx==7.2.6
> > -sphinx_rtd_theme==1.2.2
> > +sphinx_rtd_theme==2.0.0
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index e4c10d4a9f7..afb1364dd28 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -29,7 +29,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
> >   [docs]
> >   # Please keep the installed versions in sync with docs/requirements.txt
> >   sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
> > -sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
> > +sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
> >
> >   # This test group is for dependencies required to run various tooling
> >   # and tests that should always be installed at configure time. It should
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
> It would be good to get this queued to master soon as my local
> development setup is currently broken (particularly as I'm working on
> series that include documentation changes).

I've now applied this to master as a buildfix; thanks.

-- PMM

