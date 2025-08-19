Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F54CCA0EF7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLGc-00040g-Qi; Tue, 19 Aug 2025 08:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoLGb-00040Q-Fl
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:16:41 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoLGZ-0005Rb-90
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:16:41 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d6051aeafso43098117b3.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755605797; x=1756210597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJ+bDOeV++YRHC+LaH6nvENQy3+iFL9b72IFwLNCtzg=;
 b=No+SK0BvuO95Z7CbU5oAhvPaNQ8r8mHWUUXu+cHwAFtj+LTzMNDYw6Ti/i7cOOUEYw
 LyrxhLvEb9wI4OZY6GelNde/Dx7nbxRnMeqBLOayfGvWKVyEXu250PVDDHyDb7MFBvXu
 whAKjf++SxkpMWSI59sn9iTsxHeKNKIC0SIDjvnunKbsf+p990N0VP4jZE7woDICV/rH
 gH3l8ir+zcJQ3gXPzJ3tifvHMQLrDA4Sf9RW72OmaP79+P7vLbFlhLrQIvaWI2Gww6ie
 AamRpNb809L5P0QO3SzxBcggA0E9B0rz7hzmr0LKRnlTFcYpmVlFehrIUATNXx/6pqQ0
 GFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755605797; x=1756210597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJ+bDOeV++YRHC+LaH6nvENQy3+iFL9b72IFwLNCtzg=;
 b=IAUYiX7FuW4Lc4b0lIEUe0RWGxj5yrpIn1hEXTwqEllIVJuTwraPkG4/yDtHm306Re
 Z3y8JdXc3cFQDMW+AwWXS7nOKbtKa7bbQk69zmuzjry1fIbl19yAXwotkdJHlG7HU4US
 S3b+kzEDOGo48PBj6DY6/FUYhystK3dDssGWzINBDQaFKy/flnb1cNJpYn2NSM92vsdu
 +UF6oAv3hxorPhtX4YPx/tNVBMN9sVgbCHD4883Lhrf2h8/xiXonUS4/389QVwFTJDEe
 GsEKSpECI1Yas2806FDXobiTe4W6uwgalufLGeLGFwaQ3eP1hW3b2NqzZg7WM6bjjFhS
 VcZw==
X-Gm-Message-State: AOJu0YwfefoUu3oeAS+P5eje67jniIpfJuIFS3K0Dq0ZU/9Qe6TblnVh
 Zo/O3GN20+8EndoCqwEE23DrSX2277zndGtImAdNxbiX3l7EPYZoZoKlStCyJx0RLQoQdTP0CLu
 fTX7I6/dFiF6+Bp94dkDwjHGotXHKGNFipgVCfknCpw==
X-Gm-Gg: ASbGncv1j9/KbDqaJiOxz2uZl+eetsEUF1qc6s/zVDcpBzCCCgMrbpxdmNbcB0kCPqF
 bIHzDUv5AcH2yXivX97gk+yCzvKxY1p+O4Rtg1mS1hbzmNemm6CLbv/ua/YNUwuLljBBE5g6Gef
 j3essc/tqhG0AejbJJQ6Dr+JHT8mjdJJ9gSLL9ORi9wwmcmT6FAXdfvQKNl1AGhpqLvsNLlegDC
 jpwcnFt
X-Google-Smtp-Source: AGHT+IELxQ74M5dNfyD70cskGb35kN+WTMzBjmlanoz4KLNeVnvJDrIV/OP6SCemcumL3nhiuPx3M74YOdWZUI6VE6M=
X-Received: by 2002:a05:690c:c8f:b0:71c:bf3:afb0 with SMTP id
 00721157ae682-71f9d6803admr28620247b3.40.1755605797291; Tue, 19 Aug 2025
 05:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250819115648.2125709-1-peter.maydell@linaro.org>
 <aKRp22i5RhqZKGkt@redhat.com>
In-Reply-To: <aKRp22i5RhqZKGkt@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 13:16:25 +0100
X-Gm-Features: Ac12FXz-x8KGIaanHlmZksOvgCohFgFfEoxkUdMO_9ClOlSbxslRJUXEqjcJkvo
Message-ID: <CAFEAcA_qj1dSgMTy4n6eAGrubMNSuModFS0_jBRGqVz7yJ28eA@mail.gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Avoid new Perl precedence warning
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 19 Aug 2025 at 13:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Aug 19, 2025 at 12:56:48PM +0100, Peter Maydell wrote:
> > Newer versions of Perl (5.41.x and up) emit a warning for code in
> > kernel-doc:
> >  Possible precedence problem between ! and pattern match (m//) at /scri=
pts/kernel-doc line 1597.
> >
> > This is because the code does:
> >             if (!$param =3D~ /\w\.\.\.$/) {
> >
> > In Perl, the !  operator has higher precedence than the =3D~
> > pattern-match binding, so the effect of this condition is to first
> > logically-negate the string $param into a true-or-false value and
> > then try to pattern match it against the regex, which in this case
> > will always fail.  This is almost certainly not what the author
> > intended.
> >
> > In the new Python version of kernel-doc in the Linux kernel,
> > the equivalent code is written:
> >
> >             if KernRe(r'\w\.\.\.$').search(param):
> >                 # For named variable parameters of the form `x...`,
> >                 # remove the dots
> >                 param =3D param[:-3]
> >             else:
> >                 # Handles unnamed variable parameters
> >                 param =3D "..."
> >
> > which is a more sensible way of writing the behaviour you would
> > get if you put in brackets to make the regex match first and
> > then negate the result.
> >
> > Take this as the intended behaviour, and update the Perl to match.
> >
> > For QEMU, this produces no change in output, presumably because we
> > never used the "unnamed variable parameters" syntax.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This obviously will clash with the "import the python script"
> > patchseries, but I figured it was worth providing the minimal
> > fix for the benefit of stable backports.
> >
> > The kernel's copy of kernel-doc.pl still has this bug.
> > ---
> >  scripts/kernel-doc | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index fec83f53eda..117ec8fcd1f 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1594,13 +1594,12 @@ sub push_parameter($$$$$) {
> >
> >       if ($type eq "" && $param =3D~ /\.\.\.$/)
> >       {
> > -         if (!$param =3D~ /\w\.\.\.$/) {
>
> I think it would be possible to change this only line to
> collapse the ! and =3D~ into the !~ operator:
>
>     if ($param !~ /\w\.\.\.$/) {

Yes, it would, but then the code would be:

 if ($param !~ /\w\.\.\.$/) {
     stuff...
 } elsif (param =3D~ /\w\.\.\.$/){
     other stuff...
 }

where we check the condition twice rather than using "else".
So I favoured:
 * "if C then {A} else {B}" is faster and more obvious as a way to say
   "do A or B depending on C" than "if !C {B} elsif C {A}".
 * match the logic that the Python script uses

over "smallest possible change to resolve the warning".

thanks
-- PMM

