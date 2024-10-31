Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C252D6B6B4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 00:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6J5s-0005Zo-6Z; Wed, 30 Oct 2024 20:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1t6J5p-0005Ze-QA
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 20:31:18 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1t6J5o-0000aq-1F
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 20:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=RZDZhoMYhZ5jqjph3ksyRzRSw5oxvewBtAayqrdS1BA=; b=OONWsNiMoRqLZ0E1
 fhnoCZIhXOihhv3jTq93np5M688tsS4fpLRQHZGREGM59a2JIjmUNDV50iP3nmo0ZK/dH/r3R0YUn
 kUPjuZ7K+dQvP18VzPdGKAmS4ZbVplPaOss0K4pItQuqZa2HBJdqh2QCgWkZlzPIF/aMNHksut0id
 Wx5g5b/8eFjaNXB37UffMZo9O6Mdi3yIMzLjuG60h9iLOGIUcAyTribFG5oouyO9pek2z+pKgV5NN
 9cbO+20LLmyQdtiVTA9V3zRsOIbjqG6X0r+4++YLMnAohYRVLd9gliJ9w1lsWSwbjiM7ImaEVlOM/
 nDS/bKC07/i5nsiNaQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1t6J5h-00EcAh-2F;
 Thu, 31 Oct 2024 00:31:09 +0000
Date: Thu, 31 Oct 2024 00:31:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] monitor: fix cases in switch in memory_dump
Message-ID: <ZyLPzbDy_0cI7HyD@gallifrey>
References: <20241030140656.36540-1-abelova@astralinux.ru>
 <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:29:10 up 175 days, 11:43,  1 user,  load average: 0.03, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Phil Dennis-Jordan (lists@philjordan.eu) wrote:
> On Wed 30. Oct 2024 at 15:09, Anastasia Belova <abelova@astralinux.ru>
> wrote:
> 
> > default case has no condition. So if it is placed
> > higher that other cases, they are unreachable.
> >
> > Move dafult case down.
> >
> 
> The stylistic merits might be debatable, but: the order of cases in a
> switch block in C does not matter, the default case can appear anywhere.
> The other cases are still reachable. So at minimum, the commit message is
> incorrect.

I'd agree;  the analysis is wrong - it works as intended.
As for style, I'd normally agree that 'default' at end makes sense,
but:
  a) I hate duplicating code
  b) in a way this reads nicely:
                 default:
                 case 1:

      'default is the same as case 1'.

Dave

> 
> 
> > Found by Linux Verification Center (linuxtesting.org)
> >
> > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> > ---
> >  monitor/hmp-cmds-target.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> > index ff01cf9d8d..eea8ca047b 100644
> > --- a/monitor/hmp-cmds-target.c
> > +++ b/monitor/hmp-cmds-target.c
> > @@ -189,7 +189,6 @@ static void memory_dump(Monitor *mon, int count, int
> > format, int wsize,
> >          i = 0;
> >          while (i < l) {
> >              switch(wsize) {
> > -            default:
> >              case 1:
> >                  v = ldub_p(buf + i);
> >                  break;
> > @@ -202,6 +201,9 @@ static void memory_dump(Monitor *mon, int count, int
> > format, int wsize,
> >              case 8:
> >                  v = ldq_p(buf + i);
> >                  break;
> > +            default:
> > +                v = ldub_p(buf + i);
> > +                break;
> >              }
> >              monitor_printf(mon, " ");
> >              switch(format) {
> > --
> > 2.47.0
> >
> >
> >
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

