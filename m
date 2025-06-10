Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A7DC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27g-0002cj-Pc; Tue, 10 Jun 2025 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOzQB-0002No-15
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:53:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOzQ8-0000xc-O2
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=PxHSVlTXF3CN5EaJ94PQ0UQ+RJDTRPfz+2E1RY81FsE=; b=lw92K/vfvEmw5t5O
 kQ28ug0m8Jnt1qx2Wo7OPSFYJ0os1WMG2ASIEgsTlIk8IZ+dhy9wZo35lexllzEA/hUQJc3DElgW6
 VSnasDUyctrohI7Xq/uUmj9CZRPTKFoSlbKqaTQK9EgTVU0DbCW7O/dsMzYcYO20SlYld3usETAqo
 ZL8NZoOaJXK8gSLpQVuGTWtlFTH9bw7W2R/prSfGOQeatP6yQ9jzHQg/YUwiUiZlbH6ItwqU23mks
 vtChKunL3E4jtyn10e3dxTc1AtTeU5sWZjAgM5wRJEWq3/by90QwUTAhwu6NdsjmT4qkcLqeIqPYN
 xiAPFfzD9VzVDUwdZA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uOzQ4-008epY-1q;
 Tue, 10 Jun 2025 13:53:40 +0000
Date: Tue, 10 Jun 2025 13:53:40 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEg45Bptc4QGq5gK@gallifrey>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
 <aEd3d07hQYXWc4eq@gallifrey> <aEg1iP9iXlYsQP0C@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aEg1iP9iXlYsQP0C@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:51:46 up 43 days, 22:05, 1 user, load average: 0.02, 0.03, 0.00
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
> On Tue, Jun 10, 2025 at 12:08:23AM +0000, Dr. David Alan Gilbert wrote:
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 4963f6ca12..e95b7402cb 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -236,6 +236,17 @@
> > >  #     This is only present when the postcopy-blocktime migration
> > >  #     capability is enabled.  (Since 3.0)
> > >  #
> > > +# @postcopy-latency: average remote page fault latency (in us).  Note that
> > > +#     this doesn't include all faults, but only the ones that require a
> > > +#     remote page request.  So it should be always bigger than the real
> > > +#     average page fault latency. This is only present when the
> > > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> > > +#
> > > +# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
> > > +#     us).  It has the same definition of @postcopy-latency, but instead
> > > +#     this is the per-vCPU statistics.  This is only present when the
> > > +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> > 
> > I wonder if even 'us' is too big; given you have 64bits to play with, and your
> > examples show some samples landing in under 10us, perhaps it's best
> > to at least define the qapi  fields as ns, even if you keep with the same
> > buckets for now?
> 
> The few <10us ones should pretty much be outliers, I'd expect it happened
> because some faulted pages got lucky to be migrated (in the background
> stream rather than the preempt stream) right after sending the request.
> 
> But it's still a fair point, especially if there's nothing to lose to
> switch to nanoseconds here when we have 64bits fields.. I also did a quick
> check online, looks like RDMA over 100Gbps NIC may actually do a fast
> round-robin transaction within a few microseconds indeed at least with zero
> loads..
> 
> Let me do the switch in v3.
> 
> While at it, when thinking of possible future unit/format changes in the
> report, maybe I should also mark all of these fields experimental from the
> start? So we don't necessarily need to maintain the ABI - the expectation
> is even if a mgmt would like to fetch those they should only fetch and dump
> it into log so that human can read later only for debugging purposes.

Yeh I think that's OK, although perhaps another way would be to add
a field indicating the time of the first bucket; i.e. you could specify
that all the values are in ns, but have first-bucket=1000 to be exactly
the same as you have it now.

Dave

> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

