Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93809C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCl9-0000AP-Ha; Wed, 12 Feb 2025 08:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCl2-00009j-DH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCky-0005I9-Eh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739366781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1m3Q+HQ0CD8IK9x7eSq+XJkdp1Xh4xTCDhV4DHCa8w=;
 b=C0WHye4ioU3Apc8Ro67hU6z3keuzfaxbYxdg6BoftAtHFvMGqmfdwsfWTUHo23Nb+p1oyM
 UxrJZKU2ogBXAJ8I1htBTmqGoF8fhT0mZSew0d1X3s+Op0BBTHMSMESZcQRmtgB5I5A2Gn
 KqxGXMzC2+CaWV1PWPRQ4RaoDLUcJfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-hczH4I9iOaadT5Caceoe6A-1; Wed,
 12 Feb 2025 08:26:18 -0500
X-MC-Unique: hczH4I9iOaadT5Caceoe6A-1
X-Mimecast-MFC-AGG-ID: hczH4I9iOaadT5Caceoe6A_1739366777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BE551800875; Wed, 12 Feb 2025 13:26:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77884195608D; Wed, 12 Feb 2025 13:26:14 +0000 (UTC)
Date: Wed, 12 Feb 2025 14:26:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@kamp.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] block/rbd: Do not use BDS's AioContext
Message-ID: <Z6yhczeIJ1XIej3M@redhat.com>
References: <20250212093238.32312-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212093238.32312-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.02.2025 um 10:32 hat Hanna Czenczek geschrieben:
> RBD schedules the request completion code (qemu_rbd_finish_bh()) to run
> in the BDS's AioContext.  The intent seems to be to run it in the same
> context that the original request coroutine ran in, i.e. the thread on
> whose stack the RBDTask object exists (see qemu_rbd_start_co()).
> 
> However, with multiqueue, that thread is not necessarily the same as the
> BDS's AioContext.  Instead, we need to remember the actual AioContext
> and schedule the completion BH there.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-67115

Please add a short summary of what actually happens to the commit
message. I had to check the link to remember what the symptoms are.

> Reported-by: Junyao Zhao <junzhao@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
> I think I could also drop RBDTask.ctx and just use
> `qemu_coroutine_get_aio_context(RBDTask.co)` instead, but this is the
> version of the patch that was tested and confirmed to fix the issue (I
> don't have a local reproducer), so I thought I'll post this first.

Did  you figure out why it even makes a difference in which thread
qemu_rbd_finish_bh() runs? For context:

    static void qemu_rbd_finish_bh(void *opaque)
    {
        RBDTask *task = opaque;
        task->complete = true;
        aio_co_wake(task->co);
    }

This looks as if it should be working in any thread, except maybe for a
missing barrier after updating task->complete - but I think the failure
mode for that would be a hang in qemu_rbd_start_co().

>  block/rbd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index af984fb7db..9d4e0817e0 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -102,7 +102,7 @@ typedef struct BDRVRBDState {
>  } BDRVRBDState;
>  
>  typedef struct RBDTask {
> -    BlockDriverState *bs;
> +    AioContext *ctx;
>      Coroutine *co;
>      bool complete;
>      int64_t ret;
> @@ -1269,8 +1269,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
>  {
>      task->ret = rbd_aio_get_return_value(c);
>      rbd_aio_release(c);
> -    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
> -                            qemu_rbd_finish_bh, task);
> +    aio_bh_schedule_oneshot(task->ctx, qemu_rbd_finish_bh, task);
>  }
>  
>  static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
> @@ -1281,7 +1280,10 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
>                                            RBDAIOCmd cmd)
>  {
>      BDRVRBDState *s = bs->opaque;
> -    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
> +    RBDTask task = {
> +        .ctx = qemu_get_current_aio_context(),
> +        .co = qemu_coroutine_self(),
> +    };
>      rbd_completion_t c;
>      int r;

Nothing wrong I can see about the change, but I don't understand why it
fixes the problem.

Kevin


