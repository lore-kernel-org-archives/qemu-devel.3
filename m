Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D3CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKS9-0003Gh-Ae; Tue, 19 Aug 2025 07:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKS8-0003GT-25
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKS4-0007BL-8y
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBGQEKu9w8d/bcT3w9zmB2VvNOR0VQ0wqbkVvhI9Cxk=;
 b=ZZZjeL97YDTpxmvilKlzxpEqQ3OeV8iaBGFCpvjim1VvBKgsJwVDWCjR0luKhQXZSG+18P
 adRZ8Gf54ZembRXJEnr/3CSh+/JrQi0dPaRjFzAe4RXK89IFY+yqJh7BSUcx26iglMe2kv
 TyngZEV/YxgwFDzG82u6bN3K8xv323s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-_E4OeoX_OV2g50uQZepLuQ-1; Tue,
 19 Aug 2025 07:24:25 -0400
X-MC-Unique: _E4OeoX_OV2g50uQZepLuQ-1
X-Mimecast-MFC-AGG-ID: _E4OeoX_OV2g50uQZepLuQ_1755602663
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14FD195F162; Tue, 19 Aug 2025 11:24:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9B7630001A8; Tue, 19 Aug 2025 11:24:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/25] tests/functional: Move aarch64 tests into
 architecture specific folder
Date: Tue, 19 Aug 2025 13:23:42 +0200
Message-ID: <20250819112403.432587-6-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded already, some
restructuring would be helpful here. Thus move the aarch64 tests into
a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 24 +++++-----
 tests/functional/aarch64/meson.build          | 48 +++++++++++++++++++
 .../test_aspeed_ast2700.py}                   |  0
 .../test_aspeed_ast2700fc.py}                 |  0
 .../test_device_passthrough.py}               |  0
 .../test_hotplug_pci.py}                      |  0
 .../test_imx8mp_evk.py}                       |  0
 .../test_kvm.py}                              |  0
 .../test_migration.py}                        |  0
 .../test_multiprocess.py}                     |  0
 .../test_raspi3.py}                           |  0
 .../test_raspi4.py}                           |  0
 .../test_replay.py}                           |  0
 .../test_reverse_debug.py}                    |  0
 .../test_rme_sbsaref.py}                      |  2 +-
 .../test_rme_virt.py}                         |  0
 .../test_sbsaref.py}                          |  0
 .../test_sbsaref_alpine.py}                   |  2 +-
 .../test_sbsaref_freebsd.py}                  |  2 +-
 .../test_smmu.py}                             |  0
 .../test_tcg_plugins.py}                      |  0
 .../test_tuxrun.py}                           |  0
 .../test_virt.py}                             |  0
 .../test_virt_gpu.py}                         |  0
 .../test_xen.py}                              |  0
 .../test_xlnx_versal.py}                      |  0
 tests/functional/meson.build                  | 48 +------------------
 27 files changed, 64 insertions(+), 62 deletions(-)
 create mode 100644 tests/functional/aarch64/meson.build
 rename tests/functional/{test_aarch64_aspeed_ast2700.py => aarch64/test_aspeed_ast2700.py} (100%)
 rename tests/functional/{test_aarch64_aspeed_ast2700fc.py => aarch64/test_aspeed_ast2700fc.py} (100%)
 rename tests/functional/{test_aarch64_device_passthrough.py => aarch64/test_device_passthrough.py} (100%)
 rename tests/functional/{test_aarch64_hotplug_pci.py => aarch64/test_hotplug_pci.py} (100%)
 rename tests/functional/{test_aarch64_imx8mp_evk.py => aarch64/test_imx8mp_evk.py} (100%)
 rename tests/functional/{test_aarch64_kvm.py => aarch64/test_kvm.py} (100%)
 rename tests/functional/{test_aarch64_migration.py => aarch64/test_migration.py} (100%)
 rename tests/functional/{test_aarch64_multiprocess.py => aarch64/test_multiprocess.py} (100%)
 rename tests/functional/{test_aarch64_raspi3.py => aarch64/test_raspi3.py} (100%)
 rename tests/functional/{test_aarch64_raspi4.py => aarch64/test_raspi4.py} (100%)
 rename tests/functional/{test_aarch64_replay.py => aarch64/test_replay.py} (100%)
 rename tests/functional/{test_aarch64_reverse_debug.py => aarch64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_aarch64_rme_sbsaref.py => aarch64/test_rme_sbsaref.py} (98%)
 rename tests/functional/{test_aarch64_rme_virt.py => aarch64/test_rme_virt.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref.py => aarch64/test_sbsaref.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref_alpine.py => aarch64/test_sbsaref_alpine.py} (97%)
 rename tests/functional/{test_aarch64_sbsaref_freebsd.py => aarch64/test_sbsaref_freebsd.py} (97%)
 rename tests/functional/{test_aarch64_smmu.py => aarch64/test_smmu.py} (100%)
 rename tests/functional/{test_aarch64_tcg_plugins.py => aarch64/test_tcg_plugins.py} (100%)
 rename tests/functional/{test_aarch64_tuxrun.py => aarch64/test_tuxrun.py} (100%)
 rename tests/functional/{test_aarch64_virt.py => aarch64/test_virt.py} (100%)
 rename tests/functional/{test_aarch64_virt_gpu.py => aarch64/test_virt_gpu.py} (100%)
 rename tests/functional/{test_aarch64_xen.py => aarch64/test_xen.py} (100%)
 rename tests/functional/{test_aarch64_xlnx_versal.py => aarch64/test_xlnx_versal.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index adbed9df2fc..a2a5ccea7b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -212,7 +212,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
-F: tests/functional/test_aarch64_smmu.py
+F: tests/functional/aarch64/test_smmu.py
 
 AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
@@ -874,7 +874,7 @@ F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8mp-evk.rst
-F: tests/functional/test_aarch64_imx8mp_evk.py
+F: tests/functional/aarch64/test_imx8mp_evk.py
 F: tests/qtest/rs5c372-test.c
 
 MPS2 / MPS3
@@ -952,8 +952,7 @@ F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
 F: tests/functional/test_arm_raspi2.py
-F: tests/functional/test_aarch64_raspi3.py
-F: tests/functional/test_aarch64_raspi4.py
+F: tests/functional/aarch64/test_raspi*.py
 
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -993,7 +992,7 @@ F: hw/misc/sbsa_ec.c
 F: hw/watchdog/sbsa_gwdt.c
 F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
-F: tests/functional/test_aarch64_*sbsaref*.py
+F: tests/functional/aarch64/test_*sbsaref*.py
 
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1063,8 +1062,8 @@ S: Maintained
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
-F: tests/functional/test_aarch64_*virt*.py
-F: tests/functional/test_aarch64_tuxrun.py
+F: tests/functional/aarch64/test_*virt*.py
+F: tests/functional/aarch64/test_tuxrun.py
 F: tests/functional/test_arm_tuxrun.py
 F: tests/functional/test_arm_virt.py
 
@@ -1096,7 +1095,7 @@ F: hw/display/dpcd.c
 F: include/hw/display/dpcd.h
 F: docs/system/arm/xlnx-versal-virt.rst
 F: docs/system/arm/xlnx-zcu102.rst
-F: tests/functional/test_aarch64_xlnx_versal.py
+F: tests/functional/aarch64/test_xlnx_versal.py
 
 Xilinx Versal OSPI
 M: Francisco Iglesias <francisco.iglesias@amd.com>
@@ -2109,7 +2108,7 @@ ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
 S: Supported
-F: tests/functional/test_aarch64_hotplug_pci.py
+F: tests/functional/aarch64/test_hotplug_pci.py
 
 ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -2263,6 +2262,7 @@ F: util/vfio-helpers.c
 F: include/hw/vfio/
 F: docs/devel/migration/vfio.rst
 F: qapi/vfio.json
+F: tests/functional/aarch64/test_device_passthrough.py
 
 vfio-igd
 M: Alex Williamson <alex.williamson@redhat.com>
@@ -2638,7 +2638,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
 F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
-F: tests/functional/test_aarch64_xen.py
+F: tests/functional/aarch64/test_xen.py
 
 Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
@@ -2707,7 +2707,7 @@ F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
-F: tests/functional/test_aarch64_virt_gpu.py
+F: tests/functional/aarch64/test_virt_gpu.py
 
 vhost-user-blk
 M: Raphael Norwitz <raphael@enfabrica.net>
@@ -3933,7 +3933,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/tcg/plugins/
-F: tests/functional/test_aarch64_tcg_plugins.py
+F: tests/functional/aarch64/test_tcg_plugins.py
 F: contrib/plugins/
 F: scripts/qemu-plugin-symbols.py
 
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
new file mode 100644
index 00000000000..04846c6eb18
--- /dev/null
+++ b/tests/functional/aarch64/meson.build
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_aarch64_timeouts = {
+  'aspeed_ast2700' : 600,
+  'aspeed_ast2700fc' : 600,
+  'device_passthrough' : 720,
+  'imx8mp_evk' : 240,
+  'raspi4' : 480,
+  'reverse_debug' : 180,
+  'rme_virt' : 1200,
+  'rme_sbsaref' : 1200,
+  'sbsaref_alpine' : 1200,
+  'sbsaref_freebsd' : 720,
+  'smmu' : 720,
+  'tuxrun' : 240,
+  'virt' : 360,
+  'virt_gpu' : 480,
+}
+
+tests_aarch64_system_quick = [
+  'migration',
+]
+
+tests_aarch64_system_thorough = [
+  'aspeed_ast2700',
+  'aspeed_ast2700fc',
+  'device_passthrough',
+  'hotplug_pci',
+  'imx8mp_evk',
+  'kvm',
+  'multiprocess',
+  'raspi3',
+  'raspi4',
+  'replay',
+  'reverse_debug',
+  'rme_virt',
+  'rme_sbsaref',
+  'sbsaref',
+  'sbsaref_alpine',
+  'sbsaref_freebsd',
+  'smmu',
+  'tcg_plugins',
+  'tuxrun',
+  'virt',
+  'virt_gpu',
+  'xen',
+  'xlnx_versal',
+]
diff --git a/tests/functional/test_aarch64_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
similarity index 100%
rename from tests/functional/test_aarch64_aspeed_ast2700.py
rename to tests/functional/aarch64/test_aspeed_ast2700.py
diff --git a/tests/functional/test_aarch64_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
similarity index 100%
rename from tests/functional/test_aarch64_aspeed_ast2700fc.py
rename to tests/functional/aarch64/test_aspeed_ast2700fc.py
diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
similarity index 100%
rename from tests/functional/test_aarch64_device_passthrough.py
rename to tests/functional/aarch64/test_device_passthrough.py
diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/aarch64/test_hotplug_pci.py
similarity index 100%
rename from tests/functional/test_aarch64_hotplug_pci.py
rename to tests/functional/aarch64/test_hotplug_pci.py
diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
similarity index 100%
rename from tests/functional/test_aarch64_imx8mp_evk.py
rename to tests/functional/aarch64/test_imx8mp_evk.py
diff --git a/tests/functional/test_aarch64_kvm.py b/tests/functional/aarch64/test_kvm.py
similarity index 100%
rename from tests/functional/test_aarch64_kvm.py
rename to tests/functional/aarch64/test_kvm.py
diff --git a/tests/functional/test_aarch64_migration.py b/tests/functional/aarch64/test_migration.py
similarity index 100%
rename from tests/functional/test_aarch64_migration.py
rename to tests/functional/aarch64/test_migration.py
diff --git a/tests/functional/test_aarch64_multiprocess.py b/tests/functional/aarch64/test_multiprocess.py
similarity index 100%
rename from tests/functional/test_aarch64_multiprocess.py
rename to tests/functional/aarch64/test_multiprocess.py
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/aarch64/test_raspi3.py
similarity index 100%
rename from tests/functional/test_aarch64_raspi3.py
rename to tests/functional/aarch64/test_raspi3.py
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/aarch64/test_raspi4.py
similarity index 100%
rename from tests/functional/test_aarch64_raspi4.py
rename to tests/functional/aarch64/test_raspi4.py
diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/aarch64/test_replay.py
similarity index 100%
rename from tests/functional/test_aarch64_replay.py
rename to tests/functional/aarch64/test_replay.py
diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_aarch64_reverse_debug.py
rename to tests/functional/aarch64/test_reverse_debug.py
diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
similarity index 98%
rename from tests/functional/test_aarch64_rme_sbsaref.py
rename to tests/functional/aarch64/test_rme_sbsaref.py
index 746770e776d..100f1c7738b 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -13,7 +13,7 @@
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from test_aarch64_rme_virt import test_realms_guest
+from test_rme_virt import test_realms_guest
 
 
 class Aarch64RMESbsaRefMachine(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
similarity index 100%
rename from tests/functional/test_aarch64_rme_virt.py
rename to tests/functional/aarch64/test_rme_virt.py
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/aarch64/test_sbsaref.py
similarity index 100%
rename from tests/functional/test_aarch64_sbsaref.py
rename to tests/functional/aarch64/test_sbsaref.py
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/aarch64/test_sbsaref_alpine.py
similarity index 97%
rename from tests/functional/test_aarch64_sbsaref_alpine.py
rename to tests/functional/aarch64/test_sbsaref_alpine.py
index 87769993831..abb8f5114bd 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/aarch64/test_sbsaref_alpine.py
@@ -12,7 +12,7 @@
 
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from test_aarch64_sbsaref import fetch_firmware
+from test_sbsaref import fetch_firmware
 
 
 class Aarch64SbsarefAlpine(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/aarch64/test_sbsaref_freebsd.py
similarity index 97%
rename from tests/functional/test_aarch64_sbsaref_freebsd.py
rename to tests/functional/aarch64/test_sbsaref_freebsd.py
index 7ef016fba62..3b942f7795c 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/aarch64/test_sbsaref_freebsd.py
@@ -12,7 +12,7 @@
 
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from test_aarch64_sbsaref import fetch_firmware
+from test_sbsaref import fetch_firmware
 
 
 class Aarch64SbsarefFreeBSD(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/aarch64/test_smmu.py
similarity index 100%
rename from tests/functional/test_aarch64_smmu.py
rename to tests/functional/aarch64/test_smmu.py
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/aarch64/test_tcg_plugins.py
similarity index 100%
rename from tests/functional/test_aarch64_tcg_plugins.py
rename to tests/functional/aarch64/test_tcg_plugins.py
diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_aarch64_tuxrun.py
rename to tests/functional/aarch64/test_tuxrun.py
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/aarch64/test_virt.py
similarity index 100%
rename from tests/functional/test_aarch64_virt.py
rename to tests/functional/aarch64/test_virt.py
diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
similarity index 100%
rename from tests/functional/test_aarch64_virt_gpu.py
rename to tests/functional/aarch64/test_virt_gpu.py
diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/aarch64/test_xen.py
similarity index 100%
rename from tests/functional/test_aarch64_xen.py
rename to tests/functional/aarch64/test_xen.py
diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
similarity index 100%
rename from tests/functional/test_aarch64_xlnx_versal.py
rename to tests/functional/aarch64/test_xlnx_versal.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8c24ac1cc2d..9cb6325360f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -9,23 +9,7 @@ if get_option('tcg_interpreter')
   subdir_done()
 endif
 
-# Timeouts for individual tests that can be slow e.g. with debugging enabled
-test_aarch64_timeouts = {
-  'aarch64_aspeed_ast2700' : 600,
-  'aarch64_aspeed_ast2700fc' : 600,
-  'aarch64_device_passthrough' : 720,
-  'aarch64_imx8mp_evk' : 240,
-  'aarch64_raspi4' : 480,
-  'aarch64_reverse_debug' : 180,
-  'aarch64_rme_virt' : 1200,
-  'aarch64_rme_sbsaref' : 1200,
-  'aarch64_sbsaref_alpine' : 1200,
-  'aarch64_sbsaref_freebsd' : 720,
-  'aarch64_smmu' : 720,
-  'aarch64_tuxrun' : 240,
-  'aarch64_virt' : 360,
-  'aarch64_virt_gpu' : 480,
-}
+subdir('aarch64')
 
 test_arm_timeouts = {
   'arm_aspeed_palmetto' : 120,
@@ -112,36 +96,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_aarch64_system_quick = [
-  'aarch64_migration',
-]
-
-tests_aarch64_system_thorough = [
-  'aarch64_aspeed_ast2700',
-  'aarch64_aspeed_ast2700fc',
-  'aarch64_device_passthrough',
-  'aarch64_hotplug_pci',
-  'aarch64_imx8mp_evk',
-  'aarch64_kvm',
-  'aarch64_multiprocess',
-  'aarch64_raspi3',
-  'aarch64_raspi4',
-  'aarch64_replay',
-  'aarch64_reverse_debug',
-  'aarch64_rme_virt',
-  'aarch64_rme_sbsaref',
-  'aarch64_sbsaref',
-  'aarch64_sbsaref_alpine',
-  'aarch64_sbsaref_freebsd',
-  'aarch64_smmu',
-  'aarch64_tcg_plugins',
-  'aarch64_tuxrun',
-  'aarch64_virt',
-  'aarch64_virt_gpu',
-  'aarch64_xen',
-  'aarch64_xlnx_versal',
-]
-
 tests_alpha_system_quick = [
   'alpha_migration',
 ]
-- 
2.50.1


