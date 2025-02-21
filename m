Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A55C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXiS-00023y-F4; Fri, 21 Feb 2025 13:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlXiQ-00023K-Bo
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:25:34 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlXiO-0006mN-NQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:25:34 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so1874786276.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740162331; x=1740767131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGhca+FtKWVAOMd7qYj10v0KdJR1NfirrXY/isbPnrA=;
 b=cYoxyc+MypisgXc0Adumiufa5TQC2zQpv3j/5YPWgOKLISsO2kws8ty8t0hiianv4a
 VDbmd+RQqUF/CzUq6VG/qixFdMZ3ATQ9eXmjnpJRgOci9bkNL4J/Pe/THicThcC7sG8y
 aOzJLL6GDnDxurfm30CnZNJrZAMV6SN1Gbw+xp+DhAvaMzIEohosQARlX9A1+abEPInE
 LM+8SqyvL+A40L0n9KmZRc13ghefUaiXdMt29ekKuNlaU2/VEq5YKDL7ZA2a4ArXHCEM
 ziBBpQ6dHwCMgBq2sbeVpa8E9EDgZxHbINdnCr54bYSOjRgBWWoqrwoIeIT7Nq/Hppxt
 u1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740162331; x=1740767131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGhca+FtKWVAOMd7qYj10v0KdJR1NfirrXY/isbPnrA=;
 b=OH9vIaCpMrC6aSZrelQKRMF432H0z1E21ndf1ORoW185Ypi7RzXl9W1Gbj69P4p3Co
 Og6ORsmRYs/R/sdUpREGcpjpfJAwwzJOH/4dL9AxrjHJHRfVslV8ILxQleCyP1NwCPJD
 5ZDFkR7bY8nXocIUb1GnFld+oNogcvQ5sTzTSKq8LaJM+rfEtUXsDEm5Xh5/Bjob8jZD
 00D8D3SE+DqwZCGSzbF/33oY/hwFZlFDwbL+RYZL4R1i+O930rF8etf03W7W3jdY1gO8
 fwTVMbYHv6JyzFJ1czoL9Egmci+71LhzfA4r8SOKH7wkEtjz4ia3SDUQShBJF7dFJZtt
 ZNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgEfbh0FQCICGKJjMmg49vC5ixHepxfumenHu2paOXNB19s3xepfrENrzEUXQR/UJNTchau4EHJrvd@nongnu.org
X-Gm-Message-State: AOJu0YwwU/EUoCWeBM4jEWWUw34m+QAsIKJi4ferkzKr5LaTxgu2PAdm
 /OF+QiFHLzAQvq7nd/Z5kRd67qMgdiZ9kG++XgFu9IaUz/gWLvfoJyTBpoyIABYFFl9Z/glZvCE
 aJTTkafRW8h+dKQGrxAKrsoENwgs/R+eUMZya8A==
X-Gm-Gg: ASbGncsLHxGxf0/IrseQ9d2zMDboEVuSh+QuKTj5NTZlLA4658IX+2RsuGWUEWVYuub
 2DjzME1b3L+pSzB52rXyQt1dhuMMNX0Tg/cAmbfe8tyjA/bAe0BqtAO6TJT5091c/dq5N/zuBpd
 uMVSMV6Dl4
X-Google-Smtp-Source: AGHT+IHS6Q7iuU3S2eVklWSsBu42hijBhcZV71sMaYmfo+Hua8Ko7uugsQY7LfkjQJYssYhtPvElunzM0cMBHphQoZ0=
X-Received: by 2002:a05:6902:2484:b0:e5d:df2b:3b13 with SMTP id
 3f1490d57ef6-e5e2466eeddmr3263002276.32.1740162331081; Fri, 21 Feb 2025
 10:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-4-peter.maydell@linaro.org>
 <87wmdjgor4.fsf@draig.linaro.org>
In-Reply-To: <87wmdjgor4.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 18:25:19 +0000
X-Gm-Features: AWEUYZnGh1x1lMuI20asvT9Pcg8yCg1___Vm2MlNcBFXwueu9Gknb7oYMleXZX4
Message-ID: <CAFEAcA_UsSNGWUE8uzScepxQoPydd-=s2UpUeRxiN_WSdd11XA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] target/arm: Make CNTPS_* UNDEF from Secure EL1
 when Secure EL2 is enabled
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 21 Feb 2025 at 18:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > When we added Secure EL2 support, we missed that this needs an update
> > to the access code for the EL3 physical timer registers.  These are
> > supposed to UNDEF from Secure EL1 when Secure EL2 is enabled.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index ac8cb428925..7ec1e6cfaab 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -2387,6 +2387,9 @@ static CPAccessResult gt_stimer_access(CPUARMStat=
e *env,
> >          if (!arm_is_secure(env)) {
> >              return CP_ACCESS_UNDEFINED;
> >          }
>
> Hmm this failed to apply as b4d3978c2f (target-arm: Add the AArch64 view
> of the Secure physical timer) has the above as CP_ACCESS_TRAP. I guess
> because I didn't apply 20250130182309.717346-1-peter.maydell@linaro.org.
> I guess this needs fixing up for stable.

There is a Based-on: tag in the cover letter which will tell you
what this series should be based on if you want to apply it.

Yes, we'll need to either tweak this commit for stable
(i.e. use CP_ACCESS_TRAP_UNCATEGORIZED instead of UNDEFINED)
or else pull in the refactoring patches it depends on.

thanks
-- PMM

