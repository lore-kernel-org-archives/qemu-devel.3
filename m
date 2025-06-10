Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECFC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29G-0006jM-6T; Tue, 10 Jun 2025 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOzV2-0002uw-1s
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:58:48 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOzV0-0001XH-4C
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:58:47 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e77831d68so52077367b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749563924; x=1750168724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tn5YmeUOssp9njr5/DLp437/HWWmTrAYEkvk2kK3IbY=;
 b=m7uWBcTVUZib2i1fALHMDMahRUsZIqyJcf0IFEV1XQmKa181MJRIvPi/nWRHdEPIIi
 NEQ1WW4RVe1I9CFtq+E14KhRQgXBRmKHdzS6iJ49CMmq+kAXxpSut7yyIzO0skbwjno3
 9RNs+R+AsEFDv0dJJAoZjnGkXikOaJs3sletm6psODvMh/HN3+ugyBNomHGrFMTutEuK
 AeiruFmRITmOcbn8MSNxoOSAQKqp7yQn9vw3b5nGK3JCY1s97TTdG4vQQEqjAPRn0clt
 4mHk1SzEe/pSvdnJG27kuoF75E/Hx81zXzFNWS0cAbaaVZothVpihHJMyfOLM+I1jORw
 qOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749563924; x=1750168724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tn5YmeUOssp9njr5/DLp437/HWWmTrAYEkvk2kK3IbY=;
 b=qkHmzcWyBt8MgbrGIhRPAj1H7632XPNMj0CkUIaOrcS4aU65TEKGIHenEkHQYQj1rQ
 frPoQhlIW9DgOzIQFNve1N5hx5ifa7QedLtykyYkvQ1yit3mVxlcdJEhdvN5VB5bvUSx
 hbTepnrXdGBcZaf6b2Vxp08zHEWf7cygheKj2GSL2ySSIkJ7QfTFPKBS5OdNoPWXl1J/
 2wQ2JRjZlFqA+SQLNmkA/4ne7wvjeLaUukwoB60LJ8ZRp0X30UCYvICfPa1SUjxhrApj
 AmXLyAiRMpSzkQbeAUJ07KZvT/WmWTbSM3fLOskse/drzWVG8HNadkU726SshjqtGEvI
 ms1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz3+fuzJPkbw/0jENrNxRfohMfkXlf8pSxededIJ5l5JqibNStd2Oqvqm9nmLEAHVxXWQGvE6eNL1i@nongnu.org
X-Gm-Message-State: AOJu0YxDjLfmrpTnnRv1Jt2nH70IoCXhHq+5to3OCt4fCAqfOkvwSy+D
 RFvwuwuNeDw2YmuhCxlendLJNS/VU/FL6jfrYar58DuthxvudkM8CMz+Pi5ERWD+QIxhZAZpcdM
 49L/xVQQ948pMD8s0BAramQIYI9kzwcAAvdXkGrHzJA==
X-Gm-Gg: ASbGnctnmRtqwl/7SjNZJxSF+1u+Df3g+cNVHxu8G9YppCt+4lOxYxSAlMUBeKjM+m9
 aWsqNiYhdGZOaaWojZYrDgxivu6C1W9vQ0uXaNYpRFC9QP3PZcwqcuDsVIo6hbhl+QzvuFYbIay
 vAvMafrgqkDKrTir+01m55U3nbtkyY/FZrKH3Y/Qy25USJ
X-Google-Smtp-Source: AGHT+IHyI/gYx7+Y/KXYz0D34FrpiW6RdQEgX7kEcxXdXIFwqUuRMpUUFlr6Tx4Ugj4MJeHvRqoqQ4EBpelXgyW1SKY=
X-Received: by 2002:a05:690c:1c:b0:70f:83af:7dab with SMTP id
 00721157ae682-710f762d432mr220003697b3.4.1749563923702; Tue, 10 Jun 2025
 06:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250610012851.1627715-1-linux@roeck-us.net>
 <CAFEAcA-aznHrcSk9xfmLHkpJTiabjd4oX2KnvC5TXkkLgW6n8A@mail.gmail.com>
 <50464a50-1ddc-410b-bc5b-ec68b895b797@roeck-us.net>
In-Reply-To: <50464a50-1ddc-410b-bc5b-ec68b895b797@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jun 2025 14:58:31 +0100
X-Gm-Features: AX0GCFsUd9430EAQHL8DAZPHE2TpbvRHRYfiYqun59rrgCCqagK1Fn99e1MNJAE
Message-ID: <CAFEAcA9CWeEmrZ5vTr7M-UZfH3cp5Y9EZUeGPfc2s75Tz2-K9g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm7xx_boards: Add support for specifying SPI
 flash model
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 10 Jun 2025 at 14:31, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/10/25 01:42, Peter Maydell wrote:
> > I think the question I would have here is "is this the flash
> > device the hardware actually has?". If QEMU's using the wrong
> > flash type, we should fix that. If QEMU's modelling the right
> > flash type and the kernel doesn't implement it, then that's
> > a kernel bug and the right fix is to get the kernel to
> > handle that flash type.
> >
>
> That isn't the point.

It is the point from my perspective. This board type is
supposed to be modelling real hardware, and therefore in
determining how it should behave we start by saying "so
what does the real hardware do?". Adding extra behaviour
that the real hardware does not have is something that
has a tendency to lead into unspecified, untested and hard
to maintain complexity.

> Yes, one is that qemu's emulation is broken, the other is
> that I wanted to be able to test with other flash types anyway. I understand
> that this 'violates' the idea of exactly emulating some hardware, but I want
> to be able to use qemu beyond that.

Why this machine type in particular, though? You say in the commit
message that aspeed lets you specify the flash type.

> Either case, I did some debugging: For flashes with sfdp data (mx25l25635e),
> qemu returns bad sfdp data (at least with quanta-gsj), causing the kernel
> (as of v6.16-rc1) to bail out. For other flashes (mx66u51235f) it returns
> no sfdp data, but the upstream kernel now depends on it.

That sounds like a bug we should fix. Would one of the Nuvoton
maintainers like to take a look?

thanks
-- PMM

