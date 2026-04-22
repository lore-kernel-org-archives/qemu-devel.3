Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5BCF9B612
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4J-0000qB-L6; Wed, 22 Apr 2026 06:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3o-0000OZ-DN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3m-0003CJ-BO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CZE01DV4ClDM+L4PgsTX8ubkuy5NRZ8ZzDGZ2oKnas0=;
 b=UKXsF8Y8mAffy5xJ1Qd2XcM1coP7x0GUn3pYeEtWLlC0Tt1kXZrLCJ0WTST97D6EkbuQlH
 5T3YTFtcK1OdKuwjQYDRr8enzeGrIlEG4PzC1KBZ+o7DVqUKmmGbE/s56/dWUIhEgcZLHF
 yVFXn96p/Kq9rT3/A15FuaRTDffQ+x0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-JMwEBLZqO4-kL3PrivVKUg-1; Wed,
 22 Apr 2026 06:43:56 -0400
X-MC-Unique: JMwEBLZqO4-kL3PrivVKUg-1
X-Mimecast-MFC-AGG-ID: JMwEBLZqO4-kL3PrivVKUg_1776854635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97AF81956089; Wed, 22 Apr 2026 10:43:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 542BA1800664; Wed, 22 Apr 2026 10:43:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 30/40] util: move datadir.c from system/
Date: Wed, 22 Apr 2026 14:40:31 +0400
Message-ID: <20260422104042.3936506-31-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The datadir module provides general-purpose data file lookup
utilities that are not specific to system emulation. Move it
to util/ so it can be reused more broadly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 {system => util}/datadir.c | 0
 system/meson.build         | 1 -
 system/trace-events        | 1 -
 util/meson.build           | 1 +
 util/trace-events          | 3 +++
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename {system => util}/datadir.c (100%)

diff --git a/system/datadir.c b/util/datadir.c
similarity index 100%
rename from system/datadir.c
rename to util/datadir.c
diff --git a/system/meson.build b/system/meson.build
index 579e8353d53..9cdfe1b3e75 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -8,7 +8,6 @@ system_ss.add(files(
   'bootdevice.c',
   'cpus.c',
   'cpu-timers.c',
-  'datadir.c',
   'dirtylimit.c',
   'dma-helpers.c',
   'exit-with-parent.c',
diff --git a/system/trace-events b/system/trace-events
index 6d29a823f04..e6e1b612798 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -46,7 +46,6 @@ vm_stop_flush_all(int ret) "ret %d"
 
 # vl.c
 vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
-load_file(const char *name, const char *path) "name %s location %s"
 runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
 system_wakeup_request(int reason) "reason=%d"
 qemu_system_shutdown_request(int reason) "reason=%d"
diff --git a/util/meson.build b/util/meson.build
index 5d3fff0eea4..8bed0267c07 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -30,6 +30,7 @@ util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
 if glib_has_gslice
   util_ss.add(files('qtree.c'))
 endif
+util_ss.add(files('datadir.c'))
 util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('event.c'))
diff --git a/util/trace-events b/util/trace-events
index 540d6625073..df549646d12 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -114,3 +114,6 @@ uffd_unregister_memory_failed(void *addr, uint64_t length, int err) "addr: %p le
 # module.c
 module_load_module(const char *name) "file %s"
 module_lookup_object_type(const char *name) "name %s"
+
+# datadir.c
+load_file(const char *name, const char *path) "name %s location %s"
-- 
2.53.0


