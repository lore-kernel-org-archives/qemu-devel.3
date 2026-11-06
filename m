Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE84606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MY/zUBsA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPO4-0004gw-RB; Fri, 06 Nov 2026 14:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPPO0-0004fW-Qp
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPPNy-0008Pb-SE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793992441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bO+7bxGbjheJUR1oRPLYlUI89ntRh4QK8cOFPF/9i9g=;
 b=MY/zUBsAB/vwcxC00WN3VzkK0BA42a38gxZXMRnc0MnQGweTX0mTDauSMRB0By6KieIDBw
 5mMjy8IKc04o2BIo/3NldTzRT4EXMhe8kIy0AFi3YUtAf1HCh5iMRNJCJX/X9Na22OR6z7
 MXg5WxpoYOyCoi+TqIq+LIf8UThM9rA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-piVqyUBuNX6ds_HXkvuKlQ-1; Fri,
 06 Nov 2026 14:13:59 -0500
X-MC-Unique: piVqyUBuNX6ds_HXkvuKlQ-1
X-Mimecast-MFC-AGG-ID: piVqyUBuNX6ds_HXkvuKlQ_1793992438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCF00195609F; Fri,  6 Nov 2026 19:13:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76D4A1956045; Fri,  6 Nov 2026 19:13:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2] hw/i386: move bios functions into x86-bios.c
Date: Fri,  6 Nov 2026 14:13:56 -0500
Message-ID: <20261106191356.1207295-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, these functions are located in x86-common.c. However, when
configuring QEMU with `--without-default-devices`, we encounter a
linking error at final assembly time where these functions cannot be
located.

Split these functions out into a new x86-bios.c module to allow
defaultless compilations of x86_64 to succeed.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/i386/x86-bios.c   | 143 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/x86-common.c | 125 -------------------------------------
 hw/i386/x86.c        |   1 -
 hw/i386/meson.build  |   1 +
 4 files changed, 144 insertions(+), 126 deletions(-)
 create mode 100644 hw/i386/x86-bios.c

diff --git a/hw/i386/x86-bios.c b/hw/i386/x86-bios.c
new file mode 100644
index 00000000000..525e42e7252
--- /dev/null
+++ b/hw/i386/x86-bios.c
@@ -0,0 +1,143 @@
+/*
+ * x86 bios loading functions
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2019, 2024-2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/datadir.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+
+#include "hw/core/loader.h"
+#include "hw/i386/x86.h"
+#include "kvm/tdx.h"
+#include "target/i386/sev.h"
+
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only)
+{
+    uint64_t bios_size = memory_region_size(bios);
+    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
+
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, read_only);
+}
+
+static int get_bios_size(X86MachineState *x86ms,
+                         const char *bios_name, char *filename)
+{
+    int bios_size;
+
+    if (filename) {
+        bios_size = get_image_size(filename, NULL);
+    } else {
+        bios_size = -1;
+    }
+    if (bios_size <= 0 ||
+        (bios_size % 65536) != 0) {
+        goto bios_error;
+    }
+
+    return bios_size;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                                char *filename, int bios_size,
+                                bool isapc_ram_fw)
+{
+    ssize_t ret;
+
+    /* BIOS load */
+    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
+        memory_region_init_ram_guest_memfd_private(
+            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
+        if (is_tdx_vm()) {
+            tdx_set_tdvf_region(&x86ms->bios);
+        }
+    } else {
+        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
+                               bios_size, &error_fatal);
+    }
+    if (sev_enabled() || is_tdx_vm()) {
+        /*
+         * The concept of a "reset" simply doesn't exist for
+         * confidential computing guests, we have to destroy and
+         * re-launch them instead.  So there is no need to register
+         * the firmware as rom to properly re-initialize on reset.
+         * Just go for a straight file load instead.
+         */
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+        load_image_size(filename, ptr, bios_size);
+        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+    } else {
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
+        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
+        if (ret != 0) {
+            goto bios_error;
+        }
+    }
+
+    return;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+void x86_bios_rom_reload(X86MachineState *x86ms)
+{
+    int bios_size;
+    const char *bios_name;
+    char *filename;
+
+    if (memory_region_size(&x86ms->bios) == 0) {
+        /* if -bios is not used */
+        return;
+    }
+
+    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+
+    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+    load_image_size(filename, ptr, bios_size);
+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+}
+
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    int bios_size;
+    const char *bios_name;
+    g_autofree char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
+
+    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
+        /* map the last 128KB of the BIOS in ISA space */
+        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                          !isapc_ram_fw);
+    }
+
+    /* map all the bios at the top of memory */
+    memory_region_add_subregion(rom_memory,
+                                (uint32_t)(-bios_size),
+                                &x86ms->bios);
+    return;
+}
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dcd4fa8eb79..350fcbc20e1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -995,128 +995,3 @@ void x86_load_linux(X86MachineState *x86ms,
     option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     nb_option_roms++;
 }
-
-void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
-                       MemoryRegion *bios, bool read_only)
-{
-    uint64_t bios_size = memory_region_size(bios);
-    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
-
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
-                                        isa_bios, 1);
-    memory_region_set_readonly(isa_bios, read_only);
-}
-
-static int get_bios_size(X86MachineState *x86ms,
-                         const char *bios_name, char *filename)
-{
-    int bios_size;
-
-    if (filename) {
-        bios_size = get_image_size(filename, NULL);
-    } else {
-        bios_size = -1;
-    }
-    if (bios_size <= 0 ||
-        (bios_size % 65536) != 0) {
-        goto bios_error;
-    }
-
-    return bios_size;
-
- bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
-}
-
-static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
-                                char *filename, int bios_size,
-                                bool isapc_ram_fw)
-{
-    ssize_t ret;
-
-    /* BIOS load */
-    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd_private(
-            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
-        if (is_tdx_vm()) {
-            tdx_set_tdvf_region(&x86ms->bios);
-        }
-    } else {
-        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
-                               bios_size, &error_fatal);
-    }
-    if (sev_enabled() || is_tdx_vm()) {
-        /*
-         * The concept of a "reset" simply doesn't exist for
-         * confidential computing guests, we have to destroy and
-         * re-launch them instead.  So there is no need to register
-         * the firmware as rom to properly re-initialize on reset.
-         * Just go for a straight file load instead.
-         */
-        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
-        load_image_size(filename, ptr, bios_size);
-        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
-    } else {
-        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
-        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
-        if (ret != 0) {
-            goto bios_error;
-        }
-    }
-
-    return;
-
- bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
-}
-
-void x86_bios_rom_reload(X86MachineState *x86ms)
-{
-    int bios_size;
-    const char *bios_name;
-    char *filename;
-
-    if (memory_region_size(&x86ms->bios) == 0) {
-        /* if -bios is not used */
-        return;
-    }
-
-    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-
-    bios_size = get_bios_size(x86ms, bios_name, filename);
-
-    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
-    load_image_size(filename, ptr, bios_size);
-    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
-}
-
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
-{
-    int bios_size;
-    const char *bios_name;
-    g_autofree char *filename;
-
-    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-
-    bios_size = get_bios_size(x86ms, bios_name, filename);
-    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
-
-    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        /* map the last 128KB of the BIOS in ISA space */
-        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
-                          !isapc_ram_fw);
-    }
-
-    /* map all the bios at the top of memory */
-    memory_region_add_subregion(rom_memory,
-                                (uint32_t)(-bios_size),
-                                &x86ms->bios);
-    return;
-}
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 4b75b7406a8..5f842351daf 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -35,7 +35,6 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/topology.h"
-
 #include "hw/core/nmi.h"
 #include "kvm/kvm_i386.h"
 
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index e16930c4319..6bb73b8731c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -5,6 +5,7 @@ i386_ss.add(files(
   'monitor.c',
   'multiboot.c',
   'x86.c',
+  'x86-bios.c',
   'x86-cpu.c',
 ))
 
-- 
2.56.0


