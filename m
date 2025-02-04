Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C08C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMZm-00044S-3e; Tue, 04 Feb 2025 12:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfMZk-00044H-EJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:19:04 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfMZi-0000tH-9l
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:19:04 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e573136107bso6250923276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738689540; x=1739294340; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9INYqlZIyCrQudkG24InN/eYRU0LL8MU9pjYpr0PuMI=;
 b=B9YnKNRUNhmpEIaT4Lq5MfCv5ZH/ba7q7HZwxFBMIA1uggQMxAmce5qisDaLiTaEQK
 fFtQet6sa1e6JxbvmRtDI6pFKrADOsXh2XRiedl+uR/T4LbAhpKfEiRdFkEuItRamDoL
 doEh/3lUtnsDdosL5GKK55U6BzsKwyPkLdX1Ym/EFdyIGD+wnPPisXo5hraJoDIMibpz
 hZ7XXwxXggbEljumoIcEvOUtFEiPQBOXqIZy1tzE1WY8euxyPxQ32+GmASy6YUewZvLI
 DfJamfnUBRULi3WigAk3M4+F+HZRWNrd7uGhRVqU3lnmF2IcCvSX+TNobNrMI2x/9Les
 qWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738689540; x=1739294340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9INYqlZIyCrQudkG24InN/eYRU0LL8MU9pjYpr0PuMI=;
 b=t+L5aa1FS3sdCCUUTzz33x5F38+LB1u/weWkZGqMtxY1l37S1DbzPMMZC47Akj+Hn8
 NUEak7r6G5iPD9r87TDeq589mmh70rrLwoyKe6YaRT4HFNfNcOh7ceDfmkFvSII9qKVE
 1UbnIZcea2r25XL0JIKGS0yeRO3p3kzTPzhzcPPpjvvC0RRlkaBwe9Nif2DHwjygsivC
 9PPZkdYKaXe56yjeXccu5NJri3rjYuUhmc+783UrlnpcxxE5cZ7cUbDImQhTIW/egr2q
 6qwAtqxY+vuoC8C7U/9xnzRKxYIHPUA1jCXd5RAa14dUIvhK0kDjJSr4FuakXsXJTXbB
 XSpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyNU3tGNTXNryPeaA2tv4PXZ/t5Aib8km75tlgE90qwWq0hS9Z7xqf34/68Vha5xvDUJqzZquVLs4d@nongnu.org
X-Gm-Message-State: AOJu0YzZMYYl4W8ywa9hav/WTPcbmHI8wJJG62reDVmJJNP1kEObF6O8
 kKCIIHLFdS3PU/bj/Zchgbtx5qsAhqxZqU3dSPpSEchbFAGOt8P09pPuWdg0IfIBXA7pRe/1ON0
 0S5fmsJMBd5ecN1eOK407V7Wsbx1Gkj3bzCxmZA==
X-Gm-Gg: ASbGncu7q+Wd1WLvNBoGyhzON7gJer1BExfb2b4S+JywldOfzHWEKWJsWCl2n2FEuyf
 l/leMccoz5WdC21BpRrTMj1EG7ppWeCPCw6jRArrOgl+ghjEY/HTdhg7zvj2ppcnNL56ohprHcQ
 ==
X-Google-Smtp-Source: AGHT+IHjiagmPjEJujKv5RNZDTzZuEPkvDn1JZM2Ma241bp+KTDhm4aq+UT6m10bpPZVYyysj8ODR7EPuTiEp5OydT4=
X-Received: by 2002:a05:6902:118d:b0:e57:fb63:f926 with SMTP id
 3f1490d57ef6-e58a4a9c321mr22026856276.3.1738689540610; Tue, 04 Feb 2025
 09:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20241011193140.1047648-1-raj.khem@gmail.com>
 <Z1MjS9fmqO4SLwli@redhat.com>
In-Reply-To: <Z1MjS9fmqO4SLwli@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 17:18:49 +0000
X-Gm-Features: AWEUYZmaIDHl49T6XvTFHEfe2D-qmdcHbe7pl2zZ84O6OuxZ65N-E7PwcqYeWKg
Message-ID: <CAFEAcA94zmWNcNBJ_0R1n9Lp-xDS69kZSRw5c94uT9ydK1o-BQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched_attr: Do not define for glibc >= 2.41
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, 
 Khem Raj <raj.khem@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Fri, 6 Dec 2024 at 16:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> ping: this patch hasn't been merged for 9.2.0 afaict, so I
> presume we're broken with latest glibc...

Whoops, yes, we dropped the ball on this one (and now the new
glibc is in Arch Linux, and a user has reported the breakage:
https://gitlab.com/qemu-project/qemu/-/issues/2799 ).

I've picked up the patch since I'm doing a target-arm pullreq
this week anyway (and added a cc:stable so we can get it into
the stable branches).

> On Fri, Oct 11, 2024 at 12:31:40PM -0700, Khem Raj wrote:
> > glibc 2.41+ has added [1] definitions for sched_setattr and sched_getat=
tr functions
> > and struct sched_attr. Therefore, it needs to be checked for here as we=
ll before
> > defining sched_attr
> >
> > Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0
> >
> > Fixes builds with glibc/trunk
> >
> > [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D21571c=
a0d70302909cf72707b2a7736cf12190a0;hp=3D298bc488fdc047da37482f4003023cb9ade=
f78f8
> >
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > v2: Use SCHED_ATTR_SIZE_VER0 instead of glibc version check

thanks
-- PMM

