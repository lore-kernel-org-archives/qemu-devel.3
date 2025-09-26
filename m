Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 11:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v26BZ-0007II-8S; Fri, 26 Sep 2025 07:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26BS-0007Dp-2b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v26B9-0007Ro-Pz
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758884375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/gtmZh0zr1s60tL23O40RB0ztD5L1nJW5OpDcx0GCc=;
 b=MwiDcFaJi9Ln/65evOVUIT1Gmrc2chNmeIZ5LgiqM5oOGGkJXOR6yNA+mb23XQ7vK+xIvz
 7vuYdLjOR2MxJtCXy42yPx+iWRwbUzJcaiC/2nHkrfH+yq7w7icr2DaPy6kG+fVu/kB40Q
 tUYnjq18DbScKT1xwurmgT/hO0MdevY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-PiKwRgdjMy-tGzv3BpK6Tw-1; Fri,
 26 Sep 2025 06:59:34 -0400
X-MC-Unique: PiKwRgdjMy-tGzv3BpK6Tw-1
X-Mimecast-MFC-AGG-ID: PiKwRgdjMy-tGzv3BpK6Tw_1758884373
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 261E2180057A; Fri, 26 Sep 2025 10:59:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B70180035E; Fri, 26 Sep 2025 10:59:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 221D9180060B; Fri, 26 Sep 2025 12:59:27 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/4] igvm: add support for igvm memory map parameter in
 native mode
Date: Fri, 26 Sep 2025 12:59:24 +0200
Message-ID: <20250926105926.121890-3-kraxel@redhat.com>
In-Reply-To: <20250926105926.121890-1-kraxel@redhat.com>
References: <20250926105926.121890-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add and wire up qigvm_x86_get_mem_map_entry function which converts the
e820 table into an igvm memory map parameter.  This makes igvm files for
the native (non-confidential) platform with memory map parameter work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm.h   |  5 +++++
 backends/igvm.c         | 24 +++++++++++++++++----
 stubs/igvm.c            | 21 +++++++++++++++++++
 target/i386/igvm.c      | 46 +++++++++++++++++++++++++++++++++++++++++
 stubs/meson.build       |  1 +
 target/i386/meson.build |  3 +++
 6 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

diff --git a/include/system/igvm.h b/include/system/igvm.h
index a4abab043a1f..3f72a40b8897 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -19,4 +19,9 @@
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
                       bool onlyVpContext, Error **errp);
 
+/* x86 native */
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp);
+
 #endif
diff --git a/backends/igvm.c b/backends/igvm.c
index 723d45b755a0..40b60f8cb48f 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/target-info.h"
 #include "system/igvm.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
@@ -20,6 +21,12 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+/* temporary stopgap until this lands in target-info.h */
+static bool target_x86_64(void)
+{
+    return strcmp(target_name(), "x86_64") == 0;
+}
+
 typedef struct QIgvmParameterData {
     QTAILQ_ENTRY(QIgvmParameterData) next;
     uint8_t *data;
@@ -543,6 +550,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                                       Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp) = NULL;
     QIgvmParameterData *param_entry;
     int max_entry_count;
     int entry = 0;
@@ -550,7 +559,15 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     ConfidentialGuestMemoryMapEntry cgmm_entry;
     int retval = 0;
 
-    if (!ctx->cgs) {
+    if (ctx->cgs && ctx->cgsc->get_mem_map_entry) {
+        get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
+    }
+
+    if (!get_mem_map_entry && target_x86_64()) {
+        get_mem_map_entry = qigvm_x86_get_mem_map_entry;
+    }
+
+    if (!get_mem_map_entry) {
         error_setg(errp,
                    "IGVM file contains a memory map but this is not supported "
                    "by the current system.");
@@ -565,7 +582,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                 param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
             mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
 
-            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
+            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
             while (retval == 0) {
                 if (entry > max_entry_count) {
                     error_setg(
@@ -598,8 +615,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                         IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
                     break;
                 }
-                retval =
-                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
+                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
             }
             if (retval < 0) {
                 return retval;
diff --git a/stubs/igvm.c b/stubs/igvm.c
new file mode 100644
index 000000000000..c32058eb2a6e
--- /dev/null
+++ b/stubs/igvm.c
@@ -0,0 +1,21 @@
+/*
+ * QEMU IGVM, stubs
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "system/igvm.h"
+
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
new file mode 100644
index 000000000000..2ed6cd052c79
--- /dev/null
+++ b/target/i386/igvm.c
@@ -0,0 +1,46 @@
+/*
+ * QEMU IGVM, support for native x86 guests
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/i386/e820_memory_layout.h"
+#include "system/igvm.h"
+
+/*
+ * convert e820 table into igvm memory map
+ */
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp)
+{
+    struct e820_entry *table;
+    int num_entries;
+
+    num_entries = e820_get_table(&table);
+    if ((index < 0) || (index >= num_entries)) {
+        return 1;
+    }
+    entry->gpa = table[index].address;
+    entry->size = table[index].length;
+    switch (table[index].type) {
+    case E820_RAM:
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    default:
+        /* should not happen */
+        error_setg(errp, "unknown e820 type");
+        return -1;
+    }
+    return 0;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e6854d..b362b2472373 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -73,6 +73,7 @@ if have_system
   stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
+  stub_ss.add(files('igvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 092af34e2d85..da2d5d80792b 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -25,6 +25,9 @@ i386_system_ss.add(files(
 ))
 i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
                                        if_false: files('sev-system-stub.c'))
+if igvm.found()
+  i386_system_ss.add(files('igvm.c'))
+endif
 
 i386_user_ss = ss.source_set()
 
-- 
2.51.0


