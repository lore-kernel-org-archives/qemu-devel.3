Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D54F9B613
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV2M-0005vS-Rf; Wed, 22 Apr 2026 06:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV24-0005cU-9f
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV22-0002Om-Ps
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1Kn6LTd7bvM3/pbm3eKeUmXgXG3x57/GzAM1f3WSL4=;
 b=QAy9etClxqBuKK95X/PS8sOHGHkaSe/r9MHVfR9hGOG/4nEUIxxwhixeIvUculShg8irTf
 gmyjRLFZvO22N8L+CCZcWzsWggg+t7sp0TfZw9b9SNHbqAtuiXPuxtSLGX/cHNZjnOucsS
 zGOyTfXC38ESQKGuLPJHmCUSyyfHXYQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-wLJjZkMZMPqcr3NHYtL0zw-1; Wed,
 22 Apr 2026 06:41:53 -0400
X-MC-Unique: wLJjZkMZMPqcr3NHYtL0zw-1
X-Mimecast-MFC-AGG-ID: wLJjZkMZMPqcr3NHYtL0zw_1776854510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4CE195609E; Wed, 22 Apr 2026 10:41:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F81D180047F; Wed, 22 Apr 2026 10:41:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/40] ui/vnc-jobs: narrow taking the queue lock
Date: Wed, 22 Apr 2026 14:40:11 +0400
Message-ID: <20260422104042.3936506-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It's not needed unless manipulating the queue.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 28a4738f1ec..9c17d684c9e 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -83,26 +83,26 @@ VncJob *vnc_job_new(VncState *vs)
 
     assert(vs->magic == VNC_MAGIC);
     job->vs = vs;
-    vnc_lock_queue(queue);
     QLIST_INIT(&job->rectangles);
-    vnc_unlock_queue(queue);
     return job;
 }
 
+/*
+ * Do not call this after pushing the job.
+ */
 int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
 {
     VncRectEntry *entry = g_new0(VncRectEntry, 1);
 
     trace_vnc_job_add_rect(job->vs, job, x, y, w, h);
+    assert(!QTAILQ_IN_USE(job, next));
 
     entry->rect.x = x;
     entry->rect.y = y;
     entry->rect.w = w;
     entry->rect.h = h;
 
-    vnc_lock_queue(queue);
     QLIST_INSERT_HEAD(&job->rectangles, entry, next);
-    vnc_unlock_queue(queue);
     return 1;
 }
 
@@ -120,16 +120,21 @@ static void vnc_job_free(VncJob *job)
     g_free(job);
 }
 
+/*
+ * Push a job onto the queue. Ownership of the job is transferred.
+ */
 void vnc_job_push(VncJob *job)
 {
-    vnc_lock_queue(queue);
+    assert(!QTAILQ_IN_USE(job, next));
+
     if (QLIST_EMPTY(&job->rectangles)) {
         vnc_job_free(job);
     } else {
+        vnc_lock_queue(queue);
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
         qemu_cond_broadcast(&queue->cond);
+        vnc_unlock_queue(queue);
     }
-    vnc_unlock_queue(queue);
 }
 
 static bool vnc_has_job_locked(VncState *vs)
-- 
2.53.0


