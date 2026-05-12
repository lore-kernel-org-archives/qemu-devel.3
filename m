Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A40CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuND-0004l9-BB; Tue, 12 May 2026 17:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuN9-0004Hb-Gx; Tue, 12 May 2026 17:10:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuN7-0003k2-PJ; Tue, 12 May 2026 17:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=D5ZIIGAf0zEiOYuz/dz/8pp7vesqXIxrnPBW8ysDI9I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rX3N7HY7a+IhOxHSsk6YJAuNfq7uWnl3xYrPAywgnVGy7B83UDIGSZ13/2wOa3CWY
 JuW/Nq83ZFDsKb1J7GHVUE0gbhVAL+9Ddyw14yZfJm8iP2RfLHjni7MIQlvgiSwq2U
 rckXGqo2mtMEzpv+76FSBoOAymzsHWzBdDgdGyrLQ/4pYyhQTP3IABYY7N0Ke644rI
 yqC/Z5DhVEceoQn0nQ05wKTeh9iSBJnySLfS0f5kgxsJxweOIhg2L0X1oiFkOOXQpa
 zGH3D9clG6mkW2+Jg9XVTwQhVfObJbLRL/kDJau6kaMc3r0a8dufM9lVCmkE5UFpVA
 MbDTA5FzKTfaA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA8171AA36A;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B698F3ABCDA;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 045/117] ui/vnc-jobs: fix VncRectEntry leak on job
 cleanup
Date: Tue, 12 May 2026 23:53:47 +0300
Message-ID: <20260512205503.361097-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 3cae0b46be5416b26039df5259ffc8fcf2989516)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index bed33950a8..d2a3c676b0 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -108,11 +108,25 @@ int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
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
@@ -297,6 +311,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
                 n_rectangles += n;
             }
         }
+        QLIST_REMOVE(entry, next);
         g_free(entry);
     }
     trace_vnc_job_nrects(&vs, job, n_rectangles);
@@ -325,7 +340,7 @@ disconnected:
     QTAILQ_REMOVE(&queue->jobs, job, next);
     vnc_unlock_queue(queue);
     qemu_cond_broadcast(&queue->cond);
-    g_free(job);
+    vnc_job_free(job);
     vs.magic = 0;
     return 0;
 }
-- 
2.47.3


