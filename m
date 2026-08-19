Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD647C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdp-00080q-FE; Wed, 19 Aug 2026 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzh-0005TN-Ko
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:49 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzf-0000Oq-No
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:49 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzb-000000002Rb-0NKK; Wed, 19 Aug 2026 06:41:43 +0000
Date: Wed, 19 Aug 2026 07:41:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/misc/applesmc: Emulate the SMC shutdown watchdog
Message-ID: <1a25c5a68854462891d8830847b28687fa5fe432.1787114994.git.daniel@makrotopia.org>
References: <cover.1787114994.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787114994.git.daniel@makrotopia.org>
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

"NATi", "NATJ" and "OSWD" are the SMC shutdown watchdog keys. On real
Intel Macs the OS arms this watchdog so that, if the machine wedges, the
SMC forces it off or reset. "NATi" and "OSWD" hold a countdown in seconds
and "NATJ" a job code (1 shut down, 2 restart); a non-zero countdown arms
or refreshes the watchdog and zero disarms it.

The previous patch already lets writes to these keys succeed, but treats
them like any other write. Model them as the watchdog they are instead of
silently accepting them: back them with a QEMUTimer that a write arms,
refreshes or disarms, and whose expiry requests a guest shutdown or reset
through the main loop with no guest cooperation, matching the hardware
backstop. Add "NATi" and "OSWD" so the guest can read them back.

A traced macOS guest writes "OSWD" with a zero countdown to disarm the
watchdog during shutdown, which this handles; the arm-and-expiry path is
the documented behaviour for a guest that arms it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  3 ++
 2 files changed, 77 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index bc44b0f1d8..8d5bf74373 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -39,6 +39,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 /* #define DEBUG_SMC */
@@ -80,6 +81,17 @@ enum {
     APPLESMC_ST_1E_BAD_INDEX         = 0xb8,
 };
 
+/*
+ * Job codes written to the "NATJ" key, and implied by "OSWD": the action the
+ * SMC watchdog takes when its countdown (seeded from "NATi"/"OSWD") elapses
+ * because the guest failed to power down in time.
+ */
+enum {
+    APPLESMC_WDT_DISABLE             = 0,
+    APPLESMC_WDT_SHUTDOWN            = 1,
+    APPLESMC_WDT_RESTART             = 2,
+};
+
 #ifdef DEBUG_SMC
 #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
 #else
@@ -116,6 +128,10 @@ struct AppleSMCState {
     uint8_t data[255];
     char *osk;
     QLIST_HEAD(, AppleSMCData) data_def;
+
+    QEMUTimer *wdt_timer;   /* shutdown watchdog, armed via NATi/NATJ/OSWD */
+    uint16_t wdt_timeout;   /* countdown in seconds */
+    uint8_t wdt_job;        /* action on expiry (APPLESMC_WDT_*) */
 };
 
 static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
@@ -162,6 +178,48 @@ static const struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
     return NULL;
 }
 
+static void applesmc_wdt_expired(void *opaque)
+{
+    AppleSMCState *s = opaque;
+
+    trace_applesmc_wdt_expired(s->wdt_job);
+    warn_report("applesmc: watchdog expired, forcing the guest down");
+    if (s->wdt_job == APPLESMC_WDT_SHUTDOWN) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    } else {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static void applesmc_wdt_set(AppleSMCState *s, uint8_t job, uint16_t seconds)
+{
+    s->wdt_job = job;
+    if (job == APPLESMC_WDT_DISABLE || seconds == 0) {
+        timer_del(s->wdt_timer);
+        trace_applesmc_wdt_disarm();
+        return;
+    }
+    timer_mod(s->wdt_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (int64_t)seconds * NANOSECONDS_PER_SECOND);
+    trace_applesmc_wdt_arm(seconds, job);
+}
+
+/* Act on a guest write once its full payload has been received. */
+static void applesmc_write_key(AppleSMCState *s)
+{
+    if (!memcmp(s->key, "NATi", 4) && s->data_len >= 2) {
+        /* Big-endian seconds; stored only, the "NATJ" write arms the timer. */
+        s->wdt_timeout = (s->data[0] << 8) | s->data[1];
+    } else if (!memcmp(s->key, "NATJ", 4) && s->data_len >= 1) {
+        applesmc_wdt_set(s, s->data[0], s->wdt_timeout);
+    } else if (!memcmp(s->key, "OSWD", 4) && s->data_len >= 2) {
+        uint16_t seconds = (s->data[0] << 8) | s->data[1];
+        uint8_t job = seconds ? APPLESMC_WDT_RESTART : APPLESMC_WDT_DISABLE;
+
+        applesmc_wdt_set(s, job, seconds);
+    }
+}
+
 static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                    unsigned size)
 {
@@ -218,6 +276,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
             trace_applesmc_write_len(s->key[0], s->key[1], s->key[2],
                                      s->key[3], s->data_len);
             if (s->data_len == 0) {
+                applesmc_write_key(s);
                 s->status = APPLESMC_ST_CMD_DONE;
                 s->status_1e = APPLESMC_ST_CMD_DONE;
             }
@@ -229,6 +288,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                 s->data_pos++;
             }
             if (s->data_pos >= s->data_len) {
+                applesmc_write_key(s);
                 trace_applesmc_write_complete(s->key[0], s->key[1],
                                               s->key[2], s->key[3],
                                               s->data_len);
@@ -325,6 +385,12 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     s->status = 0x00;
     s->status_1e = 0x00;
     s->last_ret = 0x00;
+
+    if (s->wdt_timer) {
+        timer_del(s->wdt_timer);
+    }
+    s->wdt_job = APPLESMC_WDT_DISABLE;
+    s->wdt_timeout = 0;
 }
 
 static const MemoryRegionOps applesmc_data_io_ops = {
@@ -388,6 +454,10 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     applesmc_add_key(s, "NATJ", 1, "\x00");
     applesmc_add_key(s, "MSSP", 1, "\x00");
     applesmc_add_key(s, "MSSD", 1, "\x03");
+    applesmc_add_key(s, "NATi", 2, "\x00\x00");
+    applesmc_add_key(s, "OSWD", 2, "\x00\x00");
+
+    s->wdt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, applesmc_wdt_expired, s);
 }
 
 static void applesmc_unrealize(DeviceState *dev)
@@ -395,6 +465,10 @@ static void applesmc_unrealize(DeviceState *dev)
     AppleSMCState *s = APPLE_SMC(dev);
     struct AppleSMCData *d, *next;
 
+    if (s->wdt_timer) {
+        timer_free(s->wdt_timer);
+    }
+
     /* Remove existing entries */
     QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
         QLIST_REMOVE(d, node);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index fc01cc9b7d..d94a5fba8a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -48,6 +48,9 @@ applesmc_data_read(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos,
 applesmc_write_len(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t len) "write key %c%c%c%c len %u"
 applesmc_write_data(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "write key %c%c%c%c [%u] 0x%02x"
 applesmc_write_complete(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t len) "write key %c%c%c%c complete (%u bytes)"
+applesmc_wdt_arm(uint16_t seconds, uint8_t job) "watchdog armed %u s, job %u"
+applesmc_wdt_disarm(void) "watchdog disarmed"
+applesmc_wdt_expired(uint8_t job) "watchdog expired, job %u"
 
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
-- 
2.55.0

