Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4DCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPlH-0001oO-UN; Tue, 16 Jun 2026 05:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wZPlF-0001o0-Lq; Tue, 16 Jun 2026 05:07:10 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wZPlD-0003yH-CY; Tue, 16 Jun 2026 05:07:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C987980C5C;
 Tue, 16 Jun 2026 12:07:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:57b::1:29] (unknown
 [2a02:6bf:8080:57b::1:29])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id w6M1HZ7XC0U0-6S4pGva5; Tue, 16 Jun 2026 12:06:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1781600819;
 bh=9roYk4p38+AIhSaxgiW2KYgdkeNrbeDKQYt5IlMbq5k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LcXjBnNLaYc1D/r4fSa3nkWJWl0ep9eAoQQ1z5ohQxFC4ahD8TXI302vKAhbHxEme
 H+VXx+53JUmE7xnAjvPdsTW5CuTOBrp1nc+30+apI0N8sflurK9zRJ0oiBvyjutfqF
 132odg9bnmteqSpKOu0gRVN/7HonlAiKemC+IkW0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c2a0d86c-5989-40ca-9a7c-265b15e6b1c6@yandex-team.ru>
Date: Tue, 16 Jun 2026 12:06:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: qcow2-bitmap: fix persistent bitmap corruption on
 ENOSPC
To: Christian Barry <christian.barry@usp.br>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
References: <20260610023337.165474-1-christian.barry@usp.br>
Content-Language: ru, en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260610023337.165474-1-christian.barry@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

10.06.26 05:33, Christian Barry пишет:
> From: Christian Barry <christian.barry@usp.br>
> 
> Changed qcow2_co_remove_persistent_dirty_bitmap() to treat free_bitmap_clusters()
> failure as fatal and roll back the header update through a new helper
> function rollback_ext_header_and_dir_helper(), which was also applied
> to update_ext_header_and_dir(), which had internal rollback logic.
> Changed bitmap_list_store() to zero the cluster tail after write,
> guaranteeing that qemu-img won't parse into stale bytes.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3516

Hi!

First, seem like two different fixes merged into one commit, please if
possible, make them separate two commits.

Next, please, make commit messages more descriptive, about what the
issue we solve (link is good as additional information, but the commit
message itself should be complete).

For example, I don't understand free_bitmap_clusters makes the image
unreadable. And we we fix it in one place, leaving other calls to
free_bitmap_clusters() unchanged. Could we fix free_bitmap_clusters()
itself? See also my comments below

> 
> Signed-off-by: Christian Barry <christian.barry@usp.br>
> Co-developed by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> ---
>   block/qcow2-bitmap.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 256ec99878..5796298157 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -737,10 +737,12 @@ static int GRAPH_RDLOCK
>   bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
>                     uint64_t *offset, uint64_t *size, bool in_place)
>   {
> +    BDRVQcow2State *s = bs->opaque;
>       int ret;
>       uint8_t *dir;
>       int64_t dir_offset = 0;
>       uint64_t dir_size = 0;
> +    uint64_t tail_size;
>       Qcow2Bitmap *bm;
>       Qcow2BitmapDirEntry *e;
>   
> @@ -810,6 +812,14 @@ bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
>           goto fail;
>       }
>   
> +    tail_size = ROUND_UP(dir_size, s->cluster_size) - dir_size;
> +    if (tail_size > 0) {
> +        ret = bdrv_pwrite_zeroes(bs->file, dir_offset + dir_size, tail_size, 0);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }

If zeroing of unused bytes help to fix some issue, it obviously means,
that something is wrong in deeper logic.

> +
>       g_free(dir);
>   
>       if (!in_place) {
> @@ -882,6 +892,19 @@ update_ext_header_and_dir_in_place(BlockDriverState *bs,
>        */
>   }
>   
> +static void rollback_ext_header_and_dir_helper(BlockDriverState *bs,
> +					       uint64_t old_offset,
> +					       uint64_t old_size,
> +					       uint32_t old_nb_bitmaps,
> +					       uint64_t old_autocl)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    s->bitmap_directory_offset = old_offset;
> +    s->bitmap_directory_size = old_size;
> +    s->nb_bitmaps = old_nb_bitmaps;
> +    s->autoclear_features = old_autocl;
> +}

I think, better to inline this code, or refactor deeper. This way it only
makes code more complicated: we can't deduplicate first part of logic,
which is defining these 4 variables, but do that for the second part.

> +
>   static int GRAPH_RDLOCK
>   update_ext_header_and_dir(BlockDriverState *bs, Qcow2BitmapList *bm_list)
>   {
> @@ -937,10 +960,7 @@ fail:
>           qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_OTHER);
>       }
>   
> -    s->bitmap_directory_offset = old_offset;
> -    s->bitmap_directory_size = old_size;
> -    s->nb_bitmaps = old_nb_bitmaps;
> -    s->autoclear_features = old_autocl;
> +    rollback_ext_header_and_dir_helper(bs, old_offset, old_size, old_nb_bitmaps, old_autocl);
>   
>       return ret;
>   }
> @@ -1460,6 +1480,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>   {
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
> +    uint64_t old_offset = s->bitmap_directory_offset;
> +    uint64_t old_size = s->bitmap_directory_size;
> +    uint32_t old_nb_bitmaps = s->nb_bitmaps;
> +    uint64_t old_autocl = s->autoclear_features;
>       Qcow2Bitmap *bm = NULL;
>       Qcow2BitmapList *bm_list;
>   
> @@ -1495,7 +1519,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>           goto out;
>       }
>   
> -    free_bitmap_clusters(bs, &bm->table);
> +    ret = free_bitmap_clusters(bs, &bm->table);
> +    if (ret < 0){
> +	rollback_ext_header_and_dir_helper(bs, old_offset, old_size, old_nb_bitmaps, old_autocl);
> +    }

Again, this looks strange too. Ignoring failure of freeing _unused_ clusters
should not be a problem. If it is, it means that things are broken earlier
and something should be fixed at earlier stage.

>   
>   out:
>       qemu_co_mutex_unlock(&s->lock);


---

Let me try to understand the issue at https://gitlab.com/qemu-project/qemu/-/work_items/3516..


1. We failed to flush bitmaps. So, autoclear bit should be unset in the header and the whole bitmap extension considered inconsistent

2. On next qcow2 open, no bitmaps should be loaded, and we'll see message of

                 error_printf("Some clusters may be leaked, "
                              "run 'qemu-img check -r' on the image "
                              "file to fix.");


What's wrong with that?



-- 
Best regards,
Vladimir

