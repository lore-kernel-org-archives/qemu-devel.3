Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A17E7719A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 15:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU6Ia-00035H-2u; Sat, 04 Jan 2025 10:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IP-00033Y-O3
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:39 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IL-0000s8-BE
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:36 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-216401de828so172762765ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 07:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736005349; x=1736610149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anPqEP/o5V8whbu/QKYSx2ob6vbSxrSVz3CxTowdss0=;
 b=N/ruccn2LUwUT7UUMUge9r3og6fUbkUqEuwxZ2myTH0g4EqOh7hnSexqpWe3TzelIq
 iikXnteF17na70gWSsazYHoMSDu5UMHHI2CPMIgYTre33sVyme2hYBCJIAAVUDRjYhZC
 ux278x0qtaIR98NZByhMjgonTV5utawy4mZ+WH9CFf2cvEkeGA11gQzhgbRu/4T8n7Cz
 HVaVQ1oGVhhr4BYBzf/Rqn1BkN9s4ZMaWq0UUfQXkIGpwSvr2Hx08JQJKrBO/GvBSyVZ
 Am//cYm4z8OkqOo9pCyBYO2SqeDwn3eY417fTqHoQ12turhiMOxKafP8WlBzXTKmfUtJ
 KzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736005349; x=1736610149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anPqEP/o5V8whbu/QKYSx2ob6vbSxrSVz3CxTowdss0=;
 b=MErVJCoF8nbAMGlCXs9d0d6B93ONif3patE1vPS2fEyLq/t9xK3ffUiEywnRvSZSO+
 xkfiSgUVgJgk6s1G3lhdtWKaJALX+Bda48WMIoMHF0nQgdyQOB5xVK3BvPpHg8adBMr6
 +McMYbw9bSO4YrMPsXP7YvxN17DgLIpPkVIC29de0VM4IRiWYbrV/Yjg7NWP4spXeQp/
 7nGc3+KdSsVUBiOm+HmxkPQfoZPUHVWfuICiUzLKX89b+Wg7b4F27AL5zUUUddm2o+sP
 vLlXojGL+ERMs07kUFInqPh92yrzdY7daqRCxgZKwQt3Buj1PtArgWH1e53dzb0psNCR
 o4tQ==
X-Gm-Message-State: AOJu0YxzYtFsbOjAA78SXBzbSrTyxSuFkQB3+r6xCGI/vp1zjZx7Xk1G
 4Nr770sAbJqjsmCV8AXBNv4G9vMO2v6gIo6mTsx2/QqQzzkj56k=
X-Gm-Gg: ASbGncsm3fATfrOJMttrD8hGT4iztOTPxW/BEbZmEiaH0avieY19r0OFntWmliAWx7z
 a9n3c6aPDZd/cYB9towA02lsCiF0TAHLK43UJmmQ/3T1GFf6JAlgbxKdOYG8Og2zsr5Gu0OZCne
 6QqGPt68qhjk8zYG5w7aD0Ge6RUZBMR5jgYJUistgcL+M4S4xcr1h8YJ1i6j+mol6SDnxd0fuMg
 PRxHxj/r86JScXLaocSLKsJpchZSAXm85OrCPIiJs8WjSUcdd5Lg4BVtVNONHyI6IUbQA==
X-Google-Smtp-Source: AGHT+IE2l4TBth+DJ/WoPKR4u8vEJwdKTmO+OtNObmB0FiAYRodCvXOdbwfyoivR6mUUuM1/YSl+cg==
X-Received: by 2002:a05:6a20:2d11:b0:1e1:bd5b:b82a with SMTP id
 adf61e73a8af0-1e5e081c66amr76645506637.40.1736005349275; 
 Sat, 04 Jan 2025 07:42:29 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8162d0sm28113388b3a.12.2025.01.04.07.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 07:42:28 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 1/3] vfio/pci: declare generic quirks in a new header file
Date: Sat,  4 Jan 2025 23:42:16 +0800
Message-ID: <20250104154219.7209-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250104154219.7209-1-tomitamoeko@gmail.com>
References: <20250104154219.7209-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Declare generic vfio_generic_{window_address,window_data,mirror}_quirk
in newly created pci_quirks.h so that they can be used elsewhere, like
igd.c.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 55 +++-------------------------------
 hw/vfio/pci-quirks.h | 71 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 51 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c8e60475d5..2258fdda5f 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -25,6 +25,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
 #include "pci.h"
+#include "pci-quirks.h"
 #include "trace.h"
 
 /*
@@ -66,40 +67,6 @@ bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
  * Device specific region quirks (mostly backdoors to PCI config space)
  */
 
-/*
- * The generic window quirks operate on an address and data register,
- * vfio_generic_window_address_quirk handles the address register and
- * vfio_generic_window_data_quirk handles the data register.  These ops
- * pass reads and writes through to hardware until a value matching the
- * stored address match/mask is written.  When this occurs, the data
- * register access emulated PCI config space for the device rather than
- * passing through accesses.  This enables devices where PCI config space
- * is accessible behind a window register to maintain the virtualization
- * provided through vfio.
- */
-typedef struct VFIOConfigWindowMatch {
-    uint32_t match;
-    uint32_t mask;
-} VFIOConfigWindowMatch;
-
-typedef struct VFIOConfigWindowQuirk {
-    struct VFIOPCIDevice *vdev;
-
-    uint32_t address_val;
-
-    uint32_t address_offset;
-    uint32_t data_offset;
-
-    bool window_enabled;
-    uint8_t bar;
-
-    MemoryRegion *addr_mem;
-    MemoryRegion *data_mem;
-
-    uint32_t nr_matches;
-    VFIOConfigWindowMatch matches[];
-} VFIOConfigWindowQuirk;
-
 static uint64_t vfio_generic_window_quirk_address_read(void *opaque,
                                                        hwaddr addr,
                                                        unsigned size)
@@ -135,7 +102,7 @@ static void vfio_generic_window_quirk_address_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps vfio_generic_window_address_quirk = {
+const MemoryRegionOps vfio_generic_window_address_quirk = {
     .read = vfio_generic_window_quirk_address_read,
     .write = vfio_generic_window_quirk_address_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -178,26 +145,12 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
                       addr + window->data_offset, data, size);
 }
 
-static const MemoryRegionOps vfio_generic_window_data_quirk = {
+const MemoryRegionOps vfio_generic_window_data_quirk = {
     .read = vfio_generic_window_quirk_data_read,
     .write = vfio_generic_window_quirk_data_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-/*
- * The generic mirror quirk handles devices which expose PCI config space
- * through a region within a BAR.  When enabled, reads and writes are
- * redirected through to emulated PCI config space.  XXX if PCI config space
- * used memory regions, this could just be an alias.
- */
-typedef struct VFIOConfigMirrorQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t offset;
-    uint8_t bar;
-    MemoryRegion *mem;
-    uint8_t data[];
-} VFIOConfigMirrorQuirk;
-
 static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
                                                hwaddr addr, unsigned size)
 {
@@ -228,7 +181,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
                                           addr, data);
 }
 
-static const MemoryRegionOps vfio_generic_mirror_quirk = {
+const MemoryRegionOps vfio_generic_mirror_quirk = {
     .read = vfio_generic_quirk_mirror_read,
     .write = vfio_generic_quirk_mirror_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
new file mode 100644
index 0000000000..c0e96a01cc
--- /dev/null
+++ b/hw/vfio/pci-quirks.h
@@ -0,0 +1,71 @@
+/*
+ * vfio generic region quirks (mostly backdoors to PCI config space)
+ *
+ * Copyright Red Hat, Inc. 2012-2015
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
+#define HW_VFIO_VFIO_PCI_QUIRKS_H
+
+#include "qemu/osdep.h"
+#include "exec/memop.h"
+
+/*
+ * The generic window quirks operate on an address and data register,
+ * vfio_generic_window_address_quirk handles the address register and
+ * vfio_generic_window_data_quirk handles the data register.  These ops
+ * pass reads and writes through to hardware until a value matching the
+ * stored address match/mask is written.  When this occurs, the data
+ * register access emulated PCI config space for the device rather than
+ * passing through accesses.  This enables devices where PCI config space
+ * is accessible behind a window register to maintain the virtualization
+ * provided through vfio.
+ */
+typedef struct VFIOConfigWindowMatch {
+    uint32_t match;
+    uint32_t mask;
+} VFIOConfigWindowMatch;
+
+typedef struct VFIOConfigWindowQuirk {
+    struct VFIOPCIDevice *vdev;
+
+    uint32_t address_val;
+
+    uint32_t address_offset;
+    uint32_t data_offset;
+
+    bool window_enabled;
+    uint8_t bar;
+
+    MemoryRegion *addr_mem;
+    MemoryRegion *data_mem;
+
+    uint32_t nr_matches;
+    VFIOConfigWindowMatch matches[];
+} VFIOConfigWindowQuirk;
+
+extern const MemoryRegionOps vfio_generic_window_address_quirk;
+extern const MemoryRegionOps vfio_generic_window_data_quirk;
+
+/*
+ * The generic mirror quirk handles devices which expose PCI config space
+ * through a region within a BAR.  When enabled, reads and writes are
+ * redirected through to emulated PCI config space.  XXX if PCI config space
+ * used memory regions, this could just be an alias.
+ */
+typedef struct VFIOConfigMirrorQuirk {
+    struct VFIOPCIDevice *vdev;
+    uint32_t offset;
+    uint8_t bar;
+    MemoryRegion *mem;
+    uint8_t data[];
+} VFIOConfigMirrorQuirk;
+
+extern const MemoryRegionOps vfio_generic_mirror_quirk;
+
+#endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
-- 
2.45.2


