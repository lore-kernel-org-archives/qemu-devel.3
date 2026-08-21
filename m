Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C74C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRpz-0006Z0-Vv; Fri, 21 Aug 2026 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpx-0006Xm-Qp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpu-0001ZH-5o
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8XQg6BQj4p/2z8ChYO9Qm5IxmkU3ohV5BRIh6gosgo=;
 b=RrOTCDAtidu6UGQNRjSKumjGMnbIlaUhFS1PqZ4Dbgo7PRVOMIoCLCICrKD1iE7ad55/8U
 Rl/yD6cT5pGXSOBMT+EwIHBsuEssvwMucvO3sBibo2+wb8drIfYpC8gwraIKV997B6s178
 XwF9hvFwBkJ9sQNAY5q8T3YWQ0/Rnew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-J99oPZx7Pt-wooSZxQiALQ-1; Fri,
 21 Aug 2026 12:11:13 -0400
X-MC-Unique: J99oPZx7Pt-wooSZxQiALQ-1
X-Mimecast-MFC-AGG-ID: J99oPZx7Pt-wooSZxQiALQ_1787328672
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1145A1954222; Fri, 21 Aug 2026 16:11:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 820371800346; Fri, 21 Aug 2026 16:11:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 378851801249; Fri, 21 Aug 2026 18:11:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Graf <graf@amazon.com>
Subject: [PULL 11/12] Add functional and unit tests for the vm-launch-update
 device
Date: Fri, 21 Aug 2026 18:10:59 +0200
Message-ID: <20260821161103.3489298-12-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

This patchset adds functional and unit tests that exercize various functions
and behaviors of vm-launch-update device. It uses the IGVM files that were
introduced in the previous patch for exercizing the hypervisor interface.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260817142010.80693-11-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .../aarch64/test_vm_launch_update_aarch.py    |  33 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 tests/qtest/launchupdate-test.c               | 625 ++++++++++++++++++
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/x86_64/meson.build           |   4 +
 tests/qtest/meson.build                       |   2 +
 6 files changed, 716 insertions(+)
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

diff --git a/tests/functional/aarch64/test_vm_launch_update_aarch.py b/tests/functional/aarch64/test_vm_launch_update_aarch.py
new file mode 100755
index 000000000000..2b3d7cf4a309
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
diff --git a/tests/functional/x86_64/test_vm_launch_update.py b/tests/functional/x86_64/test_vm_launch_update.py
new file mode 100755
index 000000000000..aac7ef915f4e
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
index 000000000000..225c843df5b9
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
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index e81afd6c39fc..f0881bed1671 100644
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
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 27b31f2e966f..0353b2af8e1d 100644
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620ea..12ed368997b6 100644
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
2.55.0


