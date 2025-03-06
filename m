Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7D8-0000yq-GC; Thu, 06 Mar 2025 04:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tq7D5-0000yK-D7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:08:07 -0500
Received: from 4.mo552.mail-out.ovh.net ([178.33.43.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tq7D2-0006dH-Al
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:08:07 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.76])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4Z7k8t1DGPz1Wbk;
 Thu,  6 Mar 2025 09:07:58 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Mar
 2025 10:07:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0063cc64be7-4286-4742-bcd7-f9f6f1717f32,
 37C52C01EA5DF959F069A379DC9FDBD07502A922) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 6 Mar 2025 10:07:56 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] 9pfs: reduce latency of v9fs_reclaim_fd()
Message-ID: <20250306100756.28e6bea2@bahia>
In-Reply-To: <35b3e1bc74c4f2825acb98252398d2f8805fc99f.1741101468.git.qemu_oss@crudebyte.com>
References: <cover.1741101468.git.qemu_oss@crudebyte.com>
 <35b3e1bc74c4f2825acb98252398d2f8805fc99f.1741101468.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 18b2b9b5-0c98-4e53-84bb-663b5aef0593
X-Ovh-Tracer-Id: 7344808043234826650
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrudduvddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehhedvmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=/pazhm2T2KBH7nvhREPHTZRA+4H3JdZPXvBe0ilg8yk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741252078; v=1;
 b=C4h8vZMZbBlA4/bWmtjvhzxVe1NN4H6p/PtF+WkcKcZoo40wHZksJYHFqxsKlS5zKSrQrRd9
 /uJhw026fPDWtRM/R4rM/XfrHU00NDlt8t7KjSusG7lWCh9m3YCtSuh2MFdl/GoOfNkHg0Dj+/s
 FOG4TdsCC+RiseZiDlnnMazAG1RsHTYAPftbu+X2p8K8PMNK5zLivwZc22IxURuI1jRIKEAJLvx
 UapUfEaPcuxSmNPqllzG3MqKgP0CVfdoj0fgtDcnWh5rBdPEmELmI2sQpN7AJr/lMjLGz2PgD/2
 D77Akkpcl2V5iCIrgFu/DcxuG8HfiDwJQ7g0e0uFx1JWw==
Received-SPF: pass client-ip=178.33.43.201; envelope-from=groug@kaod.org;
 helo=4.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 4 Mar 2025 16:16:05 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

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

I'm afraid it is a bit trickier but I might have found a subtle bug
in the current code :-)

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 4f9c2dde9c..4b52b1a22a 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -434,6 +434,7 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      V9fsFidState *f;
>      GHashTableIter iter;
>      gpointer fid;
> +    int err;
>  
>      /* prevent multiple coroutines running this function simultaniously */
>      if (s->reclaiming) {
> @@ -446,10 +447,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
> @@ -499,17 +500,24 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
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
> +                total_open_fd--;

Hmm... total_open_fd is supposed to be accessed by the main thread only.
Maybe turn total_open_fd into an atomic ? Or have this block to return
the count of closed fds and propagate that to total_open_fd in the main
thread ?

> +            }
> +        }
> +    });
> +    /* Free the closed FIDs. */
>      while (!QSLIST_EMPTY(&reclaim_list)) {
>          f = QSLIST_FIRST(&reclaim_list);
>          QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
> -        if (f->fid_type == P9_FID_FILE) {
> -            v9fs_co_close(pdu, &f->fs_reclaim);
> -        } else if (f->fid_type == P9_FID_DIR) {
> -            v9fs_co_closedir(pdu, &f->fs_reclaim);
> -        }

An now for the subtle bug in the existing code :

v9fs_co_close() and v9fs_co_closedir() honor TFLUSH with the following
check that skips the actual closing :

    if (v9fs_request_cancelled(pdu)) {
        return -EINTR;
    }

If the client cancels the request that needs fd reclaim, some
fds will be cleared from the fids without being closed. This
causes fd leaks and probably ruins the overall reclaim logic.

This is kinda fixed by the current patch since all the fds
in the reclaim list are closed altogether atomically in the
same v9fs_co_run_in_worker().

>          /*
>           * Now drop the fid reference, free it
>           * if clunked.

Cheers,

-- 
Greg

