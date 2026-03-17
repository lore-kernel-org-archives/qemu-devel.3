Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5381CF3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9N-0005kJ-1A; Tue, 17 Mar 2026 04:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q92-0005hQ-CB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q90-0002iA-Ju
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IznevMGLIaneohaIKvUB/NRYjF0fgbDeE2RC1EgEH1Y=;
 b=C6scSYvAEHYuzuaRugFNVQbv+UlovtLU243F4w1zMIPFND+Qs/mYx7l2qbyrLigC4oVXpV
 WZpD7N2wqst807aX58fLr+fZmhdelMzKKzxfOpo+x5BjneuMf/daXJMY9buvhb4DjwhPQp
 aqz72xIQw2xvKgj0qTgophLdhe7fO/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-XUymlAh0PKqfMh1d9aOTYQ-1; Tue,
 17 Mar 2026 04:51:16 -0400
X-MC-Unique: XUymlAh0PKqfMh1d9aOTYQ-1
X-Mimecast-MFC-AGG-ID: XUymlAh0PKqfMh1d9aOTYQ_1773737475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C11D31954B1C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6B831800361
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:20 +0400
Subject: [PATCH 06/60] ui/vnc-jobs: remove dead VncJobQueue.exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-6-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Sed8g/S/JYt3qFw7QsNdZYnYZihK/1Nkqd9W0dWtzhc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXa2ye8cITSUdcbDk2tdyscnG1KLeZRnPYgt
 mI3ooDQnsyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5cGrD/45cryL7fkmxs5pV3DkoQVtY4VljlIx0zmLKpKGUQudFfXo3k8TFdoJ+1PkWo8XPdhyPbp
 VfFuOpGOHQZlxowK3QmB0RBVur4bZEwLtVKGFFdT/ysfcnKu63S7c7g4RZrvtrvclUE4u8sMao2
 jJDXZirgUQdjoc8/J/H5/tF2mwB5tee8M2QB/Izs7JJjSz79NoOkkqdczLwmXnuof5BR6HXkFAa
 fhAhdHr9qoj9mZgs/z5tLt1Gw0QdeuNUOMjQL91KrjndNvJRhE/qcB8XvN9/4iGpZjQK4OqqIqX
 MMPD5T/nyNFtNiOX/dN/IQCjOq5uJ328OHYcXMfvCYI1lbZ1h7obp4TYOZBbZdCrvqPGAtZ9slT
 7ReNAZvIKqzrNC1DvqKhlH7xmsk06FqQoI0aZhFWR2+6JKmVpAviNDRFEhVZ/xe/Nyg50QHLUc/
 C823CTZmi9eEfSAojMb0dH/S33g0BQfkYK3HBOmNJuU2iRgJAafLgdvCPfz6ebljNiRCLoG+7p5
 mXqKJOPZ3ffL5Qo7OCtmP5uLms01YbGahoZoe8xWFawJngCg+9SSLgSQkzaRUF/H9J0gCjmeAh/
 +awKedRkEOaMDqRhzBeHdTx8SBGL3m6N6Q67yR8rj+n5kRTZh5LT+p4IrhdFbLjKpWPmFPksZ5J
 Gq+9/aThCfSQ7YQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since commit 09526058d0a5 ("ui/vnc: Remove vnc_stop_worker_thread()"),
it's not used anymore. It seems stopping worker thread hasn't been
supported ever.

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


