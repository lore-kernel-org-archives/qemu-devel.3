Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC01FD1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtRn-0006ix-HQ; Thu, 08 Jan 2026 12:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRX-00062F-A1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRT-00070z-UH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHfp9koRpKPpUyuiE2GHRdtDltYSxKdLKrgXRYbwQBU=;
 b=Z5UqNdtS+qw0YuEF+WDzTLIsAX/NJpm6wvA+9f5K6n27xU7d4uUpt3IyR2nw3FOxGzfEUv
 Z9MxqNTFSdzVKdsFXkFzm6c+/PON3el9WKtZZnp9TeIXX234SqzNz+Riywo5dPM486DgHg
 3sYHNYCHjsK9ycsNQBer6EoNF1C8UQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-P4ikxrj8NFKRJ4LaTYsWFg-1; Thu,
 08 Jan 2026 12:04:53 -0500
X-MC-Unique: P4ikxrj8NFKRJ4LaTYsWFg-1
X-Mimecast-MFC-AGG-ID: P4ikxrj8NFKRJ4LaTYsWFg_1767891892
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 285BF1955F34; Thu,  8 Jan 2026 17:04:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39ADE19560B4; Thu,  8 Jan 2026 17:04:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 15/24] monitor: introduce monitor_cur_is_hmp() helper
Date: Thu,  8 Jan 2026 17:03:29 +0000
Message-ID: <20260108170338.2693853-16-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Note that this is not simply the inverse of monitor_cur_is_qmp(),
as both helpers require that monitor_cur() is first non-NULL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  1 +
 monitor/monitor.c              | 10 ++++++++++
 stubs/monitor-core.c           |  6 ++++++
 tests/unit/test-util-sockets.c |  1 +
 4 files changed, 18 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1..9c71e6cf3c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -16,6 +16,7 @@ extern QemuOptsList qemu_mon_opts;
 Monitor *monitor_cur(void);
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
 bool monitor_cur_is_qmp(void);
+bool monitor_cur_is_hmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6dc5a7016d..b81cc7d2ed 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -116,6 +116,16 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
 
+/**
+ * Is the current monitor, if any, a HMP monitor?
+ */
+bool monitor_cur_is_hmp(void)
+{
+    Monitor *cur_mon = monitor_cur();
+
+    return cur_mon && !monitor_is_qmp(cur_mon);
+}
+
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index a7c32297c9..674211f48f 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,6 +7,12 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+bool monitor_cur_is_hmp(void)
+{
+    /* since monitor_cur() above returns NULL, this can't be true */
+    return false;
+}
+
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c3..4b7f408902 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
+bool monitor_cur_is_hmp(void) { return false; }
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
-- 
2.52.0


