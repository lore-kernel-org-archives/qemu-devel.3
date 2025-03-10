Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A84C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZty-0002cA-K8; Mon, 10 Mar 2025 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1trZtd-0002M9-DI; Mon, 10 Mar 2025 05:58:10 -0400
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1trZta-00044d-Vi; Mon, 10 Mar 2025 05:58:05 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.139.122])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4ZBC4j5Wg1z1Rg0;
 Mon, 10 Mar 2025 09:57:57 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Mar
 2025 10:57:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006b8d814a8-6a1a-4bf5-b091-82dd6657f242,
 CAA57E8D90FBE7F25A889509E00BEDBA23686665) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 10 Mar 2025 10:57:56 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/2] 9pfs: fix FD leak and reduce latency of
 v9fs_reclaim_fd()
Message-ID: <20250310105756.1da6083f@bahia>
In-Reply-To: <30024595.HyFKvjELBK@silver>
References: <cover.1741339452.git.qemu_oss@crudebyte.com>
 <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
 <30024595.HyFKvjELBK@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a7b39b54-eecd-4265-ae62-8f47a13d0cad
X-Ovh-Tracer-Id: 13232983082959018461
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeltdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehhedvmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=8UR75CkYwiwYcODWJffW+HsnXKEOtzVl29D05XhzMfs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741600678; v=1;
 b=RoZqMhbbB9NDzOi+sAjMzIl4Ligvwt0wFP9EkBFJJp+O2wP0x3YonUMfxGMFfDAYSOD2YNje
 YQf5ik5VujV4ZZJ0Ix0466MTngnIcDciQ6BKglj+8bSOlDdNXb9Lq2m8h6n9dvSWgLuwQlU9Dax
 m2ZxsOdY94mQ0cp5DOwXXLDtpdDNTIH5gMRycN2M3u2l3p7IMCB+gf9ulxSBgbh3NZPkUv+d0my
 8celNblfC4XyJmHI6Yk4Cikdbuv3MEZU9FRglDODde6Ve/+bNjSPzWKdLf5kKhaBChX/8Znn+Ip
 vvt7o1vpxWa9rnX9KkrOZqpxMnJrQ/igSoePa98rVoQsQ==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=groug@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 07 Mar 2025 10:47:33 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Friday, March 7, 2025 10:23:02 AM CET Christian Schoenebeck wrote:
> > This patch fixes two different bugs in v9fs_reclaim_fd():
> > 
> > 1. Reduce latency:
> > 
> > This function calls v9fs_co_close() and v9fs_co_closedir() in a loop. Each
> > one of the calls adds two thread hops (between main thread and a fs driver
> > background thread). Each thread hop adds latency, which sums up in
> > function's loop to a significant duration.
> > 
> > Reduce overall latency by open coding what v9fs_co_close() and
> > v9fs_co_closedir() do, executing those and the loop itself altogether in
> > only one background thread block, hence reducing the total amount of
> > thread hops to only two.
> > 
> > 2. Fix file descriptor leak:
> > 
> > The existing code called v9fs_co_close() and v9fs_co_closedir() to close
> > file descriptors. Both functions check right at the beginning if the 9p
> > request was cancelled:
> > 
> >     if (v9fs_request_cancelled(pdu)) {
> >         return -EINTR;
> >     }
> > 
> > So if client sent a 'Tflush' message, v9fs_co_close() / v9fs_co_closedir()
> > returned without having closed the file descriptor and v9fs_reclaim_fd()
> > subsequently freed the FID without its file descriptor being closed, hence
> > leaking those file descriptors.
> > 
> > This 2nd bug is fixed by this patch as well by open coding v9fs_co_close()
> > and v9fs_co_closedir() inside of v9fs_reclaim_fd() and not performing the
> > v9fs_request_cancelled(pdu) check there.
> > 
> > Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
> > Fixes: bccacf6c792 ('hw/9pfs: Implement TFLUSH operation')
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c | 29 ++++++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 4f9c2dde9c..80b190ff5b 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -434,6 +434,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >      V9fsFidState *f;
> >      GHashTableIter iter;
> >      gpointer fid;
> > +    int err;
> > +    int nclosed = 0;
> >  
> >      /* prevent multiple coroutines running this function simultaniously */
> >      if (s->reclaiming) {
> > @@ -446,10 +448,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >      QSLIST_HEAD(, V9fsFidState) reclaim_list =
> >          QSLIST_HEAD_INITIALIZER(reclaim_list);
> >  
> > +    /* Pick FIDs to be closed, collect them on reclaim_list. */
> >      while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &f)) {
> >          /*
> > -         * Unlink fids cannot be reclaimed. Check
> > -         * for them and skip them. Also skip fids
> > +         * Unlinked fids cannot be reclaimed, skip those, and also skip fids
> >           * currently being operated on.
> >           */
> >          if (f->ref || f->flags & FID_NON_RECLAIMABLE) {
> > @@ -499,17 +501,26 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >          }
> >      }
> >      /*
> > -     * Now close the fid in reclaim list. Free them if they
> > -     * are already clunked.
> > +     * Close the picked FIDs altogether on a background I/O driver thread. Do
> > +     * this all at once to keep latency (i.e. amount of thread hops between main
> > +     * thread <-> fs driver background thread) as low as possible.
> >       */
> > +    v9fs_co_run_in_worker({
> > +        QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
> > +            err = (f->fid_type == P9_FID_DIR) ?
> > +                s->ops->closedir(&s->ctx, &f->fs_reclaim) :
> > +                s->ops->close(&s->ctx, &f->fs_reclaim);
> > +            if (!err) {
> > +                /* total_open_fd must only be mutated on main thread */
> > +                nclosed++;
> > +            }
> > +        }
> > +    });
> > +    total_open_fd -= nclosed;
> 
> So here is another thing: looking at 'man 2 close' I would say that
> decrementing 'total_open_fd' conditionally based on what close() returned is
> wrong. The man page suggest that the return value of close() should only be
> used for diagnostic purposes, as an error on close() often indicates just an
> error on a previous write() and hence the return value should only be used for
> catching a data loss related to writes.
> 
> So this should probably changed here, as well as in v9fs_co_close() /
> v9fs_co_closedir(), part of a separate patch though, so I haven't addressed it
> here yet.
> 
> Does this make sense?
> 

The handling of the return value of `close()` seems to be non-trivial
indeed. It makes sense to address this in some other series.

Cheers,

--
Greg

> /Christian
> 
> > +    /* Free the closed FIDs. */
> >      while (!QSLIST_EMPTY(&reclaim_list)) {
> >          f = QSLIST_FIRST(&reclaim_list);
> >          QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
> > -        if (f->fid_type == P9_FID_FILE) {
> > -            v9fs_co_close(pdu, &f->fs_reclaim);
> > -        } else if (f->fid_type == P9_FID_DIR) {
> > -            v9fs_co_closedir(pdu, &f->fs_reclaim);
> > -        }
> >          /*
> >           * Now drop the fid reference, free it
> >           * if clunked.
> > 
> 
> 



-- 
Greg

