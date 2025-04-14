Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6D6C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NFh-0007Xx-P9; Mon, 14 Apr 2025 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4NFW-0007VD-Ge; Mon, 14 Apr 2025 13:05:35 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4NFQ-0002h9-4K; Mon, 14 Apr 2025 13:05:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ca1:0:640:740c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2AABD60D96;
 Mon, 14 Apr 2025 20:05:22 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4ae::1:27] (unknown
 [2a02:6b8:b081:b4ae::1:27])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id L5K85P0FV0U0-v1KBa4Fk; Mon, 14 Apr 2025 20:05:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744650321;
 bh=aZ9tTSafv+sEEGOGfR4aRBkcHAZIXhNwLNDFeAvqrPY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=d6Uh1ggaHDCulE09MDXHOK9P8wKCrMKYZA5VXDnr1Y9x+qX9T0iHl8ttRvsh/O0cl
 CIvi+M5VWsze6JiN5Xl6stzr8+717fWMkbuGKxr9XIxUTk0q7pu1G7xPxVn/559aNV
 OTx2Vzy1VdIKrMkEL0VBehLoPtOTUEAc7Mbt+eZE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2d17f631-40b0-40bc-a4ba-0b507cd39c71@yandex-team.ru>
Date: Mon, 14 Apr 2025 20:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] file-posix: Allow lseek at offset 0 when !want_zero
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:raw" <qemu-block@nongnu.org>, "Denis V. Lunev" <den@openvz.org>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-10-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250411010732.358817-10-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 11.04.25 04:04, Eric Blake wrote:
> The 'want_zero' parameter to raw_co_block_status() was added so that
> we can avoid potentially time-consuming lseek(SEEK_DATA) calls
> throughout the file (working around poor filesystems that have O(n)
> rather than O(1) extent probing).  But when it comes to learning if a
> file is completely sparse (for example, it was just created), always
> claiming that a file is all data without even checking offset 0 breaks
> what would otherwise be attempts at useful optimizations for a
> known-zero mirror destination.
> 
> Note that this allows file-posix to report a file as completely zero
> if it was externally created (such as via 'truncate --size=$n file')
> as entirely sparse; however, it does NOT work for files created
> internally by blockdev-create.  That's because blockdev-create
> intentionally does a sequence of truncate(0), truncate(size),
> allocate_first_block(), in order to make it possible for gluster on
> XFS to probe the sector size for direct I/O (which doesn't work if the
> first block is sparse).  That will be addressed in a later patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/file-posix.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d156..67e83528cf5 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3217,7 +3217,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>           return ret;
>       }
> 
> -    if (!want_zero) {
> +    /*
> +     * If want_zero is clear, then the caller wants speed over
> +     * accuracy, and the only place where SEEK_DATA should be
> +     * attempted is at the start of the file to learn if the file has
> +     * any data at all (anywhere else, just blindly claim the entire
> +     * file is data).
> +     */
> +    if (!want_zero && offset) {
>           *pnum = bytes;
>           *map = offset;
>           *file = bs;

Looks like a hack. So we have bdrv_co_is_zero_fast() which do pass want_zero=false to block-status. But in case of mirror, which want to check the whole disk, we actually want want_zero=true, and detect it by offset=0..

Isn't it better to add a kind of bdrv_is_zero_middle_speed() (which means, don't try to read the data to check, but be free to use suboptimal lseek call or something like this), which will pass want_zero=true, and use it from mirror? Mirror case differs from usage in qcow2 exactly by the fact that we call it only once.


Another doubt (really weak): can this one extra lseek be so slow, that mirror becomes worse?
Den, is it right, that problems about slow lseek (that we experienced several years ago) were about qcow2-internals, and nothing related to mirror itself? May one lseek call on mirror target break something?


-- 
Best regards,
Vladimir


