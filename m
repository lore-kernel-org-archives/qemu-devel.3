Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5EACE8349
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svH85-0000gb-Je; Mon, 30 Sep 2024 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svH82-0000ey-1P; Mon, 30 Sep 2024 10:11:58 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svH7z-0006Iw-6K; Mon, 30 Sep 2024 10:11:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D5C12609E0;
 Mon, 30 Sep 2024 17:11:50 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b737::1:2c] (unknown
 [2a02:6b8:b081:b737::1:2c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oBawpX1Ii0U0-1GbtuAu6; Mon, 30 Sep 2024 17:11:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727705510;
 bh=grigxbU1QBo6MhuSo1QcaUCrxZeJIqpjPjZLv6n/WTY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QFapRQTWU0POozPoD7spFXAiJ5cZEOGZkBT4Je0wYmKaTPiy6CNt3nl0AOaOWUU/C
 NyxSCBJ5qZzn/EFNODP0fHCTftkP+sUpWd9Dz9sGuUlRbfTQvQp4pqCoXwWS5UymZE
 off3GpnnWP1uwujgJrEQZpVuKeO4bCfPZpXrVeiM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <809af64e-1f5b-4604-a3d3-47ff0b45c2bf@yandex-team.ru>
Date: Mon, 30 Sep 2024 17:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] block: refactor error handling of commit_iteration
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
 <20240901142405.3183874-4-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240901142405.3183874-4-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>   block/commit.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 9eedd1fa47..288e413be3 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -130,7 +130,6 @@ static void commit_clean(Job *job)
>   
>   static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void *buf) {
>       int ret = 0;
> -    bool copy;
>       bool error_in_source = true;
>   
>       /* Copy if allocated above the base */
> @@ -140,19 +139,34 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void
>               n, NULL, NULL, NULL);
>       }
>   
> -    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
> +    if (ret < 0) {
> +        goto handle_error;
> +    }
> +
>       trace_commit_one_iteration(s, offset, *n, ret);

this way we loose trace point for error case. Let's move trace_... above "if (ret.."

> -    if (copy) {
> +
> +    if (ret & BDRV_BLOCK_ALLOCATED) {
>           assert(*n < SIZE_MAX);
>   
>           ret = blk_co_pread(s->top, offset, *n, buf, 0);
> -        if (ret >= 0) {
> -            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
> -            if (ret < 0) {
> -                error_in_source = false;
> -            }
> +        if (ret < 0) {
> +            goto handle_error;
>           }
> +
> +        ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
> +        if (ret < 0) {
> +            error_in_source = false;
> +            goto handle_error;
> +        }
> +
> +        block_job_ratelimit_processed_bytes(&s->common, *n);
>       }
> +
> +    /* Publish progress */
> +
> +    job_progress_update(&s->common.job, *n);
> +

it looks a bit strange to fallthrough to "handle_error" from success path


I suggest:

@@ -166,17 +166,17 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void
  
      job_progress_update(&s->common.job, *n);
  
-handle_error:
-    if (ret < 0) {
-        BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
-                                                         error_in_source, -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT) {
-            return ret;
-        } else {
-            *n = 0;
-        }
+    return 0;
+
+fail:
+    BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
+                                                     error_in_source, -ret);
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return ret;
      }
  
+    /* Retry iteration */
+    *n = 0;
      return 0;
  }



(also, "fail" name is more popular for such labels:
$ git grep 'goto fail' | wc -l
1334
)



> +handle_error:
>       if (ret < 0) {
>           BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
>                                                            error_in_source, -ret);
> @@ -160,15 +174,8 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void
>               return ret;
>           } else {
>               *n = 0;
> -            return 0;
>           }
>       }
> -    /* Publish progress */
> -    job_progress_update(&s->common.job, *n);
> -
> -    if (copy) {
> -        block_job_ratelimit_processed_bytes(&s->common, *n);
> -    }
>   
>       return 0;
>   }

-- 
Best regards,
Vladimir


