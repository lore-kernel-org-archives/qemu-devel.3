Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBAF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHO7-0002OD-IC; Fri, 10 Apr 2026 15:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHO5-0002Ne-MN
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHO4-0000S1-DY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROmzbrl3g/helr+i5FS/DorPr+JmvWFeR0/3EHyzpto=;
 b=RaJjVn3eX147oqCa17qfZ3oO9wwRvCr5Eq7WaH92bxo0uYx+vA35ltNWfUN+IVCMEqOjiM
 MnSMiOa9rlWkHPmdHoW1RBCe7Oscxz7g4+1PjTpMSkqnBdFTf+cTyy+u9FwiykPsuZPec1
 OnYeNB8sSA+fg07ZquiejwUIJpN7HB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-vO80eM5qMpGfWVfZrSApQQ-1; Fri,
 10 Apr 2026 15:19:26 -0400
X-MC-Unique: vO80eM5qMpGfWVfZrSApQQ-1
X-Mimecast-MFC-AGG-ID: vO80eM5qMpGfWVfZrSApQQ_1775848765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 294E3195D03E
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:24 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC6003000C1D; Fri, 10 Apr 2026 19:19:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:27 +0400
Subject: [PATCH v2 05/67] ui/vnc-jobs: remove vnc_queue_clear()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-5-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qyc2bReAPSXL8Tu4TqrZ5PYPjMmPgsbSEM8+ZDWFQ8Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TcAMQRTArg5i3X9RzaNGMtsasVL0Ux8HY3
 fnG2V/1aVSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5a3MD/9DZfaOdJNQpTLK4CIhE7F7Aua1exC+ycY6Udu21QKvWMQELQGi/QGR4eZi05W3JlOiTzK
 Qn31eL8YqBm7J7Uo/scZEmZtcwG3Qfp5fZu0HU4V5mcUBH/wpWQG7jEqys9/f9/wf78xp4vtUx8
 lzvJzXd7oKZAnsmjlJcZC+7FfZC51WIfLdbEpi0Snil8Wt3e31tIH7LhLMUVxBV10qHBM8zRhnB
 SdhVo+jPXpdpFhIByv12I1jraSu1tuzo0o/i1jstdAI0cfNPz2TIAHMPv6daKbkyhDY0CqbJ540
 UP+8cSg/tpS1B4VUesoT/ZK4gkg3F55MIylXbTmSFmVVVEC23tQQuouS7GcYCnfTVEtTIMB7gWV
 XsuTt753AGMvZscIEstM0vreoG+QGEPe20ygDQys5JPnyj2WJE7w8D/W2BpweBAz8KlAfI+Ejrh
 uxqDTHzBVsP3ZXj4K3tR0aQ3LItPzNMeANh5SEI9hjRpyTi3b2UkVcJqJ4x2mkBsd5hEg3BzObI
 5JLTCwltxhBg9DVx02Zby/QPfKkTYpbraePTf4HYCE+BZNgjj9e6UvPHqZBtQZvAxDYChV9kUrA
 4ATe/JLCN8Po6QmmFoMz7ggDvIw7bZsE+G7FVvRJrEWVbIvgjMAQgtb5J/FORLD0Ay3778ij1DY
 DR2p3cVf00bRt7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The function was never called, since the worker thread was never
exiting. Also it was incomplete (not clearing pending job list) and
mixing global queue and argument. Let's remove it.

Note: maybe the worker thread could be torn down when vnc_jobs_join()
realizes there is no job left.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 9e536b07b90..28a4738f1ec 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -345,14 +345,6 @@ static VncJobQueue *vnc_queue_init(void)
     return queue;
 }
 
-static void vnc_queue_clear(VncJobQueue *q)
-{
-    qemu_cond_destroy(&queue->cond);
-    qemu_mutex_destroy(&queue->mutex);
-    g_free(q);
-    queue = NULL; /* Unset global queue */
-}
-
 static void *vnc_worker_thread(void *arg)
 {
     VncJobQueue *queue = arg;
@@ -360,7 +352,7 @@ static void *vnc_worker_thread(void *arg)
     qemu_thread_get_self(&queue->thread);
 
     while (!vnc_worker_thread_loop(queue)) ;
-    vnc_queue_clear(queue);
+    g_assert_not_reached();
     return NULL;
 }
 

-- 
2.53.0


