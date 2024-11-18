Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DB8D43FE5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 07:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCwK9-0001KO-A8; Mon, 18 Nov 2024 02:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwJw-0001Jl-33; Mon, 18 Nov 2024 02:37:16 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwJr-00051j-6Z; Mon, 18 Nov 2024 02:37:15 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4fa4:0:640:dbe3:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5D64560949;
 Mon, 18 Nov 2024 10:37:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:210::1:15] (unknown
 [2a02:6b8:b081:210::1:15])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3bKmsf1Id4Y0-301fv4pH; Mon, 18 Nov 2024 10:37:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731915423;
 bh=xI8kdZMCYH0WXaMzmFdpsLFln6e4aCz4/tMBZOYgD5U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pbbmcusn9cS2KbzaOz9KL8VAoRRajViIX50r/lyX7/mjY1qsnMSMpiPLpyobx89fy
 hctm6Fn9LH9TZ4ZLdOD6QzEKQLUNfymYWR23HGHUU/Y1GlsZupwpJiLWDGLMBaOfgk
 VwH69SKekI1mPy+tZkd/f09zBBJGpFF8iAWQJNVw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <578cf48d-1917-455f-922e-dff99a2416ca@yandex-team.ru>
Date: Mon, 18 Nov 2024 10:37:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] block: refactor error handling of commit_iteration
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
 <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26.10.24 19:30, Vincent Vanlaer wrote:
> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
> ---
>   block/commit.c | 61 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 078e54f51f..5c24c8b80a 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -129,51 +129,58 @@ static void commit_clean(Job *job)
>   }
>   
>   static int commit_iteration(CommitBlockJob *s, int64_t offset,
> -                            int64_t *n, void *buf)
> +                            int64_t *requested_bytes, void *buf)
>   {
> +    int64_t bytes = *requested_bytes;
>       int ret = 0;
> -    bool copy;
>       bool error_in_source = true;
>   
>       /* Copy if allocated above the base */
>       WITH_GRAPH_RDLOCK_GUARD() {
>           ret = bdrv_co_common_block_status_above(blk_bs(s->top),
>               s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
> -            n, NULL, NULL, NULL);
> +            &bytes, NULL, NULL, NULL);
>       }
>   
> -    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
> -    trace_commit_one_iteration(s, offset, *n, ret);
> -    if (copy) {
> -        assert(*n < SIZE_MAX);
> +    trace_commit_one_iteration(s, offset, bytes, ret);
>   
> -        ret = blk_co_pread(s->top, offset, *n, buf, 0);
> -        if (ret >= 0) {
> -            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
> -            if (ret < 0) {
> -                error_in_source = false;
> -            }
> -        }
> -    }
>       if (ret < 0) {
> -        BlockErrorAction action = block_job_error_action(&s->common,
> -                                                         s->on_error,
> -                                                         error_in_source,
> -                                                         -ret);
> -        if (action == BLOCK_ERROR_ACTION_REPORT) {
> -            return ret;
> -        } else {
> -            *n = 0;
> -            return 0;
> +        goto fail;
> +    }
> +
> +    if (ret & BDRV_BLOCK_ALLOCATED) {
> +        assert(bytes < SIZE_MAX);
> +
> +        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
> +        if (ret < 0) {
> +            goto fail;
>           }
> +
> +        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
> +        if (ret < 0) {
> +            error_in_source = false;
> +            goto fail;
> +        }
> +
> +        block_job_ratelimit_processed_bytes(&s->common, bytes);
>       }
> +
>       /* Publish progress */
> -    job_progress_update(&s->common.job, *n);
>   
> -    if (copy) {
> -        block_job_ratelimit_processed_bytes(&s->common, *n);
> +    job_progress_update(&s->common.job, bytes);
> +
> +    *requested_bytes = bytes;
> +
> +    return 0;

With this extra semicolon removed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I'd also add an empty line before "fail:".


> +fail:;
> +    BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
> +                                                     error_in_source, -ret);
> +    if (action == BLOCK_ERROR_ACTION_REPORT) {
> +        return ret;
>       }
>   
> +    *requested_bytes = 0;
> +
>       return 0;
>   }
>   

-- 
Best regards,
Vladimir


