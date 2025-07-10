Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AEAC83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 05:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZjqY-0007Gv-Ht; Thu, 10 Jul 2025 01:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uZjqT-0007Db-0o; Thu, 10 Jul 2025 01:29:21 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uZjqR-00074n-D0; Thu, 10 Jul 2025 01:29:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2143543E1E;
 Thu, 10 Jul 2025 05:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4ACC4CEE3;
 Thu, 10 Jul 2025 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752125350;
 bh=Qz1W+r66aQd7m1FcvD672Hhe63W3L239ECIcMlf6PsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W+aNwZl5aBAz65CvBfFsUV5FxV2THn3Y5F1w1T6NoeJgXf4VN35FtlyexHoOSJu4C
 q6vpOQG3gH8NNF1ZH9CMmLRPZeOzXD56PA0/iUGktRD0SlNP2F1/2X2s/jiiENImlO
 8zsZaoUPntnBhUlNkWiQVMFT2zp+lj0LjmE8cTPiVsCcHE30FYr7eOnxrR5hn6fhAZ
 gJvKS2JDkTEgzUkyDyzsGIYK/mz/EAD/vKhcoEzYxNKMsIkol4bHD08ePtf+3n6Kl2
 /JOK1jZCRMlxZgVObXH9vIYV0Kn1m2CuhnKrEswFe3B3c3HlwdSdI9yAJILwOVJLj2
 vtUNk7QTsn5/g==
Date: Wed, 9 Jul 2025 22:28:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>,
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/1 v2] [RISC-V/RVV] Generate strided vector loads/stores
 with tcg nodes.
Message-ID: <20250710052824.GA608727@sol>
References: <20250312155547.289642-1-paolo.savini@embecosm.com>
 <20250312155547.289642-2-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312155547.289642-2-paolo.savini@embecosm.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=ebiggers@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On Wed, Mar 12, 2025 at 03:55:47PM +0000, Paolo Savini wrote:
> This commit improves the performance of QEMU when emulating strided vector
> loads and stores by substituting the call for the helper function with the
> generation of equivalent TCG operations.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++++++++++++++++++----
>  1 file changed, 273 insertions(+), 50 deletions(-)

This recent QEMU patch broke the RISC-V vector optimized ChaCha20 code
in the Linux kernel.  I simplified the reproducer to the following,
which had its behavior changed:

rvv_test_func:
	vsetivli	zero, 1, e32, m1, ta, ma
	li		t0, 64

	vlsseg8e32.v	v0, (a0), t0
	addi		a0, a0, 32
	vlsseg8e32.v	v8, (a0), t0

	vssseg8e32.v	v0, (a1), t0
	addi		a1, a1, 32
	vssseg8e32.v	v8, (a1), t0
	ret

Before this patch, it copied 64 bytes from a0 to a1.  After this patch,
the bytes at 32..47 also incorrectly get copied to 16..31.

Please fix this, or else revert the patch.

- Eric

