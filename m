Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6167BC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 21:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHqcl-0003zY-GY; Wed, 21 May 2025 17:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uHqcc-0003xB-Od
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:05:06 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uHqca-0003fY-GA
 for qemu-devel@nongnu.org; Wed, 21 May 2025 17:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=tKdacZj8OH6t3UPaa1gZuBd9ZC3tb5PJkwf/WV6bcn8=; b=gDOswVxOM5kJ092o
 rDZ9gFEkAUWIneXgxaIVVVc1tyHfx6m5hv26oYJY8ZOtSJ2eiNlFQSfAL2fO1lUAJvDGLL8vh9WfU
 7KkzMAwCXoaBy14rVTy++2HUnKz4fOumGhpgSGOThdj01iaR35J/UBWms7cgHE05NmKm+VD5ezLfn
 qFgL6bnhpRHsxjVpDFwgMfPQ4TS0+9YTV/T82RecgHArxZ+FbcsvUpGmwTzhVfhMrTYSklx+hHM9t
 4neWNPySVaQWC8vMa2t8+l5JkDYK7ChfQtWn3rY1SyBB+tYWv0E25n0OQOdT1pZRtKeI2o3vi453l
 x4c4A8Mm+olB3SAbJA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uHqcU-0059PO-2E;
 Wed, 21 May 2025 21:04:58 +0000
Date: Wed, 21 May 2025 21:04:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the
 dump
Message-ID: <aC4_-nMc7FwsMf9p@gallifrey>
References: <20250514200137.581935-1-peterx@redhat.com>
 <20250514200137.581935-3-peterx@redhat.com>
 <26d8a22f-adfb-4990-8015-c24fd1304c8c@fujitsu.com>
 <aC3dJvwXK9eW1YO6@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aC3dJvwXK9eW1YO6@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:54:14 up 24 days, 5:07, 1 user, load average: 0.18, 0.06, 0.01
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
> On Wed, May 21, 2025 at 08:43:37AM +0000, Zhijian Li (Fujitsu) wrote:
> [...]
> > > After this change, sample output (default, no "-a" specified):
> > > 
> > >    Status: postcopy-active
> > >    Time (ms): total=40504, setup=14, down=145
> > >    RAM info:
> > >      Bandwidth (mbps): 6102.65
> > >      Sizes (KB): psize=4, total=16777992
> > >        transferred=37673019, remain=2136404,
> > >        precopy=3, multifd=26108780, postcopy=11563855
> > >      Pages: normal=9394288, zero=600672, rate_per_sec=185875
> > >      Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078
> > 
> > (Feel free to ignore my comment if you have reached a consensus.)
> > 
> > Putting multiple fields in one line is a true need for human reading?
> 
> It definitely helps me but I agree that can be subjective.  So I'm happy to
> collect opinions.
> 
> So my above layout was trying to leverage more on screens where width is
> bigger than the height (which is pretty much the default).

I think perhaps the problem with the on-one-line layout is that the grouping
is wrong;  grouping by unit probably doesn't make sense.

So it makes sense to me to have:
   Sizes: psize=4/KB
   Transfer: total=16777992 kB transferred=37673019 kB remain=11563855 kB
   Pages: normal=9394288 zero=600672
   Page rates: transferred=185875/s dirtied=278378/s
   Other: dirty_sync=3 postcopy_req=4078

so you have things on one line when you're comparing them - so it's easy
to see the transferred page/s is way less than the dirtied in this example
(really??)  because they're next to each other.
Or the 'Transfer' line is showing total, how much so far and how much remains

> > I don't have confident to reorg them so I feed this request to the AI,
> > he suggested something like this:
> > 
> > Migration Status:
> >    Status: completed
> > 
> > Time Statistics:
> >    Setup: 15 ms
> >    Downtime: 76 ms
> >    Total: 122952 ms
> > RAM Transfer:
> >    Throughput: 8717.68 mbps
> >    Page Size: 4 KB
> >    Transferred:
> >      Total: 130825923 KB
> >      Precopied: 15 KB
> >      Postcopied: 13691151 KB
> >      Multifd: 117134260 KB
> >    Remaining: 0 KB
> >    Total RAM: 16777992 KB
> > Page Statistics:
> >    Normal Pages: 32622225
> >    Zero Pages: 0
> >    Duplicate Pages: 997263
> >    Transfer Page Rate: 169431
> >    Dirty Page Rate: 1234
> >    Dirty Syncs: 10
> 
> I would trust you more than the AI, so feel free to share your opinion next
> time (which won't hurt if it was a result of AI discussions, but only which
> you agreed on :).

Haha, yes; whatever it is for those humans find easiest - that's the H in HMP!
(Those AIs can parse Json way easier than I can read Json!)

Of course you don't need to reorg it all at once again, if someone finds
one section hard, then reorg the way that people find it easy.

> It's already in a pull, let's revisit whenever necessary.  Thanks for the
> input!
> 

Nod.

Dave


> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

