Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEBEFF60F9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vn2-0000Zr-VI; Tue, 31 Mar 2026 05:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vn0-0000Xs-QM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmz-00089S-Et
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2zQVVCmyQ0LGrf0EklnYlbhl3AtvR1KwwHBqe0PJ9I=;
 b=ZdWrMZ5LwZWcM8aZZ48wpvq1P1j84Om94KesaBaCicGSAwWFaCIGl77Yi6G8w70UiiI+Z7
 0S97EP/MskEp4d3SVG22AXvEfxU+oySopXpnXWB4Jv6w85JhDOGB3mK6mDxjlqp2ZynGtQ
 C3EOBH6vHMNvS7dXmIlFQedtDkPZ7T0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-LWtE86NEOrW71MRV9zAneA-1; Tue,
 31 Mar 2026 05:53:33 -0400
X-MC-Unique: LWtE86NEOrW71MRV9zAneA-1
X-Mimecast-MFC-AGG-ID: LWtE86NEOrW71MRV9zAneA_1774950812
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CB18180034E; Tue, 31 Mar 2026 09:53:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61DE418002A6; Tue, 31 Mar 2026 09:53:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 4/6] ui/vnc-jobs: fix VncRectEntry leak on job cleanup
Date: Tue, 31 Mar 2026 13:53:00 +0400
Message-ID: <20260331095302.644608-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When a VncJob is freed, its associated VncRectEntry list must also be
freed. Previously, vnc_job_push() and the disconnected path in
vnc_worker_thread_loop() called g_free(job) directly, leaking all
VncRectEntry allocations.

Introduce vnc_job_free() which iterates and frees the rectangle entries
before freeing the job itself, and use it in both paths.

Also add QLIST_REMOVE() in the worker loop before g_free(entry), so
that entries processed during normal operation are properly unlinked.
Without this, vnc_job_free() would iterate dangling pointers to
already-freed entries, causing use-after-free.

Fixes: bd023f953e5e ("vnc: threaded VNC server")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index b296d19e089..ca625da6d05 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -107,11 +107,25 @@ int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
     return 1;
 }
 
+static void vnc_job_free(VncJob *job)
+{
+    VncRectEntry *entry, *tmp;
+
+    if (!job) {
+        return;
+    }
+    QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
+        /* no need for QLIST_REMOVE(entry, next) */
+        g_free(entry);
+    }
+    g_free(job);
+}
+
 void vnc_job_push(VncJob *job)
 {
     vnc_lock_queue(queue);
     if (queue->exit || QLIST_EMPTY(&job->rectangles)) {
-        g_free(job);
+        vnc_job_free(job);
     } else {
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
         qemu_cond_broadcast(&queue->cond);
@@ -296,6 +310,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
                 n_rectangles += n;
             }
         }
+        QLIST_REMOVE(entry, next);
         g_free(entry);
     }
     trace_vnc_job_nrects(&vs, job, n_rectangles);
@@ -324,7 +339,7 @@ disconnected:
     QTAILQ_REMOVE(&queue->jobs, job, next);
     vnc_unlock_queue(queue);
     qemu_cond_broadcast(&queue->cond);
-    g_free(job);
+    vnc_job_free(job);
     vs.magic = 0;
     return 0;
 }
-- 
2.53.0


