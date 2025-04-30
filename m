Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839FC369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 05:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9zze-0002AE-Uz; Wed, 30 Apr 2025 01:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzc-00029v-Hz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:24 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zza-0006hh-6q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:24 -0400
Received: (qmail 1694 invoked by uid 484); 30 Apr 2025 05:28:03 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.012884 secs); 30 Apr 2025 05:28:03 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:03 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 04/20] qapi: Introduce MCD schema
Date: Wed, 30 Apr 2025 07:27:25 +0200
Message-Id: <20250430052741.21145-5-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The MCD implementation follows a remote procedure call approach:
Each function from mcd_api.h will correspond to one command in mcd.json.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 MAINTAINERS          |  1 +
 docs/interop/mcd.rst | 13 +++++++++++++
 mcd/meson.build      | 27 +++++++++++++++++++++++++++
 qapi/mcd.json        |  6 ++++++
 4 files changed, 47 insertions(+)
 create mode 100644 qapi/mcd.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 327d3c5..7c085dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3125,6 +3125,7 @@ M: Mario Fleischmann <mario.fleischmann@lauterbach.com>
 S: Maintained
 F: mcd/*
 F: docs/interop/mcd.rst
+F: qapi/mcd.json
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/docs/interop/mcd.rst b/docs/interop/mcd.rst
index 2b21303..13e81df 100644
--- a/docs/interop/mcd.rst
+++ b/docs/interop/mcd.rst
@@ -44,6 +44,19 @@ To configure the build for MCD support:
 
   ./configure --enable-mcd
 
+Debugging via QAPI
+------------------
+
+Since the MCD API does not define a communication protocol, a QAPI schema
+has been added to implement a remote procedure call mechanism.
+Each function within the API corresponds to one QAPI command, ensuring a
+one-to-one mapping between the API's functions and the QAPI commands.
+
+QAPI Reference
+--------------
+
+.. qapi-doc:: qapi/mcd.json
+
 API Reference
 -------------
 
diff --git a/mcd/meson.build b/mcd/meson.build
index 3e4e67a..d62a625 100644
--- a/mcd/meson.build
+++ b/mcd/meson.build
@@ -1,5 +1,32 @@
+mcd_qapi_outputs = [
+  'mcd-qapi-commands.c',
+  'mcd-qapi-commands.h',
+  'mcd-qapi-emit-events.c',
+  'mcd-qapi-emit-events.h',
+  'mcd-qapi-events.c',
+  'mcd-qapi-events.h',
+  'mcd-qapi-features.c',
+  'mcd-qapi-features.h',
+  'mcd-qapi-init-commands.c',
+  'mcd-qapi-init-commands.h',
+  'mcd-qapi-introspect.c',
+  'mcd-qapi-introspect.h',
+  'mcd-qapi-types.c',
+  'mcd-qapi-types.h',
+  'mcd-qapi-visit.c',
+  'mcd-qapi-visit.h',
+]
+
+mcd_qapi_files = custom_target('MCD QAPI files',
+                               output: mcd_qapi_outputs,
+                               input: '../qapi/mcd.json',
+                               command: [ qapi_gen, '-p', 'mcd-', '-o', 'mcd',
+                                          '--suppress-tracing','@INPUT0@'],
+                               depend_files: qapi_gen_depends)
+
 mcd_ss = ss.source_set()
 
+mcd_ss.add(mcd_qapi_files.to_list())
 mcd_ss.add(files(
   'mcd_server.c'))
 
diff --git a/qapi/mcd.json b/qapi/mcd.json
new file mode 100644
index 0000000..701fd03
--- /dev/null
+++ b/qapi/mcd.json
@@ -0,0 +1,6 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = Multi-Core Debug (MCD) API
+##
-- 
2.34.1


