Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557B1C54754
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFL5B-0005eL-Ct; Wed, 14 May 2025 19:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFL57-0005Y9-PK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:00:11 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFL55-0007QY-3n
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=yk0zoAr2QeV7ZF2HeaL/feAt9Q4dM/rOTh+hsCowH/0=; b=Q0dF1lfxZvzY2Zkj
 xkN64IKjeZxXMgc2xSw5zAgeDBC/XAJ4pne+xbPOZW0+FWu+9njnjyKQYatPXOjOTfxZm+mB1bkT6
 Lk0NSpZGKRVuZA3JSaTduRDLQT9Sc9hdOk0IQqNbCHPoZsuLMtZAObJ9MUsSRQ2Wsvwbna+IJc49h
 /+WFoid6NFoPPusNfzaajTHo6kmHKtSWOI3iYeANhdRM4VFJAKaJ5SFTLEp6/dqFb7LG2UuaLSwJe
 HfpiuRMpBCtC1npSsZ267hQZnNZ0TjRrbVzZ7CnDtexLLdMbeU1Ravg4ttYMrj+4tJUs36Y7/ww7w
 Ue+Tc5fu9JOLha2lgw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uFL52-003e2a-1N;
 Wed, 14 May 2025 23:00:04 +0000
Date: Wed, 14 May 2025 23:00:04 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aCUgdAj1PWfPZKIJ@gallifrey>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <aCT9QRPd4cDSshGI@gallifrey> <aCUITicykC-ppJrv@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aCUITicykC-ppJrv@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 22:57:09 up 17 days, 7:10, 1 user, load average: 0.00, 0.00, 0.00
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

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, May 14, 2025 at 08:29:53PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > A new parameter "-a" is added to "info migrate" to dump all info, while
> > > when not specified it only dumps the important ones.  When at it, reorg
> > > everything to make it easier to read for human.
> > > 
> > > The general rule is:
> > > 
> > >   - Put important things at the top
> > >   - Reuse a single line when things are very relevant, hence reducing lines
> > >     needed to show the results
> > >   - Remove almost useless ones (e.g. "normal_bytes", while we also have
> > >     both "page size" and "normal" pages)
> > >   - Regroup things, so that related fields will show together
> > >   - etc.
> > 
> > Thanks for the update,
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> Thanks for the quick comments!
> 
> > 
> > Note that you did miss the change (which would be fine as a follow up)
> > where I point out that I think your unit abbreviations are slightly wrong
> 
> Ouch, it's in the spam filter... :-( I would have missed that if you didn't
> mention it. I would think any decent AI models would do better than this..
> I have no idea how this could ever happen in 2025.

Ah...

> > (although I think I was wrong as well...)
> > I think your throughput is in Mbps (capital M or Mb/s or Mbit/s) - ie.
> > 10^6 bits/second.
> > 
> > While I think all your KB are KiB not KB (i.e. 2^10 bytes).
> 
> True..
> 
> Now I've read the missing reply:
> 
> https://lore.kernel.org/qemu-devel/aCSXjRCTYKbDf9le@gallifrey/
> 
> So yeh, mbps is in unit of bit, but all the rest needs fixing.  How about
> below fixup to be squashed (if I won't need to repost for v3):
> 
> PS: in the fixup I also did s/psize/pagesize/ to be clear

That's fine.

> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 13e93d3c54..ea76f72fa4 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -111,9 +111,9 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  
>      if (info->ram) {
>          monitor_printf(mon, "RAM info:\n");
> -        monitor_printf(mon, "  Throughput (mbps): %0.2f\n",
> +        monitor_printf(mon, "  Throughput (Mbps): %0.2f\n",
>                         info->ram->mbps);

Right.

> -        monitor_printf(mon, "  Sizes (KB): psize=%" PRIu64
> +        monitor_printf(mon, "  Sizes (KiB): pagesize=%" PRIu64

Right.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

>                         ", total=%" PRIu64 "\n",
>                         info->ram->page_size >> 10,
>                         info->ram->total >> 10);
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

