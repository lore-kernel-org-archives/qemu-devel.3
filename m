Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91027606EEA0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=NBPWoYkH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvP0-0000CP-Fs; Thu, 05 Nov 2026 06:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvOe-00009U-LJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:12:48 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvOb-0002IV-IR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XvxfJl7xgvx+VXaH+T8qaeS4JDpZG2LtHa7swxf1mUI=; b=NBPWoYkH0c1gOJG
 SWi7hCC7w1aIRaPBSv5DJjeOXNOU5mm6BReWfP0Em+MupJF/uVPN2fv/fZQcC/7Qve8k0j4OE/Uja
 SDckgR1KV2xgx57vtLwoLcuzJeLrQsqPOkFH6GB6JRYd6sbKapnT+bRU8QLxhieb0y51jSqCyNF9i
 Y8=;
Date: Thu, 5 Nov 2026 12:18:11 +0100
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Subject: Re: [PATCH v1 3/6] target/hexagon: Forward return address to HLX
 load/store helpers
Message-ID: <auxla86wsN2-T7pF@hive.localdomain>
References: <20261103192358.28589-1-anjo@rev.ng>
 <20261103192358.28589-4-anjo@rev.ng>
 <CAJ+KCYOiTLRQnGg39uEMdPOb5g7j42TbdS2aPTc3skZGWNb0Kw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+KCYOiTLRQnGg39uEMdPOb5g7j42TbdS2aPTc3skZGWNb0Kw@mail.gmail.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04/11/26, Marco Liebel wrote:
> On Tue, Nov 3, 2026 at 1:18 PM Anton Johansson <anjo@rev.ng> wrote:
> >
> 
> Could you add a commit message body which explains what this fix is for?
> 
> > Fixes: 2db29a3615a5ad2a3 ("target/hexagon: add HLX helper support")
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  target/hexagon/macros.h     | 13 +++++++++----
> >  target/hexagon/hlx_helper.c | 31 ++++++++++++++++++++++---------
> >  2 files changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> > index 2748e26d6c..5799016ea4 100644
> > --- a/target/hexagon/macros.h
> > +++ b/target/hexagon/macros.h
> > @@ -22,6 +22,7 @@
> >  #include "hex_regs.h"
> >  #include "reg_fields.h"
> >  #include "accel/tcg/getpc.h"
> > +#include "hlx_helper.h"
> 
> hlx_helper.h is missing, so this commit (/series) doesn't build.
> 
> [...]
> 
> Does it make sense to write a test for this? How did you find it?
> 

Ah ofc I forgot to add it, my bad!  It's a fairly common mistake when
dealing with faulting helpers, and a mistake I've made plenty of times
myself.

-- 
Anton Johansson
rev.ng Labs Srl.

