Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A16DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBA-0007sw-Lt; Wed, 10 Sep 2025 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPB8-0007sJ-4O
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPB6-0004fV-AH
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcrB75/R+NNCB4eg5mAoBzqzkku+VwsQ0AwmZXXftUc=;
 b=RPQx6i/p1rRwBv1m9gTh8HyyBgYDpKY73rVYrFNir9TXwfAntpUYfvOezZwVc8czadWMZj
 Z/07I9N/WTCYupBPFPw06QFsDc4wW3ZDaksnIJSu5g5WKqU3WNNgk4hAnaB2Ip2O5yBvwI
 CSq8M2Vk3SKz16V3xnppYNyzVV0Ie/g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-0FwO_hZ3O7qQAH7gXF6dSQ-1; Wed,
 10 Sep 2025 14:04:13 -0400
X-MC-Unique: 0FwO_hZ3O7qQAH7gXF6dSQ-1
X-Mimecast-MFC-AGG-ID: 0FwO_hZ3O7qQAH7gXF6dSQ_1757527452
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3C28180047F; Wed, 10 Sep 2025 18:04:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE4AC1800446; Wed, 10 Sep 2025 18:04:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 02/20] monitor: initialize global data from a constructor
Date: Wed, 10 Sep 2025 19:03:39 +0100
Message-ID: <20250910180357.320297-3-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
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


