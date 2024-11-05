Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D19AD31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8O3C-0004OG-5U; Tue, 05 Nov 2024 13:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8O36-0003ru-LV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:13:06 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8O34-0005I0-Mo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:13:04 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb5014e2daso53488451fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730830380; x=1731435180; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i4iFBCLEUgPbb26jFvoQiHfJuFqpt/9yb1HmtpIZzNI=;
 b=ABwXSqc/deReJuuAn7IfWbhoHItq5sv7VcZR5pJZARQV63QUKSHNkM7KnvoedxdwrC
 6478pNqVUYmJtjylnaBI2GY+qpVoSvfrVM4lbsHoFzDxJO3LIqq9/VhBi8qQeEeUgsZU
 BjbTfYWWIx+Kv+tp/fjKDSJ6X9cYUPBvCsXh7QPZy5PX2FvzEdU9ZHJipj+c3hnKRJpQ
 gkmdTMn4XVs+otx/A+T76JaQNpWKOcjigJ7A0ynh2rzxQ9g+ld3LzZgEO8DNZ0V14kXN
 1zpLrQ2gVejj77AYKRYaPxY9Z/EjFhIGv3hnJ4cM5bbeKOEqkrE1QD0qC9zBNsHJcUrU
 dxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730830380; x=1731435180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4iFBCLEUgPbb26jFvoQiHfJuFqpt/9yb1HmtpIZzNI=;
 b=cWlu7RYgvo03lJsrtYijF01x27kv6wOMKPyC8n476/ALMHl/Q8vOAoY4ItryWseqNG
 Hhh64+6rotHW5PEEEeZ8WvfusIKt9PwD05g65u00VpxIGFL9KiUavHqp+j+gvlATILCy
 u5aNElQTn5b+cStqQ+ph6KYCKvA4BfPXnfuH4Y0kL/gKPM/oKI9u7J16MfJLb3x4QXWG
 tn4bGX9zqL9DNy/as8POm1LiQaR9XtfYc/UO8uLIU1Z3v3EG18Ezf+lO487pNXRr2jMH
 gV93FZugI0pDzrVontdbpe9FGYGSJbSNs6ngQP8UXLH8EKYy9/DIIYd1loAoHaDSrHO/
 jYFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/zahm0DA1slV/eUIPfwFuM2yET3eZqNE+RQxye935rvHDY7dOxBNKCkNv+6Yb6nclKbk4r5t02BYK@nongnu.org
X-Gm-Message-State: AOJu0Yyakyjxq1OEtn5zmcOack4EHQojpSLFUNhiUKG4kVrqkiQe5vhs
 halfs6SGPTlqZi4AEwQ3fbW+zgO55Hjbi2AoRD+oHfS85AwQjZU6t5+y8kNrkLnS3W5v47paJPX
 FGNucC9wzDtUtCjAgcnpV7Br+2Maea+snxkFg1Q==
X-Google-Smtp-Source: AGHT+IEOowS4jxGGEvqiPjLdUhmDdx929bUWqrsZaUvJytV+br485HXeJjYzwYN8T503z6Jwym0X2rdtcgJJ0qPZYqo=
X-Received: by 2002:a05:651c:b20:b0:2fb:597e:28d9 with SMTP id
 38308e7fff4ca-2fedb771588mr79232231fa.14.1730830380345; Tue, 05 Nov 2024
 10:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
 <20241024063507.1585765-11-clg@redhat.com>
 <CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com>
 <91c2ac92-66b2-45c8-b4fe-e8f8587b0e9c@linux.ibm.com>
 <CAFEAcA84hhWu2ouirfDPbCpq_=QLQxAf3k47h0Pij8iEnOVj+A@mail.gmail.com>
 <2491bc60-9a0b-486a-8f6d-2c4c94332756@linux.ibm.com>
In-Reply-To: <2491bc60-9a0b-486a-8f6d-2c4c94332756@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 18:12:48 +0000
Message-ID: <CAFEAcA85g2nX3MU5RzmBvAHT8Kis1JHhiEaBvnFFbEQkG+0OxQ@mail.gmail.com>
Subject: Re: [PULL 10/17] tests/functional: Convert most Aspeed machine tests
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, lena.voytek@canonical.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Tue, 5 Nov 2024 at 18:02, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 11/5/24 12:13 PM, Peter Maydell wrote:
> > On Tue, 5 Nov 2024 at 17:02, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> On 11/5/24 11:14 AM, Peter Maydell wrote:
> >>> Q1: why is apparmor forbidding swtpm from doing something that
> >>> it needs to do to work?
> >>
> >> What distro and version is this?
> >>
> >> The profile may be too strict and not reflecting all the paths needed
> >> for running the test cases. Ubuntu for example would have to update
> >> their profile in such a case.
> >
> > This is Ubuntu 22.04 "jammy" (with swtpm 0.6.3-0ubuntu3.3).
> >
> >>> Q2: is there a way to run swtpm such that it is not
> >>> confined by apparmor, for purposes of running it in a test case?
> >>
> >> Try either one:
> >> - sudo aa-complain /usr/bin/swtpm
> >> - sudo aa-disable /usr/bin/swtpm
> >
> > We don't have root access from QEMU's 'make check',
> > though (and shouldn't be globally disabling apparmor
> > even if we could). I had in mind more a way that an
> > individual user can say "run this swtpm process but don't
> > apply the apparmor profile to it".
>
> So the problem is that the avocado tests are using /var/tmp but we only
> have AppArmor rules for /tmp/

The file AppArmor gives the error for is not in /var/tmp:
it's in a local directory inside QEMU's build dir:

Nov  5 16:01:14 e104462 kernel: [946406.489088] audit: type=1400
audit(1730822474.384:446): apparmor="DENIED" operation="mknod"
profile="swtpm"
name="/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2600_evb_buildroot_tpm/qemu-machine-hhuvwytc/.lock"
pid=2820156 comm="swtpm" requested_mask="c" denied_mask="c" fsuid=1000
ouid=1000
> The following solutions should work:
> - do not install swtpm at all
> - sudo cp /usr/bin/swtpm  /usr/local/bin/swtpm
> - as root: echo "include <abstractions/user-tmp>" >>
> /etc/apparmor.d/local/usr.bin.swtpm && apparmor_parser -r
> /etc/apparmor.d/usr.bin.swtpm

Is there no way to just have apparmor not apply at all
here? I can see why you might want it to apply for the
case of "I'm using it as part of a sandboxed VM setup",
but in this scenario I am a local user running this binary
which is not setuid root and it is accessing a file in a
directory which my user owns and has permissions for.
This should not be being rejected: there is no security
boundary involved and swtpm is not doing anything
that I could not directly do myself anyway (as you
can tell from the fact that copying the swtpm binary
to a different location and running it works).

thanks
-- PMM

