Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A615C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4o-0007XY-Nj; Fri, 21 Feb 2025 07:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4c-00077q-Tt
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4a-00079L-IO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efArqX3wxrFLzxI2BnYAIchHDFGDYnrZNrftosICqWI=;
 b=MpPgiqRaNsfloCCcj4Sl8kVaXns9Pt/CJ/NIuCN/wmBuoLAPeQGM9pPgw5V4+h4Z+0gMVp
 cfu1vXcpEcEa3+FiNslNjVkn2yovAZd7UpqvtFG0GCPFbsVwAopd5NsZ9qWWHiA7XcZrLc
 oens9hu89dczrGrIZT7uBJhvhtfy3T0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-24l28EmYPciw52PTCe4LvA-1; Fri, 21 Feb 2025 07:24:02 -0500
X-MC-Unique: 24l28EmYPciw52PTCe4LvA-1
X-Mimecast-MFC-AGG-ID: 24l28EmYPciw52PTCe4LvA_1740140641
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f20b530dfso2862748f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140641; x=1740745441;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efArqX3wxrFLzxI2BnYAIchHDFGDYnrZNrftosICqWI=;
 b=O+rvVp0Te7HXHyBYy9QJf/ewtGFp3bM4uVEl6DC+l4JkPIxhIH39pGtXqr485rLs32
 SGJEiniZDO2zL/5lByjsl2E+JNPAIXO1mewi1Q7p8RdbzbFRKyRJO8QPf+h3i+fBxVHI
 4jMVsXqnTEPAOL4EOeJfjyr5hGV9hImLr9lPCol/tY412Oa/GMEVGDh0CMKPQz2LkQ91
 +A+GsLfUZ3sfTMW8zc6FLxtgVHEC9quL0CmksN0Zw2Hl0FDOhwIBYNQ7meoCctN4zxjY
 +fauyK6WE6GQKf2O0PPQ4u6qnfRsHuRFOxOi598Ujp8AGZwTLlAIkOPlnsqElgqWRqu+
 vYkQ==
X-Gm-Message-State: AOJu0YxTyCt8d3B9OmctVvP00oS0ybqi66yFtVLZX/fHkiGAqCBT0bb8
 TId6zB4rEwBTs+ZGUcqoiMZxi+/YJpFoMGLmG+UQs6s+gk246ApaZvrT8Ij70axFKQeCfR18yZ1
 fenv91t1H7jrME8r1/xWFaczPsrXn8sNWPQ27dwA311cwHGSsddleQ3K8g9NjzL45C/swXTKBYT
 4A47PTXYujrH+smUmwkXF1+pJNqLu8lQ==
X-Gm-Gg: ASbGnctS3So6Abt41bhsWwJjxFQxg5Kll/V+Df7p4V1BeVRWO3jd8tt03w77V9xqEe2
 EqKt8pvu87PEk48p+/pSJBQL0ZlTgmkhLquy9au6T/zCv314h4gdGzL1wOxhonYtu6T1IXmhQz+
 U5n1GNEcDuObt+xk2xGNO9GzR3lo1P+68fWwdLQ/PeO1kCpH/CxZ7JieAjthCwGRa+wd2vHFCeQ
 MaJP4o132JGQG46/Q1rRqBKRs06vPTudPnE2+GgvO+4zQIp61fDPfC5pOWXDJTATr/aX0fhu8pT
 i+Q33g==
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id
 ffacd0b85a97d-38f70783f03mr1630991f8f.7.1740140640579; 
 Fri, 21 Feb 2025 04:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBcs0LLK9M/2eQd/v420ecawU/E6E9cWuNXscwVXqJLjISObGrjJp+2QPvcf0Jj6gPFCnmDQ==
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id
 ffacd0b85a97d-38f70783f03mr1630967f8f.7.1740140640110; 
 Fri, 21 Feb 2025 04:24:00 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dcc50sm23682854f8f.34.2025.02.21.04.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:59 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 25/41] hw/virtio: reset virtio balloon stats on machine reset
Message-ID: <1456e90653c46aceb3dd83a7b9889a32aad7700d.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Message-Id: <20250204094202.2183262-1-berrange@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-balloon.h      |   4 +
 hw/virtio/virtio-balloon.c              |  30 ++++-
 MAINTAINERS                             |   1 +
 tests/functional/meson.build            |   2 +
 tests/functional/test_virtio_balloon.py | 161 ++++++++++++++++++++++++
 5 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_virtio_balloon.py

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index b12c18a43b..0456c211c6 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -16,6 +16,7 @@
 #define QEMU_VIRTIO_BALLOON_H
 
 #include "standard-headers/linux/virtio_balloon.h"
+#include "hw/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "system/iothread.h"
 #include "qom/object.h"
@@ -71,6 +72,9 @@ struct VirtIOBalloon {
 
     bool qemu_4_0_config_size;
     uint32_t poison_val;
+
+    /* State of the resettable container */
+    ResettableState reset_state;
 };
 
 #endif
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ad05768ded..2eb5a14fa2 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,7 +31,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
-
+#include "system/reset.h"
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
+static void virtio_balloon_reset_enter(Object *obj, ResetType type)
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
@@ -1038,6 +1062,7 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_balloon_properties);
     dc->vmsd = &vmstate_virtio_balloon;
@@ -1050,6 +1075,9 @@ static void virtio_balloon_class_init(ObjectClass *klass, void *data)
     vdc->get_features = virtio_balloon_get_features;
     vdc->set_status = virtio_balloon_set_status;
     vdc->vmsd = &vmstate_virtio_balloon_device;
+
+    rc->get_state = virtio_balloon_get_reset_state;
+    rc->phases.enter = virtio_balloon_reset_enter;
 }
 
 static const TypeInfo virtio_balloon_info = {
diff --git a/MAINTAINERS b/MAINTAINERS
index a928ce3e41..013a57d5bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2246,6 +2246,7 @@ F: include/hw/virtio/virtio-balloon.h
 F: system/balloon.c
 F: include/system/balloon.h
 F: tests/qtest/virtio-balloon-test.c
+F: tests/functional/test_virtio_balloon.py
 
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cf80924ddc..2d399cc464 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -44,6 +44,7 @@ test_timeouts = {
   'riscv64_tuxrun' : 120,
   's390x_ccw_virtio' : 420,
   'sh4_tuxrun' : 240,
+  'virtio_balloon': 120,
 }
 
 tests_generic_system = [
@@ -242,6 +243,7 @@ tests_x86_64_system_thorough = [
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
+  'virtio_balloon',
   'virtio_gpu',
   'x86_64_hotplug_cpu',
   'x86_64_tuxrun',
diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
new file mode 100755
index 0000000000..67b48e1b4e
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
+        # 'stop', and thus have not loaded the virtio-balloon
+        # driver in the guest
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
MST


