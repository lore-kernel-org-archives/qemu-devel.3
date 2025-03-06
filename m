Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A95C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCtd-0003An-JJ; Thu, 06 Mar 2025 10:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tqCtN-00036S-8t
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:12:11 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tqCtK-0001MM-48
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=D+PcskdqBMg/HUQT3YskrWB3ClF1pV4tIQS3FsFci28=; b=KlNMGLgCtXefAzIJ60p49z4849
 yC5GsQJkdQgYb5pAD3ZLvq1Mi6eVEjeDwedZyRx6ZvTawwg5HI6ApYoxqpaEVTaTcFfp22obv0JMf
 AUSNnONca4BXysABO/A2ZyifzwgEe38zo11d+ypJM9ckrE0W3YVHU4rZECjUodJwMalYfd16pJWOx
 obN3cAjtL0drMiMhlVaQZyNCr53P8fUE6aEqGrPhuzXRFZn4xwgvoH1FNy4In9QESl1zLPLHKXMfO
 KTlsJ49XPhoEp+S0MSxpmi2DkCPhcoIR/Yxy62/JZfoXGOOazgoXvFCEnGS8kfQPTR75QmykviNGh
 fmPnqMN4HZJTJtMByLJUlSNvM9mWDG39wPcSQ/cBwPofFD8/jdiiWSI6DyD2zBY04fiwyfUrgYcLH
 63qaDLS1sIyax1+dS7oB3y6twIdh9qTIjvhfcpyE5MNeCP8VvW/SDQcJ+r4EvFWTbnloVvmW91Y15
 Rgz52xqeE8RmIwUE7I0pZzaF7KrxOeQts06Acl2wrXaKjpXz6NmtOOuCZhXgC2YSs4QLCKTCMYuZ3
 5edujGdg5igStAYEOCxK6AZKSeFqpo436gGBoVeCzoA734rcRM3kxPEpdgDlBOIX8/Lyiokl0SpKC
 8iJZu2JTDR6z59zBzBOdLHd+0i58b77koDfgmelJI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] 9pfs: reduce latency of v9fs_reclaim_fd()
Date: Thu, 06 Mar 2025 16:11:58 +0100
Message-ID: <1869760.rOlR1cq0hG@silver>
In-Reply-To: <20250306100756.28e6bea2@bahia>
References: <cover.1741101468.git.qemu_oss@crudebyte.com>
 <35b3e1bc74c4f2825acb98252398d2f8805fc99f.1741101468.git.qemu_oss@crudebyte.com>
 <20250306100756.28e6bea2@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thursday, March 6, 2025 10:07:56 AM CET Greg Kurz wrote:
> On Tue, 4 Mar 2025 16:16:05 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
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
> 
> I'm afraid it is a bit trickier but I might have found a subtle bug
> in the current code :-)
> 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 4f9c2dde9c..4b52b1a22a 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -434,6 +434,7 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
> >      V9fsFidState *f;
> >      GHashTableIter iter;
> >      gpointer fid;
> > +    int err;
> >  
> >      /* prevent multiple coroutines running this function simultaniously */
> >      if (s->reclaiming) {
> > @@ -446,10 +447,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
> > @@ -499,17 +500,24 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
> > +                total_open_fd--;
> 
> Hmm... total_open_fd is supposed to be accessed by the main thread only.
> Maybe turn total_open_fd into an atomic ? Or have this block to return
> the count of closed fds and propagate that to total_open_fd in the main
> thread ?

Right! I'll change that to the latter, as it involves far less changes.

> > +            }
> > +        }
> > +    });
> > +    /* Free the closed FIDs. */
> >      while (!QSLIST_EMPTY(&reclaim_list)) {
> >          f = QSLIST_FIRST(&reclaim_list);
> >          QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
> > -        if (f->fid_type == P9_FID_FILE) {
> > -            v9fs_co_close(pdu, &f->fs_reclaim);
> > -        } else if (f->fid_type == P9_FID_DIR) {
> > -            v9fs_co_closedir(pdu, &f->fs_reclaim);
> > -        }
> 
> An now for the subtle bug in the existing code :
> 
> v9fs_co_close() and v9fs_co_closedir() honor TFLUSH with the following
> check that skips the actual closing :
> 
>     if (v9fs_request_cancelled(pdu)) {
>         return -EINTR;
>     }
> 
> If the client cancels the request that needs fd reclaim, some
> fds will be cleared from the fids without being closed. This
> causes fd leaks and probably ruins the overall reclaim logic.
> 
> This is kinda fixed by the current patch since all the fds
> in the reclaim list are closed altogether atomically in the
> same v9fs_co_run_in_worker().

Hu, that makes this 2nd patch indeed more than just an optimization fix.

I'll send a v2 and CC qemu-stable on the 2nd patch as well.

Good catches, thanks Greg!

/Christian



