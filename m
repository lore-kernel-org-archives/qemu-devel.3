Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DC1C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKxo-0008Bf-6C; Thu, 30 Jul 2026 03:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxc-0008Ah-K2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxZ-0007vt-Jr
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WReTeiiJs2HYXaYNe0ke+DS6dgyUwvWVr/vfh1MrFw=;
 b=fdBMR9cLwuEF34v2+ikXyoSxFpHbgVsSkY+/xTrsASyMDBCSkHrQOCf2NqYMKHmhOdQ8IP
 5MHvpqXcX3MsU88j5SP7rhC8tprbKCCnG9RVlaFOSdmdFM0hS7E+0HCSpxsWh4r1R81DYH
 a6xFOZrhsj5naMkgWRi+J10ibKlU8wM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-5JIZEPGCMPalF7EeBa5vDg-1; Thu, 30 Jul 2026 03:13:38 -0400
X-MC-Unique: 5JIZEPGCMPalF7EeBa5vDg-1
X-Mimecast-MFC-AGG-ID: 5JIZEPGCMPalF7EeBa5vDg_1785395617
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so11821285ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395617; x=1786000417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4WReTeiiJs2HYXaYNe0ke+DS6dgyUwvWVr/vfh1MrFw=;
 b=Lc/NyfhPFMJIB9+X514EnAHXfhDwsGa9I28BMO3cFJF3MVDhXL2Ks9RXfiwSN2v5uX
 ogSXqh/jy89BBUq/dpL/YCK7gLptT8b0wU8az60s0vN6stk15hZc/8Rqcx8VGBaKeueb
 tuV2YN19TFbbeG/o/edtWF8N4iYt9YH1EtdG+sZ9uONC2j4JiGjM1+nz6eElrpIZezSZ
 CikJnuIbwhBrCUo5enMizdboQUwim3e7GJQPccsRS7lXf13tuaJqsSuokQWnKeYr4pKi
 5kCpNIEGh2NTbHJ9SHf2tT0tC799aTZZAHfwmT/Lrqi5p3XKm03o3e+b9fP9T2YuLqfY
 druA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395617; x=1786000417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4WReTeiiJs2HYXaYNe0ke+DS6dgyUwvWVr/vfh1MrFw=;
 b=MjQhzoWTsBCsXMQ6va6QR1SBPW1r9okzRcSbi0rKCtnn4VjmNw0nZBgyb4BEbPTuYk
 5Q3BcnN753FG327obl1VL3Jt9xdr0wCHTHid3+LpaDttLLsxi4fWTGnVLdcAMt4UdXy6
 vyFRr1i67EIByrakLKwF6LWo980r5tygx1zIOTQtMVVNv5R2+SIGAWBNgPisMUMJmr4d
 mZ5S4Sa5uQabc8tcHLp5TTXYVRx4T59hItfBI3c1rPunUwCKUtgRDNUL5ijpLY80QQyM
 Wpssbfa+aslguExsb8SViTR1f5ZD202FiYOfEA1dRPqPcB118il4s1el9Gk3VCGWzKDq
 GNvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvZXfMEA3lmRaxh4SmvoqX9+qUXHsDWo3OIEobi1JaJPcL1Gz77e4hFwLNN7k6noWBDpQXxrpwIcyD@nongnu.org
X-Gm-Message-State: AOJu0YxaE3ciHz2ELeXkwTY19Cyv67pUvVBEXiYW3Z2Im2aBCdq1raC1
 f45BaL3U7YucmR34zeq1mzdMY3sIh3pHEpRuKsbMoUE2NvoOpFlAO2uvayJt/0lP5imleJQYK4J
 92J0YSbyHacJxazYtgm6clO3klr3Run1e3lepSGiKIPYIQbp0cF1qAyvU
X-Gm-Gg: AR+sD111lsn6467AR+KH6EiefY+iYlpW1ww202SzNfLtp7Aj74RdAwdgIlyZOpGt0VR
 qmPQfEPkak2yAuYcYDDuYvZYcBhpkY+z5jOJzKT1Za8KpwuE/L7xo1QZmKSLsIRMttRpHa1Gyxa
 IWo9Xv/7lAz0KFPWo+OFiA5mCECtt3GteavRDR9S2xnwsPjxN31VOj9zsXw3vMe+j5h3HKHZa4X
 j1cYPaC/GRUQJVr8I7ZwH8LJkk3adSeBW/ezjuxLVLcBm+AilrRplM+IFT9t+KQKZvlm7vJ50/1
 IkyHjlPe/6MR4pIf3NHjqn1x1L38ftcM9wP6Sl2W7Ukr/fFktNVmPidVfHctBYiidbczTB4gyDw
 fB0nQhZanBTzupdaj7nXVsxkGhyaZzrjGYW8=
X-Received: by 2002:a17:902:c40c:b0:2c9:9a2e:dab0 with SMTP id
 d9443c01a7336-2d035b98ab7mr17156565ad.3.1785395616912; 
 Thu, 30 Jul 2026 00:13:36 -0700 (PDT)
X-Received: by 2002:a17:902:c40c:b0:2c9:9a2e:dab0 with SMTP id
 d9443c01a7336-2d035b98ab7mr17156275ad.3.1785395616378; 
 Thu, 30 Jul 2026 00:13:36 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:34 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	Gerd Hoffman <kraxel@redhat.com>
Cc: graf@amazon.com,
	agraf@csgraf.de,
	qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg
 interface support
Date: Thu, 30 Jul 2026 12:42:32 +0530
Message-ID: <20260730071254.80695-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
and the corresponding device. The interface is made generic
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

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/meson.build              |   3 +
 hw/misc/trace-events             |   6 +
 hw/misc/vmlaunchupdate.c         | 309 +++++++++++++++++++++++++++++++
 include/hw/misc/vmlaunchupdate.h |  38 ++++
 4 files changed, 356 insertions(+)
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
index c9a868b3ef..2d6d2238c5 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -442,3 +442,9 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# vmlaunchupdate.c
+launch_update_write(void) ""
+vmlaunch_reset_enter(void) ""
+vm_launchupdate_finalize(void) ""
+restore_host_x86_igvm(void) ""
diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
new file mode 100644
index 0000000000..5b0222310b
--- /dev/null
+++ b/hw/misc/vmlaunchupdate.c
@@ -0,0 +1,309 @@
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
+/* returns NULL unless there is exactly one device */
+static VMLaunchUpdateState *vm_launchupdate_find(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_VMLAUNCHUPDATE, NULL);
+
+    return o ? VMLAUNCHUPDATE(o) : NULL;
+}
+
+static bool vmlaunchupdate_supported(void)
+{
+    return target_arch() == SYS_EMU_TARGET_X86_64;
+}
+
+static void init_vm_launch_update(VMLaunchUpdateState *s)
+{
+    s->launch_update.capabilities = VM_LAUNCHUPDATE_FORMAT_IGVM;
+    s->launch_update.control = 0;
+
+    if (s->disabled) {
+        s->launch_update.control |= VM_LAUNCHUPDATE_CTL_DISABLE;
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
+                            uint64_t fw_image_addr, uint64_t fw_image_size)
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
+                    "not changing launch state.");
+        return -2;
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
+                    PRIx64 ": %" PRIx64, fw_image_addr, fw_image_size);
+        return -1;
+    }
+
+    /* free previous file context */
+    if (igvmc->file >= 0) {
+        igvm_free(igvmc->file);
+    }
+    /* set new context */
+    igvmc->file = igvm;
+
+    physical_memory_unmap(image_addr_ptr, len, 0, 0);
+    info_report("vmlaunchupdate: new IGVM context set.");
+
+    return 0;
+}
+
+static void restore_host_x86_igvm(void)
+{
+    X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+    IgvmCfg *igvmc = x86machine->igvm;
+    Error *errp;
+
+    /* free previous file context */
+    if (igvmc->file >= 0) {
+        igvm_free(igvmc->file);
+    }
+
+    info_report("restoring original host IGVM: %s", igvmc->filename);
+    igvmc->file = qigvm_file_init(igvmc->filename, &errp);
+    assert(!errp);
+
+    info_report("vmlaunchupdate: host IGVM context set.");
+
+    trace_restore_host_x86_igvm();
+
+    return;
+}
+
+static bool fw_address_cleared(VMLaunchUpdateState *s)
+{
+    return !s->launch_update.fw_image_addr &&
+        !s->launch_update.fw_image_size;
+}
+
+static void launch_update_write(void *dev, off_t offset, size_t len)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(dev);
+    uint64_t addr;
+    uint64_t size;
+    int rc;
+
+    s->launch_update.status = VM_LAUNCHUPDATE_SUCCESS;
+
+    if (s->disabled) {
+        goto end;
+    }
+
+    if (s->launch_update.control & VM_LAUNCHUPDATE_CTL_DISABLE) {
+        s->disabled = true;
+        goto end;
+    }
+
+    if (fw_address_cleared(s) &&
+        (s->launch_update.control & VM_LAUNCHUPDATE_CTL_HOST_IGVM)) {
+        /* restore host IGVM on immediate next reset */
+        s->host_igvm_on_reset = true;
+        goto end;
+    }
+
+    if (!(s->launch_update.control & VM_LAUNCHUPDATE_FORMAT_IGVM) &&
+        !fw_address_cleared(s)) {
+        /* at least one address provided but the format is not IGVM */
+        s->launch_update.status = VM_LAUNCHUPDATE_LOAD_FAIL;
+        goto end;
+    }
+
+    /* process guest provided IGVM image */
+    if (s->launch_update.control & VM_LAUNCHUPDATE_FORMAT_IGVM) {
+        if (target_arch() == SYS_EMU_TARGET_X86_64) {
+            addr = le64_to_cpu(s->launch_update.fw_image_addr);
+            size = le64_to_cpu(s->launch_update.fw_image_size);
+            rc = process_x86_igvm(s, addr, size);
+            if (rc < 0) {
+                switch (rc) {
+                case -2:
+                    s->launch_update.status = VM_LAUNCHUPDATE_NOT_IGVM_INIT;
+                    break;
+                default:
+                    s->launch_update.status = VM_LAUNCHUPDATE_LOAD_FAIL;
+                }
+                goto end;
+            }
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
+    return;
+}
+
+static void launch_update_select(void *dev)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(dev);
+    init_vm_launch_update(s);
+}
+
+static void vmlaunch_reset_enter(Object *obj, ResetType type)
+{
+    VMLaunchUpdateState *s = VMLAUNCHUPDATE(obj);
+
+    if (target_arch() != SYS_EMU_TARGET_X86_64) {
+        return;
+    }
+
+    if (s->host_igvm_on_reset) {
+        restore_host_x86_igvm();
+        s->host_igvm_on_reset = false;
+        /* restoring host igvm enables the interface again */
+        s->disabled = false;
+        /* clear the host IGVM ctrl bit */
+        s->launch_update.control &= ~VM_LAUNCHUPDATE_CTL_HOST_IGVM;
+    }
+
+    if ((s->launch_update.control & VM_LAUNCHUPDATE_CTL_HOST_IGVM) &&
+        (s->launch_update.status == VM_LAUNCHUPDATE_SUCCESS)) {
+        info_report("vmlaunchupdate: next reset will use host igvm");
+        s->host_igvm_on_reset = true;
+    }
+
+    trace_vmlaunch_reset_enter();
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
+    rc->phases.enter = vmlaunch_reset_enter;
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
index 0000000000..02f96cebdc
--- /dev/null
+++ b/include/hw/misc/vmlaunchupdate.h
@@ -0,0 +1,38 @@
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
+#include "standard-headers/misc/vmlaunchupdate.h"
+
+#define TYPE_VMLAUNCHUPDATE "vm-launch-update"
+
+typedef struct VMLaunchUpdateState {
+    DeviceState parent_obj;
+    VMLaunchUpdate launch_update;
+    bool disabled;
+    bool host_igvm_on_reset;
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
+#endif
-- 
2.42.0


