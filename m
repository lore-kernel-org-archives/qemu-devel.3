Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626E3CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWM-00027Z-Me; Thu, 15 Oct 2026 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWL-00026H-NB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWJ-00043i-Tt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcE4vzjSzMZVA3M8g7QAKl6n6d9Iw1O4wO/Zs3KKo1U=;
 b=Vo5G2VhelwJifv47oyg+LOQOZRWEUkMEFcdxF3mGzj927Z7tqMgorQl3OCLk2/S+VUHKVC
 Vo+qmDhZrCKYWo2f9twJUo0kS9XZWopOm3NXSXnBzZeIPDy1usPm6KOX32tDs/QRhBKn4e
 nwIISePmoP/UJ4kCy8c6EoRiSwcjc10=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-a_HvIE3oPJyUZf2cEmYI0Q-1; Thu,
 15 Oct 2026 11:21:08 +0000
X-MC-Unique: a_HvIE3oPJyUZf2cEmYI0Q-1
X-Mimecast-MFC-AGG-ID: a_HvIE3oPJyUZf2cEmYI0Q_1792063266
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4C5A1956040; Thu, 15 Oct 2026 11:21:06 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 082341800257; Thu, 15 Oct 2026 11:21:02 +0000 (UTC)
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
Subject: [PATCH 04/21] system: run SIGBUS handler on alternate signal stack
Date: Thu, 15 Oct 2026 12:20:27 +0100
Message-ID: <20261015112044.1999748-5-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

In preparation for introducing data recorder dumps during handling of
of crash signals (BUS, SEGV, ILL, FPE, ABRT), introduce an alternative
signal stack. This gives a known safe stack for code to operate under.

This adds overhead of SIGSTKSZ bytes, which is OS-dependent, but on
Linux is 8kb.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build     |  1 +
 system/signal.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 255c887e8e6..b383c7fceef 100644
--- a/meson.build
+++ b/meson.build
@@ -2647,6 +2647,7 @@ config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
+config_host_data.set('CONFIG_SIGALTSTACK', cc.has_function('sigaltstack'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
                        cc.has_function('rbd_namespace_exists',
diff --git a/system/signal.c b/system/signal.c
index 423325c9a1a..dc5a75e2816 100644
--- a/system/signal.c
+++ b/system/signal.c
@@ -26,6 +26,7 @@
 #include "system/signal.h"
 #include "hw/core/cpu.h"
 #include "system/kvm.h"
+#include "qemu/error-report.h"
 
 #ifdef CONFIG_LINUX
 
@@ -89,12 +90,23 @@ void qemu_init_crash_signals(void)
 {
     struct sigaction action;
 
+#ifdef CONFIG_SIGALTSTACK
+    static stack_t signal_stack;
+    signal_stack.ss_sp = (void *)g_new0(char, SIGSTKSZ);
+    signal_stack.ss_size = SIGSTKSZ;
+    if (sigaltstack(&signal_stack, NULL) < 0) {
+        error_printf("unable to enable alternate signal stack: %s",
+                     strerror(errno));
+        abort();
+    }
+#endif
+
     /*
      * ALERT: when modifying this, take care that SIGBUS forwarding in
      * qemu_prealloc_mem() will continue working as expected.
      */
     memset(&action, 0, sizeof(action));
-    action.sa_flags = SA_SIGINFO;
+    action.sa_flags = SA_SIGINFO | SA_ONSTACK;
     action.sa_sigaction = sigbus_handler;
     sigaction(SIGBUS, &action, NULL);
 
-- 
2.56.0


