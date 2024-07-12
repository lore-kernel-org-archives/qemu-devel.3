Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF4AC3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEsg-0001xl-H2; Fri, 12 Jul 2024 07:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSEsX-0001Tb-RC; Fri, 12 Jul 2024 07:55:58 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSEsT-00039Z-4Z; Fri, 12 Jul 2024 07:55:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8919E6125C;
 Fri, 12 Jul 2024 14:55:44 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hteof71IbmI0-V5M27GYn; Fri, 12 Jul 2024 14:55:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720785344;
 bh=peNtuVVrXnTgWfkpJmvFtHQIeIQSwkH2AMBTs0VKAWc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lk5K3DvB08jquwtsJQ9CoapD6+ybab8+ujmeovbDRevCWy4FmZfQkwChYeKvfR4yI
 omyVoRlUBYZpUE2F/QRvH6brN/sRD5FFBxWkKMsHRc9CpgSA++WTkieXs0ZsMZHcex
 WOpqSBEQq1Bri88AKuvOOHBaE8j6cGc5lMWBkux4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ee1cf8a6-a381-4e30-9f5b-e6fd0a049863@yandex-team.ru>
Date: Fri, 12 Jul 2024 14:55:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: zero data data corruption using
 prealloc-filter
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, eesposit@redhat.com, den@virtuozzo.com
References: <20240712094617.565237-1-andrey.drobyshev@virtuozzo.com>
 <20240712094617.565237-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240712094617.565237-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
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

On 12.07.24 12:46, Andrey Drobyshev wrote:
> From: "Denis V. Lunev" <den@openvz.org>
> 
> We have observed that some clusters in the QCOW2 files are zeroed
> while preallocation filter is used.
> 
> We are able to trace down the following sequence when prealloc-filter
> is used:
>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>      co=0x55e7cbed7680 handle_write()
>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>      co=0x7f9edb7fe500 do_fallocate()
> 
> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
> time to handle next coroutine, which
>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>      co=0x55e7cbee91b0 handle_write()
>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>      co=0x7f9edb7deb00 do_fallocate()
> 
> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
> the same area. This means that if (once fallocate is started inside
> 0x7f9edb7deb00) original fallocate could end and the real write will
> be executed. In that case write() request is handled at the same time
> as fallocate().
> 
> The patch moves s->file_lock assignment before fallocate and that is

text need to be updated

> crucial. The idea is that all subsequent requests into the area
> being preallocation will be issued as just writes without fallocate
> to this area and they will not proceed thanks to overlapping
> requests mechanics. If preallocation will fail, we will just switch
> to the normal expand-by-write behavior and that is not a problem
> except performance.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/preallocate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index d215bc5d6d..ecf0aa4baa 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>   
>       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>   
> +    /*
> +     * Assign file_end before making actual preallocation. This will ensure
> +     * that next request performed while preallocation is in progress will
> +     * be passed without preallocation.
> +     */
> +    s->file_end = prealloc_end;
> +
>       ret = bdrv_co_pwrite_zeroes(
>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>           return false;
>       }
>   
> -    s->file_end = prealloc_end;
>       return want_merge_zero;
>   }
>   


Hmm. But this way we set both s->file_end and s->zero_start prior to actual write_zero operation. This means that next write-zero operation may go fast-path (see preallocate_co_pwrite_zeroes()) and return success, even before actual finish of preallocation write_zeroes operation (which may also fail). Seems we need to update logic around s->zero_start too.

-- 
Best regards,
Vladimir


