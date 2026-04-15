Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC53FA0C30
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCtjj-0006CZ-7M; Wed, 15 Apr 2026 02:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCtjg-0006Bw-Op
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:28:28 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCtje-0004qY-72
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:28:28 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79a60975dc5so72509467b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776234504; cv=none;
 d=google.com; s=arc-20240605;
 b=Z9AphRvriVfZ438rvITVjIyLr89oJGZSJrRriuefcMWQGK6oPRbog/scVGsF3d/2Fl
 CkLxPXfAtGlXcIjBF24rYzuhHmEge/ESut+++yay+r9fKSr1YE8yzaBUTne8l2Dp5YDq
 gGbl2s4ToD+ErxmmhA87IzaZ5UmM23Z8o/Evs6/QSnVECv8o8f+7i2ZE1TTGfR4kz8lD
 1w1n86bqm1p5qniaCurGUQZCdZc6p/mGypSeq5K/9i07EOoW4OnBzM47n9T+FHuzfwWR
 FgKwvq2h53w3DwI3+09c1sxRT58MgaswMRBaDUlkBdYzIn3Xi7fITreFvaT4D77vtrFv
 LxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0pXMJYmyEc1LrSDdraoyNnODw4s0qtxGCz9y4VUwrIo=;
 fh=mAmlY5Klec4LSvKoayEMI3ZzjiPnDuQ++f3Dm55lTn8=;
 b=Gn5w55yabb1nLyf3hVP9/fZg79SwFKbSqX494iljWfqMg3sQSqLnyI6xWyCIbKGll2
 M/IcdsGiC8k5Szebd6AqT+zMR0NWSqh9ZDP4V8q9oYy1D97H2c6d1PzEgghWul7ZGik5
 x/0K6ta+iIhmHZan0SrKcTbHoAxk8Eyz9BOIdDnjuAJtlMzE2FTGmUYJohFKbjGTAIlW
 dzsHGWkWGwe0cUl2Eu+P0L1BUU10w7uNRJyQVwDqYKxxq/iWbulwkNjPpb2lC8E9QcXR
 Aau7xiqR55Ay53L3omMvMLXqrDYnxGjT/dwh4Cy8zL6Qnlz69iCUO6K7YJ2K6ia2Myl5
 O5sA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776234504; x=1776839304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0pXMJYmyEc1LrSDdraoyNnODw4s0qtxGCz9y4VUwrIo=;
 b=JKHSz+TyK90T+SPiz8DMA7YINTxMO1QYYISkc3dpPsxlL2ZJFdqEUoSoJ50BV3YuQS
 joRHq5mAkxhTY8Aq6DqsCVweOqpbJ7lfiT60H01/FJXj6PSBSfKY1Gze7zyEkXtfRUdV
 P9a/uuQM2h4qod+S6hM5XeiytOYwfWU1XJV20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776234504; x=1776839304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pXMJYmyEc1LrSDdraoyNnODw4s0qtxGCz9y4VUwrIo=;
 b=YsMXVUUjdJndV0REqWQ9H1TyFCBh//Q9SAAVqDLrMWNi6gawtyycJJ+1wIsAGj5TNM
 nzukyaGVU5Y8xBI7qYDf1YeKbQto1jawJL2r2u5T3utPoiuhvK3FjeiHyzkR0fnwJ6Nl
 qi+ifwSRxmTfG8SJEmwXDz94+JpwUmm+JALcC2O2qpVrC08LWLduxIhUFv9QCdsZSrcG
 dKIEICbtK+fh54tM+gwz9h6IBHaxQCWy/uct6NyfUS6AFZuCpHbzAASYocoIb3XwxjeZ
 iy1chY686WNOiTI8tbQc4FYGINht8eZ16icjejmDWbpId56qeT/fOp4i9Vci2amdxcZi
 tAgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CdsUvWM0o4BvNzovRh9yPAFzXYIwwN7HSu5ATTfal0y71Ef9sQVEfJBfOPSh/eJ907UzbXXq0Sphh@nongnu.org
X-Gm-Message-State: AOJu0YyolQHbdYwDPXXnx/w5WzJeye2j99uLNIjCZ9xEmV6/CKuzz2aj
 6JY+uzrnpYCWSsw3jcPFrUeoL1cDM1n7S/GZPC1m7IQwY09IF+Tfj2KMPYbkt/81k1tK2/zEDJx
 PfwquFsrbuNv85zN+W+gj4oViJPRdXXQ=
X-Gm-Gg: AeBDieu+5y8rapL1ed70xnzkrZNeLyqjoA7mHe1p/czmQq/KccB5izuJ+NthOk91BUQ
 rgYeJRf3k0WeX7Ta77tkBeTHaaPUjfollPXS68wNlnkYdt8luQ/Ynni31dZsYyzVPrbbzPOcDUr
 THKfmt4oTQJgZV4ZyfWIY71tHBAEPRyi9CCR4CP1lE3Nflu7LIrhDjWla1Z2dDS9gVxmlnAE70l
 B5Oq2Z4SKD0sNiQujYgzAKL1HqrPpU6Vbuy6wZFrCcYqq+S1NCWvmBy9ldxUc1q63PRy1hQgje0
 QemaF2Dj2Ykb8qqPLBYDm60GMwQJdjfYBVyLn/+ey+qzX6JOF+koUCyL4407pPMkKNwZ
X-Received: by 2002:a05:690c:e4c6:b0:798:cf16:1c6e with SMTP id
 00721157ae682-7af6fdf1dd9mr170353017b3.21.1776234504007; Tue, 14 Apr 2026
 23:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260109131657.396794-1-joel@jms.id.au>
 <20260109131657.396794-5-joel@jms.id.au>
 <66870d68-0d48-4c78-aa51-37c24a82baee@ventanamicro.com>
In-Reply-To: <66870d68-0d48-4c78-aa51-37c24a82baee@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 15 Apr 2026 15:58:12 +0930
X-Gm-Features: AQROBzCCTJ5jD326weSAfKXCROokZzTb1YHETYpzFf5CedtPG6UjIiuzsv6_hX4
Message-ID: <CACPK8XfimpPtVzfrmXNUVwtq5KoWAt=ipUcQg=Skw9sHOPPnwA@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/riscv/boot: Provide a simple halting payload
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, 
 Ran Wang <wangran@bosc.ac.cn>, Michael Ellerman <mpe@oss.tenstorrent.com>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 16 Jan 2026 at 03:25, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 1/9/2026 10:16 AM, Joel Stanley wrote:
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > OpenSBI hangs before any console output if the domain init code sees the
> > next stage is not in an executable region.
> >
> > If no kernel payload is provided to QEMU, the next stage address is
> > NULL, and the riscv virt machine memory map ends up covering the 0
> > address with the catch all S-mode RWX region and so OpenSBI prints
> > console messages and does not hang until the next stage boot.
> >
> > The TT Atlantis address map has RAM starting at 0 and it loads OpenSBI
> > there, so it is M-mode and not accessible by S-mode, tripping the early
> > check and hang.
>
> Please note that these patches were split from the main Atlantis series,
> meaning this patch can land upstream earlier than the main Atlantis
> board work. In this context, saying "The TT Atlantis address map has RAM
> starting at 0" makes no sense because there's no Atlantis board in QEMU.
>
> I suggest adding something like:
>
> "The soon to be added Tenstorrent Atlantis board address map ..."
>
> To make it clear that, as far as this commit goes, we're talking about a
> board that will be added in future.

Good idea, I'll re-send with that fixed up. Thanks for the reviews.

Cheers,

Joel

