Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA649CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut8mc-0000WN-7A; Mon, 01 Sep 2025 13:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1ut8mZ-0000Vi-VP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:57:31 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1ut8mX-0006Rk-UG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=LiY4F1HG34tTooN4i3TK1jSOzSTvkCatrzpKYsXlWSI=; b=DGnvVbYUwJxgP9u8
 ij9XqpCauj8cZZti64fS46BRNEeipvx50vVn3e7aTA5KJ28YtkpeGPyxWaYdhc5UkmgCYCPpBLxVX
 Oz1Bc3iBUqoOutpOzpWozyRaSsUFeqynR6OgghgkHAHQSVXhC0ZwBHZVECqspiqqVkATYghTW0rfV
 /xwxRpiNvnNpxeBkLnXcNhnzamjO9lAwHHkzU/O0rY/dY/8ZUsNHvVyCs45lQUbX5y1jPcEt8bYX+
 vaOuUHuivZnfU8z+bcTrg4E2hgMPLmBZoek8trQl9Ryg+mTaAquxCZRmMYQC1pjFeKqT9SlyQPhSg
 1m+B81hW+ZUazNP12w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1ut8mU-007rdD-1d;
 Mon, 01 Sep 2025 17:57:26 +0000
Date: Mon, 1 Sep 2025 17:57:26 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <aLXehgy3S5G6A3ub@gallifrey>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
 <aJ43_JQct45mnVgV@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aJ43_JQct45mnVgV@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:55:32 up 127 days,  2:09,  2 users,  load average: 0.00, 0.00,
 0.00
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
> On Thu, Aug 14, 2025 at 05:42:23PM +0200, Juraj Marcin wrote:
> > Fair point, I'll then continue with the PING/PONG solution, the first
> > implementation I have seems to be working to resolve Issue 1.
> > 
> > For rarer split brain, we'll rely on block device locks/mgmt to resolve
> > and change the failure handling, so it registers errors from disk
> > activation.
> > 
> > As tested, there should be no problems with the destination
> > transitioning to POSTCOPY_PAUSED, since the VM was not started yet.
> > 
> > However, to prevent the source side from transitioning to
> > POSTCOPY_PAUSED, I think adding a new state is still the best option.
> > 
> > I tried keeping the migration states as they are now and just rely on an
> > attribute of MigrationState if 3rd PONG was received, however, this
> > collides with (at least) migrate_pause tests, that are waiting for
> > POSTCOPY_ACTIVE, and then pause the migration triggering the source to
> > resume. We could maybe work around it by waiting for the 3rd pong
> > instead, but I am not sure if it is possible from tests, or by not
> > resuming if migrate_pause command is executed?
> > 
> > I also tried extending the span of the DEVICE state, but some functions
> > behave differently depending on if they are in postcopy or not, using
> > the migration_in_postcopy() function, but adding the DEVICE there isn't
> > working either. And treating the DEVICE state sometimes as postcopy and
> > sometimes as not seems just too messy, if it would even be possible.
> 
> Yeah, it might indeed be a bit messy.
> 
> Is it possible to find a middle ground?  E.g. add postcopy-setup status,
> but without any new knob to enable it?  Just to describe the period of time
> where dest QEMU haven't started running but started loading device states.
> 
> The hope is libvirt (which, AFAIU, always enables the "events" capability)
> can ignore the new postcopy-setup status transition, then maybe we can also
> introduce the postcopy-setup and make it always appear.

When the destination is started with '-S' (autostart=false), which is what
I think libvirt does, doesn't management only start the destination
after a certain useful event?
In other words, is there an event we already emit to say that the destination
has finished loading the postcopy devices, or could we just add that
event, so that management could just wait for that before issuing
the continue?

Dave

> Thanks,
> 
> -- 
> Peter Xu
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

