Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C3CD262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viZ6Y-0006p9-8f; Wed, 21 Jan 2026 09:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1viZ6T-0006jb-4N; Wed, 21 Jan 2026 09:22:37 -0500
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1viZ6Q-0004dT-SE; Wed, 21 Jan 2026 09:22:36 -0500
Received: from [IPV6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57] (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 80F961520E01;
 Wed, 21 Jan 2026 15:22:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1769005348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcFahGtTrSSofhgqL/xqxKFTUvTWOg8hcCMYycVIGTA=;
 b=iqaAr5utpqQtiBR7oABM/p751C80VNfpauOC5TNxJEFSm1BkFPNOFiDKws1d0MK3Fledok
 0Qhdzgv1dqtrg/3lzSLI08bQFYVVudSgG1+KKudXMdrBlEJO6T4Jqnpfl9Gw28Xu1pQdma
 Hpm7VqicgpeMAmf9RDsC0RDBwLmXINfyzpwOqiimZw5EeCCGfExg/Gv5Ddwxu9HgdFRrO4
 4rA3ldFcun5T94WIbUm/8HXMg7HjB9KC5EkGVI/pNDpLE67VW/OE/ZoEgJM5VoEl4Dk7rD
 rGMy4pDx18PV8x+CopRaZH1RJjnHfer/FCdBAA1ncTMSGVkR9cgj5JWv1zBpVA==
Message-ID: <c2f9fc69-034b-4dc3-a92f-d43e13a5dfed@dupond.be>
Date: Wed, 21 Jan 2026 15:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
To: Polina Vishneva <polina.vishneva@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Den Lunev <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260120171226.1042260-1-polina.vishneva@virtuozzo.com>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20260120171226.1042260-1-polina.vishneva@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Would this also solve https://gitlab.com/qemu-project/qemu/-/issues/2909 
perhaps?

On 20/01/2026 18:20, Polina Vishneva wrote:
> Marking the bitmaps that are found in_use in the image as inconsistent
> works in the most cases. However, in some cases, like migration,
> it's critical for bdrv_dirty_bitmap_check() to always pass.
>
> Instead of asking the user to manually request the deletion of
> inconsistent bitmaps, delete them automatically if we can,
> while respecting the possible edge cases like repairing an image with
> overlaps.
>
> Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> ---
>   block/qcow2-bitmap.c                          | 111 ++++++++++++++++--
>   block/qcow2.c                                 |   9 ++
>   block/qcow2.h                                 |   2 +
>   tests/qemu-iotests/tests/migrate-bitmaps-test |   2 +
>   tests/qemu-iotests/tests/qemu-img-bitmaps     |   2 +-
>   tests/qemu-iotests/tests/qemu-img-bitmaps.out |  36 +++---
>   .../qemu-iotests/tests/qemu-img-close-errors  |   3 +-
>   7 files changed, 132 insertions(+), 33 deletions(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 256ec99878..6ab857ad1a 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1008,6 +1052,32 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,
>               continue;
>           }
>   
> +        if ((bm->flags & BME_FLAG_IN_USE) && can_write(bs) &&
> +            !(s->flags & BDRV_O_CHECK))
> +        {
> +            /*
> +             * Remove inconsistent bitmaps.
> +             * This is to avoid errors on migrations, when
> +             * whenbdrv_dirty_bitmap_check() could be called on a bitmap
Small typo here btw :)
> +             * marked as inconsistent, causing an error and requiring the user
> +             * to manually request inconsistent bitmap deletion.
> +             *
> +             * In case we have a corrupted image, there's no guarantee that
> +             * update_ext_header_and_dir() will succeed.
> +             * This would render some images impossible to repair.
> +             * Therefore, skip it on the image open if we're in the check mode
> +             * (and do it later when the image is successfully repaired).
> +             */
> +            qemu_log("Removing inconsistent bitmap '%s' at image '%s'\n",
> +                     bm->name, bs->filename);
> +
> +            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> +            free_bitmap_clusters(bs, &bm->table);
> +            bitmap_free(bm);
> +            removed_persistent_bitmaps = true;
> +            continue;
> +        }
> +
>           bitmap = load_bitmap(bs, bm, errp);
>           if (bitmap == NULL) {
>               goto fail;


Thanks
Jean-Louis


