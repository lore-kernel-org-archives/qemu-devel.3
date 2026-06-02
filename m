Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF130CD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 02:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUETG-0005yx-Sj; Mon, 01 Jun 2026 22:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wUETE-0005yp-ID
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:03:08 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wUETC-0000ND-KP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 22:03:08 -0400
Received: from yuno-loong.localnet (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 120C2240AE8F;
 Tue, 02 Jun 2026 10:02:51 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: Re: [PATCH 00/12] target/loongarch: Move CSR registers to struct
 CPUSysState
Date: Tue, 02 Jun 2026 10:02:52 +0800
Message-ID: <lOb30Y5VTVyDy4BxZJsUCg@krgm.moe>
In-Reply-To: <b1872865-1748-e89b-f6ad-2f3104496563@loongson.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
 <e922a116-ae19-bb16-8dbb-5ad276430e5b@loongson.cn>
 <b1872865-1748-e89b-f6ad-2f3104496563@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026=E5=B9=B45=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 16:28:28=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/5/26 =E4=B8=8B=E5=8D=883:48, gaosong wrote:
> > =E5=9C=A8 2026/5/26 =E4=B8=8B=E5=8D=882:50, Bibo Mao =E5=86=99=E9=81=93:
> >> Here new structure CPUSysState is added in CPULoongArchState, CSR
> >> registers are move in CPUSysState. In later with LVZ supported, there=
=20
> >> will
> >> be two copied of CSR registers, so it is simply to add CPUSysState arr=
ay.
> >>
> >> Also new field curState is added which points to CPUSysState at
> >> beginning, and it can be changed during VM exit/enter entry. There is =
no
> >> function change, all is code movement or variable rename.
> >>
> >> Bibo Mao (12):
> >>    target/loongarch: Add new field curState in CPULoongArchState
> >>    target/loongarch: Use curState in cpu.c when accessing CSR registers
> >>    target/loongarch: Use curState in cpu_helper.c when accessing CSR
> >>      registers
> >>    target/loongarch: Use curState in file arch_dump.c when accessing C=
SR
> >>      registers
> >>    target/loongarch: Use curState in kvm.c when accessing CSR registers
> >>    target/loongarch: Use curState in tlb_helper.c when accessing CSR
> >>      registers
> >>    target/loongarch: Use curState in tcg_cpu.c when accessing CSR
> >>      registers
> >>    target/loongarch: Use curState in csr_helper.c when accessing CSR
> >>      registers
> >>    target/loongarch: Use curState in op_helper.c when accessing CSR
> >>      registers
> >>    target/loongarch: Add default CSRFL_BASIC info with flags field
> >>    target/loongarch: Add wrapper function get_csr_offset()
> >>    target/loongarch: Add new structure CPUSysState
> >>
> >>   hw/intc/loongarch_dintc.c                     |   4 +-
> >>   target/loongarch/arch_dump.c                  |   5 +-
> >>   target/loongarch/cpu-mmu.h                    |   4 +-
> >>   target/loongarch/cpu.c                        | 120 ++++-----
> >>   target/loongarch/cpu.h                        |  49 ++--
> >>   target/loongarch/cpu_helper.c                 |  41 ++--
> >>   target/loongarch/csr.c                        |  10 +-
> >>   target/loongarch/csr.h                        |   5 +
> >>   target/loongarch/gdbstub.c                    |   3 +-
> >>   target/loongarch/kvm/kvm.c                    | 228 +++++++++-------=
=2D-
> >>   target/loongarch/machine.c                    | 116 ++++-----
> >>   target/loongarch/tcg/constant_timer.c         |  10 +-
> >>   target/loongarch/tcg/csr_helper.c             |  55 +++--
> >>   .../tcg/insn_trans/trans_extra.c.inc          |  11 +-
> >>   .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
> >>   target/loongarch/tcg/op_helper.c              |  45 ++--
> >>   target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
> >>   target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
> >>   18 files changed, 531 insertions(+), 435 deletions(-)
> >>
> > Hi,
> > The files in linux-user/loongarch64/* also need to be modified.
> oops, loongarch-linux-user is missing here. Thanks for the reporting.
> Will add and test this target.
>=20
> Regards
> Bibo Mao
This patch looks good to me. Should I continue lvz support after this
patch is merged?

> >=20
> > Thanks.
> > Song Gao
> >> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>=20
>=20





