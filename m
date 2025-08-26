Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B655ECA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 10:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqr37-0000DF-7o; Tue, 26 Aug 2025 06:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqr34-0000CV-HA
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:37:06 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqr2z-0008Ex-Dm
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:37:06 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e951dfcbc5bso3573359276.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756204617; x=1756809417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iTuOBvXWYGnmzTfB3cGveNb3IeH/u2Hzv8xTENHOBv4=;
 b=RQEqThkoLMfWi7osNB8oT//zREF2LYtzpZeVVjqHcScJ6d/gRa0RKja667RDH3TiBZ
 l+E+0zhv62jonXAdOEaYjaQFYJn4h/L+CvImW/O33UnspZsytJBf3tZD20okFw7lP3pf
 3vwrIrqOTQw0l5AVMXAtp047pLK3vjPEvF0tRL4ViHx/zMZlZIeq7VS7+2NhgutNKLnj
 sOcC4LHoIU2dCIOGFt2rNdGynRLXLeUuWW7ghbCHdh9eafahQ1bFB2/mCVxaCwHILAdw
 Uzsz01KwV/HrX0SqupuqoTZ9EWcaWzLVchVsGMS+Oc/ZbDD0M9mtGZxQQnOiXhQfUjMz
 sJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756204617; x=1756809417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTuOBvXWYGnmzTfB3cGveNb3IeH/u2Hzv8xTENHOBv4=;
 b=LT2+C6KYbOcTWwGqlW9VgsK35UECu6i7QRYqk3aatNP8UdJnnfFXxzyKVXStUtMZ1H
 iengHkQHXaKKQc6hgGXgQ/TI1lnEpDmoRdGjwXhlBI/zE0AvswaBx985x9F+RG+DBZjp
 Bi9EN86YnpxAdrlh1tXhh2r4+j1ac7uBW3ThEeHGiiLSJnuuwk3Ftnf++tt08lJhsIh/
 d2glReNTTWekHp+Z+HFXhA2Qsbynk8KG2VTR2xo8Kzn+/HImB7BG+iyp7kKzD2Yjj82M
 tutPra3/mZRLir/wEvLIPY9F5KntDRr7dkaK3PVXeJ/wj2PP0ut9ZmIAIcX7tI6498lc
 fo+g==
X-Gm-Message-State: AOJu0YwSJSkh/vd06HJw31jkODJsQe7uKPbSMCdXwtaesew70W+TeE3/
 ohR1NckZ3oA9wnQLM+9QfQfa2ydX+zPkMLLbXWFP7D5g6RLWXuwpVix7xyCarxUGoltkskI+4aC
 UbftyE7tofv87+2Oztw6WkBj+v2IKNk1BIWHDkr2yeQ==
X-Gm-Gg: ASbGncvWcdTPog/zmirhqMlPf2z1YHO6ihJTVh5Rwn38Lt1P0jbB2oujdot2y2XiHsH
 QH3yUEmq8SKQJIDqWmtoPM1/j/QuV0Nc75VpIiadePkRgo9WH0rklxphY2CSxQpUFO/7c6EGuzS
 iiZICclHCpN0ZvDptXL0JT7LrrdyiXpYo26prsTdnddVXVuL4vt5tYT7M5cwN/GWf8MpEfiLF3W
 DLhz3OIq4aExcGmL/U=
X-Google-Smtp-Source: AGHT+IEjy+X9YN1S6YFRMXFnEsMjBQAOannvdJI0poA6URPWCYXM30OW6688/wdDFbex8u2sVFIEQWZ3oBVzY+QeaN8=
X-Received: by 2002:a05:6902:161e:b0:e95:b680:3a86 with SMTP id
 3f1490d57ef6-e95b6804f4bmr8823995276.44.1756204616569; Tue, 26 Aug 2025
 03:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-9-peter.maydell@linaro.org>
 <20250815124005.6a93d35b@foz.lan>
In-Reply-To: <20250815124005.6a93d35b@foz.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 11:36:44 +0100
X-Gm-Features: Ac12FXxR9YYbJdX8Fg7-194QC14V1ctfR_Tbqafk_fDOGjXxcD7gdGX2ZeSnGtU
Message-ID: <CAFEAcA88f_G3OQNm5LDRTPyq4eQ3cNeAydAOE5sZqzMCw-TeSg@mail.gmail.com>
Subject: Re: [PATCH for-10.2 8/8] MAINTAINERS: Put kernel-doc under the "docs
 build machinery" section
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 15 Aug 2025 at 11:40, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Thu, 14 Aug 2025 18:13:23 +0100
> Peter Maydell <peter.maydell@linaro.org> escreveu:
>
> > We never had a MAINTAINERS entry for the old kernel-doc script; add
> > the files for the new Python kernel-doc under "Sphinx documentation
> > configuration and build machinery", as the most appropriate
> > subsection.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a07086ed762..efa59ce7c36 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4436,6 +4436,8 @@ F: docs/sphinx/
> >  F: docs/_templates/
> >  F: docs/devel/docs.rst
> >  F: docs/devel/qapi-domain.rst
> > +F: scripts/kernel-doc
> > +F: scripts/lib/kdoc/
>
> If you want, feel free to add me there either as maintainer or
> reviewer. I can gladly help you maintaining it.

Thanks, that would be very helpful. I've added you as a line to
this "Sphinx documentation configuration and build machinery"
section:
M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

(and since this whole series is now reviewed I'll take
it via target-arm.next with that tweak.)

-- PMM

