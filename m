Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07883CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9C8-0007Ig-5G; Fri, 29 Mar 2024 06:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq9C4-0007Fm-2P; Fri, 29 Mar 2024 06:10:40 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq9C0-0001yH-2Z; Fri, 29 Mar 2024 06:10:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 0071760A32;
 Fri, 29 Mar 2024 13:10:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UALeud26VuQ0-jDUgKtf5; Fri, 29 Mar 2024 13:10:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711707031;
 bh=4evnooogcCZE5AfBi9RVTFX6KZtd3/EFZAv9M3dMHhg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1lGIc1ZCsYYGmQz/f7LfHqcmhIc2ZJGuvgZjuRnOxHTjYfiiNKkAgGC5WOITXIhu6
 jD70hD/oavLkx/7qeMf5LL8zbIDbM2Tp7xYcni3GQArXjo5/S8hZ+pPOv+F32lP2Nc
 JVWe6a0VC/s9RtFuvLsMoMA0tC50Fj54JJfnP0V4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae1adcea-3540-42c1-9815-deab52e83e77@yandex-team.ru>
Date: Fri, 29 Mar 2024 13:10:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] copy-before-write: allow specifying minimum cluster
 size
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240308155158.830258-1-f.ebner@proxmox.com>
 <20240308155158.830258-2-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240308155158.830258-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 08.03.24 18:51, Fiona Ebner wrote:
> Useful to make discard-source work in the context of backup fleecing
> when the fleecing image has a larger granularity than the backup
> target.
> 
> Copy-before-write operations will use at least this granularity and in
> particular, discard requests to the source node will too. If the
> granularity is too small, they will just be aligned down in
> cbw_co_pdiscard_snapshot() and thus effectively ignored.
> 
> The QAPI uses uint32 so the value will be non-negative, but still fit
> into a uint64_t.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/block-copy.c         | 17 +++++++++++++----
>   block/copy-before-write.c  |  3 ++-
>   include/block/block-copy.h |  1 +
>   qapi/block-core.json       |  8 +++++++-
>   4 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 7e3b378528..adb1cbb440 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
>   }
>   
>   static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
> +                                                 int64_t min_cluster_size,

Maybe better use uint32_t here as well.

>                                                    Error **errp)
>   {
>       int ret;
> @@ -335,7 +336,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>                       "used. If the actual block size of the target exceeds "
>                       "this default, the backup may be unusable",
>                       BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
>       } else if (ret < 0 && !target_does_cow) {
>           error_setg_errno(errp, -ret,
>               "Couldn't determine the cluster size of the target image, "
> @@ -345,16 +346,18 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
>           return ret;
>       } else if (ret < 0 && target_does_cow) {
>           /* Not fatal; just trudge on ahead. */
> -        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
> +        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
>       }
>   
> -    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
> +    return MAX(min_cluster_size,
> +               MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));
>   }
>   
>   BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                        BlockDriverState *copy_bitmap_bs,
>                                        const BdrvDirtyBitmap *bitmap,
>                                        bool discard_source,
> +                                     int64_t min_cluster_size,

and here why not uint32_t

>                                        Error **errp)
>   {
>       ERRP_GUARD();
> @@ -365,7 +368,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>   
>       GLOBAL_STATE_CODE();
>   
> -    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
> +    if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
> +        error_setg(errp, "min-cluster-size needs to be a power of 2");
> +        return NULL;
> +    }
> +
> +    cluster_size = block_copy_calculate_cluster_size(target->bs,
> +                                                     min_cluster_size, errp);
>       if (cluster_size < 0) {
>           return NULL;
>       }
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index dac57481c5..f9896c6c1e 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -476,7 +476,8 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
>   
>       s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
>       s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
> -                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
> +                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
> +                                  opts->min_cluster_size, errp);

I assume it is guaranteed to be 0 when not specified by user.

>       if (!s->bcs) {
>           error_prepend(errp, "Cannot create block-copy-state: ");
>           return -EINVAL;
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index bdc703bacd..77857c6c68 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>                                        BlockDriverState *copy_bitmap_bs,
>                                        const BdrvDirtyBitmap *bitmap,
>                                        bool discard_source,
> +                                     int64_t min_cluster_size,
>                                        Error **errp);
>   
>   /* Function should be called prior any actual copy request */
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0a72c590a8..85c8f88f6e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4625,12 +4625,18 @@
>   #     @on-cbw-error parameter will decide how this failure is handled.
>   #     Default 0. (Since 7.1)
>   #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     operations.  Has to be a power of 2.  No effect if smaller than
> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
> +#     (Since 9.0)

will have to update to 9.1

> +#
>   # Since: 6.2
>   ##
>   { 'struct': 'BlockdevOptionsCbw',
>     'base': 'BlockdevOptionsGenericFormat',
>     'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
> +            '*min-cluster-size': 'uint32' } }
>   
>   ##
>   # @BlockdevOptions:


Otherwise, looks good to me.

-- 
Best regards,
Vladimir


