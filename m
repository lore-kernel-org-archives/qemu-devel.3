Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5464FD3C920
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUu-0001xr-TW; Sat, 19 Oct 2024 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUr-0001v6-6L
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:09 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUp-0003h0-Az
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:08 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id BAF9E180363
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:58 +0200 (CEST)
Received: (qmail 9755 invoked by uid 990); 19 Oct 2024 16:39:58 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:58 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v2 3/7] contrib/plugins: add plugin showcasing new trap
 related API
Date: Sat, 19 Oct 2024 18:39:36 +0200
Message-ID: <1a2a379011c3636cfc516a3d246566acf14dd44f.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=bLp2Ya8EFnauSsMyOa8SMgEYE21yarlDHCE17UCplxA=;
 b=JheoeNHMF8IN71/x8thC36JxGDHBrOsrvGS/Db9bau+76mkcuTymlMZsX8YjVhL2ywIr6+Lh5X
 73F4cE3M3C5p5ddlYzOb0jrQFOuUD7+eieN5f0uxzHRUjhvW9odyWFpyoTYT+ZcjGRSGRejGT/Vo
 ToBZiFe9Oo51MsqxJN+LG8HSdSZWzQRM5CXenuiTkNgeWDvc4hVK/3ZiHB1NUQI2rGPaLazoRWFA
 pI3cChuM427V38P7mO5MBUYFHHV/ny3Ty2IZJRtJLDvOzrnaMlAsyO4mQDixXyV/Vkgl4I8mhROR
 pL/xc5XTn8Gy++6g3yr5psvgEDJhJxWIi/VHWQFGv7gLThMhFNxwNPg9xkrgsNYlrze0OLaee/Jt
 +YOiVKYbNWnDvzzy+vqttTMZZEpL9y0j7r6ofzK4NjmJrCyF7tUnEUKb9Sww05Tz7fEnOuPbQEyk
 Aey+SMN6wPoKbqwo3IbtfCgGi+qHuAC6FRP7KdoIcJ58T2Piv96onY/y5UaZuSScwTjxnEAR/71G
 1M70O4JPY4cURpwZyyqLpzten2EqlN39ImLlGPn99wCVhLSKl5BK/BwKNuolLpL/17rPYEauGbwd
 AGgLrk/Ik5p9+QfpGmOiUe/B5zBQjlLQyo1/9jZJAqDZUc4jetEk+lgBHanfcrjTpCBfMXOIIoy3
 g=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We recently introduced new plugin API for registration of trap related
callbacks. This change introduces a minimal plugin showcasing the new
API. It simply counts the occurances of interrupts, exceptions and
semihosting events per CPU and reports the counts when exitting.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 contrib/plugins/Makefile |  1 +
 contrib/plugins/traps.c  | 89 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 contrib/plugins/traps.c

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index bbddd4800f..6085fd701f 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -31,6 +31,7 @@ NAMES += drcov
 NAMES += ips
 NAMES += stoptrigger
 NAMES += cflow
+NAMES += traps
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
new file mode 100644
index 0000000000..2a38dbb8b3
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2024, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct {
+    uint64_t interrupts;
+    uint64_t exceptions;
+    uint64_t semihosting;
+    bool active;
+} TrapCounters;
+
+static TrapCounters *traps;
+size_t max_vcpus;
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    traps[vcpu_index].active = true;
+}
+
+static void vcpu_interrupt(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    traps[vcpu_index].interrupts++;
+}
+
+static void vcpu_exception(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    traps[vcpu_index].exceptions++;
+}
+
+static void vcpu_semihosting(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    traps[vcpu_index].semihosting++;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report;
+    report = g_string_new("VCPU, interrupts, exceptions, semihosting\n");
+    int vcpu;
+
+    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
+        TrapCounters *rec = &traps[vcpu];
+        if (rec->active) {
+            g_string_append_printf(report,
+                                   "% 4d, % 10"PRId64", % 10"PRId64", % 10"
+                                   PRId64"\n",
+                                   vcpu,
+                                   rec->interrupts, rec->exceptions,
+                                   rec->semihosting);
+        }
+    }
+
+    qemu_plugin_outs(report->str);
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (!info->system_emulation) {
+        fputs("trap plugin can only be used in system emulation mode.\n",
+              stderr);
+        return -1;
+    }
+
+    max_vcpus = info->system.max_vcpus;
+    traps = calloc(max_vcpus, sizeof(TrapCounters));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_vcpu_for_each(id, vcpu_init);
+
+    qemu_plugin_register_vcpu_interrupt_cb(id, vcpu_interrupt);
+    qemu_plugin_register_vcpu_exception_cb(id, vcpu_exception);
+    qemu_plugin_register_vcpu_semihosting_cb(id, vcpu_semihosting);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
-- 
2.45.2


