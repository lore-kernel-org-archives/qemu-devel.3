Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3940AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTrG-00061A-4T; Mon, 26 May 2025 05:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTrD-0005x7-IK
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTrA-0001Ka-VN
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKffX4HPzxGdQ26b5rEZ+t2Ey5x4Zaw5tmG6EaQlZy4=;
 b=bx7Ed61m8OJyNBGYvjfLqhvF0rl4aollPmeCWpVT33FwRO+bPmAuv6tscNESnIRY7rtQLj
 fGIdRB9JCWg8HuPp21oiQrqPB+KBG+AFIiDi9mwGpwymyxK/YP3Vcm4mAJ+E68WB0E6X8K
 1u28CxxXmo74au/TrHVYG4KVizHWgC0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-zrus-ApNNgiD_pDp2xFa7A-1; Mon,
 26 May 2025 05:10:46 -0400
X-MC-Unique: zrus-ApNNgiD_pDp2xFa7A-1
X-Mimecast-MFC-AGG-ID: zrus-ApNNgiD_pDp2xFa7A_1748250645
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3AB5195609F; Mon, 26 May 2025 09:10:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7C5119560AF; Mon, 26 May 2025 09:10:39 +0000 (UTC)
Date: Mon, 26 May 2025 11:10:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, den@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 03/24] block/snapshot: move drain outside of
 read-locked bdrv_snapshot_delete()
Message-ID: <aDQwDbJLqPYVxgCN@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-4-f.ebner@proxmox.com>
 <4fdff680-5e77-40f2-812b-70697ad8ae64@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdff680-5e77-40f2-812b-70697ad8ae64@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.05.2025 um 20:12 hat Andrey Drobyshev geschrieben:
> On 5/20/25 1:29 PM, Fiona Ebner wrote:
> > This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> > 
> > More granular draining is not trivially possible, because
> > bdrv_snapshot_delete() can recursively call itself.
> > 
> > The return value of bdrv_all_delete_snapshot() changes from -1 to
> > -errno propagated from failed sub-calls. This is fine for the existing
> > callers of bdrv_all_delete_snapshot().
> > 
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> > 
> > Changes in v2:
> > * Use 'must be drained' instead of 'needs to be drained'.
> > * Use goto for cleanup/error handling in bdrv_all_delete_snapshot().
> > * Don't use atomics to access bs->quiesce_counter.
> > 
> >  block/snapshot.c | 26 +++++++++++++++-----------
> >  blockdev.c       | 25 +++++++++++++++++--------
> >  qemu-img.c       |  2 ++
> >  3 files changed, 34 insertions(+), 19 deletions(-)
> > 
> > diff --git a/block/snapshot.c b/block/snapshot.c
> > index 22567f1fb9..9f300a78bd 100644
> > --- a/block/snapshot.c
> > +++ b/block/snapshot.c
> > @@ -327,7 +327,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
> >  
> >  /**
> >   * Delete an internal snapshot by @snapshot_id and @name.
> > - * @bs: block device used in the operation
> > + * @bs: block device used in the operation, must be drained
> >   * @snapshot_id: unique snapshot ID, or NULL
> >   * @name: snapshot name, or NULL
> >   * @errp: location to store error
> > @@ -358,6 +358,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
> >  
> >      GLOBAL_STATE_CODE();
> >  
> > +    assert(bs->quiesce_counter > 0);
> > +
> >      if (!drv) {
> >          error_setg(errp, "Device '%s' has no medium",
> >                     bdrv_get_device_name(bs));
> > @@ -368,9 +370,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
> >          return -EINVAL;
> >      }
> >  
> > -    /* drain all pending i/o before deleting snapshot */
> > -    bdrv_drained_begin(bs);
> > -
> >      if (drv->bdrv_snapshot_delete) {
> >          ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
> >      } else if (fallback_bs) {
> > @@ -382,7 +381,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
> >          ret = -ENOTSUP;
> >      }
> >  
> > -    bdrv_drained_end(bs);
> >      return ret;
> >  }
> >  
> > @@ -571,19 +569,22 @@ int bdrv_all_delete_snapshot(const char *name,
> >      ERRP_GUARD();
> >      g_autoptr(GList) bdrvs = NULL;
> >      GList *iterbdrvs;
> > +    int ret = 0;
> >  
> >      GLOBAL_STATE_CODE();
> > -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> >  
> > -    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
> > -        return -1;
> > +    bdrv_drain_all_begin();
> > +    bdrv_graph_rdlock_main_loop();
> > +
> > +    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
> > +    if (ret < 0) {
> > +        goto out;
> >      }
> >  
> >      iterbdrvs = bdrvs;
> >      while (iterbdrvs) {
> >          BlockDriverState *bs = iterbdrvs->data;
> >          QEMUSnapshotInfo sn1, *snapshot = &sn1;
> > -        int ret = 0;
> >  
> >          if ((devices || bdrv_all_snapshots_includes_bs(bs)) &&
> >              bdrv_snapshot_find(bs, snapshot, name) >= 0)
> > @@ -594,13 +595,16 @@ int bdrv_all_delete_snapshot(const char *name,
> >          if (ret < 0) {
> >              error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
> >                            name, bdrv_get_device_or_node_name(bs));
> > -            return -1;
> > +            goto out;
> >          }
> >  
> >          iterbdrvs = iterbdrvs->next;
> >      }
> >  
> > -    return 0;
> > +out:
> > +    bdrv_graph_rdunlock_main_loop();
> > +    bdrv_drain_all_end();
> > +    return ret;
> >  }
> >  
> >  
> > diff --git a/blockdev.c b/blockdev.c
> > index 21443b4514..3982f9776b 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -1132,39 +1132,41 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
> >      int ret;
> >  
> >      GLOBAL_STATE_CODE();
> > -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> > +
> > +    bdrv_drain_all_begin();
> > +    bdrv_graph_rdlock_main_loop();
> >  
> >      bs = qmp_get_root_bs(device, errp);
> >      if (!bs) {
> > -        return NULL;
> > +        goto error;
> >      }
> >  
> >      if (!id && !name) {
> >          error_setg(errp, "Name or id must be provided");
> > -        return NULL;
> > +        goto error;
> >      }
> >  
> >      if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT_DELETE, errp)) {
> > -        return NULL;
> > +        goto error;
> >      }
> >  
> >      ret = bdrv_snapshot_find_by_id_and_name(bs, id, name, &sn, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> > -        return NULL;
> > +        goto error;
> >      }
> >      if (!ret) {
> >          error_setg(errp,
> >                     "Snapshot with id '%s' and name '%s' does not exist on "
> >                     "device '%s'",
> >                     STR_OR_NULL(id), STR_OR_NULL(name), device);
> > -        return NULL;
> > +        goto error;
> >      }
> >  
> >      bdrv_snapshot_delete(bs, id, name, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> > -        return NULL;
> > +        goto error;
> >      }
> >  
> >      info = g_new0(SnapshotInfo, 1);
> > @@ -1180,6 +1182,9 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
> >          info->has_icount = true;
> >      }
> >  
> > +error:
> > +    bdrv_graph_rdunlock_main_loop();
> > +    bdrv_drain_all_end();
> >      return info;
> >  }
> >  
> > @@ -1295,12 +1300,14 @@ static void internal_snapshot_abort(void *opaque)
> >      Error *local_error = NULL;
> >  
> >      GLOBAL_STATE_CODE();
> > -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> >  
> >      if (!state->created) {
> >          return;
> >      }
> >  
> > +    bdrv_drain_all_begin();
> > +    bdrv_graph_rdlock_main_loop();
> > +
> >      if (bdrv_snapshot_delete(bs, sn->id_str, sn->name, &local_error) < 0) {
> >          error_reportf_err(local_error,
> >                            "Failed to delete snapshot with id '%s' and "
> > @@ -1308,6 +1315,8 @@ static void internal_snapshot_abort(void *opaque)
> >                            sn->id_str, sn->name,
> >                            bdrv_get_device_name(bs));
> >      }
> > +    bdrv_graph_rdunlock_main_loop();
> > +    bdrv_drain_all_end();
> >  }
> >
> 
> Okay, I've got a very simple and naive question to ask.  We've got this
> pattern recurring throughout the series:
> 
> > GLOBAL_STATE_CODE();
> > bdrv_drain_all_begin();
> > bdrv_graph_rdlock_main_loop();
> > 
> > ...
> > 
> > bdrv_graph_rdunlock_main_loop();
> > bdrv_drain_all_end();
> 
> bdrv_graph_rdlock_main_loop() doesn't actually take any locks, it
> asserts that we're running in the main thread and not in a coroutine.
> bdrv_graph_rdunlock_main_loop() does the same.
> GRAPH_RDLOCK_GUARD_MAINLOOP() does both those calls, in the beginning of
> a function and when leaving its scope, so essentially it also just does
> assert(qemu_in_main_thread() && !qemu_in_coroutine()).
> 
> Therefore:
> 
> 1. Is there any real benefit from using those
> {rdlock/rdunlock}_main_loop() constructions, or they're here due to
> historical reasons only?

It's the price we pay for the compiler to verify our locking rules.

> 2. Would it hurt if we only leave GRAPH_RDLOCK_GUARD_MAINLOOP() in all
> such occurrences?  At least when it's obvious we can't get out of the
> main thread.  That would simply deliver us from performing same checks
> several times, similar to what's done in commit 22/24 ("block/io: remove
> duplicate GLOBAL_STATE_CODE() in bdrv_do_drained_end()").

Once bdrv_drain_all_begin() is marked GRAPH_UNLOCKED, calling it after
GRAPH_RDLOCK_GUARD_MAINLOOP() would be wrong according to TSA rules
(which don't know anything about this being only a fake lock) and the
build would fail.

Kevin


