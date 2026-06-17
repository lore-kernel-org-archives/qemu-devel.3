Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FA8CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 23:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa022-0004PH-4L; Wed, 17 Jun 2026 19:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01w-0004NL-IR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:48 -0400
Received: from p-east2-cluster1-host7-snip4-8.eps.apple.com ([57.103.76.71]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01u-0003tp-0G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:47 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 C8A071800CDA; Wed, 17 Jun 2026 23:50:41 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ5YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcAFkBRQlLAUMFWgZJCFUGQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781740242; x=1784332242; bh=QxIFPOHU7e9gIqyhQkeZZjwyxbbbOQrk6FsunfvYN9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=iCGb2VA+Vy00aS1gfGjSHtgzcQZZ7R6sY9JtHlUjAQwcOUvY0Th650yccUkbzjhrlE7dKii2joucDfDj48NXdt9NdsiNZOPrawHoPLZek4TOyHw88fQ2SdvXS4UId3zyXHBu4mmn8Gml9cenux8ZKVTJ7qEtXL7rw8f6IoPCYVSnJ3VrmU1hoLtzb2CuoNGoS4vY+AR11dFZpYqMnJ6xghipVgsaf2GJU3UwimNoGGSG6CmF6G9cH+YToJWDsRMVdTT2dgAHsYDqhbOptePExa7EsLWhrOhQEsDkWF64FaxFCKk34ur0WIpZaDXMoStGuW4pX9Pw58H+dAPwL7TJ0w==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 234391800C16; Wed, 17 Jun 2026 23:50:41 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v2 4/5] hw/m68k: add working floppy controller for q800
Date: Wed, 17 Jun 2026 19:50:31 -0400
Message-ID: <20260617235032.21491-5-mhjacobson@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617235032.21491-1-mhjacobson@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIyOCBTYWx0ZWRfXwThi3PryvK4x
 /Y/3lcd336p/bZuTRydYIG4YX0MqDYHzs7Z/qfCGuUE2Vd/BZUkuA6IzOv4lgxm3D3Rl0m4IQur
 /NB5SKOPNCTEkDBgH18NPrKuMTUkvbx0MNkxx/P+8lB8VWd1/3vF74A6yF6zyyVZ7Zr3bRV5vEB
 yZka5IGaB6EQ7wUUtR8dxim4QFvTvoapTU51VohbydOFwqQBDdDqwTjUkyxqBXZ6A5tadymMzf3
 sNbcw0uLivaI2vednMBtasEfpCvYJzGdTqsALqfjBOmNzIKkZYKYX/GUp4Mawvt0I4hiZFpXWeZ
 g1PMwVG2ph1Z6Ez0sdl
X-Proofpoint-ORIG-GUID: fQAeRe0chWi0TUH8f3v0ER_qmOQwbJTp
X-Proofpoint-GUID: fQAeRe0chWi0TUH8f3v0ER_qmOQwbJTp
Received-SPF: pass client-ip=57.103.76.71; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
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
 include/hw/misc/mac_via.h |  4 ++++
 4 files changed, 25 insertions(+), 4 deletions(-)

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
index 114f41db4c..a25f219a25 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -35,6 +35,8 @@
 #define TYPE_MOS6522_Q800_VIA1 "mos6522-q800-via1"
 OBJECT_DECLARE_SIMPLE_TYPE(MOS6522Q800VIA1State, MOS6522_Q800_VIA1)
 
+struct SWIM2State;
+
 struct MOS6522Q800VIA1State {
     /*< private >*/
     MOS6522State parent_obj;
@@ -77,6 +79,8 @@ struct MOS6522Q800VIA1State {
 
     /* SETUPTIMEK hack */
     int timer_hack_state;
+
+    struct SWIM2State *swim;
 };
 
 
-- 
2.53.0


