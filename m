Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB65CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQL7D-0007Os-3j; Fri, 22 May 2026 04:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQL78-0007NS-Gm; Fri, 22 May 2026 04:20:14 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQL74-0000GC-1k; Fri, 22 May 2026 04:20:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 932EE80839;
 Fri, 22 May 2026 11:20:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55c::1:1d] (unknown
 [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xJPLML0hBW20-dGTaKmvR; Fri, 22 May 2026 11:20:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779438000;
 bh=PnO5qIi6f4fPUpEMaAB6d2qMDYFoeEWBbuUmmTQx4Ps=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=scqZ2LpQ+BYX/OwXLAGIFEwWORf2w46KPNhrjJ7tAUAWrcDJzTQ1UvfeqAA27uxhr
 gILlmfnJvIAF6a3r7W4a0LI+bbtFxzo45owMTTUKHTPrOa6quyl8iG0SV2vDyTAnX5
 4pGI4fxjGKYxDKBqYoS/qAAoqrLyIRTESXrIBUtc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b5391bdd-387c-4a61-824d-d998dd442058@yandex-team.ru>
Date: Fri, 22 May 2026 11:19:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qcow2: add functionality to repair bitmaps
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20260521091918.2366140-1-jean-louis@dupond.be>
 <20260521091918.2366140-3-jean-louis@dupond.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260521091918.2366140-3-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21.05.26 12:19, Jean-Louis Dupond wrote:
> In some cases, it might happen that bitmaps become corrupt.
> For example when adding/removing bitmaps on a live image.
> 
> Of course this should not happen, but in case this happens, the image is
> corrupt and even cannot be opened anymore. You'll get something like the
> following:
> qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the constraints
> 
> So the image becomes useless, and cannot be repaired. This while in fact
> only (one) bitmap entry is corrupt, and the rest of the data is just
> intact.
> 
> This commit adds a way to fix this corruption, by just replacing the
> bitmap list in the qcow2 image with the valid bitmaps, and dropping the
> bitmaps that are corrupt.
> 
> $ qemu-img check disk.qcow2
> qemu-img: Check failed: Invalid argument
> qemu-img: Lost persistent bitmaps during inactivation of node '#block147': Bitmap '' doesn't satisfy the constraints
> 
> $ qemu-img check -r all disk.qcow2
> qcow2_free_clusters failed: Invalid argument
> Leaked cluster 3 refcount=1 reference=0
> Leaked cluster 26 refcount=1 reference=0
> ERROR cluster 983214 refcount=0 reference=1
> Rebuilding refcount structure
> Repairing cluster 1 refcount=1 reference=0
> Repairing cluster 2 refcount=1 reference=0
> Repairing cluster 32768 refcount=1 reference=0
> Repairing cluster 65536 refcount=1 reference=0
> Repairing cluster 98304 refcount=1 reference=0
> Repairing cluster 131072 refcount=1 reference=0
> Repairing cluster 163840 refcount=1 reference=0
> Repairing cluster 196612 refcount=1 reference=0
> Repairing cluster 229377 refcount=1 reference=0
> Repairing cluster 262146 refcount=1 reference=0
> Repairing cluster 294915 refcount=1 reference=0
> Repairing cluster 327684 refcount=1 reference=0
> Repairing cluster 360449 refcount=1 reference=0
> Repairing cluster 393218 refcount=1 reference=0
> Repairing cluster 425987 refcount=1 reference=0
> Repairing cluster 458756 refcount=1 reference=0
> Repairing cluster 491521 refcount=1 reference=0
> Repairing cluster 524289 refcount=1 reference=0
> Repairing cluster 557058 refcount=1 reference=0
> Repairing cluster 589827 refcount=1 reference=0
> Repairing cluster 622596 refcount=1 reference=0
> Repairing cluster 655361 refcount=1 reference=0
> Repairing cluster 688130 refcount=1 reference=0
> Repairing cluster 720899 refcount=1 reference=0
> Repairing cluster 753668 refcount=1 reference=0
> Repairing cluster 786433 refcount=1 reference=0
> Repairing cluster 819202 refcount=1 reference=0
> Repairing cluster 851971 refcount=1 reference=0
> Repairing cluster 884740 refcount=1 reference=0
> Repairing cluster 917505 refcount=1 reference=0
> Repairing cluster 950274 refcount=1 reference=0

I think, most of these lines may be replaced with "...".

> Repairing cluster 983042 refcount=1 reference=0
> Repairing cluster 983214 refcount=1 reference=0
> The following inconsistencies were found and repaired:
> 
>      2 leaked clusters
>      3 corruptions
> 
> Double checking the fixed image now...
> No errors were found on the image.
> 983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed clusters
> Image end offset: 64437878784
> 
> And the image is valid again!
> Worst case you lose all bitmaps, but at least the image and the data
> itself is useable again.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>

Overall looks good to me, still some comments below.

> ---
>   block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
>   block/qcow2-refcount.c |  3 ++-
>   block/qcow2.c          | 15 +++++++++++----
>   block/qcow2.h          |  3 ++-
>   4 files changed, 56 insertions(+), 7 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b87940bb43..bcc9462feb 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1734,11 +1734,14 @@ uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *in_bs,
>   int coroutine_fn
>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                 void **refcount_table,
> -                              int64_t *refcount_table_size)
> +                              int64_t *refcount_table_size,
> +                              BdrvCheckMode fix)
>   {
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
>       Qcow2BitmapList *bm_list;
> +    Qcow2BitmapList *fixed_list = NULL;
> +    int valid_bitmaps = 0;
>       Qcow2Bitmap *bm;
>   
>       if (s->nb_bitmaps == 0) {
> @@ -1752,16 +1755,29 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>           return ret;
>       }
>   
> +    if (fix & BDRV_FIX_ERRORS) {
> +        fixed_list = bitmap_list_new();
> +    }
> +
>       bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                  s->bitmap_directory_size, NULL);
>       if (bm_list == NULL) {
>           res->corruptions++;
> +
> +        if (fix & BDRV_FIX_ERRORS) {
> +            ret = update_ext_header_and_dir(bs, fixed_list);
> +            if (ret >= 0) {
> +                res->corruptions_fixed++;
> +            }
> +            goto out;
> +        }
>           return -EINVAL;
>       }
>   
>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>           uint64_t *bitmap_table = NULL;
>           int i;
> +        bool bitmap_valid = true;
>   
>           ret = qcow2_inc_refcounts_imrt(bs, res,
>                                          refcount_table, refcount_table_size,
> @@ -1774,6 +1790,9 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>           ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
>           if (ret < 0) {
>               res->corruptions++;
> +            if (fix & BDRV_FIX_ERRORS) {
> +                continue;
> +            }
>               goto out;
>           }
>   
> @@ -1783,6 +1802,7 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>   
>               if (check_table_entry(entry, s->cluster_size) < 0) {
>                   res->corruptions++;
> +                bitmap_valid = false;
>                   continue;
>               }
>   
> @@ -1799,10 +1819,30 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>               }
>           }
>   
> +        if ((fix & BDRV_FIX_ERRORS) && bitmap_valid) {
> +            valid_bitmaps++;
> +            Qcow2Bitmap *bm_copy = g_new0(Qcow2Bitmap, 1);
> +            *bm_copy = *bm;
> +            bm_copy->name = g_strdup(bm->name);
> +            QSIMPLEQ_INSERT_TAIL(fixed_list, bm_copy, entry);
> +        }
> +
>           g_free(bitmap_table);
>       }
>   
> +    /* If fixing, update the bitmap directory with the repaired list */
> +    if ((fix & BDRV_FIX_ERRORS) && s->nb_bitmaps != valid_bitmaps) {
> +        ret = update_ext_header_and_dir(bs, fixed_list);
> +        if (ret >= 0) {
> +            res->corruptions_fixed += s->nb_bitmaps - valid_bitmaps;

Previous call to  update_ext_header_and_dir() already made "s->nb_bitmaps = new_nb_bitmaps", so,
I expect this difference "s->nb_bitmaps - valid_bitmaps" would be always zero.

> +        }
> +    }
> +
>   out:
> +    if (fix & BDRV_FIX_ERRORS) {

"if" maybe omitted, as bitmap_list_free() has null-check at the beginning.

> +        bitmap_list_free(fixed_list);
> +    }
> +
>       bitmap_list_free(bm_list);
>   
>       return ret;
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 6512cda407..df7f6d2f23 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2305,7 +2305,8 @@ calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>       }
>   
>       /* bitmaps */
> -    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, nb_clusters);
> +    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table,
> +                                        nb_clusters, fix);
>       if (ret < 0) {
>           return ret;
>       }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 81fd299b4c..dfb6b23932 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1927,11 +1927,18 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>       if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>           /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
>           bool header_updated;
> -        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
> -            ret = -EINVAL;
> -            goto fail;
> +        Error *local_err = NULL;
> +        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, &local_err)) {
> +            /* Allow this to fail in check mode

Qemu style ask for opening "/*" on a separate line, if I remember correctly.

> +             * because otherwise we can't open the image at all.
> +             */
> +            if (!(flags & BDRV_O_CHECK)) {

I'm a bit confused, that we don't have similar logic for other checks in qcow2_do_open(),
like qcow2_validate_table() calls... So, qemu-img check can't repair any error that doesn't
have such "if (!_CHECK)" in qcow2_do_open()?

On the other hand, I don't see any other way to do it. qemu-img check needs to open the image
first anyway.

> +                ret = -EINVAL;
> +                error_propagate(errp, local_err);
> +                goto fail;
> +            }
> +            error_free(local_err);
>           }
> -
>           update_header = update_header && !header_updated;
>       }
>   
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 192a45d596..2d9c6929a7 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -1034,7 +1034,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
>   int coroutine_fn GRAPH_RDLOCK
>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                 void **refcount_table,
> -                              int64_t *refcount_table_size);
> +                              int64_t *refcount_table_size,
> +                              BdrvCheckMode fix);
>   
>   bool coroutine_fn GRAPH_RDLOCK
>   qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,


-- 
Best regards,
Vladimir

