Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E2606A327
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bvmzneLq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNULG-0007yA-AH; Sun, 01 Nov 2026 07:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL2-0007x1-UQ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL1-0003Yy-4H
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Sg4/oZ7fo49gWmcBhCl0V3aX/XQ6BCF8InWFjDUPc8=;
 b=bvmzneLqCWWmz4R607/RJJlt3jIB+nv1OGLvcD1vKXRJ4p8Clnz21f5KvJqAb/SefTGjm0
 eQEMgHqYxNgR8ITTcYcyzrb0sZwdPTolQAX0+wuz0JdtCgcTbQV/M11nsUAou+3ptqTHkh
 9acKCVKdZEf9ofvqUmKwYEK+FZQGlB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-R_H2O_2dOfyTRBKFVsC1KA-1; Sun,
 01 Nov 2026 07:07:01 -0500
X-MC-Unique: R_H2O_2dOfyTRBKFVsC1KA-1
X-Mimecast-MFC-AGG-ID: R_H2O_2dOfyTRBKFVsC1KA_1793534820
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6E41955E7D; Sun,  1 Nov 2026 12:07:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F5FA7D9; Sun,  1 Nov 2026 12:06:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:38 +0400
Subject: [GIT PULL 5/9] ui/vnc: recover a job dropped by
 vnc_abort_display_jobs()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-5-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4348;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gPnjkxHfMM4YLNx7201VIW3rLhulcjBseMmNAL+tB3Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOFFo9sRlcgEwIVz1rZJ7liDO8zTDzwa4xP
 sDDZ/e8kPuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5U7AEACZEAowvdK1iRViQxWlUzXNXqe8fzvk2Wz/nDSUDMdli9LshxbVDG45/zremjuXPRRo5sD
 qjiJurDPrnFxoSOtzGLSxIalKPQ7W8/Dj+qpiCJcjaBkTT7LltazEVYDAXZe3Q565X5/lLbj4n5
 fnXdJ4oMwYkLnv3oaJ1e9Pp2NEgkPoHQPh92emFq1Fg8Lgk6A6vJY4kOrGJl64yWY2mdy9wHIpR
 z63R1g3LYOLNh9jCwP7RhTdLZGGmNGtPcNDZ5vSwQ5FjFJu5Ysh4+K07vVb/4vngD4xFE/Swz1/
 SYcWCCoPtYP812bbERG9VuxFUmhXKE9B6KRT0mnZ7NbGzghUsNnoUV98KnYJhN6yfa4HKZct2uG
 XpHK7wIisZIzkXFZ7b4tfy/7tMIBbrnKxoAXy+XpGq0ftCDFRSTWclSQ/rNy2Ci3m8TrVa2UlkL
 mOv1D6b6pxh/0RQM4RxpCNTkTQn60Vw9eOpO2FNaC+Zk67v2S8CKw3EiUPzOO226qkb262Oh60u
 1cA2bTDprFuiThcVIePdO9/T8ZjnTdew0xrQqp4RXGRDAwLFb39IMk6JbKBGxa2H2KMgd+4OIv4
 Ied6nhdGPDR1XnSkRRAJsfO13dfnS0Bm4zW7bW4viA0dKS7uQIn+4dzQ4uxaRRfRr2SEzb3K4j3
 CkZ9Z7AxRK9jkWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dax Kelson <dkelson@gurulabs.com>

Fix a race in the VNC server that corrupts a client's display output
(the client keeps stale pixels because their update is never sent), or
stops updating a client entirely, when the display surface is switched
while an update for that client is queued but not yet encoded.

virtio-gpu guests with a double-buffering compositor (GNOME/mutter on
Wayland) switch surfaces on every frame, so they hit it in normal use:
fast scrolling in a terminal leaves scattered 16-pixel slivers of old
text that stay until the client reconnects. A reproducer (a
page-flipping virtio-gpu guest plus a VNC/QMP harness) loses updates in
35 of 150 four-client cycles on master, and in none with this patch.

How it happens: vnc_update_client() clears a client's dirty bits for
every rectangle it puts into a job, resets vs->has_dirty, and moves
vs->update into vs->job_update, before the worker thread encodes
anything. When the display surface is switched, vnc_dpy_switch() calls
vnc_abort_display_jobs(), and a job the worker has not started yet is
discarded (vnc_worker_thread_loop() sees vs->abort and skips it).

The abort path only handles that case when no newer request is pending,
and even then it restores vs->update but not the cleared dirty state:

1. Lost pixels. On the page-flip path vnc_dpy_switch() then re-dirties
   only the GUEST dirty map. vnc_refresh_server_surface() compares the
   new guest surface against the server surface, which already holds the
   dropped rectangles' pixels, so every chunk that did not change again
   is never marked dirty for the client, and with has_dirty at zero an
   incremental update is not even attempted. The client keeps the stale
   pixels until those chunks change again or it sends a non-incremental
   request.

2. A stuck client. If the client sent another request while the job was
   queued (vs->update != NONE), the dropped job's vs->job_update is never
   cleared, and vnc_should_update() refuses every later update for that
   client until it reconnects.

Retire a dropped job whenever job_update is still set after the join
(a completed job's output was consumed by vnc_jobs_join(), which clears
it), keep a pending forced update, and re-dirty the whole client area
plus has_dirty. This costs one full update, and only when a job was
actually discarded.

Fixes: 61e77a5f0c ("vnc: detect and optimize pageflips")
Fixes: ada8d2e436 ("ui: fix VNC client throttling when forced update is requested")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dax Kelson <dkelson@gurulabs.com>
Message-ID: <20261028223204.86741-1-dkelson@gurulabs.com>
---
 ui/vnc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8b1d03ef2434..10acb3e1e64b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -748,11 +748,24 @@ static void vnc_abort_display_jobs(VncDisplay *vd)
     }
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         vnc_lock_output(vs);
-        if (vs->update == VNC_STATE_UPDATE_NONE &&
-            vs->job_update != VNC_STATE_UPDATE_NONE) {
-            /* job aborted before completion */
-            vs->update = vs->job_update;
+        if (vs->job_update != VNC_STATE_UPDATE_NONE) {
+            /*
+             * Job aborted before completion (a completed job's output was
+             * consumed by vnc_jobs_join(), which cleared job_update).
+             * Retire it even if the client sent a newer request meanwhile,
+             * or vnc_should_update() refuses every later update.
+             * vnc_update_client() already cleared the dirty bits of the
+             * rectangles it carried and the server surface already holds
+             * their pixels, so nothing would mark them dirty again:
+             * re-dirty the whole client area and its pending-dirty count.
+             */
+            if (vs->update != VNC_STATE_UPDATE_FORCE) {
+                vs->update = vs->job_update;
+            }
             vs->job_update = VNC_STATE_UPDATE_NONE;
+            vnc_set_area_dirty(vs->dirty, vd, 0, 0,
+                               vnc_width(vd), vnc_height(vd));
+            vs->has_dirty++;
         }
         vs->abort = false;
         vnc_unlock_output(vs);

-- 
2.56.0.116.g6de20f6092dc


