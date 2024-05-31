Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B1AC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3As-00063X-P8; Fri, 31 May 2024 10:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD3Aq-00062j-M8
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:24:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD3Ak-0005GK-VB
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:24:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a2f032007so1493880a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717165437; x=1717770237; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BgV2AxDdm9z9k+cfkTr7fV4K0FqXPSon1KrwvWC1BpI=;
 b=p6GK/1RQHlYMuzBl814NnWr+3rcIsP35+ul0AJKb0KSW+GT4J5GDIXubFTSzRYxYoj
 7lHo298/TeVckyxJvm9ZI1S5DmSCJW93rRCeHcE5x+eoOZeWIl/G2lIQDgmVyhNTSAUV
 YtNbTyLdL9xqfSqVHYUtwzQPBNNzej4xLnv7EetEu/vG8/Vcg6SUjlbIskVAAWenUeCL
 Me9Nx/ausF2y2eZ/OhfPrs6C3Bmao/ALQUi4LUkpd4LMWptZiw9c6plZ10nTykB5vWOL
 cDS9rDVuzne0JK6vAiT7tfq46BcwsRH+4PfJK0Wqwg0eMxVEUgB45J2w3AiRUKliFvx5
 X8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165437; x=1717770237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BgV2AxDdm9z9k+cfkTr7fV4K0FqXPSon1KrwvWC1BpI=;
 b=Sg+C8T08hstabT1sFzAJvSi16sGfjFuUOgoqMGi+bgQWHQOzA10O2Em8Qh4SHMsl7G
 HWOGDt0D2RGvOs17rrDqntSfMieIetdmHz2U+59mtvO+/qbwdJ5u44Awq6loYPVbLWZe
 +gMhBCA9/9HgOqASidW/YzpMVHCzWqGlivOvEl3jR9es9m+2reqTaIosZ+DsEOXjvFQW
 R3kPkNehwuR/a5v/qO4VsXF4cfSBjWSNU6rQB+3skIyziAoucPszfgOC+c0XIjalcSTb
 PHaKJoFqZwHcoTt5PKbVJEqAtMjNzek8ve6qBEV4qZEqKBXkXgu08JiS/lRpyFuXMpdQ
 j9Cw==
X-Gm-Message-State: AOJu0Ywd7OjZi3pJGhrgAYzduti7WCKwYDJKrF5/DmB1y9IuWJ2BndZa
 6QpD3sR25wjneuM4SG6ia2id0E+PgIOXFMyvKnzG3f3E55GWUNR1AS3WUUmbFAw++7vmhmD3xhl
 NPbzI0va3uKnEzlVaWAhv6dNABczPkBLCYVLK5g==
X-Google-Smtp-Source: AGHT+IHzyJY/AKv94cXJAGi/T1bsW20WN08vY7ecaXtjQH0QYtRQWAQi4797BSbwDGMRRt0qz6vWtcQTcwSUc6l/2r8=
X-Received: by 2002:a50:aa94:0:b0:579:d01e:bc4a with SMTP id
 4fb4d7f45d1cf-57a363af868mr1136808a12.23.1717165437176; Fri, 31 May 2024
 07:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <CAFEAcA8-wh=0Fr75ZgepGAywvOhH=UfjkwxbD7=SkwR7Qyf0Aw@mail.gmail.com>
In-Reply-To: <CAFEAcA8-wh=0Fr75ZgepGAywvOhH=UfjkwxbD7=SkwR7Qyf0Aw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 15:23:45 +0100
Message-ID: <CAFEAcA-cY9A2rcqADV3OiNy6uA9S720sskOM_cS1A5BmYzbwYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework x86 page table walks
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, dave@treblig.org, nadav.amit@gmail.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 31 May 2024 at 14:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 24 May 2024 at 18:08, Don Porter <porter@cs.unc.edu> wrote:
> >
> > This version of the 'info pg' command adopts Peter Maydell's request
> > to write some guest-agnostic page table iterator and accessor code,
> > along with architecture-specific hooks.  The first patch in this
> > series contributes a generic page table iterator and an x86
> > instantiation.  As a client, we first introduce an 'info pg' monitor
> > command, as well as a compressing callback hook for creating succinct
> > page table representations.
> >
> > After this, each successive patch replaces an exisitng x86 page table
> > walker with a use of common iterator code.
> >
> > I could use advice on how to ensure this is sufficiently well tested.
> > I used 'make check' and 'make check-avocado', which both pass; what is
> > the typical standard for testing something like a page table related
> > change?
> >
> > As far as generality, I have only attempted this on x86, but I expect
> > the design would work for any similar radix-tree style page table.
> >
> > I am still new enough to the code base that I wasn't certain about
> > where to put the generic code, as well as naming conventions.
> >
> > Per David Gilbert's suggestion, I was careful to ensure that monitor
> > calls do not perturb TLB state (see the read-only flag in some
> > functions).
> >
> > I appreciate Nadav's suggestion about other ways to pursue the same
> > goal: I ended up deciding I would like to try my hand at consolidating
> > the x86 page table code.
> >
> > Don Porter (6):
> >   Add an "info pg" command that prints the current page tables
> >   Convert 'info tlb' to use generic iterator
> >   Convert 'info mem' to use generic iterator
> >   Convert x86_cpu_get_memory_mapping() to use generic iterators
> >   Move tcg implementation of x86 get_physical_address into common helper
> >     code.
> >   Convert x86_mmu_translate() to use common code.
>
> Thanks for doing this work -- I like the diffstats for patches 2 and
> 3 a lot :-)
>
> I have been digging out from under a big backlog of unreviewed
> patches, but in an ideal world I might get to this next week.
> Hopefully the x86 maintainers will have a look at it too.

PS: forgot to mention, but if you eventually send a v2 of this
series, could you send it as its own fresh email, not as
a reply to an existing email like this series? Patches and
patchsets that are replies to existing threads tend to get
overlooked, and our automated patch tooling doesn't spot them
either.

thanks
-- PMM

