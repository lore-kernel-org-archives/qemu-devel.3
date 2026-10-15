Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27FACC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWy-0003Mt-Ui; Thu, 15 Oct 2026 07:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWv-000358-ED
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWt-000488-Fe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzlJyDe4zs3886N5xEwtyoKBEt/CgdMwFT2Y2P20zYo=;
 b=XCRDQ9FFofC1Al50MFMN95/ZGFwW8HhKfcU8Alszr8DhnT2ANrSmBVrCjgWfN2rQtsUVDp
 PEzHPrXOfypImpA6Lzx0agY6nP9t0+llMZ9k1FBf4stmffM6rcSBCrryc/NzDTDcwv+/fZ
 4k//QFbwFD8Rm66aZBM18tyUAk11HDQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-JZz9jQJ_Mai0Jf-I2CB70g-1; Thu,
 15 Oct 2026 11:21:43 +0000
X-MC-Unique: JZz9jQJ_Mai0Jf-I2CB70g-1
X-Mimecast-MFC-AGG-ID: JZz9jQJ_Mai0Jf-I2CB70g_1792063302
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1FA1956040; Thu, 15 Oct 2026 11:21:42 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C8181803A40; Thu, 15 Oct 2026 11:21:38 +0000 (UTC)
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
Subject: [PATCH 13/21] system: enable crash dumps on SIGSEGV, SIGILL,
 SIGFPE and SIGABRT
Date: Thu, 15 Oct 2026 12:20:36 +0100
Message-ID: <20261015112044.1999748-14-berrange@redhat.com>
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

Expand the current SIGBUS crash dumps onto further signals that
represent program crashes from bad code or guest OS behaviour.
This change covers Windows platforms too, by using the dummy
siginfo struct definition from osdeup.h.

Note that the signal handler gets unregistered before trying the
crash dump, so in the unlikely event that crash dump itself crashes,
QEMU will exit, rather than getting into a loop.

In a debugger we'll still see the full stack history of the original
flaw, just with one extra frame present for the signal handler.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/signal.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/system/signal.c b/system/signal.c
index 615704900bc..4568ded4cdd 100644
--- a/system/signal.c
+++ b/system/signal.c
@@ -56,11 +56,11 @@ static void sig_handler(int n, siginfo_t *siginfo, void *ctx)
 
     memset(&action, 0, sizeof(action));
     action.sa_handler = SIG_DFL;
-    assert(sigaction(SIGBUS, &action, NULL) == 0);
+    assert(sigaction(siginfo->si_signo, &action, NULL) == 0);
     qtldr_crash_dump_signal(siginfo);
-    raise(SIGBUS);
+    raise(siginfo->si_signo);
     sigemptyset(&set);
-    sigaddset(&set, SIGBUS);
+    sigaddset(&set, siginfo->si_signo);
     pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 }
 
@@ -108,10 +108,13 @@ void qemu_init_crash_signals(void)
      */
     memset(&action, 0, sizeof(action));
     action.sa_flags = SA_SIGINFO | SA_ONSTACK;
+    action.sa_sigaction = sig_handler;
+    sigaction(SIGSEGV, &action, NULL);
+    sigaction(SIGABRT, &action, NULL);
+    sigaction(SIGILL, &action, NULL);
+    sigaction(SIGFPE, &action, NULL);
 #ifdef CONFIG_LINUX
     action.sa_sigaction = sigbus_handler;
-#else
-    action.sa_sigaction = sig_handler;
 #endif
     sigaction(SIGBUS, &action, NULL);
 
@@ -120,7 +123,27 @@ void qemu_init_crash_signals(void)
 #endif
 }
 #else /* !CONFIG_SIGACTION */
+
+static void sig_handler(int signo)
+{
+    siginfo_t si = {
+        .si_signo = signo,
+        .si_code = 0,
+        .si_addr = 0x0,
+    };
+    assert(signal(signo, SIG_DFL) == 0);
+    qtldr_crash_dump_signal(&si);
+    raise(signo);
+}
+
 void qemu_init_crash_signals(void)
 {
+#ifndef WIN32
+    signal(SIGBUS, sig_handler);
+#endif
+    signal(SIGSEGV, sig_handler);
+    signal(SIGABRT, sig_handler);
+    signal(SIGILL, sig_handler);
+    signal(SIGFPE, sig_handler);
 }
 #endif /* !CONFIG_SIGACTION */
-- 
2.56.0


