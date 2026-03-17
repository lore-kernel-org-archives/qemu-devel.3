Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A25F3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q8p-0005XW-Hj; Tue, 17 Mar 2026 04:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8a-0005VL-KF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8Z-0002dS-3e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGTjgtHL5muRT74itdDRSEurgAYGEKElfvAsD0TqRGo=;
 b=TNpHvxu3ypNyWA9EPno/uDJnXRNVZHDI+TYlnEmrTlx+KChqzLbLpZic6yW0/inlRt4Lm8
 ZmkHKByLHPnRXsSfoqySkZVeOucaa0NjbFBMowCwpYvzyr8cU3W6Hggm1WCqoLMfwWdJ+x
 QQJcgmuz9lRDI+nJHPb3yIEjgnyIORY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-pcPOBXkCN_6rbDG4-mm0Fw-1; Tue,
 17 Mar 2026 04:50:48 -0400
X-MC-Unique: pcPOBXkCN_6rbDG4-mm0Fw-1
X-Mimecast-MFC-AGG-ID: pcPOBXkCN_6rbDG4-mm0Fw_1773737447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8D391955F6A
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB1B41800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:15 +0400
Subject: [PATCH 01/60] ui/vnc-jobs: fix VncRectEntry leak on job cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-1-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RLlcTNCdLyyu+aN9n+BJ1vQwoIRnZWh7ApczLnywLF0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXZJ3D0hoPuJ3ln2WZo2Fl/+PuO+vJKhx3ot
 PpSHvjoCsWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2QAKCRDa6OEJdZac
 5afAD/9fdHym8fTFD89znrza2+JPB/Z+bByMb5yFTYQdsL0ha9sYZrBBkwA1Fx2u/CUhMuQ1VO7
 j1naWzJsQdxfpupiT0iJKmdNlkxX1fBtj7GPb/9fSC46T6l/641JTYVX88M+uJAV42MC4YjRCD+
 uDcJu4CjdSidUYXTbe0Xv8fR1GqQITRVuPO1edhmc/eHJzq5ygcv/YkhyJffYKjpPp3mvxmm5+Q
 EUNt0G/pQJCQbpiVetp01gjDXwvq7D1lmFqeL2NrXCYyJfsmY+qAavoLi1uwJ/a8PGFGD8JlyEI
 fgQoJAoKhqCPxjuPDbLlYDKz2GYVK40ilWh1Y/aa62byx60PKz5kQw6GWagUiSYo8cmaY71DlRW
 EfKfolVZMff1V65YSbV4a4Fd/9+pIxb3cYrF2x47uFVb3GsDEhTuPnJdKRB5xmXw3y36MfO7v1H
 rdGmi+gbV4xLgj0owjOoxtKvHOwtj/kvW75NpaXNEkzjEoazcR94JaOlsjIWUetHv3bkcDDDhc2
 bL+9CKaQU/2Zhwwb49kCb8dOcQskA7j2tCp/NkiSqdUWQMI3Mqv/CX2pzQJxQMGyFkQ09jCaEV3
 bn+vzV2ruDGxERxqLzwRdQSrBIE2hxrqM1fjfeC2xqpMinmpxZAVXJlAYmWM5lUXfUSR0maumCO
 /33YvkQWKlAYzIA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


