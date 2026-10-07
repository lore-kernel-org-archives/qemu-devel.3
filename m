Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB8CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWUc-000099-QK; Wed, 07 Oct 2026 14:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWUb-00008u-Ep
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWUZ-0001TE-Ix
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791398150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=42nwbVbFZVp7ZJwYSKTuvxo17SK7czq6PzqvwtBM6HI=;
 b=DBNzZA8SKWgY5QN/3smOZ7fZetwfUr47KNubsakkU8X2Iod4YrBIQiVffb8ShLJt6OUz/X
 nG7lv2qdblefhTiPDhxM2keLI4wB107PVaWRxv3wo4UTfGqQ9vGE5iTs21AZsWGB9oOLsi
 yC6KfPLCZ9Z/Ygx3mVvrGGfkkccoBEo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-oSfPbkCtM9KDzdrRK2O8JQ-1; Wed,
 07 Oct 2026 14:35:49 -0400
X-MC-Unique: oSfPbkCtM9KDzdrRK2O8JQ-1
X-Mimecast-MFC-AGG-ID: oSfPbkCtM9KDzdrRK2O8JQ_1791398148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0299F195604E; Wed,  7 Oct 2026 18:35:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D05E230001BE; Wed,  7 Oct 2026 18:35:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH] kvm: shuffle bios loading functions into kvm.c
Date: Wed,  7 Oct 2026 14:35:45 -0400
Message-ID: <20261007183545.1899945-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Currently, these functions are located in kvm-common.c. However, when
configuring QEMU with `--without-default-devices`, we encounter a
linking error at final assembly time where these functions cannot be
located.

As a quick hack, I've moved the functions into kvm.c to allow
defaultless-compilations of x86_64 to succeed. This may not be the
correct or most elegant approach, but it does restore a compilation
feature that was working in v10.0.0 and broken by v11.0.0.

Suggestions?

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/i386/x86-common.c | 125 -----------------------------------------
 hw/i386/x86.c        | 130 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 126 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fa18bf1aece..e07fb6c5f66 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -993,128 +993,3 @@ void x86_load_linux(X86MachineState *x86ms,
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
index f8ba3244e22..077c5e3d3b8 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/qapi-visit-machine.h"
@@ -34,11 +35,138 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/topology.h"
-
+#include "target/i386/sev.h"
 #include "hw/core/nmi.h"
+#include "hw/core/loader.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 
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
+
 void init_topo_info(X86CPUTopoInfo *topo_info,
                     const X86MachineState *x86ms)
 {
-- 
2.55.0


