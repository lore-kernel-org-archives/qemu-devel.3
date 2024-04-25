Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877E1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzttE-0002KY-P2; Thu, 25 Apr 2024 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rzttA-0002Iq-FW; Thu, 25 Apr 2024 03:51:28 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztt8-0006wc-Tz; Thu, 25 Apr 2024 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=acKsY5/yphuMvkfLPTUSo/AmhbEKlxY/oFgqWmU/ddE=; b=OzuApP0pY5NL3pM
 1sr0ZlvXosaPe6hGIJJvbKB9fb/Xp2q+hh1oTkBByYULGZ9kNUQII7xT+3xGK0S80p9sfav9hVhDJ
 q2iBtPjed10arlwjKD4GO1W7pgsxX3uFs9dAdcqBipfiGXoyPqJtRxNbkO79sWC9rte4b7F2iMkdW
 As=;
Date: Thu, 25 Apr 2024 09:52:35 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 07/24] exec: Un-inline tlb_vaddr_to_host() and declare it
 in 'exec/cputlb.h'
Message-ID: <l2ob32xcx2gh77xxots2sttd7i327cz3bcvavxf4h7vt5kwogy@33u6iavgeilz>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-8-philmd@linaro.org>
 <w7c53ha73uvaxl6yr5vxcsqb2mlndzi2niib4za7h64j3ca7ru@ssa2okjwzd3b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w7c53ha73uvaxl6yr5vxcsqb2mlndzi2niib4za7h64j3ca7ru@ssa2okjwzd3b>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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

On 25/04/24, Anton Johansson via wrote:
> On 18/04/24, Philippe Mathieu-Daudé wrote:
> > Declare tlb_vaddr_to_host() in "exec/cputlb.h" with the CPU TLB
> > API. Un-inline the user emulation definition to avoid including
> > "exec/cpu_ldst.h" (which declares g2h) in "exec/cputlb.h".
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  include/exec/cpu_ldst.h      | 24 ------------------------
> >  include/exec/cputlb.h        | 18 ++++++++++++++++++
> >  accel/tcg/user-exec.c        |  7 +++++++
> >  target/arm/tcg/helper-a64.c  |  1 +
> >  target/riscv/vector_helper.c |  1 +
> >  target/sparc/mmu_helper.c    |  1 +
> >  6 files changed, 28 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> 

Missed existing review, my bad!

