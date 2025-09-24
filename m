Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CE4CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1M0M-0005i2-7a; Wed, 24 Sep 2025 05:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1M0H-0005hl-DB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:41:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1M0E-0006cA-SX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=VNKqSSG1iDxB7fzZ8TjvsRgeQ8Pnsk/y9MmLc1nAVeY=; b=e38i2U2W+27fBk0
 niMsw4QCBptyG+yvQr1KwfSPUgXB8WDZYwzquZy8KE/JTGwQ6uBj0XgwyOTAGV4ZrTe8S53BELz/Y
 64/MwIR9dct6SFkwxXLoQIkbr4Z9mddzXGDFrGHzmcR4KmMkSf6XMnnj+KvCi1deRrEt2bHKgU18h
 5A=;
Date: Wed, 24 Sep 2025 11:44:04 +0200
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, kasperl@rivosinc.com, lazyparser@gmail.com, 
 liwei1518@gmail.com, =?utf-8?B?5p2O5aiB5aiB?= <liweiwei@kubuds.cn>
Subject: Re: [PATCH] accel/tcg: Properly unlink a TB linked to itself
Message-ID: <jsf6bt4lk7laaxlq74xtgr3j5gvzzjkeuu2lik3mblsvoyr3bg@4r4rukqvww5j>
References: <20250923230415.3688766-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923230415.3688766-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/09/25, Richard Henderson wrote:
> When we remove dest from orig's links, we lose the link
> that we rely on later to reset links.  This can lead to
> failure to release from spinlock with self-modifying code.
> 
> Reported-by: 李威威 <liweiwei@kubuds.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tb-maint.c              |  8 +++++
>  tests/tcg/riscv64/tb-link.c       | 60 +++++++++++++++++++++++++++++++
>  tests/tcg/riscv64/Makefile.target |  1 +
>  3 files changed, 69 insertions(+)
>  create mode 100644 tests/tcg/riscv64/tb-link.c

Nice, tried the fix/test.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>

