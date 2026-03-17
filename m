Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70425F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9o-000624-7x; Tue, 17 Mar 2026 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q97-0005jW-Ku
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q96-0002jC-4D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmSu/mBBvG8RYBpITrfSgIbnurHMURYY1Gp/CJZrAO0=;
 b=AMwBUq29jpivTrrrLz6ouB0BpBvcxEgqyI5IZ0IuvFqSUDNTsSzppUChITtXzX2IjCH1n8
 oEKVyK8l4KoAz2QtK1uqSD8TOwKnL/o1uOgZwFp3VLhJSLDk8uIliruaUAZOC6rk84EEVN
 wOH72725mfNYWvc2Z2pZoPCDKomNCiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-96YkNTr-OAKp16NqyT2V8w-1; Tue,
 17 Mar 2026 04:51:22 -0400
X-MC-Unique: 96YkNTr-OAKp16NqyT2V8w-1
X-Mimecast-MFC-AGG-ID: 96YkNTr-OAKp16NqyT2V8w_1773737481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 333D119560A2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:21 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 242A21955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:21 +0400
Subject: [PATCH 07/60] ui/vnc-jobs: remove vnc_queue_clear()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-7-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=o1X6AJPHMwJoGa7BBbTMNCzMXVWGkhZyR/VMSqHsBhc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaerZkxCJW6LjD55trFjwGYXvvo279rmrrb
 n7B51Frf72JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5XvvEACTqdg9mVgyBlqZFb5xqnNQ8GboXo60xA01MYneWP9OoBJ33XHCbaJQebJXfwvPOd82rHS
 dTlL7hiONRShZQTzgoB1gbFAwwg29k8ewWjgPS6DRgHlXAY8t7S6jl8C4Xg6+UhZZoHO0/d+XAv
 8ptd1v6TUTL7yr/4+QUI9nPRNqvxZiAgNfCf6k5oFJ25a6DtTr/mXL0wZT6GLe7+uvACT81KNoT
 WSsEv8zhVd16Ot4RhJh9yobM032jGB4THpWix3lI0mnHNZqf81Q2GLLqOfX6M6RaXfXPaeb5q+5
 /HsGrjYoVwGD1lV6DFn9LQ7aulMpo7g78hXDwrIiKUK8UkItLmyJ/7M+pwSjKHLLg4GQAt9s2AL
 uGWNCbK/58mY3asswzk9WVa8V6kYWygW7q7eO4u9lKHWuDo6qlgKdcOFFuUb8TynajFWaGKKDLJ
 veMwqhJZ0SLKBr0TRL5WlkVyXp8XUtOemQk8lviCxUgbk1JMYD7RBtsSXcGAx8/07TNxDZ1Kzh2
 zCHkoXBHICiFZ0kCQ20RttEZ6OoMKi990YuL7TM7FqxrnKDdppnv5BqztJwVDbGn5nW7chTyWKO
 RhdE3kx9/ikmvg0Z+HYJpm8k710E6dNr2OTfAjh57dfrpYZWupLFM5zS/qs17L7uz/Lc6t00FMM
 r3mPBwncVZ+uKgQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

The function was never called, since the worker thread was never
exiting. Also it was incomplete (not clearing pending job list) and
mixing global queue and argument. Let's remove it.

Note: maybe the worker thread could be torn down when vnc_jobs_join()
realizes there is no job left.

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


