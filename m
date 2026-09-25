Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D97C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA7YM-0000H5-JA; Fri, 25 Sep 2026 11:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xA7YK-0000GO-JR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xA7YI-0001Mg-J3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790348969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kZ3KiyS6g3PynDQfawPhQdd55pp7R8FUVSyiOB2Rck=;
 b=KOT/9OlLeBSim1kHidC7JW0Xfktqv8yFYgoVjJ1ma8iDsVY7Mf8Sze2ZsXL15H4KHd3m+v
 ckiNzE8aQnGsyeiT3ifAIAGtAmu9oK89X9hJbA5WS+nF0hU1WK6x+ZPLAK6EcX21710qvM
 SqRhqK+uW4n+4bIBl9DEWYt6YwNYw7g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-9vqtT9BqM5ee3c21knB0-Q-1; Fri,
 25 Sep 2026 11:09:27 -0400
X-MC-Unique: 9vqtT9BqM5ee3c21knB0-Q-1
X-Mimecast-MFC-AGG-ID: 9vqtT9BqM5ee3c21knB0-Q_1790348966
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA575194A21C; Fri, 25 Sep 2026 15:09:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.175])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE12518004D4; Fri, 25 Sep 2026 15:09:07 +0000 (UTC)
Date: Fri, 25 Sep 2026 17:09:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Jorge Merlino <jorge.merlino@canonical.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block: add debug when block operations finish
Message-ID: <araOkUxn0agKKJrJ@redhat.com>
References: <20260909-debug-block-ops-b4-v1-1-2405f34ec068@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-debug-block-ops-b4-v1-1-2405f34ec068@canonical.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 09.09.2026 um 21:56 hat Jorge Merlino geschrieben:
> Add new debug tracepoints when block read and write operations finish to
> be able to measure latency.
> 
> Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>

The subject line should mention trace points. Maybe just "block: Add
tracepoiont at end of read/write"?

> This patch adds debug tracepoints when block read and write operations
> finish. The log includes the parameters used when the operation was
> initiated so that the start and finish messages can be easily
> correlated. Also the return value of the operation is logged.
> 
> This can be used to analyze latency issues with block operations.

Yes, this seems useful.

I wonder if we shouldn't make sure that the start and end traces always
come in pairs. Specifically...

>  block/block-backend.c | 2 ++
>  block/trace-events    | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc4..75d3cd1949 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1364,6 +1364,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,

Adding more context here:

    trace_blk_co_preadv(blk, bs, offset, bytes, flags);

    ret = blk_check_byte_request(blk, offset, bytes);
    if (ret < 0) {
        return ret;
    }

Should this error return also call trace_blk_co_preadv_done()?

    bdrv_inc_in_flight(bs);

    /* throttling disk I/O */
    if (qatomic_load_acquire(&tgm->throttle_state)) {
        throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_READ);
    }

>  
>      ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
>                                flags);
> +    trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
>      bdrv_dec_in_flight(bs);
>      return ret;
>  }
> @@ -1442,6 +1443,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
>  
>      ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
>                                 flags);
> +    trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
>      bdrv_dec_in_flight(bs);
>      return ret;
>  }

Same question for writes.

Kevin


