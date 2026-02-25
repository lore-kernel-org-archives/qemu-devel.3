Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AFCFD376A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHuJ-0002EI-Fc; Wed, 25 Feb 2026 11:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvHuH-0002Ds-F1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvHu7-0000Ew-UO
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772037505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BeiN0SVh1XH+GRVIutAzYTulX76k8mQ0TIG2fGtKFKc=;
 b=fyxcEOY/CFEkPM1WUZ+WTihRyAYbbQByZ44W/GuVCuC8q3akOOTBovozvxj3/vq/noMDFM
 OSXm+s0oxuV/svpeIiCEMeWDZAb0Fl907YNkXVKMJCignA6nA+NnxQgy9WSPbaGYfnHcbN
 KSa/V8r/rhRewisfyTxNz6BylkAnJwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-ib2FY7p4PkiTGmjyf8TOBA-1; Wed,
 25 Feb 2026 11:38:21 -0500
X-MC-Unique: ib2FY7p4PkiTGmjyf8TOBA-1
X-Mimecast-MFC-AGG-ID: ib2FY7p4PkiTGmjyf8TOBA_1772037500
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDDA819560AF; Wed, 25 Feb 2026 16:38:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.206])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8F0E3003D89; Wed, 25 Feb 2026 16:38:18 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:38:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org
Subject: Re: [PATCH v3] [for-10.1] block-jobs: add final flush
Message-ID: <aZ8leLFRoF4J7s6a@redhat.com>
References: <20250402083715.391059-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402083715.391059-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 02.04.2025 um 10:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Actually block job is not completed without the final flush. It's
> rather unexpected to have broken target when job was successfully
> completed long ago and now we fail to flush or process just
> crashed/killed.
> 
> Mirror job already has mirror_flush() for this. So, it's OK.
> 
> Do this for stream, commit and backup jobs too.
> 
> Note that jobs behave a bit different around IGNORE action:
> backup and commit just retry the operation, when stream skip
> failed operation and store the error to report later. Keep
> these different behaviors for final flush too.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> v2 was old "[PATCH v2 0/3] block-jobs: add final flush"[1]
> v3: follow Kevin's suggestion to introduce block_job_handle_error()
>    (still, it's not obvious how to rewrite commit and stream operation
>    loops reusing this helper, not making things more complicated..
>    I decided too keep them as is, using new helper only for final flush.)
> 
> [1] https://patchew.org/QEMU/20240626145038.458709-1-vsementsov@yandex-team.ru/
> Supersedes: <20240626145038.458709-1-vsementsov@yandex-team.ru>
> 
>  block/backup.c           |  8 ++++++++
>  block/commit.c           |  6 +++++-
>  block/stream.c           |  8 ++++++--
>  blockjob.c               | 34 ++++++++++++++++++++++++++++++++++
>  include/block/blockjob.h |  9 +++++++++
>  5 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 79652bf57b..13fcdaa320 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -221,6 +221,14 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
>      }
>  
>  out:
> +    if (ret == 0) {
> +        do {
> +            WITH_GRAPH_RDLOCK_GUARD() {
> +                ret = bdrv_co_flush(job->target_bs);
> +            }
> +        } while (block_job_handle_error(&job->common, ret, job->on_target_error,
> +                                        true, true));
> +    }

Backup doesn't flush if there was already an error before. This makes
sense to me because then the job won't complete successfully anyway.

is_read=true feels wrong for a flush. (Same in all three jobs.)

retry_on_ignore=true means that this is a potential tight loop that will
keep the process at 100% CPU if the request fails repeatedly. (In
file-posix, flush failing once means that it will keep failing forever.)
I wonder if we shouldn't use retry_on_ignore=false for all end-of-job
flushes because there isn't really a chance to retry successfully later.

>      block_copy_call_free(s);
>      job->bg_bcs_call = NULL;
>      return ret;
> diff --git a/block/commit.c b/block/commit.c
> index 5df3d05346..711093504f 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -201,7 +201,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>          }
>      }
>  
> -    return 0;
> +    do {
> +        ret = blk_co_flush(s->base);
> +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, true));

Why does commit still flush even if we return an error?

> +    return ret;
>  }
>  
>  static const BlockJobDriver commit_job_driver = {
> diff --git a/block/stream.c b/block/stream.c
> index 999d9e56d4..3d374094f5 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -160,6 +160,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>      int64_t offset = 0;
>      int error = 0;
>      int64_t n = 0; /* bytes */
> +    int ret = -1;
>  
>      WITH_GRAPH_RDLOCK_GUARD() {
>          unfiltered_bs = bdrv_skip_filters(s->target_bs);
> @@ -177,7 +178,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>  
>      for ( ; offset < len; offset += n) {
>          bool copy;
> -        int ret = -1;
>  
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.

These two hunks looked suspicious because ret is now set only once
instead of in each loop iteration. However, it doesn't matter, the
initialisation was dead code anyway and the value was never read.

Of course, it is still dead code, and -1 isn't a good return code
anyway (it should be -errno), so maybe remove the initialisation?

> @@ -235,8 +235,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>          }
>      }
>  
> +    do {
> +        ret = blk_co_flush(s->blk);
> +    } while (block_job_handle_error(&s->common, ret, s->on_error, true, false));

Same here about flushing even on error.

> +
>      /* Do not remove the backing file if an error was there but ignored. */
> -    return error;
> +    return error ?: ret;
>  }
>  
>  static const BlockJobDriver stream_job_driver = {
> diff --git a/blockjob.c b/blockjob.c
> index 32007f31a9..70a7af2077 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -626,3 +626,37 @@ AioContext *block_job_get_aio_context(BlockJob *job)
>      GLOBAL_STATE_CODE();
>      return job->job.aio_context;
>  }
> +
> +bool coroutine_fn
> +block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
> +                       bool is_read, bool retry_on_ignore)
> +{
> +    assert(ret >= 0);
> +
> +    if (ret == 0) {
> +        return false;
> +    }
> +
> +    if (job_is_cancelled(&job->job)) {
> +        return false;
> +    }
> +
> +    BlockErrorAction action =
> +        block_job_error_action(job, on_err, is_read, -ret);
> +    switch (action) {
> +    case BLOCK_ERROR_ACTION_REPORT:
> +        return false;
> +    case BLOCK_ERROR_ACTION_IGNORE:
> +        if (!retry_on_ignore) {
> +            return false;
> +        }
> +        /* fallthrough */

What is the idea behind having a pause point for "ignore"? Is it to at
least avoid QEMU hanging completely if it goes into an infinite loop
with retry_on_ignore?

> +    case BLOCK_ERROR_ACTION_STOP:
> +        job_pause_point(&job->job);
> +        break;
> +    default:
> +        abort();
> +    }
> +
> +    return true;
> +}
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 7061ab7201..8362143ed7 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -235,4 +235,13 @@ bool block_job_is_internal(BlockJob *job);
>   */
>  const BlockJobDriver *block_job_driver(BlockJob *job);
>  
> +/**
> + * block_job_handle_error:
> + *
> + * Return, wherter the operation should be retried.

s/wherter/whether/

> + */
> +bool coroutine_fn
> +block_job_handle_error(BlockJob *job, int ret, BlockdevOnError on_err,
> +                       bool is_read, bool retry_on_ignore);
> +
>  #endif

Kevin


