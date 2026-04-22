Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFCAF9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV1t-0004eU-Mc; Wed, 22 Apr 2026 06:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1h-0004Hz-Uf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV1f-0002Iu-O6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inYdvGCpIYu2N7toYOzj1Y5BVp2cO4Atp8Li2P8yAVQ=;
 b=L9qFBH1tDPI112l5N3zZgAmVxjD6T0fNVSut2gvdnvVkZpYHJ7baqwuWtItF9qCgR89Q66
 KgS8UvgFfgaqFTAc5b1eP08YVdkKAapXI9mgo2Qb4Ec6h9T/FkZK+wgFD5WSVKugkPNYWO
 sms9G7lBTHABRs1ix299bpXGbsCKUOA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-U_lnOwdaO1aLdr7yShSQ6w-1; Wed,
 22 Apr 2026 06:41:45 -0400
X-MC-Unique: U_lnOwdaO1aLdr7yShSQ6w-1
X-Mimecast-MFC-AGG-ID: U_lnOwdaO1aLdr7yShSQ6w_1776854504
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E6CD1800352; Wed, 22 Apr 2026 10:41:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2B6119560AB; Wed, 22 Apr 2026 10:41:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 09/40] ui/vnc-jobs: remove vnc_queue_clear()
Date: Wed, 22 Apr 2026 14:40:10 +0400
Message-ID: <20260422104042.3936506-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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


