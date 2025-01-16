Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580A9C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSAv-0006NC-Pd; Thu, 16 Jan 2025 10:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYSAu-0006MW-A2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYSAr-00075W-FP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737042768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NioJEozp/E/2+kjSR6XVEchx2tyOWGs0ZVwf67ilJAw=;
 b=e1PCI840wHQ8nnBjBPMf9qcA0XwESit/o/UmyaVKevudEIPQxZX7BsgaEAGtOSu9S3ZsDB
 2uI7dKoV4/5KgMGMn/KM+yDNUMRI+P5S4oKSiQoj0Ccyof2OF4h2WSXRtoXiRQ87Rjm8B4
 GA7Ja31MmE6n0j9kv7XkkfK3U/KDLTY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-xvpGwjPBPSqqhZtXOZfaEg-1; Thu,
 16 Jan 2025 10:52:44 -0500
X-MC-Unique: xvpGwjPBPSqqhZtXOZfaEg-1
X-Mimecast-MFC-AGG-ID: xvpGwjPBPSqqhZtXOZfaEg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 888F81955DC0; Thu, 16 Jan 2025 15:52:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.196.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77E1430001BE; Thu, 16 Jan 2025 15:52:41 +0000 (UTC)
Date: Thu, 16 Jan 2025 16:52:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
Message-ID: <Z4krRmzb3upAkUSI@redhat.com>
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
 <81befe6a-49fb-47bb-88fc-3fde73bb7c8c@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81befe6a-49fb-47bb-88fc-3fde73bb7c8c@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.01.2025 um 17:37 hat Fiona Ebner geschrieben:
> Am 09.01.25 um 11:47 schrieb Kevin Wolf:
> > Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
> >> Setting blk->root is a graph change operation and thus needs to be
> >> protected by the block graph write lock in blk_remove_bs(). The
> >> assignment to blk->root in blk_insert_bs() is already protected by
> >> the block graph write lock.
> > 
> > Hm, if that's the case, then we should also enforce this in the
> > declaration of BlockBackend:
> > 
> >     BdrvChild * GRAPH_RDLOCK_PTR root;
> > 
> > However, this results in more compiler failures that we need to fix. You
> > caught the only remaining writer, but the lock is only fully effective
> > if all readers take it, too.
> 
> I started giving this a try, but quickly ran into some issues/questions:
> 
> 1. For global state code, is it preferred to use
> GRAPH_RDLOCK_GUARD_MAINLOOP() to cover the whole function or better to
> use bdrv_graph_rd(un)lock_main_loop() to keep the locked section as
> small as necessary? I feel like the former can be more readable, e.g. in
> blk_insert_bs(), blk_new_open(), where blk->root is used in conditionals.

Yes, I think we generally use GRAPH_RDLOCK_GUARD_MAINLOOP() if there is
no read not to (e.g. if you need to take a writer lock in another part
of the same function). It's essentially only an assertion anyway, so it
doesn't even actually hold a real lock for longer than necessary.

> 2. In particular, protecting blk->root means that blk_bs() needs to have
> the read lock. In fact, blk_bs() is reading blk->root twice in a row, so
> it seems like it could suffer from a potential NULL pointer dereference
> (or I guess after compiler optimization a potential use-after-free)?
> 
> Since blk_bs() is IO_CODE() and not a coroutine, I tried to mark it
> GRAPH_RDLOCK and move on to the callers.

It looks like blk_bs() is tricky in general... blk_bs() is used in
iothreads in devices. Not sure how easy it would be to trigger a bug
there, but from the locking alone, it seems entirely possible to have
the device iothread race with the main thread changing the root node.

> However, one caller is blk_nb_sectors() which itself is called by
> blk_get_geometry(). Both of these are manually-written coroutine wrappers:
> 
> > commit 81f730d4d0e8af9c0211c3fedf406df0046341a9
> > Author: Paolo Bonzini <pbonzini@redhat.com>
> > Date:   Fri Apr 7 17:33:03 2023 +0200
> > 
> >     block, block-backend: write some hot coroutine wrappers by hand
> >     
> >     The introduction of the graph lock is causing blk_get_geometry, a hot function
> >     used in the I/O path, to create a coroutine.  However, the only part that really
> >     needs to run in coroutine context is the call to bdrv_co_refresh_total_sectors,
> >     which in turn only happens in the rare case of host CD-ROM devices.
> >     
> >     So, write by hand the three wrappers on the path from blk_co_get_geometry to
> >     bdrv_co_refresh_total_sectors, so that the coroutine wrapper is only created
> >     if bdrv_nb_sectors actually calls bdrv_refresh_total_sectors.
> 
> Both the blk_bs() and blk_nb_sectors() functions are IO_CODE(), but not
> coroutines, and callers of blk_get_geometry are already in the device
> code. I'm not sure how to proceed here, happy to hear suggestions :)

Being in device code is not necessarily a problem, we could be doing
stuff already there if we wanted.

The important question is, what would be the right behaviour? Can any of
the calls run while the writer lock is held?

If not, we can probably assert that and just take a reader lock
(bdrv_graph_co_rdlock() has to run in coroutine context only because it
might have to wait for a writer - if we know that there is none, we
could do it outside of a coroutine).

But if yes, then we either have a real bug that needs to be solved or
the protection is provided by something other than the graph lock. Maybe
the answer is that because of how devices access the field, the graph
lock isn't the right mechanism for protecting BlockBackend.root and we
should rely on draining instead?

We already try to do this:

    blk_drain(blk);
    root = blk->root;
    blk->root = NULL;

It would make more sense for this to be a drained_begin/end section that
quiesces devices while we're changing the root node, otherwise we can
get new requests before blk_drain() returns.

Do you know if the I/O request dereferencing a NULL pointer came from a
device? (The stack trace in your commit message is shortened too much to
tell me a lot, and the link to your forum doesn't allow me to view the
logs without registering an account. Please include more information in
the commit message in v2.)

Kevin


