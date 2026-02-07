Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1760EEE0AEF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 17:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vomHt-0005uc-RC; Sat, 07 Feb 2026 12:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vomHs-0005tx-9p
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 12:40:04 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vomHq-0007Dc-Ih
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 12:40:04 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-794f701a3e6so30543137b3.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 09:40:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770486001; cv=none;
 d=google.com; s=arc-20240605;
 b=aE5z3xsDbpxEQqPaGOWV/8uA5MFOWScbABaj3VakYXVXAOhRr9TKFs1FKPd0FvsG97
 5wGxfo0iclIFpZL5+vCV1AlH7ayXQoiUJ8bpCgOUK7gkz4GPwZYn7OB1wbFwKv/15KtP
 zNHpdXMw/bV30KQZRaALhsfpB4Kv5XNumvIiUgUZ7LivlAaLugXOh3T2Jdc4ormAOCXK
 ex9MPyp2DtS614rryly6KFDBlWFpJZLkYTBPvSY3FM6I+YqtC7EqgXWwLy2dDJB1CSUD
 HojfggaUYjhln7aYoe37c7pXRI7uJHCFJ9mf9xIWW42D0O0PANkgtGdf8wczQlXpbf7R
 fcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=29WB7zZXjLjBP/uVYuh5X/432rmm2UDKkA4Yr82QwaY=;
 fh=4K+h5x9go7ApuLQDfQifwDquWyjO4cvidf25ma8RBTg=;
 b=QzP52JPsk/xnr/l+775WD3+iA7FdLib8MwUoPMaU1N+FE10Yt/tJw82cZe7QvSJ9m8
 NHnvsjLDiXNRpLrdwGyrSUIXldUPR0AqnPOuBwlNzzhPpsOaoZcesq0GHkqI/qTxyEi2
 mi7PmSlH7nz8B36C5R2UaRTm9p5nj8uxHNBgkZC0XIc9wG1gu5U1QFxK37JYhcOOe4f6
 BOXZufPYOQXtMSeYVRCw1Vx71LvRQCoNMYyhMJC6tz/9Xf/BcMZnwVsYI+hqVlK7OXZ5
 /Nq9cLF2qorG22XXZqZF/gw/rPj2otTKot6R/OIWflFHS4dMHjw3bZgu14UqaxrCf+7M
 wuNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770486001; x=1771090801; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=29WB7zZXjLjBP/uVYuh5X/432rmm2UDKkA4Yr82QwaY=;
 b=ljeRtx5nEIC/rZNi/Hscl9vQ/FDFHmbH2Frj+Y5swCzk0NtVKExSj4+D4uM2bEU6pN
 gHNqbXgXH2vNJF8NGduvx365d6j4uVY9IBj6gnM3beZqZPxhSYZhdVVygND9Gr4GAijB
 tV1oHqFZCDhytqHgB6bFHiffWttgoxrBuDJEW7rLk8jzPuasEXCETuYnN/DjgsYpdsNC
 5g+Mrfs1RyAFwvy7Agrb1GGuXnAMyYZWy2WyfMP1u1GcCBoPFxdVZi2O11FU63Inb36E
 zXEXd0tlqjlQzZXvP9n5LZEhwhUITGEuKDs47dByPOp2AvhQCW3Wkc/xHpR2Ku3/DuvG
 rAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770486001; x=1771090801;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29WB7zZXjLjBP/uVYuh5X/432rmm2UDKkA4Yr82QwaY=;
 b=ERCxyfYLL+9AamJ+R0XHQcmELNhbKrDO0f/vt0ZCWRJUb6sNC6WY1b1qGe6/A1pTpf
 O3TzJj5Waplh5AH6V35mrUc5hx4I97+ZX8YN54dS0IiAz68lFoEPef6B+uk/gQgbKxOj
 9P649DFhFQxKBaB5ctuYFaTRKSXFn2FZjURMSDLSYmN05S9xqwdjsxpHLsqgXOHf79Ug
 IID6sbilFP2fv8xBVsj3x3/86ZjxgzHeyqTpfsM2m1pnSEi1kmvR9++zz7VZIy/lAbXB
 jUMZD8mNAKvC9o840r++x8bCCvTi10P7XUs0yAk+qeqcT+j6U3DH6SCCEmlYS5WJOqml
 Sa7Q==
X-Gm-Message-State: AOJu0YwfRPsWTAOMLFDM0aWUnK5IdeYwz9y2mxd6XfEERKEShQ5qz8+/
 yxUEOtqF8zTfkpGhxpqtdCe+fzs0ig00ZvvJx1nboXq79Mc2Mv3I+7IIcCasDFmLy1RgfmPb6Pj
 3UBYswsQaSqZ6QfTSj2q8/8w6MGQKsl+RzCSSEMB5e0d3QyUxGNQQscA=
X-Gm-Gg: AZuq6aJTvMWg1UXF5WcB4Ofqy3NK34mG0u84hnny84sZiQILESebnu7px6ipUmo74Gz
 LU2B4PrVh9WDcOqmSdZON58mBfDrNU3rYM2y0QdadCaGt05KK1UnY08kbfStMG6EnvZ1Wuoo2zM
 oiUF91Z3Vd2sBNxa/CFu/mQF5MBEimi30lnK4xqXy1ve9mSNVh6xp3Q0qd587q5vwv671iOdPnb
 dfqwP2Uc8msQ1ydUR5bbCpcFkgOOqPTvogI3DH2d3DNyRynTrijXBOGDjd3YjqzX3+dvnUHAyiD
 gDj91KRrcAkJcNo6D9t56DnREdto+FpVKXeSXKI+UWV3fINyDhDZIY8=
X-Received: by 2002:a05:690c:6501:b0:793:a3c9:795d with SMTP id
 00721157ae682-7952ab71be9mr57406727b3.59.1770486000871; Sat, 07 Feb 2026
 09:40:00 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Feb 2026 17:39:49 +0000
X-Gm-Features: AZwV_Qhidlo1tVLhzwFoui6OYvrGO-j-Tj1ThJXJOBxLeBtfWzn2h0_7QR3esmw
Message-ID: <CAFEAcA8M6AL1xQsiiS1f5nA4XVV6n6mOhi1T3QWfhLb_01+8Tg@mail.gmail.com>
Subject: handling of non-page-aligned addresses in get_phys_page_debug
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

I was looking at a reported bug about semihosting when the MPU
is being used on Arm CPUs:
https://gitlab.com/qemu-project/qemu/-/issues/3292
which turns out to be because in cpu_memory_rw_debug() instead
of passing in the vaddr we're given to get_phys_page_debug() we
first round it down to a target-page, then translate it, then
add the page offset back in. This doesn't work if the target
is dealing with memory protection/validity at a granularity
smaller than a target-page, as the Arm MPU does.

I thought this was a bit odd, because the Arm page-table
walk code will happily translate a non-page-aligned address
for you, so I had a bit of a dig into our implementations and
callers, and we seem to be inconsistent about whether you're
supposed to handle non-page-aligned addresses here. (By "handle"
I mean both "can take a non-page-aligned input" and also "the
resulting physaddr includes the bits for the offset within the
page and has not been rounded down to a page-base address".)

Implementations that don't handle non-aligned addresses:
 * alpha, microblaze, sparc, x86, riscv, s390x
   (but riscv only because it explicitly masks out the low bits
   just before returning the physaddr!)
Implementations that do handle non-aligned addresses:
 * arm, avr, hppa, loongarch, m68k, mips, openrisc, rx, sh4,
   tricore, xtensa
Implementations that were too complex for me to determine the
answer with a quick look:
 * ppc

And at the callsites we have:

Callers that naturally always use page aligned addresses:
 * hw/i386/vapic.c : always uses page-aligned addresses
 * target/sparc/mmu_helper.c: uses in dump_mmu() are always page aligned

Callers that assume non-aligned addresses are handled:
 * hw/xtensa/sim.c,xtfpga.c : we translate ELF program header p_addrs
 * target/xtensa/xtensa-semi.c
   (these two only work because xtensa is in the "handles" this group)

Callers that do some kind of "work around getting the page base",
and mostly-work with both:
 * monitor/hmp-cmds.c: in hmp_gva2gpa we round to a page base then
   add back in the offset within the page
 * plugins/api.c: ORs in the low bits, so can cope with both "get
   exact answer" and "gives page base"
 * target/s390x/helper.c: s390_cpu_get_phys_addr_debug is a wrapper
   implementing "give actual page" in terms of cpu_get_phys_page_debug
   by the usual "mask and put the page offset back in" approach
 * physmem.c: cpu_memory_rw_debug rounds to a page base then adds
   back in the offset within the page afterwards

Looking at this, my feeling is that we should:
 * define that these APIs must handle non-page-aligned addresses
 * fix the six or seven implementations that don't (either "properly" or
   by adding in the "mask to page base then OR back in the page offset"
   code to their get_phys_page_debug functions)
 * clean up the callsites to not work around the lack of handling
   of non-page-aligned addresses
 * add/extend the get_phys_page_debug API so that a caller can get
   the lg_page_size
 * fix the cpu_memory_rw_debug vs Arm MPU bug by having it use that
   lg_page_size to determine how much memory to access at once rather
   than assuming it can read to the end of the page

Opinions ?

thanks
-- PMM

