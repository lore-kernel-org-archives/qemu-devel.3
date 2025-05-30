Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6BDC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyu-0006n6-PD; Fri, 30 May 2025 03:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwf-0002EA-Dh
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwd-0006xx-E3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3W23WX4zCqECxaSrIlcvPj2ZIcIzMpSdkQaRY+GObk=;
 b=Moe1uTLkNUXRw1U4puIXR3tZmDBZZg0BboTMv0oVetO1WSSXvtFD4qj6A/a+eExNY1/35k
 Uj3IHiQ1kB0fX/oJWlGkFtsxEf/43ChTZUmJRGqPGkALWkHactTTCfTLZ38mtvLdIY7ThV
 a+3wzwByxXuzvMbQaLtHqjDIEWmf28U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-CtZdXSL0Ou2ToDH2Lp90sw-1; Fri, 30 May 2025 03:14:21 -0400
X-MC-Unique: CtZdXSL0Ou2ToDH2Lp90sw-1
X-Mimecast-MFC-AGG-ID: CtZdXSL0Ou2ToDH2Lp90sw_1748589260
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso185686166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589259; x=1749194059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3W23WX4zCqECxaSrIlcvPj2ZIcIzMpSdkQaRY+GObk=;
 b=fAaVdGhwrnVl+oo7R/l5KMWnNa22f5GvtdOcm4SRuohWxvGeA8vQSXK/xYP0Qjlylg
 ufwrGEtRWO8FILzwXLswyXlRVvH/6KcvaO/giau+Hl6VYp6n0Krwy/F6ZNZK9BcxWxHO
 YRZIw26XGWe32m+meYslWohdpxCTe6YtKvz3l1QNeCdDC5Sb9rH7Lh+0xF1AtOAUFYxo
 egbQK8wFHjR/P14x/iNZ5KHSBW+T8/ySElVkiUIoZOrUm29ggUYBRJ4F3TcaWyunBEIx
 qpJaR7k7emuDztj1eRGaNgjKmSpOdGkVPKPLVnIelY9t0J3XUv1/mahOIESN4VUPUaJH
 I4JQ==
X-Gm-Message-State: AOJu0YzJzmj4boD0v/ijITWWoBs/9OLkK2OAwefJf+RIXY6wgu+80j6m
 jx+3kHlL/1oZTUSDn2suEuYWdTJQtMMn1iyz2xi/wVqwtcHc1pVi6ulb4L8XGjuahD18qq+5yAl
 HQavsuoE/1vAUabkkKCA8Hi7dfrAn3ILim8AhdNDN/wO+h79RMiWHmq74SzXm97EjLxjDSGBaHE
 0NfKz5IEg1ZFOI+rex7n2oAOAlOOiem258NfDHWKV9
X-Gm-Gg: ASbGnctwhI/K+IcEGNMpUq7BGK7RXNkBxPi3evVzu7Pw/PtJgxLQHeve0Ne8xRBlhn9
 37Xbnz8p1XbTE3D98G8mcIg0MaCqKwtKfIEyNpd7rv9tOR7W//lr65hbiCqhBC1a46u51H0GvyT
 g4M2BPiQN/cL4YIjdPMwwCK5nKr2LgCvzDcwOkXlyR3Je4y0sC/wFHm1msbQ0x50ReTUhBm+dpE
 0P7Pddhl+K3lpcnIZrXVzzFjAtax7DpArYO1vK9OV6bA0CQYF1cX28OTX+kdgv9S1vlW5zGA8dA
 9VTk+DH+8G1JsQ==
X-Received: by 2002:a17:907:2cc2:b0:ad5:3156:2c0c with SMTP id
 a640c23a62f3a-adb322afceamr200569966b.26.1748589259371; 
 Fri, 30 May 2025 00:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9IHqY4YrMKIEQ4V0jRV/apfSVrsvLz5NnRtvP/X6zwDVJgDhHeFTKsHjrqyUq1Z0H0xMNRA==
X-Received: by 2002:a17:907:2cc2:b0:ad5:3156:2c0c with SMTP id
 a640c23a62f3a-adb322afceamr200566666b.26.1748589258848; 
 Fri, 30 May 2025 00:14:18 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6aaf5sm273004166b.183.2025.05.30.00.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 35/77] i386/tdx: Setup the TD HOB list
Date: Fri, 30 May 2025 09:12:05 +0200
Message-ID: <20250530071250.2050910-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The TD HOB list is used to pass the information from VMM to TDVF. The TD
HOB must include PHIT HOB and Resource Descriptor HOB. More details can
be found in TDVF specification and PI specification.

Build the TD HOB in TDX's machine_init_done callback.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-24-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/tdvf-hob.h    |  26 +++++++++
 hw/i386/tdvf-hob.c    | 130 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c |  16 ++++++
 hw/i386/meson.build   |   2 +-
 4 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 hw/i386/tdvf-hob.h
 create mode 100644 hw/i386/tdvf-hob.c

diff --git a/hw/i386/tdvf-hob.h b/hw/i386/tdvf-hob.h
new file mode 100644
index 00000000000..4fc6a3740a5
--- /dev/null
+++ b/hw/i386/tdvf-hob.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HW_I386_TD_HOB_H
+#define HW_I386_TD_HOB_H
+
+#include "hw/i386/tdvf.h"
+#include "target/i386/kvm/tdx.h"
+
+void tdvf_hob_create(TdxGuest *tdx, TdxFirmwareEntry *td_hob);
+
+#define EFI_RESOURCE_ATTRIBUTE_TDVF_PRIVATE     \
+    (EFI_RESOURCE_ATTRIBUTE_PRESENT |           \
+     EFI_RESOURCE_ATTRIBUTE_INITIALIZED |       \
+     EFI_RESOURCE_ATTRIBUTE_TESTED)
+
+#define EFI_RESOURCE_ATTRIBUTE_TDVF_UNACCEPTED  \
+    (EFI_RESOURCE_ATTRIBUTE_PRESENT |           \
+     EFI_RESOURCE_ATTRIBUTE_INITIALIZED |       \
+     EFI_RESOURCE_ATTRIBUTE_TESTED)
+
+#define EFI_RESOURCE_ATTRIBUTE_TDVF_MMIO        \
+    (EFI_RESOURCE_ATTRIBUTE_PRESENT     |       \
+     EFI_RESOURCE_ATTRIBUTE_INITIALIZED |       \
+     EFI_RESOURCE_ATTRIBUTE_UNCACHEABLE)
+
+#endif
diff --git a/hw/i386/tdvf-hob.c b/hw/i386/tdvf-hob.c
new file mode 100644
index 00000000000..782b3d15787
--- /dev/null
+++ b/hw/i386/tdvf-hob.c
@@ -0,0 +1,130 @@
+/*
+ * Copyright (c) 2025 Intel Corporation
+ * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
+ *                        <isaku.yamahata at intel.com>
+ *         Xiaoyao Li <xiaoyao.li@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "standard-headers/uefi/uefi.h"
+#include "hw/pci/pcie_host.h"
+#include "tdvf-hob.h"
+
+typedef struct TdvfHob {
+    hwaddr hob_addr;
+    void *ptr;
+    int size;
+
+    /* working area */
+    void *current;
+    void *end;
+} TdvfHob;
+
+static uint64_t tdvf_current_guest_addr(const TdvfHob *hob)
+{
+    return hob->hob_addr + (hob->current - hob->ptr);
+}
+
+static void tdvf_align(TdvfHob *hob, size_t align)
+{
+    hob->current = QEMU_ALIGN_PTR_UP(hob->current, align);
+}
+
+static void *tdvf_get_area(TdvfHob *hob, uint64_t size)
+{
+    void *ret;
+
+    if (hob->current + size > hob->end) {
+        error_report("TD_HOB overrun, size = 0x%" PRIx64, size);
+        exit(1);
+    }
+
+    ret = hob->current;
+    hob->current += size;
+    tdvf_align(hob, 8);
+    return ret;
+}
+
+static void tdvf_hob_add_memory_resources(TdxGuest *tdx, TdvfHob *hob)
+{
+    EFI_HOB_RESOURCE_DESCRIPTOR *region;
+    EFI_RESOURCE_ATTRIBUTE_TYPE attr;
+    EFI_RESOURCE_TYPE resource_type;
+
+    TdxRamEntry *e;
+    int i;
+
+    for (i = 0; i < tdx->nr_ram_entries; i++) {
+        e = &tdx->ram_entries[i];
+
+        if (e->type == TDX_RAM_UNACCEPTED) {
+            resource_type = EFI_RESOURCE_MEMORY_UNACCEPTED;
+            attr = EFI_RESOURCE_ATTRIBUTE_TDVF_UNACCEPTED;
+        } else if (e->type == TDX_RAM_ADDED) {
+            resource_type = EFI_RESOURCE_SYSTEM_MEMORY;
+            attr = EFI_RESOURCE_ATTRIBUTE_TDVF_PRIVATE;
+        } else {
+            error_report("unknown TDX_RAM_ENTRY type %d", e->type);
+            exit(1);
+        }
+
+        region = tdvf_get_area(hob, sizeof(*region));
+        *region = (EFI_HOB_RESOURCE_DESCRIPTOR) {
+            .Header = {
+                .HobType = EFI_HOB_TYPE_RESOURCE_DESCRIPTOR,
+                .HobLength = cpu_to_le16(sizeof(*region)),
+                .Reserved = cpu_to_le32(0),
+            },
+            .Owner = EFI_HOB_OWNER_ZERO,
+            .ResourceType = cpu_to_le32(resource_type),
+            .ResourceAttribute = cpu_to_le32(attr),
+            .PhysicalStart = cpu_to_le64(e->address),
+            .ResourceLength = cpu_to_le64(e->length),
+        };
+    }
+}
+
+void tdvf_hob_create(TdxGuest *tdx, TdxFirmwareEntry *td_hob)
+{
+    TdvfHob hob = {
+        .hob_addr = td_hob->address,
+        .size = td_hob->size,
+        .ptr = td_hob->mem_ptr,
+
+        .current = td_hob->mem_ptr,
+        .end = td_hob->mem_ptr + td_hob->size,
+    };
+
+    EFI_HOB_GENERIC_HEADER *last_hob;
+    EFI_HOB_HANDOFF_INFO_TABLE *hit;
+
+    /* Note, Efi{Free}Memory{Bottom,Top} are ignored, leave 'em zeroed. */
+    hit = tdvf_get_area(&hob, sizeof(*hit));
+    *hit = (EFI_HOB_HANDOFF_INFO_TABLE) {
+        .Header = {
+            .HobType = EFI_HOB_TYPE_HANDOFF,
+            .HobLength = cpu_to_le16(sizeof(*hit)),
+            .Reserved = cpu_to_le32(0),
+        },
+        .Version = cpu_to_le32(EFI_HOB_HANDOFF_TABLE_VERSION),
+        .BootMode = cpu_to_le32(0),
+        .EfiMemoryTop = cpu_to_le64(0),
+        .EfiMemoryBottom = cpu_to_le64(0),
+        .EfiFreeMemoryTop = cpu_to_le64(0),
+        .EfiFreeMemoryBottom = cpu_to_le64(0),
+        .EfiEndOfHobList = cpu_to_le64(0), /* initialized later */
+    };
+
+    tdvf_hob_add_memory_resources(tdx, &hob);
+
+    last_hob = tdvf_get_area(&hob, sizeof(*last_hob));
+    *last_hob =  (EFI_HOB_GENERIC_HEADER) {
+        .HobType = EFI_HOB_TYPE_END_OF_HOB_LIST,
+        .HobLength = cpu_to_le16(sizeof(*last_hob)),
+        .Reserved = cpu_to_le32(0),
+    };
+    hit->EfiEndOfHobList = tdvf_current_guest_addr(&hob);
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e06f5d0bd43..e20ffee9550 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -21,6 +21,7 @@
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
+#include "hw/i386/tdvf-hob.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 
@@ -147,6 +148,19 @@ void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
     tdx_guest->tdvf_mr = tdvf_mr;
 }
 
+static TdxFirmwareEntry *tdx_get_hob_entry(TdxGuest *tdx)
+{
+    TdxFirmwareEntry *entry;
+
+    for_each_tdx_fw_entry(&tdx->tdvf, entry) {
+        if (entry->type == TDVF_SECTION_TYPE_TD_HOB) {
+            return entry;
+        }
+    }
+    error_report("TDVF metadata doesn't specify TD_HOB location.");
+    exit(1);
+}
+
 static void tdx_add_ram_entry(uint64_t address, uint64_t length,
                               enum TdxRamType type)
 {
@@ -281,6 +295,8 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 
     qsort(tdx_guest->ram_entries, tdx_guest->nr_ram_entries,
           sizeof(TdxRamEntry), &tdx_ram_entry_compare);
+
+    tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
 }
 
 static Notifier tdx_machine_done_notify = {
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 3bc1da2b6eb..7896f348cff 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -32,7 +32,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'port92.c'))
 i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
                                         if_false: files('pc_sysfw_ovmf-stubs.c'))
-i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c'))
+i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c', 'tdvf-hob.c'))
 
 subdir('kvm')
 subdir('xen')
-- 
2.49.0


