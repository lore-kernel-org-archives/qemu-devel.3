Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9D9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FWF-0003Rk-5u; Mon, 29 Sep 2025 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1v3FWD-0003Qz-CU; Mon, 29 Sep 2025 11:10:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1v3FW9-0004vr-Ex; Mon, 29 Sep 2025 11:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=swcNK9nkmIT7lw+4DLQsV/KEKEerwGvPxiUBUQFSUIQ=; b=Is7MLzZqPZEZP60
 RUL0AfBU1M4R8BNm8+qCZTajheqlro/JlzT5DMajbGvggl5OO04u8pu3dgktJRHno6gqhtIJYbALO
 iNELcaHx9hU6Cnm/LjnXWhatwHNqi/AGQFR2aYHkgq5/4UJDG5ZuMCLWCyECgBeaTckh37gKCrHxQ
 44=;
Date: Mon, 29 Sep 2025 17:12:46 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-trivial@nongnu.org, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com,
 vhaudiquet <vhaudiquet343@hotmail.fr>
Subject: Re: [PATCH] target/riscv: Fix endianness swap on compressed
 instructions
Message-ID: <x6aqkgtvpzki7sgy7vkwqky76sfuvgs4qgf6g7jm2exks4j7tr@m76wj23zdejf>
References: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
 <cc5b1d2c-90cb-4276-a192-fd0ce9e926e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc5b1d2c-90cb-4276-a192-fd0ce9e926e8@linaro.org>
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

On 29/09/25, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> 
> On 29/9/25 13:55, Valentin Haudiquet wrote:
> > From: vhaudiquet <vhaudiquet343@hotmail.fr>
> > 
> > Three instructions were not using the endianness swap flag, which resulted in a bug on big-endian architectures.
> 
> I suppose you mean "big-endian host architectures".
> If so, please clarify.
> 
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
> > Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828
> > 
> > Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> > ---
> >   target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> > index c77c2b927b..dd15af0f54 100644
> > --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> > @@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
> >   static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
> >   {
> >       REQUIRE_ZCB(ctx);
> > -    return gen_load(ctx, a, MO_UW);
> > +    return gen_load(ctx, a, MO_TEUW);
> NAck.
> Please do not use MO_TE* anymore. Use explicit endianness.
> 
> So far all our RISC-V targets are little-endian:
> 
>   $ git grep TARGET_BIG_ENDIAN configs/targets/riscv*
>   $
> 
> If you are not worried about RISCV core running in BE mode
> (as we currently don't check MSTATUS_[USM]BE bits), your change
> should be:
> 
>  -    return gen_load(ctx, a, MO_UW);
>  +    return gen_load(ctx, a, MO_UW | MO_LE);
> 
> >   }
> 
> Regards,
> 
> Phil.

Right, I forgot about the MO_TE changes when reviewing. My bad.

//Anton

