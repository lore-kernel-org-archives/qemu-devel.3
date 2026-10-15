Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B708CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWp-0002g6-VI; Thu, 15 Oct 2026 07:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWf-0002Yb-3U
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWd-000464-Em
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTnJllB9fustWggRt0G/FCD+pXdMXjfOMHK6D5h8GU4=;
 b=FjvjMv8/DmzJb/kKnivUhc1xhgIO4uHQ4jq58b1rbDn6IBE9rZelnZrjTPx2t/+2XN506L
 qiGyc8Lgb0nvaKNcPfiX6aWDbtigcPf/Oh2w59ZxXYFVJ35zOGjQabeNdrhEB20Z68J17M
 Xf4vKj5g0ssYvtFK7zFMF0xwJ7g0OWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-RtYVXydaNfCnE3YxBIVcRg-1; Thu,
 15 Oct 2026 11:21:27 +0000
X-MC-Unique: RtYVXydaNfCnE3YxBIVcRg-1
X-Mimecast-MFC-AGG-ID: RtYVXydaNfCnE3YxBIVcRg_1792063286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1471D18002E6; Thu, 15 Oct 2026 11:21:26 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 750951800257; Thu, 15 Oct 2026 11:21:22 +0000 (UTC)
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
Subject: [PATCH 09/21] system: trigger TLDR crash dump on unhandled SIGBUS
Date: Thu, 15 Oct 2026 12:20:32 +0100
Message-ID: <20261015112044.1999748-10-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU currently installs a SIGBUS handler which either forwards MCEs
to KVM, or re-raises the SIGBUS. Leave MCE handling untouched, but
wire up other to trigger the TLDR crash dump in the re-raise scenario.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/signal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/signal.c b/system/signal.c
index dc5a75e2816..f667b56255d 100644
--- a/system/signal.c
+++ b/system/signal.c
@@ -27,6 +27,7 @@
 #include "hw/core/cpu.h"
 #include "system/kvm.h"
 #include "qemu/error-report.h"
+#include "qemu/tldr.h"
 
 #ifdef CONFIG_LINUX
 
@@ -48,7 +49,7 @@
 
 
 #ifdef CONFIG_LINUX
-static void sigbus_reraise(void)
+static void sigbus_reraise(siginfo_t *siginfo)
 {
     sigset_t set;
     struct sigaction action;
@@ -56,6 +57,7 @@ static void sigbus_reraise(void)
     memset(&action, 0, sizeof(action));
     action.sa_handler = SIG_DFL;
     if (!sigaction(SIGBUS, &action, NULL)) {
+        qtldr_crash_dump_signal(siginfo);
         raise(SIGBUS);
         sigemptyset(&set);
         sigaddset(&set, SIGBUS);
@@ -69,19 +71,19 @@ static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 {
     if (siginfo->si_code != BUS_MCEERR_AO &&
         siginfo->si_code != BUS_MCEERR_AR) {
-        sigbus_reraise();
+        sigbus_reraise(siginfo);
     }
 
     if (current_cpu) {
         /* Called asynchronously in VCPU thread.  */
         if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
                                siginfo->si_addr)) {
-            sigbus_reraise();
+            sigbus_reraise(siginfo);
         }
     } else {
         /* Called synchronously (via signalfd) in main thread.  */
         if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
-            sigbus_reraise();
+            sigbus_reraise(siginfo);
         }
     }
 }
-- 
2.56.0


