Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDC5C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMrg-0007lm-Jn; Thu, 20 Jun 2024 14:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sKMrd-0007lY-Af
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:50:29 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sKMra-0006i6-F2
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+9qC1Y6a3LSlHk5nZdyOUnkzXfrGfRDs4VreZYdpxQw=; b=wWNQw8Jw+L/bYcE
 zgCMe1A/+hKeCXqWHeBUl+bIFpy8VWegeVPWqCgYX467qqjw+1MihejoDIo6KD0Uod1OS0Xh/6+Dw
 TEAoe5szFgjJRszwJYA7/7JOXOCsel1wIm1IPjdgU3HM0gnwwiMmK9WZOiSEGRpkH0qkm9fdrmLhr
 CQ=;
Date: Thu, 20 Jun 2024 20:51:33 +0200
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, philmd@linaro.org
Subject: Re: [RFC PATCH 27/34] accel/tcg: Make translate-all.c target
 independent
Message-ID: <7apv5q34jgspbir3m7hdvh5wljingfoe472wa4x5suzqtaby5s@r3lswbbkn4tw>
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-28-anjo@rev.ng>
 <63dfead3-ddab-4502-b3aa-b7481a4f0ebc@linaro.org>
 <n5zuo5jky5zblncdnfitmch7fdy3qki6o5k5tyjpc7bmvkczck@7g6m6m7jukfb>
 <f0360d29-7348-4910-8057-849418049c6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0360d29-7348-4910-8057-849418049c6d@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/06/24, Richard Henderson wrote:
> On 6/13/24 02:50, Anton Johansson wrote:
> > On 24/01/24, Richard Henderson wrote:
> > > On 1/20/24 00:40, Anton Johansson wrote:
> > > > Makes translate-all.c independent of softmmu target by switching
> > > > 
> > > >       TARGET_LONG_BITS        -> target_long_bits()
> > > > 
> > > >       TARGET_INSN_START_WORDS -> tcg_ctx->insn_start_words,
> > > >                                  target_insn_start_words(),
> > > > 
> > > >       TCG_GUEST_DEFAULT_MO    -> target_default_memory_order()
> > > > 
> > > >       MO_TE                   -> target_endian_memory_order()
> > > > 
> > > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > ---
> > > >    accel/tcg/translate-all.c | 38 ++++++++++++++++++--------------------
> > > >    1 file changed, 18 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > > > index 9c981d1750..a3ae0c6910 100644
> > > > --- a/accel/tcg/translate-all.c
> > > > +++ b/accel/tcg/translate-all.c
> > > > @@ -65,7 +65,6 @@
> > > >    #include "internal-common.h"
> > > >    #include "internal-target.h"
> > > >    #include "perf.h"
> > > > -#include "tcg/insn-start-words.h"
> > > >    TBContext tb_ctx;
> > > > @@ -106,7 +105,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
> > > >            val |= (int64_t)(byte & 0x7f) << shift;
> > > >            shift += 7;
> > > >        } while (byte & 0x80);
> > > > -    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
> > > > +    if (shift < target_long_bits() && (byte & 0x40)) {
> > > 
> > > You just make TARGET_PAGE_SIZE etc target independent, right?
> > > So you don't need this?  Or is this because of user-only still.
> > 
> > Hi, Richard!
> > 
> > I missed this piece of feedback previously.  I don't see how
> > TARGET_PAGE_[SIZE|BITS] would be used here.  Are the values we're
> > encoding always TARGET_PAGE_BITS in size?
> 
> I was obviously tired here, since they're obviously unrelated.
> 
> However in this case I think TARGET_LONG_BITS is a red herring, and we
> should be using int64_t not target_long at all, and thus the shift count
> must be less than 64.
> 
> 
> r~
> 

Ah I see, thanks!:) I'll give that a go then.

-- 
Anton Johansson
rev.ng Labs Srl.

