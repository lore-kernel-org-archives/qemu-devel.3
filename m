Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167FDCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 20:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrkWO-0000TF-Fs; Tue, 02 Apr 2024 16:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrkWK-0000Sb-Ur; Tue, 02 Apr 2024 16:14:15 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rrkWI-0003BS-35; Tue, 02 Apr 2024 16:14:12 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7619:0:640:c0b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id EDE9C608C4;
 Tue,  2 Apr 2024 23:14:03 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b507::1:2e] (unknown
 [2a02:6b8:b081:b507::1:2e])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1EZ7TU40QeA0-vDgIhVFF; Tue, 02 Apr 2024 23:14:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712088843;
 bh=9HZGcUl7SGuQfI8dT8CTEBKiqG/3mCbgTksDnoWzF4o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=d7NfadhykqZZRnFNkU4mmXt90kLmQJLLF/6RCfBSy++fWwAcX02OVA/n7fGin5amU
 PWUKpyPwCAJ5054yEfN1lr5noyWtyeZm23GcygLPNG0yMYVP6MdKaAGjIalI9faVZh
 pZtV3CyvTEa9nCLZxxquqnY5A8Fjzskcxk2MwcvA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3e338160-a172-42b8-946c-ae7f7d97a17c@yandex-team.ru>
Date: Tue, 2 Apr 2024 23:14:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mirror: allow specifying working bitmap
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240307134711.709816-1-f.ebner@proxmox.com>
 <20240307134711.709816-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240307134711.709816-3-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 07.03.24 16:47, Fiona Ebner wrote:
> From: John Snow <jsnow@redhat.com>
> 
> for the mirror job. The bitmap's granularity is used as the job's
> granularity.
> 
> The new @bitmap parameter is marked unstable in the QAPI and can
> currently only be used for @sync=full mode.
> 
> Clusters initially dirty in the bitmap as well as new writes are
> copied to the target.
> 
> Using block-dirty-bitmap-clear and block-dirty-bitmap-merge API,
> callers can simulate the three kinds of @BitmapSyncMode (which is used
> by backup):
> 1. always: default, just pass bitmap as working bitmap.
> 2. never: copy bitmap and pass copy to the mirror job.
> 3. on-success: copy bitmap and pass copy to the mirror job and if
>     successful, merge bitmap into original afterwards.
> 
> When the target image is a fresh "diff image", i.e. one that was not
> used as the target of a previous mirror and the target image's cluster
> size is larger than the bitmap's granularity, or when
> @copy-mode=write-blocking is used, there is a pitfall, because the
> cluster in the target image will be allocated, but not contain all the
> data corresponding to the same region in the source image.
> 
> An idea to avoid the limitation would be to mark clusters which are
> affected by unaligned writes and are not allocated in the target image
> dirty, so they would be copied fully later. However, for migration,
> the invariant that an actively synced mirror stays actively synced
> (unless an error happens) is useful, because without that invariant,
> migration might inactivate block devices when mirror still got work
> to do and run into an assertion failure [0].
> 
> Another approach would be to read the missing data from the source
> upon unaligned writes to be able to write the full target cluster
> instead.
> 
> But certain targets like NBD do not allow querying the cluster size.
> To avoid limiting/breaking the use case of syncing to an existing
> target, which is arguably more common than the diff image use case,
> document the limiation in QAPI.
> 
> This patch was originally based on one by Ma Haocong, but it has since
> been modified pretty heavily, first by John and then again by Fiona.
> 
> [0]: https://lore.kernel.org/qemu-devel/1db7f571-cb7f-c293-04cc-cd856e060c3f@proxmox.com/
> 
> Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> [FG: switch to bdrv_dirty_bitmap_merge_internal]
> Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> [FE: rebase for 9.0
>       get rid of bitmap mode parameter
>       use caller-provided bitmap as working bitmap
>       turn bitmap parameter experimental]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/mirror.c                         | 95 ++++++++++++++++++++------
>   blockdev.c                             | 39 +++++++++--
>   include/block/block_int-global-state.h |  5 +-
>   qapi/block-core.json                   | 37 +++++++++-
>   tests/unit/test-block-iothread.c       |  2 +-
>   5 files changed, 146 insertions(+), 32 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 1609354db3..5c9a00b574 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -51,7 +51,7 @@ typedef struct MirrorBlockJob {
>       BlockDriverState *to_replace;
>       /* Used to block operations on the drive-mirror-replace target */
>       Error *replace_blocker;
> -    bool is_none_mode;
> +    MirrorSyncMode sync_mode;

Could you please split this change to separate preparation patch?

>       BlockMirrorBackingMode backing_mode;
>       /* Whether the target image requires explicit zero-initialization */
>       bool zero_target;
> @@ -73,6 +73,11 @@ typedef struct MirrorBlockJob {
>       size_t buf_size;
>       int64_t bdev_length;
>       unsigned long *cow_bitmap;
> +    /*
> +     * Whether the bitmap is created locally or provided by the caller (for
> +     * incremental sync).
> +     */
> +    bool dirty_bitmap_is_local;
>       BdrvDirtyBitmap *dirty_bitmap;
>       BdrvDirtyBitmapIter *dbi;

[..]

> +    if (bitmap_name) {
> +        if (sync != MIRROR_SYNC_MODE_FULL) {
> +            error_setg(errp, "Sync mode '%s' not supported with bitmap.",
> +                       MirrorSyncMode_str(sync));
> +            return;
> +        }
> +        if (granularity) {
> +            error_setg(errp, "Granularity and bitmap cannot both be set");
> +            return;
> +        }
> +
> +        bitmap = bdrv_find_dirty_bitmap(bs, bitmap_name);
> +        if (!bitmap) {
> +            error_setg(errp, "Dirty bitmap '%s' not found", bitmap_name);
> +            return;
> +        }
> +
> +        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {

Why allow read-only bitmaps?

> +            return;
> +        }
> +    }
> +
>       if (!bdrv_backing_chain_next(bs) && sync == MIRROR_SYNC_MODE_TOP) {
>           sync = MIRROR_SYNC_MODE_FULL;
>       }
> @@ -2889,10 +2913,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,

[..]

> +# @unstable: Member @bitmap is experimental.
> +#
>   # Since: 1.3
>   ##
>   { 'struct': 'DriveMirror',
>     'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>               '*format': 'str', '*node-name': 'str', '*replaces': 'str',
> -            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> +            'sync': 'MirrorSyncMode',
> +            '*bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
> +            '*mode': 'NewImageMode',
>               '*speed': 'int', '*granularity': 'uint32',
>               '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
>               '*on-target-error': 'BlockdevOnError',
> @@ -2513,6 +2531,18 @@
>   #     destination (all the disk, only the sectors allocated in the
>   #     topmost image, or only new I/O).
>   #
> +# @bitmap: The name of a bitmap to use as a working bitmap for
> +#     sync=full mode.  This argument must be not be present for other
> +#     sync modes and not at the same time as @granularity.  The
> +#     bitmap's granularity is used as the job's granularity.  When
> +#     the target is a diff image, i.e. one that should only contain
> +#     the delta and was not synced to previously, the target's
> +#     cluster size must not be larger than the bitmap's granularity.

Could we check this? Like in block_copy_calculate_cluster_size(), we can check if target does COW, and if not, we can check that we are safe with granularity.

> +#     For a diff image target, using copy-mode=write-blocking should
> +#     not be used, because unaligned writes will lead to allocated
> +#     clusters with partial data in the target image!

Could this be checked?

>  The bitmap
> +#     will be enabled after the job finishes.  (Since 9.0)

Hmm. That looks correct. At least for the case, when bitmap is enabled at that start of job. Suggest to require this.

> +#
>   # @granularity: granularity of the dirty bitmap, default is 64K if the
>   #     image format doesn't have clusters, 4K if the clusters are
>   #     smaller than that, else the cluster size.  Must be a power of 2
> @@ -2548,6 +2578,10 @@
>   #     disappear from the query list without user intervention.
>   #     Defaults to true.  (Since 3.1)
>   #
> +# Features:
> +#
> +# @unstable: Member @bitmap is experimental.
> +#
>   # Since: 2.6

Y_MODE_BACKGROUND,
>                    &error_abort);

[..]

Generally looks good to me.

-- 
Best regards,
Vladimir


