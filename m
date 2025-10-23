Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6726CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC562-0007iw-5o; Thu, 23 Oct 2025 19:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC55v-0007M1-FR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:51:49 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC55n-0007dZ-7Y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:51:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b5e19810703so225077966b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263497; x=1761868297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBaX2B2H6HDDMtXQjf/gxJwL6ZbL9iKCxPWdUhXmM/0=;
 b=XgN8Xnr/9dCDdHcF/IU/gKH+5+53oh7n++dz3t+ZtT+fabS8uAAHNoxdU+j0yDVQ8O
 a1kKV8/j7+HzINZboewwqwt5Xu67pAIKEWcpzd7fOvdBUplcXijMIxwnRGt/UFFXPiNY
 uaQCk8wVsftT7v7v7i5ZKyL5tcLdXME+c4P+LrhQkBUhkPdC31TIlJkuiBB3rRiegUxZ
 2XcvAIa90o3eCJJ669zYfVY3I2cWwfNSHGDAETZxMm24+Tnbn8O5+VqFWxDdCc51qval
 pNdHbXOG0V/9q+igMqrlmrPFPznZ0l+AP7D5DieeIY7PBy+vAcLazk20tju6oZe7DX4w
 Jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263497; x=1761868297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBaX2B2H6HDDMtXQjf/gxJwL6ZbL9iKCxPWdUhXmM/0=;
 b=wiSzsV3DwM91rEWDuzdZhcjpmZQshw7QlSjpK4aPARfa/eJz02o62Db8V2huppOhXs
 LwyulEtB2QHbBTcII+bhMrQ68IlkpDlgXu7CwLOqKKt/IZiGRMzVpVBIH8Uv8a+NRDrN
 0uGgKDDrXXo9szo5oApn+YnsAoSUhjjtJLy8aM0RUjQ6t3bHPBueTqJEnMH8d04zv/Ks
 0H9iQ/V+VWZOlRT+WpMbJEk4C7cW5OipVjBZ5MRnfQySSIa4KlXsCVLUogBMmk6m5E+D
 G4hpL++c4GPVhI+HSdbzLvNScF+DY4EbaL/uFmPNG8IeirZX67oYS7yniSBSqf+ztU57
 9Dtw==
X-Gm-Message-State: AOJu0YwXcvGaXDYhp0fEt3PsdpeF5942CRZmuqax8CkRQeOYA8VorRS9
 e16FeK88SWXP2MpIA4ceoCqE3vad7z5WF+pXlDvdegWvgaM1hKsaVzlyTk/kdabvYEHZRzeiDj/
 XhCI+XWOK6EdXt4F9VbgP2UZ22vm9cxqYaEyJ
X-Gm-Gg: ASbGnctxqg95w//NMhz5/T3G+85xG6CzVgH/InpYsQuKKCFjRXl7zsdYfW8Ur8lmg1h
 eKkIinAH2MhSM5LmfTesJefE6h9r9IMmfzf2Jv35M6d3DZxYxptQGhSy9FYUOzsLpM7MtKLsX2E
 zkhThdaPxAjQO/ymj7XH+ufgykA0+RZ769CRetXzr1KnTLdioRjDAtGn2h+xO8fKoSyJi7bRPRe
 1w9MjM4xGRB3ZBVgqLcoArrwtHmybD7JJj9+oiYEDQm2Cv0SXHLmzTkh+k5HD6DaNwW/pf2kjKX
 TPbWzh905TroxwE=
X-Google-Smtp-Source: AGHT+IF/BnLoSqTxmXKcIbX59LpyvhRHGXhpCwE0+301UXYCy4pKSmK4BJd6KlX89e1uEQRI8T7DQBH14uAmuaXSTKc=
X-Received: by 2002:a05:6402:f26:b0:639:5f23:5d10 with SMTP id
 4fb4d7f45d1cf-63c1f6bf0cdmr19099004a12.17.1761263496744; Thu, 23 Oct 2025
 16:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 24 Oct 2025 09:51:10 +1000
X-Gm-Features: AS18NWAJb0c59s-WlGvF0Gztgt-PJaVFsN0Wzdx3U77hqqVXTotLWRT92hs5lf0
Message-ID: <CAKmqyKPtDX=0O3MqdsOwODtt3njkwE=-YBR3GE68TziofOYz4g@mail.gmail.com>
Subject: Re: [PULL v2 00/25] riscv-to-apply queue
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Oct 24, 2025 at 9:49=E2=80=AFAM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> The following changes since commit 88b1716a407459c8189473e4667653cb8e4c3d=
f7:
>
>   Merge tag 'pull-target-arm-20251023' of https://gitlab.com/pm215/qemu i=
nto staging (2025-10-23 13:17:27 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-2025102=
4
>
> for you to fetch changes up to eccf20c02a5ad913a910444dc6bbe5de0952d254:
>
>   target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-24 09:=
24:08 +1000)
>
> ----------------------------------------------------------------
> Second RISC-V PR for 10.2
>
> * Correct mmu-type property of sifive_u harts in device tree
> * Centralize MO_TE uses in a pair of helpers
> * Fix Ethernet interface support for microchip-icicle-kit
> * Fix mask for smsiaddrcfgh
> * Fix env->priv setting in reset_regs_csr()
> * Coverity-related fixes
> * Fix riscv_cpu_sirq_pending() mask
> * Fix a uninitialized variable warning
> * Make PMP granularity configurable

I have dropped the MIP Boston board as that seems to fail when running
on s390 [1]. Hopefully this passes CI, but I'm unable to check that it
works on s390

1: https://gitlab.com/qemu-project/qemu/-/jobs/11827080939#L5859

Alistair

>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       target/riscv: Fix a uninitialized variable warning
>
> Daniel Henrique Barboza (3):
>       target/riscv/kvm: fix env->priv setting in reset_regs_csr()
>       target/riscv/riscv-qmp-cmds.c: coverity-related fixes
>       target/riscv: fix riscv_cpu_sirq_pending() mask
>
> Djordje Todorovic (1):
>       hw/intc: Allow gaps in hartids for aclint and aplic
>
> Guenter Roeck (4):
>       hw/net/cadence_gem: Support two Ethernet interfaces connected to si=
ngle MDIO bus
>       hw/riscv: microchip_pfsoc: Connect Ethernet PHY channels
>       hw/net/cadence_gem: Add pcs-enabled property
>       microchip icicle: Enable PCS on Cadence Ethernet
>
> Jay Chang (2):
>       target/riscv: Make PMP granularity configurable
>       target/riscv: Make PMP CSRs conform to WARL constraints
>
> Jialong Yang (1):
>       aplic: fix mask for smsiaddrcfgh
>
> Philippe Mathieu-Daud=C3=A9 (12):
>       target/riscv: Explode MO_TExx -> MO_TE | MO_xx
>       target/riscv: Conceal MO_TE within gen_amo()
>       target/riscv: Conceal MO_TE within gen_inc()
>       target/riscv: Conceal MO_TE within gen_load() / gen_store()
>       target/riscv: Conceal MO_TE within gen_load_idx() / gen_store_idx()
>       target/riscv: Conceal MO_TE within gen_fload_idx() / gen_fstore_idx=
()
>       target/riscv: Conceal MO_TE within gen_storepair_tl()
>       target/riscv: Conceal MO_TE within gen_cmpxchg*()
>       target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() / gen_sc()
>       target/riscv: Factor MemOp variable out when MO_TE is set
>       target/riscv: Introduce mo_endian() helper
>       target/riscv: Introduce mo_endian_env() helper
>
> Zejun Zhao (1):
>       hw/riscv: Correct mmu-type property of sifive_u harts in device tre=
e
>
>  include/hw/net/cadence_gem.h                  |  4 ++
>  target/riscv/cpu.h                            |  1 +
>  target/riscv/cpu_cfg_fields.h.inc             |  1 +
>  hw/intc/riscv_aclint.c                        | 18 ++++-
>  hw/intc/riscv_aplic.c                         | 42 ++++++++----
>  hw/net/cadence_gem.c                          | 31 +++++++--
>  hw/riscv/microchip_pfsoc.c                    |  6 ++
>  hw/riscv/sifive_u.c                           |  2 +-
>  target/riscv/cpu.c                            | 39 +++++++++++
>  target/riscv/cpu_helper.c                     |  3 +-
>  target/riscv/kvm/kvm-cpu.c                    |  1 +
>  target/riscv/op_helper.c                      | 30 +++++---
>  target/riscv/pmp.c                            | 46 +++++++++++++
>  target/riscv/riscv-qmp-cmds.c                 | 22 +++---
>  target/riscv/tcg/tcg-cpu.c                    | 12 ++--
>  target/riscv/translate.c                      | 16 ++++-
>  target/riscv/insn_trans/trans_rva.c.inc       | 50 ++++++++------
>  target/riscv/insn_trans/trans_rvd.c.inc       |  6 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |  6 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       | 24 ++++---
>  target/riscv/insn_trans/trans_rvzabha.c.inc   | 20 +++---
>  target/riscv/insn_trans/trans_rvzacas.c.inc   | 12 ++--
>  target/riscv/insn_trans/trans_rvzce.c.inc     | 12 ++--
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 +--
>  target/riscv/insn_trans/trans_xthead.c.inc    | 98 +++++++++++++++------=
------
>  26 files changed, 361 insertions(+), 159 deletions(-)

