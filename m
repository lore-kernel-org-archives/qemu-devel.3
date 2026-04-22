Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86934F9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1h-0004Hh-Vn; Wed, 22 Apr 2026 06:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1b-0004E0-1z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1Z-0002IS-Mq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5FCXtUEX1jk/fKHVMJ+Nx2aosJbPE/UQEKJ5yoPU0Q=;
 b=SI1TXD5TKFy8E0NjwHSImaLT40kNIax+pCAMraCF6fOpLh87ucVirl1NMJtWjE3EMPNLaH
 N/xhEiUcsPw8Q1EOY1DCiUD2YDIQfe6BZS+1epEFVxNYzUiWzd1hQa6kApA4u5TQeeo18w
 vSsfNBuhOwkCiELmKN6Ii8OFatWxLDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-kjVBz8I6OmOLK6jWjKQjRg-1; Wed,
 22 Apr 2026 06:41:38 -0400
X-MC-Unique: kjVBz8I6OmOLK6jWjKQjRg-1
X-Mimecast-MFC-AGG-ID: kjVBz8I6OmOLK6jWjKQjRg_1776854497
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9576D195608B; Wed, 22 Apr 2026 10:41:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 766983000C21; Wed, 22 Apr 2026 10:41:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 08/40] ui/vnc-jobs: remove dead VncJobQueue.exit
Date: Wed, 22 Apr 2026 14:40:09 +0400
Message-ID: <20260422104042.3936506-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Since commit 09526058d0a5 ("ui/vnc: Remove vnc_stop_worker_thread()"),
it's not used anymore. It seems stopping worker thread hasn't been
supported ever.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 8cb30e72276..9e536b07b90 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -56,7 +56,6 @@ struct VncJobQueue {
     QemuCond cond;
     QemuMutex mutex;
     QemuThread thread;
-    bool exit;
     QTAILQ_HEAD(, VncJob) jobs;
 };
 
@@ -124,7 +123,7 @@ static void vnc_job_free(VncJob *job)
 void vnc_job_push(VncJob *job)
 {
     vnc_lock_queue(queue);
-    if (queue->exit || QLIST_EMPTY(&job->rectangles)) {
+    if (QLIST_EMPTY(&job->rectangles)) {
         vnc_job_free(job);
     } else {
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
@@ -248,17 +247,12 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
     int saved_offset;
 
     vnc_lock_queue(queue);
-    while (QTAILQ_EMPTY(&queue->jobs) && !queue->exit) {
+    while (QTAILQ_EMPTY(&queue->jobs)) {
         qemu_cond_wait(&queue->cond, &queue->mutex);
     }
-    /* Here job can only be NULL if queue->exit is true */
     job = QTAILQ_FIRST(&queue->jobs);
     vnc_unlock_queue(queue);
 
-    if (queue->exit) {
-        return -1;
-    }
-
     assert(job->vs->magic == VNC_MAGIC);
     vc = container_of(job->vs, VncConnection, vs);
 
-- 
2.53.0


