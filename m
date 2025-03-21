Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98754C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfR7-0004Du-Un; Fri, 21 Mar 2025 12:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvfR3-0004DI-Je
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:41:29 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvfR2-00066P-0t
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=a3i7Fh1+DGvRaBJtMHByxDqG6TVAJPK1hqGllUCwht0=; b=EOHFR2oUp7EcjYb
 k4nuR7ciVWLACrcPCpg/hCRarjcINd9xb59Ur5uVRAwSJl2QklyEyQk3UM/Bhe+/U6kv+d9H2HNV8
 Ip9/0rtGCH1IqkwFoF/8CEFoqDHROw+CoLW6Odzyd+uhyNmc5N/bWYvETJf+bJ7wRELRk40mz7X1U
 Vo=;
Date: Fri, 21 Mar 2025 17:41:55 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-10.1 4/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
Message-ID: <gbrrfbvhsryeduie27vfqzxkyb24hanjygjfsmmqu5gyg4hxde@kpnh3dqhu4i5>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321155925.96626-5-philmd@linaro.org>
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
> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
> have each target set the 'mttcg_supported' field in the TCGCPUOps
> structure.
> 
> Since so far we only emulate one target architecture at a time,
> tcg_init_machine() gets whether MTTCG is supported via the
> &first_cpu global.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/multi-thread-tcg.rst          | 2 +-
>  configs/targets/aarch64-softmmu.mak      | 1 -
>  configs/targets/alpha-softmmu.mak        | 1 -
>  configs/targets/arm-softmmu.mak          | 1 -
>  configs/targets/hppa-softmmu.mak         | 1 -
>  configs/targets/i386-softmmu.mak         | 1 -
>  configs/targets/loongarch64-softmmu.mak  | 1 -
>  configs/targets/microblaze-softmmu.mak   | 1 -
>  configs/targets/microblazeel-softmmu.mak | 1 -
>  configs/targets/mips-softmmu.mak         | 1 -
>  configs/targets/mipsel-softmmu.mak       | 1 -
>  configs/targets/or1k-softmmu.mak         | 1 -
>  configs/targets/ppc64-softmmu.mak        | 1 -
>  configs/targets/riscv32-softmmu.mak      | 1 -
>  configs/targets/riscv64-softmmu.mak      | 1 -
>  configs/targets/s390x-softmmu.mak        | 1 -
>  configs/targets/sparc-softmmu.mak        | 1 -
>  configs/targets/sparc64-softmmu.mak      | 1 -
>  configs/targets/x86_64-softmmu.mak       | 1 -
>  configs/targets/xtensa-softmmu.mak       | 1 -
>  configs/targets/xtensaeb-softmmu.mak     | 1 -
>  include/accel/tcg/cpu-ops.h              | 8 ++++++++
>  include/exec/poison.h                    | 1 -
>  accel/tcg/tcg-all.c                      | 7 ++-----
>  target/alpha/cpu.c                       | 1 +
>  target/arm/cpu.c                         | 1 +
>  target/arm/tcg/cpu-v7m.c                 | 1 +
>  target/avr/cpu.c                         | 1 +
>  target/hexagon/cpu.c                     | 1 +
>  target/hppa/cpu.c                        | 1 +
>  target/i386/tcg/tcg-cpu.c                | 1 +
>  target/loongarch/cpu.c                   | 1 +
>  target/m68k/cpu.c                        | 1 +
>  target/microblaze/cpu.c                  | 1 +
>  target/mips/cpu.c                        | 1 +
>  target/openrisc/cpu.c                    | 1 +
>  target/ppc/cpu_init.c                    | 1 +
>  target/riscv/tcg/tcg-cpu.c               | 1 +
>  target/rx/cpu.c                          | 1 +
>  target/s390x/cpu.c                       | 1 +
>  target/sh4/cpu.c                         | 1 +
>  target/sparc/cpu.c                       | 1 +
>  target/tricore/cpu.c                     | 1 +
>  target/xtensa/cpu.c                      | 1 +
>  44 files changed, 31 insertions(+), 27 deletions(-)

Nice!

Reviewed-by: Anton Johansson <anjo@rev.ng>

