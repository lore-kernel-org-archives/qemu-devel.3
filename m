Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB0ECD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXI9v-0001Bl-Ht; Wed, 10 Jun 2026 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI9t-000117-Js
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI9r-0003RX-Hd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wterB0lN9a8Cvx7eccBENkKcz3yI0IvsfLhjAZode5M=;
 b=epEB29vaIad9A+WpQyJfHVAhVpzgNW8Dlcu+krfn0hIc41iVadVWvU0GKQp9PP+ZPzfCwq
 VxPBXcpZn+OZ/MQCDlzQNOZpL7LoasQqUqrVTOH09/ge10L9eAamh+ZRN7/WFCd/jioMxD
 3eubfZKh6B4rNpakWUsAoX7ma+A/GtQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-Vce28G63MzOh4oZKLgIU6g-1; Wed,
 10 Jun 2026 08:35:43 -0400
X-MC-Unique: Vce28G63MzOh4oZKLgIU6g-1
X-Mimecast-MFC-AGG-ID: Vce28G63MzOh4oZKLgIU6g_1781094942
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E6361800A3F; Wed, 10 Jun 2026 12:35:42 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8419F31D2; Wed, 10 Jun 2026 12:35:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 20/35] monitor: drop unused monitor_is_qmp method
Date: Wed, 10 Jun 2026 13:34:00 +0100
Message-ID: <20260610123415.2883603-21-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The previous patch dropped the only remaining use of
monitor_is_qmp.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h | 9 ---------
 monitor/monitor.c          | 1 -
 2 files changed, 10 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index efd21b8912..fe5703af6d 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -134,7 +134,6 @@ struct Monitor {
     char *chardev_id;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
-    bool is_qmp;
 
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
@@ -197,14 +196,6 @@ struct MonitorQMP {
     GQueue *qmp_requests;
 };
 
-/**
- * Is @mon a QMP monitor?
- */
-static inline bool monitor_is_qmp(const Monitor *mon)
-{
-    return mon->is_qmp;
-}
-
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
 extern IOThread *mon_iothread;
 extern Coroutine *qmp_dispatcher_co;
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 578aca70d4..0cace985f0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -112,7 +112,6 @@ static void monitor_init(Object *obj)
     Monitor *mon = MONITOR(obj);
 
     qemu_mutex_init(&mon->mon_lock);
-    mon->is_qmp = !!object_dynamic_cast(obj, TYPE_MONITOR_QMP);
     mon->outbuf = g_string_new(NULL);
 }
 
-- 
2.54.0


