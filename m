Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B43606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=ZwcgIbjH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsGw-0008An-8R; Thu, 22 Oct 2026 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJsGm-0008AI-Tc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:51:45 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xJsGj-0006fI-NU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=mftDiPmjb1mlyC5krFyA9sahWe9kaYx6VcFc1OfsZpY=; b=ZwcgIbjHfHeNhOF
 tPOPhttYIjAX6SkjLqBb+t+FckbYF3Tm1pCQc8crB7HaL1917oGyF+cN3y8gvcfGkKJNqtF1PrCJE
 S64wChqrxYAqclTjh1jRXrwoPpKV0DLjsusWZzaqnU3in8KWN1+06xtktwx6/krhyhmHIoSdjDpqb
 1o=;
Date: Thu, 22 Oct 2026 14:57:03 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
Message-ID: <atoF3WQrtsFPfxkP@hive.localdomain>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/26, Pierrick Bouvier wrote:
> When linking multiple targets together, we usually have conflicts with helper
> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
> would be better to have a general mechanism for it, so here it is.
> 
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
> but it was relying on (binary) symbol renaming, which is not a portable solution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.
> 
> Series follows these steps:
> 
> First, we make sure all helpers and definition are using HELPER() macro. A lot
> of helpers were already defined this way, we just make sure it's exhaustive.
> After that we don't have any 'helper_' left on any target code. This is a big
> change touching the whole codebase, but it's a simple mechanical change. As long
> as it compiles and links, we know it's correct.
> 
> Then, we introduce the prefix for target helpers. For this , we add a new define
> (from meson) that applies to all target related code. It could later be used to
> prefix other symbols also, that's why it's not named "TCG".
> 
> Finally, we cleanup the previous manual helpers prefix that were added in
> codebase.
> 
> Pierrick Bouvier (26):
>   target/alpha: define and call helpers using HELPER macro
>   target/arm: define and call helpers using HELPER macro
>   target/avr: define and call helpers using HELPER macro
>   target/hppa: define and call helpers using HELPER macro
>   target/i386: define and call helpers using HELPER macro
>   target/loongarch: define and call helpers using HELPER macro
>   target/m68k: define and call helpers using HELPER macro
>   target/microblaze: define and call helpers using HELPER macro
>   target/mips: define and call helpers using HELPER macro
>   target/or1k: define and call helpers using HELPER macro
>   target/ppc: define and call helpers using HELPER macro
>   target/riscv: define and call helpers using HELPER macro
>   target/rx: define and call helpers using HELPER macro
>   target/s390x: define and call helpers using HELPER macro
>   target/sh4: define and call helpers using HELPER macro
>   target/sparc: define and call helpers using HELPER macro
>   target/tricore: define and call helpers using HELPER macro
>   tcg: introduce HELPER_INFO macro
>   tcg: prefix helpers with target base architecture
>   target/alpha: remove explicit target specific prefix
>   target/hexagon: remove explicit target specific prefix
>   target/hppa: remove explicit target specific prefix
>   target/microblaze: remove explicit target specific prefix
>   target/or1k: remove explicit target specific prefix
>   target/rx: remove explicit target specific prefix
>   target/tricore: remove explicit target specific prefix

Hi, since this allows us to link different targets together with clashing
helper names, what about going one step further to allow symbol
collisions between say riscv32/64 etc.? It would make converting targets
to heterogeoneous emulation much easier since you could just compile
op_helper.c and translate.c twice and select different function pointers
based on target_*().

When I played around with this I ended up splitting helper.h in to
helper-common.h and helper-target.h, where the latter would get an extra
helper_*_tl32_*() prefix and could be compiled twice. But I recall you
mentioning this might be too much helper magic.

Just throwing ideas out there, either way the current series is good.

Series:
Reviewed-by: Anton Johansson <anjo@rev.ng>

