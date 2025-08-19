Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B7CA0EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSE-0003IB-6K; Tue, 19 Aug 2025 07:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSD-0003Ht-7k
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSA-0007Bj-AX
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubtXaQC+IseNuBF6d7DyK5xasE/8nhKFBiNc5sO7FMA=;
 b=U8YyZ2McoOHm8DmTLpcB3H0YK81eajpq95fJwn55ac/87mI8nG3IIg0iTiCWvf77mu+ojt
 42wM/FDqjG6lvDiCgBzCpBlwszMT6xVZfzApMnZdQARsTB66TN82vAmfHwHRi4FwFOtUAn
 kUzeYhX0ClTXiaXR0S3jJv0wiwsqoiU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194--xAypSv8OTyxLGDBe79Wtg-1; Tue,
 19 Aug 2025 07:24:31 -0400
X-MC-Unique: -xAypSv8OTyxLGDBe79Wtg-1
X-Mimecast-MFC-AGG-ID: -xAypSv8OTyxLGDBe79Wtg_1755602670
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 969AB18003FD; Tue, 19 Aug 2025 11:24:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B1C1B30001A8; Tue, 19 Aug 2025 11:24:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/25] tests/functional: Move arm tests into architecture
 specific folder
Date: Tue, 19 Aug 2025 13:23:44 +0200
Message-ID: <20250819112403.432587-8-thuth@redhat.com>
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
arm tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   | 38 ++++++------
 tests/functional/arm/meson.build              | 62 +++++++++++++++++++
 .../test_aspeed_ast1030.py}                   |  0
 .../test_aspeed_ast2500.py}                   |  0
 .../test_aspeed_ast2600.py}                   |  0
 .../test_aspeed_bletchley.py}                 |  0
 .../test_aspeed_catalina.py}                  |  0
 .../test_aspeed_gb200nvl_bmc.py}              |  0
 .../test_aspeed_palmetto.py}                  |  0
 .../test_aspeed_rainier.py}                   |  0
 .../test_aspeed_romulus.py}                   |  0
 .../test_aspeed_witherspoon.py}               |  0
 .../{test_arm_bflt.py => arm/test_bflt.py}    |  0
 .../test_bpim2u.py}                           |  0
 .../test_canona1100.py}                       |  0
 .../test_collie.py}                           |  0
 .../test_cubieboard.py}                       |  0
 .../test_emcraft_sf2.py}                      |  0
 .../test_integratorcp.py}                     |  0
 .../test_max78000fthr.py}                     |  0
 .../test_microbit.py}                         |  0
 .../test_migration.py}                        |  0
 .../test_orangepi.py}                         |  0
 .../test_quanta_gsj.py}                       |  0
 .../test_raspi2.py}                           |  0
 .../test_realview.py}                         |  0
 .../test_replay.py}                           |  0
 .../test_smdkc210.py}                         |  0
 .../test_stellaris.py}                        |  0
 .../{test_arm_sx1.py => arm/test_sx1.py}      |  0
 .../test_tuxrun.py}                           |  0
 .../test_vexpress.py}                         |  0
 .../{test_arm_virt.py => arm/test_virt.py}    |  0
 tests/functional/meson.build                  | 62 +------------------
 34 files changed, 83 insertions(+), 79 deletions(-)
 create mode 100644 tests/functional/arm/meson.build
 rename tests/functional/{test_arm_aspeed_ast1030.py => arm/test_aspeed_ast1030.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2500.py => arm/test_aspeed_ast2500.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2600.py => arm/test_aspeed_ast2600.py} (100%)
 rename tests/functional/{test_arm_aspeed_bletchley.py => arm/test_aspeed_bletchley.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_aspeed_catalina.py => arm/test_aspeed_catalina.py} (100%)
 rename tests/functional/{test_arm_aspeed_gb200nvl_bmc.py => arm/test_aspeed_gb200nvl_bmc.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_aspeed_palmetto.py => arm/test_aspeed_palmetto.py} (100%)
 rename tests/functional/{test_arm_aspeed_rainier.py => arm/test_aspeed_rainier.py} (100%)
 rename tests/functional/{test_arm_aspeed_romulus.py => arm/test_aspeed_romulus.py} (100%)
 rename tests/functional/{test_arm_aspeed_witherspoon.py => arm/test_aspeed_witherspoon.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_bflt.py => arm/test_bflt.py} (100%)
 rename tests/functional/{test_arm_bpim2u.py => arm/test_bpim2u.py} (100%)
 rename tests/functional/{test_arm_canona1100.py => arm/test_canona1100.py} (100%)
 rename tests/functional/{test_arm_collie.py => arm/test_collie.py} (100%)
 rename tests/functional/{test_arm_cubieboard.py => arm/test_cubieboard.py} (100%)
 rename tests/functional/{test_arm_emcraft_sf2.py => arm/test_emcraft_sf2.py} (100%)
 rename tests/functional/{test_arm_integratorcp.py => arm/test_integratorcp.py} (100%)
 rename tests/functional/{test_arm_max78000fthr.py => arm/test_max78000fthr.py} (100%)
 rename tests/functional/{test_arm_microbit.py => arm/test_microbit.py} (100%)
 rename tests/functional/{test_arm_migration.py => arm/test_migration.py} (100%)
 rename tests/functional/{test_arm_orangepi.py => arm/test_orangepi.py} (100%)
 rename tests/functional/{test_arm_quanta_gsj.py => arm/test_quanta_gsj.py} (100%)
 rename tests/functional/{test_arm_raspi2.py => arm/test_raspi2.py} (100%)
 rename tests/functional/{test_arm_realview.py => arm/test_realview.py} (100%)
 rename tests/functional/{test_arm_replay.py => arm/test_replay.py} (100%)
 rename tests/functional/{test_arm_smdkc210.py => arm/test_smdkc210.py} (100%)
 rename tests/functional/{test_arm_stellaris.py => arm/test_stellaris.py} (100%)
 rename tests/functional/{test_arm_sx1.py => arm/test_sx1.py} (100%)
 rename tests/functional/{test_arm_tuxrun.py => arm/test_tuxrun.py} (100%)
 rename tests/functional/{test_arm_vexpress.py => arm/test_vexpress.py} (100%)
 rename tests/functional/{test_arm_virt.py => arm/test_virt.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8115aae6183..1eb964feca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -444,6 +444,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: target/arm/kvm.c
+F: tests/functional/aarch64/test_kvm.py
 
 MIPS KVM CPUs
 M: Huacai Chen <chenhuacai@kernel.org>
@@ -673,7 +674,7 @@ F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 F: docs/system/arm/cubieboard.rst
 F: hw/misc/axp209.c
-F: tests/functional/test_arm_cubieboard.py
+F: tests/functional/arm/test_cubieboard.py
 
 Allwinner-h3
 M: Niek Linnenbank <nieklinnenbank@gmail.com>
@@ -683,7 +684,7 @@ F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
 F: hw/arm/orangepi.c
 F: docs/system/arm/orangepi.rst
-F: tests/functional/test_arm_orangepi.py
+F: tests/functional/arm/test_orangepi.py
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -753,7 +754,7 @@ F: docs/system/arm/bananapi_m2u.rst
 F: hw/*/allwinner-r40*.c
 F: hw/arm/bananapi_m2u.c
 F: include/hw/*/allwinner-r40*.h
-F: tests/functional/test_arm_bpim2u.py
+F: tests/functional/arm/test_bpim2u.py
 
 B-L475E-IOT01A IoT Node
 M: Samuel Tardieu <sam@rfc1149.net>
@@ -771,7 +772,7 @@ S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/*/exynos*
 F: docs/system/arm/exynos.rst
-F: tests/functional/test_arm_smdkc210.py
+F: tests/functional/arm/test_smdkc210.py
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
@@ -790,7 +791,7 @@ S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
-F: tests/functional/test_arm_canona1100.py
+F: tests/functional/arm/test_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
@@ -833,7 +834,7 @@ S: Odd Fixes
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
-F: tests/functional/test_arm_integratorcp.py
+F: tests/functional/arm/test_integratorcp.py
 F: docs/system/arm/integratorcp.rst
 
 MCIMX6UL EVK / i.MX6ul
@@ -939,7 +940,7 @@ F: pc-bios/npcm7xx_bootrom.bin
 F: pc-bios/npcm8xx_bootrom.bin
 F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
-F: tests/functional/test_arm_quanta_gsj.py
+F: tests/functional/arm/test_quanta_gsj.py
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -952,7 +953,7 @@ F: hw/*/bcm283*
 F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
-F: tests/functional/test_arm_raspi2.py
+F: tests/functional/arm/test_raspi2.py
 F: tests/functional/aarch64/test_raspi*.py
 
 Real View
@@ -964,7 +965,7 @@ F: hw/cpu/realview_mpcore.c
 F: hw/intc/realview_gic.c
 F: include/hw/intc/realview_gic.h
 F: docs/system/arm/realview.rst
-F: tests/functional/test_arm_realview.py
+F: tests/functional/arm/test_realview.py
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1004,7 +1005,7 @@ F: hw/arm/strongarm*
 F: hw/gpio/zaurus.c
 F: include/hw/arm/sharpsl.h
 F: docs/system/arm/collie.rst
-F: tests/functional/test_arm_collie.py
+F: tests/functional/arm/test_collie.py
 
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1015,7 +1016,7 @@ F: hw/display/ssd03*
 F: include/hw/input/stellaris_gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
-F: tests/functional/test_arm_stellaris.py
+F: tests/functional/arm/test_stellaris.py
 
 STM32L4x5 SoC Family
 M: Samuel Tardieu <sam@rfc1149.net>
@@ -1044,7 +1045,7 @@ S: Odd Fixes
 F: hw/arm/vexpress.c
 F: hw/display/sii9022.c
 F: docs/system/arm/vexpress.rst
-F: tests/functional/test_arm_vexpress.py
+F: tests/functional/arm/test_vexpress.py
 
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1065,8 +1066,8 @@ F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
 F: tests/functional/aarch64/test_*virt*.py
 F: tests/functional/aarch64/test_tuxrun.py
-F: tests/functional/test_arm_tuxrun.py
-F: tests/functional/test_arm_virt.py
+F: tests/functional/arm/test_tuxrun.py
+F: tests/functional/arm/test_virt.py
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
@@ -1187,7 +1188,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/msf2-som.c
 F: docs/system/arm/emcraft-sf2.rst
-F: tests/functional/test_arm_emcraft_sf2.py
+F: tests/functional/arm/test_emcraft_sf2.py
 
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
@@ -1205,6 +1206,7 @@ F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 F: docs/system/arm/aspeed.rst
 F: docs/system/arm/fby35.rst
+F: tests/functional/*/*aspeed*
 F: tests/*/*aspeed*
 F: tests/*/*ast2700*
 F: hw/arm/fby35.c
@@ -1220,7 +1222,7 @@ F: hw/*/microbit*.c
 F: include/hw/*/nrf51*.h
 F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
-F: tests/functional/test_arm_microbit.py
+F: tests/functional/arm/test_microbit.py
 F: docs/system/arm/nrf.rst
 
 ARM PL011 Rust device
@@ -2077,7 +2079,7 @@ S: Odd Fixes
 F: hw/*/omap*
 F: include/hw/arm/omap.h
 F: docs/system/arm/sx1.rst
-F: tests/functional/test_arm_sx1.py
+F: tests/functional/arm/test_sx1.py
 
 IPack
 M: Alberto Garcia <berto@igalia.com>
@@ -3914,7 +3916,7 @@ F: configs/targets/*linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
 F: scripts/update-syscalltbl.sh
 F: scripts/update-mips-syscall-args.sh
-F: tests/functional/test_arm_bflt.py
+F: tests/functional/arm/test_bflt.py
 
 Tiny Code Generator (TCG)
 -------------------------
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
new file mode 100644
index 00000000000..e4e7dba8d08
--- /dev/null
+++ b/tests/functional/arm/meson.build
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_arm_timeouts = {
+  'aspeed_palmetto' : 120,
+  'aspeed_romulus' : 120,
+  'aspeed_witherspoon' : 120,
+  'aspeed_ast2500' : 720,
+  'aspeed_ast2600' : 1200,
+  'aspeed_bletchley' : 480,
+  'aspeed_catalina' : 480,
+  'aspeed_gb200nvl_bmc' : 480,
+  'aspeed_rainier' : 480,
+  'bpim2u' : 500,
+  'collie' : 180,
+  'cubieboard' : 360,
+  'orangepi' : 540,
+  'quanta_gsj' : 240,
+  'raspi2' : 120,
+  'replay' : 240,
+  'tuxrun' : 240,
+  'sx1' : 360,
+}
+
+tests_arm_system_quick = [
+  'migration',
+]
+
+tests_arm_system_thorough = [
+  'aspeed_ast1030',
+  'aspeed_palmetto',
+  'aspeed_romulus',
+  'aspeed_witherspoon',
+  'aspeed_ast2500',
+  'aspeed_ast2600',
+  'aspeed_bletchley',
+  'aspeed_catalina',
+  'aspeed_gb200nvl_bmc',
+  'aspeed_rainier',
+  'bpim2u',
+  'canona1100',
+  'collie',
+  'cubieboard',
+  'emcraft_sf2',
+  'integratorcp',
+  'max78000fthr',
+  'microbit',
+  'orangepi',
+  'quanta_gsj',
+  'raspi2',
+  'realview',
+  'replay',
+  'smdkc210',
+  'stellaris',
+  'sx1',
+  'vexpress',
+  'virt',
+  'tuxrun',
+]
+
+tests_arm_linuxuser_thorough = [
+  'bflt',
+]
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast1030.py
rename to tests/functional/arm/test_aspeed_ast1030.py
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/arm/test_aspeed_ast2500.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast2500.py
rename to tests/functional/arm/test_aspeed_ast2500.py
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast2600.py
rename to tests/functional/arm/test_aspeed_ast2600.py
diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_arm_aspeed_bletchley.py
rename to tests/functional/arm/test_aspeed_bletchley.py
diff --git a/tests/functional/test_arm_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_catalina.py
rename to tests/functional/arm/test_aspeed_catalina.py
diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_arm_aspeed_gb200nvl_bmc.py
rename to tests/functional/arm/test_aspeed_gb200nvl_bmc.py
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/arm/test_aspeed_palmetto.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_palmetto.py
rename to tests/functional/arm/test_aspeed_palmetto.py
diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_rainier.py
rename to tests/functional/arm/test_aspeed_rainier.py
diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/arm/test_aspeed_romulus.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_romulus.py
rename to tests/functional/arm/test_aspeed_romulus.py
diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/arm/test_aspeed_witherspoon.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_arm_aspeed_witherspoon.py
rename to tests/functional/arm/test_aspeed_witherspoon.py
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/arm/test_bflt.py
similarity index 100%
rename from tests/functional/test_arm_bflt.py
rename to tests/functional/arm/test_bflt.py
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/arm/test_bpim2u.py
similarity index 100%
rename from tests/functional/test_arm_bpim2u.py
rename to tests/functional/arm/test_bpim2u.py
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/arm/test_canona1100.py
similarity index 100%
rename from tests/functional/test_arm_canona1100.py
rename to tests/functional/arm/test_canona1100.py
diff --git a/tests/functional/test_arm_collie.py b/tests/functional/arm/test_collie.py
similarity index 100%
rename from tests/functional/test_arm_collie.py
rename to tests/functional/arm/test_collie.py
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/arm/test_cubieboard.py
similarity index 100%
rename from tests/functional/test_arm_cubieboard.py
rename to tests/functional/arm/test_cubieboard.py
diff --git a/tests/functional/test_arm_emcraft_sf2.py b/tests/functional/arm/test_emcraft_sf2.py
similarity index 100%
rename from tests/functional/test_arm_emcraft_sf2.py
rename to tests/functional/arm/test_emcraft_sf2.py
diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/arm/test_integratorcp.py
similarity index 100%
rename from tests/functional/test_arm_integratorcp.py
rename to tests/functional/arm/test_integratorcp.py
diff --git a/tests/functional/test_arm_max78000fthr.py b/tests/functional/arm/test_max78000fthr.py
similarity index 100%
rename from tests/functional/test_arm_max78000fthr.py
rename to tests/functional/arm/test_max78000fthr.py
diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/arm/test_microbit.py
similarity index 100%
rename from tests/functional/test_arm_microbit.py
rename to tests/functional/arm/test_microbit.py
diff --git a/tests/functional/test_arm_migration.py b/tests/functional/arm/test_migration.py
similarity index 100%
rename from tests/functional/test_arm_migration.py
rename to tests/functional/arm/test_migration.py
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/arm/test_orangepi.py
similarity index 100%
rename from tests/functional/test_arm_orangepi.py
rename to tests/functional/arm/test_orangepi.py
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/arm/test_quanta_gsj.py
similarity index 100%
rename from tests/functional/test_arm_quanta_gsj.py
rename to tests/functional/arm/test_quanta_gsj.py
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/arm/test_raspi2.py
similarity index 100%
rename from tests/functional/test_arm_raspi2.py
rename to tests/functional/arm/test_raspi2.py
diff --git a/tests/functional/test_arm_realview.py b/tests/functional/arm/test_realview.py
similarity index 100%
rename from tests/functional/test_arm_realview.py
rename to tests/functional/arm/test_realview.py
diff --git a/tests/functional/test_arm_replay.py b/tests/functional/arm/test_replay.py
similarity index 100%
rename from tests/functional/test_arm_replay.py
rename to tests/functional/arm/test_replay.py
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/arm/test_smdkc210.py
similarity index 100%
rename from tests/functional/test_arm_smdkc210.py
rename to tests/functional/arm/test_smdkc210.py
diff --git a/tests/functional/test_arm_stellaris.py b/tests/functional/arm/test_stellaris.py
similarity index 100%
rename from tests/functional/test_arm_stellaris.py
rename to tests/functional/arm/test_stellaris.py
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/arm/test_sx1.py
similarity index 100%
rename from tests/functional/test_arm_sx1.py
rename to tests/functional/arm/test_sx1.py
diff --git a/tests/functional/test_arm_tuxrun.py b/tests/functional/arm/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_arm_tuxrun.py
rename to tests/functional/arm/test_tuxrun.py
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/arm/test_vexpress.py
similarity index 100%
rename from tests/functional/test_arm_vexpress.py
rename to tests/functional/arm/test_vexpress.py
diff --git a/tests/functional/test_arm_virt.py b/tests/functional/arm/test_virt.py
similarity index 100%
rename from tests/functional/test_arm_virt.py
rename to tests/functional/arm/test_virt.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a7f8c88a078..6989446d1c4 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,27 +11,7 @@ endif
 
 subdir('aarch64')
 subdir('alpha')
-
-test_arm_timeouts = {
-  'arm_aspeed_palmetto' : 120,
-  'arm_aspeed_romulus' : 120,
-  'arm_aspeed_witherspoon' : 120,
-  'arm_aspeed_ast2500' : 720,
-  'arm_aspeed_ast2600' : 1200,
-  'arm_aspeed_bletchley' : 480,
-  'arm_aspeed_catalina' : 480,
-  'arm_aspeed_gb200nvl_bmc' : 480,
-  'arm_aspeed_rainier' : 480,
-  'arm_bpim2u' : 500,
-  'arm_collie' : 180,
-  'arm_cubieboard' : 360,
-  'arm_orangepi' : 540,
-  'arm_quanta_gsj' : 240,
-  'arm_raspi2' : 120,
-  'arm_replay' : 240,
-  'arm_tuxrun' : 240,
-  'arm_sx1' : 360,
-}
+subdir('arm')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -97,46 +77,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_arm_system_quick = [
-  'arm_migration',
-]
-
-tests_arm_system_thorough = [
-  'arm_aspeed_ast1030',
-  'arm_aspeed_palmetto',
-  'arm_aspeed_romulus',
-  'arm_aspeed_witherspoon',
-  'arm_aspeed_ast2500',
-  'arm_aspeed_ast2600',
-  'arm_aspeed_bletchley',
-  'arm_aspeed_catalina',
-  'arm_aspeed_gb200nvl_bmc',
-  'arm_aspeed_rainier',
-  'arm_bpim2u',
-  'arm_canona1100',
-  'arm_collie',
-  'arm_cubieboard',
-  'arm_emcraft_sf2',
-  'arm_integratorcp',
-  'arm_max78000fthr',
-  'arm_microbit',
-  'arm_orangepi',
-  'arm_quanta_gsj',
-  'arm_raspi2',
-  'arm_realview',
-  'arm_replay',
-  'arm_smdkc210',
-  'arm_stellaris',
-  'arm_sx1',
-  'arm_vexpress',
-  'arm_virt',
-  'arm_tuxrun',
-]
-
-tests_arm_linuxuser_thorough = [
-  'arm_bflt',
-]
-
 tests_avr_system_thorough = [
   'avr_mega2560',
   'avr_uno',
-- 
2.50.1


