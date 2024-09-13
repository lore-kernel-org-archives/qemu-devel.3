Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF6FA373C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3Er-0002kn-JI; Fri, 13 Sep 2024 06:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp3Ep-0002kJ-Ue
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:09:15 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp3Eo-0000v7-6I
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:09:15 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5365c060f47so2347374e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726222148; x=1726826948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SdjoXif38LW99lqbEpk4Y4xefvM3d5yJHPpiKstLDNI=;
 b=C3q/B2fTC/R8DSFo+5KKOhkw1Zk3yv8AER/AEheDKnwGr95N8V1ftqOQUMhxN/HNHG
 YyFyoAYE8GaCPsAOdGJx4AN+JbtxkqW+zJNjIxjRLsHxOrcXcXkiPWmFwxGTQ2vE+Ena
 8Cb9S8cFHhJddHzSLy25z9ZgygeMz9HoucVu9YnwIFIEIkEgLnNUSBgYmLl3oQ47S+sL
 rS6AWN5CpxdYNO7C1jCmklXuCa16q4uV2U1yTtimuHScZRlusReYZ/5kpJ8Rsa3JaUY+
 8AqKEmKoWN/O3DJs/SvDWoOaeEIPtnRfISDArVXAJUN6pbRHG+us9j1ntGjFXIa8N39n
 nWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726222148; x=1726826948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdjoXif38LW99lqbEpk4Y4xefvM3d5yJHPpiKstLDNI=;
 b=mAEcMnmXn7JDG4A+K2Lx5FCXwVGPa+9zdPZt0jSHkTHq7ftoK0hkqXQfYWJcKqEeaW
 kqGi2QPQBlEWlfV3rWOwLWLstcsQKmpemQtg/hLFpFYUxmxPHcnmNJ1VhLw6eyZpFJvn
 pjdataabJJFttkLybzYR4XbCS0BSFKJshfcVq8/7G9zV1toO+anTRke9dmqMQsJl5Lyh
 W9gOJ1km++olm9ZZpZYltmp3MPFSUkiXfwdhApXf0Kgr9BH7Zv0ShQf74Ugz3Go9kCnN
 SuYAetDohsuwpNOhD7Pm+dBT3wug+ayt3NHatv3c3znCm7oeAjLsc69n3xlcsVhl3DFj
 JEeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUdOs49Ki+xBmQENtMNmF66rlQLUqx/DULZVxTyCYb0NMH7WXagjYaEHV7YNk9mE6Tkv2fmqUCmmph@nongnu.org
X-Gm-Message-State: AOJu0YyGDmQ6EivI71ybIThXINpFjQiF4ctfrdvM/QYd8DDCxNz4L+5Y
 tAGvoUqGoWVL3EOAKdR7amDXSSHNWiOCIWJmYAnCtiWbsGRxGs2RHPcREQ1PCqD1jbPOX+jDxRQ
 3U6KUnJdQRRtSafTboR6ROuM+I6twzdPXcngciA==
X-Google-Smtp-Source: AGHT+IGunerLNURah5r7h21KD+XqHP0i/pobPQI1gg7eV2vY47STjFWdZVg1DMujWnaXdQONuo/thLPBrIWPKOflLR4=
X-Received: by 2002:a05:6512:3b86:b0:533:46cc:a736 with SMTP id
 2adb3069b0e04-53678fed099mr3764219e87.37.1726222147834; Fri, 13 Sep 2024
 03:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <87r09wlu87.fsf@suse.de> <87r09nzxaq.fsf@pond.sub.org>
In-Reply-To: <87r09nzxaq.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 11:08:56 +0100
Message-ID: <CAFEAcA9nHvrm1K=WFQROLDuY-g9F2zk4C0CFk4bqZKc1d5hUFg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 13 Sept 2024 at 11:02, Markus Armbruster <armbru@redhat.com> wrote:
>
> Fabiano Rosas <farosas@suse.de> writes:
> > I could add error/warn variants that are noop in case qtest is
> > enabled. It would, however, lead to this pattern which is discouraged by
> > the error.h documentation (+Cc Markus for advice):
> >
> > before:
> >     if (!dinfo && !qtest_enabled()) {
> >         error_report("A flash image must be given with the "
> >                      "'pflash' parameter");
> >         exit(1);
> >     }
>
> This is connex_init() and verdex_init() in hw/arm/gumstix.c.
>
> qtest_enabled() is *not* just suppressing a warning here, it's
> suppressing a fatal error.  We use it to take a different codepath,
> which is what Peter called out as a bad idea.
>
> Comes from commit bdf921d65f8 (gumstix: Don't enforce use of -pflash for
> qtest).

The good news on this one is that gumstix.c goes away in the
"arm: Drop deprecated boards" series, so this specific
error is moot :-) But it's in the same category as various
"-kernel is mandatory except with qtest" machine checks.

> > after:
> >     if (!dinfo) {
> >         error_report_noqtest(&error_fatal,
> >                              "A flash image must be given with the "
> >                              "'pflash' parameter");
> >     }
>
> I don't like creating infrastructure to make bad ideas look less
> obviously bad.
>
> > For both error/warn, we'd reduce the amount of qtest_enabled() to only
> > the special cases not related to printing. We'd remove ~35/83 instances,
> > not counting the 7 printfs.
> >
> >> Some categories as a starter:
> >>  * some board models will error-and-exit if the user
> >>    didn't provide any guest code (eg no -kernel option),
> >>    like hw/m68k/an5206.c. When we're running with the
> >>    qtest accelerator it's fine and expected that there's
> >>    no guest code loaded because we'll never run any guest code
>
> Having tests provide the things users need to provide feels better.  It
> may not always be practical.

Specifically, if you don't disable the error-exit when qtest
is in use, then the generic qom-test tests which say "can we
at least instantiate every machine?" will fail, because they
assume that "qemu-system-foo -machine bar -accel qtest" will
at least start.

It doesn't really seem feasible to me to have qom-test
know about every machine's specific requirements for
how to pass a guest image.

The other approach would be to standardize on "every machine
type should happily start up with no warnings even if there
is no guest code specified by the user and it would simply
execute zeroes". We already do this for quite a lot of
boards, including some major ones, so we're certainly not
consistent about trying to diagnose user errors in this area.

thanks
-- PMM

