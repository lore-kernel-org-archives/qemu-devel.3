Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2CECDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrXH-0007uD-3D; Thu, 25 Jun 2026 17:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXF-0007mO-4a
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXC-00047N-NI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29Z3rBfPd1tCZESqoKoleKg6oLMW7kB/G4ySrNtwxvo=;
 b=DSGp+eW3R3qsCDNOB8/zLP563WQ1222VHCUCpNfxvwmYmz+wAAzYpbDKNA83gwt6Ah8Hcj
 YxELRd6bfOjxftw6CXZhDYou1PfStikfikW+/8WXoRFwtXSn9M3jsjrr5BGNz6ZsZRTWSR
 r11CxAdwTM/qA7nsRT1l3sSHSjPgGlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-I_KXnCMKOuWr6OwPvOk5-w-1; Thu,
 25 Jun 2026 17:22:52 -0400
X-MC-Unique: I_KXnCMKOuWr6OwPvOk5-w-1
X-Mimecast-MFC-AGG-ID: I_KXnCMKOuWr6OwPvOk5-w_1782422571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C486D1955E75; Thu, 25 Jun 2026 21:22:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34DD61800347; Thu, 25 Jun 2026 21:22:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:38 +0400
Subject: [PATCH v2 37/39] build-sys: make HMP source files conditional on
 have_hmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-37-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13380;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2JAfSLU5I4P1cKSyjKnc5riI/bxpf8qr0sQZXLFVhc4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZte23FKJP0Ukn0mATJSaYhKsWUbzZhPyH+Kp
 xBpnUCPvMCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5bpbEACnG69rxtx7ir0E45pV+2uhBTRSMWAKCw1NFRUhzNd4UvyjbiAp0PMUwCxGGKACTkCH+2O
 dw4hn2jUeNwErJMi+SWDsgZxR4rM6nc0tdu88ukJwZutiBemYR/k1w+NSyaizTjycSKEtCk8hvl
 cEzeU1RIXVY32xwu/9/2+hn+PmNAaJnCA77QNFO3n30Mh5tXeeym/JxoQvFVihsvcyUctDTP/6F
 X9eIsQGZWWZIbhNt+hg6BwPRWsHWRYZJwpLcuaBFJzIESRHO8iel9yD4KPgME3s+J6gNxDZu+9x
 6IblYiyBZyeYTsN26HJMu4B8FREqBU/vzSxokDEHkd9JR7mPo38ksIF0cpkzgJcm0I2jiEf7VAV
 YsRwjEjAW2rHu/w+U0Ex5qrZuslBycBeTiOkTZLxirG+UMGiE+vSlKRF4uu/Bxg4FJkWYUrlxsh
 Y5DRUbUFXNMFvrn1bKqQL4X9f5BBm8y8pheZcNkTke4MYDu4U6vTEaItxdQcBhbLUYaLzOudWs0
 Muha9zPstUApvQunf4aRkwryeq+6CBgx5bpE+KQKM5NnEKgKk27EhiBeRbsCVYiYPM/2NOC6FoG
 CmpeSTglYnoaXmrItpEhgQCkpGchzeZISJlUaPvCh8Z92yzA/deaEW0i9Rvx7922C+2cHQHBJhl
 NUxnYzRBjbNVVMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Exclude all *-hmp-cmds.c files and HMP-only source files from the
build when HMP is disabled.

Also conditionalise the hmp-commands.hx header generation and the
test-hmp qtest.

Drop the transient #ifdef CONFIG_HMP, no longer needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build               |  2 +-
 hw/pci/pci-hmp-cmds.c     |  2 --
 monitor/hmp.c             |  2 --
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
 24 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/meson.build b/meson.build
index 824ba695801..4b208a2c56e 100644
--- a/meson.build
+++ b/meson.build
@@ -3536,7 +3536,7 @@ hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
   ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
 ]
-if have_system
+if have_system and have_hmp
   hx_headers += [
     ['hmp-commands.hx', 'hmp-commands.h'],
     ['hmp-commands-info.hx', 'hmp-commands-info.h'],
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index 3e378eadfaa..a5f6483cc3d 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -134,7 +134,6 @@ void hmp_info_pci(Monitor *mon, const QDict *qdict)
     qapi_free_PciInfoList(info_list);
 }
 
-#ifdef CONFIG_HMP
 void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     PCIDevice *d = (PCIDevice *)dev;
@@ -170,7 +169,6 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
                        r->addr, r->addr + r->size - 1);
     }
 }
-#endif
 
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index c9e207c7a30..4926972a3fb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1616,9 +1616,7 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     if (cs == NULL) {
         return -1;
     }
-#ifdef CONFIG_HMP
     md = cs->cc->sysemu_ops->monitor_defs;
-#endif
     if (md == NULL) {
         return -1;
     }
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
index 84f142df222..df3373be03b 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -67,6 +67,8 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
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
index 0e023235164..b59f455a511 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -100,6 +100,8 @@ stub_ss.add(files('vhost-user-stub.c'))
 stub_ss.add(files('virtio-stub.c'))
 stub_ss.add(files('virtio-md-stubs.c'))
 
-system_ss.add(files('virtio-hmp-cmds.c'))
+if have_hmp
+  system_ss.add(files('virtio-hmp-cmds.c'))
+endif
 
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
diff --git a/migration/meson.build b/migration/meson.build
index 0a9a5d0d374..4ab9d99cea6 100644
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
index 9c8068b06d1..5bb76d13649 100644
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
index cd3193d170b..da4d4fe1f6c 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -22,12 +22,17 @@ system_ss.add(files(
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
index e154abb05d2..c00a53b2bba 100644
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
index 0c6a432948c..433b3b9118c 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -55,10 +55,12 @@ system_ss.add(png)
 system_ss.add(files(
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


