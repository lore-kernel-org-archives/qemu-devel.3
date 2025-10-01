Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D93CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3uf6-00037g-Mt; Wed, 01 Oct 2025 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v3uf2-00036D-RU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:06:16 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v3uev-0005WV-VL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=kaU533JRO2Q/hhnuGkdaydzLuYjZQvv6nDIA255VW5I=; b=YXjRBTg8bK6LtK+p
 ZqRrIaaxFHb36ut3xGOT0Q0LxOXgbQ9BE+e9WkMDuQuW4x20SBlBrXH2YCF+oB+53X1hOcjwmE7LT
 4m1NI9tbpjkQboVWPRKeoquTsLNlslUWP1QSNLaGVDtie/kUBScZmAp2eUzPojY+Ie3p4TLVJBQKm
 4B0dzSGS4H6yD9DZFSAflnlSLO4GcD+APHEVTN8f3hcsmCO9fcGYu81NQJFtD9sQ/a/aH7Fw7qYwW
 KBX1HPdVJ2io/9mntUAhSurPp+EScllIcxbPz9dzF97zOOcZHL7MT31t+bfDR1kja8ZHfuQCzw4E/
 60kO1y8yy9Xf0+a0EQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v3uel-00EGfm-0f;
 Wed, 01 Oct 2025 11:05:59 +0000
Date: Wed, 1 Oct 2025 11:05:59 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aN0LFzHSyF7dMtZ1@gallifrey>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net> <aNw35iWaNDnYXOz7@x1.local>
 <aNzpxr7N420TUIIf@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNzpxr7N420TUIIf@orkuz.int.mamuti.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:03:48 up 156 days, 19:17,  1 user,  load average: 0.00, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

* Jiří Denemark (jdenemar@redhat.com) wrote:
> On Tue, Sep 30, 2025 at 16:04:54 -0400, Peter Xu wrote:
> > On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> > > On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > > > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > > > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > > > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > > > do vm_start(), at the end of which RESUME event will be generated.  So
> > > > RESUME currently implies both disk activation success, and vm start worked.
> > > > 
> > > > > may still fail when locking disks fails (not sure if this is the only
> > > > > way cont may fail). In this case we cannot cancel the migration on the
> > > > 
> > > > Is there any known issue with locking disks that dest would fail?  This
> > > > really sound like we should have the admin taking a look.
> > > 
> > > Oh definitely, it would be some kind of an storage access issue on the
> > > destination. But we'd like to give the admin an option to actually do
> > > anything else than just killing the VM :-) Either by automatically
> > > canceling the migration or allowing recovery once storage issues are
> > > solved.
> > 
> > The problem is, if the storage locking stopped working properly, then how
> > to guarantee the shared storage itself is working properly?
> > 
> > When I was replying previously, I was expecting the admin taking a look to
> > fix the storage, I didn't expect the VM can still be recovered anymore if
> > there's no confidence that the block devices will work all fine.  The
> > locking errors to me may imply a block corruption already, or should I not
> > see it like that?
> 
> If the storage itself is broken, there's clearly nothing we can do. But
> the thing is we're accessing it from two distinct hosts. So while it may
> work on the source, it can be broken on the destination. For example,
> connection between the destination host and the storage may be broken.
> Not sure how often this can happen in real life, but we have a bug
> report that (artificially) breaking storage access on the destination
> results in paused VM on the source which can only be killed.

I've got a vague memory that a tricky case is when some of your storage
devices are broken on the destination, but not all.
So you tell the block layer you want to take them on the destination
some take their lock, one fails;  now what state are you in?
I'm not sure if the block layer had a way of telling you what state
you were in when I was last involved in that.

> So I believe we should do better if reasonably possible. People don't
> like losing their VMs just because they tried to migrate and something
> failed.

Nod.

Dave

> Jirka
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

