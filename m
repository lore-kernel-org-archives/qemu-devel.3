Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56789CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWK-00025b-7n; Thu, 15 Oct 2026 07:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWG-00023q-Mq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWF-000439-1S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KbgCyTF1uksFvjh6xj1JJtYuBY5wZ7IAXRMhquiwRfY=;
 b=cFMYqkNnRs7VolosPeITwpEUUeNSBTpM+tYQuWYGtSfscLv8LE8weasmBaT6XgO9CXVJZJ
 7wwRtxPuW3W6e4ml/nJhqMaiOVBHfkvMLP5sT1iE6wNTIwsx0dY0tGkjaY0illG6PoBDfD
 HXfKj325vFPrGiGbRBj0OWs6travuPo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-OU8aU9FHMJiheKY3gtNAQQ-1; Thu,
 15 Oct 2026 11:21:04 +0000
X-MC-Unique: OU8aU9FHMJiheKY3gtNAQQ-1
X-Mimecast-MFC-AGG-ID: OU8aU9FHMJiheKY3gtNAQQ_1792063262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F7C61954B17; Thu, 15 Oct 2026 11:21:02 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28DD11800677; Thu, 15 Oct 2026 11:20:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 03/21] system: rename qemu_init_sigbus to
 qemu_init_crash_signals
Date: Thu, 15 Oct 2026 12:20:26 +0100
Message-ID: <20261015112044.1999748-4-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Support for handling further crash signals will be introduced
in subsequent commits, so remove 'sigbus' from the initializer
function name.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/system/signal.h | 2 +-
 system/cpus.c           | 2 +-
 system/signal.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/signal.h b/include/system/signal.h
index f8d00221bcf..bb9b77428b1 100644
--- a/include/system/signal.h
+++ b/include/system/signal.h
@@ -22,4 +22,4 @@
  * THE SOFTWARE.
  */
 
-void qemu_init_sigbus(void);
+void qemu_init_crash_signals(void);
diff --git a/system/cpus.c b/system/cpus.c
index b231ca4c4ac..870d4cfaaa3 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -295,7 +295,7 @@ static QemuCond qemu_pause_cond;
 
 void qemu_init_cpu_loop(void)
 {
-    qemu_init_sigbus();
+    qemu_init_crash_signals();
     qemu_cond_init(&qemu_cpu_cond);
     qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&bql);
diff --git a/system/signal.c b/system/signal.c
index 6d69db2bc79..423325c9a1a 100644
--- a/system/signal.c
+++ b/system/signal.c
@@ -85,7 +85,7 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
     }
 }
 
-void qemu_init_sigbus(void)
+void qemu_init_crash_signals(void)
 {
     struct sigaction action;
 
@@ -101,7 +101,7 @@ void qemu_init_sigbus(void)
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
 }
 #else /* !CONFIG_LINUX */
-void qemu_init_sigbus(void)
+void qemu_init_crash_signals(void)
 {
 }
 #endif /* !CONFIG_LINUX */
-- 
2.56.0


