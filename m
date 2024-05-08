Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93580C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 14:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4iCV-00083A-3j; Wed, 08 May 2024 10:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s4iCT-000832-O5
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:23:17 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s4iCR-0000FR-L0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 10:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=f1Lk5qRs/YvBXQV9R4mnp+GPaBVqrdmTaPNt3LhIbLE=; b=i+HNkV9nFrcFi4k
 Ms8NNcbOOcknZaq7EYMrqekeWO1Gk0nk9w04wEJuf8rK0Px7r41SAfr6JJeMNd2B5rsOy48Mpc1L1
 aUbqX1ovwPkeLQ7XdFzb+wgVSvQK/vixm2t1D4MsNXNxoy5uQxxDndoy270UAtKyP/T9gdsA9YDoV
 ec=;
Date: Wed, 8 May 2024 16:24:01 +0200
To: ltaylorsimpson@gmail.com
Cc: qemu-devel@nongnu.org, ale@rev.ng, bcain@quicinc.com
Subject: Re: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
Message-ID: <jsusre6vphnnyoengz74djo2dvaoiz3auruhkmcc2pygv73w3u@hk7zhipgpbz6>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-4-anjo@rev.ng>
 <067f01da9fe7$51597590$f40c60b0$@gmail.com>
 <f7fmzerjibovuo7uevxmold5g6jvvjazfckhtv6tqkatpgbtzy@ging72uqq27r>
 <071701daa0c2$5988d450$0c9a7cf0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <071701daa0c2$5988d450$0c9a7cf0$@gmail.com>
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

On 07/05/24, ltaylorsimpson@gmail.com wrote:
> 
> 
> > -----Original Message-----
> > From: 'Anton Johansson' <anjo@rev.ng>
> > Sent: Tuesday, May 7, 2024 4:47 AM
> > To: ltaylorsimpson@gmail.com
> > Cc: qemu-devel@nongnu.org; ale@rev.ng; bcain@quicinc.com
> > Subject: Re: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
> > 
> > On 06/05/24, ltaylorsimpson@gmail.com wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Anton Johansson <anjo@rev.ng>
> > > > Sent: Monday, May 6, 2024 1:31 PM
> > > > To: qemu-devel@nongnu.org
> > > > Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> > > > Subject: [PATCH 3/4] target/hexagon: idef-parser fix leak of
> > > > init_list
> > > >
> > > > gen_inst_init_args() is called for instructions using a predicate as
> > > > an
> > > rvalue.
> > > > Upon first call, the list of arguments which might need
> > > > initialization
> > > init_list is
> > > > freed to indicate that they have been processed. For instructions
> > > > without
> > > an
> > > > rvalue predicate,
> > > > gen_inst_init_args() isn't called and init_list will never be freed.
> > > >
> > > > Free init_list from free_instruction() if it hasn't already been freed.
> > > >
> > > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > ---
> > > >  target/hexagon/idef-parser/parser-helpers.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/target/hexagon/idef-parser/parser-helpers.c
> > > > b/target/hexagon/idef-parser/parser-helpers.c
> > > > index 95f2b43076..bae01c2bb8 100644
> > > > --- a/target/hexagon/idef-parser/parser-helpers.c
> > > > +++ b/target/hexagon/idef-parser/parser-helpers.c
> > > > @@ -2121,6 +2121,13 @@ void free_instruction(Context *c)
> > > >          g_string_free(g_array_index(c->inst.strings, GString*, i), TRUE);
> > > >      }
> > > >      g_array_free(c->inst.strings, TRUE);
> > > > +    /*
> > > > +     * Free list of arguments that might need initialization, if
> > > > + they
> > > haven't
> > > > +     * already been free'd.
> > > > +     */
> > > > +    if (c->inst.init_list) {
> > > > +        g_array_free(c->inst.init_list, TRUE);
> > > > +    }
> > > >      /* Free INAME token value */
> > > >      g_string_free(c->inst.name, TRUE);
> > > >      /* Free variables and registers */
> > >
> > > Why not do this in gen_inst_init_args just before this?
> > >    /* Free argument init list once we have initialized everything */
> > >     g_array_free(c->inst.init_list, TRUE);
> > >     c->inst.init_list = NULL;
> > 
> > Thanks for the reviews Taylor! I'm not sure I understand what you mean
> > here, we already free init_list in gen_inst_init_args, since gen_inst_init_args
> > won't be called for all instructions we need to also free from a common
> > place.
> > 
> > //Anton
> 
> It just seems more natural to free the elements of the array at the same place you free the array itself.  If there are valid reasons for doing it elsewhere, I'm OK with that.
> 
> Taylor
> 
> 

Ah I see what you mean. The array and its elements are either freed in
gen_inst_init_args or free_instruction so they do occur together. The
"freeing of variables and registers" comment only refers to declared
TCGvs and has nothing to do with the arguments.

Comment is a bit outdated so I've updated it.

//Anton

