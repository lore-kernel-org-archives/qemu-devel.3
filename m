Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49902F459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEOM-0006iG-FK; Fri, 10 Apr 2026 12:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN6-0004Rr-1L
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN2-0006ag-RV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yGpbp1wrCi4QCAosuKIWuVsmzC+UFfclvaHmYjnOJ4=;
 b=ChV38lgwAfMEbou5Hfv/Rx5ucFz736VZuTpxMfsamvCHhyc/DY/CPpEQTJWKqi910D9bTG
 UZnh43Tksmu/HYggOnFV94PVESTwvIm8gOkRexnHqo/bs3K13C1bVCvVm8esVElzDRQ3dE
 eRgZBwxxpnpiYT/s8tVS6BybRLzEOww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-CMlD4FhoOFK9KZEBPtNB8Q-1; Fri,
 10 Apr 2026 12:06:01 -0400
X-MC-Unique: CMlD4FhoOFK9KZEBPtNB8Q-1
X-Mimecast-MFC-AGG-ID: CMlD4FhoOFK9KZEBPtNB8Q_1775837160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F1D019560AA; Fri, 10 Apr 2026 16:06:00 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D41E219560AB; Fri, 10 Apr 2026 16:05:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 15/17] monitor: drop unused monitor_is_qmp method
Date: Fri, 10 Apr 2026 17:04:56 +0100
Message-ID: <20260410160458.3778874-16-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 7004f5d002..d40fdde793 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -106,7 +106,6 @@ struct Monitor {
     Object parent;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
-    bool is_qmp;
     bool use_io_thread;
 
     char *mon_cpu_path;
@@ -171,14 +170,6 @@ struct MonitorQMP {
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
index c08b2c2ee1..f48603a7e8 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -94,7 +94,6 @@ static void monitor_init(Object *obj)
     Monitor *mon = MONITOR(obj);
 
     qemu_mutex_init(&mon->mon_lock);
-    mon->is_qmp = !!object_dynamic_cast(obj, TYPE_MONITOR_QMP);
     mon->outbuf = g_string_new(NULL);
 }
 
-- 
2.53.0


