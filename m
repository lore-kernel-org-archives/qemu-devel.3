Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80805CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 22:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un2aH-0006w6-GV; Fri, 15 Aug 2025 18:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1un2aF-0006vh-OY; Fri, 15 Aug 2025 18:07:35 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1un2aE-0005Pi-6I; Fri, 15 Aug 2025 18:07:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 460745C69B1;
 Fri, 15 Aug 2025 22:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D1C4CEEB;
 Fri, 15 Aug 2025 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755295649;
 bh=KkPwkM14ax0TYQfRPch1GnAGK4jNiOfCdjxeAx33u8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nDjKLM8jXCa1RupeHk715wefofBb/Xmk8iTIvDxcRoeNZ9QC2lCQvpzM7/dONsMP1
 R2SIeSbJyD9Bl6lbix9MBLlbggGczJrIzjCO7i2bNAnaoug5C1UKBv58wFHAOJc3h8
 6f+X8ReS70v6+FVzYdgkYukfbxL4auDtVU3E6LJj9glZoAO9DogkM8Ii1YJ9THQWSc
 lVFq15PUEbV0MW3Wz3XUd7dAPWOiq3dci407U6EeT0pCfBmI9JcX94KydWiRwOWV+k
 1J7JV6S/a4JXsoD0dLH7gQcW7/rB7nW+X3biKlc4vkDndRj1bnP1T9hp6sBoP8dtV6
 GSEcB0clKcj5g==
Date: Fri, 15 Aug 2025 15:07:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Liu <chao.liu@yeah.net>
Cc: paolo.savini@embecosm.com, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] target/riscv: fix vector register address
 calculation in strided LD/ST
Message-ID: <20250815220727.GB2041@quark>
References: <cover.1755287531.git.chao.liu@yeah.net>
 <ee461421503da741d4cf6d2486b8596862fc0b7f.1755287531.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee461421503da741d4cf6d2486b8596862fc0b7f.1755287531.git.chao.liu@yeah.net>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ebiggers@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, Aug 16, 2025 at 03:55:40AM +0800, Chao Liu wrote:
> This patch fixes a critical bug in the RISC-V vector instruction
> translation that caused incorrect data handling in strided load
> operations (e.g., vlsseg8e32).
> 
> Problem Description:
> 
> The `get_log2` function in `trans_rvv.c.inc` returned a value 1 higher
> than the actual log2 value. For example, get_log2(4) incorrectly
> returned 3 instead of 2.
> 
> This led to erroneous vector register offset calculations, resulting in
> data overlap where bytes 32-47 were incorrectly copied to positions
> 16-31 in ChaCha20 encryption code.
> 
> rvv_test_func:
>     vsetivli    zero, 1, e32, m1, ta, ma
>     li          t0, 64
> 
>     vlsseg8e32.v v0, (a0), t0
>     addi        a0, a0, 32
>     vlsseg8e32.v v8, (a0), t0
> 
>     vssseg8e32.v v0, (a1), t0
>     addi        a1, a1, 32
>     vssseg8e32.v v8, (a1), t0
>     ret
> 
> Analysis:
> 
> The original implementation counted the number of right shifts until
> zero, including the final shift that reduced the value to zero:
> 
> static inline uint32_t get_log2(uint32_t a)
> {
>     uint32_t i = 0;
>     for (; a > 0;) {
>         a >>= 1;
>         i++;
>     }
>     return i; // Returns 3 for a=4 (0b100 → 0b10 → 0b1 → 0b0)
> }
> 
> Fix:
> 
> The corrected function stops shifting when only the highest bit remains
> and handles the special case of a=0:
> 
> static inline uint32_t get_log2(uint32_t a)
> {
>     uint32_t i = 0;
>     if (a == 0) {
>         return i; // Handle edge case
>     }
>     for (; a > 1; a >>= 1) {
>         i++;
>     }
>     return i; // Now returns 2 for a=4
> }
> 
> Fixes: 28c12c1f2f ("Generate strided vector loads/stores with tcg nodes.")
> 
> Signed-off-by: Chao Liu <chao.liu@yeah.net>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Tested-by: Eric Biggers <ebiggers@kernel.org>

But, to get this to apply I had to re-apply the fixed commit (which was
reverted), then resolve a conflict.  You'll need to send out a new
series which applies to the latest master branch.

- Eric

