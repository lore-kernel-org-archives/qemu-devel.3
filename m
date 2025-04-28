Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39615C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NtT-0002eH-Pv; Mon, 28 Apr 2025 08:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9NtR-0002dy-Aj
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:47:29 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9NtN-0001yr-Pg
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:47:28 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e733a6ff491so929730276.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745844442; x=1746449242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgkeaH9Wvr3SdTJnXpmBgXX3ovTBm5XK+7al14CaMzA=;
 b=XP7Jy7AmVK9fqQg/B5tNqsNmHmFyJc9mxiDtRhhdI0T8b00CSZhrO2WHPCntmtmg3M
 DUHFd0HxOxZoz0Bnf04PtEhffWIEnD7hCTCAjd1rtDnIwRMRR+nCWwUPEJ7YC+j1lTED
 5xtX/HfwybvHjPWIcasY8cPY9yi1LapfIJ+wLnhPC3R10GOA4Uxd9fYItYcvP/A9C3uc
 rQ6ESRaxEXtSEtY+iAFN8mNjewQKAzWiUZeb4uSvQsObaq9mESZ5dc4WpUz54G2Z+yXn
 vxI5ztDjSggW0vlwAshOAH0nImjcfs+yDffVf4l3N/nQnEKap4mPGStVck23yzciRldU
 FqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745844442; x=1746449242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgkeaH9Wvr3SdTJnXpmBgXX3ovTBm5XK+7al14CaMzA=;
 b=MdITkhjZDqFXpjxecGwUvwn2P9QKE1EMqdokZ0MDZnU3zbQkBWFNLtuVJ2YZRCdUN0
 cyqR2Qtcc2s1HxDb3MASLCnGSbudiAyuT9BwV9VBGl90JwEfF+uf9m2bvR4+ul5gRiZo
 17qSJH2cIFWwGzMaeM/a+jEFTGl8PvUIjsruq9Sk7Ltvb5TFPy6NOi4rqaxoqODwLhrb
 PFlDGcTNqpTt8/nrFZlfRghQ3bsZWwZdcEgT6UQNd6byBTVkZsiU45zC3+Ol3DUz4Ki/
 CwDrWNKSeNuJvn+FopoNBsRTUFn4K7LLlhSNxLIIIyn9J+Ct1W132fPTFuuWA5Mr2PvM
 vxEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXibuK0EJgx3YYv9CuwezKfjKEaeijpSqVnqb/nAcH2zR53qUfCPavRulzzYBhrmtOa1l9qZbApFvkj@nongnu.org
X-Gm-Message-State: AOJu0Yy776J5IPj3VBwBuevYejlynsBWfW1DEEYKe567THcf6ZED2L0f
 ApQ2TkFap+0huAWOzYVo45f7erlEmuERsAzRK2Jmy7YNM1nBDP30SGh8nDoS3W+sv5OCRogt7ik
 Bv3OAKXRD1ectOIZWmSyARfK7UAW6DJEx4ArS8PPt9BeTe3Fk
X-Gm-Gg: ASbGncv+SES5jLrtYVTGCbnm/Z8zPKYFwaHv4EEdt31fEaeullnYNT8Pmqtz/SK5qf7
 7zoghHisQpwnJEW0eYIU7OGtiolVwyxi5d18Yz9zfq8M9+WZWK07NDttLCHNQx10+v5y+kCjtEP
 on+thFHRqjhzZOyZMNDJ2jaMk=
X-Google-Smtp-Source: AGHT+IEZr8FTbNBcqOHw9aEIXQsd1Ik1IWRkAzwblSvK1e/PMjsHhZX0kmqNYU6rd6jKXLF4NWeuqHNVZiTdxxyO5PU=
X-Received: by 2002:a05:6902:20ca:b0:e73:1812:88ec with SMTP id
 3f1490d57ef6-e732336f56cmr11563214276.11.1745844442169; Mon, 28 Apr 2025
 05:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
 <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
 <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
In-Reply-To: <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Apr 2025 13:47:10 +0100
X-Gm-Features: ATxdqUHMhAv_DH3jeMjZ9-CX81MkeGQd34Ve_bPeyW3o0dUNGPxTfV4ygvCvqdY
Message-ID: <CAFEAcA8i60Ydeu+rpVYdRbDkMRaQ5EPmzAbBNsMHWq9Lr3FRaA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: Zhang Chen <zhangckid@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 24 Apr 2025 at 09:57, Zhang Chen <zhangckid@gmail.com> wrote:
>
> On Thu, Apr 3, 2025 at 10:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > On Thu, Apr 3, 2025 at 2:43=E2=80=AFAM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > >
> > > On 4/2/25 06:54, Zhang Chen wrote:
> > > > Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> > > > is mistakenly set to the default AARCH64 target.
> > >
> > > This is the correct backward compatible setting.
> > > In essence, it means that you *must* supply a -cpu argument.
> > >
> > >
> >
> > If the "-cpu" is required, the VM should not be started without this ar=
gument.
> > If yes, I will skip this patch and submit another one to make QEMU
> > refuse to start without this parameter.
> >
>
> Ping... and let me explain this status, it is not just for the default va=
lue.
> 1. The cpu type "cortex-a15" is not the correct backward compatible
> setting for AARCH64 target.
> The ARM cortex-a15 is a 32 bit CPU based on ARMv7-A architecture. It
> can not boot for AARCH64 target.
> For example, the Apple M silicon can not boot with the default -cpu value=
.

'qemu-system-aarch64' doesn't mean "I want an AArch64 CPU", it
just means that you can select AArch64 machines and CPUs. Almost
all command lines that work with qemu-system-arm also do the same
thing if run with qemu-system-aarch64. So in this case,
"qemu-system-aarch64 -M virt" does the same as "qemu-system-arm -M virt",
including the CPU type selected.

The Cortex-A15 is now very rarely what anybody wants, but we
keep it this way to avoid breaking existing users' command lines.
(It works fine if you pass it a 32-bit guest kernel.)

thanks
-- PMM

