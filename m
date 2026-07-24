Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE59C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFox-0001gF-2A; Fri, 24 Jul 2026 09:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnFon-0001Nl-Cz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnFom-00056G-2w
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784899199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ubiKibu8zl7z7x/gixfrgnSBYVwrzyl4hfifSU9rVM=;
 b=a+no/ayI7XeBXxoPUymRP3/r73X4kuNBKxe62BekfSvKhekhIxvi4zJ8YfLrXSJQ/gLFZ3
 LlyMrvlHwT41Wj9fjReGjVFMxWpXZkMOvOmfPen4Hy/v6tp0SWXS+E84YYwV8fMcc5ADtq
 PmNwvdzyTq7mUIKrJ3ptPPNtcgtCjP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-vIi1JKzmPCuFwDSR8HGTiQ-1; Fri,
 24 Jul 2026 09:19:57 -0400
X-MC-Unique: vIi1JKzmPCuFwDSR8HGTiQ-1
X-Mimecast-MFC-AGG-ID: vIi1JKzmPCuFwDSR8HGTiQ_1784899195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ACE6195608F; Fri, 24 Jul 2026 13:19:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF6630002D5; Fri, 24 Jul 2026 13:19:47 +0000 (UTC)
Date: Fri, 24 Jul 2026 15:19:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 6/8] block: add missing coroutine_fn annotations
Message-ID: <amNmcTIfZT0OFpkB@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-6-fabb4db3c204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-co-v1-6-fabb4db3c204@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Am 20.07.2026 um 09:55 hat Marc-André Lureau geschrieben:
> The functions call coroutine functions or are called by coroutine.

That it's called only by coroutines isn't a reason to make a function
coroutine_fn as long as it theoretically could be called by
non-coroutine code and it would still work fine (i.e. it doesn't yield).

> Add an assert() in qcow2_do_close() code path which calls a
> no_coroutine_fn bdrv_graph_wrlock_drained().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

> diff --git a/block/parallels.c b/block/parallels.c
> index 7a90fb5220b..46a6e8f2743 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -142,8 +142,9 @@ static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
>      return off / s->cluster_size;
>  }
>  
> -static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
> -                            int nb_sectors, int *pnum)
> +static int64_t coroutine_fn
> +block_status(BDRVParallelsState *s, int64_t sector_num,
> +             int nb_sectors, int *pnum)
>  {
>      int64_t start_off = -2, prev_end_off = -2;
>  

Specifically this hunk is unclear to me.

As far as I can see, block_status() can't yield. Why did you add the
coroutine_fn marker here, but not e.g. for seek_to_sector() or
cluster_remainder(), which are only called by block_status() and
therefore also always only in coroutine context?

I believe the right way to stay consistent is to leave all of them
unmarked because there is no fundamental reason why they would only make
sense in coroutine context.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19271b10a49..161626fa3cb 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1287,9 +1287,10 @@ fail:
>  }
>  
>  /* s_locked specifies whether s->lock is held or not */
> -static void qcow2_update_options_commit(BlockDriverState *bs,
> -                                        Qcow2ReopenState *r,
> -                                        bool s_locked)
> +static void coroutine_fn
> +qcow2_update_options_commit(BlockDriverState *bs,
> +                            Qcow2ReopenState *r,
> +                            bool s_locked)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int i;
> @@ -2126,7 +2127,8 @@ fail:
>      return ret;
>  }
>  
> -static void qcow2_reopen_commit(BDRVReopenState *state)
> +static void coroutine_fn
> +qcow2_reopen_commit(BDRVReopenState *state)
>  {
>      BDRVQcow2State *s = state->bs->opaque;
>  

This doesn't match the declaration of the .bdrv_reopen_commit callback
in BlockDriver, and as far as I can see, the callers are actually
guaranteed to _not_ be in coroutine context.

If this is true, qcow2_update_options_commit() should probably be marked
coroutine_mixed_fn and this one stay unannotated or no_coroutine_fn.

The other parts of the patch looks correct.

Kevin


