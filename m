Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8F8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwk-0002Bn-EQ; Fri, 30 May 2025 03:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwP-0001Xh-M0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwN-0006wX-JM
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmk6prxMuzwxBBeoL0Lg4tqN452cN7FNQdjhmOytJ34=;
 b=KI/Lqq7EMa1n++pFqsU2cRI8EqTjJe7gn/k6S/adsLbTnAc9yGEFvK8g2XjnwxaVG4oRuN
 bPwiqDQIRJzeXwykr/kjD6SFbTw9axsPa2ultWkSqAYffd6rEJ103LtmLTqJIi5DYpSerQ
 OeCjoQbjE8T8ya4QMcjHAkjjyZCgi7s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-5MGWEu3-PdOz7qdTEdSdlw-1; Fri, 30 May 2025 03:14:05 -0400
X-MC-Unique: 5MGWEu3-PdOz7qdTEdSdlw-1
X-Mimecast-MFC-AGG-ID: 5MGWEu3-PdOz7qdTEdSdlw_1748589244
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso130621366b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589243; x=1749194043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmk6prxMuzwxBBeoL0Lg4tqN452cN7FNQdjhmOytJ34=;
 b=ejNSW7rxWdd9yBHnS/BplT+Z25Npl0/BLUgt+qFh4WoouaayFlvSFLdQJNUQyharaE
 +QY2HZ1DWe38EzVs1NQSjfVMRjcvqmNxlSipMIdMsUnHMK4QoUy6k0z1CxC9HJB6zvnK
 fQpWmVKmPdSjJldIj265TH96fM3acCC8AdbIwcYXF9eok0cQOMEmGJYuymLPAhuuhLCw
 DL67QAX19iTlIWrOSb89R5DloOND47R7+KpWCdJKE+gICVoYajUYYxOpes9Cjt+2CPzl
 sPF+sZqhNHIN0Nj/H3vHwpz9QnbCFtZfyu2ybNwKqv1cLhg7RunRA6ONKfz+lCAIPZF9
 vCiw==
X-Gm-Message-State: AOJu0YwnbkkVl3QvuRfwsrCKqp/qSFBWSf9IkL7XfIPDJmP8yGtWSwIW
 eHdhF3ZuV4NQdfaHmiqV2bpETNJrLF6awqfzJyuJC0CZGxaSrcwZH6J8u5/F1PJdb7Bx9JAdcjT
 6wSArA32j+Q4MU+PmKEq4ptlBCjjj1yCo6dVm/VSDMHVyC4mV6VZWz3g8IrzZYmAT77Dz4sUtJF
 sn/WYaMn3QxVB9WfBu2Vy8+f4ydoXHJI292wbp4NXZ
X-Gm-Gg: ASbGnct9qNBkwJsFNAzTLQAZ38OrghGmJDoMaYEx/cr9R/86n8WHzVlqNAW0GK3Zevk
 Lacrhv2xbStfFigEfOT0n7GWPlENLfObU0tqv13EhMDVvZzkQipCkXvp4YlJIle9+7HKLofewBM
 UWJ1EBfMUujklxd7G37AS2J6F8wa4kM7cazcoLyaITKKjCU0jW+XYRh6GKOVGFyoIMDuiImcF8D
 wEq8Oka8ofVC3mBsXl9yobeOdY6HA8miXMjb6BR5HNXm5fkKrsYbJD5kZxZCp+MIhW9kr46drXx
 4kPEtaN042qubA==
X-Received: by 2002:a17:906:c108:b0:adb:156e:990b with SMTP id
 a640c23a62f3a-adb3229efffmr194589566b.30.1748589243175; 
 Fri, 30 May 2025 00:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiuNea/+73yo4fL2nmxABppcUbcqUx/4QZrax//9Tdsmq47jMKr+Y1nAAyxg0zGhtqDWZEMQ==
X-Received: by 2002:a17:906:c108:b0:adb:156e:990b with SMTP id
 a640c23a62f3a-adb3229efffmr194586566b.30.1748589242672; 
 Fri, 30 May 2025 00:14:02 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7ff08bsm276895066b.17.2025.05.30.00.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/77] i386/tdvf: Introduce function to parse TDVF metadata
Date: Fri, 30 May 2025 09:11:59 +0200
Message-ID: <20250530071250.2050910-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX VM needs to boot with its specialized firmware, Trusted Domain
Virtual Firmware (TDVF). QEMU needs to parse TDVF and map it in TD
guest memory prior to running the TDX VM.

A TDVF Metadata in TDVF image describes the structure of firmware.
QEMU refers to it to setup memory for TDVF. Introduce function
tdvf_parse_metadata() to parse the metadata from TDVF image and store
the info of each TDVF section.

TDX metadata is located by a TDX metadata offset block, which is a
GUID-ed structure. The data portion of the GUID structure contains
only an 4-byte field that is the offset of TDX metadata to the end
of firmware file.

Select X86_FW_OVMF when TDX is enable to leverage existing functions
to parse and search OVMF's GUID-ed structures.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-18-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/tdvf.h |  38 +++++++++
 hw/i386/tdvf.c         | 188 +++++++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig        |   1 +
 hw/i386/meson.build    |   1 +
 4 files changed, 228 insertions(+)
 create mode 100644 include/hw/i386/tdvf.h
 create mode 100644 hw/i386/tdvf.c

diff --git a/include/hw/i386/tdvf.h b/include/hw/i386/tdvf.h
new file mode 100644
index 00000000000..7ebcac42a36
--- /dev/null
+++ b/include/hw/i386/tdvf.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2025 Intel Corporation
+ * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
+ *                        <isaku.yamahata at intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_I386_TDVF_H
+#define HW_I386_TDVF_H
+
+#include "qemu/osdep.h"
+
+#define TDVF_SECTION_TYPE_BFV               0
+#define TDVF_SECTION_TYPE_CFV               1
+#define TDVF_SECTION_TYPE_TD_HOB            2
+#define TDVF_SECTION_TYPE_TEMP_MEM          3
+
+#define TDVF_SECTION_ATTRIBUTES_MR_EXTEND   (1U << 0)
+#define TDVF_SECTION_ATTRIBUTES_PAGE_AUG    (1U << 1)
+
+typedef struct TdxFirmwareEntry {
+    uint32_t data_offset;
+    uint32_t data_len;
+    uint64_t address;
+    uint64_t size;
+    uint32_t type;
+    uint32_t attributes;
+} TdxFirmwareEntry;
+
+typedef struct TdxFirmware {
+    uint32_t nr_entries;
+    TdxFirmwareEntry *entries;
+} TdxFirmware;
+
+int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size);
+
+#endif /* HW_I386_TDVF_H */
diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
new file mode 100644
index 00000000000..e2d486946a0
--- /dev/null
+++ b/hw/i386/tdvf.c
@@ -0,0 +1,188 @@
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
+
+#include "hw/i386/pc.h"
+#include "hw/i386/tdvf.h"
+#include "system/kvm.h"
+
+#define TDX_METADATA_OFFSET_GUID    "e47a6535-984a-4798-865e-4685a7bf8ec2"
+#define TDX_METADATA_VERSION        1
+#define TDVF_SIGNATURE              0x46564454 /* TDVF as little endian */
+#define TDVF_ALIGNMENT              4096
+
+/*
+ * the raw structs read from TDVF keeps the name convention in
+ * TDVF Design Guide spec.
+ */
+typedef struct {
+    uint32_t DataOffset;
+    uint32_t RawDataSize;
+    uint64_t MemoryAddress;
+    uint64_t MemoryDataSize;
+    uint32_t Type;
+    uint32_t Attributes;
+} TdvfSectionEntry;
+
+typedef struct {
+    uint32_t Signature;
+    uint32_t Length;
+    uint32_t Version;
+    uint32_t NumberOfSectionEntries;
+    TdvfSectionEntry SectionEntries[];
+} TdvfMetadata;
+
+struct tdx_metadata_offset {
+    uint32_t offset;
+};
+
+static TdvfMetadata *tdvf_get_metadata(void *flash_ptr, int size)
+{
+    TdvfMetadata *metadata;
+    uint32_t offset = 0;
+    uint8_t *data;
+
+    if ((uint32_t) size != size) {
+        return NULL;
+    }
+
+    if (pc_system_ovmf_table_find(TDX_METADATA_OFFSET_GUID, &data, NULL)) {
+        offset = size - le32_to_cpu(((struct tdx_metadata_offset *)data)->offset);
+
+        if (offset + sizeof(*metadata) > size) {
+            return NULL;
+        }
+    } else {
+        error_report("Cannot find TDX_METADATA_OFFSET_GUID");
+        return NULL;
+    }
+
+    metadata = flash_ptr + offset;
+
+    /* Finally, verify the signature to determine if this is a TDVF image. */
+    metadata->Signature = le32_to_cpu(metadata->Signature);
+    if (metadata->Signature != TDVF_SIGNATURE) {
+        error_report("Invalid TDVF signature in metadata!");
+        return NULL;
+    }
+
+    /* Sanity check that the TDVF doesn't overlap its own metadata. */
+    metadata->Length = le32_to_cpu(metadata->Length);
+    if (offset + metadata->Length > size) {
+        return NULL;
+    }
+
+    /* Only version 1 is supported/defined. */
+    metadata->Version = le32_to_cpu(metadata->Version);
+    if (metadata->Version != TDX_METADATA_VERSION) {
+        return NULL;
+    }
+
+    return metadata;
+}
+
+static int tdvf_parse_and_check_section_entry(const TdvfSectionEntry *src,
+                                              TdxFirmwareEntry *entry)
+{
+    entry->data_offset = le32_to_cpu(src->DataOffset);
+    entry->data_len = le32_to_cpu(src->RawDataSize);
+    entry->address = le64_to_cpu(src->MemoryAddress);
+    entry->size = le64_to_cpu(src->MemoryDataSize);
+    entry->type = le32_to_cpu(src->Type);
+    entry->attributes = le32_to_cpu(src->Attributes);
+
+    /* sanity check */
+    if (entry->size < entry->data_len) {
+        error_report("Broken metadata RawDataSize 0x%x MemoryDataSize 0x%lx",
+                     entry->data_len, entry->size);
+        return -1;
+    }
+    if (!QEMU_IS_ALIGNED(entry->address, TDVF_ALIGNMENT)) {
+        error_report("MemoryAddress 0x%lx not page aligned", entry->address);
+        return -1;
+    }
+    if (!QEMU_IS_ALIGNED(entry->size, TDVF_ALIGNMENT)) {
+        error_report("MemoryDataSize 0x%lx not page aligned", entry->size);
+        return -1;
+    }
+
+    switch (entry->type) {
+    case TDVF_SECTION_TYPE_BFV:
+    case TDVF_SECTION_TYPE_CFV:
+        /* The sections that must be copied from firmware image to TD memory */
+        if (entry->data_len == 0) {
+            error_report("%d section with RawDataSize == 0", entry->type);
+            return -1;
+        }
+        break;
+    case TDVF_SECTION_TYPE_TD_HOB:
+    case TDVF_SECTION_TYPE_TEMP_MEM:
+        /* The sections that no need to be copied from firmware image */
+        if (entry->data_len != 0) {
+            error_report("%d section with RawDataSize 0x%x != 0",
+                         entry->type, entry->data_len);
+            return -1;
+        }
+        break;
+    default:
+        error_report("TDVF contains unsupported section type %d", entry->type);
+        return -1;
+    }
+
+    return 0;
+}
+
+int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size)
+{
+    g_autofree TdvfSectionEntry *sections = NULL;
+    TdvfMetadata *metadata;
+    ssize_t entries_size;
+    int i;
+
+    metadata = tdvf_get_metadata(flash_ptr, size);
+    if (!metadata) {
+        return -EINVAL;
+    }
+
+    /* load and parse metadata entries */
+    fw->nr_entries = le32_to_cpu(metadata->NumberOfSectionEntries);
+    if (fw->nr_entries < 2) {
+        error_report("Invalid number of fw entries (%u) in TDVF Metadata",
+                     fw->nr_entries);
+        return -EINVAL;
+    }
+
+    entries_size = fw->nr_entries * sizeof(TdvfSectionEntry);
+    if (metadata->Length != sizeof(*metadata) + entries_size) {
+        error_report("TDVF metadata len (0x%x) mismatch, expected (0x%x)",
+                     metadata->Length,
+                     (uint32_t)(sizeof(*metadata) + entries_size));
+        return -EINVAL;
+    }
+
+    fw->entries = g_new(TdxFirmwareEntry, fw->nr_entries);
+    sections = g_new(TdvfSectionEntry, fw->nr_entries);
+
+    memcpy(sections, (void *)metadata + sizeof(*metadata), entries_size);
+
+    for (i = 0; i < fw->nr_entries; i++) {
+        if (tdvf_parse_and_check_section_entry(&sections[i], &fw->entries[i])) {
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    fw->entries = 0;
+    g_free(fw->entries);
+    return -EINVAL;
+}
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index cce9521ba93..eb65bda6e07 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -12,6 +12,7 @@ config SGX
 
 config TDX
     bool
+    select X86_FW_OVMF
     depends on KVM
 
 config PC
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 10bdfde27c6..3bc1da2b6eb 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -32,6 +32,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'port92.c'))
 i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
                                         if_false: files('pc_sysfw_ovmf-stubs.c'))
+i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c'))
 
 subdir('kvm')
 subdir('xen')
-- 
2.49.0


