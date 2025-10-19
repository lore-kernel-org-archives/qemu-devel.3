Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8B1CCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV99-0001vz-DX; Sun, 19 Oct 2025 11:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV8w-0001sw-90
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:28 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV8t-00039q-Ja
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:21 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 8184B60A9D
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:18 +0200 (CEST)
Received: (qmail 22776 invoked by uid 990); 19 Oct 2025 15:16:18 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:14 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v8 04/25] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Date: Sun, 19 Oct 2025 17:14:53 +0200
Message-ID: <056b017b5524be30120f3b04eb9dc588d99e7968.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999)
X-Rspamd-Score: -4.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=dqybkAOfRtXHelEez94qnN/FtC5ilBJlP25tPvkm2xI=;
 b=HsyJd9xDmUPdytO11zvB5jz8FHws2pM1kTgUkggUzZKQl1WUtC50NUrg0kxpzdKFq6vSbNV7mu
 T1eO+5pTzAPYVtXLyTitHpWxIeWcyYeWmWqHYUHyhsFgOhiRhjkkJDTQ6txtQYdG/udzDdT/iIKc
 +GK1SbOSQlhlqJrZyCFL97TTzfa/5TA7nemOuYsT+sKwkEZJWbe3OviNollNtuFHTESHc1r4aXt/
 eYBW7pE4EbHHg6C3d+A5LuA2cDJxFPLNUwN0hd3MCP9dCM0VoU4jJql9iKA3hARISccmCzxWL4f+
 nnSqVPoZt1IMg2pLS+I1OPPebbRzXvIQQLUHSMutMfNZFFTuJ9q1IR1fO3f77q7CMjsBVtJK0e50
 zRGY0Ithn6z0OG1JiYK1xfN4pARBiYcjzDEW6KmpZeIOiAsiim9b6hiD8e90Cc4mEoyUPCjo2mp7
 Jb8XtvIbSqTxPhjm3mz3RJL6vvE3kHrhWutRRCOCKR/73V3Wx9p0JWUBvDhmhKIzw7ypdZL4cVLt
 wc7Bv6qGKa4tuxbZESwfYf/FWRtRs30KVvve1wXWm7l/Gy1UIsx+/jpc2XgnDWCeAzIKYcBsZeL5
 51quIPjm7cOV8GjeJJ86j6S9sc68vPT4Jvri4koJ33T/l8yt7xqZU+RYcd0UE3XZ/VU23PVkFlKj
 U=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.184,
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

We recently introduced new plugin API for registration of discontinuity
related callbacks. This change introduces a minimal plugin showcasing
the new API. It simply counts the occurances of interrupts, exceptions
and host calls per CPU and reports the counts when exitting.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 contrib/plugins/meson.build |  2 +-
 contrib/plugins/traps.c     | 83 +++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst    |  8 ++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/traps.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 7eb3629c95..eb944b5159 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,6 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
                    'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'uftrace']
+                   'traps', 'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
new file mode 100644
index 0000000000..d5ddc0f3dd
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,83 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
+ *
+ * Count the number of interrupts (asyncronous events), exceptions (synchronous
+ * events) and host calls (e.g. semihosting) per cpu and report those counts on
+ * exit.
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
+    uint64_t hostcalls;
+} TrapCounters;
+
+static struct qemu_plugin_scoreboard *traps;
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        rec->interrupts++;
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        rec->exceptions++;
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        rec->hostcalls++;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report;
+    report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
+    int max_vcpus = qemu_plugin_num_vcpus();
+    int vcpu;
+
+    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
+        TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu);
+        g_string_append_printf(report,
+                               "% 4d, % 10"PRId64", % 10"PRId64", % 10"PRId64
+                               "\n", vcpu, rec->interrupts, rec->exceptions,
+                               rec->hostcalls);
+    }
+
+    qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(traps);
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (!info->system_emulation) {
+        qemu_plugin_outs("Note: interrupts are only reported in system"
+                         " emulation mode.");
+    }
+
+    traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 8a5e128f67..92c219119e 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1015,6 +1015,14 @@ interesting to generate them around a particular point of execution::
     # generate trace around init execution (2 seconds):
     $ uftrace dump --chrome --time-range=1753122320~1753122322 > init.json
 
+Count traps
+...........
+
+``contrib/plugins/traps.c``
+
+This plugin counts the number of interrupts (asyncronous events), exceptions
+(synchronous events) and host calls (e.g. semihosting) per cpu.
+
 Other emulation features
 ------------------------
 
-- 
2.49.1


