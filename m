Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E9CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmwL-0008Az-Bo; Wed, 03 Jun 2026 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmwG-0008Ap-1y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:51:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmwE-0002zt-Ah
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:51:23 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bf046d4da1fso152313266b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780498280; cv=none;
 d=google.com; s=arc-20240605;
 b=bubUiwocU+XzzYIyqCZG7NXd2V7peKOR3TThuGUB5tYgrJ42ICmRKI0l0SbbwGtBfo
 sCk3anRWxDhRHqNnLTU3je50FvJbk/TKHyq6gKyzui2Fdo7vCJ8UMi7XJ7iqXbM50lMw
 mHyq3UtO2r+JvcsyBYhu/IKzwEZukrDO+zTnk/UZEODtJ9xoSZyey5h7EbEg6DlglNKz
 9jcHVHgkuj8F49Q/ZBI1EVkmNmHMdVzAcFlfI0770rV54eYP9YCO1jyzIBvF/Uj+53Mx
 AdaxGnYarAClHaTInmWjebTmlJ7FrdPJCkRN3CaV6zzilhx9QCkO0zbgtm3AlOVF1Zxw
 gbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qZ+CSaMdJj5Ziz/UABtI6gZbghEhLa2A7I9bTo0n6eQ=;
 fh=jLOYD3FirvnRX49lPiVx6PZReYR15m+gPuAeFKi2agU=;
 b=MIfBwY5sf8acbRIMZW8JRPWSdiN/k0iBPc9ZUsuWSy0hooxx2XOWHb3SNvZ61Fm34z
 OXu5BxprTykH5awd4AOMT5nfQajRWb7wnudsp6Cauh7FnXxWp289CEGil3xcFQcAi2pT
 XDrwtazdpAIyzaRKCz6dtKFr33u9mRkmHIDj5ehrWpo6tv6z5vniJNPg3dfhZXEpOkWL
 6BRt1UJr6rlSp3bwvV3A/d7m/a+ARI+/d5Lus+j4LdTfTchLHKdY6GOiGFaLPF/7oEo7
 o4vTT0UyByUzYG3LDGzpsfhsFV9KuH/4lEbReH2LVegoZPH6OzZ/a8qmYRd5Xw0SwJkk
 kitw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780498280; x=1781103080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZ+CSaMdJj5Ziz/UABtI6gZbghEhLa2A7I9bTo0n6eQ=;
 b=N5Ns3pF96zJCuzxaN0giZRSa+kEUfXXGHVLwCPtr/MZfARI15qfYn8CCeVmNbzd6fi
 M/f8Ut09S/j5RmrMirJqyl8qg1aWhoRC4kVwvEHLWssk98JAUYaTqlfBLlyfrXZUdJdM
 QLlsflQjjmCOGGL5xg/EHb7d4hW7ftum2qdHffES50pbW0Vx+h3sRZYkw9xYY+DoQTH+
 jPaE3+bSpMVC5qqX3WzAYla34tAJO8JW90zvsTKDSH4XFLVEIPBp75sOFW74M2wOmZvn
 /56EIHzuBoJbDVjqDVOU9HxUVw8apabuJtnWdJR/TpNpvQCRmh5WLdqtto0q7liEP8a/
 9Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498280; x=1781103080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qZ+CSaMdJj5Ziz/UABtI6gZbghEhLa2A7I9bTo0n6eQ=;
 b=BgIJS+AJbvDnHooTFWWSYd8eKZwnt/XkpB4PyapprdCQy/10TEk15EfNtwE/4Rwws/
 qJgPuqkvgQA3ec+QbiuYNH0wv7xNrG4XO7nbnEogbD84GEKQdZ9i9S79klbWWS1WlDHV
 Zn4Ux4ImbQJE5pA6d/k+ivoluQZKlT9HvyNKNmokd5tLXqc9gTzcsYtf+CiVwwcrioDb
 iDYKswsGwX0RIgYu9mKPIsGfKIklryDiBxkDaPlmcn5kdCDBCytWQZP1rDSS2/72C9ei
 eStOIYqH1ACkNM7/ibSwj5B8vCIe4JkwvjXus7FoxpJK9srT1MUwVxlyIbALdbMzxrEm
 LAoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LVUZXo84S1ERjs+WXC9e5/I46+B390k0KOL6WuOHboucSWIpEl+TqZX0QRZW6uoDoqVU83yohjjPT@nongnu.org
X-Gm-Message-State: AOJu0YwpkfK4j2YA0IXX66f/ujeYQNjst9pJyN85qZiZDTRX3amNk6Hg
 4U1LthlrKSTF4+0TrxVPMdh3dtgEYqdQ0MUP4eWUyNlabN78LrtolXrBUQGPYmtGo8ftgW7Yaws
 t2pDRmTPoBbAvRnKS+BgDZLL9ujcVBQY=
X-Gm-Gg: Acq92OFpJELfJ+PiLspKZRMVFqBQh7O56G/EVWpv+bugD6OsOt64Vho0JBszkvfqdMP
 Hxxl+XZQ22DlAEHja97FLgBv4BGJnhVpDg3f7nsxbEueaiD1rUKS+6167giDWt5ZbyaoQIvMxyb
 fM1pooGOrzYIHwXSP0emsQdviTf29lnX3PkuwWhyUUlnVzILik8IHiQkii6AmWIFzFwsU2OqfsN
 NlHWM8Du1P7K2u6fJAQCMdjKeCwDs1AhEYlf0sRRk/ZzEp3sv6FcfuXmX0eLoo3vqpH28c6WtW1
 EyqjnRJywCCOKqcAow2KQ9LOJUmIW/VnIKHfgqlc3WFT5jsip5SA
X-Received: by 2002:a17:906:9c90:b0:bce:a1fc:6877 with SMTP id
 a640c23a62f3a-bf0ae3fefabmr213308866b.24.1780498280189; Wed, 03 Jun 2026
 07:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-2-stefanha@redhat.com>
 <b3e40f92-6544-40ba-ab18-9171b6318ca1@mailo.com>
In-Reply-To: <b3e40f92-6544-40ba-ab18-9171b6318ca1@mailo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 10:51:07 -0400
X-Gm-Features: AVHnY4LAaptl-I6VSOW8Df8W0Mev2slbesV7bXLaJuoVNwt3CMLiX8Gj-62UHhs
Message-ID: <CAJSP0QUW_-dhyVN8Q6mTK=hqJ=_8rxL3-ygNxyjSGYX-MqPWXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gitlab: remove x64-freebsd-14-build Cirrus job
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62b.google.com
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

On Wed, Jun 3, 2026 at 3:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
mailo.com> wrote:
>
> On 2/6/26 18:24, Stefan Hajnoczi wrote:
> > Cirrus has shut down and the x64-freebsd-14-build is failing:
> > https://gitlab.com/qemu-project/qemu/-/jobs/14656732122
> >
> > Remove the x64-freebsd-14-build job to get the CI pipeline passing
> > again. The next commit will be to remove Cirrus integration from the
> > GitLab YAML and lcitool since it is no longer used.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   MAINTAINERS                         |  2 --
> >   .gitlab-ci.d/cirrus.yml             | 14 --------------
> >   .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------
> >   tests/lcitool/refresh               |  5 -----
> >   4 files changed, 37 deletions(-)
> >   delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7752917d8c..4ff33eb630 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4511,9 +4511,7 @@ W: https://travis-ci.org/qemu/qemu
> >   FreeBSD Hosted Continuous Integration
> >   M: Li-Wen Hsu <lwhsu@freebsd.org>
> >   S: Maintained
>
> This raise the question, is it still maintained?

I left this section because Warner is working on bringing up a FreeBSD
build VM and corresponding a GitLab CI YAML file in qemu.git to run
builds. Warner can add the path to the new YAML file and add himself
as a maintainer in his patch series.

Stefan

