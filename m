Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yUR-0006aX-Rq; Wed, 01 Oct 2025 11:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3yUN-0006U1-2T
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3yU3-0001ee-Op
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759331455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63Z6b/EH/N5G+8Nwqkl2CrTapG8XTez3aMv5q68Pqus=;
 b=jAiOO4rSHAkSsavQF0lngnk9WgN4Os/it0hwsGgP6sw6uTBXOV9CQ+a0N+TAF25Etwv68F
 faiZgQSjLCtbMeXRmSiCa7p3yag6sRrGL5T14z6Hzvud4+xWCDtrWJ4ioRC0oTOwv6XYyn
 WSMw/VCy5ANY0ZefwLk0zLGKykvg7XQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-tk2OTQMdNxm-kezCAcUBVg-1; Wed,
 01 Oct 2025 11:10:52 -0400
X-MC-Unique: tk2OTQMdNxm-kezCAcUBVg-1
X-Mimecast-MFC-AGG-ID: tk2OTQMdNxm-kezCAcUBVg_1759331451
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D122918002C3; Wed,  1 Oct 2025 15:10:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4310180035E; Wed,  1 Oct 2025 15:10:48 +0000 (UTC)
Date: Wed, 1 Oct 2025 16:10:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aN1EdMGbLxE10NOp@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net> <aNw35iWaNDnYXOz7@x1.local>
 <aNzpxr7N420TUIIf@orkuz.int.mamuti.net>
 <aN0LFzHSyF7dMtZ1@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN0LFzHSyF7dMtZ1@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 01, 2025 at 11:05:59AM +0000, Dr. David Alan Gilbert wrote:
> * Jiří Denemark (jdenemar@redhat.com) wrote:
> > On Tue, Sep 30, 2025 at 16:04:54 -0400, Peter Xu wrote:
> > > On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> > > > On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > > > > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > > > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > > > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > > > > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > > > > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > > > > do vm_start(), at the end of which RESUME event will be generated.  So
> > > > > RESUME currently implies both disk activation success, and vm start worked.
> > > > > 
> > > > > > may still fail when locking disks fails (not sure if this is the only
> > > > > > way cont may fail). In this case we cannot cancel the migration on the
> > > > > 
> > > > > Is there any known issue with locking disks that dest would fail?  This
> > > > > really sound like we should have the admin taking a look.
> > > > 
> > > > Oh definitely, it would be some kind of an storage access issue on the
> > > > destination. But we'd like to give the admin an option to actually do
> > > > anything else than just killing the VM :-) Either by automatically
> > > > canceling the migration or allowing recovery once storage issues are
> > > > solved.
> > > 
> > > The problem is, if the storage locking stopped working properly, then how
> > > to guarantee the shared storage itself is working properly?
> > > 
> > > When I was replying previously, I was expecting the admin taking a look to
> > > fix the storage, I didn't expect the VM can still be recovered anymore if
> > > there's no confidence that the block devices will work all fine.  The
> > > locking errors to me may imply a block corruption already, or should I not
> > > see it like that?
> > 
> > If the storage itself is broken, there's clearly nothing we can do. But
> > the thing is we're accessing it from two distinct hosts. So while it may
> > work on the source, it can be broken on the destination. For example,
> > connection between the destination host and the storage may be broken.
> > Not sure how often this can happen in real life, but we have a bug
> > report that (artificially) breaking storage access on the destination
> > results in paused VM on the source which can only be killed.
> 
> I've got a vague memory that a tricky case is when some of your storage
> devices are broken on the destination, but not all.
> So you tell the block layer you want to take them on the destination
> some take their lock, one fails;  now what state are you in?
> I'm not sure if the block layer had a way of telling you what state
> you were in when I was last involved in that.

As long as the target QEMU CPUs have NOT started running, then
no I/O writes should have been sent to the storage, so the storage
should still be in a consistent state, and thus we can still try
to fail back to the source QEMU.

The "fun" problem here is that just because we /try/ to fail back
to the source QEMU, does not imply the source QEMU will now succeed
in re-acquiring the locks it just released a short time ago.

Consider the classic dead NFS server problem. The target may have
acquired 1 lock and failed on another lock because of a service
interruption to the NFS server. Well the target can't neccessarily
release the lock that it did successfully acquire now. So if we
fail back to the source, it'll be unable to reacquire the lock as
the target still holds it.

This doesn't mean we shouldn't try to fail back, but there will
always be some failures scenarios we'll struggle to recover from.

The "migration paused" state is our last chance, as that leaves
both QEMU's present while the admin tries to fix the underlying
problems.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


