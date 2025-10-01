Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD71CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ur9-0007AD-8N; Wed, 01 Oct 2025 07:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <macro@orcam.me.uk>) id 1v3ur0-000727-Po
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:18:41 -0400
Received: from angie.orcam.me.uk ([2001:4190:8020::34])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <macro@orcam.me.uk>) id 1v3uqs-0003RI-0d
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:18:38 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 428DD92009C; Wed,  1 Oct 2025 13:18:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 3B41092009B;
 Wed,  1 Oct 2025 12:18:09 +0100 (BST)
Date: Wed, 1 Oct 2025 12:18:09 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: YunQiang Su <syq@debian.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH] mips: pass code of conditional trap
In-Reply-To: <CAKcpw6WgSkJVwv4oU53-qUS2AGD=SEfpVumQmeYC7zWK0Ja4kA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2509280205020.47454@angie.orcam.me.uk>
References: <20240620234633.74447-1-syq@debian.org>
 <alpine.DEB.2.21.2406210124020.43454@angie.orcam.me.uk>
 <CAKcpw6Vc9QkHWGxJmJwipaqEnGJZsPof7k25i9e1trtCTDVc=A@mail.gmail.com>
 <alpine.DEB.2.21.2406211258060.43454@angie.orcam.me.uk>
 <CAKcpw6WgSkJVwv4oU53-qUS2AGD=SEfpVumQmeYC7zWK0Ja4kA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: none client-ip=2001:4190:8020::34;
 envelope-from=macro@orcam.me.uk; helo=angie.orcam.me.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, 27 Sep 2025, YunQiang Su wrote:

> > > >  What problem are you trying to solve?
> > >
> > > See the talk in GCC mailing list about testsuite/ubsan/overflow-div-3.c
> > > Qemu emits SIGTRAP instead of SIGFPE, due to it didn't initialize the
> > > code of conditional trap to env.
> >
> >  Self-contained information about the reproducer needs to be included in
> > the change description.  A general statement such as "this and that does
> > not work" or referring to another mailing list is not sufficient.
> 
> I am trying to fix the problem like this
> gcc/testsuite/gcc.c-torture/execute/20101011-1.c
> 
> void
> sigfpe (int signum __attribute__ ((unused)))
> {
>   exit (0);
> }
> 
> int
> main ()
> {
> #if DO_TEST
>   signal (SIGFPE, sigfpe);
>   k = i / j;
>   abort ();

 I gather QEMU in the user emulation mode fails to interpret the embedded 
break or trap code of a `teq $2,$0,7' or similar instruction produced by 
the compiler as a part of the integer division machine code sequence for 
the source code quoted above, and consequently issues the wrong signal to 
the program emulated.  Is that a correct statement of the problem?

 If so, then it has to be stated in the change description.  Then Richard 
has correctly identified the fix to make.

  Maciej

