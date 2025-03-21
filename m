Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C66C36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdXF-0005eU-5E; Fri, 21 Mar 2025 10:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdXD-0005aw-Gc
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:39:43 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdXB-0000Fu-L8
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=QB1XUe/whImbl2lgvlFtGKKCEytKrJSkNt/GS9tfoqo=; b=pLPfdpjX5oinac7
 YT60SDxBhOXsr3+cc+PrBxBJWUh3Hz+4dOra6S7z8c/HWEvjM8j8htb7pLSYiXYuTw7ZoyZGstB40
 DetSUSNdi6bG6CWTBWl6XCk2gDwV90dYLWh2w+s8iWIiA4EhwOLBDDN+hi6NCIP+DVrabMT3danPe
 z8=;
Date: Fri, 21 Mar 2025 15:40:10 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH-for-10.1 0/4] tcg: Move TCG_GUEST_DEFAULT_MO ->
 TCGCPUOps::guest_default_memory_order
Message-ID: <7wjz5v5wqscpil55ltryfbmzksbedcsl5rzp3rb4zd3ut74snt@gkztlt3zfzyj>
References: <20250321125737.72839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321125737.72839-1-philmd@linaro.org>
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

On 21/03/25, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> In this series we replace the TCG_GUEST_DEFAULT_MO definition
> from "cpu-param.h" by a 'guest_default_memory_order' field in
> TCGCPUOps.
> 
> Since tcg_req_mo() now accesses tcg_ctx, this impact the
> cpu_req_mo() calls in accel/tcg/{cputlb,user-exec}.c.
> 
> The long term goal is to be able to use targets with distinct
> guest memory order restrictions.
> 
> Philippe Mathieu-Daudé (4):
>   tcg: Always define TCG_GUEST_DEFAULT_MO
>   tcg: Simplify tcg_req_mo() macro
>   tcg: Have tcg_req_mo() use runtime TCGContext::guest_mo
>   tcg: Define guest_default_memory_order in TCGCPUOps
> 
>  accel/tcg/internal-target.h   | 13 ++-----------
>  include/accel/tcg/cpu-ops.h   |  8 ++++++++
>  target/alpha/cpu-param.h      |  3 ---
>  target/arm/cpu-param.h        |  3 ---
>  target/avr/cpu-param.h        |  2 --
>  target/hppa/cpu-param.h       |  8 --------
>  target/i386/cpu-param.h       |  3 ---
>  target/loongarch/cpu-param.h  |  2 --
>  target/microblaze/cpu-param.h |  3 ---
>  target/mips/cpu-param.h       |  2 --
>  target/openrisc/cpu-param.h   |  2 --
>  target/ppc/cpu-param.h        |  2 --
>  target/riscv/cpu-param.h      |  2 --
>  target/s390x/cpu-param.h      |  6 ------
>  target/sparc/cpu-param.h      | 23 -----------------------
>  target/xtensa/cpu-param.h     |  3 ---
>  accel/tcg/tcg-all.c           |  3 ---
>  accel/tcg/translate-all.c     |  6 +-----
>  target/alpha/cpu.c            |  3 +++
>  target/arm/cpu.c              |  3 +++
>  target/arm/tcg/cpu-v7m.c      |  3 +++
>  target/avr/cpu.c              |  1 +
>  target/hexagon/cpu.c          |  2 ++
>  target/hppa/cpu.c             |  8 ++++++++
>  target/i386/tcg/tcg-cpu.c     |  5 +++++
>  target/loongarch/cpu.c        |  2 ++
>  target/m68k/cpu.c             |  3 +++
>  target/microblaze/cpu.c       |  3 +++
>  target/mips/cpu.c             |  2 ++
>  target/openrisc/cpu.c         |  2 ++
>  target/ppc/cpu_init.c         |  2 ++
>  target/riscv/tcg/tcg-cpu.c    |  2 ++
>  target/rx/cpu.c               |  3 +++
>  target/s390x/cpu.c            |  6 ++++++
>  target/sh4/cpu.c              |  3 +++
>  target/sparc/cpu.c            | 23 +++++++++++++++++++++++
>  target/tricore/cpu.c          |  2 ++
>  target/xtensa/cpu.c           |  3 +++
>  38 files changed, 92 insertions(+), 83 deletions(-)
> 
> -- 
> 2.47.1
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

