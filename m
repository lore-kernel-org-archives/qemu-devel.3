Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C7C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9ZB-0005TG-JC; Tue, 25 Jun 2024 13:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM9Ys-0005GM-A1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:02:30 -0400
Received: from [2a02:6b8:c02:900:1:45:d181:df01]
 (helo=forwardcorp1b.mail.yandex.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM9Xw-00012O-Nj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:02:19 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2CFEB612FB;
 Tue, 25 Jun 2024 19:25:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sPSGgM0Jl0U0-mJJGHr1V; Tue, 25 Jun 2024 19:25:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719332755;
 bh=li+cZYmgJ7PZeUEdtT5wAtSWqw8w4x3xciVw707E2Sg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=L0EV9KT5eJZnqMcw2XnEd+XfOz87DzY35x2bTVMPu/YKbSBIOD/E2vxRN4BXRCZXD
 cPXkpi6IYOoQ1xZWjyVt0tTU47j2cxqJjC6mAgQAYv6csTK1SFvf8xP30PMm/tQHMw
 uWIdXqewQaVUtQMpIcgC7bAZMhYOC9W7y7ZfqXoo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <89b7276c-97d6-498a-8676-e076238937e7@yandex-team.ru>
Date: Tue, 25 Jun 2024 19:25:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: allow commit to unmap zero blocks
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240526192918.3503128-1-libvirt-e6954efa@volkihar.be>
 <20240526192918.3503128-2-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240526192918.3503128-2-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for
 2a02:6b8:c02:900:1:45:d181:df01 (deferred)
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 26.05.24 22:29, Vincent Vanlaer wrote:
> Non-active block commits do not discard blocks only containing zeros,
> causing images to lose sparseness after the commit. This commit fixes
> that by writing zero blocks using blk_co_pwrite_zeroes rather than
> writing them out as any oother arbitrary data.

Hi Vincent! Sorry for long delay.

Could you please split the commit into simpler parts?

Something like this:

1. refactor to use direct bdrv_co_common_block_status_above()

2. refactor to use CommitMethod (with two possible modes)

3. add new mode

(The idea is to split parts of no-logic-change refactoring from real logic changes and keep the latter smaller and clearer)

> 
> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
> ---
>   block/commit.c | 71 +++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 7c3fdcb0ca..5bd97b5a74 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -12,9 +12,13 @@
>    *
>    */
>   
> +#include "bits/time.h"
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
> +#include "time.h"
>   #include "trace.h"
> +#include "block/block-common.h"
> +#include "block/coroutines.h"
>   #include "block/block_int.h"
>   #include "block/blockjob_int.h"
>   #include "qapi/error.h"
> @@ -126,6 +130,12 @@ static void commit_clean(Job *job)
>       blk_unref(s->top);
>   }
>   
> +typedef enum CommitMethod {
> +    COMMIT_METHOD_COPY,
> +    COMMIT_METHOD_ZERO,
> +    COMMIT_METHOD_IGNORE,
> +} CommitMethod;
> +
>   static int coroutine_fn commit_run(Job *job, Error **errp)
>   {
>       CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> @@ -156,8 +166,9 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>       buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
>   
>       for (offset = 0; offset < len; offset += n) {
> -        bool copy;
>           bool error_in_source = true;
> +        CommitMethod commit_method = COMMIT_METHOD_COPY;
> +
>   
>           /* Note that even when no rate limit is applied we need to yield
>            * with no pending I/O here so that bdrv_drain_all() returns.
> @@ -167,21 +178,54 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>               break;
>           }
>           /* Copy if allocated above the base */
> -        ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
> -                                        offset, COMMIT_BUFFER_SIZE, &n);
> -        copy = (ret > 0);
> +        WITH_GRAPH_RDLOCK_GUARD() {
> +            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
> +                s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
> +                &n, NULL, NULL, NULL);
> +        }
> +
>           trace_commit_one_iteration(s, offset, n, ret);
> -        if (copy) {
> -            assert(n < SIZE_MAX);
> -
> -            ret = blk_co_pread(s->top, offset, n, buf, 0);
> -            if (ret >= 0) {
> -                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
> -                if (ret < 0) {
> -                    error_in_source = false;
> +
> +        if (ret >= 0 && !(ret & BDRV_BLOCK_ALLOCATED)) {
> +            commit_method = COMMIT_METHOD_IGNORE;
> +        } else if (ret >= 0 && ret & BDRV_BLOCK_ZERO) {
> +            int64_t target_offset;
> +            int64_t target_bytes;
> +            WITH_GRAPH_RDLOCK_GUARD() {
> +                bdrv_round_to_subclusters(s->base_bs, offset, n,
> +                                       &target_offset, &target_bytes);
> +            }
> +
> +            if (target_offset == offset &&
> +                target_bytes == n) {
> +                commit_method = COMMIT_METHOD_ZERO;
> +            }
> +        }
> +
> +        if (ret >= 0) {
> +            switch (commit_method) {
> +            case COMMIT_METHOD_COPY:
> +                assert(n < SIZE_MAX);
> +                ret = blk_co_pread(s->top, offset, n, buf, 0);
> +                if (ret >= 0) {
> +                    ret = blk_co_pwrite(s->base, offset, n, buf, 0);
> +                    if (ret < 0) {
> +                        error_in_source = false;
> +                    }
>                   }
> +                break;
> +            case COMMIT_METHOD_ZERO:
> +                ret = blk_co_pwrite_zeroes(s->base, offset, n,
> +                    BDRV_REQ_MAY_UNMAP);
> +                error_in_source = false;
> +                break;
> +            case COMMIT_METHOD_IGNORE:
> +                break;
> +            default:
> +                abort();
>               }
>           }
> +
>           if (ret < 0) {
>               BlockErrorAction action =
>                   block_job_error_action(&s->common, s->on_error,
> @@ -193,10 +237,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>                   continue;
>               }
>           }
> +
>           /* Publish progress */
>           job_progress_update(&s->common.job, n);
>   
> -        if (copy) {
> +        if (commit_method == COMMIT_METHOD_COPY) {
>               block_job_ratelimit_processed_bytes(&s->common, n);
>           }
>       }

-- 
Best regards,
Vladimir


