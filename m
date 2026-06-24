Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6DBCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRZR-0007xB-HE; Wed, 24 Jun 2026 13:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZG-0007SL-TP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRZB-0004XZ-Vy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48scUZ/AVH6sBd0rwVqS48vcL7DzpHoZlAUp7mirFwQ=;
 b=UXt3u+IobvhUzvmxI7MiamCwbcSjy1cE8Y0Y2+WNOWD3Je0X9k6PQyoBo6dZC8mbjabAEh
 sugtIQMSDZWMgQlYTIOZ7K3QE3h6taBAHCxOp3YQOFwq4m6dwgokhv9Z5vSEWPbo5kAkso
 EQ5xCoOObO+h1fURO08txyMBBzRz4Rw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-7KJzwyZtNROf_liKguexoA-1; Wed,
 24 Jun 2026 13:39:09 -0400
X-MC-Unique: 7KJzwyZtNROf_liKguexoA-1
X-Mimecast-MFC-AGG-ID: 7KJzwyZtNROf_liKguexoA_1782322748
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A5A41955EBA; Wed, 24 Jun 2026 17:39:08 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 934B4180034F; Wed, 24 Jun 2026 17:39:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v5 17/35] monitor: drop unused monitor_cur_is_qmp
Date: Wed, 24 Jun 2026 18:37:33 +0100
Message-ID: <20260624173752.2928717-18-berrange@redhat.com>
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
monitor_cur_is_qmp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  1 -
 monitor/monitor.c              | 10 ----------
 stubs/monitor-core.c           |  5 -----
 tests/unit/test-util-sockets.c |  1 -
 tools/qemu-vnc/stubs.c         |  5 -----
 5 files changed, 22 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 8cb3db677b..3f730cffee 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -25,7 +25,6 @@ extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
-bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index b788669f1f..0db7903795 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -150,16 +150,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-/**
- * Is the current monitor, if any, a QMP monitor?
- */
-bool monitor_cur_is_qmp(void)
-{
-    Monitor *cur_mon = monitor_cur();
-
-    return cur_mon && monitor_is_qmp(cur_mon);
-}
-
 bool monitor_requires_iothread(const Monitor *mon)
 {
     MonitorClass *cls = MONITOR_GET_CLASS(mon);
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 078a5012e9..a7c32297c9 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,11 +7,6 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
-bool monitor_cur_is_qmp(void)
-{
-    return false;
-}
-
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index b9f2453e29..ee66d727c3 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -74,7 +74,6 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
-bool monitor_cur_is_qmp(void) { abort(); };
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
index a865ce85f0..1c82d8cff4 100644
--- a/tools/qemu-vnc/stubs.c
+++ b/tools/qemu-vnc/stubs.c
@@ -36,11 +36,6 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
-bool monitor_cur_is_qmp(void)
-{
-    return false;
-}
-
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
-- 
2.54.0


