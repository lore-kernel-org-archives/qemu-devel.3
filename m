Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB9AC87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 23:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf5BI-0002eF-Vu; Thu, 24 Jul 2025 19:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uf5BG-0002b9-Un
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 19:16:54 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uf5BE-0006xt-T3
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 19:16:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8A6343862;
 Thu, 24 Jul 2025 23:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322DC4CEED;
 Thu, 24 Jul 2025 23:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753399010;
 bh=Ey7PjDwiz2S9ES1vVkTER9dvfutMI7NS7IvXb4iA4UY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KG8LLlOaFWwFBWn70eAgd9lP5Xaepfp0Miur76fVwJ+6BZdYxWjKfckvN/HgEfIn3
 5FVbpo972fkBxp4icEWqmQwOiZDSDW9xgxyFdSHbgr7OZdRgwRXQk0xOeU8du3HXEc
 zhzTRaXybA3pMep965zhOhd4VaaPsMfogN8Fg2KX8skwkOSli/vb8LXUbEzIhtTvh/
 c8xNdXM6NFKtr9gcYnlP5FV9tAdQMaMMavfudgDJ1rv4RHVe5XP2o0OXZU7oDC9/TN
 84klRGAygHqDHW/jQtWZDPJnxU1AnOA5elEy0GA4HWpr2yoHu2UuDq0hvEvVWhXKJL
 k4WTcyBwLoc4w==
Date: Thu, 24 Jul 2025 16:16:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [QEMU bug] [x86_64] Incorrect emulation of vinserti128 instruction
Message-ID: <20250724231642.GC1409@quark>
References: <20250724225031.GA1409@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724225031.GA1409@quark>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=ebiggers@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 24, 2025 at 03:50:36PM -0700, Eric Biggers wrote:
> Another QEMU bug found by the Linux kernel's crypto tests
> (https://lore.kernel.org/linux-crypto/20250724173657.GB26800@sol/):
> 
> When KVM is disabled, QEMU's implementation of the AVX2 instruction
> 'vinserti128' with a memory source operand incorrectly reads 32 bytes
> from memory.  This differs from the real CPUs which read only 16 bytes,
> as per the spec
> (https://www.felixcloutier.com/x86/vinserti128:vinserti32x4:vinserti64x2:vinserti32x8:vinserti64x4)
> which defines the operand as xmm3/m128.
> 
> This can be reproduced by the recently-added poly1305_kunit test in
> linux-next, or alternatively by the following userspace program:
> 
>     #include <stddef.h>
>     #include <sys/mman.h>
>     int main()
>     {
>             unsigned char *buf = mmap(NULL, 8192, PROT_READ|PROT_WRITE,
>                                       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> 
>             munmap(buf + 4096, 4096);
>             asm volatile("vinserti128 $1, %0, %%ymm0, %%ymm0\n"
>                          :: "m" (buf[4080]));
>     }
> 
> That executes vinserti128 with a memory operand with 16 valid bytes
> followed by an unmapped page.  This works fine on the real CPUs, but it
> segfaults when run with qemu-x86_64.  To avoid the segfault in QEMU, we
> have to go down to buf[4064], which implies it reads 32 bytes.
> 
> This bug exists on the master branch of QEMU as well as v8.2.10 and
> v7.2.19.  So probably it's not new.
> 
> - Eric

It looks like support for this instruction was added by the following
commit:

    commit 7906847768613ea6b6e737f3295c77cdb4ff67f4
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Tue Sep 6 10:34:11 2022 +0200

        target/i387: reimplement 0x0f 0x3a, add AVX

