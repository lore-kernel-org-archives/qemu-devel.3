Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DE2F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHNz-0002JT-Mb; Fri, 10 Apr 2026 15:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNy-0002H5-GW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNx-0000Py-5n
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I09NHvw8atmJax+ZAvCxf3dEVbEAKA6LxIu95J9jOIY=;
 b=aOtGMdqCE3GgNrbgykTRD31oDqd5g2nA/gmAubYY35p7chaAB7gZT+0/AmgggYfMqOfyWl
 0Onzm8yRHezUzpIhRX+HRf5DWPAMn1z7S+E6CRv0MQm2lGQLwM0mSJ+CCMjOhTTmVhSA8N
 nyS83zuF0q3GQfbtY1j94Kdqko2pHsU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-vx_P347-OGmlxAVJd63VUA-1; Fri,
 10 Apr 2026 15:19:18 -0400
X-MC-Unique: vx_P347-OGmlxAVJd63VUA-1
X-Mimecast-MFC-AGG-ID: vx_P347-OGmlxAVJd63VUA_1775848757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91A431801326
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56C8D1955E77; Fri, 10 Apr 2026 19:19:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:26 +0400
Subject: [PATCH v2 04/67] ui/vnc-jobs: remove dead VncJobQueue.exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-4-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dgRNTw9wFjvzywdXh2HBEiFRI7zZwhAv49Mp+nZt5gc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TpkcMpz7YbgnFAe1hXAkHJHnR/wCYU0Mrb
 ubWcspCNNKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5UD9D/9I9EaL70HdZHS43JiYeFsD1WDReURSerHfakS1qq6EsrcgYPkP5I0cqiXlAAM2VNYscFa
 1+9TVAaA4DaXLvytfgzPDC0aFw7oGliGknm8yLdOZoyyj+TfKvy/9R6xV+ZAYqp6TWwkn69t1SI
 068X2k5HBMUK736cR9ORpjDEKGXavjat4iAoRpGEpQB3NNisYG7BXKO6a2qGtEEDpB/3ny4TV+E
 LrCct8rIZwX8Pof6Ho5Lex/keQSHFd2tjubNEuVVKLd+PYPyXbUZFhI3bekvrKIzVySZl79Lddr
 1M5N4SNjsEgE9pf0/UiaaoS8aHzJTWsrDwCd34vRFeFW7rLQNmRHodL8BiPjtSf0qBh1kp7LQs4
 hhctQGqAwAPEhyLN+dFJRjyoHdgpM8TUCAmiVKC9KHPt32ez9Q0B0GSXvaJgyueZgRjLjKuFdUt
 3D1/cVAFfsCsiH3zc+PVmxrxfJHI3pBtELkoTkQgwS7s0JscVwC72Af93MFbxUyEW2I16bQ56/8
 9tWGuSbqKfUcwKKkiPYjBgNr8+vN+ySkNMkQHIfx37f0i6G7lmrD+r/iFxRZT6gfKhJxs/oPEpK
 2+fBMFxibm7ClBFTgfQ93EvqdeZ5Erg7vsJR9eQf/kZSVWuadeW1IldCcYpSuO1bu2f30NF23AW
 2UyU9WACLYYvuNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


