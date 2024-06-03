Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8788C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAQw-0001wj-St; Mon, 03 Jun 2024 12:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEAQv-0001w1-75
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEAQt-0003qF-06
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717431673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9NGXLaWkdgrBttknLaNp1KhjQ9mO0TnZBGp6ufufS4=;
 b=Q4IuMpbKZxJus9L6u6GrZdImq5QrzdyBV9h5G/NTWQrwBz3mb95PJTaTQVr7D9dSMu0a6d
 jp1tvuvR2jruC4qEU+xoxJpOaFYTIPXv0nX068qFFRYpibw/a+Vpd+Szbca5nAxqeCwmcC
 brWjTAL41+S2zbJQw/yK4eyj3NXPvMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303--mufUT4QNkajVBcCaD-sOA-1; Mon, 03 Jun 2024 12:21:11 -0400
X-MC-Unique: -mufUT4QNkajVBcCaD-sOA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5D76812296;
 Mon,  3 Jun 2024 16:21:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DB4402EB5;
 Mon,  3 Jun 2024 16:21:06 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:21:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 2/4] block-backend: fix edge case in bdrv_next() where
 BDS associated to BB changes
Message-ID: <Zl3tcRie6y3wEpsP@redhat.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-3-f.ebner@proxmox.com>
 <ZgLDEdmI0rBcJcGh@redhat.com>
 <bf1537a6-0597-4e82-8b42-32364a6246a3@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1537a6-0597-4e82-8b42-32364a6246a3@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 03.06.2024 um 16:17 hat Fiona Ebner geschrieben:
> Hi Kevin,
> 
> Am 26.03.24 um 13:44 schrieb Kevin Wolf:
> > Am 22.03.2024 um 10:50 hat Fiona Ebner geschrieben:
> >> The old_bs variable in bdrv_next() is currently determined by looking
> >> at the old block backend. However, if the block graph changes before
> >> the next bdrv_next() call, it might be that the associated BDS is not
> >> the same that was referenced previously. In that case, the wrong BDS
> >> is unreferenced, leading to an assertion failure later:
> >>
> >>> bdrv_unref: Assertion `bs->refcnt > 0' failed.
> > 
> > Your change makes sense, but in theory it shouldn't make a difference.
> > The real bug is in the caller, you can't allow graph modifications while
> > iterating the list of nodes. Even if it doesn't crash (like after your
> > patch), you don't have any guarantee that you will have seen every node
> > that exists that the end - and maybe not even that you don't get the
> > same node twice.
> > 
> >> In particular, this can happen in the context of bdrv_flush_all(),
> >> when polling for bdrv_co_flush() in the generated co-wrapper leads to
> >> a graph change (for example with a stream block job [0]).
> > 
> > The whole locking around this case is a bit tricky and would deserve
> > some cleanup.
> > 
> > The basic rule for bdrv_next() callers is that they need to hold the
> > graph reader lock as long as they are iterating the graph, otherwise
> > it's not safe. This implies that the ref/unref pairs in it should never
> > make a difference either - which is important, because at least
> > releasing the last reference is forbidden while holding the graph lock.
> > I intended to remove the ref/unref for bdrv_next(), but I didn't because
> > I realised that the callers need to be audited first that they really
> > obey the rules. You found one that would be problematic.
> > 
> > The thing that bdrv_flush_all() gets wrong is that it promises to follow
> > the graph lock rules with GRAPH_RDLOCK_GUARD_MAINLOOP(), but then calls
> > something that polls. The compiler can't catch this because bdrv_flush()
> > is a co_wrapper_mixed_bdrv_rdlock. The behaviour for these functions is:
> > 
> > - If called outside of coroutine context, they are GRAPH_UNLOCKED
> > - If called in coroutine context, they are GRAPH_RDLOCK
> > 
> > We should probably try harder to get rid of the mixed functions, because
> > a synchronous co_wrapper_bdrv_rdlock could actually be marked
> > GRAPH_UNLOCKED in the code and then the compiler could catch this case.
> > 
> > The fix for bdrv_flush_all() is probably to make it bdrv_co_flush_all()
> > with a coroutine wrapper so that the graph lock is held for the whole
> > function. Then calling bdrv_co_flush() while iterating the list is safe
> > and doesn't allow concurrent graph modifications.
> 
> I attempted this now, but ran into two issues:
> 
> The first is that I had to add support for a function without arguments
> to the block-coroutine-wrapper.py script. I can send this as an RFC in
> any case if desired.

I think I wouldn't necessarily merge it if we don't have code that makes
use of it, but having it on the list as an RFC can't hurt either way.
Then we can come back to it once we do need it for something.

> The second is that iotest 255 ran into an assertion failure upon QMP 'quit':
> 
> > ../block/graph-lock.c:113: bdrv_graph_wrlock: Assertion `!qemu_in_coroutine()' failed.
> 
> Looking at the backtrace:
> 
> > #5  0x0000762a90cc3eb2 in __GI___assert_fail
> >     (assertion=0x5afb07991e7d "!qemu_in_coroutine()", file=0x5afb07991e00 "../block/graph-lock.c", line=113, function=0x5afb07991f20 <__PRETTY_FUNCTION__.4> "bdrv_graph_wrlock")
> >     at ./assert/assert.c:101
> > #6  0x00005afb07585311 in bdrv_graph_wrlock () at ../block/graph-lock.c:113
> > #7  0x00005afb07573a36 in blk_remove_bs (blk=0x5afb0af99420) at ../block/block-backend.c:901
> > #8  0x00005afb075729a7 in blk_delete (blk=0x5afb0af99420) at ../block/block-backend.c:487
> > #9  0x00005afb07572d88 in blk_unref (blk=0x5afb0af99420) at ../block/block-backend.c:547
> > #10 0x00005afb07572fe8 in bdrv_next (it=0x762a852fef00) at ../block/block-backend.c:618
> > #11 0x00005afb0758cd65 in bdrv_co_flush_all () at ../block/io.c:2347
> > #12 0x00005afb0753ba37 in bdrv_co_flush_all_entry (opaque=0x7ffff12c6050) at block/block-gen.c:1391
> > #13 0x00005afb0773bf41 in coroutine_trampoline (i0=168365184, i1=23291)
> 
> So I guess calling bdrv_next() is not safe from a coroutine, because
> the function doing the iteration could end up being the last thing to
> have a reference for the BB.

Does your bdrv_co_flush_all() take the graph (reader) lock? If so, this
is surprising, because while we hold the graph lock, no reference should
be able to go away - you need the writer lock for that and you won't get
it as long as bdrv_co_flush_all() locks the graph. So whatever had a
reference before the bdrv_next() loop must still have it now. Do you
know where it gets dropped?

Kevin


