Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC58EE20B3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voOK5-0001lu-Sm; Fri, 06 Feb 2026 11:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1voOJt-0001lM-Is
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:04:33 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1voOJr-00042n-UN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:04:33 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-894a2309a29so36492156d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 08:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393869; cv=none;
 d=google.com; s=arc-20240605;
 b=f9mKZ5APaE7hFr3ePnQ/uta2jCY+necsedMomUIqW/DOce+gIRAga6t66gQGzJShrP
 vVCbBJpydLUbeV79sr0meqn3EKoW1Lhs5J1OPqLEfmhAz8crwYwzhThPIFuL+cuo9fPD
 V5nrgFmgibHA6waMbTWAXSpoS3nD8e1+bny9eueAbpT7lYwGjIuNLThOHSve1SOaKueK
 AByqTvLNd36mdAqT//insYxWiqsIwYBlhysnUnhUgn5wBxyNeS56DBfCcKUsayieFVCA
 ZjpVEWGF+NeWo4NDsyCJvrnzOUAmvmF8b8qLNbuHSkFfswxqoQBwqKdXegwRuagj2dH2
 oY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bwopqVA0bmz2cgeNNUWB9fnjhsfYJq3VDIvzcGlhufA=;
 fh=1N8JXxzPSb1qBuNPZu2F8wnafdJwgvfuO89xwhL6jkc=;
 b=dhzxrcI8m1H2y0pKnO8Y208DmexnfnKL9CQ9o1qY07l1c4ndaPnIOkc7bVBZqrzRlF
 vZwT2sP++/Wr7efiWWTR023v3GBIy1g9He8AuxFZfpZfAhRwuo4emc3/FOrPLL9jS1p2
 nnqrWz7sZPfgFXrKBGhklOO/MxHH+KMuSSkzN4u/kV68WBszX+vw62SIOLoRZKF/8iYJ
 FC8nFsbu84wP/8EbJwBLRQrlzriGOb5wysyk0K8movnY21JtixLY31NERf7Jppa/yMdf
 +Njliav5bW100A8QcnYzh8p28U157z25So3jo6tPq0sKPFarLfrUfBmJuu19WgmxwIka
 ptCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770393869; x=1770998669; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwopqVA0bmz2cgeNNUWB9fnjhsfYJq3VDIvzcGlhufA=;
 b=b5hxq86pwt7t3eqp0mfXlxKC6W/wQbbtFLuIbqjyw8X7ciujLsZYitSAMfkuomk712
 P/XLWV+aRPKbxrDFPoiYXd97Dx7shvyHUXMS6bT9vQdJDku7PbEhhiJ8YoN0QIpDVV3Y
 9p0/m+Pwg6NdiLD4VglnB9x+kpcjk30gjm376MLCqJ5Zirunxg545kiznd4rCep6n+5P
 5na1PjXFmN1qC6tltmkg5asaxjzxyd3uxN7UbNOiGjDP6px9uQRKoVoETzsWCkUAB4zN
 ytlDv9HlRp9ziBMP0lld8BXJZx3rdUyXltaW+kCAEBNXSJGGSndNsApHT60nx5Si4AhB
 UyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770393869; x=1770998669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bwopqVA0bmz2cgeNNUWB9fnjhsfYJq3VDIvzcGlhufA=;
 b=DEwsgsajzFDGpcWSD6Nvl4wZ1pUcMW1ucgaEP874cYJLgLzVAaiPvFbD0Z5H0Yj2zS
 0B0DEpmDrnBC6nS4GFBLQOR+Df1De6ji/4SMIfFaUuIryQ3GqXLexUOtUbNXOtQa1cNb
 Kf9bD5QEmnDAmpCwQI49rrxz9/MfNqwPXC0HBEgiaQ/VWADIdKA6rQOksnghO668Uulb
 RaWsRRvhnawwoND5g3tpCmOSAoUEte/GmJgirBoyPOQhDpycQwF1YCPxqUVJn5ensJcR
 qHbDQiTsgteU7nDqJdS7SrU8VOJRbC/ZVWNqMMtUDXPbFalO5QxlU5T8woeOVEaAFYbq
 Xo7Q==
X-Gm-Message-State: AOJu0YwYFLeJjtoaQhWahMDP0GzZu+XRz/t3lng45Exe3ZLjF5LS5O6r
 /CSYLMUMcairb1w6UQfgSAzVCgGNsNfwVy3rPgTI0ReZ+r95QzUOEazxlZprYr3lGw03L+dXAB8
 wE6nNiBI+b1OX2Ezn+qObuus78a+2d+s=
X-Gm-Gg: AZuq6aJZ5yuoITcYqHmA2iGmk0HlWswixL9/RS2qD1AxOQQ1gMon+A7K9X74+4SXs6D
 7THnD6tJjPPW0dOg1SLt/feHoKI2au3hIt/mKLi1HBTilNkCfA8Yp9ivcDyqQonXY54VmN2ROr+
 ZQRqaMpuKqMCFgymvbYryKAS2WEWhPMpcLBLluF/R1NHkpnEpZsPCJQUFwRf9Fz7ygZJ7FeyNNM
 Rm/NQri/zefAezknUJxPWwkaAth8ycQBnIY9DAuFb/VjE5IOGB6L1Bj8imf14ibrgi7hU3nRSA2
 qM7Tzs1pyBiQcw==
X-Received: by 2002:a05:6214:1946:b0:894:7eb6:72e5 with SMTP id
 6a1803df08f44-8952fe8bf05mr98807266d6.0.1770393868520; Fri, 06 Feb 2026
 08:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20260204014611.2267-1-ckeong.teo17@gmail.com>
 <60a6e029-52a1-4482-9b01-702103e76ea5@redhat.com>
In-Reply-To: <60a6e029-52a1-4482-9b01-702103e76ea5@redhat.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Sat, 7 Feb 2026 00:04:16 +0800
X-Gm-Features: AZwV_QisR8NHsW0ysvZn8u6u6QESluY5NFSTglfAneBlzltTD7CRAMDTEAZQRq8
Message-ID: <CAOkKuiM-6jhhSLP31gWejH8BUykW4K38pHydvKkB6oRDv_+q4g@mail.gmail.com>
Subject: Re: [PATCH] tests: add run-tcg-tests-TARGET-softmmu to make check-help
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thanks, Thomas! That makes sense, it should be a subset of check-tcg.
I will amend it and resend the patch for review shortly.


Best regards,
Choon Keong.

On Fri, Feb 6, 2026 at 10:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
>
>   Hi!
>
> Thanks for your patch! A comment below...
>
> On 04/02/2026 02.46, ck wrote:
> ...
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 7728098981..5a99f0a920 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -3,29 +3,30 @@
> >   .PHONY: check-help
> >   check-help:
> >       @echo "Regression testing targets:"
> > -     @echo " $(MAKE) check                    Run block, qapi-schema, =
unit, softfloat, qtest and decodetree tests"
> > -     @echo " $(MAKE) bench                    Run speed tests"
> > +     @echo " $(MAKE) check                         Run block, qapi-sch=
ema, unit, softfloat, qtest and decodetree tests"
> > +     @echo " $(MAKE) bench                         Run speed tests"
> >       @echo
> >       @echo "Individual test suites:"
> > -     @echo " $(MAKE) check-qtest-TARGET       Run qtest tests for give=
n target"
> > -     @echo " $(MAKE) check-qtest              Run qtest tests"
> > -     @echo " $(MAKE) check-functional         Run python-based functio=
nal tests"
> > -     @echo " $(MAKE) check-functional-TARGET  Run functional tests for=
 a given target"
> > -     @echo " $(MAKE) check-unit               Run qobject tests"
> > -     @echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
> > -     @echo " $(MAKE) check-tracetool          Run tracetool generator =
tests"
> > -     @echo " $(MAKE) check-block              Run block tests"
> > +     @echo " $(MAKE) check-qtest-TARGET            Run qtest tests for=
 given target"
> > +     @echo " $(MAKE) check-qtest                   Run qtest tests"
> > +     @echo " $(MAKE) check-functional              Run python-based fu=
nctional tests"
> > +     @echo " $(MAKE) check-functional-TARGET       Run functional test=
s for a given target"
> > +     @echo " $(MAKE) check-unit                    Run qobject tests"
> > +     @echo " $(MAKE) check-qapi-schema             Run QAPI schema tes=
ts"
> > +     @echo " $(MAKE) check-tracetool               Run tracetool gener=
ator tests"
> > +     @echo " $(MAKE) check-block                   Run block tests"
> > +     @echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a=
 given target"
> >   ifneq ($(filter $(all-check-targets), check-softfloat),)
> > -     @echo " $(MAKE) check-tcg                Run TCG tests"
> > -     @echo " $(MAKE) check-softfloat          Run FPU emulation tests"
> > +     @echo " $(MAKE) check-tcg                     Run TCG tests"
>
> Could you please move the new "run-tcg-tests..." line next to the check-t=
cg
> line, i.e. within the "ifneq" section? It's a subset of "check-tcg", i.e.
> TCG-based tests, so it does not make sense that we show this new line whe=
n
> QEMU has been configured with "--disable-tcg", but not the "check-tcg" li=
ne.
>
>   Thanks,
>    Thomas
>
>
> > +     @echo " $(MAKE) check-softfloat               Run FPU emulation t=
ests"
> >   endif
> >       @echo
> > -     @echo " $(MAKE) check-report.junit.xml   Generates an aggregated =
XML test report"
> > -     @echo " $(MAKE) check-venv               Creates a Python venv fo=
r tests"
> > -     @echo " $(MAKE) check-clean              Clean the tests and rela=
ted data"
> > +     @echo " $(MAKE) check-report.junit.xml        Generates an aggreg=
ated XML test report"
> > +     @echo " $(MAKE) check-venv                    Creates a Python ve=
nv for tests"
> > +     @echo " $(MAKE) check-clean                   Clean the tests and=
 related data"
> >       @echo
> >       @echo "The following are useful for CI builds"
> > -     @echo " $(MAKE) check-build              Build most test binaries=
"
> > +     @echo " $(MAKE) check-build                   Build most test bin=
aries"
> >       @echo
> >       @echo
> >       @echo "The variable SPEED can be set to control the gtester speed=
 setting."
>

