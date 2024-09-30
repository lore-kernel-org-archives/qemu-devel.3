Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641BCE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGsG-0001K8-SQ; Mon, 30 Sep 2024 09:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svGs2-0001H5-A3; Mon, 30 Sep 2024 09:55:27 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svGry-0004jg-BN; Mon, 30 Sep 2024 09:55:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8568160A69;
 Mon, 30 Sep 2024 16:55:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b737::1:2c] (unknown
 [2a02:6b8:b081:b737::1:2c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FtZGrB13OGk0-5tQoVUfc; Mon, 30 Sep 2024 16:55:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727704516;
 bh=VwVlU+04fB5D2K3LmVcTt2nkPRsRe7vq5ILG6Ccvt2s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UvfzJbXGG3Rua3Qg042nidvvW2GhLTKySWgavBINtNF4NqCuPqFo/7UnSpJaNazGB
 qwjf6c0/HY/df4+JP6lY/N+yxHzlXVt2hAJDOLCF49n/NqqOggqgl+5DOdzm5FEK5u
 2S05cymrieUi1eTOzQsDaOx97h70aL9LAT1TI8Dg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b041b1e3-6f66-4a2e-b7dd-07e97ebd7ca8@yandex-team.ru>
Date: Mon, 30 Sep 2024 16:55:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] block: move commit_run loop to separate function
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
 <20240901142405.3183874-3-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240901142405.3183874-3-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

On 01.09.24 17:24, Vincent Vanlaer wrote:
> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
> ---
>   block/commit.c | 85 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 8dee25b313..9eedd1fa47 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -128,6 +128,51 @@ static void commit_clean(Job *job)
>       blk_unref(s->top);
>   }
>   
> +static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void *buf) {
> +    int ret = 0;
> +    bool copy;
> +    bool error_in_source = true;
> +
> +    /* Copy if allocated above the base */
> +    WITH_GRAPH_RDLOCK_GUARD() {
> +        ret = bdrv_co_common_block_status_above(blk_bs(s->top),
> +            s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
> +            n, NULL, NULL, NULL);
> +    }
> +
> +    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
> +    trace_commit_one_iteration(s, offset, *n, ret);
> +    if (copy) {
> +        assert(*n < SIZE_MAX);

Probably a matter of taste, but I'd prefer working with local variable instead of dereferencing the pointer on every line.
Like this:

commit_iteration(..., int64_t bytes, int64_t *done, ...) {

... work with bytes variable ...

out:
   *done = bytes;
   return 0;
}


anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +
> +        ret = blk_co_pread(s->top, offset, *n, buf, 0);
> +        if (ret >= 0) {
> +            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
> +            if (ret < 0) {
> +                error_in_source = false;
> +            }
> +        }
> +    }
> +    if (ret < 0) {
> +        BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
> +                                                         error_in_source, -ret);
> +        if (action == BLOCK_ERROR_ACTION_REPORT) {
> +            return ret;
> +        } else {
> +            *n = 0;
> +            return 0;
> +        }
> +    }
> +    /* Publish progress */
> +    job_progress_update(&s->common.job, *n);
> +
> +    if (copy) {
> +        block_job_ratelimit_processed_bytes(&s->common, *n);
> +    }
> +
> +    return 0;
> +}
> +
>   static int coroutine_fn commit_run(Job *job, Error **errp)
>   {
>       CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> @@ -158,9 +203,6 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>       buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
>   
>       for (offset = 0; offset < len; offset += n) {
> -        bool copy;
> -        bool error_in_source = true;
> -
>           /* Note that even when no rate limit is applied we need to yield
>            * with no pending I/O here so that bdrv_drain_all() returns.
>            */
> @@ -168,42 +210,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>           if (job_is_cancelled(&s->common.job)) {
>               break;
>           }
> -        /* Copy if allocated above the base */
> -        WITH_GRAPH_RDLOCK_GUARD() {
> -            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
> -                s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
> -                &n, NULL, NULL, NULL);
> -        }
>   
> -        copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
> -        trace_commit_one_iteration(s, offset, n, ret);
> -        if (copy) {
> -            assert(n < SIZE_MAX);
> -
> -            ret = blk_co_pread(s->top, offset, n, buf, 0);
> -            if (ret >= 0) {
> -                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
> -                if (ret < 0) {
> -                    error_in_source = false;
> -                }
> -            }
> -        }
> -        if (ret < 0) {
> -            BlockErrorAction action =
> -                block_job_error_action(&s->common, s->on_error,
> -                                       error_in_source, -ret);
> -            if (action == BLOCK_ERROR_ACTION_REPORT) {
> -                return ret;
> -            } else {
> -                n = 0;
> -                continue;
> -            }
> -        }
> -        /* Publish progress */
> -        job_progress_update(&s->common.job, n);
> +        ret = commit_iteration(s, offset, &n, buf);
>   
> -        if (copy) {
> -            block_job_ratelimit_processed_bytes(&s->common, n);
> +        if (ret < 0) {
> +            return ret;
>           }
>       }
>   

-- 
Best regards,
Vladimir


