Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E855C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Iox-0003oa-5S; Tue, 07 May 2024 07:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s4Ioq-0003k8-6V
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:17:12 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s4Ioo-00048q-Dv
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+3lAuG6dD9BYd00oq6jQN6agoXMrIMvZsXqVbs5g+rY=; b=Qk7F7pBGE0OHEeW
 e3ItHYPjZztHDRt9WQoYcN0TEPl29xwZQ28fPzeycOr/2Gmay/vOFX4D8B/tnnerwloiHtmhKuugO
 WImLlRBM1BoWLA3VF0dNeOD2rwaLA6jcwBYY4wmOOqq2YscDbJZnYsMQXfBGySuS4Is9uDruhNVP7
 e4=;
Date: Tue, 7 May 2024 13:18:28 +0200
To: ltaylorsimpson@gmail.com
Cc: qemu-devel@nongnu.org, ale@rev.ng, bcain@quicinc.com
Subject: Re: [PATCH 4/4] target/hexagon: idef-parser simplify predicate init
Message-ID: <jx7e3hvlsxld3h7736twjjaoaguamzeqtonjnrpr4yzmz44qlj@4paocplivllt>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-5-anjo@rev.ng>
 <067e01da9fe7$4ffddd30$eff99790$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <067e01da9fe7$4ffddd30$eff99790$@gmail.com>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  'Anton Johansson' <anjo@rev.ng>
From:  'Anton Johansson' via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 06/05/24, ltaylorsimpson@gmail.com wrote:
> 
> 
> > -----Original Message-----
> > From: Anton Johansson <anjo@rev.ng>
> > Sent: Monday, May 6, 2024 1:31 PM
> > To: qemu-devel@nongnu.org
> > Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> > Subject: [PATCH 4/4] target/hexagon: idef-parser simplify predicate init
> > 
> > Only predicate instruction arguments need to be initialized by
> idef-parser.
> > This commit removes registers from the init_list and simplifies
> > gen_inst_init_args() slightly.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  target/hexagon/idef-parser/idef-parser.y    |  2 --
> >  target/hexagon/idef-parser/parser-helpers.c | 20 +++++++++-----------
> >  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> > diff --git a/target/hexagon/idef-parser/parser-helpers.c
> > b/target/hexagon/idef-parser/parser-helpers.c
> > index bae01c2bb8..33e8f82007 100644
> > --- a/target/hexagon/idef-parser/parser-helpers.c
> > +++ b/target/hexagon/idef-parser/parser-helpers.c
> > @@ -1652,26 +1652,24 @@ void gen_inst(Context *c, GString *iname)
> > 
> >  void gen_inst_init_args(Context *c, YYLTYPE *locp)  {
> > +    /* If init_list is NULL arguments have already been initialized */
> >      if (!c->inst.init_list) {
> >          return;
> >      }
> > 
> >      for (unsigned i = 0; i < c->inst.init_list->len; i++) {
> >          HexValue *val = &g_array_index(c->inst.init_list, HexValue, i);
> > -        if (val->type == REGISTER_ARG) {
> > -            /* Nothing to do here */
> > -        } else if (val->type == PREDICATE) {
> > -            char suffix = val->is_dotnew ? 'N' : 'V';
> > -            EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
> > -                      val->pred.id, suffix);
> > -        } else {
> > -            yyassert(c, locp, false, "Invalid arg type!");
> > -        }
> > +        yyassert(c, locp, val->type == PREDICATE,
> > +                 "Only predicates need to be initialized!");
> > +        char suffix = val->is_dotnew ? 'N' : 'V';
> 
> Declarations should be at the beginning of the function per QEMU coding
> standards.

Agh right!

>
> > +        EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
> 
> Since you know this is a predicate, the bit_width will always be 32.  You
> can hard-code that instead of using %u.

Good point, I'll add a paranoia assertion as well.

//Anton

