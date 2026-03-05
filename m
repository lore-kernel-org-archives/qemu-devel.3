Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF34F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCod-0002WA-Ca; Thu, 05 Mar 2026 12:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoW-0002Eg-Gs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoU-0002BQ-BJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAnXty8ojb0QvYCAJwvtMMolNwPYeQ0lJZK1O5DK5TM=;
 b=if8GqEtCi1IDHNKTJxhV4tR3ZyKeXaawpg+3f8Os0n1VvNXYF1ytQF1UzjSWrPwQOLkCMk
 6Q9SBBZHhFYniRO9Ib68en9RuXx6U61hD6nFt6ljVKnQ1Lsc168KsaCMilfmNelDQGXkTH
 yGgDuCAobwDRcmOuKlvkzffr+Ue0cIg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-V4wl-JcLOeGaH4fxp9c7fw-1; Thu,
 05 Mar 2026 12:48:38 -0500
X-MC-Unique: V4wl-JcLOeGaH4fxp9c7fw-1
X-Mimecast-MFC-AGG-ID: V4wl-JcLOeGaH4fxp9c7fw_1772732916
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D48218005BD; Thu,  5 Mar 2026 17:48:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 849941956095; Thu,  5 Mar 2026 17:48:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL 08/27] monitor: initialize global data from a constructor
Date: Thu,  5 Mar 2026 17:47:24 +0000
Message-ID: <20260305174743.3084606-9-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
2.53.0


