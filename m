Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D05CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ESC-0006En-MQ; Mon, 29 Sep 2025 10:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1v3ESB-0006EV-JP; Mon, 29 Sep 2025 10:02:11 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1v3ERw-0008My-6V; Mon, 29 Sep 2025 10:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=yUKQCluVvU/oxFXPjMCLWhMYeKPMcqD/YxlvQKKyhtE=; b=DpcYaaEmetc+WMc
 CT31tsnZTq1/dvwyVo2tyOFg4n89qwaOncX9mJC9hTenCGLFHsM+2tc3W9wnBqwzDSaFlnSGtad9T
 k/ijM7Oj/qIP2Pel5z0O0rdHGlwlJQCaT9tFo2piOGZRFl1x/ay7pyA5aJLAr9Khy179tEd/6P/1J
 bA=;
Date: Mon, 29 Sep 2025 16:04:24 +0200
To: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-trivial@nongnu.org, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com,
 vhaudiquet <vhaudiquet343@hotmail.fr>
Subject: Re: [PATCH] target/riscv: Fix endianness swap on compressed
 instructions
Message-ID: <oz2iukkdeaphmx7kagvw4i5ibjihjhka23aocl5ytnarndqmjs@bhgrml5uvzbr>
References: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 29/09/25, Valentin Haudiquet wrote:
> From: vhaudiquet <vhaudiquet343@hotmail.fr>
> 
> Three instructions were not using the endianness swap flag, which resulted in a bug on big-endian architectures.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
> Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828
> 
> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> ---
>  target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>

