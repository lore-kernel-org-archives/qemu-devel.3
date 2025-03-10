Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BC2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZq7-0006A4-1S; Mon, 10 Mar 2025 05:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1trZq2-00066q-ID; Mon, 10 Mar 2025 05:54:23 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1trZpy-0003Qn-Ku; Mon, 10 Mar 2025 05:54:22 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.9.71])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZBC0F6fxhz102p;
 Mon, 10 Mar 2025 09:54:05 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Mar
 2025 10:54:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005578d41f6-1129-42f9-806d-ba8e3cd77f24,
 CAA57E8D90FBE7F25A889509E00BEDBA23686665) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 10 Mar 2025 10:54:04 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 2/2] 9pfs: fix FD leak and reduce latency of
 v9fs_reclaim_fd()
Message-ID: <20250310105404.185278bb@bahia>
In-Reply-To: <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
References: <cover.1741339452.git.qemu_oss@crudebyte.com>
 <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 13683970-711e-465c-9592-7f9316441a41
X-Ovh-Tracer-Id: 13167680886166493661
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeltdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtgedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=6BcoR2zEvHmaHt/NNjb5GjA+cUS7/bkq+5D7/7GewOI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741600446; v=1;
 b=c3dNIgtizN6//JEB961xwECEdsAODeCWeW943smm2KbI6R/Lp0a57MNAwyo17Y8dMXoj8hi4
 3sidfQiY5+Dn9v58gO5OppxrnC7B1VhX+pWx+3S38sTmxgB5SC8c59gTf2e8iC+NSuT1m5Xr5Tw
 4bjBmXPy0F7sCNu5ZBtM4GZa7PKpSzRpwekFta6+mktYnGXgBaxr0cDq3wut4b3ld/0BcroX8yF
 epC9/nyB25x1CFrl8+cFPIoJFc0gn5QX+xhxP/5gMkp0GLwUExpjj9cZLBLmzh3+1+l86ygXCt9
 zAOIwKhd3Ju9B3qSsvp7L7AWaH9OSlhjF/EnZ6MfXaZlA==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
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

On Fri, 7 Mar 2025 10:23:02 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This patch fixes two different bugs in v9fs_reclaim_fd():
> 
> 1. Reduce latency:
> 
> This function calls v9fs_co_close() and v9fs_co_closedir() in a loop. Each
> one of the calls adds two thread hops (between main thread and a fs driver
> background thread). Each thread hop adds latency, which sums up in
> function's loop to a significant duration.
> 
> Reduce overall latency by open coding what v9fs_co_close() and
> v9fs_co_closedir() do, executing those and the loop itself altogether in
> only one background thread block, hence reducing the total amount of
> thread hops to only two.
> 
> 2. Fix file descriptor leak:
> 
> The existing code called v9fs_co_close() and v9fs_co_closedir() to close
> file descriptors. Both functions check right at the beginning if the 9p
> request was cancelled:
> 
>     if (v9fs_request_cancelled(pdu)) {
>         return -EINTR;
>     }
> 
> So if client sent a 'Tflush' message, v9fs_co_close() / v9fs_co_closedir()
> returned without having closed the file descriptor and v9fs_reclaim_fd()
> subsequently freed the FID without its file descriptor being closed, hence
> leaking those file descriptors.
> 
> This 2nd bug is fixed by this patch as well by open coding v9fs_co_close()
> and v9fs_co_closedir() inside of v9fs_reclaim_fd() and not performing the
> v9fs_request_cancelled(pdu) check there.
> 
> Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
> Fixes: bccacf6c792 ('hw/9pfs: Implement TFLUSH operation')
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 4f9c2dde9c..80b190ff5b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -434,6 +434,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      V9fsFidState *f;
>      GHashTableIter iter;
>      gpointer fid;
> +    int err;
> +    int nclosed = 0;
>  
>      /* prevent multiple coroutines running this function simultaniously */
>      if (s->reclaiming) {
> @@ -446,10 +448,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      QSLIST_HEAD(, V9fsFidState) reclaim_list =
>          QSLIST_HEAD_INITIALIZER(reclaim_list);
>  
> +    /* Pick FIDs to be closed, collect them on reclaim_list. */
>      while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &f)) {
>          /*
> -         * Unlink fids cannot be reclaimed. Check
> -         * for them and skip them. Also skip fids
> +         * Unlinked fids cannot be reclaimed, skip those, and also skip fids
>           * currently being operated on.
>           */
>          if (f->ref || f->flags & FID_NON_RECLAIMABLE) {
> @@ -499,17 +501,26 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>          }
>      }
>      /*
> -     * Now close the fid in reclaim list. Free them if they
> -     * are already clunked.
> +     * Close the picked FIDs altogether on a background I/O driver thread. Do
> +     * this all at once to keep latency (i.e. amount of thread hops between main
> +     * thread <-> fs driver background thread) as low as possible.
>       */
> +    v9fs_co_run_in_worker({
> +        QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
> +            err = (f->fid_type == P9_FID_DIR) ?
> +                s->ops->closedir(&s->ctx, &f->fs_reclaim) :
> +                s->ops->close(&s->ctx, &f->fs_reclaim);
> +            if (!err) {
> +                /* total_open_fd must only be mutated on main thread */
> +                nclosed++;
> +            }
> +        }
> +    });
> +    total_open_fd -= nclosed;
> +    /* Free the closed FIDs. */
>      while (!QSLIST_EMPTY(&reclaim_list)) {
>          f = QSLIST_FIRST(&reclaim_list);
>          QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
> -        if (f->fid_type == P9_FID_FILE) {
> -            v9fs_co_close(pdu, &f->fs_reclaim);
> -        } else if (f->fid_type == P9_FID_DIR) {
> -            v9fs_co_closedir(pdu, &f->fs_reclaim);
> -        }
>          /*
>           * Now drop the fid reference, free it
>           * if clunked.



-- 
Greg

