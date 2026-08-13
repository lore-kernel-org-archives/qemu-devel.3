Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE32EC5DF67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmL-0005zV-NI; Thu, 13 Aug 2026 06:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmK-0005zI-MZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmI-0000DP-Bp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0kB6WTU3MJyfoKuVN9tFZMFuxsI1CHKvQTy9mgVknk=;
 b=Y9L7VzWi2q+VL0J9rdyii2ZPA1q4Q5rj/rDofQp6dTVwhc8C3afu+xmxZv/6by8AdrGcf2
 0ee5mol8WAmkij8Xhcj4Vfg0JaIx4k4Re7O9NEGloCGKcbmvCdNIZ8xd2ux2ng8q1tc3ip
 xiQgQx4+mFdBGPIf/2ZyejEn36I17Mo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-sM6iNbkYO0G_7v84jgOYsg-1; Thu, 13 Aug 2026 06:35:12 -0400
X-MC-Unique: sM6iNbkYO0G_7v84jgOYsg-1
X-Mimecast-MFC-AGG-ID: sM6iNbkYO0G_7v84jgOYsg_1786617311
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso758736a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617311; x=1787222111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w0kB6WTU3MJyfoKuVN9tFZMFuxsI1CHKvQTy9mgVknk=;
 b=Ux0MeRSHLct3u+AnN4Z6Be8GY6d4rCv7fm/oKbbXQMV8tczkDcgU5wnxLQfSdAU/kz
 3YKjZkpcsvET96ZOtPUhgFEyGHs2GYXUazftCEldKcWPg6Ad/48uFvk77A95bNbvCvxE
 F7Q7s3WwIg56fmJBNhMluOYLx7xEiA4BfcHCb0vDI+XaHTt+SgFCr+2vsprgzuoQwFP3
 KorI0WFUP7LdJMLit1MljE8L+x87365jSmxwOGB+cB127gRi9hZpPbA+4GheKXVG1UvS
 6IntX4kg+kmH2sKZbvsLhaJ1o7QBQ9Az49wLOJdxu/3TOT7ZIEQSDan/7h5Nk8DN30VH
 L4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617311; x=1787222111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w0kB6WTU3MJyfoKuVN9tFZMFuxsI1CHKvQTy9mgVknk=;
 b=Uwhor1q63JrptVMvaLSXRxqiKjMW/4lExYdcU1Jbqo1hsxu1wiU39Gw2PHaWiJq5AK
 VeA+lc1Vbsgjy9kRaUHe3o2r7kFnTwscgDWzORGSzB+PC0MVxy4LFKIwm0k+IPMQtobG
 zAYbe9cvRUV89cNjqrc2u8kFMD1qBxIlPmEqVclD7KumFGbNEPFJZIB2+DDvngfGi9n0
 aj8BwiZEeT2Ul+XWNsh+Z2yuJwUX39b7yhXAXAHL9QbaJ4pT0vUs5NhhTsdLnPm8Rp+U
 6pnJTcdNHeyl7V5zz3KaFd5fw0WVbqxipZPwaM+uIxsAsrFQlKN2iYzNrTrCYBob16BH
 KnOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYKslXGD+A+M6dotJoW6XKPh4zCYDcWyv9vIddwTC52S3GpvI10ciSKBOjyvOhfvRqXmii/shuX8bE@nongnu.org
X-Gm-Message-State: AOJu0YzbRaT9MqLfTUQRFlsZ8CYoa1JxBxS7VLq/3vcubVAw/2EqsSOf
 jCiQeWcxRkpbPLcXlXlrQg1FQaGsemaak42KeYR7JBRxL97HYP4avYz4tTLY9NGXkSfOXn5SPKx
 YkCr4jPBq/aPOc7ggyeKXCUxxjqkU3OYA7GhSDO8ioNkllcqMnkkHAXj+
X-Gm-Gg: AR+sD117S3KAiRBUymYdZcyBDM0ZX5dbzdXjis5N9jpJLRZ4n+tt0PEjyacQhszWVMW
 oexHCCHcHqs3CUhVzafJMVwpTSAqc019gSjtdzqsejzjljzay++H2D2x5zKoiQO5lZUw8XgJ2vS
 VQfjsH1kSVS4qqDWsPEccbVevIEUquhNWIlbReEf1Cf6v66L8SwVFnOQEfw3OIzzdfBBHw+aecQ
 iFrC6dwptRwsfZmd9A95/OMtlyl4zLvjBe77hWcQBt3rWrb86cwDkXBoRDY5cFwFtqSzy4+c31Q
 D4vH1UXU2KhRvcm3d5EpzdPADi5nbyqWq3hrGbnGnFy1RJ8KCTmXuEb6phR4PvmojrW7rHOkEgp
 aYkpi1uR6wsAf5vvK3FZc/+K22c0z7CV+SA==
X-Received: by 2002:a17:90b:264d:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-3931e0374f2mr5960778a91.6.1786617311027; 
 Thu, 13 Aug 2026 03:35:11 -0700 (PDT)
X-Received: by 2002:a17:90b:264d:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-3931e0374f2mr5960727a91.6.1786617310433; 
 Thu, 13 Aug 2026 03:35:10 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:35:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	Gerd Hoffman <kraxel@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg
 interface support
Date: Thu, 13 Aug 2026 16:04:09 +0530
Message-ID: <20260813103425.24474-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/misc/meson.build              |   3 +
 hw/misc/trace-events             |   6 +
 hw/misc/vmlaunchupdate.c         | 333 +++++++++++++++++++++++++++++++
 include/hw/misc/vmlaunchupdate.h |  38 ++++
 4 files changed, 380 insertions(+)
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 include/hw/misc/vmlaunchupdate.h

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e86d9ad6b3..858ca845a2 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -164,6 +164,9 @@ specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
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
index 0000000000..afa2d278ae
--- /dev/null
+++ b/hw/misc/vmlaunchupdate.c
@@ -0,0 +1,333 @@
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
+static bool no_igvmcfg(X86MachineState *x86m)
+{
+    IgvmCfg *igvmc;
+
+    if (!x86m) {
+        return true;
+    }
+
+    igvmc = x86m->igvm;
+
+    if (!igvmc) {
+        /* The VM was not started with an IGVM, bail */
+        info_report("guest was not initially started with IGVM, "
+                    "not changing launch state.");
+        return true;
+    }
+    return false;
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
+    if (no_igvmcfg(x86machine)) {
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
+        goto err;
+    }
+
+    igvm = igvm_new_from_binary(image_addr_ptr, fw_image_size);
+    if (igvm < 0) {
+        warn_report("vmlaunchupdate: Unable to parse IGVM file %"
+                    PRIx64 ": %" PRIx64, fw_image_addr, fw_image_size);
+        goto err;
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
+ err:
+    if (image_addr_ptr) {
+        physical_memory_unmap(image_addr_ptr, len, 0, 0);
+    }
+    return -1;
+}
+
+static void restore_host_x86_igvm(void)
+{
+    X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
+    IgvmCfg *igvmc = x86machine->igvm;
+    Error *errp = NULL;
+
+    if (no_igvmcfg(x86machine)) {
+        return;
+    }
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


