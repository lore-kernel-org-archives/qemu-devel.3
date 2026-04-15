Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C7FF43848
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD2iK-0004L1-Ce; Wed, 15 Apr 2026 12:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wD2iI-0004KW-P4
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wD2iG-0006an-Gi
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776269013;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJs9Xo+XajFHW0euJa6Hz+oJAemFdxaokFDxIbTsAWE=;
 b=P/qeRn/kvs4o1rfZfGOWbAuGPeFKG0Dj1mcMz48rtYl2UFHOhrn2t4pbyvSEtvupvd5MFs
 zugUkfZ0Jis9KTnL8GNWe1KEraRCg4gfzDnONckOk2H1lh+GFh5aDrCEaod0Mo3bSaFF+3
 3vcY0ivsQYH/uwwdyw9B/7CjvzHsaxY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-ke-o9Kf0P3CbVKOdEeXDMA-1; Wed,
 15 Apr 2026 12:03:30 -0400
X-MC-Unique: ke-o9Kf0P3CbVKOdEeXDMA-1
X-Mimecast-MFC-AGG-ID: ke-o9Kf0P3CbVKOdEeXDMA_1776269009
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 666F519560AA
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:03:29 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B1F730001A4; Wed, 15 Apr 2026 16:03:28 +0000 (UTC)
Date: Wed, 15 Apr 2026 17:03:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 46/67] ui/vnc: make the worker thread per-VncDisplay
Message-ID: <ad-2zbZKrCWBrlbb@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-46-231416f76dc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-qemu-vnc-v2-46-231416f76dc3@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 10, 2026 at 11:19:08PM +0400, Marc-André Lureau wrote:
> The VNC encoding worker thread was using a single global queue shared
> across all VNC displays, with no way to stop it. This made it impossible
> to properly clean up resources when a VncDisplay is freed.
> 
> Move the VncJobQueue from a file-scoped global to a per-VncDisplay
> member, so each display owns its worker thread and queue. Add
> vnc_stop_worker_thread() to perform an orderly shutdown: signal the
> thread to exit, join it, and destroy the queue. The thread is now
> created as QEMU_THREAD_JOINABLE instead of QEMU_THREAD_DETACHED.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc-jobs.h |  3 ++-
>  ui/vnc.h      |  2 ++
>  ui/vnc-jobs.c | 76 +++++++++++++++++++++++++++++++++--------------------------
>  ui/vnc.c      |  3 ++-
>  4 files changed, 49 insertions(+), 35 deletions(-)
> 

> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index 5b17ef54091..c809287dd3a 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -29,8 +29,6 @@
>  #include "qemu/osdep.h"
>  #include "vnc.h"
>  #include "vnc-jobs.h"
> -#include "qemu/sockets.h"
> -#include "qemu/main-loop.h"
>  #include "trace.h"
>  
>  /*
> @@ -56,17 +54,10 @@ struct VncJobQueue {
>      QemuCond cond;
>      QemuMutex mutex;
>      QemuThread thread;
> +    bool exit;
>      QTAILQ_HEAD(, VncJob) jobs;
>  };
>  
> -typedef struct VncJobQueue VncJobQueue;
> -
> -/*
> - * We use a single global queue, but most of the functions are
> - * already reentrant, so we can easily add more than one encoding thread
> - */
> -static VncJobQueue *queue;
> -
>  static void vnc_lock_queue(VncJobQueue *queue)
>  {
>      qemu_mutex_lock(&queue->mutex);
> @@ -125,19 +116,22 @@ static void vnc_job_free(VncJob *job)
>   */
>  void vnc_job_push(VncJob *job)
>  {
> +    VncJobQueue *queue = job->vs->vd->queue;
> +
>      assert(!QTAILQ_IN_USE(job, next));
>  
>      if (QLIST_EMPTY(&job->rectangles)) {
>          vnc_job_free(job);
>      } else {
>          vnc_lock_queue(queue);
> +        assert(!queue->exit);
>          QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
>          qemu_cond_broadcast(&queue->cond);
>          vnc_unlock_queue(queue);
>      }
>  }
>  
> -static bool vnc_has_job_locked(VncState *vs)
> +static bool vnc_has_job_locked(VncJobQueue *queue, VncState *vs)
>  {

Instead of passing this I think you could add

   VncJobQueue *queue = vs->vd->queue;

which guarantees the queue object matches the state object
instead of leaving that precondition to the caller.

>      VncJob *job;
>  
> @@ -151,8 +145,10 @@ static bool vnc_has_job_locked(VncState *vs)
>  
>  void vnc_jobs_join(VncState *vs)
>  {
> +    VncJobQueue *queue = vs->vd->queue;
> +
>      vnc_lock_queue(queue);
> -    while (vnc_has_job_locked(vs)) {
> +    while (vnc_has_job_locked(queue, vs)) {
>          qemu_cond_wait(&queue->cond, &queue->mutex);
>      }
>      vnc_unlock_queue(queue);
> @@ -252,9 +248,13 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>      int saved_offset;
>  
>      vnc_lock_queue(queue);
> -    while (QTAILQ_EMPTY(&queue->jobs)) {
> +    while (QTAILQ_EMPTY(&queue->jobs) && !queue->exit) {
>          qemu_cond_wait(&queue->cond, &queue->mutex);
>      }
> +    if (queue->exit) {
> +        vnc_unlock_queue(queue);
> +        return 1;
> +    }
>      job = QTAILQ_FIRST(&queue->jobs);
>      vnc_unlock_queue(queue);
>  
> @@ -340,39 +340,49 @@ disconnected:
>      return 0;
>  }
>  
> -static VncJobQueue *vnc_queue_init(void)
> -{
> -    VncJobQueue *queue = g_new0(VncJobQueue, 1);
> -
> -    qemu_cond_init(&queue->cond);
> -    qemu_mutex_init(&queue->mutex);
> -    QTAILQ_INIT(&queue->jobs);
> -    return queue;
> -}

IMHO it makes sense to keep this object allocator
method and call it from...

> -
>  static void *vnc_worker_thread(void *arg)
>  {
>      VncJobQueue *queue = arg;
>  
>      while (!vnc_worker_thread_loop(queue)) ;
> -    g_assert_not_reached();
> +
>      return NULL;
>  }
>  
> -static bool vnc_worker_thread_running(void)
> +void vnc_start_worker_thread(VncDisplay *vd)
>  {
> -    return queue; /* Check global queue */
> +    VncJobQueue *queue;
> +
> +    assert(vd->queue == NULL);
> +
> +    queue = g_new0(VncJobQueue, 1);
> +    qemu_cond_init(&queue->cond);
> +    qemu_mutex_init(&queue->mutex);
> +    QTAILQ_INIT(&queue->jobs);
> +    vd->queue = queue;

....here

  vd->queue = vnc_queue_init();

though renaming it to vnc_queue_new() would be more
in keeping with the naming patterns.

> +
> +    qemu_thread_create(&queue->thread, "vnc_worker", vnc_worker_thread, queue,
> +                       QEMU_THREAD_JOINABLE);
>  }
>  
> -void vnc_start_worker_thread(void)
> +void vnc_stop_worker_thread(VncDisplay *vd)
>  {
> -    VncJobQueue *q;
> +    VncJobQueue *queue = vd->queue;
>  
> -    if (vnc_worker_thread_running())
> +    if (!queue) {
>          return;
> +    }
> +
> +    /* all VNC clients must have finished before we can stop the worker thread */
> +    vnc_lock_queue(queue);
> +    assert(QTAILQ_EMPTY(&queue->jobs));
> +    queue->exit = true;
> +    qemu_cond_broadcast(&queue->cond);
> +    vnc_unlock_queue(queue);
>  
> -    q = vnc_queue_init();
> -    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
> -                       QEMU_THREAD_DETACHED);
> -    queue = q; /* Set global queue */
> +    qemu_thread_join(&queue->thread);
> +    qemu_cond_destroy(&queue->cond);
> +    qemu_mutex_destroy(&queue->mutex);
> +    g_free(queue);


I'd suggest  a vnc_queue_free(queue) method here too

> +    vd->queue = NULL;
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index ba7376360e6..4e5a9ee0341 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3457,7 +3457,7 @@ void vnc_display_init(const char *id, Error **errp)
>      vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>      vd->connections_limit = 32;
>  
> -    vnc_start_worker_thread();
> +    vnc_start_worker_thread(vd);
>  
>      register_displaychangelistener(&vd->dcl);
>      vd->kbd = qkbd_state_init(vd->dcl.con);
> @@ -3517,6 +3517,7 @@ static void vnc_display_free(VncDisplay *vd)
>  
>      assert(QTAILQ_EMPTY(&vd->clients));
>  
> +    vnc_stop_worker_thread(vd);
>      vnc_display_close(vd);
>      unregister_displaychangelistener(&vd->dcl);
>      qkbd_state_free(vd->kbd);
> 
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


