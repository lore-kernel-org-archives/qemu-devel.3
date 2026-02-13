Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B341CEF99C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxbR-0004Fb-1A; Fri, 13 Feb 2026 13:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqxbQ-0004FR-2t
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:09:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqxbN-0002MT-3Y
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771006150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3RjgddKc+e0gg+Jac5OjvToT869hPupJS4+jFjsiEE=;
 b=HWUoQ0kWPPSvyQFFCw7oV7qT2ZYspcmvqDeNGnnX3gCQet08ilJVwLIzeHXehOSIoBKLEW
 ClakVe27n54GalaEn1vPRoMpX719Prc9RW89uDT9pqOxblD4cyQpm4kyt0wIPBuOfa6K40
 bqDDt+k/pz3jzvUy0pdmpd0VLcTFRm0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-_i82YypYO9KCnOiy9Oq2dA-1; Fri, 13 Feb 2026 13:09:09 -0500
X-MC-Unique: _i82YypYO9KCnOiy9Oq2dA-1
X-Mimecast-MFC-AGG-ID: _i82YypYO9KCnOiy9Oq2dA_1771006148
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-649aebcce1dso1830913d50.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:09:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771006148; cv=none;
 d=google.com; s=arc-20240605;
 b=aSbVrf2lmD0j1fRKL2reSikQwO++ftm625MAQ5tiMiAx8bKAxOHcjdNK7+6Ql/noqI
 khO2ARGOXAYuXdNTwFECVoFaYaB+udHQbmi00dKsOAFK0/wnC94DMdFt/QL/wT7qVmX0
 p3qu9AgILhLTrfwl3PfAhnTH8kxQM24ge/VukdepXq2sIK5HoGHvN7pzz5xg1+hS2ieT
 rqwasGiZRBd/k+7DVOjyVEGBk9KdFJHYyzPvVAohVjy7kztuJsqKYLMQPrJpYmF09Ps+
 wy9h9livON5XqOKzJJb90cez6Wgigwd1r/nlORiCvdgigKLNwEW7N1bqWLJtgJxLxZjn
 xh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y3RjgddKc+e0gg+Jac5OjvToT869hPupJS4+jFjsiEE=;
 fh=7ju8ALpj9z+CUS+WZEI5RFaco1zk6wmLf3mbg26+QVg=;
 b=b1mgC5Jonfd/mj9BtT/kGTXt9L4PPVwsQLOq6IiOP45Iuk1PPZ9z0HblOPIvMMbwkp
 kQ4uC3HqSCApI0zGoDQhEGdhzJKQI2UpMpHhpHkjFyeIRAjkld8sj8v12Ju6hiZMdJcs
 /QzXRvmaroGVDc+ugyebotV/tloeVFxcWI5vVI2gfTXxbGSF+kENpZnnmQh+/NOHp89c
 NEFznnl+KsiOO0vN4qXvao7ws1/lVtt02uQk+obs5YGs4DQSEUXCFpdQJH8D7jI6eSdh
 pXHKgScgMOHusClYVdCD7i223SYRID/3axKebrggUb7z0LIyibRLgh5TYihYcgn5LbYY
 RHoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771006148; x=1771610948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y3RjgddKc+e0gg+Jac5OjvToT869hPupJS4+jFjsiEE=;
 b=B0/PtEbTija+RZTpWkv2F65kLbN6Q4wwbCDLQBJppngv5/yRS0H3ugCEOypUqNXpVE
 Yh68gja658iB07qHF7BJRkNTaQbW2JDZ4FPY4UvCznasxbJlgys7ItGv2kRK4Qu9TEvi
 CvBzusc4Opzu5aUKvbLTepHWcyYR4ejLX7dvlIFmjkVa2OnLf5nicJae1+jjv/m5ymrB
 7tWAHtE8w+UcwEzV5LWbJpt2FEDDOdCmmx7ZS0vGkBCOF3fZuY17zuttdroBteguslae
 FeJtpY+ZZiNNLvVPSDUdHvEI7Pfatq4g0mZ9Z9gs+FyMOafhw3jXGf51HlNfze793jKN
 9aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771006148; x=1771610948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3RjgddKc+e0gg+Jac5OjvToT869hPupJS4+jFjsiEE=;
 b=pmVyCMGj/nuVZMgNf2MKxsdpqsIe4UhR6dAKFJosrZeDN+4PPm2MiNFj+bpiNNLvde
 QMZR587JCbuPG1ssODBNpMa3AGrSByiOcgjDvk2RrreG0cQVY6LJSKwt0ART/BrikwNP
 PhQIL0UkNRnV1MZ1sO5BO4CxUV4AK6PAudD4IwkuooFDz8NnbIiDL7g3rkxDSyK7b+fI
 vyicAWZhadVRYXpWIwhi0ddejC/oPC7ktMo3h9jWR8FEOOyDBwWLKi6IFOUQ1d/1v8zk
 2dhuEmU4dufJf31JOQ4PbkRvxolKZdAyMrDVXn8U1d0GyU6lMy5H3VSa6PcaPPXwp2Ts
 gS/w==
X-Gm-Message-State: AOJu0Yz7pasj7jn9QytZMbIU5zDNAh3nB2grvG4+8sHPHzyaKCq/j2xY
 m+hbFftO7oXQN3hc1+/GuVWktp/x9T9hCr4M211RfzwfaasHqI1FU1/JmNbrTJ2HI6JfcjruqEi
 Mwp/GbI82SqoxIkaNEkN+SBLIQU41TXW1v8lLcHE1J1zOVi9vZkted3JHUO2MmZkElwHpZBd2g8
 Hr5kWTlBt0k1h6xUcQ6CqhtcFBHEm1rB8=
X-Gm-Gg: AZuq6aJGGZ8Z8gvIsa56tvkTVxGefoylNj7E7Pn4TdDqY7Z7QpcvVQEb53ApP950KSm
 JtStUb+r2NjItVVJ2m0vrMF/h2tjr1O3Tp54pxAvneHt+dRbY0kLWKWXaUbaWb0g3i0yV97uaxc
 vQ2sRibbQ4lg0kO/UBE5BhjBcyTtbiWYcqKaNMDMxlnJClfQONXDg+wkBWmS29tcntO6nSqqYWV
 /bvOT6HgBeng4pte5TDhqB3Y9sa40R4pQLWXA==
X-Received: by 2002:a53:ac89:0:b0:64a:d45b:a4c4 with SMTP id
 956f58d0204a3-64c197a3d0cmr2009389d50.3.1771006148513; 
 Fri, 13 Feb 2026 10:09:08 -0800 (PST)
X-Received: by 2002:a53:ac89:0:b0:64a:d45b:a4c4 with SMTP id
 956f58d0204a3-64c197a3d0cmr2009367d50.3.1771006148083; Fri, 13 Feb 2026
 10:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20260211195804.135144-1-jsnow@redhat.com>
 <CAFEAcA9Lv8hAoM=kcGAACkRRy3MLHWp9sLoZ1n7_dNngMa6cVg@mail.gmail.com>
In-Reply-To: <CAFEAcA9Lv8hAoM=kcGAACkRRy3MLHWp9sLoZ1n7_dNngMa6cVg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 13 Feb 2026 13:08:57 -0500
X-Gm-Features: AZwV_QiUq0mKfFSMv3bWU9ZwC6l4lAYtAfmXT2Ah66Be9xSxaXTODIrj181HRXo
Message-ID: <CAFn=p-b7D7NB9jeHLkwSe+dPXrKzVbCJQYYY-PCaEg4ofUUADg@mail.gmail.com>
Subject: Re: [PATCH 0/2] python: fix python-minreqs test failure et al
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Feb 12, 2026 at 6:31=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 11 Feb 2026 at 19:59, John Snow <jsnow@redhat.com> wrote:
> >
> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2320293005
> >
> > The tox test is still broken because our use of avocado uses
> > pkg_resources, it will have to be removed but in a separate
> > series. Let's get the core tests green first and then worry about deepe=
r
> > surgeries later.
> >
> > John Snow (2):
> >   python: fix minreqs test under newest pip/setuptools
> >   python: drop uses of pkg_resources
> >
> >  python/Makefile          |  5 ++---
> >  python/setup.py          |  4 ----
> >  python/tests/minreqs.txt | 10 +++++-----
> >  tests/Makefile.include   |  2 +-
> >  4 files changed, 8 insertions(+), 13 deletions(-)
>
> Applying this series locally fixes the "No module named 'pkg_resources'"
> error, but instead I get:
>
> lanath:noble:qemu$ make -C build/clang/ check-functional
> make: Entering directory '/home/pm215/qemu/build/clang'
>   VENVPIP install --no-build-isolation -e /home/pm215/qemu/python/
>   error: subprocess-exited-with-error
>
>   =C3=97 Preparing editable metadata (pyproject.toml) did not run success=
fully.
>   =E2=94=82 exit code: 1
>   =E2=95=B0=E2=94=80> [13 lines of output]
>       running dist_info
>       creating /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info
>       writing /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/PKG-INFO
>       writing dependency_links to
> /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/dependency_links.txt
>       writing entry points to
> /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/entry_points.txt
>       writing requirements to
> /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/requires.txt
>       writing top-level names to
> /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/top_level.txt
>       writing manifest file
> '/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
>       reading manifest file
> '/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
>       reading manifest template 'MANIFEST.in'
>       writing manifest file
> '/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
>       creating '/tmp/pip-modern-metadata-bj38p2z_/qemu-0.6.1.0a1.dist-inf=
o'
>       error: invalid command 'bdist_wheel'
>       [end of output]
>
>   note: This error originates from a subprocess, and is likely not a
> problem with pip.
> error: metadata-generation-failed
>
> =C3=97 Encountered error while generating package metadata.
> =E2=95=B0=E2=94=80> See above for output.
>
> note: This is an issue with the package mentioned above, not pip.
> hint: See above for details.
> make: *** [/home/pm215/qemu/tests/Makefile.include:109:
> /home/pm215/qemu/build/clang/pyvenv/tests.group] Error 1
> make: Leaving directory '/home/pm215/qemu/build/clang'
>
> Applying only patch 2 and not patch 1 avoids this and allows
> check-functional to work.
>
> thanks
> -- PMM

Tch, I see what happened. Happened to not run into it in local testing
because I have more packages than you!

Thanks, apologies for the fuss.

--js


