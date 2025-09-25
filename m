Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F32CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iXd-0000q0-Rd; Thu, 25 Sep 2025 05:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXT-0000lw-IB
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXG-0001FB-Pl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcI0f/40UM6S++W5fRjwKPKMY6j7Dg0M4zkV/J73zRo=;
 b=F/93VMFj9eTDK92OCm4FDSQrRZp8XPPIdu3/j2YvnX2zf56QXsQ+1maYZQr2GrubMGWkgC
 YLdaeL+cTSuGzyv+oszk6uxTTUtxmdrbcijuZeJk6gtw//v/bFhdjSAuAsq2uQt9VPGUFo
 pVzdnbOolWek7uENgYlvO8eyLf23IbE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-3rXXKG-zM16ZeMJFCJGGcQ-1; Thu,
 25 Sep 2025 05:45:03 -0400
X-MC-Unique: 3rXXKG-zM16ZeMJFCJGGcQ-1
X-Mimecast-MFC-AGG-ID: 3rXXKG-zM16ZeMJFCJGGcQ_1758793501
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3210C18004D4; Thu, 25 Sep 2025 09:45:01 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C6C330002D0; Thu, 25 Sep 2025 09:44:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 02/23] monitor: initialize global data from a constructor
Date: Thu, 25 Sep 2025 10:44:20 +0100
Message-ID: <20250925094441.1651372-3-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index c5a5d30877..da54e1b1ce 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -704,18 +704,22 @@ void monitor_cleanup(void)
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
2.50.1


