Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8186D6ACF4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLkt-00014C-0Y; Wed, 27 Nov 2024 12:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tGLkq-00013s-HA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:23:08 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tGLko-00077L-MP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=M+M5aW18ddkRLTN8mPb7seP7JJfO8IXnP0SHH3+Rjqk=; b=XTM2q0bnfeafnna
 H1SHyni+pwzJe2tyLQYfsYBhLAUwTVsl/VSsw18suC9Tod/rRwEUY3Yef4tCksJi3hYqdGwtXix6B
 FkJaTrmn9oty3AhCa5sTAJcfjOg8VA19ePJ2XPNGBvKZhST3wuwAIoo4YpXCHjR9A9mMdhfM44BBv
 /0=;
Date: Wed, 27 Nov 2024 18:26:03 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH-for-10.0 5/6] accel/tcg: Add TCGCPUOps::arch_id field
Message-ID: <nrtmnhffrv7bpkdd5py7vkn6lfntmbp4ynephisgo7jrmedydk@w6vgenkwx73g>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127121658.88966-6-philmd@linaro.org>
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

On 27/11/24, Philippe Mathieu-Daudé wrote:
> When using multiple TCG frontends concurrently, we need to
> be able to discriminate by target architecture. While we
> can infer that from the CPUClass, it can be quicker to get
> it from a direct field in TCGCPUOps.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/tcg-cpu-ops.h | 3 +++
>  target/alpha/cpu.c            | 1 +
>  target/arm/cpu.c              | 1 +
>  target/arm/tcg/cpu-v7m.c      | 1 +
>  target/avr/cpu.c              | 1 +
>  target/hexagon/cpu.c          | 1 +
>  target/hppa/cpu.c             | 1 +
>  target/i386/tcg/tcg-cpu.c     | 1 +
>  target/loongarch/cpu.c        | 1 +
>  target/m68k/cpu.c             | 1 +
>  target/microblaze/cpu.c       | 1 +
>  target/mips/cpu.c             | 1 +
>  target/openrisc/cpu.c         | 1 +
>  target/ppc/cpu_init.c         | 1 +
>  target/riscv/tcg/tcg-cpu.c    | 1 +
>  target/rx/cpu.c               | 1 +
>  target/s390x/cpu.c            | 1 +
>  target/sh4/cpu.c              | 1 +
>  target/sparc/cpu.c            | 1 +
>  target/tricore/cpu.c          | 1 +
>  target/xtensa/cpu.c           | 1 +
>  21 files changed, 23 insertions(+)

Reviewed-by: Anton Johansson <anjo@rev.ng>

