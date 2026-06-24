Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7579CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZG-00072v-Bk; Wed, 24 Jun 2026 01:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZD-00071X-HQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZA-00064n-8s
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssW03Dn5AeZWkODFXTT7NI4oiMDlz/9jXiRM25HGFig=;
 b=OeOVE6Gg8jEjY5Mir0Aieyneg6QIXulvwjE8/ozizU/AdmjDvN+1wSqIsYPedQH5rtbeUZ
 I/AFAuZuO0+0M5Bc/0Q3+y6KQSN0y36nDhub4u/skUxNz69kfwltGRYwKbub6dDvFJDTA+
 k/rPG5w4T9yqGFjhO82HutzeXcSUDfE=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-uNPHT6eQNBCRhK3Y1BbKmw-1; Wed, 24 Jun 2026 01:54:24 -0400
X-MC-Unique: uNPHT6eQNBCRhK3Y1BbKmw-1
X-Mimecast-MFC-AGG-ID: uNPHT6eQNBCRhK3Y1BbKmw_1782280464
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c03c1dda3so2116695eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280464; x=1782885264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssW03Dn5AeZWkODFXTT7NI4oiMDlz/9jXiRM25HGFig=;
 b=rbxWcjDPAKRu8U/15JV579yi8wu8EeO+V0HNRFo6P3gC0kLLAvszI8NGzc5Zj5GKl/
 7KEelmiGHP8o3ysht73ViPoHJYb3rdhnYAJx/xq+8kwRxAjcbnLtEfUsLHLcWeMqw0t3
 Pe+GAdJqsEpPkvNT5veLml2EfzA2mBe3R/tZV7lJI65SqY/E2L8BDHDkLggynwuH+3je
 mu5U6JKLxR+C+tgTXCH0ppr+ak2xKeaegkIXFtAdICHplTvdW/2WMLxO4pYdpBcXhp1O
 xkbbv08k9ZJd9Wt6XZFxMRJTx0M+deq+mLe2ZHJd6WlM50/lAiKtZ8SB2M+xVEpButrF
 GYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280464; x=1782885264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ssW03Dn5AeZWkODFXTT7NI4oiMDlz/9jXiRM25HGFig=;
 b=n8WY6jGmqHQlyWrk2Rp2XNpx4FIdNYb1g5YFvlkvIXUMu19T2D6FG6KjUI2WmwgZnl
 4u2ctp+83P8+bB/DN0jTBpE03ralthwqqMX8yRMhenx9C8by6Mcnv3yTs3lZf6QCvlWC
 v4BP1EEJ6kizED/fZhzcEHL+erCHnOi0YbbXroPcNmDPOzYfHUno4XKOV/M1RDionOVU
 0+Z/154MBlySlVInv8bf6ZI6W+MbkfW7BgpzqjO7q2BaYx8G+JlIOGtC0Vh9JBK1qy6K
 iVwrRg87VIGQqehkl6iq5fLyEgme2kUz2ujZ7L+L9bKYjx97yoaFsOlf6sVGZS9FqlGT
 lYtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkbHSrk3bY659pB/zQhUN+44W3pQNQ3C8vtwCkkFQDCUhN2+0FG3Ew8nD+bIH01hXAg2vAhHYsCJUe@nongnu.org
X-Gm-Message-State: AOJu0YzCMv7abLQXkd3irBD3J7dvyRyEVdfXfpKSY3oAr18jItvDDGLB
 XPQprajXvwgA9UhRN3+POulMOfYKFS2uZgeu+0tr179pOZZAXH27duh45wknaq6ZLeMJbOrX9xM
 6vXMPi8OnTtXR2wBQ0vxRtschsnkYeJC0fygVsY0VyjOST2wviKt21+l1
X-Gm-Gg: AfdE7ckZ9161A/D5WXJPpCCfxNwP+YuqdOJXJWfiJd7Xk0pb3gTB8Pmh1zALBmxaHf6
 PfOk8STnYMo10/NDCifhBexZ800InNCKhWN3KftDqZ1wXhQIXpyGNtOpqhJC9aCzByJ0tK+BcS9
 4KyOY8yFQ1LrpM8B1g+BRx7CN0PQM0plfAhNAuGPbl+p4aC0LDl1qebroxpV2G21CKd8VxUI78e
 2F8hHXVQCXVd3y4VZQJfx5AUZfwmc8aMsvW5Fr/6lY4wblw+csQb3Rr9fRHK1jAqX0zMaV1wDew
 8HBuZqL3Z2UsUecyFNoLqisyr91aGOFmLA2kPAleQ204sTKEswFzgxbWoZohtLrDPzYarSFaEpt
 HCOXJI9YcXZy/quUgt2isB0jzA6mWp9+sD9hFVpkc/kua
X-Received: by 2002:a05:7300:ac8a:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30c1d5955c6mr13998205eec.0.1782280463486; 
 Tue, 23 Jun 2026 22:54:23 -0700 (PDT)
X-Received: by 2002:a05:7300:ac8a:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30c1d5955c6mr13998192eec.0.1782280462847; 
 Tue, 23 Jun 2026 22:54:22 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex Graf <graf@amazon.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg
 interface support
Date: Wed, 24 Jun 2026 11:23:26 +0530
Message-ID: <20260624055339.46862-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VM launch update is a mechanism where the virtual machines can use IGVM
file bundle to boot into a trusted execution environment without
having to depend on a untrusted party to provide the IGVM bundle or firmware
image. This is particularly useful for confidential virtual machines that
are deployed in the cloud where the tenant and the cloud provider are two
different entities. In this scenario, virtual machines can bring their own
trusted IGVM file containing a trusted firmware image
bundled as a part of their filesystem and then use this hypervisor interface
to update to a trusted and deterministic boot state.
This also allows the guests to have a consistent measurements on the firmware
image.

Currently, this mechanism only works if the VM was started with IGVM in the
first place.

This change introduces support for the fw-cfg based hypervisor interface
and the corresponding device.The change also includes the
specification document for this interface. The interface is made generic
enough so that guests are free to use their own ABI to pass required
information between initial and trusted execution contexts (where they are
running their own trusted boot state) without the hypervisor getting
involved in between.

Currently, this device is only supported for x86 machines. Presence of
IGVM host libraries is also required for parsing IGVM files. Hence, the device
cannot be initialized for other machine types or hosts where IGVM support
is not present. Trying to initialize it for arm for example will lead to failure:

$ ./qemu-system-arm -device vm-launch-update -machine virt
qemu-system-arm: -device vmfwupdate: This machine does not support vm-launch-update device

Functional and qtests will be added in a subsequent patch.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/meson.build              |   3 +
 hw/misc/trace-events             |   5 +
 hw/misc/vmlaunchupdate.c         | 236 +++++++++++++++++++++++++++++++
 include/hw/misc/vmlaunchupdate.h |  85 +++++++++++
 include/system/igvm.h            |   2 +
 5 files changed, 331 insertions(+)
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 include/hw/misc/vmlaunchupdate.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..b8c7de295e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -163,6 +163,9 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
+if igvm.found()
+   specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmlaunchupdate.c'))
+endif
 
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..f440987501 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -417,3 +417,8 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# vmlaunchupdate.c
+launch_update_write(void) ""
+vmlaunch_reset(void) ""
+vm_launchupdate_finalize(void) ""
diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
new file mode 100644
index 0000000000..b19cf6b8cd
--- /dev/null
+++ b/hw/misc/vmlaunchupdate.c
@@ -0,0 +1,236 @@
+/*
+ * Guest driven VM launch component update (using IGVM) device
+ * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "system/physmem.h"
+#include "system/reset.h"
+#include "qemu/target-info-qapi.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/i386/pc.h"
+#include "exec/cpu-common.h"
+#include "hw/misc/vmlaunchupdate.h"
+#include "system/igvm.h"
+#include "system/igvm-internal.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+static bool disabled;
+
+static bool vmlaunchupdate_supported(void)
+{
+    return target_arch() == SYS_EMU_TARGET_X86_64;
+}
+
+static void init_vm_launch_update(VMLaunchUpdateState *s)
+{
+    s->launch_update.capabilities = VM_LAUNCHUPDATE_FORMAT_IGVM;
+
+    if (disabled) {
+        s->launch_update.control = VM_LAUNCHUPDATE_CTL_DISABLE;
+    }
+
+    s->launch_update.version = VM_LAUNCHUPDATE_VERSION;
+    return;
+}
+
+static void clear_init_vm_launch_update(VMLaunchUpdateState *s)
+{
+    memset(&s->launch_update, 0, sizeof(s->launch_update));
+    init_vm_launch_update(s);
+}
+
+static int process_x86_igvm(VMLaunchUpdateState *s,
+                            uint64_t fw_image_addr, uint32_t fw_image_size)
+{
+    X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+    IgvmCfg *igvmc = x86machine->igvm;
+    IgvmHandle igvm;
+    void *image_addr_ptr;
+    hwaddr len;
+
+    if (!igvmc) {
+        /* The VM was not started with an IGVM, bail */
+        info_report("guest was not initially started with IGVM, "
+                    "not chnaging launch state.");
+        return -1;
+    }
+
+    if (!fw_image_addr || !fw_image_size) {
+        return -1;
+    }
+
+    len = (hwaddr) fw_image_size;
+    image_addr_ptr = physical_memory_map((hwaddr) fw_image_addr,
+                                         (hwaddr *) &len, 0);
+
+    if (!image_addr_ptr || (len < fw_image_size)) {
+        warn_report("vmlaunchupdate: Invalid guest addresses.");
+        physical_memory_unmap(image_addr_ptr, len, 0, 0);
+        return -1;
+    }
+
+    igvm = igvm_new_from_binary(image_addr_ptr, fw_image_size);
+    if (igvm < 0) {
+        warn_report("vmlaunchupdate: Unable to parse IGVM file %"
+                    PRIx64 ": %d", fw_image_addr, fw_image_size);
+        return -1;
+    }
+
+    /* free previous file context */
+    if (igvmc->file >= 0) {
+        igvm_free(igvmc->file);
+    }
+    g_free(igvmc->filename);
+    /* set new context */
+    igvmc->file = igvm;
+
+
+    /* free existing memory regions and ram blocks */
+    qigvm_cleanup_memory(igvmc);
+
+    physical_memory_unmap(image_addr_ptr, len, 0, 0);
+    info_report("vmlaunchupdate: new IGVM context set");
+
+    return 0;
+}
+
+static void launch_update_write(void *dev, off_t offset, size_t len)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(dev);
+    uint64_t addr;
+    uint32_t size;
+
+    if (disabled) {
+        return;
+    }
+
+    if (s->launch_update.control & VM_LAUNCHUPDATE_CTL_DISABLE) {
+        disabled = true;
+        return;
+    }
+
+
+    /* process guest provided IGVM image */
+    if (s->launch_update.control & VM_LAUNCHUPDATE_FORMAT_IGVM) {
+        if (target_arch() == SYS_EMU_TARGET_X86_64) {
+            addr = le64_to_cpu(s->launch_update.fw_image_addr);
+            size = le32_to_cpu(s->launch_update.fw_image_size);
+            if (process_x86_igvm(s, addr, size) < 0) {
+                goto end;
+            }
+
+        }
+        /* process other machines here when support is added */
+    }
+
+    /* clear the addresses */
+    s->launch_update.fw_image_addr = 0x0;
+    s->launch_update.fw_image_size = 0x0;
+
+ end:
+    trace_launch_update_write();
+
+    return;
+}
+
+static void launch_update_select(void *dev)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(dev);
+    init_vm_launch_update(s);
+}
+
+static void vmlaunch_reset(Object *obj, ResetType type)
+{
+    trace_vmlaunch_reset();
+}
+
+static ResettableState *vmlaunch_reset_state(Object *obj)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(obj);
+
+    return &s->reset_state;
+}
+
+static void vm_launchupdate_realize(DeviceState *dev, Error **errp)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(dev);
+    FWCfgState *fw_cfg = fw_cfg_find();
+
+    /* multiple devices are not supported */
+    if (!vm_launchupdate_find()) {
+        error_setg(errp, "at most one %s device is permitted",
+                   TYPE_VMLAUNCHUPDATE);
+        return;
+    }
+
+    /* if current machine is not supported, do not initialize */
+    if (!vmlaunchupdate_supported()) {
+        error_setg(errp,
+                   "This machine does not support vm-launch-update device");
+        return;
+    }
+
+    /* fw_cfg with DMA support is necessary to support this device */
+    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
+        error_setg(errp, "%s device requires fw_cfg",
+                   TYPE_VMLAUNCHUPDATE);
+        return;
+    }
+
+    fw_cfg_add_file_callback(fw_cfg, FILE_VMLAUNCHUPDATE,
+                             launch_update_select, launch_update_write, s,
+                             &s->launch_update,
+                             sizeof(s->launch_update),
+                             false);
+
+    clear_init_vm_launch_update(s);
+    /*
+     * This device requires to register a global reset because it is
+     * not plugged to a bus (which, as its QOM parent, would reset it).
+     */
+    qemu_register_resettable(OBJECT(s));
+}
+
+static void vm_launchupdate_finalize(Object *obj)
+{
+    qemu_unregister_resettable(obj);
+    trace_vm_launchupdate_finalize();
+}
+
+static void vmlaunchupdate_device_class_init(ObjectClass *klass,
+                                             const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    /* we are not interested in migration - so no need to populate dc->vmsd */
+    dc->desc = "VM launch state update device";
+    dc->realize = vm_launchupdate_realize;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    rc->phases.hold = vmlaunch_reset;
+    rc->get_state = vmlaunch_reset_state;
+}
+
+static const TypeInfo vmlaunchupdate_device_types[] = {
+    {
+        .name              = TYPE_VMLAUNCHUPDATE,
+        .parent            = TYPE_DEVICE,
+        .instance_size     = sizeof(VMLaunchUpdateState),
+        .class_init        = vmlaunchupdate_device_class_init,
+        .instance_finalize = vm_launchupdate_finalize,
+    },
+};
+
+DEFINE_TYPES(vmlaunchupdate_device_types)
diff --git a/include/hw/misc/vmlaunchupdate.h b/include/hw/misc/vmlaunchupdate.h
new file mode 100644
index 0000000000..1d13f4b176
--- /dev/null
+++ b/include/hw/misc/vmlaunchupdate.h
@@ -0,0 +1,85 @@
+/*
+ * Guest driven VM launch state update device via IGVM.
+ * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+#ifndef VMLAUNCHUPDATE_H
+#define VMLAUNCHUPDATE_H
+
+#include "hw/core/qdev.h"
+#include "qom/object.h"
+#include "qemu/units.h"
+#include "system/igvm-cfg.h"
+
+#define TYPE_VMLAUNCHUPDATE "vm-launch-update"
+
+/* fw-cfg file definition */
+#define FILE_VMLAUNCHUPDATE "etc/vmlaunchupdate"
+
+/* version */
+#define VM_LAUNCHUPDATE_VERSION 0x01
+
+/* format bits, used by both 'capabilities' and 'control'  */
+
+/* igvm */
+#define VM_LAUNCHUPDATE_FORMAT_IGVM           (1ULL << 32)
+
+/* 'control' field bits  */
+
+/* disable vmlaunchupdate interface */
+#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
+
+typedef struct {
+    /* api version */
+    uint16_t version;
+
+    /* VMM capabilities, read-only. */
+    uint64_t capabilities;
+    /* control bits, see VMFWUPDATE_CTL_* */
+    uint64_t control;
+
+    /*
+     * address and size of the IGVM image.  Will be cleared when
+     * the write completes successfully and IGVM file is correctly parsed.
+     */
+    uint64_t fw_image_addr;
+    uint32_t fw_image_size;
+
+    /*
+     * address + size of opaque blob.  The guest can use this to pass on
+     * information, for example which memory region the linux kernel has been
+     * loaded to.  writable, will be kept intact on firmware update.
+     */
+    uint64_t opaque_addr;
+    uint64_t opaque_size;
+
+} VMLaunchUpdate;
+
+typedef struct VMLaunchUpdateState {
+    DeviceState parent_obj;
+    VMLaunchUpdate launch_update;
+    ResettableState reset_state;
+} VMLaunchUpdateState;
+
+
+typedef struct VMLaunchUpdateStateClass {
+    ObjectClass parent_class;
+} VMLaunchUpdateStateClass;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VMLaunchUpdateState, VMLAUNCHUPDATE);
+
+/* returns NULL unless there is exactly one device */
+static inline VMLaunchUpdateState *vm_launchupdate_find(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_VMLAUNCHUPDATE, NULL);
+
+    return o ? VMLAUNCHUPDATE(o) : NULL;
+}
+
+#endif
diff --git a/include/system/igvm.h b/include/system/igvm.h
index e219f1a4ed..e6879550b1 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -22,6 +22,8 @@ int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
                        bool onlyVpContext, Error **errp);
 void qigvm_cleanup_memory(IgvmCfg *igvm);
 
+void qigvm_free_memory_regions(void);
+
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
-- 
2.42.0


