Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E43C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vifnf-0004oq-Gv; Wed, 21 Jan 2026 16:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vifnd-0004nr-JH
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:31:37 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vifnb-0001sT-Sl
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=NAqNwxhSrJoIwAGHn4tWpMbpY39Axku5dj6wMreEEvI=; b=K+Uk0ncYU4CyMQ+V
 aBIyx4v0kYIDONDFHzlcnIeTGpqsgQndL5hsrSoy3HjdHrH1H5uCdVRIFKt5BXroqcVwBc17/C0k0
 UBizDQ+HBYElDmYsYhryo8HlQv7jOAHjtHLkO5dcGene8S2PSmlFqoe4asAh1xPGqsOOyS5QKA6ER
 GDnetxhHJb88aRGWWp6WwVhiQVUcywoiWlsSqh+JTC0/GGduWiq7HW8xzl+2+W2O+56yGBflVma0I
 DOaWbf0W+5j688/yd7uUiQFBU6zhphIwr/98wytd7nX5PVJtC5fnbhrwX3tq7r5T1bcc0y3jZ+nP8
 hnkYku3bGOWQHRJ+ng==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vifnV-0000000GT7R-28tk;
 Wed, 21 Jan 2026 21:31:29 +0000
Date: Wed, 21 Jan 2026 21:31:29 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aXFFsfqusBQtd5DI@gallifrey>
References: <20260117204913.584e1829@penguin> <aW6xNcsz3RIqHeE5@x1.local>
 <20260120110811.7df19a6c@penguin> <aW-mCye_eFmy5f4B@x1.local>
 <aW_Rqbc2Swg8vkXY@gallifrey> <aW_ccMSY4xJlRVn2@x1.local>
 <aXArDHMRAohmUt51@gallifrey> <aXEG73I8tJyhpn69@x1.local>
 <aXENdA6DP5j0ETIU@gallifrey> <aXE1i9xJ81EWokYz@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aXE1i9xJ81EWokYz@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 21:26:01 up 86 days, 21:02,  3 users,  load average: 0.10, 0.03, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
> On Wed, Jan 21, 2026 at 05:31:32PM +0000, Dr. David Alan Gilbert wrote:
> > Right that's true for postcopy; but then the only way to load the stream into
> > that buffer is to load it all at once because of the vmstate problem above.
> > (and because in the original postcopy we needed the original fd free
> > for page requests; you might be able to avoid that with multifd now)
> 
> Only until now, I recognized that COLO wants to make sure the checkpoint is
> either completely applied or none applied.
> 
> So the specialty is COLO does loadvm on top of a running VM, meanwhile COLO
> may decide to not loadvm afterwards if checkpoint wasn't correctly
> received.

Oh yes; because if your secondary is running happily, your primary could
fail while it was sending you a new snapshot - and then the secondary
has to be able to carry on.

> And yes, to cache all device states with current section header definition
> in the stream, we'll likely need a size.  We can still parse the stream as
> you pointed out previously, but I agree a special SIZE header still makes
> sense.

Well, *can't* parse the stream as I said; because of the get()/put() stuff
without rewriting that.

Dave

> I suppose that answers my question indeed, thanks!
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

