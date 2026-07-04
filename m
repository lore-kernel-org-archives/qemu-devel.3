Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FCFC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 03:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfqy1-0006OL-4i; Fri, 03 Jul 2026 23:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfqxx-0006NQ-Gx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 23:22:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfqxv-0004wz-5e
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 23:22:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c88973b6965so1632235a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783135368; x=1783740168; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mx+KQQuIfqPu/Tv5czRYZc4G5HYqgiOoLgIGzdshTxQ=;
 b=BgRk6peF5MlQECVlG1MLMllALcRWjImItjf9zbz/N3jzWwd+z2uxCR/iZrf//YqXmJ
 uWb/hsR2WZtLbUZ++G8JhO3yPhTWPaXC1z8V4e8Lt7ElUzYlb4XeaMEyPvEahhNPIB95
 fHcPpQF9uFk5QOco4PYC+QrNSi6NGikENcw0b/oLHHYMmKrvkvOOgqV/MQiWqg6CP0Ua
 bClziGz5X/BUYAzZrIe0EjVC15b5r+Yt5I+giAcnfUVSL30oJHWfXG7982vj2yShJRiE
 b2VtrEucmy73K4LTOxefj2tC3Zg4anFPwhuFD/qFwbZvbIYmjyS3rBkoKPrBdeQMn16E
 15kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783135368; x=1783740168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mx+KQQuIfqPu/Tv5czRYZc4G5HYqgiOoLgIGzdshTxQ=;
 b=rxyhx3Tcn7OO8JvosbRmwwNnPPIiyLbnvdGiF+ZZV9j451lt3JGwjNGb4FuBNoLXmR
 63JRLM/ct7UeU9GEa1OMcjcF3VTYCf73JQTloClbelbu9YCi4z1LRIs2ERpyEt5NNUUd
 Py0amGiiDptwNFJ+Tnj2hKPwNE8VmpxF3bpUzbfSyVfTOFDlD85n46CdIDXnCKd90M3m
 m1cXXWP3d/1q3aoyKO6eXpYkZ7R1ooSODkHmI4x4d+nka3bOp8mOjPmAQZA7QRH/Xoud
 emv9jcbUTlsNp7Ry05cV+PA33X2TumxwQJYby7M++U/48/iakwoyUsTHHVjJC/LkZrN0
 6+IQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqinEmCU64alOm3j3C1zQLJUKTs4lUm4NLBabP2+wGuK186cEowmKVCD7kMNR4j1DYk/JpvlOgUYnQs@nongnu.org
X-Gm-Message-State: AOJu0YxBY35uBA/83/raa4cPNH2iSMDmsFqtZ2M2eI6LyQei4J3TKUyC
 L8Ft31z/114xsFEAaWykbtHds05gnEvXn8twGlWFjYxrTUmANKps8TPO
X-Gm-Gg: AfdE7cnZBmvJ6HE3vy86rxOg/9im44wdueT2Bcn9m+Z+36auuyDI/xXDVseyPN/bIYE
 6iV4Aeo3obx/sSb3Gr+vdvEC3juweTbQ10bo40uVyhUArG1cuOo5x6s8+KmgFlLlRw+8RviL6Fh
 GBSvi6SwYV4/14h+5YbGS1R2G35M7nBKGXBlRfhYpkOflynrD5XwIsariBvVFfHQIVIAIXIw2IY
 KQD2NdbVnOQ4s1VUrwYgYW1FhhZ5InY1JKzdqUKpVfgB/VCbyxss3B88jUMoiRE/lotpm/hSUMY
 KqB2//zC5ZtjrM0LpASf9xsRuUjARclKvj89u3dGJTWwyDiyt1FmJJhjf7Fy9BbVyXQXD/bvokj
 QAfXbRMoaj3WGdwRUjoziM2uxi+LXQ6GHImSx2bPi/QeN084uzcwXU3csrJyrYMsuef5Rh6QnXl
 oZDw/w3P8mn1muWZmn3NRWMq0c4DQfd4Px4cR5dC/h9+mM1l5C
X-Received: by 2002:a17:90b:394e:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-3811236e007mr7727293a91.16.1783135367891; 
 Fri, 03 Jul 2026 20:22:47 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb843fasm25995577eec.18.2026.07.03.20.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 20:22:47 -0700 (PDT)
Date: Sat, 4 Jul 2026 11:22:44 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 bin.meng@windriver.com, vivahavey@gmail.com,
 Alvin Chang <alvinga@andestech.com>, 
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT
 Ascalon support
Message-ID: <akh7ajryQNtpb0ho@ChaodeMacBook-Pro.local>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <ab8cd5ab-97bc-4c62-8225-6fd9d00e82da@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab8cd5ab-97bc-4c62-8225-6fd9d00e82da@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 03, 2026 at 06:36:13PM +0800, Daniel Henrique Barboza wrote:
> Greetings,
> 
> 
> My current understanding is that this series is an official dependency of
> the riscv-server-ref board, currently on v8:
> 
> [PATCH v8 0/7] hw/riscv: Server Platform Reference Board
> 
> Because we decided that we want to keep 0.13 and 1.0 instead of deprecating
> debug 1.0 (see [1]).
> 
> We missed the 11.1 boat with this work and with riscv-server-ref.  No big
> deal TBH since the server-ref board can use improvements before upstreaming.
> But I would like to not miss the 11.2 train in the end of the year.
> 
> Nick, I already reviewed a bunch of patches that seems to be fixes that we
> can use right away.  If you're ok with it I'll pick them all and re-send in
> your behalf, rebased and with acks.  My hope is that this will reduce
> the amount of work needed for the rest of the 0.13/1.0 debug code and
> we can get that sorted it out.  Then Chao can use the new 1.0 infrastructure
> for his 'sdext' patches, and then we can lend the riscv-server-ref board on
That's great news. I'll follow up on this series next week and start updating
my 'sdext' patches.

> top of it all.
> 
> Let me know if that works for you.  Chao, not sure if you were aware of this
> series so feel free to comment.
I'm no longer being blocked by anything, and I feel like our work is basically
nearing completion. 

The main thing missing right now relates to the debug spec features, but I don't
think those will be an issue. We should be able to push them upstream before
the 11.2 release.

Thanks,
Chao
> 
> 
> [1] https://lore.kernel.org/qemu-devel/383936e5-fcdf-488b-8f77-17fdee41243e@oss.qualcomm.com/
> 
> 
> Thanks,
> 
> Daniel
> 
> On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> > Hi,
> > 
> > Sorry for the big series. The Ascalon CPU implements Sdtrig with 2
> > different types of mcontrol6 trigger and the icount trigger, so in
> > the course of testing and bringing up OpenSBI and Linux support for
> > this, I've accumulated quite a lot.
> > 
> > My new year resolution is to start being better upstream contributor,
> > it's taken me a while with changing jobs and architectures. So I don't
> > expect others to drop everything to review this! Joel has been
> > prodding me, and noted there is some other Sdtrig work going on
> > with the v1.0 support patches.
> > 
> > I think the debug v1.0 patches are somewhat orthogonal to this series,
> > but both are addressing aspects of a common problem of Sdtrig
> > implementation specifics. I wonder if these should be reconciled or
> > left separate. Sdtrig v1.00/v0.13 configuration is a single boolean
> > which is feasible as a CPU property. Whereas the entire space of
> > Sdtrig implementation seems like too much to make configurable in that
> > way.
> > 
> > Any thoughts would be welcome.
> > 
> > Thanks,
> > Nick
> > 
> > Nicholas Piggin (25):
> >    target/riscv/debug: Check only mcontrol triggers for break/watchpoint
> >      matching
> >    target/riscv/debug: Handle changing trigger types
> >    target/riscv/debug: Implement permissive type unavailable trigger
> >    target/riscv/debug: Fix icount trigger privilege check
> >    target/riscv/debug: Update itrigger_enabled after changing privilege
> >    target/riscv/debug: Implement get_trigger_action for icount type
> >      trigger
> >    target/riscv/debug: Fix migration post_load icount_enabled() test
> >    target/riscv/debug: Fix icount privilege matching icount_enabled()
> >      test
> >    target/riscv/debug: Implement icount trigger textra matching
> >    target/riscv/debug: Maintain itrigger_enabled in
> >      helper_itrigger_match()
> >    target/riscv/debug: Fix breakpoint matching action
> >    target/riscv/debug: Put mcontrol load/store match address into tval
> >    target/riscv/debug: Remove breakpoints on reset
> >    target/riscv/debug: Move debug CPU post_load details into debug.c
> >    target/riscv/debug: Insert breakpoints after migration
> >    target/riscv/debug: Remove itrigger icount-enabled mode
> >    target/riscv/debug: Advertise icount trigger type in tinfo
> >    target/riscv/debug: Reset trigger type to unavailable
> >    target/riscv/debug: Add new debug state format
> >    target/riscv/debug: Migrate mcontext using new sdtrig vmstate
> >    target/riscv/debug: Implementation specific Sdtrig configuration
> >    target/riscv/debug: Support heterogeneous trigger types
> >    target/riscv/debug: Support heterogeneous mcontrol access types
> >    target/riscv/debug: Emulate TT Ascalon Sdtrig
> >    target/riscv/debug: Fix minor comment typos
> > 
> >   target/riscv/cpu.c         |  65 ++++-
> >   target/riscv/cpu.h         |  41 ++-
> >   target/riscv/cpu_helper.c  |  10 +-
> >   target/riscv/csr.c         |   7 +-
> >   target/riscv/debug.c       | 571 ++++++++++++++++++++-----------------
> >   target/riscv/debug.h       |  19 +-
> >   target/riscv/machine.c     |  96 ++++++-
> >   target/riscv/tcg/tcg-cpu.c |   5 +-
> >   8 files changed, 510 insertions(+), 304 deletions(-)
> > 
> 

