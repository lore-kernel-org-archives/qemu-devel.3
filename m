Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DDACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4J70-0004vc-Mc; Thu, 02 Oct 2025 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v4J6w-0004ue-Fb
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:12:42 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v4J6m-0002zr-Do
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Fm0RSVrOQhd6e/vp0R8GHa28guhOU8ZFjeL5Yc0roaY=; b=R/gUgCPf6AMVyct1
 KvFUAre4GeOgF2XGCvZEhmlf+Qfnzplr6LilG9a8dBGeG5dg1Zs1MblYf3iP6H04tz5Zek/LpEOkY
 pHabUvyEX2OfJP9eQGPaSPxGPCnZL0E1Wm0rmc9UzBya2k/iU2nyGPW6X+VhlI4EAt6XXIhEecrjE
 p3w95no96eUFozTLh0h4PBeTJoOskpL3wgmjvoTqQ4RMrF3laKZfSrWNl1EFTtAIvm1Hy0GnV5ZYQ
 tplu6AnhNsy514w49Zuo+GYRFvo61eI9zbV7DKoRvW7HynOA00FbXsRvc7X3Xr03zecXdCUId1gty
 JsKdq7te30gcb7phAw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v4J6Y-00EWyE-15;
 Thu, 02 Oct 2025 13:12:18 +0000
Date: Thu, 2 Oct 2025 13:12:18 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aN56MmzhmjCvZJoO@gallifrey>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net> <aNw35iWaNDnYXOz7@x1.local>
 <aNzpxr7N420TUIIf@orkuz.int.mamuti.net>
 <aN0LFzHSyF7dMtZ1@gallifrey> <aN1EdMGbLxE10NOp@redhat.com>
 <aN5tZuKfIx5OJK-i@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN5tZuKfIx5OJK-i@orkuz.int.mamuti.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:10:47 up 157 days, 21:24,  1 user,  load average: 0.04, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> On Wed, Oct 01, 2025 at 16:10:44 +0100, Daniel P. Berrangé wrote:
> > On Wed, Oct 01, 2025 at 11:05:59AM +0000, Dr. David Alan Gilbert wrote:
> > > * Jiří Denemark (jdenemar@redhat.com) wrote:
> > > > On Tue, Sep 30, 2025 at 16:04:54 -0400, Peter Xu wrote:
> > > > > On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> > > > > > On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > > > > > > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > > > > > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > > > > > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > > > > > > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > > > > > > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > > > > > > do vm_start(), at the end of which RESUME event will be generated.  So
> > > > > > > RESUME currently implies both disk activation success, and vm start worked.
> > > > > > > 
> > > > > > > > may still fail when locking disks fails (not sure if this is the only
> > > > > > > > way cont may fail). In this case we cannot cancel the migration on the
> > > > > > > 
> > > > > > > Is there any known issue with locking disks that dest would fail?  This
> > > > > > > really sound like we should have the admin taking a look.
> > > > > > 
> > > > > > Oh definitely, it would be some kind of an storage access issue on the
> > > > > > destination. But we'd like to give the admin an option to actually do
> > > > > > anything else than just killing the VM :-) Either by automatically
> > > > > > canceling the migration or allowing recovery once storage issues are
> > > > > > solved.
> > > > > 
> > > > > The problem is, if the storage locking stopped working properly, then how
> > > > > to guarantee the shared storage itself is working properly?
> > > > > 
> > > > > When I was replying previously, I was expecting the admin taking a look to
> > > > > fix the storage, I didn't expect the VM can still be recovered anymore if
> > > > > there's no confidence that the block devices will work all fine.  The
> > > > > locking errors to me may imply a block corruption already, or should I not
> > > > > see it like that?
> > > > 
> > > > If the storage itself is broken, there's clearly nothing we can do. But
> > > > the thing is we're accessing it from two distinct hosts. So while it may
> > > > work on the source, it can be broken on the destination. For example,
> > > > connection between the destination host and the storage may be broken.
> > > > Not sure how often this can happen in real life, but we have a bug
> > > > report that (artificially) breaking storage access on the destination
> > > > results in paused VM on the source which can only be killed.
> > > 
> > > I've got a vague memory that a tricky case is when some of your storage
> > > devices are broken on the destination, but not all.
> > > So you tell the block layer you want to take them on the destination
> > > some take their lock, one fails;  now what state are you in?
> > > I'm not sure if the block layer had a way of telling you what state
> > > you were in when I was last involved in that.
> > 
> > As long as the target QEMU CPUs have NOT started running, then
> > no I/O writes should have been sent to the storage, so the storage
> > should still be in a consistent state, and thus we can still try
> > to fail back to the source QEMU.
> > 
> > The "fun" problem here is that just because we /try/ to fail back
> > to the source QEMU, does not imply the source QEMU will now succeed
> > in re-acquiring the locks it just released a short time ago.
> 
> Right, but if we manage to get the source QEMU out of postcopy migration
> is such scenario, the VM may be manually resumed once storage issues are
> solved. So yes, we can't always rollback, but we should at least allow
> some kind of manual recovery.
> 
> > Consider the classic dead NFS server problem. The target may have
> > acquired 1 lock and failed on another lock because of a service
> > interruption to the NFS server. Well the target can't neccessarily
> > release the lock that it did successfully acquire now. So if we
> > fail back to the source, it'll be unable to reacquire the lock as
> > the target still holds it.
> > 
> > This doesn't mean we shouldn't try to fail back, but there will
> > always be some failures scenarios we'll struggle to recover from.
> > 
> > The "migration paused" state is our last chance, as that leaves
> > both QEMU's present while the admin tries to fix the underlying
> > problems.
> 
> IIUC from my conversation with Juraj switching to postcopy-paused can
> only happen when CPUs were already started.

But if you:
  a) Kill the destination
  b) Try to restart the source
  c) The source IO fails to restart

you could take the source to a normal 'paused' like you can do if storage
fails on the source. (as in -drive werror=stop  ?)

Dave

> Jirka
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

