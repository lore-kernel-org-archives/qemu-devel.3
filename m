Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D6C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggi1-0008C8-Mi; Wed, 21 Aug 2024 04:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgghz-00082A-8a
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgghw-0004L2-1g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYJAy9HPTv95fmxl5Gagh6Tnx7UWqf2cOFeMiqMq4YM=;
 b=e+NEd2ZBKPaXMRinuAdTbUF3/llsF+4iBHX3yoL3GHOyp+P+bxH386lQAYycJFhohEZX9C
 chEmVJhzTWYRfTfy6Z+mC9/K5d8SIfC/g6gjWNF97u9BaJcJC32q951nM8TPCtcGWGvfiv
 UDSj67zE4MyfI1kFDRDjEBjE8CP6th4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-Nx-v4N0gNKmVXpCIO7s-RA-1; Wed,
 21 Aug 2024 04:28:39 -0400
X-MC-Unique: Nx-v4N0gNKmVXpCIO7s-RA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C1E91955D54; Wed, 21 Aug 2024 08:28:38 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92D7A1955F1B; Wed, 21 Aug 2024 08:28:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 12/35] tests/functional: Convert simple avocado tests into
 standalone python tests
Date: Wed, 21 Aug 2024 10:27:13 +0200
Message-ID: <20240821082748.65853-13-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

These test are rather simple and don't need any modifications apart
from adjusting the "from avocado_qemu" line. To ease debugging, make
the files executable and add a shebang line and Python '__main__'
handling, too, so that these tests can now be run by executing them
directly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  5 ++
 tests/functional/meson.build                  |  5 ++
 .../test_cpu_queries.py}                      | 12 +++--
 .../test_empty_cpu_model.py}                  |  7 ++-
 .../test_mem_addr_space.py}                   | 52 +++----------------
 .../test_pc_cpu_hotplug_props.py}             | 11 ++--
 .../test_virtio_version.py}                   |  8 +--
 7 files changed, 40 insertions(+), 60 deletions(-)
 rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (85%)
 mode change 100644 => 100755
 rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
 mode change 100644 => 100755
 rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
 mode change 100644 => 100755
 rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 80cc84dd99..b3a0ac0e8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1833,6 +1833,8 @@ F: hw/isa/apm.c
 F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
+F: tests/functional/test_mem_addr_space.py
+F: tests/functional/test_pc_cpu_hotplug_props.py
 
 PC Chipset
 M: Michael S. Tsirkin <mst@redhat.com>
@@ -1899,6 +1901,8 @@ F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
 F: include/sysemu/numa.h
+F: tests/functional/test_cpu_queries.py
+F: tests/functional/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
@@ -2238,6 +2242,7 @@ F: net/vhost-user.c
 F: include/hw/virtio/
 F: docs/devel/virtio*
 F: docs/devel/migration/virtio.rst
+F: tests/functional/test_virtio_version.py
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7fc9c4e513..a8cc0e6330 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -14,9 +14,14 @@ test_timeouts = {
 }
 
 tests_generic = [
+  'empty_cpu_model',
 ]
 
 tests_x86_64_quick = [
+  'cpu_queries',
+  'mem_addr_space',
+  'pc_cpu_hotplug_props',
+  'virtio_version',
 ]
 
 tests_x86_64_thorough = [
diff --git a/tests/avocado/cpu_queries.py b/tests/functional/test_cpu_queries.py
old mode 100644
new mode 100755
similarity index 85%
rename from tests/avocado/cpu_queries.py
rename to tests/functional/test_cpu_queries.py
index d3faa14720..b1122a0e8f
--- a/tests/avocado/cpu_queries.py
+++ b/tests/functional/test_cpu_queries.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Sanity check of query-cpu-* results
 #
 # Copyright (c) 2019 Red Hat, Inc.
@@ -8,7 +10,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 class QueryCPUModelExpansion(QemuSystemTest):
     """
@@ -16,10 +18,7 @@ class QueryCPUModelExpansion(QemuSystemTest):
     """
 
     def test(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:none
-        """
+        self.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -33,3 +32,6 @@ def test(self):
             e = self.vm.cmd('query-cpu-model-expansion', model=model,
                             type='full')
             self.assertEqual(e['model']['name'], c['name'])
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/empty_cpu_model.py b/tests/functional/test_empty_cpu_model.py
old mode 100644
new mode 100755
similarity index 84%
rename from tests/avocado/empty_cpu_model.py
rename to tests/functional/test_empty_cpu_model.py
index d906ef3d3c..0081b06d85
--- a/tests/avocado/empty_cpu_model.py
+++ b/tests/functional/test_empty_cpu_model.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Check for crash when using empty -cpu option
 #
 # Copyright (c) 2019 Red Hat, Inc.
@@ -7,7 +9,7 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 class EmptyCPUModel(QemuSystemTest):
     def test(self):
@@ -17,3 +19,6 @@ def test(self):
         self.vm.wait()
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/functional/test_mem_addr_space.py
old mode 100644
new mode 100755
similarity index 93%
rename from tests/avocado/mem-addr-space-check.py
rename to tests/functional/test_mem_addr_space.py
index d3974599f4..bb0cf062ca
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/functional/test_mem_addr_space.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Check for crash when using memory beyond the available guest processor
 # address space.
 #
@@ -8,7 +10,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 import time
 
 class MemAddrCheck(QemuSystemTest):
@@ -22,9 +24,6 @@ class MemAddrCheck(QemuSystemTest):
     # for all 32-bit cases, pci64_hole_size is 0.
     def test_phybits_low_pse36(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         With pse36 feature ON, a processor has 36 bits of addressing. So it can
         access up to a maximum of 64GiB of memory. Memory hotplug region begins
         at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
@@ -52,9 +51,6 @@ def test_phybits_low_pse36(self):
 
     def test_phybits_low_pae(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         With pae feature ON, a processor has 36 bits of addressing. So it can
         access up to a maximum of 64GiB of memory. Rest is the same as the case
         with pse36 above.
@@ -72,9 +68,6 @@ def test_phybits_low_pae(self):
 
     def test_phybits_ok_pentium_pse36(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Setting maxmem to 59.5G and making sure that QEMU can start with the
         same options as the failing case above with pse36 cpu feature.
         """
@@ -91,9 +84,6 @@ def test_phybits_ok_pentium_pse36(self):
 
     def test_phybits_ok_pentium_pae(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Test is same as above but now with pae cpu feature turned on.
         Setting maxmem to 59.5G and making sure that QEMU can start fine
         with the same options as the case above.
@@ -111,9 +101,6 @@ def test_phybits_ok_pentium_pae(self):
 
     def test_phybits_ok_pentium2(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Pentium2 has 36 bits of addressing, so its same as pentium
         with pse36 ON.
         """
@@ -130,9 +117,6 @@ def test_phybits_ok_pentium2(self):
 
     def test_phybits_low_nonpse36(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Pentium processor has 32 bits of addressing without pse36 or pae
         so it can access physical address up to 4 GiB. Setting maxmem to
         4 GiB should make QEMU fail to start with "phys-bits too low"
@@ -153,9 +137,6 @@ def test_phybits_low_nonpse36(self):
     # now lets test some 64-bit CPU cases.
     def test_phybits_low_tcg_q35_70_amd(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         For q35 7.1 machines and above, there is a HT window that starts at
         1024 GiB and ends at 1 TiB - 1. If the max GPA falls in this range,
         "above_4G" memory is adjusted to start at 1 TiB boundary for AMD cpus
@@ -182,9 +163,6 @@ def test_phybits_low_tcg_q35_70_amd(self):
 
     def test_phybits_low_tcg_q35_71_amd(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
         version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 bit
         processor address space, it has to be 1012 GiB , that is 12 GiB
@@ -205,9 +183,6 @@ def test_phybits_low_tcg_q35_71_amd(self):
 
     def test_phybits_ok_tcg_q35_70_amd(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Same as q35-7.0 AMD case except that here we check that QEMU can
         successfully start when maxmem is < 988G.
         """
@@ -224,9 +199,6 @@ def test_phybits_ok_tcg_q35_70_amd(self):
 
     def test_phybits_ok_tcg_q35_71_amd(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Same as q35-7.1 AMD case except that here we check that QEMU can
         successfully start when maxmem is < 976G.
         """
@@ -243,9 +215,6 @@ def test_phybits_ok_tcg_q35_71_amd(self):
 
     def test_phybits_ok_tcg_q35_71_intel(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Same parameters as test_phybits_low_tcg_q35_71_amd() but use
         Intel cpu instead. QEMU should start fine in this case as
         "above_4G" memory starts at 4G.
@@ -264,9 +233,6 @@ def test_phybits_ok_tcg_q35_71_intel(self):
 
     def test_phybits_low_tcg_q35_71_amd_41bits(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
         By setting maxram above 1012 GiB  - 32 GiB - 4 GiB = 976 GiB, we can
         force "above_4G" memory to start at 1 TiB for q35-7.1 machines
@@ -291,9 +257,6 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
 
     def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
         Same as above but by setting maxram between 976 GiB and 992 Gib,
         QEMU should start fine.
@@ -312,9 +275,6 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
 
     def test_phybits_low_tcg_q35_intel_cxl(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         cxl memory window starts after memory device range. Here, we use 1 GiB
         of cxl window memory. 4G_mem end aligns at 4G. pci64_hole is 32 GiB and
         starts after the cxl memory window.
@@ -335,9 +295,6 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
 
     def test_phybits_ok_tcg_q35_intel_cxl(self):
         """
-        :avocado: tags=machine:q35
-        :avocado: tags=arch:x86_64
-
         Same as above but here we do not reserve any cxl memory window. Hence,
         with the exact same parameters as above, QEMU should start fine even
         with cxl enabled.
@@ -352,3 +309,6 @@ def test_phybits_ok_tcg_q35_intel_cxl(self):
         time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/pc_cpu_hotplug_props.py b/tests/functional/test_pc_cpu_hotplug_props.py
old mode 100644
new mode 100755
similarity index 90%
rename from tests/avocado/pc_cpu_hotplug_props.py
rename to tests/functional/test_pc_cpu_hotplug_props.py
index 4bd3e02665..9d5a37cb17
--- a/tests/avocado/pc_cpu_hotplug_props.py
+++ b/tests/functional/test_pc_cpu_hotplug_props.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # Ensure CPU die-id can be omitted on -device
 #
@@ -20,16 +21,16 @@
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 class OmittedCPUProps(QemuSystemTest):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=cpu:qemu64
-    """
+
     def test_no_die_id(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
         self.vm.launch()
         self.assertEqual(len(self.vm.cmd('query-cpus-fast')), 2)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/virtio_version.py b/tests/functional/test_virtio_version.py
old mode 100644
new mode 100755
similarity index 98%
rename from tests/avocado/virtio_version.py
rename to tests/functional/test_virtio_version.py
index afe5e828b5..eb23060564
--- a/tests/avocado/virtio_version.py
+++ b/tests/functional/test_virtio_version.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 """
 Check compatibility of virtio device types
 """
@@ -12,7 +13,7 @@
 import os
 
 from qemu.machine import QEMUMachine
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 # Virtio Device IDs:
 VIRTIO_NET = 1
@@ -60,8 +61,6 @@ class VirtioVersionCheck(QemuSystemTest):
     Check if virtio-version-specific device types result in the
     same device tree created by `disable-modern` and
     `disable-legacy`.
-
-    :avocado: tags=arch:x86_64
     """
 
     # just in case there are failures, show larger diff:
@@ -173,3 +172,6 @@ def test_modern_only_devs(self):
         self.check_modern_only('virtio-mouse-pci', VIRTIO_INPUT)
         self.check_modern_only('virtio-tablet-pci', VIRTIO_INPUT)
         self.check_modern_only('virtio-keyboard-pci', VIRTIO_INPUT)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


