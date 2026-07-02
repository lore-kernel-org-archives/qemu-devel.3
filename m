Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39772C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7BW-0004BV-QH; Wed, 01 Jul 2026 22:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BU-0004AC-S6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:48 -0400
Received: from ms-2002c-snip4-10.eps.apple.com ([57.103.74.72]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BQ-0002WO-R6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:48 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 DCCC9180011F; Thu, 02 Jul 2026 02:29:40 +0000 (UTC)
X-ICL-RepId: 019f20a9-193f-76d0-a759-46feb330b00b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQhIEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXAEALTgNaB1kCQgtBAVoZXwRFCEgeWBoGWhpYG1wPRARcMFQdHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782959383; x=1785551383; bh=slZFG3XWsAGvW3dJCKCnn4VgnlVItIo6kSH2q5+xM6A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IgdcQYVrATgunkNx7IaBe9oX19ZOJP1JRQtQ/xhDvKofzUJcoaE1cOHeatGjGBpqsub5VMzjwSwJ0TcCa3nTJD6iEYTx8rx1L4EHSS5gzFR39sSbnLSG8Lb4x2YeafaKZbV5AxfgMsK6lSxIZmmabKV55ImD9ixME+YGqWO2k2hiXHf59TdyMo+f4WKRDUpgvhKEMEKd6S8lnOd2Z5xjUPYIh0wAP8PiclZoP6fnjRcf/vXWiY9+9mP34tooTsqvdWAU+IZCdpwnzm0YKzY9Dfgo4XZ6yOzIKvubrtxDJbDXCA4km2A9xbqBufngeW2E17IVFKNr4QZCZwb/XKfoUA==
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 274C41800133; Thu, 02 Jul 2026 02:29:39 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v3 4/5] hw/m68k: add working floppy controller for q800
Date: Wed,  1 Jul 2026 22:29:26 -0400
Message-ID: <20260702022927.46510-5-mhjacobson@me.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702022927.46510-1-mhjacobson@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nwHQyttg-tzRgX-12fmOD74IpAP8pnFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMyBTYWx0ZWRfX1ujW4/kv33zl
 GWDBqJSaC/dhttGF4G9cxmh1oY2AS0hnLYtUlAbZ/cGZjkI/P1nH1upuR3ncRbBEvLg5w2rJ6Np
 kDHnvLdsQ2ulgjnoYxCav64cVs9RxN/yx8u8Y9JMFUVSXSeH6vFmoq1t8H6U2QZ7a+EP8/YV4ZJ
 f1v/AhfeEoOzk7KYHKgg6HWUdO+NkMo/Tz/RzsIX02DX2F/UEbWSqMx1IZO9tnTEcGjr3Mfiz/r
 XdE3JUdaqyqk5VlYaYM7S8iWjF0sjBIcwTn12ArYTaV3bzg7G8ckWTAjP0X+OASSrpwjul7C/dV
 o3vUJmvuDdkYUZmF+fX
X-Proofpoint-ORIG-GUID: nwHQyttg-tzRgX-12fmOD74IpAP8pnFG
Received-SPF: pass client-ip=57.103.74.72; envelope-from=mhjacobson@me.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Switch the Quadra 800 machine to the working SWIM2 floppy controller.
Hook up the HeadSel bit on the VIA to control the head selection (the
IWM does not handle this part itself).

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 hw/m68k/q800.c            |  5 +++--
 hw/misc/mac_via.c         | 16 ++++++++++++++++
 include/hw/m68k/q800.h    |  4 ++--
 include/hw/misc/mac_via.h |  3 +++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ab64250c47..a6997ef802 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -47,7 +47,7 @@
 #include "hw/audio/asc.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
-#include "hw/block/swim.h"
+#include "hw/block/swim2.h"
 #include "net/net.h"
 #include "net/util.h"
 #include "qapi/error.h"
@@ -338,6 +338,7 @@ static void q800_machine_init(MachineState *machine)
     /* VIA 1 */
     object_initialize_child(OBJECT(machine), "via1", &m->via1,
                             TYPE_MOS6522_Q800_VIA1);
+    m->via1.swim = &m->swim;
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
         qdev_prop_set_drive(DEVICE(&m->via1), "drive",
@@ -511,7 +512,7 @@ static void q800_machine_init(MachineState *machine)
     /* SWIM floppy controller */
 
     object_initialize_child(OBJECT(machine), "swim", &m->swim,
-                            TYPE_SWIM);
+                            TYPE_SWIM2);
     sysbus = SYS_BUS_DEVICE(&m->swim);
     sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 26ee230dcc..09197fe519 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -31,6 +31,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "system/rtc.h"
+#include "hw/block/swim2.h"
 #include "trace.h"
 #include "qemu/log.h"
 
@@ -1080,6 +1081,17 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
     mos6522_write(ms, addr, val, size);
 
     switch (addr) {
+    case VIA_REG_A:
+    case VIA_REG_ANH: {
+        const bool sel = (ms->a & VIA1A_vHeadSel) != 0;
+
+        if (v1s->swim) {
+            swim2_set_sel(v1s->swim, sel);
+        }
+
+        break;
+    }
+
     case VIA_REG_B:
         via1_rtc_update(v1s);
         via1_adb_update(v1s);
@@ -1224,6 +1236,10 @@ static void mos6522_q800_via1_reset_hold(Object *obj, ResetType type)
 
     /* Timer calibration hack */
     v1s->timer_hack_state = 0;
+
+    if (v1s->swim) {
+        swim2_set_sel(v1s->swim, false);
+    }
 }
 
 static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 77551b9592..2a20314d57 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,7 +33,7 @@
 #include "hw/char/escc.h"
 #include "hw/core/or-irq.h"
 #include "hw/scsi/esp.h"
-#include "hw/block/swim.h"
+#include "hw/block/swim2.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
 #include "hw/misc/djmemc.h"
@@ -59,7 +59,7 @@ struct Q800MachineState {
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
-    Swim swim;
+    SWIM2State swim;
     MacNubusBridge mac_nubus_bridge;
     MacfbNubusState macfb;
     DJMEMCState djmemc;
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 114f41db4c..e23735b47c 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -13,6 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/mos6522.h"
 #include "hw/input/adb.h"
+#include "hw/block/swim2.h"
 #include "qom/object.h"
 
 
@@ -77,6 +78,8 @@ struct MOS6522Q800VIA1State {
 
     /* SETUPTIMEK hack */
     int timer_hack_state;
+
+    SWIM2State *swim;
 };
 
 
-- 
2.54.0


