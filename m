Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231B3C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkDt-0005K1-Ui; Wed, 19 Aug 2026 13:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDr-0005Iy-Iq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:37:07 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDp-0001WS-C4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:37:07 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDl-000000005lk-0mRj; Wed, 19 Aug 2026 17:37:01 +0000
Date: Wed, 19 Aug 2026 18:36:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Matthew Jackson <matthew@pq.io>, Alexander Graf <agraf@csgraf.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/misc/applesmc: Emulate the SMC shutdown watchdog
Message-ID: <6888e300e29ce09f2c754641c6108da170357dbd.1787150842.git.daniel@makrotopia.org>
References: <20260720164930.68383-1-matthew@pq.io>
 <cover.1787150842.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787150842.git.daniel@makrotopia.org>
Received-SPF: pass client-ip=2a07:2ec0:3002::65;
 envelope-from=daniel@makrotopia.org; helo=pidgin.makrotopia.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "NATi", "NATJ" and "OSWD" keys drive the SMC shutdown watchdog: a
guest arms a countdown and the SMC forces the machine down if the guest
stops refreshing it. The previous patch lets writes to these keys
succeed; model them as the watchdog they are instead of discarding the
value, so a guest that arms the watchdog gets the reset or power-off it
asked for.

NATi sets the timeout in seconds, NATJ selects the job and arms it (0
disarms, 1 powers the machine down, 2 restarts it), and OSWD is a
one-shot shutdown timer. A write arms, refreshes or disarms a
QEMU_CLOCK_VIRTUAL timer whose expiry raises a guest shutdown or reset
request.

A traced macOS guest writes OSWD with a zero countdown to disarm on its
way down and does not otherwise arm the watchdog; the arm-and-expiry
path is the documented behaviour for a guest that does arm it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  3 ++
 2 files changed, 69 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 4a82a36a2a..e329b2e1e6 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -40,6 +40,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 /* #define DEBUG_SMC */
@@ -81,6 +82,12 @@ enum {
     APPLESMC_ST_1E_BAD_INDEX         = 0xb8,
 };
 
+enum {
+    APPLESMC_WDT_DISARM              = 0,
+    APPLESMC_WDT_SHUTDOWN            = 1,
+    APPLESMC_WDT_RESTART             = 2,
+};
+
 #ifdef DEBUG_SMC
 #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
 #else
@@ -117,6 +124,9 @@ struct AppleSMCState {
     uint8_t data[255];
     char *osk;
     QLIST_HEAD(, AppleSMCData) data_def;
+    QEMUTimer *wdt_timer;
+    uint16_t wdt_timeout;
+    uint8_t wdt_job;
 };
 
 static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
@@ -169,6 +179,53 @@ static const struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
     return NULL;
 }
 
+static void applesmc_wdt_expired(void *opaque)
+{
+    AppleSMCState *s = opaque;
+
+    trace_applesmc_wdt_expired(s->wdt_job);
+    if (s->wdt_job == APPLESMC_WDT_RESTART) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    } else {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
+static void applesmc_wdt_update(AppleSMCState *s)
+{
+    if (s->wdt_job == APPLESMC_WDT_DISARM || s->wdt_timeout == 0) {
+        timer_del(s->wdt_timer);
+        trace_applesmc_wdt_disarm();
+        return;
+    }
+    timer_mod(s->wdt_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (uint64_t)s->wdt_timeout * NANOSECONDS_PER_SECOND);
+    trace_applesmc_wdt_arm(s->wdt_job, s->wdt_timeout);
+}
+
+/*
+ * The "NATi"/"NATJ"/"OSWD" keys are the SMC shutdown watchdog macOS uses to
+ * force the machine down if userspace stops petting it: NATi sets the
+ * timeout in seconds, NATJ selects and arms the job (0 disarm, 1 shutdown,
+ * 2 restart), and OSWD is a one-shot shutdown timer. A write to one of them
+ * arms, refreshes or disarms the timer rather than being silently discarded.
+ */
+static void applesmc_wdt_write_key(AppleSMCState *s)
+{
+    if (!memcmp(s->key, "NATi", 4) && s->data_len >= 2) {
+        s->wdt_timeout = (s->data[0] << 8) | s->data[1];
+    } else if (!memcmp(s->key, "NATJ", 4) && s->data_len >= 1) {
+        s->wdt_job = s->data[0];
+        applesmc_wdt_update(s);
+    } else if (!memcmp(s->key, "OSWD", 4) && s->data_len >= 2) {
+        s->wdt_timeout = (s->data[0] << 8) | s->data[1];
+        s->wdt_job = s->wdt_timeout ? APPLESMC_WDT_SHUTDOWN
+                                    : APPLESMC_WDT_DISARM;
+        applesmc_wdt_update(s);
+    }
+}
+
 static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                    unsigned size)
 {
@@ -243,6 +300,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                   s->data_len);
                     trace_applesmc_write(s->key[0], s->key[1], s->key[2],
                                          s->key[3], s->data_len);
+                    applesmc_wdt_write_key(s);
                     s->status = APPLESMC_ST_CMD_DONE;
                     s->status_1e = APPLESMC_ST_CMD_DONE;
                 } else {
@@ -449,6 +507,9 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     s->status = 0x00;
     s->status_1e = 0x00;
     s->last_ret = 0x00;
+    s->wdt_job = APPLESMC_WDT_DISARM;
+    s->wdt_timeout = 0;
+    timer_del(s->wdt_timer);
 }
 
 static const MemoryRegionOps applesmc_data_io_ops = {
@@ -485,6 +546,8 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
 {
     AppleSMCState *s = APPLE_SMC(dev);
 
+    s->wdt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, applesmc_wdt_expired, s);
+
     memory_region_init_io(&s->io_data, OBJECT(s), &applesmc_data_io_ops, s,
                           "applesmc-data", 1);
     isa_register_ioport(&s->parent_obj, &s->io_data,
@@ -511,6 +574,7 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
+    applesmc_add_key(s, "NATi", 2, "\0\0");
     applesmc_add_key(s, "NATJ", 1, "\0");
     applesmc_add_key(s, "MSSP", 1, "\0");
     applesmc_add_key(s, "MSSD", 1, "\x03");
@@ -687,6 +751,8 @@ static void applesmc_unrealize(DeviceState *dev)
     AppleSMCState *s = APPLE_SMC(dev);
     struct AppleSMCData *d, *next;
 
+    timer_free(s->wdt_timer);
+
     /* Remove existing entries */
     QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
         QLIST_REMOVE(d, node);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5b823182c9..a62d357213 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -46,6 +46,9 @@ applesmc_write(char k0, char k1, char k2, char k3, uint8_t len) "WRITE '%c%c%c%c
 applesmc_key_type(char k0, char k1, char k2, char k3, uint8_t len) "GET_KEY_TYPE '%c%c%c%c' size %u"
 applesmc_key_by_index(uint32_t idx, char k0, char k1, char k2, char k3) "GET_KEY_BY_INDEX %u -> '%c%c%c%c'"
 applesmc_key_by_index_end(uint32_t idx) "GET_KEY_BY_INDEX %u past end"
+applesmc_wdt_arm(uint8_t job, uint16_t seconds) "arm job %u timeout %us"
+applesmc_wdt_disarm(void) "disarm"
+applesmc_wdt_expired(uint8_t job) "expired job %u"
 
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
-- 
2.55.0

