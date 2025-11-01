Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 10:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF9El-0003pI-OK; Sat, 01 Nov 2025 06:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vF9Eh-0003op-S1
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 06:53:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vF9Ee-00021z-PY
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 06:53:30 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-785d3a5f641so33134637b3.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761994406; x=1762599206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ymc9XmyDfzuq+hOcUZ7yF1V4vwQXEvI0gxFZVNLRPhU=;
 b=GIzAI+19HWbiClaROCW/9Y8TNstUF9CvfGYgoF8Aru5VlgFazc0LuXcTHV8Qptz3ze
 oY/Aakg4lC0Je64j40M9a1y1drJ3Du87BWUJkNCId5Fg9IxAkv2hMEwnFIjxBME0hd73
 hrXB0T1WpNeCgk7RLIkcF1qR8v5iHinkkx2Tr2Pxjx5vGw/FNf/pED/gz0Jg437uwBWe
 RxNDdErG9XosGvqWJlPojVYTLZyVOjM6ztO5YA1Z67pDU9RRfL3LHClvvu0gzrIHHwn+
 pwFpPyLACRfMW9k9T/I5yBQ6t/RZmuzUU/TAlJwv/V/tFsnLm0ZJT33+MMlIV/B6jXFL
 u1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761994406; x=1762599206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ymc9XmyDfzuq+hOcUZ7yF1V4vwQXEvI0gxFZVNLRPhU=;
 b=ZY9oFN/2M+GCYUD0sgndnTvubC5zP0yRQh6n4KZXpPS2vAnsmt106ev5pQy/gMfgTJ
 UAnbB9bxTRXCTIDm1zwTncCKSbyhIKdeODxC4QksUQjSK/IWPHVPsonmqE5gPXhoA74G
 XUhgX8kFfiTqOlYevr+HJx6gZo/avhbQrMb1HrmL3iM0KjCF3sH3iysuZdu4Kw4IpoSX
 kr8ktz/UUrpBKqBwVK9px82d/7jTqCcGGeBpUy/lPy/e0zE190MkDg7mHbQWqs6IX6cJ
 l/oCR/+htbIcLuPYGlaXTee7mGrIafGMuhgcaeGLBc8Brn7aMhYetwQkWkuwLF708JoM
 Ho3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7RexNy9xPCvhpGgPACaGb9Dqk8MH8P6Xd/yFKxIU/TmFvG3Mtxg6zV+gUa+5EhE1rKM+FsCLMXmJV@nongnu.org
X-Gm-Message-State: AOJu0Yw1UK1RmRe4atQFlT3XNcDlSTO2HNnDuW6pPtL2BA4ZaKKov05K
 M7zHTS4SyKlaYohzXQDfdj5sRudCO49Z4kwcOyKpURc8u//vPtoq5hsW6JV5ujJqqIXstolYif/
 CJh/t6mZ1+CSNHullEZQoIe4kJCpUyh2Cdq1Uyhx2QQ==
X-Gm-Gg: ASbGnctoKoBYwffyyW7WIufnH/JQ3tE2shZUpCOEO20UZaa8966ZMkDhNUOvewW5JSr
 X9A/ZdGe//1+R0hPlEBWJyOsxR2ZnBi27pOVD+8/CqBKdXyEP6CKu7+zEKW094wBuuAxeG9QVkv
 Si0NGn5ppZ2MdxinX7H9UUIsxVKNcV69z5bDtJT56GvqocQjungfgvLuAUm4SS3NgrEwMEpKiUQ
 0hRpDE/M5uxLcV2+watqrZHdpoo7axYne1ICSjsXq30oqUbvh3b9lMtbcK/rwVW/cwO03h8
X-Google-Smtp-Source: AGHT+IEvhMqjaYcXuU/ukEoE+ZJAasHPLhaDCUbA62r6wgAln8hltlvHhOkVz20OgEvGD4iX08wzEkYQ6oqmNVUW0Bs=
X-Received: by 2002:a53:d058:0:20b0:63f:7d65:747a with SMTP id
 956f58d0204a3-63f922be1b3mr4385212d50.30.1761994406197; Sat, 01 Nov 2025
 03:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251022001741.222499-1-richard.henderson@linaro.org>
 <82f3c305-bbc4-480a-9c73-ef4386e4ab3b@tls.msk.ru>
 <1f05a80a-12ba-46b8-9681-43e9331221dc@linaro.org>
In-Reply-To: <1f05a80a-12ba-46b8-9681-43e9331221dc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Nov 2025 10:53:14 +0000
X-Gm-Features: AWmQ_blIQwV2Vp23GfbZb8_LrHfc5eQsXN3KC6lrByWVQFSAYnRMpMTIL-TXYkI
Message-ID: <CAFEAcA-GH_2s77rhmWB=2UT7xR1zUFiNY_CVHG1s3hgayX3=Kg@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sat, 1 Nov 2025 at 09:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/31/25 21:21, Michael Tokarev wrote:
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > I wonder if we should pick this up for qemu-stable too (including
> > 10.0.x lts series).  It's a rather large change though.
> >
> > The patch applies cleanly to both 10.0.x and 10.1.x series, and
> > seems to be working fine.  Maybe it can be picked up for a later
> > release.
>
> I think you should hold off for now.
>
> > What's the implication of this bug, anyway?
>
> Failure to raise an alignment trap accessing Device memory when architecturally required
> with -smp 1.

We have failures both ways, I think -- the bug report is about an alignment
trap we raise when we should not, for a 4-aligned LDRD to Device memory.
There are probably also cases where we don't trap but we should.

But I think this is something of a corner case, so I agree
with postponing it for a bit, so we can see if it has any
unexpected regressions in trunk.

thanks
-- PMM

