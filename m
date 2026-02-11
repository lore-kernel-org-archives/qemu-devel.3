Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D9AEB5946
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 01:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzEt-0006yH-55; Tue, 10 Feb 2026 20:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vpzEr-0006y2-Mq
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:41:57 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vpzEq-0004Ou-2r
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:41:57 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8c5349ba802so625762885a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 17:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770774114; cv=none;
 d=google.com; s=arc-20240605;
 b=gFpPwbMYdXYwTe2b28/X1OQI/rvrYUOjlg5Jn7WMM0MNfvsnaQzSJ+z/0uZojTeTFx
 auBAhCdhftEfSL3E0uo249WYVITi6Bm1EMmUqpFuZYphO72FNjrqKS6Vrsf7lzEl0OEe
 LLEU4kQsyaXpsKeoQZS+3zvv+8ThGAmn4lO6C75Q0qTV1eq2J7ebodUWnFjpzZzga8/y
 XorzvdIna8qLw3fZYY8cNpLFZ+dlLbC0fZrPr2FgAnvjNkNil0+dQyxKUDunB0hmDq+x
 JezdO2vD4VKLyn3fA+MHu9LRZ1jUaTeo6lM6SpEnii9mWzl6WOss8fYqOzgWkYMtcZ3M
 K9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D4NvS2zr7+COFjRTMAU6b2GqDYUT80a6SG5QMUja81Q=;
 fh=8GsmLM9B1EwSl6p4jp89tZu3Tl7fzr4Crekib497Mq4=;
 b=UeXItLgHxUXC28Npv+bPDYSKletu3dezvqSrpHaER65M0zI+YEO22qp5dAJ+aiIjMm
 RogUM6AJXdPEeLS0A5KIinfZBFavF+U8vl4VEBRsjOIa2Fx9T95CTvc/DjXG/VSNJqAm
 xI3VSNdEcCBIYX13gZ4sLW0b1TOjyCVjcgTtkmK9nGBaaY1RLG10MfxcyxXqqTpQS3DU
 lHPMkN/3gx7Wbezfp61n4Ng8s/7QVBohvubjlohuMNV7JsgBvfnteqyD3vGlimcpP7mO
 f55UP8Yrt2n+EEBv5IYHrYsj+ZlgvbleGhMYjSsprytXn4uNukgtQYv0FBQAFOx8WcZS
 sVnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770774114; x=1771378914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4NvS2zr7+COFjRTMAU6b2GqDYUT80a6SG5QMUja81Q=;
 b=gQuKeQT15PpbsHZ1h/pFJ5Ov+tGVQg8YzNdl/SjiVmQO0ZEdTqY7zzeFfF9ZJjp0HV
 DXJ+ec7cTfw61R+MuM6O2TpDuKnQILmTbTpCt2qTe6gVp2oRHDoZktVdWsvZo5PikV6c
 sLfp98G2Y0ZnY3+mFJKqu3uYAE29/UB/ngU0YfvV1eUtqEERzXm1w8Kx1YnmDOw6stch
 m+A4QSo6dLv7kPpvNydBxGUG/vcDz/nzvLT0ppkfYEG1ZXLWJK8UZXjuR8hTMnbeSr9n
 g7oV2xHlPfRJelU0KaWf31TTEXyCF1/ttv/GwGlB13wsF292Y/WVahet4BJmbnhpAvCk
 +xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770774114; x=1771378914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4NvS2zr7+COFjRTMAU6b2GqDYUT80a6SG5QMUja81Q=;
 b=uK7ePXxQiFu7TGnhe0+htmelBzrcKYNW2joqXAMeDAHRa0k/wXXHp8gAIdrQXnHUhP
 cLMR9XmnXh3juJV8JefUPyzS6B77VYeqghne3VwxNILWCD2GQBYIFgudqcFWPKmFphwa
 xjk+oImQ00MYA3TCp1CCzSxEt7afTf2GWn3iOBiF7y0utew6T9p8FsH1O2Drg783dFcW
 A7pxeKGsA+g+5YUHW+6xcRqi9bMXRhrdBw1TQ8/z3mVRaHCgRBPjFhzS6Gw+wf8Fa63Q
 3UG/kS/sgIVPIcyNJOeTiN6hCTOpzU5ZYwBihaj+nsqmGvyC+Cre6crCeXTw/cVDDwWA
 CvAg==
X-Gm-Message-State: AOJu0YwQvykWDGjSPOeHvqcok9+pM+FDEVv0yx3DnzZTQ1lWKJkoZHL4
 3J+abJy+gBpqTQZ1A9Wlf73krW5FlYoJZLdmG6dpe+Do6RiY1jOrhqybVewwhW5+thEKDwD/FJw
 NyV4MEbqh9I4npdYdsMx0RhRaVTmpRpc=
X-Gm-Gg: AZuq6aLeLLbhb2dB/3r4N7oQnHyt3JwrdqDT1hoZ3Tdu3eX+z2pQ4qxb4XQvwFajor0
 P2ed06548t4G/ymKsaeZCX/WHnltVTgOwEiHGReAwGtnn5t3roDrktwQU9VPwBBHEs+dw57HMs8
 zmM0PqCW+SfG+10WR4PJFbVYdgUJmWwaVQ6ADFriqbOx+G9iVsEkhsXftE6B8eW165tVRl6BQau
 nLfRDL1cTr6cdpBRFEED0+kYJT1kqsLpcBH75eq5b50Z1B4I7YMSA+quCCxdh/yn2n8jb05yyzb
 d3HXkdz7Tp0APtGLUwsYxPFi+Q==
X-Received: by 2002:a05:620a:46a0:b0:8c5:2ce6:db1 with SMTP id
 af79cd13be357-8cb2a2bda8fmr27001685a.3.1770774114513; Tue, 10 Feb 2026
 17:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20260206170059.4913-1-ckeong.teo17@gmail.com>
 <cad6f399-1607-44a0-b0cc-6f18bf9be1b5@redhat.com>
In-Reply-To: <cad6f399-1607-44a0-b0cc-6f18bf9be1b5@redhat.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Wed, 11 Feb 2026 09:41:43 +0800
X-Gm-Features: AZwV_QjWYZklqXhB9VHy5-6JtnEdKRKzw7uYTE-0np5CpHC17-29-b5T33-jsss
Message-ID: <CAOkKuiMHFzu71Mzho40x4o6OAjv=TsVNda8BAcePZ+pmEhMmeQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests/Makefile.include: add run-tcg-tests-TARGET to
 check-help
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qk1-x729.google.com
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

Thank you Thomas for your guidance and support!


On Tue, Feb 10, 2026 at 5:58=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 06/02/2026 18.00, ck wrote:
> > User can execute TCG tests for a specific TARGET using the command:
> > $ make run-tcg-tests-TARGET-softmmu
> >
> > However, this command is not showing in 'make check-help'
> > documentation, making it hard for new contributors to
> > discover.
> >
> > This commit help to resolve this by adding the description
> > for the command, to the "check-tcg" section, as suggested
> > by Thomas, in tests/Makefile.include.
> >
> > Additionally, reformat the alignment to accommodate
> > the length of the new command, ensuring the
> > consistency of the output.
> >
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/228
> > Signed-off-by: ck <ckeong.teo17@gmail.com>
> > ---
> >   tests/Makefile.include | 33 +++++++++++++++++----------------
> >   1 file changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 7728098981..be3b78fdfb 100644
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
> >   ifneq ($(filter $(all-check-targets), check-softfloat),)
> > -     @echo " $(MAKE) check-tcg                Run TCG tests"
> > -     @echo " $(MAKE) check-softfloat          Run FPU emulation tests"
> > +     @echo " $(MAKE) check-tcg                     Run TCG tests"
> > +     @echo " $(MAKE) check-softfloat               Run FPU emulation t=
ests"
> > +     @echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a=
 given target"
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
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

