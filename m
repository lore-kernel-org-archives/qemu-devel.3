Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32A5C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTxg-0001nm-Vd; Thu, 13 Aug 2026 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wuTxb-0001mv-2d; Thu, 13 Aug 2026 07:50:59 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wuTxZ-0002KJ-4R; Thu, 13 Aug 2026 07:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=I67k8YxoLBe9J/4gOxpVNagKSR4dzDYl4ybXJ796l3g=; b=XAjHe18rGOsRLOo
 q429HA3+y1MfvPN9soww8gIXdQ06WSpbu7Wi0HRM/0mWB+PGofW7uy1xOK9TShw0EZH46MAMcgxcz
 mJ7UhYqjpdGA+DW3lf95cNUgIxgpOUHDdQaWbwYwMJm3DfTs2cdIqfYbKaSNYMH2lqvccqnwkU0Ra
 Z4=;
Date: Thu, 13 Aug 2026 13:56:02 +0200
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/riscv: Restore register dump zero padding
Message-ID: <an2wqzgtLnuCUq3C@hive.localdomain>
References: <20260813032421.54438-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813032421.54438-1-joel@jms.id.au>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/08/26, Joel Stanley wrote:
> The register values lost their leading zeroes when the underlying type
> was changed, resulting in mismatched padding and harder to read output.
> 
> Print with a runtime field width based on MXL, so values are 16 hex
> digits on rv64 and 8 on rv32, matching the csr and fp dump. This avoids
> adding target_ulong back into the dump.
> 
> Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> before:
> 
>  mvendorid     0000000000000000
>  marchid       000000000000002a
>  mimpid        0000000000000000
>  mhartid       0000000000000000
>  mconfigptr    0000000000000000
>  x0/zero  0 x1/ra    ffffffff803f10f6 x2/sp    ff2000000000bc70 x3/gp    ffffffff805c94c0
>  x4/tp    ff60000000c78000 x5/t0    ffffffff803f132c x6/t1    0 x7/t2    20646e65205b2d2d
>  x8/s0    ff2000000000bc80 x9/s1    708 x10/a0   270f x11/a1   8
>  x12/a2   0 x13/a3   120 x14/a4   14992a1 x15/a5   ffffffffffffffff
>  x16/a6   fffff079 x17/a7   79 x18/s2   0 x19/s3   7d0
>  x20/s4   ffffffff805ca228 x21/s5   31 x22/s6   ff60000000e15000 x23/s7   ffffffff804228c8
>  x24/s8   0 x25/s9   ffffffff804e3e90 x26/s10  0 x27/s11  0
>  x28/t3   ff60000000c60f00 x29/t4   ff60000000c60f00 x30/t5   ff60000000c60000 x31/t6   ff2000000000bc28
>  fflags        0000000000000000
>  frm           0000000000000000
>  fcsr          0000000000000000
>  f0/ft0   ffffffff00000000 f1/ft1   ffffffff00000000 f2/ft2   ffffffff00000000 f3/ft3   ffffffff00000000
>  f4/ft4   ffffffff00000000 f5/ft5   ffffffff00000000 f6/ft6   ffffffff00000000 f7/ft7   ffffffff00000000
>  f8/fs0   ffffffff00000000 f9/fs1   ffffffff00000000 f10/fa0  ffffffff00000000 f11/fa1  ffffffff00000000
>  f12/fa2  ffffffff00000000 f13/fa3  ffffffff00000000 f14/fa4  ffffffff00000000 f15/fa5  ffffffff00000000
>  f16/fa6  ffffffff00000000 f17/fa7  ffffffff00000000 f18/fs2  ffffffff00000000 f19/fs3  ffffffff00000000
>  f20/fs4  ffffffff00000000 f21/fs5  ffffffff00000000 f22/fs6  ffffffff00000000 f23/fs7  ffffffff00000000
>  f24/fs8  ffffffff00000000 f25/fs9  ffffffff00000000 f26/fs10 ffffffff00000000 f27/fs11 ffffffff00000000
>  f28/ft8  ffffffff00000000 f29/ft9  ffffffff00000000 f30/ft10 ffffffff00000000 f31/ft11 ffffffff00000000
> 
> after:
> 
>  mvendorid     0000000000000000
>  marchid       000000000000002a
>  mimpid        0000000000000000
>  mhartid       0000000000000000
>  mconfigptr    0000000000000000
>  x0/zero  0000000000000000 x1/ra    ffffffff803f10f6 x2/sp    ff2000000000bc70 x3/gp    ffffffff805c94c0
>  x4/tp    ff60000000c78000 x5/t0    ffffffff803f132c x6/t1    0000000000000000 x7/t2    20646e65205b2d2d
>  x8/s0    ff2000000000bc80 x9/s1    0000000000000e10 x10/a0   000000000000270f x11/a1   0000000000000008
>  x12/a2   0000000000000000 x13/a3   0000000000000120 x14/a4   0000000002575fd6 x15/a5   ffffffffffffffff
>  x16/a6   00000000fffff079 x17/a7   0000000000000079 x18/s2   0000000000000001 x19/s3   0000000000000ed8
>  x20/s4   ffffffff805ca228 x21/s5   0000000000000060 x22/s6   ff60000000e15000 x23/s7   ffffffff804228c8
>  x24/s8   0000000000000000 x25/s9   ffffffff804e3e90 x26/s10  0000000000000000 x27/s11  0000000000000000
>  x28/t3   ff60000000c60f00 x29/t4   ff60000000c60f00 x30/t5   ff60000000c60000 x31/t6   ff2000000000bc28
>  fflags        0000000000000000
>  frm           0000000000000000
>  fcsr          0000000000000000
>  f0/ft0   ffffffff00000000 f1/ft1   ffffffff00000000 f2/ft2   ffffffff00000000 f3/ft3   ffffffff00000000
>  f4/ft4   ffffffff00000000 f5/ft5   ffffffff00000000 f6/ft6   ffffffff00000000 f7/ft7   ffffffff00000000
>  f8/fs0   ffffffff00000000 f9/fs1   ffffffff00000000 f10/fa0  ffffffff00000000 f11/fa1  ffffffff00000000
>  f12/fa2  ffffffff00000000 f13/fa3  ffffffff00000000 f14/fa4  ffffffff00000000 f15/fa5  ffffffff00000000
>  f16/fa6  ffffffff00000000 f17/fa7  ffffffff00000000 f18/fs2  ffffffff00000000 f19/fs3  ffffffff00000000
>  f20/fs4  ffffffff00000000 f21/fs5  ffffffff00000000 f22/fs6  ffffffff00000000 f23/fs7  ffffffff00000000
>  f24/fs8  ffffffff00000000 f25/fs9  ffffffff00000000 f26/fs10 ffffffff00000000 f27/fs11 ffffffff00000000
>  f28/ft8  ffffffff00000000 f29/ft9  ffffffff00000000 f30/ft10 ffffffff00000000 f31/ft11 ffffffff00000000
> 
> I also wrote a patch to align the first column of register values, but
> that creates the dilemma between aligning the numbers vs keeping the
> spacing between the registers and their value within a row. Aside from
> avoiding bikeshedding, it wastes more columns for an already wide
> output, so opted not to 'fix' that.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  target/riscv/cpu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Nice, thank you!:)

Reviewed-by: Anton Johansson <anjo@rev.ng>

