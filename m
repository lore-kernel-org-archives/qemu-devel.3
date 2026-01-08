Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A52D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtQh-0003tI-Pf; Thu, 08 Jan 2026 12:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQe-0003nq-Bz
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQc-0006rZ-8K
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtFPI6vVXa2ox707p91yDXfVumBlXkpusbUwLIynWCc=;
 b=JrThNT27O5cfPhC6jfS4dyUZgijE0ZeGGo38i+R2ZI3W7xI8YzF11R+4FZDGeDbuXxjejR
 EK3CDSHYAMxl69YxnNBzf5IZDFG0FY6y8mCsQjSmNoGKa+5tsd9J3tIlO3bJCoZivscAKN
 EOlcGLLLuPq+qEa6s+FJ4PGg0KgVqCY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-_VYh9_zhNe-y6nSlJbwTsQ-1; Thu,
 08 Jan 2026 12:04:00 -0500
X-MC-Unique: _VYh9_zhNe-y6nSlJbwTsQ-1
X-Mimecast-MFC-AGG-ID: _VYh9_zhNe-y6nSlJbwTsQ_1767891838
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D8BB1956095; Thu,  8 Jan 2026 17:03:58 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3A2C19560B4; Thu,  8 Jan 2026 17:03:54 +0000 (UTC)
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
Subject: [PATCH v5 03/24] monitor: initialize global data from a constructor
Date: Thu,  8 Jan 2026 17:03:17 +0000
Message-ID: <20260108170338.2693853-4-berrange@redhat.com>
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

Some monitor functions, most notably, monitor_cur() rely on global
data being initialized by 'monitor_init_globals()'. The latter is
called relatively late in startup. If code triggers error_report()
before monitor_init_globals() is called, QEMU will abort when
accessing the uninitialized monitor mutex.

The critical monitor global data must be initialized from a
constructor function, to improve the guarantee that it is done
before any possible calls to monitor_cur(). Not only that, but
the constructor must be marked to run before the default
constructor in case any of them trigger error reporting.

Note in particular that the RCU constructor will spawn a background
thread so we might even have non-constructor QEMU code running
concurrently with other constructors.

As a general note, constructors should be extrememly careful
about what QEMU code they invoke, as it cannot be guaranteed that
the process is fully initialized and so not all normal QEMU API
rules apply.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Fixes: e69ee454b5f9 (monitor: Make current monitor a per-coroutine property)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1273eb7260..dd2c45ded0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -708,18 +708,22 @@ void monitor_cleanup(void)
     }
 }
 
-static void monitor_qapi_event_init(void)
+/*
+ * Initialize static vars that have no deps on external
+ * module initialization, and are required for external
+ * functions to call things like monitor_cur()
+ */
+static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
+monitor_init_static(void)
 {
+    qemu_mutex_init(&monitor_lock);
+    coroutine_mon = g_hash_table_new(NULL, NULL);
     monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
                                                 qapi_event_throttle_equal);
 }
 
 void monitor_init_globals(void)
 {
-    monitor_qapi_event_init();
-    qemu_mutex_init(&monitor_lock);
-    coroutine_mon = g_hash_table_new(NULL, NULL);
-
     /*
      * The dispatcher BH must run in the main loop thread, since we
      * have commands assuming that context.  It would be nice to get
-- 
2.52.0


