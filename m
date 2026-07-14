Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134B8C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTAE-0008PA-Jz; Mon, 13 Jul 2026 22:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTAA-0008Oh-Q6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA7-0006bv-ER
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayDKbQIMHmkvEltzCJOUg1AJNbeiv21Z8VCvXefyhRY=;
 b=cn3sNPnQ/MGy1qjlE0RmocOemFVBKwYsemmvSuniS0wWarWb9+ehJ2/9MunOe9zE0wELrf
 sR6ZCCGdKplZyeTQZK6cpChJNzkeKbAD/Ti9N+sLqCF6cKPvGt+6k47g+wJ/42stwclBbk
 xY+bleuwjI9H6hxwV3MM5Dt1TBWO6Mw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Vo_MS0vlPMCTGtw7pbvvmg-1; Mon, 13 Jul 2026 22:46:21 -0400
X-MC-Unique: Vo_MS0vlPMCTGtw7pbvvmg-1
X-Mimecast-MFC-AGG-ID: Vo_MS0vlPMCTGtw7pbvvmg_1783997180
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so4949658a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997180; x=1784601980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ayDKbQIMHmkvEltzCJOUg1AJNbeiv21Z8VCvXefyhRY=;
 b=nqzkUXfeUDRHFS14CAE40ls4MkjaA4TKuZZ0xiR7WRCAa78fmIYmebv9se/M1XzbcS
 AFQmILrB2WAkPmaP0K/YhCnz+jMNmsM2zZg9IwVIWxGkXhywlezaJO2+5VqgYucgCBph
 kW4k93C+t5TER9VXHN1iNZgBv/Ci/Ly33LRRGg/1J+eu5Y4Fn4wfMNC7/nQA2/8QXQBe
 9boyXOXCAd+ZRcSpBkPaRwTm8F3t2/K6JaMdjLDykZg745YYIfbmfq4nTONf2NRoceOQ
 I7I+PRKjecmBLIeaw4lXmS72SYdrK5TByR711EFZDAYbjLQVzHduqKDQ5QkV+qqOC41S
 PAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997180; x=1784601980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ayDKbQIMHmkvEltzCJOUg1AJNbeiv21Z8VCvXefyhRY=;
 b=Ij+7zbojwUCXTeW8rIOO7LbcQkM+S8ExMhSaIN0EZaJeLmfe5GqLXsUc3Q2pdtwkh5
 QrV2jdGqCci6o477UiR/bccY3RuPuCHdHjIz0QlKpeX4BPIG07KVGZ6jPJBW5JLsgVP4
 36o1vWGmiBiB5eyks3GdhzI0oAzw9I5+v02jBL+aGGYMQTOZUVfgCQmSRGUvGPPng6rR
 mm32btcHWgwGDPE4LH/Etye2S+7bMGObNNCa5eBtgdFAh1azy4tRcumkubVeoumyzUeq
 3x34qSLPSaaN6B9mMRRfSe9F5LakXoWmz4OgBJjNZ7jddG4mzTpCn69/hYGZc6HKSAvG
 /xJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXZwvikbVWX0lOWz616NGXaRKobeBxBgfMtLyLeGAe23e3dspkw2izoSPV5iioy1ArZ28UoEB5Y0m1@nongnu.org
X-Gm-Message-State: AOJu0YzH9saSESC2NF+JMKfe+kHhCXtjzFP0Axh3p+8sG/5yzGqh3HZY
 h8B4IllIzv3B7TmxhMg8dAh1GNSVftnoSwAEnp0/ppEzQ6LbfRNl/IwL8ruiCdP59oQnssf1FaI
 ZHm4ulFtZTbQvebDTrqJm3PfEi2As96xLynQjkyOnEmnH3B0RP8Tz+GHz
X-Gm-Gg: AfdE7ckUkYGDRoPUStNyjG860etnQy4KHoEytIUqpSKeMZTQ5lNC/KuEFV1yUU3eCbA
 mFp/X88ikZ4oGJCO4aFberoVVtNAwTVlV9e6BgebySs0yQAc/PulcZf5sAe1yYvhSMCZqS8KP7u
 39BcJSsZYvjAqRyB4K7KIdnqZBiKWraSgHlYkcHtlK6XEIuW6bR8EVSOqgSA+Q5Roz5np+KWHKk
 oxv3vMTVRJJnMvaYb+IIaHHuz1Aw7cXeZ2IE5jp2UVtetEc8D3T96/jto40pRNo4NHZLffKfEMM
 erA3P+5bSDHB/5B5+XK3qrYctCV/pudByqlaOFU4TZStUB0a776jUtDLxnD7uF14VK2xSFt0Gwq
 0G8BHx9Hh0JOww6jg85mNsh2MyYHywX6z8VSOQquAOmQBag==
X-Received: by 2002:a05:6a21:6817:b0:3c0:9c19:65aa with SMTP id
 adf61e73a8af0-3c110a4b3c4mr12003545637.66.1783997180143; 
 Mon, 13 Jul 2026 19:46:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:6817:b0:3c0:9c19:65aa with SMTP id
 adf61e73a8af0-3c110a4b3c4mr12003510637.66.1783997179599; 
 Mon, 13 Jul 2026 19:46:19 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	Gerd Hoffman <kraxel@redhat.com>
Cc: Alex Graf <graf@amazon.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg
 interface support
Date: Tue, 14 Jul 2026 08:15:24 +0530
Message-ID: <20260714024557.204578-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260714024557.204578-1-anisinha@redhat.com>
References: <20260714024557.204578-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/meson.build              |   3 +
 hw/misc/trace-events             |   6 +
 hw/misc/vmlaunchupdate.c         | 307 +++++++++++++++++++++++++++++++
 include/hw/misc/vmlaunchupdate.h |  38 ++++
 4 files changed, 354 insertions(+)
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
index 0000000000..8406d0a6b5
--- /dev/null
+++ b/hw/misc/vmlaunchupdate.c
@@ -0,0 +1,307 @@
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


