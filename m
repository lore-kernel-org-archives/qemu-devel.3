Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87CDCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy8av-0003vv-7E; Mon, 15 Sep 2025 08:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uy8ao-0003tQ-Sy
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uy8ah-0002RY-H7
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 08:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757940349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezBQBXPjbMx+thVM2oVako/4ZqNR08hj/ehnZCFiXk4=;
 b=e2kCZqWHtVgSgcmZL0gGcgp0+n6aXGjZIG9JrvjOWdnl1QgysYECik+No1B9wb/aZ+9d8t
 0pkaSsQE2KijfwwKQhNnBUGa0cFL0vfFRyNbAmfYh59aJNgB6JwQJhLFigk6jy6BvDJDVG
 scccK6VLrLWlJ5ilykGoqE+QpFP5b+w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-q8hEVm0PNFmbtSgJQV53dQ-1; Mon,
 15 Sep 2025 08:45:48 -0400
X-MC-Unique: q8hEVm0PNFmbtSgJQV53dQ-1
X-Mimecast-MFC-AGG-ID: q8hEVm0PNFmbtSgJQV53dQ_1757940347
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D3B1910529; Mon, 15 Sep 2025 12:45:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.139])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FA0F300021A; Mon, 15 Sep 2025 12:45:43 +0000 (UTC)
Date: Mon, 15 Sep 2025 14:45:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 hreitz@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMgKdXoaZ_lpKfnX@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com>
 <58d82de4-25ac-48f5-ae80-181faf2bf8cf@redhat.com>
 <aMK8-4-xE0R7AnaK@redhat.com> <aMQs8pbZZPio0ikL@redhat.com>
 <aMQz383L7sjWiPV_@redhat.com> <aMRn31T1Id5ceFjX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMRn31T1Id5ceFjX@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 12.09.2025 um 20:35 hat Daniel P. Berrangé geschrieben:
> On Fri, Sep 12, 2025 at 04:53:19PM +0200, Kevin Wolf wrote:
> > Am 12.09.2025 um 16:23 hat Daniel P. Berrangé geschrieben:
> > > On Thu, Sep 11, 2025 at 02:13:47PM +0200, Kevin Wolf wrote:
> > > > Hm, so block_crypto_read_func() isn't prepared to be called in coroutine
> > > > context, but block_crypto_co_amend_luks() still calls it from a
> > > > coroutine. The indirection of going through QCrypto won't make it easier
> > > > to fix this properly.
> > > 
> > > Historically block_crypto_read_func() didn't care/know whether it
> > > was in a coroutine or not. Bisect tells me the regression was caused
> > > by
> > > 
> > >   commit 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
> > >   Author: Kevin Wolf <kwolf@redhat.com>
> > >   Date:   Fri Oct 27 17:53:33 2023 +0200
> > > 
> > >     block: Protect bs->file with graph_lock
> > > 
> > > which added
> > >  
> > >     GLOBAL_STATE_CODE();
> > >     GRAPH_RDLOCK_GUARD_MAINLOOP();
> > > 
> > > > It seems to me that while block_crypto_read/write_func are effectively
> > > > no_coroutine_fn, qcrypto_block_amend_options() should really take
> > > > function pointers that can be called from coroutines. It is called from
> > > > both coroutine and non-coroutine code paths, so should the function
> > > > pointers be coroutine_mixed_fn or do we want to change the callers?
> > > >
> > > > Either way, we should add the appropriate coroutine markers to the
> > > > QCrypto interfaces to show the intention at least.
> > > 
> > > I'm unclear why QCrypto needs to know about coroutines at all ?
> > > It just wants a function pointer that will send or recv a blob
> > > of data. In the case of the block layer these functions end up
> > > doing I/O via the block APIs, but QCrypto doesn't care about
> > > this impl detail.
> > 
> > Does a case where it's not in the context of the block layer even exist?
> 
> Only the unit tests.
> 
> > The only callers of qcrypto_block_amend_options() are in block/crypto.c
> > and block/qcow2.c. Apart from a test case, qcrypto_block_open() is the
> > same.
> 
> Yep
> 
> > And even ignoring the block layer, doing synchronous I/O outside of
> > coroutines is arguably a bug anyway because that's a blocking operation
> > that stops the mainloop from making progress.
> 
> More generally, simply opening a LUKS volume can also impose a significant
> delay because key validation is intentionally slow in wallclock time. So we
> should get a minimum of 1 second delay, but if given an image created on a
> significantly faster machine (or a malicious image), the larger 'iterations'
> count could make us take way longer to open the image.
> 
> I guess that's a potential problem too ?
> 
> Amending the keys has the same performance penalty too as that involves
> same intentionally slow crypto

Yes, that could be very noticable for the guest.

bdrv_open() being synchronous is a problem in general. It is somewhat
mitigated in some block drivers like qcow2 by creating a coroutine that
does the real open and an AIO_WAIT_WHILE_UNLOCKED() call that waits for
the coroutine, but processes other events, too (though it doesn't
process events in iohandler_ctx, like new QMP commands). But at least in
the common case, bdrv_open() is relatively fast anyway.

I guess the easiest way to deal with it in the luks block driver would
be offloading the calculations to a task in the thread pool and using
AIO_WAIT_WHILE_UNLOCKED() to wait for its completion. We could combine
it with the qcow2 approach to cover the read request(s?) for the image
file, too.

> > But if we don't want to fix it at the QCrypto level, that makes the
> > function pointer implicitly coroutine_mixed_fn and the function needs to
> > be rewritten to check qemu_in_coroutine() and probably take the graph
> > lock internally before calling bdrv_co_pread() in the coroutine case,
> > unless we can prove that all callers already hold it. Unfortunately,
> > function pointers still defeat TSA, so this proof will have to be
> > manual.
> 
> So IIUC the 'open' operation is not in a coroutine, while the
> 'amend' operation is in a coroutine ?

Yes.

> IIUC the coroutine_mixed_fn is expanding to a no-op. What is the
> actual functional fix needed to stop the crash ?

The problem is that block_crypto_read_func() calls bdrv_pread().

When called outside of a coroutine, it creates a coroutine, takes the
graph reader lock and calls bdrv_co_pread().

When called from a coroutine, it's just a thin wrapper that calls
bdrv_co_pread() directly without creating a new coroutine and without
taking the graph lock, but calling bdrv_co_pread() still requires that
you hold the lock. So we need to make sure that either the graph lock is
already taken when the function is called from coroutine context, or we
must take it here.

Kevin


