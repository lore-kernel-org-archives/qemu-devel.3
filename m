Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C118C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTAU-0008S7-QB; Mon, 13 Jul 2026 22:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTAS-0008RW-Kj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTAM-0006cf-PL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fyQjkgvEsxqWCkcrmIFcUIZk2rH4A2mC8bViuOQNLM=;
 b=EdV8eO0sHU16sN137Lz+2/CQCan+4gtnNI+iIBhH7SQ7TbkqE9eGldxeqabQiPDbXTdLHq
 bZEsQx7ssRrC71vP78P7EcMyB8nBTGnTtX68jHkN1o3MIA0FVl5J7LzXkuLy8X8RN+fbDu
 UgzKouzW2SPCfewl78zz530cdMJmqKA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-VtHpoXXsPtWtd5wv9UrcTw-1; Mon, 13 Jul 2026 22:46:36 -0400
X-MC-Unique: VtHpoXXsPtWtd5wv9UrcTw-1
X-Mimecast-MFC-AGG-ID: VtHpoXXsPtWtd5wv9UrcTw_1783997195
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so9735022a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997195; x=1784601995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5fyQjkgvEsxqWCkcrmIFcUIZk2rH4A2mC8bViuOQNLM=;
 b=b2xCCwol94p4J/G8a5wXOx+ufH0u1RYIineaWZmGwm1QayIkvhaYf4TKEStyq5gNS9
 OU12HoigRxNcLGQbZq2wB4wsi+msFKu3cwkO54gwWe5xKMsf0e8zvgUhk7porR4LtCkJ
 jJkrtfJXhX6QxDJ2PS3ZxLGEjqaX3AdbmUiLROYnP6pccy8LeKy72+i26lcY2b+uL9aL
 loWZb61oyvDS9b+qVjHw+Puga2OqaKFA5dto3WUWW73EgCfBuxrfr2VTAIo3Hz1kVrbt
 ewJi0nbnOe60EtzzoKe0+337+KE6XrxsrSf2aEGrn3tLlANT6LaPhWKwKoePlK1iGVMp
 1k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997195; x=1784601995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5fyQjkgvEsxqWCkcrmIFcUIZk2rH4A2mC8bViuOQNLM=;
 b=bQQXTI906udit7YeKHR08qyYBN1HGrXVKWc2oPXZAdLmnIUkhy4Uf1Eqin8OasAXSX
 VNM2FaWEB8eHY1S/bmcnr6sAvci2+4InsxU7hj4S9okVbIKQT3QHi49/S7PaTRifgXNH
 kt5/xtS8gUf3eoIStD2YNUgHpbmyIeZD7Mf1euSC9sDlBnA32jezVo5nGPsyuPODqKZO
 KAWzXGfGXEdYFLdpxDtlCcmKJLrp9964xpNDv2MX8lIWTDZtqTLTiwl+IHhwxDMSzsjR
 xFSGyUYOo18VOGZ0qXVjyZpok8iw4Sorrzc02ivXtKlbcK0AZPWg2tmMgR/8rQ6CpJwO
 nLRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqn03bmHxUVcXp0+DvHwV3rLD5+Kkl3jjZumCeU9fjJXCaIZS24+EMgoHJ+3RpurWmZJ/OAlT9A4DRR@nongnu.org
X-Gm-Message-State: AOJu0Yz71OYntWUn0Sli4yHXAGtMSuCPB2jXIOZc8NefnUaQ+6s03hNF
 0nzn6sFy+ADSiozLM1wTmghhFa2RpXQXXcIlcOFWfc3OKhNCt/vKogUK4ei2nKYBnDGSxFIPZ7w
 uD10RPTz/hQSge8ZcVTQlQADenq7LtETySdXUC7TNKr3E4tzY1IOwWuSRvVcLyX1U
X-Gm-Gg: AfdE7clK31qfPrM5AI7H9A/Lwt+pGFO2bM3d6ZgKjo0S7XsSdmvYUHhrh5tgOXXOrV7
 9ajeybKx64cgfKjnAKOFpGCwWzvSe7tpJkOWINw3AITESrVMBst+CgWsVPtTrtgy6qW7Sjnjf+/
 GC2KxdmNYIoNBrt0BLLuECUfXfiKx10PHwvHsr4HyY+jjrmRVcGXVhmnrodveSZ3jjzAOAcckLN
 6pM1RfDvm0bffsnTCGBq/ipLeSFtZ5zxOr/ssfkoZdSTyhUD8p/60fW0bS2kCPbjbADs9etttgF
 rrwys+6deUEDrKPDjHeO8uZNicPmPHjeBqIC8aeh3/SFbdxVD62jDuha/JUb90mlRn8qwISPXKp
 1N9v/SCm7q0DRNxI2Dxx1GHHVCNXfKThhM2Oug09BR25x7w==
X-Received: by 2002:a05:6a21:7a8b:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3c357395a06mr411836637.20.1783997193002; 
 Mon, 13 Jul 2026 19:46:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a8b:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3c357395a06mr411728637.20.1783997191610; 
 Mon, 13 Jul 2026 19:46:31 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:30 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Alex Graf <graf@amazon.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] Add functional and unit tests for the vm-launch-update
 device
Date: Tue, 14 Jul 2026 08:15:27 +0530
Message-ID: <20260714024557.204578-9-anisinha@redhat.com>
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
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
 tests/data/igvm/hello.igvm                    | Bin 153624 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   1 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vm_launch_update.py           |  48 +++
 tests/qtest/launchupdate-test.c               | 408 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 7 files changed, 493 insertions(+)
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

diff --git a/tests/data/igvm/hello.igvm b/tests/data/igvm/hello.igvm
index 62196ba40a1bd63a7fb68cdb3eb26ac93fed40db..2d3ffda5b157c13d109ef965d1c0f41e9a34caf5 100644
GIT binary patch
literal 137112
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

literal 153624
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

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
index 27b31f2e96..079861ed77 100644
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
index 0000000000..247f9ea389
--- /dev/null
+++ b/tests/qtest/launchupdate-test.c
@@ -0,0 +1,408 @@
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
+static void check_error(void)
+{
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+    uint16_t status;
+    size_t filesize;
+
+    /* guest not started with IGVM */
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
+static void test_load_igvm(void)
+{
+    const char *igvm_f;
+    const char *igvm_init;
+    int ser_fd;
+    g_autofree void *igvm_blob = NULL;
+    g_autofree char *serialtmp = NULL;
+    const char exp_out[] = "Hello world!";
+    const char exp_out2[] = "Test succeeded!";
+    const char exp_out3[] = "boot process complete with initial igvm";
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
+    /* exp_out3 should be printed once from initial boot */
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) == 0);
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
+    /* set VM_LAUNCHUPDATE_CTL_HOST_IGVM control */
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
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_printerr("vmlaunchupdate tests are only available on x86\n");
+        exit(EXIT_FAILURE);
+    }
+
+    g_test_add_func("/vm-launch-update/cap", test_vm_launch_update_capability);
+    g_test_add_func("/vm-launch-update/disabled",
+                    test_vm_launch_update_disable);
+
+    g_test_add_func("/vm-launch-update/errorcheck", check_error);
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
index 56ff860e21..5c7883b48a 100644
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


