Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB30FCB613
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyX8x-0004k2-Cp; Fri, 06 Mar 2026 10:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyX8d-0004d4-AB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyX8b-0007uV-FK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772811047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDbgmgw+Jl+N8n8jYhMKt3SJXMrjyMwKj3gWiyfjdkc=;
 b=iCJKL/lnDV07750z4I3HZwOTIUpa6BFJVV8Yj5Lfp1xuD9T9J5e6P077BLenrzWdwAcMuy
 BfB94DiTHhE2LxhTQ40bUvuYENzjvUsqAwS6zTLqxaV+2tgkQyQlLRfLftskODzoiwcQl8
 jcgVAheXGJTHeK1JZLcJLAKYbX1ah6s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-Q5I6DiF3M4ufDgBS4J0HoA-1; Fri,
 06 Mar 2026 10:30:44 -0500
X-MC-Unique: Q5I6DiF3M4ufDgBS4J0HoA-1
X-Mimecast-MFC-AGG-ID: Q5I6DiF3M4ufDgBS4J0HoA_1772811042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BF5F180049D; Fri,  6 Mar 2026 15:30:42 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4461956095; Fri,  6 Mar 2026 15:30:37 +0000 (UTC)
Date: Fri, 6 Mar 2026 16:30:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@dlhnet.de>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 04/19] nfs: Run =?utf-8?Q?co?=
 =?utf-8?Q?_BH_CB_in_the_coroutine=E2=80=99s?= AioContext
Message-ID: <aarzG5k8LULdB-b0@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-5-hreitz@redhat.com>
 <EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de>
 <1d11486a-f592-49ff-837a-346f7c493ca7@redhat.com>
 <D366BE0D-C606-4DE1-9BC6-6DE522616F0C@dlhnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D366BE0D-C606-4DE1-9BC6-6DE522616F0C@dlhnet.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 06.03.2026 um 14:57 hat Peter Lieven geschrieben:
> 
> 
> > Am 06.03.2026 um 14:41 schrieb Hanna Czenczek <hreitz@redhat.com>:
> > 
> > On 03.03.26 20:24, Peter Lieven wrote:
> >> 
> >> 
> >>> Am 10.11.2025 um 16:48 schrieb Hanna Czenczek <hreitz@redhat.com> <mailto:hreitz@redhat.com>:
> >>> 
> >>> Like in “rbd: Run co BH CB in the coroutine’s AioContext”, drop the
> >>> completion flag, yield exactly once, and run the BH in the coroutine’s
> >>> AioContext.
> >>> 
> >>> (Can be reproduced with multiqueue by adding a usleep(100000) before the
> >>> `while (!task.complete)` loops.)
> >>> 
> >>> Like in “iscsi: Run co BH CB in the coroutine’s AioContext”, this makes
> >>> nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
> >>> calling aio_co_wake() directly.
> >>> 
> >>> Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>
> >>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com> <mailto:hreitz@redhat.com>
> >>> ---
> >>> block/nfs.c | 41 ++++++++++++++++-------------------------
> >>> 1 file changed, 16 insertions(+), 25 deletions(-)
> >>> 
> >>> diff --git a/block/nfs.c b/block/nfs.c
> >>> index 0a7d38db09..1d3a34a30c 100644
> >>> --- a/block/nfs.c
> >>> +++ b/block/nfs.c
> >>> @@ -69,7 +69,6 @@ typedef struct NFSClient {
> >>> typedef struct NFSRPC {
> >>>     BlockDriverState *bs;
> >>>     int ret;
> >>> -    int complete;
> >>>     QEMUIOVector *iov;
> >>>     struct stat *st;
> >>>     Coroutine *co;
> >>> @@ -230,14 +229,6 @@ static void coroutine_fn nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
> >>>     };
> >>> }
> >>> 
> >>> -static void nfs_co_generic_bh_cb(void *opaque)
> >>> -{
> >>> -    NFSRPC *task = opaque;
> >>> -
> >>> -    task->complete = 1;
> >>> -    aio_co_wake(task->co);
> >>> -}
> >>> -
> >>> /* Called (via nfs_service) with QemuMutex held.  */
> >>> static void
> >>> nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
> >>> @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
> >>>     if (task->ret < 0) {
> >>>         error_report("NFS Error: %s", nfs_get_error(nfs));
> >>>     }
> >>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
> >>> -                                     nfs_co_generic_bh_cb, task);
> >>> +
> >>> +    /*
> >>> +     * Safe to call: nfs_service(), which called us, is only run from the FD
> >>> +     * handlers, never from the request coroutine.  The request coroutine in
> >>> +     * turn will yield unconditionally.
> >>> +     * No need to release the lock, even if we directly enter the coroutine, as
> >>> +     * the lock is never re-taken after yielding.  (Note: If we do enter the
> >>> +     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
> >>> +     */
> >>> +    aio_co_wake(task->co);
> >>> }
> >>> 
> >>> static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
> >>> @@ -278,9 +277,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
> >>> 
> >>>         nfs_set_events(client);
> >>>     }
> >>> -    while (!task.complete) {
> >>> -        qemu_coroutine_yield();
> >>> -    }
> >>> +    qemu_coroutine_yield();
> >>> 
> >>>     if (task.ret < 0) {
> >>>         return task.ret;
> >>> @@ -328,9 +325,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
> >>> 
> >>>         nfs_set_events(client);
> >>>     }
> >>> -    while (!task.complete) {
> >>> -        qemu_coroutine_yield();
> >>> -    }
> >>> +    qemu_coroutine_yield();
> >>> 
> >>>     if (my_buffer) {
> >>>         g_free(buf);
> >>> @@ -358,9 +353,7 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
> >>> 
> >>>         nfs_set_events(client);
> >>>     }
> >>> -    while (!task.complete) {
> >>> -        qemu_coroutine_yield();
> >>> -    }
> >>> +    qemu_coroutine_yield();
> >>> 
> >>>     return task.ret;
> >>> }
> >>> @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
> >>>     if (task->ret < 0) {
> >>>         error_report("NFS Error: %s", nfs_get_error(nfs));
> >>>     }
> >>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
> >>> -                                     nfs_co_generic_bh_cb, task);
> >>> +    /* Safe to call, see nfs_co_generic_cb() */
> >>> +    aio_co_wake(task->co);
> >>> }
> >>> 
> >>> static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
> >>> @@ -748,9 +741,7 @@ static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
> >>> 
> >>>         nfs_set_events(client);
> >>>     }
> >>> -    while (!task.complete) {
> >>> -        qemu_coroutine_yield();
> >>> -    }
> >>> +    qemu_coroutine_yield();
> >>> 
> >>>     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >>> }
> >>> -- 
> >>> 2.51.1
> >>> 
> >> 
> >> Hallo Hanna,
> >> 
> >> it has been a long time where I was inactive in Qemu development and I should have checked this earlier, but it seems that this patch accidentally broke libnfs usage with at least qemu cmdline tools like qemu-img. Again, sorry for not testing this earlier, but I have only recently entered the Qemu show again.
> >> 
> >> I found this glitch while working on a patch to include libnfs v6 support in qemu to avoid dropping libnfs support.
> >> 
> >> A simple call like:
> >> 
> >> qemu-img create -f qcow2 nfs://nfsserver/image.qcow2 10G
> >> 
> >> hangs forever in the second write request.
> > 
> > I sent a patch for this, which is basically the same as yours below: https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.html
> 
> Thanks, I will rebase by NFS patches for libnfs v6 on top of that.
> 
> Do we need the same fix for iSCSI?

iscsi drops the lock temporarily. This means that the deadlock won't
happen. What might be worth double checking is if temporarily dropping
the lock still gives enough guarantees for iscsi_service() and its
callers to work correctly.

I don't think I fully understand what the lock is protecting.
Apparently it comes from mass conversions from the original automatic
locking in AioContext callbacks, so nobody really seems to have thought
about it other than asserting that it's as safe as before. Maybe locking
more locally could be a better alternative that would be easier to
understand.

Kevin


