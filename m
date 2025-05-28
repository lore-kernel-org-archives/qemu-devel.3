Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A7EC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZi-0002Us-Lu; Wed, 28 May 2025 14:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZW-0002MJ-Dx
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-00072c-Eh
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yaWA0S0hBaMk0OtNEGRhgMjTbxcQEGn9bR08a4VnM=;
 b=FN0d2/yb2L+ccg8uNm6f3PxEkZ9JpIOPwTQlRU1xMUWlKGhnsxMzPaDBlJPTjFwAW9IJw5
 I+gS7e3ljh9VzCnV+LWP2rpNnY0b1ujv0y0a3BEqwFkbxLJ3igVihQVA8pTMKUAN877OGu
 R/yqlWgZ2AzjHO1lecBBsYnxjg4j/Fg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-_5PbnCr9Oo6yLk7htuZr_A-1; Wed,
 28 May 2025 14:31:59 -0400
X-MC-Unique: _5PbnCr9Oo6yLk7htuZr_A-1
X-Mimecast-MFC-AGG-ID: _5PbnCr9Oo6yLk7htuZr_A_1748457118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7699D1800570; Wed, 28 May 2025 18:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA18F18004A7; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B562221E65EC; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/13] qapi: make s390x specific CPU commands unconditionally
 available
Date: Wed, 28 May 2025 20:31:48 +0200
Message-ID: <20250528183151.2839034-11-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_S390X and CONFIG_KVM conditions from the
CPU commands that are conceptually specific to s390x. Top level
stubs are provided to cope with non-s390x targets, or builds
without KVM.

The removal of CONFIG_KVM is justified by the fact there is no
conceptual difference between running 'qemu-system-s390x -accel tcg'
on a build with and without KVM built-in, so apps only using TCG
can't rely on the CONFIG_KVM in the schema.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-11-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 ...machine-target.json => machine-s390x.json} | 16 +++++---------
 qapi/qapi-schema.json                         |  2 +-
 include/hw/s390x/cpu-topology.h               |  2 +-
 hw/s390x/cpu-topology.c                       |  4 ++--
 stubs/monitor-cpu-s390x-kvm.c                 | 22 +++++++++++++++++++
 tests/qtest/qmp-cmd-test.c                    |  1 +
 qapi/meson.build                              |  2 +-
 stubs/meson.build                             |  1 +
 8 files changed, 35 insertions(+), 15 deletions(-)
 rename qapi/{machine-target.json => machine-s390x.json} (85%)
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c

diff --git a/qapi/machine-target.json b/qapi/machine-s390x.json
similarity index 85%
rename from qapi/machine-target.json
rename to qapi/machine-s390x.json
index f19e34adaf..966dbd61d2 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-s390x.json
@@ -1,6 +1,7 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
 #
+# SPDX-License-Identifier: GPL-2.0-or-later
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
@@ -15,8 +16,7 @@
 # Since: 8.2
 ##
 { 'enum': 'S390CpuPolarization',
-  'data': [ 'horizontal', 'vertical' ],
-  'if': 'TARGET_S390X'
+  'data': [ 'horizontal', 'vertical' ]
 }
 
 ##
@@ -54,8 +54,7 @@
       '*entitlement': 'S390CpuEntitlement',
       '*dedicated': 'bool'
   },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -90,8 +89,7 @@
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
   'data': { 'polarization': 'S390CpuPolarization' },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -104,8 +102,7 @@
 # Since: 8.2
 ##
 { 'struct': 'CpuPolarizationInfo',
-  'data': { 'polarization': 'S390CpuPolarization' },
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'data': { 'polarization': 'S390CpuPolarization' }
 }
 
 ##
@@ -120,6 +117,5 @@
 # Since: 8.2
 ##
 { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
+  'features': [ 'unstable' ]
 }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index d8eb79cfda..a8f66163cb 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -57,7 +57,7 @@
 { 'include': 'qdev.json' }
 { 'include': 'machine-common.json' }
 { 'include': 'machine.json' }
-{ 'include': 'machine-target.json' }
+{ 'include': 'machine-s390x.json' }
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index 9283c948e3..d5e9aa43f8 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -13,7 +13,7 @@
 
 #include "qemu/queue.h"
 #include "hw/boards.h"
-#include "qapi/qapi-types-machine-target.h"
+#include "qapi/qapi-types-machine-s390x.h"
 
 #define S390_TOPOLOGY_CPU_IFL   0x03
 
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index 7d4e1f5472..b513f8936e 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -23,8 +23,8 @@
 #include "target/s390x/cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/cpu-topology.h"
-#include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qapi-events-machine-target.h"
+#include "qapi/qapi-commands-machine-s390x.h"
+#include "qapi/qapi-events-machine-s390x.h"
 
 /*
  * s390_topology is used to keep the topology information.
diff --git a/stubs/monitor-cpu-s390x-kvm.c b/stubs/monitor-cpu-s390x-kvm.c
new file mode 100644
index 0000000000..8683dd2d4c
--- /dev/null
+++ b/stubs/monitor-cpu-s390x-kvm.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine-s390x.h"
+
+void qmp_set_cpu_topology(uint16_t core,
+                          bool has_socket, uint16_t socket,
+                          bool has_book, uint16_t book,
+                          bool has_drawer, uint16_t drawer,
+                          bool has_entitlement, S390CpuEntitlement entitlement,
+                          bool has_dedicated, bool dedicated,
+                          Error **errp)
+{
+    error_setg(errp, "CPU topology change is not supported on this target");
+}
+
+CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp)
+{
+    error_setg(errp, "CPU polarization is not supported on this target");
+    return NULL;
+}
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 15c88248b7..040d042810 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -100,6 +100,7 @@ static bool query_is_ignored(const char *cmd)
         /* Success depends on target arch: */
         "query-cpu-definitions",  /* arm, i386, ppc, s390x */
         "query-gic-capabilities", /* arm */
+        "query-s390x-cpu-polarization", /* s390x */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
         "x-query-virtio",         /* CONFIG_VIRTIO */
diff --git a/qapi/meson.build b/qapi/meson.build
index ffe44f9e0b..e038b636c9 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -39,7 +39,7 @@ qapi_all_modules = [
   'job',
   'machine-common',
   'machine',
-  'machine-target',
+  'machine-s390x',
   'migration',
   'misc',
   'net',
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2fad0824..cef046e685 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('monitor-i386-xen.c'))
   stub_ss.add(files('monitor-cpu.c'))
   stub_ss.add(files('monitor-cpu-s390x.c'))
+  stub_ss.add(files('monitor-cpu-s390x-kvm.c'))
 endif
 
 if have_system or have_user
-- 
2.48.1


