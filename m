Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE566C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvB-0005rP-7T; Mon, 02 Mar 2026 03:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuI-0004wl-Ua
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu8-0001tS-6k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kNPuPLo+kDu65wNHg/Ys8gL0oDKZMPcdkl4aAZoh3w=;
 b=g4jFgN3G6eJFInyh0bddZsFosBnKhsn7VjlL69646b/l2U1Y31g5uMPxkdi0lcJNxQ9ihG
 MwBt7SkTGf1h5BIz728gDbHXZbQjCfSq+Hs1GTl8M4/GVsCZ1C0bh5008xLFevRwUrOHD6
 fHIpVMYz/uRjWRntbqSUtQMRTolquAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637--vYheo4kOPWIBu-qx0vv0w-1; Mon, 02 Mar 2026 03:45:24 -0500
X-MC-Unique: -vYheo4kOPWIBu-qx0vv0w-1
X-Mimecast-MFC-AGG-ID: -vYheo4kOPWIBu-qx0vv0w_1772441123
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so48181225e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441122; x=1773045922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kNPuPLo+kDu65wNHg/Ys8gL0oDKZMPcdkl4aAZoh3w=;
 b=CycVzrnsyEMtXthMv0ObKP7cjULg2zCytODMVjTEmaHDS5e61KTC/EqEPYhqExQZcr
 W07gC05jNSTGvD+cnfUPsblLtFZ7V2v6bOBWm7PC4pzeWhxN1sAp7TzLvAZxW7Ublgwn
 XJE1qD7NAaokKV3RYJAvwOyrJKvZIu8zAjBbFRw/c37NfExL+Qo53HeS0M5RLorgasQm
 YR0ipvdpe9BwkACiB65P0yFo7AxSaMTkkC2F6D5gbIPzKQ/vmPUBw4LT+6j9Gb+cnla7
 cMDk7J2rOovqNp4Xw7ypu8w6u/PldQk03+jZSHi+FsENXZs34/g/FnNBo8PbK5ZlTFNM
 15RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441122; x=1773045922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6kNPuPLo+kDu65wNHg/Ys8gL0oDKZMPcdkl4aAZoh3w=;
 b=RMNXiHq22IMLYgMdSWtbiQAZNPVpa5C8waSj5PzBPsvNu3n8PlzsVuM9pSGHi0lYPj
 xb2nxgNwgX/2U2dssduMwDHAH0g4xODoBwwrAOHPs3aKjxrIj+OXFe2/mJXFq+6JO0C0
 YFJO04MtWcmzBRIz9WTH3wSwHvVGjGqjyHJHrJ/iL0KF4ehPUJWLatkULqvJ03weLnNO
 DEqkXOefpkseEVMvog8xLrSZ1rjlPJ20KDkEyZUYzBs9G+dMwAts5kvhTRVrOIgYkyHJ
 z37Sw0xXgnJL6rRU9Kp7rmaIVId6M6eWDB3AjxvN4Me/kJ018g27GzRbxJgtIlL5G/7+
 BPrQ==
X-Gm-Message-State: AOJu0Ywnb41OinLzXXDo6DyR+tIDD0BP5AJo3uibpkT6ChemMqopj/3q
 1jDEQBdfJb3ATgxxGLmmfj9Fz6pUJ8tBH5A3GJ6eZEwyCIoB7eixOt+DpjqVf/qU/ow7f3pi3SB
 4VwxC0n7mzO33CRvaZYUcH9/NkW9AA0ombZ/rqUafMwSwioo6DQUJjBSmUW33Dr4OJ3xKVpey/3
 WpfF3XDVBGp/BuzAmCIN6RoH4oQ7NZ+3JnccvXxEFH
X-Gm-Gg: ATEYQzzmOAsjhJ1Qpjwtju74sX5JYUXXyBm+s1EzqyQ+s8M6FC0Fi54Te4w2JvKxnuI
 W6qr17GSyC47sdMXo0Wh/e0q5w/2xfp/yj0BtIc9xEL/Opy03Kd5zgO7Lo7RdbTYtuyHqQTAG3W
 TUovFlE9AuSX7Nog5Zc3U53ZR46jTHEgxHhMZcnSn3h9GL9GdDlF1CuPQ0jil4JDIRjDDByYaQb
 vdJgz/y1LrwiwkT3nGyNOBrS+F1PEBE6h/oXrUEG48PodSI3nbv7tZUd6uX6TnXKVYpUQ72So6S
 VaD44lhY7ZaQsXsOcKONmfV6EZ8tpqKbmWyMCtv9FZE8jPdvRMSd9wcRlXTC8VBb1iUTO0TAjCc
 q/0bJxBCRJuN8zR5azyPzf81NkOqlocoLehgJsWzGm0q4Hvhr/HLMwipfvy0FpVaLboXkjSGFED
 HHc+kQKf9uvqsjwS0s7NOs3E78OlI=
X-Received: by 2002:a05:600c:8183:b0:483:7eeb:4558 with SMTP id
 5b1f17b1804b1-483c33c1e04mr258789845e9.2.1772441122266; 
 Mon, 02 Mar 2026 00:45:22 -0800 (PST)
X-Received: by 2002:a05:600c:8183:b0:483:7eeb:4558 with SMTP id
 5b1f17b1804b1-483c33c1e04mr258789225e9.2.1772441121715; 
 Mon, 02 Mar 2026 00:45:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm27722423f8f.32.2026.03.02.00.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 038/102] hw/nitro: Add nitro machine
Date: Mon,  2 Mar 2026 09:42:33 +0100
Message-ID: <20260302084338.473368-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Add a machine model to spawn a Nitro Enclave. Unlike the existing -M
nitro-enclave, this machine model works exclusively with the -accel
nitro accelerator to drive real Nitro Enclave creation. It supports
memory allocation, number of CPU selection, both x86_64 as well as
aarch64, implements the Enclave heartbeat logic and debug serial
console.

To use it, create an EIF file and run

  $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
                       -kernel test.eif

or

  $ qemu-system-aarch64 -accel nitro,debug-mode=on -M nitro -nographic \
                        -kernel test.eif

Signed-off-by: Alexander Graf <graf@amazon.com>

Link: https://lore.kernel.org/r/20260225220807.33092-9-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nitro/machine.h |  20 +++++
 hw/nitro/machine.c         | 161 +++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c     |   1 +
 hw/nitro/Kconfig           |   8 ++
 hw/nitro/meson.build       |   1 +
 5 files changed, 191 insertions(+)
 create mode 100644 include/hw/nitro/machine.h
 create mode 100644 hw/nitro/machine.c

diff --git a/include/hw/nitro/machine.h b/include/hw/nitro/machine.h
new file mode 100644
index 00000000000..d78ba7d6dc3
--- /dev/null
+++ b/include/hw/nitro/machine.h
@@ -0,0 +1,20 @@
+/*
+ * Nitro Enclaves (accel) machine
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NITRO_MACHINE_H
+#define HW_NITRO_MACHINE_H
+
+#include "hw/core/boards.h"
+#include "qom/object.h"
+
+#define TYPE_NITRO_MACHINE MACHINE_TYPE_NAME("nitro")
+OBJECT_DECLARE_SIMPLE_TYPE(NitroMachineState, NITRO_MACHINE)
+
+struct NitroMachineState {
+    MachineState parent;
+};
+
+#endif /* HW_NITRO_MACHINE_H */
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
new file mode 100644
index 00000000000..e28c8e9bf50
--- /dev/null
+++ b/hw/nitro/machine.c
@@ -0,0 +1,161 @@
+/*
+ * Nitro Enclaves (accel) machine
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors:
+ *   Alexander Graf <graf@amazon.com>
+ *
+ * Nitro Enclaves machine model for -accel nitro. This machine behaves
+ * like the nitro-enclave machine, but uses the real Nitro Enclaves
+ * backend to launch the virtual machine. It requires use of the -accel
+ * nitro.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "chardev/char.h"
+#include "hw/core/boards.h"
+#include "hw/core/cpu.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/nitro/heartbeat.h"
+#include "hw/nitro/machine.h"
+#include "hw/nitro/nitro-vsock-bus.h"
+#include "hw/nitro/serial-vsock.h"
+#include "system/address-spaces.h"
+#include "system/hostmem.h"
+#include "system/system.h"
+#include "system/nitro-accel.h"
+#include "qemu/accel.h"
+#include "hw/arm/machines-qom.h"
+
+#define EIF_LOAD_ADDR   (8 * 1024 * 1024)
+
+static void nitro_machine_init(MachineState *machine)
+{
+    const char *eif_path = machine->kernel_filename;
+    const char *cpu_type = machine->cpu_type;
+    g_autofree char *eif_data = NULL;
+    gsize eif_size;
+
+    if (!nitro_enabled()) {
+        error_report("The 'nitro' machine requires -accel nitro");
+        exit(1);
+    }
+
+    if (!cpu_type) {
+        ObjectClass *oc = cpu_class_by_name(target_cpu_type(), "host");
+
+        if (!oc) {
+            error_report("nitro: no 'host' CPU available");
+            exit(1);
+        }
+        cpu_type = object_class_get_name(oc);
+    }
+
+    if (!eif_path) {
+        error_report("nitro: -kernel <eif-file> is required");
+        exit(1);
+    }
+
+    /* Expose memory as normal QEMU RAM. Needs to be huge page backed. */
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+
+    /*
+     * Load EIF (-kernel) as raw blob at the EIF_LOAD_ADDR into guest RAM.
+     * The Nitro Hypervisor will extract its contents and bootstrap the
+     * Enclave from it.
+     */
+    if (!g_file_get_contents(eif_path, &eif_data, &eif_size, NULL)) {
+        error_report("nitro: failed to read EIF '%s'", eif_path);
+        exit(1);
+    }
+    address_space_write(&address_space_memory, EIF_LOAD_ADDR,
+                        MEMTXATTRS_UNSPECIFIED, eif_data, eif_size);
+
+    if (defaults_enabled()) {
+        NitroVsockBridge *bridge = nitro_vsock_bridge_create();
+
+        /* Nitro Enclaves require a heartbeat device. Provide one. */
+        qdev_realize(qdev_new(TYPE_NITRO_HEARTBEAT),
+                     BUS(&bridge->bus), &error_fatal);
+
+        /*
+         * In debug mode, Nitro Enclaves expose the guest's serial output via
+         * vsock. When the accel is in debug mode, wire the vsock serial to
+         * the machine's serial port so that -nographic automatically works
+         */
+        if (object_property_get_bool(OBJECT(current_accel()), "debug-mode", NULL)) {
+            Chardev *chr = serial_hd(0);
+
+            if (chr) {
+                DeviceState *dev = qdev_new(TYPE_NITRO_SERIAL_VSOCK);
+
+                qdev_prop_set_chr(dev, "chardev", chr);
+                qdev_realize(dev, BUS(&bridge->bus), &error_fatal);
+            }
+        }
+    }
+}
+
+static bool nitro_create_memfd_backend(MachineState *ms, const char *path,
+                                       Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    Object *root = object_get_objects_root();
+    Object *obj;
+    bool r = false;
+
+    obj = object_new(TYPE_MEMORY_BACKEND_MEMFD);
+
+    /* Nitro Enclaves require huge page backing */
+    if (!object_property_set_int(obj, "size", ms->ram_size, errp) ||
+        !object_property_set_bool(obj, "hugetlb", true, errp)) {
+        goto out;
+    }
+
+    object_property_add_child(root, mc->default_ram_id, obj);
+
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
+        goto out;
+    }
+    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
+
+out:
+    object_unref(obj);
+    return r;
+}
+
+static void nitro_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Nitro Enclave";
+    mc->init = nitro_machine_init;
+    mc->create_default_memdev = nitro_create_memfd_backend;
+    mc->default_ram_id = "ram";
+    mc->max_cpus = 4096;
+}
+
+static const TypeInfo nitro_machine_info = {
+    .name = TYPE_NITRO_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(NitroMachineState),
+    .class_init = nitro_machine_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        /* x86_64 and aarch64 only */
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { }
+    },
+};
+
+static void nitro_machine_register(void)
+{
+    type_register_static(&nitro_machine_info);
+}
+
+type_init(nitro_machine_register);
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 794d8700857..051faf31e14 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1815,6 +1815,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
             g_str_equal("xenpv", machines[i].name) ||
             g_str_equal("xenpvh", machines[i].name) ||
             g_str_equal("vmapple", machines[i].name) ||
+            g_str_equal("nitro", machines[i].name) ||
             g_str_equal("nitro-enclave", machines[i].name)) {
             continue;
         }
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
index d3fbc7b683c..cfae85920a0 100644
--- a/hw/nitro/Kconfig
+++ b/hw/nitro/Kconfig
@@ -8,3 +8,11 @@ config NITRO_SERIAL_VSOCK
 config NITRO_HEARTBEAT
     bool
     depends on NITRO_VSOCK_BUS
+
+config NITRO_MACHINE
+    bool
+    default y
+    depends on NITRO
+    select NITRO_VSOCK_BUS
+    select NITRO_HEARTBEAT
+    select NITRO_SERIAL_VSOCK
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
index 381c1ee6c15..e3f18958906 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1,3 +1,4 @@
 system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-vsock-bus.c'))
 system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
 system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: files('heartbeat.c'))
+system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: files('machine.c'))
-- 
2.53.0


