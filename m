Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76293E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxrP-0005bA-Ss; Wed, 18 Dec 2024 12:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNxrO-0005az-PH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNxrM-0001KM-LI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734542958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5tokgQBzHEagMosxvso3PWuoLSEI2dJOOavHCTAly1c=;
 b=Ypk65A/habI3LO6HFiGAOAeAQpnr5/119nlYsDDIK3gYVC5aUAjlPZOY5lSUOr91K1IGd9
 M3Ak0EfeP8nTkuJGcM7AxRLJn4s4E59Z8ycXdayF9B6dBTfut/FxOu428k6jL8+VvaqyD+
 UutaXhq6QzYgoDi4H3w+BjzI2O8XgHM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-z3bjGKO-MsGQFdaZP-ZbHA-1; Wed,
 18 Dec 2024 12:29:17 -0500
X-MC-Unique: z3bjGKO-MsGQFdaZP-ZbHA-1
X-Mimecast-MFC-AGG-ID: z3bjGKO-MsGQFdaZP-ZbHA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA8941955D4D
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 17:29:15 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE9951956053; Wed, 18 Dec 2024 17:29:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/virtio: reset virtio balloon stats on machine reset
Date: Wed, 18 Dec 2024 17:29:12 +0000
Message-ID: <20241218172912.4170899-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

When a machine is first booted, all virtio balloon stats are initialized
to their default value -1 (18446744073709551615 when represented as
unsigned).

They remain that way while the firmware is loading, and early phase of
guest OS boot, until the virtio-balloon driver is activated. Thereafter
the reported stats reflect the guest OS activity.

When a machine reset is performed, however, the virtio-balloon stats are
left unchanged by QEMU, despite the guest OS no longer updating them,
nor indeed even still existing.

IOW, the mgmt app keeps getting stale stats until the guest OS starts
once more and loads the virtio-balloon driver (if ever). At that point
the app will see a discontinuity in the reported values as they sudden
jump from the stale value to the new value. This jump is indigituishable
from a valid data update.

While there is an "last-updated" field to report on the freshness of
the stats, that does not unambiguously tell the mgmt app whether the
stats are still conceptually relevant to the current running workload.

It is more conceptually useful to reset the stats to their default
values on machine reset, given that the previous guest workload the
stats reflect no longer exists. The mgmt app can now clearly identify
that there are is no stats information available from the current
executing workload.

The 'last-updated' time is also reset back to 0.

IOW, on every machine reset, the virtio stats are in the same clean
state they were when the macine first powered on.

A functional test is added to validate this behaviour with a real
world guest OS.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

One side-thought I have, is whether it makes sense to add a
'reset-count' field in the virtio stats, alongside the
'last-updated' field. While apps can infer a reset from seeing
the stats all go back to their defaults, an explicit flag is
simpler...

 MAINTAINERS                             |   1 +
 hw/virtio/virtio-balloon.c              |  30 ++++-
 include/hw/virtio/virtio-balloon.h      |   4 +
 tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++
 4 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_virtio_balloon.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 822f34344b..1380d53d03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2234,6 +2234,7 @@ F: include/hw/virtio/virtio-balloon.h
 F: system/balloon.c
 F: include/sysemu/balloon.h
 F: tests/qtest/virtio-balloon-test.c
+F: tests/functional/test_virtio_balloon.py
 
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ab2ee30475..fe0854e198 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,7 +31,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
-
+#include "sysemu/reset.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
@@ -910,6 +910,8 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     }
 
     reset_stats(s);
+    s->stats_last_update = 0;
+    qemu_register_resettable(OBJECT(dev));
 }
 
 static void virtio_balloon_device_unrealize(DeviceState *dev)
@@ -917,6 +919,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
 
+    qemu_unregister_resettable(OBJECT(dev));
     if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
         object_unref(OBJECT(s->iothread));
@@ -987,6 +990,27 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
+static ResettableState *virtio_balloon_get_reset_state(Object *obj)
+{
+    VirtIOBalloon *s = VIRTIO_BALLOON(obj);
+    return &s->reset_state;
+}
+
+static void virtio_balloon_system_reset_enter(Object *obj, ResetType type)
+{
+    VirtIOBalloon *s = VIRTIO_BALLOON(obj);
+
+    /*
+     * When waking up from standby/suspend-to-ram, do not reset stats.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    reset_stats(s);
+    s->stats_last_update = 0;
+}
+
 static void virtio_balloon_instance_init(Object *obj)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
@@ -1039,6 +1063,7 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_balloon_properties);
     dc->vmsd = &vmstate_virtio_balloon;
@@ -1051,6 +1076,9 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
     vdc->get_features = virtio_balloon_get_features;
     vdc->set_status = virtio_balloon_set_status;
     vdc->vmsd = &vmstate_virtio_balloon_device;
+
+    rc->get_state = virtio_balloon_get_reset_state;
+    rc->phases.enter = virtio_balloon_system_reset_enter;
 }
 
 static const TypeInfo virtio_balloon_info = {
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 5139cf8ab6..e8a4dcbee2 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -16,6 +16,7 @@
 #define QEMU_VIRTIO_BALLOON_H
 
 #include "standard-headers/linux/virtio_balloon.h"
+#include "hw/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "sysemu/iothread.h"
 #include "qom/object.h"
@@ -71,6 +72,9 @@ struct VirtIOBalloon {
 
     bool qemu_4_0_config_size;
     uint32_t poison_val;
+
+    /* State of the resettable container */
+    ResettableState reset_state;
 };
 
 #endif
diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
new file mode 100755
index 0000000000..d66df4b2cd
--- /dev/null
+++ b/tests/functional/test_virtio_balloon.py
@@ -0,0 +1,161 @@
+#!/usr/bin/env python3
+#
+# virtio-balloon tests
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import time
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+
+UNSET_STATS_VALUE = 18446744073709551615
+
+
+class VirtioBalloonx86(QemuSystemTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    ASSET_DISKIMAGE = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'),
+        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
+
+    DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
+                             'rd.rescue')
+
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(
+            self,
+            success_message,
+            failure_message="Kernel panic - not syncing",
+            vm=vm,
+        )
+
+    def mount_root(self):
+        self.wait_for_console_pattern('Entering emergency mode.')
+        prompt = '# '
+        self.wait_for_console_pattern(prompt)
+
+        exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
+                                          prompt)
+        exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
+                                          prompt)
+        exec_command_and_wait_for_pattern(self, "modprobe virtio-balloon",
+                                          prompt)
+
+    def assert_initial_stats(self):
+        ret = self.vm.qmp('qom-get',
+                          {'path': '/machine/peripheral/balloon',
+                           'property': 'guest-stats'})['return']
+        when = ret.get('last-update')
+        assert when == 0
+        stats = ret.get('stats')
+        for name, val in stats.items():
+            assert val == UNSET_STATS_VALUE
+
+    def assert_running_stats(self, then):
+        ret = self.vm.qmp('qom-get',
+                          {'path': '/machine/peripheral/balloon',
+                           'property': 'guest-stats'})['return']
+        when = ret.get('last-update')
+        now = time.time()
+
+        assert when > then and when < now
+        stats = ret.get('stats')
+        # Stat we expect this particular Kernel to have set
+        expectData = [
+            "stat-available-memory",
+            "stat-disk-caches",
+            "stat-free-memory",
+            "stat-htlb-pgalloc",
+            "stat-htlb-pgfail",
+            "stat-major-faults",
+            "stat-minor-faults",
+            "stat-swap-in",
+            "stat-swap-out",
+            "stat-total-memory",
+        ]
+        for name, val in stats.items():
+            if name in expectData:
+                assert val != UNSET_STATS_VALUE
+            else:
+                assert val == UNSET_STATS_VALUE
+
+    def test_virtio_balloon_stats(self):
+        self.set_machine('q35')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        diskimage_path = self.ASSET_DISKIMAGE.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args("-S")
+        self.vm.add_args("-cpu", "max")
+        self.vm.add_args("-m", "2G")
+        # Slow down BIOS phase with boot menu, so that after a system
+        # reset, we can reliably catch the clean stats again in BIOS
+        # phase before the guest OS launches
+        self.vm.add_args("-boot", "menu=on")
+        self.vm.add_args("-machine", "q35,accel=kvm:tcg")
+        self.vm.add_args("-device", "virtio-balloon,id=balloon")
+        self.vm.add_args('-drive',
+                         f'file={diskimage_path},if=none,id=drv0,snapshot=on')
+        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
+                         'drive=drv0,id=virtio-disk0,bootindex=1')
+
+        self.vm.add_args(
+            "-kernel",
+            kernel_path,
+            "-initrd",
+            initrd_path,
+            "-append",
+            self.DEFAULT_KERNEL_PARAMS
+        )
+        self.vm.launch()
+
+        # Poll stats at 100ms
+        self.vm.qmp('qom-set',
+                    {'path': '/machine/peripheral/balloon',
+                     'property': 'guest-stats-polling-interval',
+                     'value': 100 })
+
+        # We've not run any guest code yet, neither BIOS or guest,
+        # so stats should be all default values
+        self.assert_initial_stats()
+
+        self.vm.qmp('cont')
+
+        then = time.time()
+        self.mount_root()
+        self.assert_running_stats(then)
+
+        # Race window between these two commands, where we
+        # rely on '-boot menu=on' to (hopefully) ensure we're
+        # still executing the BIOS when QEMU processes the
+        # 'stop', and thus not loaded the virtio-balloon driver
+        # in the guest
+        self.vm.qmp('system_reset')
+        self.vm.qmp('stop')
+
+        # If the above assumption held, we're in BIOS now and
+        # stats should be all back at their default values
+        self.assert_initial_stats()
+        self.vm.qmp('cont')
+
+        then = time.time()
+        self.mount_root()
+        self.assert_running_stats(then)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


