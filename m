Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5042C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4Vl-0003sM-Q0; Tue, 25 Jun 2024 07:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM4Vi-0003rQ-Vh; Tue, 25 Jun 2024 07:38:55 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM4Vf-0007dv-P7; Tue, 25 Jun 2024 07:38:54 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C78B660DED;
 Tue, 25 Jun 2024 14:38:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id icNBaH0JiSw0-g8znkRCW; Tue, 25 Jun 2024 14:38:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719315525;
 bh=06FJaCAKMz6cusDNtyHpXYQwgBTlyfdsnZcclhEZsbo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=b8HDEHvzW4XtIWtfqkW0l5Rb4XMo68Y+qL6YDFcXvQ94FD/oneqFz8B6XHRkzlS0n
 r2Qk1mmq2z1u4kvPzeFv6W78mwxyhPetko7U6Zq6gHiWT8iIsFTRKm6cpYuawFRGtj
 HUHs3n2GZ1BPiQeZzyIlzlivoVmFHQc5AGjN+LzU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a6f4411c-71f1-4e00-a471-02a1bdba617e@yandex-team.ru>
Date: Tue, 25 Jun 2024 14:38:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] backup: add minimum cluster size to performance
 options
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240528120114.344416-1-f.ebner@proxmox.com>
 <20240528120114.344416-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240528120114.344416-3-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Use 'size' type in QAPI.
> 
>   block/backup.c            | 2 +-
>   block/copy-before-write.c | 8 ++++++++
>   block/copy-before-write.h | 1 +
>   blockdev.c                | 3 +++
>   qapi/block-core.json      | 9 +++++++--
>   5 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 3dd2e229d2..a1292c01ec 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -458,7 +458,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>       }
>   
>       cbw = bdrv_cbw_append(bs, target, filter_node_name, discard_source,
> -                          &bcs, errp);
> +                          perf->min_cluster_size, &bcs, errp);
>       if (!cbw) {
>           goto error;
>       }
> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index ef0bc4dcfe..183eed42e5 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -553,6 +553,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
>                                     BlockDriverState *target,
>                                     const char *filter_node_name,
>                                     bool discard_source,
> +                                  uint64_t min_cluster_size,
>                                     BlockCopyState **bcs,
>                                     Error **errp)
>   {
> @@ -572,6 +573,13 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
>       qdict_put_str(opts, "file", bdrv_get_node_name(source));
>       qdict_put_str(opts, "target", bdrv_get_node_name(target));
>   
> +    if (min_cluster_size > INT64_MAX) {
> +        error_setg(errp, "min-cluster-size too large: %lu > %ld",
> +                   min_cluster_size, INT64_MAX);

opts leaked here.

with that fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +        return NULL;
> +    }
> +    qdict_put_int(opts, "min-cluster-size", (int64_t)min_cluster_size);
> +
>       top = bdrv_insert_node(source, opts, flags, errp);
>       if (!top) {
>           return NULL;
> diff --git a/block/copy-before-write.h b/block/copy-before-write.h
> index 01af0cd3c4..2a5d4ba693 100644
> --- a/block/copy-before-write.h
> +++ b/block/copy-before-write.h
> @@ -40,6 +40,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
>                                     BlockDriverState *target,
>                                     const char *filter_node_name,
>                                     bool discard_source,
> +                                  uint64_t min_cluster_size,
>                                     BlockCopyState **bcs,
>                                     Error **errp);
>   void bdrv_cbw_drop(BlockDriverState *bs);
> diff --git a/blockdev.c b/blockdev.c
> index 835064ed03..6740663fda 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2655,6 +2655,9 @@ static BlockJob *do_backup_common(BackupCommon *backup,
>           if (backup->x_perf->has_max_chunk) {
>               perf.max_chunk = backup->x_perf->max_chunk;
>           }
> +        if (backup->x_perf->has_min_cluster_size) {
> +            perf.min_cluster_size = backup->x_perf->min_cluster_size;
> +        }
>       }
>   
>       if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8fc0a4b234..f1219a9dfb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1551,11 +1551,16 @@
>   #     it should not be less than job cluster size which is calculated
>   #     as maximum of target image cluster size and 64k.  Default 0.
>   #
> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
> +#     and background copy operations.  Has to be a power of 2.  No
> +#     effect if smaller than the maximum of the target's cluster size
> +#     and 64 KiB.  Default 0.  (Since 9.1)
> +#
>   # Since: 6.0
>   ##
>   { 'struct': 'BackupPerf',
> -  'data': { '*use-copy-range': 'bool',
> -            '*max-workers': 'int', '*max-chunk': 'int64' } }
> +  'data': { '*use-copy-range': 'bool', '*max-workers': 'int',
> +            '*max-chunk': 'int64', '*min-cluster-size': 'size' } }
>   
>   ##
>   # @BackupCommon:

-- 
Best regards,
Vladimir


