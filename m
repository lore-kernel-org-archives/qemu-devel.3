Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB8FE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCz2-0002gz-37; Thu, 19 Dec 2024 04:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCz0-0002gg-V0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCyx-0002Z0-Rc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734601091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SYe3uuRXk8M0Kf8yDrTg25rYrFmfSGIQdTQEV58WCBU=;
 b=F0c+6N+KzudOdn4tBHPENtRPqRUyZhtlHfC5Raaz3AfSgytHjL/ffeMI28rGWHm45LIgKl
 9Twa7Tf5B/AhOJzaWG1S+lh/OoJUfoUYiZvfFFdW9BZv3P+kBY1wDVZvcF2ROBIn6Flfl2
 6pCSXjFrkvyFq1kEaKYeQCyHfWx54Rk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-jfPbKfsJMuSr-InRfqTAuw-1; Thu, 19 Dec 2024 04:38:08 -0500
X-MC-Unique: jfPbKfsJMuSr-InRfqTAuw-1
X-Mimecast-MFC-AGG-ID: jfPbKfsJMuSr-InRfqTAuw
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2166a1a5cc4so6336195ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734601086; x=1735205886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SYe3uuRXk8M0Kf8yDrTg25rYrFmfSGIQdTQEV58WCBU=;
 b=fWt3sYU29ZJPZ5E4sPSXQeRpNq2iTeK01aNjWdcs/vSctc5SFiuNufZ+H+iZvjb+z5
 g8hAG2T3RoGY3dgMesNVSrzvuJkZlriqpwqZVS84iF+w5EpZxs1me5LX1ZReLefE6dZP
 iGRgmDxmnzFz23wtObjeWt+ea7sz4h48XbLp3fPzI0GRotbapgwUkRiQQBRmBLFgzPDR
 3Bal5XzgvpQFCmkMXv+B4dzeSU5JhH5r4FpK3Z1Poe/rI/JpYqcrHC91xWnILWE1a9rV
 7avJ4KOVBOIe16R4XVVouRQXJB3BJ3wspLwjZ0jFM5oP0onOeL5ipif1hFx6Q/nUFETN
 VMMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw7VOqBcGz536gPWRD39b23S3XgKqerkms7BahNYl7EjQiZYUs4fM8bvbLskfkJWLN1CorBakFdww6@nongnu.org
X-Gm-Message-State: AOJu0YxUvIQmek7DdXQQAXJ4tX6/XB8NeLj7QHoqMSu9bERJJix/V6M4
 rGZ5QM4Qdyo93+f6co467xh86zoqghxB0R0M2A2/GiZBDv8kedKm2uIGE5j8M+mv0hAkSHGFg/r
 mNOwrXo+vBAdXq8SCi0Rdjhvwm6gfYPjDcwFp1jo/Ivh4TcIesJaa
X-Gm-Gg: ASbGncuNnfDYRb/1jCeT8ZcWfBwM7K+a6xyk+Ls9+n9erOBSmjZUuIBq9aPLnS/Ad/B
 NusN+Hnkxvbx9YP6s9iklTAXBPAG+CggUxIAJTZtC2BYQ6+v6zfXjnkPIrqqSwrjDRdzKzFHxrl
 gupEy02lXobxueOehHpljYW0l8UoCHyA7k1lh5tjuGWs/1rSBlllfw4V8AJ2bDvpUxTaUQSx0/D
 Pcz4aqirtB/sKLcl8EPOTT1x3/JJJP4bgJZNeE8jiqlrkjlbJ6d8EHOhCCtv1XIZgwBDQ==
X-Received: by 2002:a17:902:b487:b0:216:4499:b836 with SMTP id
 d9443c01a7336-218d70fe05fmr72689695ad.26.1734601086042; 
 Thu, 19 Dec 2024 01:38:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJzaXcCF5ATY+3JVy3KDA9XTBHpPxmuD7nTWHZqTcvY/1IxQKEUavb14klcOof1zqLE4SZkQ==
X-Received: by 2002:a17:902:b487:b0:216:4499:b836 with SMTP id
 d9443c01a7336-218d70fe05fmr72689455ad.26.1734601085642; 
 Thu, 19 Dec 2024 01:38:05 -0800 (PST)
Received: from localhost.localdomain ([116.73.135.226])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f447882a3fsm924764a91.38.2024.12.19.01.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 01:38:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg interface
 support
Date: Thu, 19 Dec 2024 15:07:44 +0530
Message-ID: <20241219093749.15794-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

VM firmware update is a mechanism where the virtual machines can use their
preferred and trusted firmware image in their execution environment without
having to depend on a untrusted party to provide the firmware bundle. This is
particularly useful for confidential virtual machines that are deployed in the
cloud where the tenant and the cloud provider are two different entities. In
this scenario, virtual machines can bring their own trusted firmware image
bundled as a part of their filesystem (using UKIs for example[1]) and then use
this hypervisor interface to update to their trusted firmware image. This also
allows the guests to have a consistent measurements on the firmware image.

This change introduces basic support for the fw-cfg based hypervisor interface
and the corresponding device. The change also includes the
specification document for this interface. The interface is made generic
enough so that guests are free to use their own ABI to pass required
information between initial and trusted execution contexts (where they are
running their own trusted firmware image) without the hypervisor getting
involved in between. In subsequent patches, we will introduce other minimal
changes on the hypervisor that are required to make the mechanism work.

A functional test has been added to test basic device creation and failure mode
in cases where the user tries to create more than one device.

[1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
and https://github.com/systemd/systemd/pull/35281 for some discussions on
how we can bundle firmware image within an UKI.

CC: Alex Graf <graf@amazon.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Gerd Hoffman <kraxel@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                         |   9 ++
 docs/specs/index.rst                |   1 +
 docs/specs/vmfwupdate.rst           | 119 +++++++++++++++++++++
 hw/misc/meson.build                 |   2 +
 hw/misc/vmfwupdate.c                | 155 ++++++++++++++++++++++++++++
 include/hw/misc/vmfwupdate.h        |  95 +++++++++++++++++
 tests/functional/meson.build        |   1 +
 tests/functional/test_vmfwupdate.py |  36 +++++++
 8 files changed, 418 insertions(+)
 create mode 100644 docs/specs/vmfwupdate.rst
 create mode 100644 hw/misc/vmfwupdate.c
 create mode 100644 include/hw/misc/vmfwupdate.h
 create mode 100644 tests/functional/test_vmfwupdate.py

changelogs:
v3: inputs from Gerd and Phil taken into account. One basic functional
test added. Spec doc updated as per Gerd's suggestions.
v2: do not allow changing bios region if advertized size is 0 (non-pc
platforms).

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..cd4135fb5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2531,6 +2531,15 @@ F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
+VM Firmware Update
+M: Ani Sinha <anisinha@redhat.com>
+M: Alex Graf <graf@amazon.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: hw/misc/vmfwupdate.c
+F: include/hw/misc/vmfwupdate.h
+F: docs/specs/vmfwupdate.rst
+
 LED
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index ff5a1f03da..cbda7e0398 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -34,6 +34,7 @@ guest hardware that is specific to QEMU.
    virt-ctlr
    vmcoreinfo
    vmgenid
+   vmfwupdate
    rapl-msr
    rocker
    riscv-iommu
diff --git a/docs/specs/vmfwupdate.rst b/docs/specs/vmfwupdate.rst
new file mode 100644
index 0000000000..fbe8f188c7
--- /dev/null
+++ b/docs/specs/vmfwupdate.rst
@@ -0,0 +1,119 @@
+VMFWUPDATE INTERFACE SPECIFICATION
+##################################
+
+Introduction
+************
+
+``Vmfwupdate`` is an extension to ``fw-cfg`` that allows guests to replace early boot
+code in their virtual machine. Through a combination of vmfwupdate and
+hypervisor stack knowledge, guests can deterministically replace the launch
+payload for guests. This is useful for environments like SEV-SNP where the
+launch payload becomes the launch digest. Guests can use vmfwupdate to provide
+a measured, full guest payload (BIOS image, kernel, initramfs, kernel
+command line) to the virtual machine which enables them to easily reason about
+integrity of the resulting system.
+For more information, please see the `KVM Forum 2024 presentation <KVMFORUM_>`__
+about this work from the authors [1]_.
+
+
+.. _KVMFORUM: https://www.youtube.com/watch?v=VCMBxU6tAto
+
+Base Requirements
+*****************
+
+#. **fw-cfg**:
+     The target system must provide a ``fw-cfg`` interface. For x86 based
+     environments, this ``fw-cfg`` interface must be accessible through PIO ports
+     0x510 and 0x511. The ``fw-cfg`` interface does not need to be announced as part
+     of system device tables such as DSDT. The ``fw-cfg`` interface must support the
+     DMA interface. It may only support the DMA interface for write operations.
+
+#. **BIOS region**:
+     The hypervisor must provide a BIOS region which may be
+     statically sized. Through vmfwupdate, the guest is able to atomically replace
+     its contents. The BIOS region must be mapped as read-write memory. In a
+     SEV-SNP environment, the BIOS region must be mapped as private memory at
+     launch time.
+
+Fw-cfg Files
+************
+
+Guests drive vmfwupdate through special ``fw-cfg`` files that control its flow
+followed by a standard system reset operation. When vmfwupdate is available,
+it provides the following ``fw-cfg`` files:
+
+* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitmap of additional
+  capabilities the interface supports. List of available capabilities:
+
+     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
+
+* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of the BIOS region.
+  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` contains
+  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may resize. Guests are
+  required to read the value after writing and compare it with the requested size
+  to determine whether the resize was successful. Note, x86 BIOS regions always
+  start at 4GiB - bios-size.
+
+* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survives the BIOS replacement
+  flow. Can be used by the guest to propagate guest physical addresses of payloads
+  to its BIOS stage. It’s recommended to make the new BIOS clear this file on boot
+  if it exists. Contents of this file are under control by the hypervisor. In an
+  environment that considers the hypervisor outside of its trust boundary, guests
+  are advised to validate its contents before consumption.
+
+* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is disabled.
+  Returns 0 for enabled, 1 for disabled. Writing any value disables it. Writing is
+  only allowed if the value is 0. When the interface is disabled, the replace file
+  is ignored on reset. This value resets to 0 on system reset.
+
+* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded guest physical address
+  at the beginning of the replacement BIOS region. The provided payload must reside
+  in shared memory. 0 on system reset.
+
+
+Triggering the Firmware Update
+******************************
+
+To initiate the firmware update process, the guest issues a standard system reset
+operation through any of the means implemented by the machine model.
+
+On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is ``1``. If it is, it ignores
+any other vmfwupdate values and performs a standard system reset.
+
+If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if bios-addr is ``0``. If it is, it
+performs a standard system reset.
+
+If ``vmfwupdate/bios-addr`` is ``non-0``, the hypervisor replaces the contents of the system’s
+BIOS region with the guest physically contiguous ``vmfwupdate/bios-size`` sized payload at the
+guest physical address address vmfwupdate/bios-addr.
+
+The firmware update mechanism works both for confidential and non-confidential
+guests. In confidential guests, as a part of the reset operation, all existing
+guest shared memory (shared with the hypervisor) as well as the ``vmfwupdate/opaque`` file
+are preserved. The reset causes recreation of the VM context which triggers a fresh
+measurement of the replaced BIOS region and reset CPU state [2]_ .
+For non-confidential guests, there is no concept of guest private memory and all the existing
+guest memory is preserved (this is the default behavior today - QEMU does not reset/clear
+guest memory upon reset).
+
+In both confidential and non-confidential cases, CPU and device state are reset to
+the default hypervisor specific reset states. In confidential environments, the guest
+always resumes operation in the highest privileged mode available to it (VMPL0 in SEV-SNP).
+
+Closing Remarks
+***************
+The handover protocol (format of the ``vmwupdate/opaque`` file etc.) will be implemented by
+the firmware loader and firmware image, both provided by the guest.  The hypervisor does
+not need to know these details, so it is not included in this specification.
+
+
+
+Footnotes:
+^^^^^^^^^^
+.. [1] Original author of the specification: *Alex Graf <graf@amazon.com>*,
+       converted to re-structured-text (rst format) and slightly edited
+       by *Ani Sinha <anisinha@redhat.com>*.
+.. [2] Currently SEV-SNP guests do not support reset. Upon reset, the instance is
+       terminated and a new instance must be created with new VM confidential context.
+       Work is being done currently to support resetting SEV-SNP guests with a new
+       confidential/SEV context after reset.
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403..4c5bdb0de2 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
+specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdate.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
new file mode 100644
index 0000000000..0e90bd10e1
--- /dev/null
+++ b/hw/misc/vmfwupdate.c
@@ -0,0 +1,155 @@
+/*
+ * Guest driven VM boot component update device
+ * For details and specification, please look at docs/specs/vmfwupdate.rst.
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "sysemu/reset.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/i386/pc.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/vmfwupdate.h"
+#include "qemu/error-report.h"
+
+/* returns NULL unless there is exactly one device */
+static inline VMFwUpdateState *vmfwupdate_find(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_VMFWUPDATE, NULL);
+
+    return o ? VMFWUPDATE(o) : NULL;
+}
+
+static uint64_t get_max_fw_size(void)
+{
+    Object *m_obj = qdev_get_machine();
+    PCMachineState *pcms = PC_MACHINE(m_obj);
+
+    if (pcms) {
+        return pcms->max_fw_size;
+    } else {
+        return 0;
+    }
+}
+
+static void fw_blob_write(void *dev, off_t offset, size_t len)
+{
+    VMFwUpdateState *s = VMFWUPDATE(dev);
+
+    /* for non-pc platform, we do not allow changing bios_size yet */
+    if (!s->plat_bios_size) {
+        return;
+    }
+
+    /*
+     * in order to change the bios size, appropriate capability
+     * must be enabled
+     */
+    if (s->fw_blob.bios_size &&
+        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
+        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not enabled");
+        return;
+    }
+
+    s->plat_bios_size = s->fw_blob.bios_size;
+
+    return;
+}
+
+static void vmfwupdate_realize(DeviceState *dev, Error **errp)
+{
+    VMFwUpdateState *s = VMFWUPDATE(dev);
+    FWCfgState *fw_cfg = fw_cfg_find();
+
+    /* multiple devices are not supported */
+    if (!vmfwupdate_find()) {
+        error_setg(errp, "at most one %s device is permitted",
+                   TYPE_VMFWUPDATE);
+        return;
+    }
+
+    /* fw_cfg with DMA support is necessary to support this device */
+    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
+        error_setg(errp, "%s device requires fw_cfg",
+                   TYPE_VMFWUPDATE);
+        return;
+    }
+
+    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
+    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
+
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
+                             NULL, NULL, s,
+                             &s->opaque_blobs,
+                             sizeof(s->opaque_blobs),
+                             false);
+
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
+                             NULL, fw_blob_write, s,
+                             &s->fw_blob,
+                             sizeof(s->fw_blob),
+                             false);
+
+    /*
+     * Add global capability fw_cfg file. This will be used by the guest to
+     * check capability of the hypervisor.
+     */
+    s->capability = cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_EDKROM);
+    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
+                    &s->capability, sizeof(s->capability));
+
+    s->plat_bios_size = get_max_fw_size(); /* for non-pc, this is 0 */
+    /* size of bios region for the platform - read only by the guest */
+    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
+                    &s->plat_bios_size, sizeof(s->plat_bios_size));
+    /*
+     * add fw cfg control file to disable the hypervisor interface.
+     */
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
+                             NULL, NULL, s,
+                             &s->disable,
+                             sizeof(s->disable),
+                             false);
+    /*
+     * This device requires to register a global reset because it is
+     * not plugged to a bus (which, as its QOM parent, would reset it).
+     */
+    qemu_register_resettable(OBJECT(s));
+}
+
+static Property vmfwupdate_properties[] = {
+    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /* we are not interested in migration - so no need to populate dc->vmsd */
+    dc->desc = "VM firmware blob update device";
+    dc->realize = vmfwupdate_realize;
+    dc->hotpluggable = false;
+    device_class_set_props(dc, vmfwupdate_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vmfwupdate_device_types[] = {
+    {
+        .name          = TYPE_VMFWUPDATE,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(VMFwUpdateState),
+        .class_init    = vmfwupdate_device_class_init,
+    },
+};
+
+DEFINE_TYPES(vmfwupdate_device_types)
diff --git a/include/hw/misc/vmfwupdate.h b/include/hw/misc/vmfwupdate.h
new file mode 100644
index 0000000000..02bb61a6ba
--- /dev/null
+++ b/include/hw/misc/vmfwupdate.h
@@ -0,0 +1,95 @@
+/*
+ * Guest driven VM boot component update device
+ * For details and specification, please look at docs/specs/vmfwupdate.rst.
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef VMFWUPDATE_H
+#define VMFWUPDATE_H
+
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+
+#define TYPE_VMFWUPDATE "vmfwupdate"
+
+#define VMFWUPDCAPMSK  0xffff /* least significant 16 capability bits */
+
+#define VMFWUPDATE_CAP_EDKROM 0x08 /* bit 4 represents support for EDKROM */
+#define VMFWUPDATE_CAP_BIOS_RESIZE 0x04 /* guests may resize bios region */
+#define CAP_VMFWUPD_MASK 0x80
+
+#define VMFWUPDATE_OPAQUE_SIZE (4 * KiB) /* PAGE_SIZE */
+
+/* fw_cfg file definitions */
+#define FILE_VMFWUPDATE_OBLOB "etc/vmfwupdate/opaque-blob"
+#define FILE_VMFWUPDATE_FWBLOB "etc/vmfwupdate/fw-blob"
+#define FILE_VMFWUPDATE_CAP "etc/vmfwupdate/cap"
+#define FILE_VMFWUPDATE_BIOS_SIZE "etc/vmfwupdate/bios-size"
+#define FILE_VMFWUPDATE_CONTROL "etc/vmfwupdate/disable"
+
+/*
+ * Address and length of the guest provided firmware blob.
+ * The blob itself is passed using the guest shared memory to QEMU.
+ * This is then copied to the guest private memeory in the secure vm
+ * by the hypervisor.
+ */
+typedef struct {
+    uint64_t bios_size; /*
+                         * this is used by the guest to update plat_bios_size
+                         * when VMFWUPDATE_CAP_BIOS_RESIZE is set.
+                         */
+    uint64_t bios_paddr; /*
+                          * starting gpa where the blob is in shared guest
+                          * memory. Cleared upon system reset.
+                          */
+} VMFwUpdateFwBlob;
+
+typedef struct VMFwUpdateState {
+    DeviceState parent_obj;
+
+    /*
+     * capabilities - 64 bits.
+     * Little endian format.
+     */
+    uint64_t capability;
+
+    /*
+     * size of the bios region - architecture dependent.
+     * Read-only by the guest unless VMFWUPDATE_CAP_BIOS_RESIZE
+     * capability is set.
+     */
+    uint64_t plat_bios_size;
+
+    /*
+     * disable - disables the interface when non-zero value is written to it.
+     * Writing 0 to this file enables the interface.
+     */
+    uint8_t disable;
+
+    /*
+     * The first stage boot uses this opaque blob to convey to the next stage
+     * where the next stage components are loaded. The exact structure and
+     * number of entries are unknown to the hypervisor and the hypervisor
+     * does not touch this memory or do any validations.
+     * The contents of this memory needs to be validated by the guest and
+     * must be ABI compatible between the first and second stages.
+     */
+    unsigned char opaque_blobs[VMFWUPDATE_OPAQUE_SIZE];
+
+    /*
+     * firmware blob addresses and sizes. These are moved to guest
+     * private memory.
+     */
+    VMFwUpdateFwBlob fw_blob;
+} VMFwUpdateState;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VMFwUpdateState, VMFWUPDATE);
+
+#endif
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 758145d1e5..ac495fd026 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -201,6 +201,7 @@ tests_x86_64_system_quick = [
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
+  'vmfwupdate',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/functional/test_vmfwupdate.py b/tests/functional/test_vmfwupdate.py
new file mode 100644
index 0000000000..4ca203d53f
--- /dev/null
+++ b/tests/functional/test_vmfwupdate.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+#
+# Check for vmfwupdate device.
+#
+# Copyright (c) 2024 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+
+class VmFwUpdateDeviceCheck(QemuSystemTest):
+    # after launch, in order to generate the logs from QEMU we need to
+    # wait for some time. Launching and then immediately shutting down
+    # the VM generates empty logs. A delay of 1 second is added for
+    # this reason.
+    DELAY_Q35_BOOT_SEQUENCE = 1
+
+    def test_multiple_device_fail(self):
+        """
+        Only one vmfwdevice can be instantiated. Ensure failure if
+        user tries to create more than one device.
+        """
+        self.vm.add_args('-device', 'vmfwupdate,id=fwupd1',
+                         '-device', 'vmfwupdate,id=fwupd2')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                         r'at most one vmfwupdate device is permitted')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.42.0


