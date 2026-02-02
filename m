Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330A6E7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmv28-0000Tt-Eo; Mon, 02 Feb 2026 09:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vmv27-0000TX-Cx; Mon, 02 Feb 2026 09:36:07 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1vmv26-0000Tf-1F; Mon, 02 Feb 2026 09:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=6Zu+q+wZAU5r6s0l/ojLBcwELAMqHbycB+3xFm7N2yk=; b=tn95IyxXo6ihqvY
 i1OpxxtmsjlJwbZo2ay+/Z5NupuabBmqdHhh3Tu38uKoMIh6FG7SGQriIGmnHV0AwB0EWtD9sIdqN
 yP2l7k83B7lS4kkNXKtjsYpKUpGzQx01TC8B28zpPkH+buam8uQZUTj/P0N4+iggaH/49gzQ2+k88
 Q8=;
Date: Mon, 2 Feb 2026 15:39:35 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 06/11] target/ppc: Introduce ppc_code_endian() helper
Message-ID: <aYC28VNE0yNjlJw6@hive.localdomain>
References: <20260122221106.57184-1-philmd@linaro.org>
 <20260122221106.57184-7-philmd@linaro.org>
 <aYC1bfhw1CtIED8Y@hive.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYC1bfhw1CtIED8Y@hive.localdomain>
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

On 02/02/26, Anton Johansson wrote:
> On 22/01/26, Philippe Mathieu-Daudé wrote:
> > Introduce the ppc_code_endian() helper which returns the
> > MemOp endianness for the CODE path.
> > 
> > Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  target/ppc/translate.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 17e6d07c8c2..4a9199a4473 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -214,14 +214,15 @@ static inline bool is_ppe(const DisasContext *ctx)
> >      return !!(ctx->flags & POWERPC_FLAG_PPE42);
> >  }
> >  
> > +static inline MemOp ppc_code_endian(const DisasContext *ctx)
> > +{
> > +    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
> > +}
> 
> This was not super obvious to me, is this a common pattern?

Ignore this comment, I see we do it for translator_ld*()!:)

