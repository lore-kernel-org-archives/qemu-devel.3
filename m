Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 04:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLxrX-0002xX-P7; Tue, 25 Jun 2024 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLxrV-0002wx-PI; Tue, 25 Jun 2024 00:32:57 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLxrR-0003VN-Sn; Tue, 25 Jun 2024 00:32:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C3BCF61379;
 Tue, 25 Jun 2024 07:32:47 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5bf::1:d] (unknown
 [2a02:6b8:b081:b5bf::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jWGcYI0Ih0U0-tLdBbkNi; Tue, 25 Jun 2024 07:32:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719289966;
 bh=hb6iVfMwjHpxM/NPC8d4hURXS9rYNtsSE13sI5ITKZY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SjCVqTMwx+lcqCaW2VUem9PdKg9mWrp7dRu8QKhuzI/sE89XWQQimFKG4qwREla+a
 7EZfE+yed+dsrFWAI+aDXhFaTN6GhVvGHPQp0vyRsd6WRGnvIDE/WTHl5uhgerZbql
 Ud867w3GFusC1t7DngONHHQJ/X95Qs+vbs7oJrsA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae83e414-6a60-4431-885c-d67eabf0494d@yandex-team.ru>
Date: Tue, 25 Jun 2024 07:32:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] mirror: allow specifying working bitmap
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240521122014.333221-1-f.ebner@proxmox.com>
 <20240521122014.333221-4-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240521122014.333221-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21.05.24 15:20, Fiona Ebner wrote:
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
> When the target image is a non-COW "diff image", i.e. one that was not
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
> document the limitation in QAPI.
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
> [FE: rebase for 9.1
>       get rid of bitmap mode parameter
>       use caller-provided bitmap as working bitmap
>       turn bitmap parameter experimental]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/mirror.c                         | 80 +++++++++++++++++++++-----
>   blockdev.c                             | 44 +++++++++++---
>   include/block/block_int-global-state.h |  5 +-
>   qapi/block-core.json                   | 35 ++++++++++-
>   tests/unit/test-block-iothread.c       |  2 +-
>   5 files changed, 141 insertions(+), 25 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index ca23d6ef65..d3d0698116 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
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
>       uint8_t *buf;
> @@ -691,7 +696,11 @@ static int mirror_exit_common(Job *job)
>           bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
>       }
>   
> -    bdrv_release_dirty_bitmap(s->dirty_bitmap);
> +    if (s->dirty_bitmap_is_local) {
> +        bdrv_release_dirty_bitmap(s->dirty_bitmap);
> +    } else {
> +        bdrv_enable_dirty_bitmap(s->dirty_bitmap);
> +    }
>   
>       /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
>        * before we can call bdrv_drained_end */
> @@ -820,6 +829,16 @@ static void mirror_abort(Job *job)
>       assert(ret == 0);
>   }
>   
> +/* Always called after commit/abort. */
> +static void mirror_clean(Job *job)
> +{
> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
> +
> +    if (!s->dirty_bitmap_is_local && s->dirty_bitmap) {
> +        bdrv_dirty_bitmap_set_busy(s->dirty_bitmap, false);
> +    }

why not do that in existing mirror_exit_common, where we already do release/enable?

> +}
> +


-- 
Best regards,
Vladimir


