Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDC5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorg-0000zo-C2; Wed, 20 May 2026 17:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorZ-0000QM-F3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorW-00059r-Va
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P78ckPc3ZPybKo5juuBAaJzw+Cy9pLdmq2erCPFjXPs=;
 b=HKqevWHtvGIVl9X2PFvbcupAoJ0VFZiPzijl3ffK0ykW/6fJ5OIHRFJGVDqNBPcQUrOrfS
 /FGk+0cQyimbRxItTYfMAdUnY2/Pf0YYyZ7nDfXtpIhz6R8MWmjzKFITmzr9SyyMqq0E/k
 KQ6vDddWdUw+x7P+ODLR3uecOweVilk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-fPD1x9S7N-Oc_PVpdi9kWA-1; Wed,
 20 May 2026 17:53:56 -0400
X-MC-Unique: fPD1x9S7N-Oc_PVpdi9kWA-1
X-Mimecast-MFC-AGG-ID: fPD1x9S7N-Oc_PVpdi9kWA_1779314035
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7131800283
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:55 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74B4F1684; Wed, 20 May 2026 21:53:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:40 +0400
Subject: [PATCH 39/40] build-sys: make HMP source files conditional on have_hmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-39-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12291;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kPuxRSfsK1rprdQnXUjLN4BoAarEMBpDqza6xvogyjg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyELy9KzkmoWHgEbSWczEFAWuGKee5MIEEEI
 F349rnrtuyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5fGJD/9feTW0I/ye6kGXRzisebWhLbfZ4zC/cBdP5RFQJHYzzLT4hCdZd6my/mGD6OqF3M2FYd/
 LDrlQ8t8dzVlOb8QZhUloFwUgbw3bmBTWqLBUleoFyGkGAxe0i52O6Irb2NnJrMFw92tgDFuHbq
 3HnqdeDgQ2EOL+Dq9X1HiAWeTFkIEzkzmABlnFmusDtbjnzZJ2RPaQLwdNiqJTf+eKDS2nWNpKQ
 f7TVioruAqMevi+XFP9KumAvLqGS/jHWURXH+8eiKOOwPDe8Rg1/VZrJkUv+zPo1coUBG01ZYqb
 J/5DrPb9BSwb3BnQnahNnO30sNnH5f5Nh86Vx2ApxImgDmgQ+jvot4EOQwE+QcdEr1SDFVVAbYb
 uA6nQDS3HlqylDKH9E2n2N3SFxtF606eSZ4I6eo+HKlA9NktzExGaj4WezwXyMViArWy1V69R/N
 mrxQQ/r3cCA1DNVu1MJe+jPPQ5urbVDFZBArlRzcaT9aIF2YPxKN4YsXyFT1AIbRWL78CWDwrXs
 0muuPA8zxzHjLfnqNe1vv3mQhsamFziFYyrFmdrfw4y9SEZXzUfxjcOsI69Z41U9ADyHj9vlUzz
 8TNxkbthb5vw36hD5ZZ4CgJqa5OLTy8+x56BrN6+3b7yH0p+8BYYRtjkmkw+dl4PqUW0Mi2GJL2
 pGWIUZj4U5ZtH7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Exclude all *-hmp-cmds.c files and HMP-only source files from the
build when HMP is disabled.

Also conditionalise the hmp-commands.hx header generation and the
test-hmp qtest.

Together with the preceding CONFIG_HMP guards, this makes QEMU
buildable with -Dhmp=disabled.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build               |  2 +-
 audio/meson.build         |  4 +++-
 backends/meson.build      |  5 ++++-
 block/monitor/meson.build |  4 +++-
 chardev/meson.build       |  5 ++++-
 disas/meson.build         |  4 +++-
 dump/meson.build          |  5 ++++-
 hw/core/meson.build       |  5 +++--
 hw/i386/meson.build       |  4 +++-
 hw/net/meson.build        |  4 +++-
 hw/pci/meson.build        |  4 +++-
 hw/virtio/meson.build     |  4 +++-
 migration/meson.build     |  4 +++-
 monitor/meson.build       |  9 +++++++--
 net/meson.build           |  4 +++-
 qom/meson.build           |  4 +++-
 stats/meson.build         |  5 ++++-
 stubs/meson.build         | 12 +++++++-----
 system/meson.build        |  9 +++++++--
 tests/qtest/meson.build   |  8 +++++++-
 trace/meson.build         |  5 ++++-
 ui/meson.build            |  4 +++-
 22 files changed, 85 insertions(+), 29 deletions(-)

diff --git a/meson.build b/meson.build
index e83cfe56cf3..63f2d687b69 100644
--- a/meson.build
+++ b/meson.build
@@ -3538,7 +3538,7 @@ hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
   ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
 ]
-if have_system
+if have_system and have_hmp
   hx_headers += [
     ['hmp-commands.hx', 'hmp-commands.h'],
     ['hmp-commands-info.hx', 'hmp-commands-info.h'],
diff --git a/audio/meson.build b/audio/meson.build
index 0e33b6f9836..6655f601b11 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -9,7 +9,9 @@ audio_ss.add(files(
 ))
 
 # deprecated since v10.2, to be removed
-system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
+if have_hmp
+  system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
+endif
 
 audio_modules = {}
 foreach m : [
diff --git a/backends/meson.build b/backends/meson.build
index 60021f45d12..a59729f56fe 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -1,6 +1,5 @@
 system_ss.add([files(
   'cryptodev-builtin.c',
-  'cryptodev-hmp-cmds.c',
   'cryptodev.c',
   'hostmem-ram.c',
   'hostmem.c',
@@ -10,6 +9,10 @@ system_ss.add([files(
   'confidential-guest-support.c',
 ), numa])
 
+if have_hmp
+  system_ss.add(files('cryptodev-hmp-cmds.c'))
+endif
+
 if host_os != 'windows'
   system_ss.add(files('rng-random.c'))
   if host_os != 'emscripten'
diff --git a/block/monitor/meson.build b/block/monitor/meson.build
index 74faced9e17..2d5c157a739 100644
--- a/block/monitor/meson.build
+++ b/block/monitor/meson.build
@@ -1,3 +1,5 @@
-system_ss.add(files('block-hmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('block-hmp-cmds.c'))
+endif
 block_ss.add(files('bitmap-qmp-cmds.c'))
 system_ss.add(files('qmp-cmds.c'))
diff --git a/chardev/meson.build b/chardev/meson.build
index 56ee39ac0b0..031b6d7238c 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -30,11 +30,14 @@ endif
 chardev_ss = chardev_ss.apply({})
 
 system_ss.add(files(
-    'char-hmp-cmds.c',
     'msmouse.c',
     'wctablet.c',
     'testdev.c'))
 
+if have_hmp
+    system_ss.add(files('char-hmp-cmds.c'))
+endif
+
 chardev_modules = {}
 
 if brlapi.found()
diff --git a/disas/meson.build b/disas/meson.build
index 42977a1f74d..b382550e41f 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -20,5 +20,7 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
     'objdump.c'
 ))
 common_ss.add(files('disas-common.c'))
-system_ss.add(files('disas-mon.c'))
+if have_hmp
+  system_ss.add(files('disas-mon.c'))
+endif
 specific_ss.add(capstone)
diff --git a/dump/meson.build b/dump/meson.build
index 26e1561ed48..bef8276aa5a 100644
--- a/dump/meson.build
+++ b/dump/meson.build
@@ -1,3 +1,6 @@
-system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
+system_ss.add([files('dump.c'), snappy, lzo])
+if have_hmp
+  system_ss.add(files('dump-hmp-cmds.c'))
+endif
 specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-x86.c'))
 system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-stubs.c'))
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8a96567de8f..8fe776d2c86 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,13 +26,11 @@ system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
-
 system_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'hotplug.c',
   'loader.c',
-  'machine-hmp-cmds.c',
   'machine-qmp-cmds.c',
   'machine.c',
   'nmi.c',
@@ -46,6 +44,9 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
+if have_hmp
+  system_ss.add(files('machine-hmp-cmds.c'))
+endif
 user_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index b611fbb5a7f..125f4ce894c 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,7 +24,9 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
-stub_ss.add(files('sgx-hmp-stub.c'))
+if have_hmp
+  stub_ss.add(files('sgx-hmp-stub.c'))
+endif
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 31025874699..76fe3d7dda6 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -68,6 +68,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
   'rocker/rocker_world.c',
 ))
 stub_ss.add(files('rocker/rocker-stubs.c'))
-system_ss.add(files('rocker/rocker-hmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('rocker/rocker-hmp-cmds.c'))
+endif
 
 subdir('can')
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index a6cbd89c0a3..984c7327e5d 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -5,12 +5,14 @@ pci_ss.add(files(
   'pci.c',
   'pci_bridge.c',
   'pci_host.c',
-  'pci-hmp-cmds.c',
   'pci-qmp-cmds.c',
   'pcie_sriov.c',
   'shpc.c',
   'slotid_cap.c'
 ))
+if have_hmp
+  pci_ss.add(files('pci-hmp-cmds.c'))
+endif
 # The functions in these modules can be used by devices too.  Since we
 # allow plugging PCIe devices into PCI buses, include them even if
 # CONFIG_PCI_EXPRESS=n.
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index e0566a60de7..4b80e4e1c87 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -97,6 +97,8 @@ stub_ss.add(files('vhost-stub.c'))
 stub_ss.add(files('virtio-stub.c'))
 stub_ss.add(files('virtio-md-stubs.c'))
 
-system_ss.add(files('virtio-hmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('virtio-hmp-cmds.c'))
+endif
 
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
diff --git a/migration/meson.build b/migration/meson.build
index e583822dec6..bb39d987110 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -36,7 +36,9 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
 ), gnutls, zlib)
-system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
+if have_hmp
+  system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
+endif
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 4c58dd148c0..f67e0291a42 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -2,8 +2,13 @@ qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
 
 system_ss.add(files(
   'fds.c',
-  'hmp-cmds.c',
-  'hmp.c',
   'qemu-config-qmp.c',
   'qmp-cmds.c',
 ))
+
+if have_hmp
+  system_ss.add(files(
+    'hmp-cmds.c',
+    'hmp.c',
+  ))
+endif
diff --git a/net/meson.build b/net/meson.build
index da6ea635e95..bb7d70c6c36 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -8,7 +8,6 @@ system_ss.add(files(
   'filter-mirror.c',
   'filter.c',
   'hub.c',
-  'net-hmp-cmds.c',
   'net.c',
   'queue.c',
   'socket.c',
@@ -16,6 +15,9 @@ system_ss.add(files(
   'stream_data.c',
   'util.c',
 ))
+if have_hmp
+  system_ss.add(files('net-hmp-cmds.c'))
+endif
 
 if get_option('replication').allowed() or \
     get_option('colo_proxy').allowed()
diff --git a/qom/meson.build b/qom/meson.build
index bd6f4aadd78..022d3ad5c8f 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -10,4 +10,6 @@ if have_system
 endif
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
-system_ss.add(files('qom-hmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('qom-hmp-cmds.c'))
+endif
diff --git a/stats/meson.build b/stats/meson.build
index 0728dafcd1c..b5f68a94052 100644
--- a/stats/meson.build
+++ b/stats/meson.build
@@ -1 +1,4 @@
-system_ss.add(files('stats-hmp-cmds.c', 'stats-qmp-cmds.c'))
+system_ss.add(files('stats-qmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('stats-hmp-cmds.c'))
+endif
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2f2680b19..fe77107cc86 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -85,11 +85,13 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
-  stub_ss.add(files('hmp-cmd-info_mem.c'))
-  stub_ss.add(files('hmp-cmd-info_sev.c'))
-  stub_ss.add(files('hmp-cmd-info_tlb.c'))
-  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
-  stub_ss.add(files('hmp-cmds-target-i386.c'))
+  if have_hmp
+    stub_ss.add(files('hmp-cmd-info_mem.c'))
+    stub_ss.add(files('hmp-cmd-info_sev.c'))
+    stub_ss.add(files('hmp-cmd-info_tlb.c'))
+    stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+    stub_ss.add(files('hmp-cmds-target-i386.c'))
+  endif
 endif
 
 if have_system or have_user
diff --git a/system/meson.build b/system/meson.build
index 9cdfe1b3e75..a1afc6fee5f 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -21,12 +21,17 @@ system_ss.add(files(
   'qtest.c',
   'rtc.c',
   'runstate-action.c',
-  'runstate-hmp-cmds.c',
   'runstate.c',
-  'tpm-hmp-cmds.c',
   'watchpoint.c',
 ))
 
+if have_hmp
+  system_ss.add(files(
+    'runstate-hmp-cmds.c',
+    'tpm-hmp-cmds.c',
+  ))
+endif
+
 if have_tpm
   system_ss.add(files('tpm.c'))
 endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 728dde54b3f..acd175a679c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -26,7 +26,13 @@ qtests_generic = [
   'qmp-test',
   'qmp-cmd-test',
   'qom-test',
-  'test-hmp',
+]
+if have_hmp
+  qtests_generic += [
+    'test-hmp',
+  ]
+endif
+qtests_generic += [
   'qos-test',
   'readconfig-test',
   'netdev-socket',
diff --git a/trace/meson.build b/trace/meson.build
index d89a0db82a1..4e5681c44ca 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,4 +1,7 @@
-system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
+system_ss.add(files('control-target.c'))
+if have_hmp
+  system_ss.add(files('trace-hmp-cmds.c'))
+endif
 trace_rs_targets = []
 trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
diff --git a/ui/meson.build b/ui/meson.build
index 1b8f71796e4..66790c29f44 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -57,10 +57,12 @@ system_ss.add(files(
   'input-legacy.c',
   'input-barrier.c',
   'input.c',
-  'ui-hmp-cmds.c',
   'ui-qmp-cmds.c',
   'util.c',
 ))
+if have_hmp
+  system_ss.add(files('ui-hmp-cmds.c'))
+endif
 system_ss.add(ui)
 system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
 if dbus_display

-- 
2.54.0


