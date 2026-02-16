Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D56E7BD88
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvmw-00058b-Cf; Mon, 16 Feb 2026 05:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vrvmv-00057y-1N
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vrvmt-0006RZ-DR
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=og3R0QAVpEu3XhgTJIvQ+hBOvjqcwqFOe4HoPsi77n4=;
 b=abmd+pwmFwnrq+tlPlSrPeDPO8smO3jmB6C5K3ElZEqcMI+3U3s2XBA3Veq71QlvJRGnZh
 97Jz7WveLvcDlMX+d0cMv73Ut3yJFX/vil8MdL5GjVxbWtsSObIBflEht7XR8ta9MhcWJl
 JyG9D+jBmmrJJoo9sr3tg9LN6iR1/SM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-aKcJ-0JROU6bPqPHhh3t-Q-1; Mon,
 16 Feb 2026 05:25:01 -0500
X-MC-Unique: aKcJ-0JROU6bPqPHhh3t-Q-1
X-Mimecast-MFC-AGG-ID: aKcJ-0JROU6bPqPHhh3t-Q_1771237500
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5F5C18002C2; Mon, 16 Feb 2026 10:24:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BBC319560B2; Mon, 16 Feb 2026 10:24:55 +0000 (UTC)
Date: Mon, 16 Feb 2026 11:24:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 jean-louis@dupond.be, dionbosschieter@gmail.com
Subject: Re: [PATCH] block/mirror: disable dirty bitmap only after job init
Message-ID: <aZLwdRhpTHvi1Y1-@redhat.com>
References: <20260212120411.369498-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120411.369498-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.02.2026 um 13:02 hat Fiona Ebner geschrieben:
> Currently, the dirty bitmap is disabled too early and the following
> bad scenario is possible:
> 
> 1. Dirty bitmap is disabled in mirror_start_job()
> 2. Some request are started in mirror_top_bs while s->job == NULL
> 3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
>    the request hasn't completed yet, the block isn't allocated
> 4. The request completes, still sees s->job == NULL and skips the
>    bitmap, and nothing else will mark it dirty either
> 
> One ingredient is that mirror_top_opaque->job is only set after the
> job is fully initialized. For the rationale, see commit 32125b1460
> ("mirror: Fix access of uninitialised fields during start").
> 
> Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write()
> sees that the job is set, because then:
> 
> 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap
>    will be set by bdrv_mirror_top_do_write().
> 
> 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
>    synchronously to the target.
> 
> At least with virtio-blk using iothread-vq-mapping, mirror_run() and
> bdrv_mirror_top_do_write() might be called in different threads.
> bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap
> mutex, so the memory is synchronized between threads.
> 
> Many thanks to Kevin Wolf for discussing the issue and solutions with
> me! [0]
> 
> [0]: https://lore.kernel.org/qemu-devel/4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be/T/
> 
> Cc: qemu-stable@nongnu.org
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3273
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/mirror.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b344182c74..eadd4501e8 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1123,6 +1123,21 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>       */
>      mirror_top_opaque->job = s;
>  
> +    /*
> +     * Disabling the dirty bitmap is safe once bdrv_mirror_top_do_write() sees
> +     * that the job is set, because then:
> +     *
> +     * 1. When not using MIRROR_COPY_MODE_WRITE_BLOCKING, the dirty bitmap will
> +     * be set by bdrv_mirror_top_do_write().
> +     *
> +     * 2. When using MIRROR_COPY_MODE_WRITE_BLOCKING, writes will be done
> +     * synchronously to the target.
> +     *
> +     * bdrv_disable_dirty_bitmap() acquires and releases the dirty bitmap mutex,
> +     * so the memory is synchronized between threads.
> +     */
> +    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +
>      assert(!s->dbi);
>      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
>      for (;;) {
> @@ -2014,12 +2029,6 @@ static BlockJob *mirror_start_job(
>          goto fail;
>      }
>  
> -    /*
> -     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
> -     * mode.
> -     */
> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> -
>      bdrv_graph_wrlock_drained();
>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
>                               BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |

The thing I meant in the other thread is if we don't need something like
this additionally:

diff --git a/block/mirror.c b/block/mirror.c
index b344182c747..159954158ba 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1672,9 +1672,17 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
         abort();
     }
 
-    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
+    if (!copy_to_target) {
         qatomic_set(&s->job->actively_synced, false);
-        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
+        if (s->job && s->job->dirty_bitmap) {
+            bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
+        } else {
+            /*
+             * Avoid race in the case that mirror_run() disables the bitmap
+             * between here and bdrv_co_write_req_finish().
+             */
+            bdrv_set_dirty(bs, offset, bytes);
+        }
     }
 
     if (ret < 0) {

By the way, can it ever happen that s->job && !s->job->dirty_bitmap or
is that second part of the condition redundant?

Kevin


