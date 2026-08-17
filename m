Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F774C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvy9x-0007U7-Qj; Mon, 17 Aug 2026 10:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvy9u-0007Ta-3c; Mon, 17 Aug 2026 10:17:51 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wvy9s-0001Tm-5O; Mon, 17 Aug 2026 10:17:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:118b:0:640:b49:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0F1D080B96;
 Mon, 17 Aug 2026 17:17:43 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d2f::1:33] (unknown
 [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id gHVxqc0eHKo0-zqFG4e8t; Mon, 17 Aug 2026 17:17:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786976262;
 bh=CDL/LvC82Ai7I2B4R2rgyfCXHObcOcI6qHq6agM9LHE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WDWMWJ3Xr6jS46T3ipt+MUDrRri+Ihm96wsOcIMrXPXRnNBxCGzAwQ3g0/7VZcRZq
 qiFCVizuTTsvAs3FYjH93RHjyCYgfApw9DZ1vGkAKRsBQM5Acq5MBYGZ4As6R1T72N
 vk3sHBedFS1p/D/uMqOjzKFP+yDLZmD6LzeZhQus=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <183c3455-caf3-4132-a99d-ce6d6c7585dc@yandex-team.ru>
Date: Mon, 17 Aug 2026 17:17:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dirty-bitmap: fix integer overflow in serialization
 coverage
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260811173857.396571-1-den@openvz.org>
 <20260811173857.396571-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260811173857.396571-4-den@openvz.org>
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

On 11.08.26 20:38, Denis V. Lunev wrote:
> The chunk size is an int and is shifted left by 3 before the result is
> widened, so a chunk size of 1 << 28 or above overflows.
> 
> parallels passes s->cluster_size, which parallels_open() lets reach
> 2 GiB. With a bitmap needing two L1 entries the bogus limit makes the
> "bm_size - offset" in parallels_load_bitmap_data() underflow; both
> wrong values slip past the assertions in serialization_chunk() and the
> resulting index lands outside the hbitmap, so a 128 KiB image memsets
> unrelated memory through hbitmap_deserialize_ones().
> 
> Widen the shift. qcow2, the only other caller, never exceeds a 2 MiB
> cluster.
> 
> Fixes: 35f428ba3971 ("qcow2-bitmap: make bytes_covered_by_bitmap_cluster() public")
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/dirty-bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 13a1979755..9fda3a4b98 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -612,7 +612,7 @@ uint64_t bdrv_dirty_bitmap_serialization_coverage(int serialized_chunk_size,
>                                                     const BdrvDirtyBitmap *bitmap)
>   {
>       uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
> -    uint64_t limit = granularity * (serialized_chunk_size << 3);
> +    uint64_t limit = granularity * ((uint64_t)serialized_chunk_size << 3);
>   
>       assert(QEMU_IS_ALIGNED(limit,
>                              bdrv_dirty_bitmap_serialization_align(bitmap)));


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I think, it's good to pick this one for my next pull request with another
bitmap-related fixes.

Thanks, applied to my block branch (this one 3/8 patch).


-- 
Best regards,
Vladimir

