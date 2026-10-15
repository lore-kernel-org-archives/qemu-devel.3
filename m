Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE40ACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJX1-0003Vl-Oa; Thu, 15 Oct 2026 07:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWr-0002k4-21
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWp-00047Y-GU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikOWBCnGd0ZSp7V1Io6El/Mrne0pg5RABHu9yG81MyQ=;
 b=fbdyo2HhpHZUnku1oMnRVnhgJoFJg6WVtelXbUPURYwNDGb+34sLz2Pi5YDz0p7FhWcqdn
 Dm52JJGDV/tCH3MF3RyX5zvJMv/qmoXPwARPummIyd1CJA0eA8j952XS+xMZt8w657gOWH
 xbT+cXn5j3i5pBFmkL7TVOplWG8IF8M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-ZXRSdLc8MyeVC86tFGJkKg-1; Thu,
 15 Oct 2026 11:21:39 +0000
X-MC-Unique: ZXRSdLc8MyeVC86tFGJkKg-1
X-Mimecast-MFC-AGG-ID: ZXRSdLc8MyeVC86tFGJkKg_1792063298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7F818007F4; Thu, 15 Oct 2026 11:21:38 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C191C1800677; Thu, 15 Oct 2026 11:21:34 +0000 (UTC)
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
Subject: [PATCH 12/21] system: enable SIGBUS handling on non-Linux platforms
Date: Thu, 15 Oct 2026 12:20:35 +0100
Message-ID: <20261015112044.1999748-13-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The MCE handling code is Linux/KVM specific, however, the handling
of SIGBUS and crash dumps can work on any platform supporting the
sigaction() function. The current function for re-raising SIGBUS
can be used as the sigation handler on non-Linux by just adding
the extra args.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build     |  1 +
 system/signal.c | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index c6207443365..c96c8884f51 100644
--- a/meson.build
+++ b/meson.build
@@ -2648,6 +2648,7 @@ config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: ut
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 config_host_data.set('CONFIG_SIGALTSTACK', cc.has_function('sigaltstack'))
+config_host_data.set('CONFIG_SIGACTION', cc.has_function('sigaction'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
                        cc.has_function('rbd_namespace_exists',
diff --git a/system/signal.c b/system/signal.c
index 88316089fc0..615704900bc 100644
--- a/system/signal.c
+++ b/system/signal.c
@@ -48,8 +48,8 @@
 #endif /* CONFIG_LINUX */
 
 
-#ifdef CONFIG_LINUX
-static void sigbus_reraise(siginfo_t *siginfo)
+#ifdef CONFIG_SIGACTION
+static void sig_handler(int n, siginfo_t *siginfo, void *ctx)
 {
     sigset_t set;
     struct sigaction action;
@@ -64,26 +64,28 @@ static void sigbus_reraise(siginfo_t *siginfo)
     pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 }
 
+#ifdef CONFIG_LINUX
 static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 {
     if (siginfo->si_code != BUS_MCEERR_AO &&
         siginfo->si_code != BUS_MCEERR_AR) {
-        sigbus_reraise(siginfo);
+        sig_handler(n, siginfo, ctx);
     }
 
     if (current_cpu) {
         /* Called asynchronously in VCPU thread.  */
         if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
                                siginfo->si_addr)) {
-            sigbus_reraise(siginfo);
+            sig_handler(n, siginfo, ctx);
         }
     } else {
         /* Called synchronously (via signalfd) in main thread.  */
         if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
-            sigbus_reraise(siginfo);
+            sig_handler(n, siginfo, ctx);
         }
     }
 }
+#endif
 
 void qemu_init_crash_signals(void)
 {
@@ -106,13 +108,19 @@ void qemu_init_crash_signals(void)
      */
     memset(&action, 0, sizeof(action));
     action.sa_flags = SA_SIGINFO | SA_ONSTACK;
+#ifdef CONFIG_LINUX
     action.sa_sigaction = sigbus_handler;
+#else
+    action.sa_sigaction = sig_handler;
+#endif
     sigaction(SIGBUS, &action, NULL);
 
+#ifdef CONFIG_LINUX
     prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
+#endif
 }
-#else /* !CONFIG_LINUX */
+#else /* !CONFIG_SIGACTION */
 void qemu_init_crash_signals(void)
 {
 }
-#endif /* !CONFIG_LINUX */
+#endif /* !CONFIG_SIGACTION */
-- 
2.56.0


