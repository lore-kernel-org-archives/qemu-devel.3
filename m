Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0296CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1P4c-00035r-9I; Wed, 24 Sep 2025 08:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1P4Z-00035I-0w
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:58:15 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1P4T-0006RL-Er
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9eoNgbBqf+lW3hFmhhNUmtf2xELt+bIOMZDxpteIVpE=; b=lI5rNTmhkljmKSy
 ecSNdDse1HeZuekzwEI+FnzjIez1f51f2DSuM4ekb1I9GwtvuZxbPbOgy58XQTCWMl5obZXUJ8JkW
 oO3Un+3M4lE34aQDrnphJqdcOTsxiXkdlHZOvDuD9pxo9rS7qHyvS0zog2AIL3Tki7nZawd2h3Auk
 MY=;
Date: Wed, 24 Sep 2025 15:00:34 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [RFC PATCH 01/34] target/riscv: Use 32 bits for misa extensions
Message-ID: <b7356hmczc7qhofbuo7jevrwnev76epqpe2yni5qh7npigei26@ar4frawtml42>
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-2-anjo@rev.ng>
 <551c2907-32a1-401b-9ad6-2994bbbbe6cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <551c2907-32a1-401b-9ad6-2994bbbbe6cf@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24/09/25, Philippe Mathieu-Daudé wrote:
> On 24/9/25 09:20, Anton Johansson wrote:
> > uint32_t is already in use in most places storing misa extensions such
> > as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
> > RISCVImpliedExtsRule::implied_misa_exts, etc.
> 
> Also, the field is migrated as 32-bit:
> 
>   VMSTATE_UINT32(env.misa_ext, RISCVCPU),

Ah right!

> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 4a862da615..a0b2ef1cc1 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -50,7 +50,7 @@ typedef struct CPUArchState CPURISCVState;
> >    */
> >   #define RISCV_UW2_ALWAYS_STORE_AMO 1
> > -#define RV(x) ((target_ulong)1 << (x - 'A'))
> > +#define RV(x) ((uint32_t)1 << (x - 'A'))
> 
> 1u, or simply using BIT():
> 
>   #define RV(x) BIT(x - 'A')

I'll go for BIT() thanks:)

