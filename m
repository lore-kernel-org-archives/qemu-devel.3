Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4398C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4Mb-0001Xh-6H; Tue, 25 Jun 2024 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM4MZ-0001Ww-1u; Tue, 25 Jun 2024 07:29:27 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM4MV-0005jH-1Z; Tue, 25 Jun 2024 07:29:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2208:0:640:cdc8:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1EAEE60BA0;
 Tue, 25 Jun 2024 14:29:15 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DTNkUG0IjSw0-AT8Dgu1S; Tue, 25 Jun 2024 14:29:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719314954;
 bh=W+cZdRvy95FUSfOg6/73/RQu02gtiRHrpJSsjqGRuho=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RwTP/mOZVA+jaS6sAeEUzwsuWiti1QAQE8n7SdEpa4Kqvp+EDQwMzJ3J9b1FKxrgD
 v++Iw65kEpSlIaO3pSr/cb06nZvJspqehJY3FOprEVgeIB/ffLmasVV+FR1NLlQwwm
 3JVsujEJlSNB3v6l1zrVSKnxHYiQH3xYQKAzCyJk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <35c36e55-aaa6-4854-b6e9-b7bbf69c7aad@yandex-team.ru>
Date: Tue, 25 Jun 2024 14:29:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] copy-before-write: allow specifying minimum
 cluster size
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240528120114.344416-1-f.ebner@proxmox.com>
 <20240528120114.344416-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240528120114.344416-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 28.05.24 15:01, Fiona Ebner wrote:
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
>    blockdev options.
> 
>   block/block-copy.c         | 22 ++++++++++++++++++----
>   block/copy-before-write.c  | 10 +++++++++-
>   include/block/block-copy.h |  1 +
>   qapi/block-core.json       |  8 +++++++-
>   4 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 7e3b378528..36eaecaaf4 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
>   }
>   
>   static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
> +                                                 int64_t min_cluster_size,
>                                                    Error **errp)
>   {
>       int ret;
> @@ -335,7 +336,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>                       "used. If the actual block size of the target exceeds "
>                       "this default, the backup may be unusable",
>                       BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

instead of triple use MAX(min_..., let's just do

    min_cluster_size = MAX(min_cluster_size, (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

at start of function, and then use min_cluster_size


anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

>       } else if (ret < 0 && !target_does_cow) {
>           error_setg_errno(errp, -ret,
>               "Couldn't determine the cluster size of the target image, "
> @@ -345,16 +346,18 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>           return ret;
>       } else if (ret < 0 && target_does_cow) {
>           /* Not fatal; just trudge on ahead. */
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
>       }
>   
> -    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
> +    return MAX(min_cluster_size,
> +               (int64_t)MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));
>   }
>   
>   BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                        BlockDriverState *copy_bitmap_bs,
>                                        const BdrvDirtyBitmap *bitmap,
>                                        bool discard_source,
> +                                     uint64_t min_cluster_size,
>                                        Error **errp)
>   {
>       ERRP_GUARD();
> @@ -365,7 +368,18 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>   
>       GLOBAL_STATE_CODE();
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
>       if (cluster_size < 0) {
>           return NULL;
>       }
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index cd65524e26..ef0bc4dcfe 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -417,6 +417,7 @@ static BlockdevOptions *cbw_parse_options(QDict *options, Error **errp)
>       qdict_extract_subqdict(options, NULL, "bitmap");
>       qdict_del(options, "on-cbw-error");
>       qdict_del(options, "cbw-timeout");
> +    qdict_del(options, "min-cluster-size");
>   
>   out:
>       visit_free(v);
> @@ -432,6 +433,7 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>       BDRVCopyBeforeWriteState *s = bs->opaque;
>       BdrvDirtyBitmap *bitmap = NULL;
>       int64_t cluster_size;
> +    uint64_t min_cluster_size = 0;
>       g_autoptr(BlockdevOptions) full_opts = NULL;
>       BlockdevOptionsCbw *opts;
>       int ret;
> @@ -476,8 +478,14 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>                bs->file->bs->supported_zero_flags);
>   
>       s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
> +
> +    if (opts->has_min_cluster_size) {
> +        min_cluster_size = opts->min_cluster_size;
> +    }
> +
>       s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
> -                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
> +                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
> +                                  min_cluster_size, errp);
>       if (!s->bcs) {
>           error_prepend(errp, "Cannot create block-copy-state: ");
>           return -EINVAL;
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index bdc703bacd..dd5cc82f3b 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                        BlockDriverState *copy_bitmap_bs,
>                                        const BdrvDirtyBitmap *bitmap,
>                                        bool discard_source,
> +                                     uint64_t min_cluster_size,
>                                        Error **errp);
>   
>   /* Function should be called prior any actual copy request */
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df5e07debd..8fc0a4b234 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4642,12 +4642,18 @@
>   #     @on-cbw-error parameter will decide how this failure is handled.
>   #     Default 0.  (Since 7.1)
>   #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     operations.  Has to be a power of 2.  No effect if smaller than
> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
> +#     (Since 9.1)
> +#
>   # Since: 6.2
>   ##
>   { 'struct': 'BlockdevOptionsCbw',
>     'base': 'BlockdevOptionsGenericFormat',
>     'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
> +            '*min-cluster-size': 'size' } }
>   
>   ##
>   # @BlockdevOptions:

-- 
Best regards,
Vladimir


