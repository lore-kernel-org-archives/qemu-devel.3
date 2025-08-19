Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88A0CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSj-0003nz-9C; Tue, 19 Aug 2025 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSg-0003mW-Sj
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSe-0007FK-Ci
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQqZz81DyOrA7IEU/xUvjooUnrf4m4rTU5JDiTCCURg=;
 b=cqGg+quBiOGYrmf7aOhsmZLJMdvj5jQ7zIpywsTiLZvVhkNfWX5klb9AyVEU9HMZEe+HBP
 KjoE2bsw92aiz3OLm6M3/1ZJmMABjVpvBR06UAv+yaEEX1rWA4v6HVTIGWxitR/lwZO2ha
 SupbhexQKdwtvWqxyArG5Kmiec+DW10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-nkMFoKuLMxK-iVgWaaguDA-1; Tue,
 19 Aug 2025 07:24:57 -0400
X-MC-Unique: nkMFoKuLMxK-iVgWaaguDA-1
X-Mimecast-MFC-AGG-ID: nkMFoKuLMxK-iVgWaaguDA_1755602696
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C91FB19775A5; Tue, 19 Aug 2025 11:24:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDFEF30001A8; Tue, 19 Aug 2025 11:24:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/25] tests/functional: Move ppc/ppc64 tests into
 target-specific folders
Date: Tue, 19 Aug 2025 13:23:53 +0200
Message-ID: <20250819112403.432587-17-thuth@redhat.com>
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

The tests/functional folder has become quite crowded, thus move the
ppc and ppc64 tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 32 ++++++-------
 tests/functional/meson.build                  | 47 +------------------
 tests/functional/ppc/meson.build              | 22 +++++++++
 .../{test_ppc_40p.py => ppc/test_40p.py}      |  0
 .../{test_ppc_74xx.py => ppc/test_74xx.py}    |  0
 .../{test_ppc_amiga.py => ppc/test_amiga.py}  |  0
 .../test_bamboo.py}                           |  0
 .../{test_ppc_mac.py => ppc/test_mac.py}      |  0
 .../test_migration.py}                        |  0
 .../test_mpc8544ds.py}                        |  0
 .../test_replay.py}                           |  0
 .../test_sam460ex.py}                         |  0
 .../test_tuxrun.py}                           |  0
 .../test_virtex_ml507.py}                     |  0
 tests/functional/ppc64/meson.build            | 25 ++++++++++
 .../test_e500.py}                             |  0
 .../{test_ppc64_hv.py => ppc64/test_hv.py}    |  0
 .../test_mac99.py}                            |  0
 .../test_migration.py}                        |  0
 .../test_powernv.py}                          |  0
 .../test_pseries.py}                          |  0
 .../test_replay.py}                           |  0
 .../test_reverse_debug.py}                    |  0
 .../test_tuxrun.py}                           |  0
 24 files changed, 65 insertions(+), 61 deletions(-)
 create mode 100644 tests/functional/ppc/meson.build
 rename tests/functional/{test_ppc_40p.py => ppc/test_40p.py} (100%)
 rename tests/functional/{test_ppc_74xx.py => ppc/test_74xx.py} (100%)
 rename tests/functional/{test_ppc_amiga.py => ppc/test_amiga.py} (100%)
 rename tests/functional/{test_ppc_bamboo.py => ppc/test_bamboo.py} (100%)
 rename tests/functional/{test_ppc_mac.py => ppc/test_mac.py} (100%)
 rename tests/functional/{test_ppc_migration.py => ppc/test_migration.py} (100%)
 rename tests/functional/{test_ppc_mpc8544ds.py => ppc/test_mpc8544ds.py} (100%)
 rename tests/functional/{test_ppc_replay.py => ppc/test_replay.py} (100%)
 rename tests/functional/{test_ppc_sam460ex.py => ppc/test_sam460ex.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_ppc_tuxrun.py => ppc/test_tuxrun.py} (100%)
 rename tests/functional/{test_ppc_virtex_ml507.py => ppc/test_virtex_ml507.py} (100%)
 create mode 100644 tests/functional/ppc64/meson.build
 rename tests/functional/{test_ppc64_e500.py => ppc64/test_e500.py} (100%)
 rename tests/functional/{test_ppc64_hv.py => ppc64/test_hv.py} (100%)
 rename tests/functional/{test_ppc64_mac99.py => ppc64/test_mac99.py} (100%)
 rename tests/functional/{test_ppc64_migration.py => ppc64/test_migration.py} (100%)
 rename tests/functional/{test_ppc64_powernv.py => ppc64/test_powernv.py} (100%)
 rename tests/functional/{test_ppc64_pseries.py => ppc64/test_pseries.py} (100%)
 rename tests/functional/{test_ppc64_replay.py => ppc64/test_replay.py} (100%)
 rename tests/functional/{test_ppc64_reverse_debug.py => ppc64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_ppc64_tuxrun.py => ppc64/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56ba9b02c39..b0d440cf751 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -310,7 +310,7 @@ F: configs/devices/ppc*
 F: docs/system/ppc/embedded.rst
 F: docs/system/target-ppc.rst
 F: tests/tcg/ppc*/*
-F: tests/functional/test_ppc_74xx.py
+F: tests/functional/ppc/test_74xx.py
 
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
@@ -1466,7 +1466,7 @@ L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
 F: hw/pci-host/ppc4xx_pci.c
-F: tests/functional/test_ppc_bamboo.py
+F: tests/functional/ppc/test_bamboo.py
 
 e500
 M: Bernhard Beschow <shentey@gmail.com>
@@ -1484,8 +1484,8 @@ F: pc-bios/u-boot.e500
 F: hw/intc/openpic_kvm.c
 F: include/hw/ppc/openpic_kvm.h
 F: docs/system/ppc/ppce500.rst
-F: tests/functional/test_ppc64_e500.py
-F: tests/functional/test_ppc_tuxrun.py
+F: tests/functional/ppc64/test_e500.py
+F: tests/functional/ppc/test_tuxrun.py
 
 mpc8544ds
 M: Bernhard Beschow <shentey@gmail.com>
@@ -1493,7 +1493,7 @@ L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
-F: tests/functional/test_ppc_mpc8544ds.py
+F: tests/functional/ppc/test_mpc8544ds.py
 
 New World (mac99)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1515,8 +1515,8 @@ F: include/hw/ppc/mac_dbdma.h
 F: include/hw/pci-host/uninorth.h
 F: include/hw/input/adb*
 F: pc-bios/qemu_vga.ndrv
-F: tests/functional/test_ppc_mac.py
-F: tests/functional/test_ppc64_mac99.py
+F: tests/functional/ppc/test_mac.py
+F: tests/functional/ppc64/test_mac99.py
 
 Old World (g3beige)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1532,7 +1532,7 @@ F: include/hw/intc/heathrow_pic.h
 F: include/hw/input/adb*
 F: include/hw/pci-host/grackle.h
 F: pc-bios/qemu_vga.ndrv
-F: tests/functional/test_ppc_mac.py
+F: tests/functional/ppc/test_mac.py
 
 PReP
 M: Hervé Poussineau <hpoussin@reactos.org>
@@ -1549,7 +1549,7 @@ F: hw/dma/i82374.c
 F: hw/rtc/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/rtc/m48t59.h
-F: tests/functional/test_ppc_40p.py
+F: tests/functional/ppc/test_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
@@ -1572,9 +1572,9 @@ F: tests/qtest/spapr*
 F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
-F: tests/functional/test_ppc64_pseries.py
-F: tests/functional/test_ppc64_hv.py
-F: tests/functional/test_ppc64_tuxrun.py
+F: tests/functional/ppc64/test_pseries.py
+F: tests/functional/ppc64/test_hv.py
+F: tests/functional/ppc64/test_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
@@ -1593,7 +1593,7 @@ F: include/hw/ssi/pnv_spi*
 F: pc-bios/skiboot.lid
 F: pc-bios/pnv-pnor.bin
 F: tests/qtest/pnv*
-F: tests/functional/test_ppc64_powernv.py
+F: tests/functional/ppc64/test_powernv.py
 
 pca955x
 M: Glenn Miles <milesg@linux.ibm.com>
@@ -1608,7 +1608,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/virtex_ml507.c
-F: tests/functional/test_ppc_virtex_ml507.py
+F: tests/functional/ppc/test_virtex_ml507.py
 
 sam460ex
 M: BALATON Zoltan <balaton@eik.bme.hu>
@@ -1624,7 +1624,7 @@ F: pc-bios/dtb/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
-F: tests/functional/test_ppc_sam460ex.py
+F: tests/functional/ppc/test_sam460ex.py
 
 pegasos2
 M: BALATON Zoltan <balaton@eik.bme.hu>
@@ -1642,7 +1642,7 @@ S: Maintained
 F: hw/ppc/amigaone.c
 F: hw/pci-host/articia.c
 F: include/hw/pci-host/articia.h
-F: tests/functional/test_ppc_amiga.py
+F: tests/functional/ppc/test_amiga.py
 
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 397303ec6fb..3caeea5ebdd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -24,19 +24,8 @@ subdir('mipsel')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
-
-test_ppc_timeouts = {
-  'ppc_40p' : 240,
-}
-
-test_ppc64_timeouts = {
-  'ppc64_hv' : 1000,
-  'ppc64_powernv' : 480,
-  'ppc64_pseries' : 480,
-  'ppc64_replay' : 210,
-  'ppc64_tuxrun' : 420,
-  'ppc64_mac99' : 120,
-}
+subdir('ppc')
+subdir('ppc64')
 
 test_riscv64_timeouts = {
   'riscv64_tuxrun' : 120,
@@ -71,38 +60,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_ppc_system_quick = [
-  'ppc_migration',
-  'ppc_74xx',
-]
-
-tests_ppc_system_thorough = [
-  'ppc_40p',
-  'ppc_amiga',
-  'ppc_bamboo',
-  'ppc_mac',
-  'ppc_mpc8544ds',
-  'ppc_replay',
-  'ppc_sam460ex',
-  'ppc_tuxrun',
-  'ppc_virtex_ml507',
-]
-
-tests_ppc64_system_quick = [
-  'ppc64_migration',
-]
-
-tests_ppc64_system_thorough = [
-  'ppc64_e500',
-  'ppc64_hv',
-  'ppc64_powernv',
-  'ppc64_pseries',
-  'ppc64_replay',
-  'ppc64_reverse_debug',
-  'ppc64_tuxrun',
-  'ppc64_mac99',
-]
-
 tests_riscv32_system_quick = [
   'riscv32_migration',
   'riscv_opensbi',
diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
new file mode 100644
index 00000000000..3d562010d8c
--- /dev/null
+++ b/tests/functional/ppc/meson.build
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_ppc_timeouts = {
+  '40p' : 240,
+}
+
+tests_ppc_system_quick = [
+  'migration',
+  '74xx',
+]
+
+tests_ppc_system_thorough = [
+  '40p',
+  'amiga',
+  'bamboo',
+  'mac',
+  'mpc8544ds',
+  'replay',
+  'sam460ex',
+  'tuxrun',
+  'virtex_ml507',
+]
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/ppc/test_40p.py
similarity index 100%
rename from tests/functional/test_ppc_40p.py
rename to tests/functional/ppc/test_40p.py
diff --git a/tests/functional/test_ppc_74xx.py b/tests/functional/ppc/test_74xx.py
similarity index 100%
rename from tests/functional/test_ppc_74xx.py
rename to tests/functional/ppc/test_74xx.py
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/ppc/test_amiga.py
similarity index 100%
rename from tests/functional/test_ppc_amiga.py
rename to tests/functional/ppc/test_amiga.py
diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/ppc/test_bamboo.py
similarity index 100%
rename from tests/functional/test_ppc_bamboo.py
rename to tests/functional/ppc/test_bamboo.py
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/ppc/test_mac.py
similarity index 100%
rename from tests/functional/test_ppc_mac.py
rename to tests/functional/ppc/test_mac.py
diff --git a/tests/functional/test_ppc_migration.py b/tests/functional/ppc/test_migration.py
similarity index 100%
rename from tests/functional/test_ppc_migration.py
rename to tests/functional/ppc/test_migration.py
diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/ppc/test_mpc8544ds.py
similarity index 100%
rename from tests/functional/test_ppc_mpc8544ds.py
rename to tests/functional/ppc/test_mpc8544ds.py
diff --git a/tests/functional/test_ppc_replay.py b/tests/functional/ppc/test_replay.py
similarity index 100%
rename from tests/functional/test_ppc_replay.py
rename to tests/functional/ppc/test_replay.py
diff --git a/tests/functional/test_ppc_sam460ex.py b/tests/functional/ppc/test_sam460ex.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_ppc_sam460ex.py
rename to tests/functional/ppc/test_sam460ex.py
diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/ppc/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_ppc_tuxrun.py
rename to tests/functional/ppc/test_tuxrun.py
diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional/ppc/test_virtex_ml507.py
similarity index 100%
rename from tests/functional/test_ppc_virtex_ml507.py
rename to tests/functional/ppc/test_virtex_ml507.py
diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
new file mode 100644
index 00000000000..842fe0fc715
--- /dev/null
+++ b/tests/functional/ppc64/meson.build
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_ppc64_timeouts = {
+  'hv' : 1000,
+  'mac99' : 120,
+  'powernv' : 480,
+  'pseries' : 480,
+  'replay' : 210,
+  'tuxrun' : 420,
+}
+
+tests_ppc64_system_quick = [
+  'migration',
+]
+
+tests_ppc64_system_thorough = [
+  'e500',
+  'hv',
+  'mac99',
+  'powernv',
+  'pseries',
+  'replay',
+  'reverse_debug',
+  'tuxrun',
+]
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/ppc64/test_e500.py
similarity index 100%
rename from tests/functional/test_ppc64_e500.py
rename to tests/functional/ppc64/test_e500.py
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/ppc64/test_hv.py
similarity index 100%
rename from tests/functional/test_ppc64_hv.py
rename to tests/functional/ppc64/test_hv.py
diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ppc64/test_mac99.py
similarity index 100%
rename from tests/functional/test_ppc64_mac99.py
rename to tests/functional/ppc64/test_mac99.py
diff --git a/tests/functional/test_ppc64_migration.py b/tests/functional/ppc64/test_migration.py
similarity index 100%
rename from tests/functional/test_ppc64_migration.py
rename to tests/functional/ppc64/test_migration.py
diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/ppc64/test_powernv.py
similarity index 100%
rename from tests/functional/test_ppc64_powernv.py
rename to tests/functional/ppc64/test_powernv.py
diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/ppc64/test_pseries.py
similarity index 100%
rename from tests/functional/test_ppc64_pseries.py
rename to tests/functional/ppc64/test_pseries.py
diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/ppc64/test_replay.py
similarity index 100%
rename from tests/functional/test_ppc64_replay.py
rename to tests/functional/ppc64/test_replay.py
diff --git a/tests/functional/test_ppc64_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_ppc64_reverse_debug.py
rename to tests/functional/ppc64/test_reverse_debug.py
diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/ppc64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_ppc64_tuxrun.py
rename to tests/functional/ppc64/test_tuxrun.py
-- 
2.50.1


