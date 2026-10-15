Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E177FCC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWK-00025g-JA; Thu, 15 Oct 2026 07:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWF-00023n-8F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWC-000432-9f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qlpt+MdO11lcCowkxz4GM0uQ0zXlAJAaoHffBaEqEvw=;
 b=AAeK8ph0IcBEoj0T6zJXKtN09OWN9SVhIBKVtxQPB9kLzaTl9jM4bmvZDu/GGdr47uPT1w
 hDPd2XNEo+KExkWB9ZujscexvlCtVaPQ18oGORVZzrkvWUFX9rmb+foWciZuzFRrRlHif2
 xcSa0ZVcds2kHq+LWtFcujc9tPkSavo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-PfGTlsMXMLqvgF-v3E13ww-1; Thu,
 15 Oct 2026 11:21:00 +0000
X-MC-Unique: PfGTlsMXMLqvgF-v3E13ww-1
X-Mimecast-MFC-AGG-ID: PfGTlsMXMLqvgF-v3E13ww_1792063259
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4AAB1956071; Thu, 15 Oct 2026 11:20:58 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E90881800677; Thu, 15 Oct 2026 11:20:54 +0000 (UTC)
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
Subject: [PATCH 02/21] system: move SIGBUS signal handling to signal.c
Date: Thu, 15 Oct 2026 12:20:25 +0100
Message-ID: <20261015112044.1999748-3-berrange@redhat.com>
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

Introduce a new file 'system/signal.c' to hold the SIGBUS signal
handler, since subsequent commits are going to expand the signal
handling logic somewhat.

The existing copyright header/license boilerplate is retained
instead of a SPDX tag, to respect historic context.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS             |   2 +
 include/system/signal.h |  25 ++++++++++
 system/cpus.c           |  76 +---------------------------
 system/meson.build      |   1 +
 system/signal.c         | 107 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 75 deletions(-)
 create mode 100644 include/system/signal.h
 create mode 100644 system/signal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc60193aa3f..6b5aafe43b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -553,6 +553,7 @@ F: include/exec/target_long.h
 F: include/qemu/accel.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
+F: include/system/signal.h
 F: include/accel/accel-*.h
 F: accel/accel-*.?
 F: accel/dummy-cpus.?
@@ -562,6 +563,7 @@ F: cpu-common.c
 F: cpu-target.c
 F: qapi/accelerator.json
 F: system/cpus.c
+F: system/signal.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
diff --git a/include/system/signal.h b/include/system/signal.h
new file mode 100644
index 00000000000..f8d00221bcf
--- /dev/null
+++ b/include/system/signal.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+void qemu_init_sigbus(void);
diff --git a/system/cpus.c b/system/cpus.c
index e11a5aab6a6..b231ca4c4ac 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -39,28 +39,11 @@
 #include "system/runstate.h"
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
+#include "system/signal.h"
 #include "hw/core/boards.h"
 #include "hw/core/hw-error.h"
 #include "trace.h"
 
-#ifdef CONFIG_LINUX
-
-#include <sys/prctl.h>
-
-#ifndef PR_MCE_KILL
-#define PR_MCE_KILL 33
-#endif
-
-#ifndef PR_MCE_KILL_SET
-#define PR_MCE_KILL_SET 1
-#endif
-
-#ifndef PR_MCE_KILL_EARLY
-#define PR_MCE_KILL_EARLY 1
-#endif
-
-#endif /* CONFIG_LINUX */
-
 /* The Big QEMU Lock (BQL) */
 static QemuMutex bql;
 
@@ -302,63 +285,6 @@ void cpu_handle_guest_debug(CPUState *cpu)
     }
 }
 
-#ifdef CONFIG_LINUX
-static void sigbus_reraise(void)
-{
-    sigset_t set;
-    struct sigaction action;
-
-    memset(&action, 0, sizeof(action));
-    action.sa_handler = SIG_DFL;
-    if (!sigaction(SIGBUS, &action, NULL)) {
-        raise(SIGBUS);
-        sigemptyset(&set);
-        sigaddset(&set, SIGBUS);
-        pthread_sigmask(SIG_UNBLOCK, &set, NULL);
-    }
-    perror("Failed to re-raise SIGBUS!");
-    abort();
-}
-
-static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
-{
-    if (siginfo->si_code != BUS_MCEERR_AO && siginfo->si_code != BUS_MCEERR_AR) {
-        sigbus_reraise();
-    }
-
-    if (current_cpu) {
-        /* Called asynchronously in VCPU thread.  */
-        if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code, siginfo->si_addr)) {
-            sigbus_reraise();
-        }
-    } else {
-        /* Called synchronously (via signalfd) in main thread.  */
-        if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
-            sigbus_reraise();
-        }
-    }
-}
-
-static void qemu_init_sigbus(void)
-{
-    struct sigaction action;
-
-    /*
-     * ALERT: when modifying this, take care that SIGBUS forwarding in
-     * qemu_prealloc_mem() will continue working as expected.
-     */
-    memset(&action, 0, sizeof(action));
-    action.sa_flags = SA_SIGINFO;
-    action.sa_sigaction = sigbus_handler;
-    sigaction(SIGBUS, &action, NULL);
-
-    prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
-}
-#else /* !CONFIG_LINUX */
-static void qemu_init_sigbus(void)
-{
-}
-#endif /* !CONFIG_LINUX */
 
 static QemuThread io_thread;
 
diff --git a/system/meson.build b/system/meson.build
index a6ba7a04f7d..1829de3d25b 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -24,6 +24,7 @@ system_ss.add(files(
   'rtc.c',
   'runstate-action.c',
   'runstate.c',
+  'signal.c',
   'watchpoint.c',
 ))
 
diff --git a/system/signal.c b/system/signal.c
new file mode 100644
index 00000000000..6d69db2bc79
--- /dev/null
+++ b/system/signal.c
@@ -0,0 +1,107 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "system/signal.h"
+#include "hw/core/cpu.h"
+#include "system/kvm.h"
+
+#ifdef CONFIG_LINUX
+
+#include <sys/prctl.h>
+
+#ifndef PR_MCE_KILL
+#define PR_MCE_KILL 33
+#endif
+
+#ifndef PR_MCE_KILL_SET
+#define PR_MCE_KILL_SET 1
+#endif
+
+#ifndef PR_MCE_KILL_EARLY
+#define PR_MCE_KILL_EARLY 1
+#endif
+
+#endif /* CONFIG_LINUX */
+
+
+#ifdef CONFIG_LINUX
+static void sigbus_reraise(void)
+{
+    sigset_t set;
+    struct sigaction action;
+
+    memset(&action, 0, sizeof(action));
+    action.sa_handler = SIG_DFL;
+    if (!sigaction(SIGBUS, &action, NULL)) {
+        raise(SIGBUS);
+        sigemptyset(&set);
+        sigaddset(&set, SIGBUS);
+        pthread_sigmask(SIG_UNBLOCK, &set, NULL);
+    }
+    perror("Failed to re-raise SIGBUS!");
+    abort();
+}
+
+static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
+{
+    if (siginfo->si_code != BUS_MCEERR_AO &&
+        siginfo->si_code != BUS_MCEERR_AR) {
+        sigbus_reraise();
+    }
+
+    if (current_cpu) {
+        /* Called asynchronously in VCPU thread.  */
+        if (kvm_on_sigbus_vcpu(current_cpu, siginfo->si_code,
+                               siginfo->si_addr)) {
+            sigbus_reraise();
+        }
+    } else {
+        /* Called synchronously (via signalfd) in main thread.  */
+        if (kvm_on_sigbus(siginfo->si_code, siginfo->si_addr)) {
+            sigbus_reraise();
+        }
+    }
+}
+
+void qemu_init_sigbus(void)
+{
+    struct sigaction action;
+
+    /*
+     * ALERT: when modifying this, take care that SIGBUS forwarding in
+     * qemu_prealloc_mem() will continue working as expected.
+     */
+    memset(&action, 0, sizeof(action));
+    action.sa_flags = SA_SIGINFO;
+    action.sa_sigaction = sigbus_handler;
+    sigaction(SIGBUS, &action, NULL);
+
+    prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0);
+}
+#else /* !CONFIG_LINUX */
+void qemu_init_sigbus(void)
+{
+}
+#endif /* !CONFIG_LINUX */
-- 
2.56.0


