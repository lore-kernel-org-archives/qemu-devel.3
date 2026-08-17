Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71003C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyDK-0000yK-Q8; Mon, 17 Aug 2026 10:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyDJ-0000rJ-6p
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyDF-0002ml-0l
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XER8W57BiJJLRtK/OlZrMpYMv+YG/Hs7ea3NGyBppDY=;
 b=F5L31tkN3QRGoN8qbfgo1eXSGuJl1Luq7MRLUo3GxJqm93gJkoumZLaTz2CbQNIfMcKK3T
 Ssam8IwFtXeRePOtyl9wpfhAHkYnZgOXOkn56zU6eDw9cjFkUJT4Kerz4mdfB1VGGQPU3g
 LB7xj9JseXXSRkgbRw5fO7XYCKsSUig=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-asYPk4trOFOFhUprtPBzDg-1; Mon, 17 Aug 2026 10:21:13 -0400
X-MC-Unique: asYPk4trOFOFhUprtPBzDg-1
X-Mimecast-MFC-AGG-ID: asYPk4trOFOFhUprtPBzDg_1786976473
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca3673560so60328035ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976472; x=1787581272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XER8W57BiJJLRtK/OlZrMpYMv+YG/Hs7ea3NGyBppDY=;
 b=f++cpOiHYd9JroIkql62VSFcfsrT1f/MCImp+6MYP8HKDMF2I9ozo+qmjSTsRcxHgi
 WTb6PtcHNzmQfNXpnz+caqeM0ZjhQ5Y/yvUVBzw3DMCaqeYd0mRlW0aZUWdDjJmK+1nU
 ewLenYGa7BVW2B2RmBtTur1uQBGYdhQ9r3IunMTuuF9DpHu00EN8SsNNBQDBf13dQJhb
 U24lX9s+UoIlNDhbYEf2Fmnktp2m2JCaLdEFB5xMVISsHSKCnrSCos230MKFwNOid9oS
 gsyvtqlFsFBgCR8l1QMftkjLl6E/c6Gb7edL6PgEskdi1MV9P3iV9agxFCJpk/HFKA2i
 hiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976472; x=1787581272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XER8W57BiJJLRtK/OlZrMpYMv+YG/Hs7ea3NGyBppDY=;
 b=O1ls9iQzQzKaRj9URZj+s6GHh9U1OUS9n56da6aDmypje+bV/TBuI4xJHlsAaaf7pP
 ZokrHb9UEkcN9+Rg07PCik7DEV7oarOVVz6lReHgS3vZpAaTODfL6YdgyvN0M+GtLZUF
 s/uo8+mchGyFDwZe3ApKkmRJtw9UUKT+zM4Z29mm9WPgj8TAjsLVGFjcpmzDe5lPo6Dl
 4/dEXXiW0TrEcQDAhGFJlej6mnilaVqEAdRJhhY+PIn0ZvPdygSdmPVbCJ3/V/uYPPg1
 NZMcJdQq2pYf+vxUUwjU4ZgIVWosdR61jgqYuxW6qobgv0JQ7ieaM/QIuE4+/4P/oHnw
 Ku/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1Hmz32uV/7gp8RiieFlph+fBVliXa+iX0a8XyCQn6C3xN8O8IuDi4L14fKPdm3o0u0mbRlmZLUhCm@nongnu.org
X-Gm-Message-State: AOJu0YyfagSgW/ibIfmnao0VnhlLLLCQvzlx+o5d2hFovOpX2/cI36Uv
 PVqOM0JF2BGynUOmcgCC8d2Y5JMTiuryT+WDwReeavR71ZHr/nzWexT1iA3H/QvqbqtwEHRLzFT
 3uwIx+HvzjC/RpD3jrLe12LbvQZXSgRnVh4o++5F+yWVWaFbyR3r+femJ
X-Gm-Gg: AR+sD12HzXSvO2AuB6yHX1gyTp2NPkshVml1TSz8zsIEDhvHU5gXRuZrbe7qtss1JfZ
 zupXzbfNLwbiTSC87nF69ktFvj4dn3oa9cGf5hoPRgchTAW4aWz3AyEqgxdupUAeKNBbvmMV4Wn
 UvP1iLjkjYaV54ubIVdDFq1W3LqBskAjPp70B47w4rOou9VXv/f1uiioopjITRUl9IXElYZq1Wv
 uJtXW/2HBGVv2E1xnkY9vowKQ9T9QuvsVLOko356mq9vQrpRTEKd7bjw3UQbTH4FBsbTGgKpMRF
 XXW1Vnm+CGZKGgF6/fKxMBC+P98g8wbsoYnSeAqE1x0YvHxM/FAxzFdVTRH5uFJoD2i1tEm0+wl
 cAqKKdA/Y/B7sUrxzWF8aGBSjF5MVTzGpKQ==
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d5c4f07dfcmr7966925ad.4.1786976472045; 
 Mon, 17 Aug 2026 07:21:12 -0700 (PDT)
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d5c4f07dfcmr7965995ad.4.1786976471318; 
 Mon, 17 Aug 2026 07:21:11 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:21:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v6 10/11] Add functional and unit tests for the
 vm-launch-update device
Date: Mon, 17 Aug 2026 19:50:05 +0530
Message-ID: <20260817142010.80693-11-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/functional/aarch64/meson.build          |   4 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 +
 tests/functional/x86_64/meson.build           |   4 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 tests/qtest/launchupdate-test.c               | 625 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 6 files changed, 716 insertions(+)
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index e81afd6c39..f0881bed16 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -25,6 +25,10 @@ tests_aarch64_system_quick = [
   'vmstate',
 ]
 
+if igvm.found()
+  tests_aarch64_system_quick += [ 'vm_launch_update_aarch' ]
+endif
+
 tests_aarch64_system_thorough = [
   'aspeed_ast2700a1',
   'aspeed_ast2700a2',
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
index 27b31f2e96..0353b2af8e 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -28,6 +28,10 @@ if not get_option('asan')
   tests_x86_64_system_quick += [ 'memlock' ]
 endif
 
+if igvm.found()
+  tests_x86_64_system_quick += [ 'vm_launch_update' ]
+endif
+
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'hotplug_blk',
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
index 0000000000..225c843df5
--- /dev/null
+++ b/tests/qtest/launchupdate-test.c
@@ -0,0 +1,625 @@
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
+static bool trace;
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
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
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
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
+
+    /* use default accelerator */
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
+static void check_error(void)
+{
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+    uint16_t status;
+    size_t filesize;
+
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
+
+    /* guest not started with IGVM and with default accelerator */
+    qs = qtest_pc_boot("-device vm-launch-update");
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.fw_image_size = 50;
+    launch_update.fw_image_addr = cpu_to_le64(0xdeadbeef);
+    launch_update.control |= VM_LAUNCHUPDATE_FORMAT_IGVM;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    memset(&launch_update, 0, sizeof(launch_update));
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMLAUNCHUPDATE,
+                                &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+    status = le64_to_cpu(launch_update.status);
+    /* should fail with NOT_IGVM_INIT */
+    g_assert_cmpint(status, ==, VM_LAUNCHUPDATE_NOT_IGVM_INIT);
+
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.fw_image_size = 50;
+    launch_update.fw_image_addr = cpu_to_le64(0xdeadbeef);
+    /* control set to 0, not VM_LAUNCHUPDATE_FORMAT_IGVM */
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    memset(&launch_update, 0, sizeof(launch_update));
+    filesize = qfw_cfg_get_file(fw_cfg, FILE_VMLAUNCHUPDATE,
+                                &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+    status = le64_to_cpu(launch_update.status);
+    /* should fail with LOAD_FAIL since it was not IGVM format */
+    g_assert_cmpint(status, ==, VM_LAUNCHUPDATE_LOAD_FAIL);
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
+static guint32 match_string(char *serial_f, const char *exp_out)
+{
+    GError *error = NULL;
+    g_autofree gchar *f_contents = NULL;
+    g_autofree GRegex *regex = NULL;
+    g_autofree GMatchInfo *match_info = NULL;
+    gsize len;
+    guint32 count = 0;
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
+    while (g_match_info_matches(match_info)) {
+        gchar *word = g_match_info_fetch(match_info, 0);
+        g_free(word);
+        g_match_info_next(match_info, &error);
+        count++;
+    }
+    g_regex_unref(regex);
+    return count;
+}
+
+static int wait_for_match(char *serial_f,
+                          const char *exp_out, int64_t timeout_s,
+                          guint32 count)
+{
+    time_t start, delta;
+    int ret = -1;
+
+    start = time(NULL);
+    while (1) {
+        if (match_string(serial_f, exp_out) == count) {
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
+static void set_test_params(const char **igvm_f, const char **igvm_init,
+                            const char **snp, const char **cgs)
+{
+    if (confidential) {
+        *snp = "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
+            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
+        *cgs = "confidential-guest-support=lsec0";
+        /*
+         * The following two IGVM files can be built from the source
+         * present in https://gitlab.com/anisinha/virt-firmware-rs .
+         * Typing 'make' from the top of this repository will build the
+         * IGVM files for both confidential and
+         * non-confidential tests. The IGVM files for the non-coco
+         * case has been checked-in into the QEMU repository for
+         * convenience and easy CI pipeline testing.
+         */
+        *igvm_f = "tests/data/igvm/snptest.igvm"; /* prints 'hello world' */
+        *igvm_init = "tests/data/igvm/snptest-nohello.igvm";
+    } else {
+        *igvm_f = "tests/data/igvm/hello.igvm";
+        *igvm_init = "tests/data/igvm/qemuinit.igvm";
+        *snp = "";
+        *cgs = "";
+    }
+
+    return;
+}
+
+static void set_expected_out(const char **exp_out, const char **exp_out2,
+                             const char **exp_out3)
+{
+    *exp_out = "Hello world!";
+    *exp_out2 = "Test succeeded!";
+    *exp_out3 = "boot process complete with initial igvm";
+
+    return;
+}
+
+static QOSState *set_qemu_args(const char *cgs, const char *tp, char *serialf,
+                               const char *igvm_init, const char *snp)
+{
+    QOSState *qs;
+
+    if (tp) {
+        qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
+                           "-device vm-launch-update %s "
+                           "-chardev file,id=serial0,path=%s "
+                           "-serial chardev:serial0 "
+                           "-object igvm-cfg,id=igvm0,file=%s %s",
+                           cgs, tp, serialf, igvm_init, snp);
+    } else {
+        qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
+                           "-device vm-launch-update "
+                           "-chardev file,id=serial0,path=%s "
+                           "-serial chardev:serial0 "
+                           "-object igvm-cfg,id=igvm0,file=%s %s",
+                           cgs, serialf, igvm_init, snp);
+    }
+
+    return qs;
+}
+
+static void test_load_igvm(void)
+{
+    const char *igvm_f;
+    const char *igvm_init;
+    int ser_fd;
+    g_autofree void *igvm_blob = NULL;
+    g_autofree char *serialtmp = NULL;
+    const char *exp_out;
+    const char *exp_out2;
+    const char *exp_out3;
+    const char *tracepoints = "--trace memory_region_finalize "
+        "--trace qigvm_cleanup_memory -D /tmp/qemu-debug.log ";
+    const char *snp, *cgs;
+    uint64_t gaddr;
+    size_t igvm_sz;
+    size_t filesize;
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+
+    if (!trace) {
+        tracepoints = "";
+    }
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    if (!qtest_has_accel("kvm")) {
+        g_test_skip("No KVM accelerator available");
+        return;
+    }
+
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
+
+    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
+    set_expected_out(&exp_out, &exp_out2, &exp_out3);
+
+    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
+        !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
+        g_test_skip("igvm file bundle(s) does not exist!");
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
+    qs = set_qemu_args(cgs, tracepoints, serialtmp, igvm_init, snp);
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    if (debug) {
+        fprintf(stderr, "target endianness: %s\n",
+                qtest_big_endian(qs->qts) ? "big" : "little");
+    }
+
+    /* exp_out3 should be printed once from initial boot */
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "initially booted with host igvm\n");
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
+    launch_update.fw_image_size = cpu_to_le64(igvm_sz);
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
+    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC, 1) == 0);
+    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "hello world found on console\n");
+    }
+
+    /* check if VM_LAUNCHUPDATE_CTL_HOST_IGVM function works */
+
+    /* set only VM_LAUNCHUPDATE_CTL_HOST_IGVM control without IGVM bundle */
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.control |= VM_LAUNCHUPDATE_CTL_HOST_IGVM;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    /* now reset the guest */
+    if (debug) {
+        fprintf(stderr,
+                "resetting again in order to restore host provided IGVM\n");
+    }
+    qtest_system_reset(qs->qts);
+
+    /*
+     * exp_out3 should be printed twice, once from initial boot,
+     * once from restoring host igvm.
+     */
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) == 0);
+
+    if (debug) {
+        fprintf(stderr, "booted with host igvm again\n");
+    }
+
+    close(ser_fd);
+    guest_free(&qs->alloc, gaddr);
+    pc_fw_cfg_uninit(fw_cfg);
+    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
+    qtest_quit(qs->qts);
+}
+
+static void test_set_ctrl_once_and_reset_to_host_igvm(void)
+{
+    const char *igvm_f;
+    const char *igvm_init;
+    int ser_fd;
+    g_autofree void *igvm_blob = NULL;
+    g_autofree char *serialtmp = NULL;
+    const char *exp_out;
+    const char *exp_out2;
+    const char *exp_out3;
+    const char *snp, *cgs;
+    uint64_t gaddr;
+    size_t igvm_sz;
+    size_t filesize;
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    if (!qtest_has_accel("kvm")) {
+        g_test_skip("No KVM accelerator available");
+        return;
+    }
+
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
+
+    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
+    set_expected_out(&exp_out, &exp_out2, &exp_out3);
+
+    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
+        !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
+        g_test_skip("igvm file bundle(s) does not exist!");
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
+    qs = set_qemu_args(cgs, NULL, serialtmp, igvm_init, snp);
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "initially booted with host igvm\n");
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
+    launch_update.fw_image_size = cpu_to_le64(igvm_sz);
+    launch_update.fw_image_addr = cpu_to_le64(gaddr);
+
+    /* set both host ctrl and format_igvm ctrl once */
+    launch_update.control |= VM_LAUNCHUPDATE_FORMAT_IGVM;
+    launch_update.control |= VM_LAUNCHUPDATE_CTL_HOST_IGVM;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    if (debug) {
+        fprintf(stderr, "resetting the virtual machine. This should load "
+                "user provided igvm.\n");
+    }
+
+    qtest_system_reset(qs->qts);
+
+    /* expected string should be printed on the console */
+    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC, 1) == 0);
+    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "hello world found on console\n");
+        fprintf(stderr, "Now resetting again in order to reset to host igvm\n");
+    }
+
+    qtest_system_reset(qs->qts);
+
+    /*
+     * exp_out3 should be printed twice, once from initial boot,
+     * once from restoring host igvm.
+     */
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) == 0);
+
+    if (debug) {
+        fprintf(stderr, "booted with host igvm\n");
+    }
+
+    close(ser_fd);
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
+    if (strcmp(arch, "x86_64")) {
+        g_test_skip("vmlaunchupdate tests are only available on x86_64\n");
+        return 0;
+    }
+
+    g_test_add_func("/vm-launch-update/cap", test_vm_launch_update_capability);
+    g_test_add_func("/vm-launch-update/disabled",
+                    test_vm_launch_update_disable);
+
+    g_test_add_func("/vm-launch-update/errorcheck", check_error);
+    g_test_add_func("/vm-launch-update/load_igvm",
+                    test_load_igvm);
+    g_test_add_func("/vm-launch-update/ctrl_set_once",
+                    test_set_ctrl_once_and_reset_to_host_igvm);
+
+    if (getenv("LAUNCHUPDATE_DEBUG")) {
+        debug = true;
+    }
+    if (getenv("LAUNCHUPDATE_TRACE")) {
+        trace = true;
+    }
+    if (getenv("COCO")) {
+        confidential = true;
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..12ed368997 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -61,6 +61,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_Q35') ? ['e820-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_Q35') ? ['dump-test'] : []) +                         \
+  (igvm.found() and
+   config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['launchupdate-test'] : []) +          \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
-- 
2.42.0


