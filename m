Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F67DCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZP-000778-Ig; Wed, 24 Jun 2026 01:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZO-00076T-9q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZL-0006HK-7g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34jMeIE3M2vwUm6cv4K9cmcXI75mLxkqEp1TheFx/gw=;
 b=QXwnkkU58xTGO7F6+VZQIxcJDjsj7NKLt6jafP4IeHyyKimsjP4+nvPNfhcGo3I7RK6Lys
 K3UKPkWedMDF9BEpQ9Ebbk/MfpnPy2V3wpnAh/mnIJpzoC3GWPJoU8EH4y50sx3kso0twv
 Z3+BiZdPVkCQRi7yEwLR4fB1ggyOG3c=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-NslUdNAKMsOS1XHwgvRK3A-1; Wed, 24 Jun 2026 01:54:36 -0400
X-MC-Unique: NslUdNAKMsOS1XHwgvRK3A-1
X-Mimecast-MFC-AGG-ID: NslUdNAKMsOS1XHwgvRK3A_1782280475
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so833010eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280475; x=1782885275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34jMeIE3M2vwUm6cv4K9cmcXI75mLxkqEp1TheFx/gw=;
 b=j76Mx0Cg3jtpY2u585O26w+r7eHUw/waeDPIOtOwARM39QrTJt3Yabq1LAM6Kz/jfq
 fJ/hHCkvbDTyEBdXHH8DcchuoffyByKd/TaQt8Faf153xT2mmkbWev4WRZ8YTLJYzpGl
 TABSc8wRgetGOeoqxarFH9q1Akl0Zln5jM1XsPVR2UceKvO/qhboKVxnLbpjWVebOr8y
 EuD/SVFSUZ193y5LpyMLGAVmt3KKhis+oOrX3KcfpQPbJ6PNZtg1zz03T+8GjOgpxUHK
 OYojqTjerZawA120S2kpSfWZKGaur8dnmTqm1sIbCCEtLn18HWrfhUfCZqt331xjNL4j
 A7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280475; x=1782885275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34jMeIE3M2vwUm6cv4K9cmcXI75mLxkqEp1TheFx/gw=;
 b=hjps9gCE2L0cI7LA3gwTG1pnG7N8dAWQ/ZN5tXLUVoiFrHZt+5RBaygra8Im2M686E
 dDxPc6ByBFSPLAsbd1yEGduIUFVGtmUXfJQ6n8awLNZLlhvFpXU80nfLIDLFHyxpxD3h
 A4iu0mtM7mcHzbCLK47zuBNNYCD3kgUCwUJFusEjs7ZnZrEuvQY3XUeqVPK9CopLjpos
 nqREVJFlffyV5XbICNgGhS+eWntdQYmcFCiDD2B01nQuKB/5n+bDkrCEqva8gjnLjTz6
 XwK7dl+zH7P8fLVYF1p55oAi7KUQ4At8tyX0cJ1bl7Fnv3WLCBgLF6izo+zqbWPsNlX6
 h/nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpacJWGOqn018ug+1qwY81X6KGMwg2q9qNs9qfrYhSQe9FGDugZmR/ynFYvy5tBz7nEnoA3yqa3zhcu@nongnu.org
X-Gm-Message-State: AOJu0YyzI8O2CJWmG931y1eIxY612H7xgn1wNCRPEP0/TmHKeagau/wD
 HiwvRkTpXvTyVZyaNjcu8ebYWpQrnDmSH9xwCu9gq7LkahUxvoXiLGFPDZGZfKwg7XWBE/eloWZ
 9X9EMFMNYgG8Otezuh7FMn6W9bJM/LmUIjAzL7lHvnFTSFvXGIr+Pos4H
X-Gm-Gg: AfdE7clu/8kh4xsaLjOMw8Ch9gh26XE5a34n3T2FMVVjAqNoCwM9TDglVmmKmb5n3og
 g20yemAf4IuTFVDc2sAblY48I23HMiFdVuQctUFUG6xBXMO2H/YjuLk2tDWXZ875fXdjpdFKlZd
 N/oszEs7/5jCoPurH4zwRWi3WTzaD/fO/O3lDYoQnhRGNdd1Ulp045aMKwySEh1YBwkr7r8SHUd
 R9/5NDgqWNHuE2SJSQ4if+4TnvlANsD1Z9i44sEKEiaiznMnMCAekyAaTPOPFYQpzLZ6jVtX8Nd
 HFzvtUDmgKTUcnX51XexL77SRqOsnSoVNfzCmt4q9kcRtt4MilQ2Thu/kha7lHIqAqPETQ+tR+9
 R48wHLMMBohDIUbpUfEWw/kNy3Ib1BijtgpOS+LTCDbrg
X-Received: by 2002:a05:7300:80cf:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-30c68d23953mr2386320eec.15.1782280475101; 
 Tue, 23 Jun 2026 22:54:35 -0700 (PDT)
X-Received: by 2002:a05:7300:80cf:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-30c68d23953mr2386298eec.15.1782280474506; 
 Tue, 23 Jun 2026 22:54:34 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:34 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Alex Graf <graf@amazon.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v1 7/8] Add functional and unit tests for the vm-launch-update
 device
Date: Wed, 24 Jun 2026 11:23:29 +0530
Message-ID: <20260624055339.46862-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset adds functional and unit tests that exercize various functions
and behaviors of vm-launch-update device. It uses the IGVM files that were
introduced in the previous patch for exercizing the hypervisor interface.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/functional/aarch64/meson.build          |   1 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vm_launch_update.py           |  48 +++
 tests/qtest/launchupdate-test.c               | 321 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 6 files changed, 406 insertions(+)
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index e81afd6c39..b07373189e 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -23,6 +23,7 @@ test_aarch64_timeouts = {
 tests_aarch64_system_quick = [
   'migration',
   'vmstate',
+  'vm_launch_update_aarch',
 ]
 
 tests_aarch64_system_thorough = [
diff --git a/tests/functional/aarch64/test_vm_launch_update_aarch.py b/tests/functional/aarch64/test_vm_launch_update_aarch.py
new file mode 100755
index 0000000000..2b3d7cf4a3
--- /dev/null
+++ b/tests/functional/aarch64/test_vm_launch_update_aarch.py
@@ -0,0 +1,33 @@
+#!/usr/bin/env python3
+#
+# Check for vm-launch-update device.
+#
+# Copyright (c) 2026 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+
+class VmLaunchUpdateDeviceCheck(QemuSystemTest):
+
+    def aarch64_fail_test(self):
+        """
+        Currently the device is only supported for pc platforms.
+        """
+        self.vm.add_args('-machine', 'virt', '-device',
+                         'vm-launch-update,id=fwupd1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                    r'This machine does not support vm-launch-update device')
+
+    def test_vm_launch_update(self):
+        self.aarch64_fail_test()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 1ed10ad6c2..9b98e61e63 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -18,6 +18,7 @@ tests_x86_64_system_quick = [
   'pc_cpu_hotplug_props',
   'virtio_version',
   'vmstate',
+  'vm_launch_update',
 ]
 
 # The address-sanitizer makes mlock() a no-op because it
diff --git a/tests/functional/x86_64/test_vm_launch_update.py b/tests/functional/x86_64/test_vm_launch_update.py
new file mode 100755
index 0000000000..aac7ef915f
--- /dev/null
+++ b/tests/functional/x86_64/test_vm_launch_update.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Check for vm-launch-update device.
+#
+# Copyright (c) 2026 Red Hat, Inc.
+#
+# Author:
+#  Ani Sinha <anisinha@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+import time
+
+class VmLaunchUpdateDeviceCheck(QemuSystemTest):
+    DELAY_BOOT_SEQUENCE = 1
+
+    def vm_launch_update_pass(self):
+        """
+        Basic test to make sure vm-launch-update device can be instantiated.
+        """
+        self.vm.add_args('-device', 'vm-launch-update,id=fwupd1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertEqual(self.vm.exitcode(), 0, "QEMU exit code should be 0")
+
+    def multiple_device_fail(self):
+        """
+        Only one vm-launch-update device can be instantiated. Ensure failure if
+        user tries to create more than one device.
+        """
+        self.vm.add_args('-device', 'vm-launch-update,id=fw1',
+                         '-device', 'vm-launch-update,id=fw2')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                         r'at most one vm-launch-update device is permitted')
+
+    def test_vm_launch_update(self):
+        self.vm_launch_update_pass()
+        self.multiple_device_fail()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
new file mode 100644
index 0000000000..ac5b820864
--- /dev/null
+++ b/tests/qtest/launchupdate-test.c
@@ -0,0 +1,321 @@
+/*
+ * vmlaunchupdate device fwcfg test.
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * Author:
+ *   Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqos/libqos-pc.h"
+#include "libqtest.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+#include "hw/misc/vmlaunchupdate.h"
+
+#define WAIT_SEC 10
+static bool debug;
+static bool confidential;
+
+static void test_vm_launch_update_capability(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    VMLaunchUpdate launch_update;
+    size_t filesize;
+    uint64_t capabilities;
+
+    s = qtest_init("-device vm-launch-update");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMLAUNCHUPDATE,
+                                &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+    capabilities = le64_to_cpu(launch_update.capabilities);
+    g_assert_cmpint(capabilities, ==, VM_LAUNCHUPDATE_FORMAT_IGVM);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
+
+static void test_vm_launch_update_disable(void)
+{
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+    uint64_t control;
+    size_t filesize;
+
+    qs = qtest_pc_boot("-device vm-launch-update");
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMLAUNCHUPDATE,
+                                &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+    control = le64_to_cpu(launch_update.control);
+    g_assert_cmpint(VM_LAUNCHUPDATE_CTL_DISABLE & control, ==, 0);
+
+    /* disable the device */
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.control |= VM_LAUNCHUPDATE_CTL_DISABLE;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    /* try to clear the dsable flag */
+    memset(&launch_update, 0, sizeof(launch_update));
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    /* check if the device is still disabled */
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMLAUNCHUPDATE,
+                                &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+    control = le64_to_cpu(launch_update.control);
+    g_assert_cmpint(VM_LAUNCHUPDATE_CTL_DISABLE & control, ==, 1);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_shutdown(qs);
+}
+
+static int64_t get_image_size(const char *filename)
+{
+    int fd;
+    int64_t size;
+    fd = open(filename, O_RDONLY | O_BINARY);
+    g_assert_true(fd > 0);
+    size = lseek(fd, 0, SEEK_END);
+    close(fd);
+    return size;
+}
+
+static ssize_t load_image(const char *igvm_f, void **addr, size_t *size)
+{
+    ssize_t actsize = 0, l = 0;
+    int f_igvm_f;
+    size_t l_size;
+
+    f_igvm_f = open(igvm_f, O_RDONLY | O_BINARY);
+    g_assert_true(f_igvm_f);
+    l_size = get_image_size(igvm_f);
+    g_assert_true(l_size > 0);
+    *addr = g_malloc0(l_size);
+    g_assert_true(*addr);
+
+    while (l < l_size) {
+        actsize = read(f_igvm_f, *addr + l, 1);
+        if (actsize < 0) {
+            break;
+        }
+        l += actsize;
+    }
+
+    close(f_igvm_f);
+    *size = l_size;
+    return actsize < 0 ? -1 : l;
+}
+
+static gboolean match_hello_world(char *serial_f, const char *exp_out)
+{
+    GError *error = NULL;
+    g_autofree gchar *f_contents = NULL;
+    g_autofree GRegex *regex = NULL;
+    g_autofree GMatchInfo *match_info = NULL;
+    gsize len;
+    gboolean ret;
+
+    ret = g_file_get_contents(serial_f, &f_contents, &len, &error);
+    g_assert(ret);
+    g_assert_no_error(error);
+
+    regex = g_regex_new(exp_out, G_REGEX_CASELESS, 0, &error);
+    g_assert_no_error(error);
+
+    ret = g_regex_match_full(regex, f_contents, -1, 0, 0, &match_info, &error);
+    g_assert_no_error(error);
+
+    return ret;
+}
+
+static int wait_for_match(char *serial_f,
+                          const char *exp_out, int64_t timeout_s)
+{
+    time_t start, delta;
+    int ret = -1;
+
+    start = time(NULL);
+    while (1) {
+        if (match_hello_world(serial_f, exp_out)) {
+            ret = 0;
+            break;
+        }
+
+        delta = time(NULL) - start;
+        if (delta >= timeout_s) {
+            fprintf(stderr, "timed out waiting to read serial output\n");
+            break;
+        }
+
+        /* wait 20 ms before trying again */
+        if (false) {
+            fprintf(stderr,
+                    "sleeping 20 ms before checking serial output again.\n");
+        }
+        g_usleep(20000);
+    }
+    return ret;
+}
+
+static void test_load_igvm(void)
+{
+    const char *igvm_f;
+    const char *igvm_init;
+    int ser_fd;
+    g_autofree void *igvm_blob = NULL;
+    g_autofree char *serialtmp = NULL;
+    const char exp_out[] = "Hello world!";
+    const char exp_out2[] = "Test succeeded!";
+    const char *snp, *cgs;
+    uint64_t gaddr;
+    size_t igvm_sz;
+    size_t filesize;
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+
+    if (confidential) {
+        snp = "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
+            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
+        cgs = "confidential-guest-support=lsec0";
+        /*
+         * The following two IGVM files can be built from the source
+         * present in https://gitlab.com/anisinha/virt-firmware-rs .
+         * Typing 'make' from the top of this repository will build the
+         * IGVM files for both confidential and
+         * non-confidential tests. The IGVM files for the non-coco
+         * case has been checked-in into the QEMU repository for
+         * convenience and easy CI pipeline testing.
+         */
+        igvm_f = "tests/data/igvm/snptest.igvm"; /*
+                                                  * this prints 'hello world'
+                                                  * on console
+                                                  */
+        igvm_init = "tests/data/igvm/snptest-nohello.igvm";
+    } else {
+        igvm_f = "tests/data/igvm/hello.igvm";
+        igvm_init = "tests/data/igvm/qemuinit.igvm";
+        snp = "";
+        cgs = "";
+    }
+
+    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS)) {
+        g_test_skip("igvm file bundle does not exist!");
+        return;
+    }
+
+    ser_fd = g_file_open_tmp("launchupdate-qtest-serial-sXXXXXX",
+                             &serialtmp, NULL);
+    g_assert_true(ser_fd != -1);
+
+    if (debug) {
+        fprintf(stderr, "serial console file is %s\n", serialtmp);
+    }
+
+    qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
+                       "-device vm-launch-update "
+                       "-chardev file,id=serial0,path=%s "
+                       "-serial chardev:serial0 "
+                       "-object igvm-cfg,id=igvm0,file=%s %s",
+                       cgs, serialtmp, igvm_init, snp);
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    if (debug) {
+        fprintf(stderr, "target endianness: %s\n",
+                qtest_big_endian(qs->qts) ? "big" : "little");
+    }
+
+    g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) == igvm_sz);
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&qs->alloc, igvm_sz);
+
+    if (debug) {
+        fprintf(stderr, "guest paddr: %"PRIx64 "  igvm size: %lu\n",
+                gaddr, igvm_sz);
+    }
+
+    if (debug) {
+        fprintf(stderr, "writing igvm file into the guest memory\n");
+    }
+
+    qtest_bufwrite(qs->qts, gaddr, igvm_blob, igvm_sz);
+
+    if (debug) {
+        fprintf(stderr,
+                "tell hypervisor where igvm is loaded in guest memory\n");
+    }
+
+    /* now tell hypervisor where we loaded the bios */
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.fw_image_size = cpu_to_le32(igvm_sz);
+    launch_update.fw_image_addr = cpu_to_le64(gaddr);
+    launch_update.control |= VM_LAUNCHUPDATE_FORMAT_IGVM;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    if (debug) {
+        fprintf(stderr, "resetting the virtual machine now\n");
+    }
+
+    qtest_system_reset(qs->qts);
+
+    /* expected string should be printed on the console */
+    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC) == 0);
+    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC) == 0);
+
+    close(ser_fd);
+
+    guest_free(&qs->alloc, gaddr);
+    pc_fw_cfg_uninit(fw_cfg);
+    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
+    qtest_quit(qs->qts);
+}
+
+int main(int argc, char **argv)
+{
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_printerr("vmlaunchupdate tests are only available on x86\n");
+        exit(EXIT_FAILURE);
+    }
+
+    g_test_add_func("/vm-launch-update/cap", test_vm_launch_update_capability);
+    g_test_add_func("/vm-launch-update/disabled",
+                    test_vm_launch_update_disable);
+
+    g_test_add_func("/vm-launch-update/load_igvm",
+                    test_load_igvm);
+
+    if (getenv("LAUNCHUPDATE_DEBUG")) {
+        debug = true;
+    }
+    if (getenv("COCO")) {
+        confidential = true;
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..d23c76963e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -59,6 +59,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
+  (igvm.found() and
+   config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['launchupdate-test'] : []) +          \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
-- 
2.42.0


