Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD6DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmO9-0005j5-Lw; Wed, 21 May 2025 12:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmO8-0005id-Cp; Wed, 21 May 2025 12:33:52 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmO6-0004th-48; Wed, 21 May 2025 12:33:52 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8741A5C5ADC;
 Wed, 21 May 2025 16:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1CC4CEEB;
 Wed, 21 May 2025 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747845225;
 bh=Q3egzTgzDfH2KEE0SZSuIaJxUIh7d2qdWkDhFtEuleU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tyFG90jTuP7C9hzJj7+8eAMZZcyfmkiyO4C1s94+65wW+Z/m88fVPqQcMqVPDtFJh
 lCyD28gtgpFFEhaw4ksaGtE0xcFMA9ZmUyoXtj/KWR2a/JW1H3kU0kPUHoJsHwg63d
 GdhPA6r5TVukXftx30Zo+pEf7EEjQ52KFIwjOxk618qCwmnAEOSoGSKvF3mz2CtqJA
 oSasVBsXpxm6G83+ly3U0ZPITCaymhb+cDj/At15cgPq0yiayQTvd9snVE1yLFYgBG
 J0cxxLtukO9CBL09eVDw/yW1OVsByokkvAl8QbuXF89glDTKC6l5w/O6p54Tr0yJzj
 SHDwVH4qB2xVQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 3/3] target/riscv: add profile->present flag
In-Reply-To: <20250520172336.759708-4-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-4-dbarboza@ventanamicro.com>
Date: Wed, 21 May 2025 18:33:42 +0200
Message-ID: <8734cxzzx5.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> Bj=C3=B6rn reported in [1] a case where a rv64 CPU is going through the
> profile code path to enable satp mode. In this case,the amount of
> extensions on top of the rv64 CPU made it compliant with the RVA22S64
> profile during the validation of CPU 0. When the subsequent CPUs were
> initialized the static profile object has the 'enable' flag set,
> enabling the profile code path for those CPUs.
>
> This happens because we are initializing and realizing each CPU before
> going to the next, i.e. init and realize CPU0, then init and realize
> CPU1 and so on. If we change any persistent state during the validation
> of CPU N it will interfere with the init/realization of CPU N+1.
>
> We're using the 'enabled' profile flag to do two distinct things: inform
> cpu_init() that we want profile extensions to be enabled, and telling
> QMP that a profile is currently enabled in the CPU. We want to be
> flexible enough to recognize profile support for all CPUs that has the
> extension prerequisites, but we do not want to force the profile code
> path if a profile wasn't set too.
>
> Add a new 'present' flag for profiles that will coexist with the 'enabled'
> flag. Enabling a profile means "we want to switch on all its mandatory
> extensions". A profile is 'present' if we asserted during validation
> that the CPU has the needed prerequisites.
>
> This means that the case reported by Bj=C3=B6rn now results in
> RVA22S64.enabled=3Dfalse and RVA22S64.present=3Dtrue. QMP will recognize =
it
> as a RVA22 compliant CPU and we won't force the CPU into the profile
> path.
>
> [1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.b=
elong.to.us/
>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Fixes: 2af005d610 ("target/riscv/tcg: validate profiles during finalize")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

