Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E430C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 23:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf53n-0005FP-CT; Thu, 24 Jul 2025 19:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uf53Y-0005BB-GB; Thu, 24 Jul 2025 19:08:58 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1uf53V-0003V6-2i; Thu, 24 Jul 2025 19:08:55 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8AB643DA1;
 Thu, 24 Jul 2025 23:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F93C4CEED;
 Thu, 24 Jul 2025 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753398528;
 bh=lhwVW+BaYNiHTEAk5dlLV2y2WOOLI3+gQYdehygifnk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WpF9CD11VwXePTB28++pwcJ8we7qQ5v8D2n4dPoPhUbDjqvz+xJDUIBTgT9GNsDkj
 RWJ+iLU6b4LVRc0E+iq6QpSrcrgLn8QSbSIkRY7/ZjrnUzVMQq0nGk/crT5fZPiXII
 UOxTZp0EDkRMPBJ6RBErsGrizU8SMOvJL8lFXw9hEVOgbINM1fLmghNOCAGZkP7JA9
 FdwnxS4kDcYmdWqOx6LlyCCTa9JLyAoTKZO8/qLAMksrbJZUL9sx6PjQ2DtcGNiisI
 KrqVjuqdwjZ3RjLcFHO5WvifDbfXb0ONYYjRZucj9xzbvbBDMuO3BQ1+5HqqfYNcp4
 GMk3+Sicn2M0A==
Date: Thu, 24 Jul 2025 16:08:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Subject: Re: [PATCH] riscv: Revert "Generate strided vector loads/stores with
 tcg nodes."
Message-ID: <20250724230845.GB1409@quark>
References: <20250710100525.372985-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710100525.372985-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=ebiggers@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

On Thu, Jul 10, 2025 at 07:05:25AM -0300, Daniel Henrique Barboza wrote:
> This reverts commit 28c12c1f2f50d7f7f1ebfc587c4777ecd50aac5b.
> 
> As reported in [1] this commit is breaking Linux vector code, and
> although a simpler reproducer was provided, the fix itself isn't trivial
> due to the amount and the nature of the changes. And we really do not
> want to keep Linux broken while we work on it.
> 
> The revert will fix Linux and will give us time to do a proper fix.
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg02525.html
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++--------------------
>  1 file changed, 50 insertions(+), 273 deletions(-)

Tested-by: Eric Biggers <ebiggers@kernel.org>

- Eric

