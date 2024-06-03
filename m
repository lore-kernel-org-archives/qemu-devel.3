Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2249C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gA-00039A-N8; Mon, 03 Jun 2024 07:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE5g9-00038P-7D
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE5g7-00067u-Cc
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717413396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZleCqpGh9AAHOxSQCX3G8XR+Y9SD8pRP1Phf4oGLbk=;
 b=MY89JXvaFXCiFZGO6OdHtSPgXV7m0G6FzMwZ7DCDnLdNVcl+7bJRLcJjBnGvAJS+qy1rBq
 AiQen/5yIcUo0Mgwq4XlC8omrjvnRyAOydm0LsuKDT76Hk8MkJnloV+c1Cx97Xol/hQPkA
 bcR8+LfNmxjev2HMNLz95fJleF4HM9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-0VBAzJTxNoahJl4mkkBUhA-1; Mon, 03 Jun 2024 07:16:32 -0400
X-MC-Unique: 0VBAzJTxNoahJl4mkkBUhA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5427D85A58C;
 Mon,  3 Jun 2024 11:16:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 514874026B8;
 Mon,  3 Jun 2024 11:16:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7258821E6757; Mon,  3 Jun 2024 13:16:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: Re: [PATCH v2 1/2] copy-before-write: allow specifying minimum
 cluster size
In-Reply-To: <20240528120114.344416-2-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Tue, 28 May 2024 14:01:13 +0200")
References: <20240528120114.344416-1-f.ebner@proxmox.com>
 <20240528120114.344416-2-f.ebner@proxmox.com>
Date: Mon, 03 Jun 2024 13:16:30 +0200
Message-ID: <87h6eatgxd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> In the context of backup fleecing, discarding the source will not work
> when the fleecing image has a larger granularity than the one used for
> block-copy operations (can happen if the backup target has smaller
> cluster size), because cbw_co_pdiscard_snapshot() will align down the
> discard requests and thus effectively ignore then.
>
> To make @discard-source work in such a scenario, allow specifying the
> minimum cluster size used for block-copy operations and thus in
> particular also the granularity for discard requests to the source.
>
> The type 'size' (corresponding to uint64_t in C) is used in QAPI to
> rule out negative inputs and for consistency with already existing
> @cluster-size parameters. Since block_copy_calculate_cluster_size()
> uses int64_t for its result, a check that the input is not too large
> is added in block_copy_state_new() before calling it. The calculation
> in block_copy_calculate_cluster_size() is done in the target int64_t
> type.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> Changes in v2:
> * Use 'size' type in QAPI.
> * Remove option in cbw_parse_options(), i.e. before parsing generic
>   blockdev options.
>
>  block/block-copy.c         | 22 ++++++++++++++++++----
>  block/copy-before-write.c  | 10 +++++++++-
>  include/block/block-copy.h |  1 +
>  qapi/block-core.json       |  8 +++++++-
>  4 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 7e3b378528..36eaecaaf4 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
>  }
>  
>  static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
> +                                                 int64_t min_cluster_size,
>                                                   Error **errp)
>  {
>      int ret;
> @@ -335,7 +336,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>                      "used. If the actual block size of the target exceeds "
>                      "this default, the backup may be unusable",
>                      BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

BLOCK_COPY_CLUSTER_SIZE_DEFAULT gets promoted from int to
min_cluster_size's type int64_t even without the cast.  The cast makes
it explicit.  Matter of taste, and I'm not the maintainer here :)

>      } else if (ret < 0 && !target_does_cow) {
>          error_setg_errno(errp, -ret,
>              "Couldn't determine the cluster size of the target image, "
> @@ -345,16 +346,18 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>          return ret;
>      } else if (ret < 0 && target_does_cow) {
>          /* Not fatal; just trudge on ahead. */
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

Likewise.

>      }
>  
> -    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
> +    return MAX(min_cluster_size,
> +               (int64_t)MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));

Likewise.

>  }
>  
>  BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                       BlockDriverState *copy_bitmap_bs,
>                                       const BdrvDirtyBitmap *bitmap,
>                                       bool discard_source,
> +                                     uint64_t min_cluster_size,
>                                       Error **errp)
>  {
>      ERRP_GUARD();
> @@ -365,7 +368,18 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>  
>      GLOBAL_STATE_CODE();
>  
> -    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
> +    if (min_cluster_size > INT64_MAX) {
> +        error_setg(errp, "min-cluster-size too large: %lu > %ld",
> +                   min_cluster_size, INT64_MAX);
> +        return NULL;
> +    } else if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
> +        error_setg(errp, "min-cluster-size needs to be a power of 2");
> +        return NULL;
> +    }
> +
> +    cluster_size = block_copy_calculate_cluster_size(target->bs,
> +                                                     (int64_t)min_cluster_size,
> +                                                     errp);

This is now more obviously safe.  Thanks!

>      if (cluster_size < 0) {
>          return NULL;
>      }
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index cd65524e26..ef0bc4dcfe 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -417,6 +417,7 @@ static BlockdevOptions *cbw_parse_options(QDict *options, Error **errp)
>      qdict_extract_subqdict(options, NULL, "bitmap");
>      qdict_del(options, "on-cbw-error");
>      qdict_del(options, "cbw-timeout");
> +    qdict_del(options, "min-cluster-size");
>  
>  out:
>      visit_free(v);
> @@ -432,6 +433,7 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>      BDRVCopyBeforeWriteState *s = bs->opaque;
>      BdrvDirtyBitmap *bitmap = NULL;
>      int64_t cluster_size;
> +    uint64_t min_cluster_size = 0;
>      g_autoptr(BlockdevOptions) full_opts = NULL;
>      BlockdevOptionsCbw *opts;
>      int ret;
> @@ -476,8 +478,14 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>               bs->file->bs->supported_zero_flags);
>  
>      s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
> +
> +    if (opts->has_min_cluster_size) {
> +        min_cluster_size = opts->min_cluster_size;
> +    }
> +
>      s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
> -                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
> +                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
> +                                  min_cluster_size, errp);
>      if (!s->bcs) {
>          error_prepend(errp, "Cannot create block-copy-state: ");
>          return -EINVAL;

You can pass opts->min_cluster_size directly, as in v1.  When
!opts->has_min_cluster_size, then opts->min_cluster_size is zero.

> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index bdc703bacd..dd5cc82f3b 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                       BlockDriverState *copy_bitmap_bs,
>                                       const BdrvDirtyBitmap *bitmap,
>                                       bool discard_source,
> +                                     uint64_t min_cluster_size,
>                                       Error **errp);
>  
>  /* Function should be called prior any actual copy request */
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df5e07debd..8fc0a4b234 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4642,12 +4642,18 @@
>  #     @on-cbw-error parameter will decide how this failure is handled.
>  #     Default 0.  (Since 7.1)
>  #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     operations.  Has to be a power of 2.  No effect if smaller than
> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
> +#     (Since 9.1)
> +#
>  # Since: 6.2
>  ##
>  { 'struct': 'BlockdevOptionsCbw',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
> +            '*min-cluster-size': 'size' } }
>  
>  ##
>  # @BlockdevOptions:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


