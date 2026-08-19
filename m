Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3EC5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdn-00080o-CI; Wed, 19 Aug 2026 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzY-0005Py-3d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:40 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzW-0000Kv-Gd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:39 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzM-000000002Qo-0Gve; Wed, 19 Aug 2026 06:41:28 +0000
Date: Wed, 19 Aug 2026 07:41:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/misc/applesmc: Add trace events
Message-ID: <f5f6243dfb572ba2dbf9c929f6cb497b3723e6be.1787114994.git.daniel@makrotopia.org>
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

The device only offered the compile-time DEBUG_SMC fprintf() macro for
introspection. Add trace events for the command and data port
transactions: the incoming command byte and whether it was accepted or
rejected, each four-character key as it is assembled, key lookups that
miss, and every data byte handed back. The SMC conversation a guest
performs can then be observed at runtime, for example with
-trace 'applesmc*', which is helpful for understanding which keys and
commands a macOS guest actually issues.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 13 +++++++++++++
 hw/misc/trace-events |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index d004e8b443..6f9d0a590d 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -39,6 +39,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "trace.h"
 
 /* #define DEBUG_SMC */
 
@@ -123,6 +124,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     AppleSMCState *s = opaque;
     uint8_t status = s->status & 0x0f;
 
+    trace_applesmc_cmd_write((uint8_t)val, s->status);
     smc_debug("CMD received: 0x%02x\n", (uint8_t)val);
     switch (val) {
     case APPLESMC_READ_CMD:
@@ -130,6 +132,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
         if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
             s->cmd = val;
             s->status = APPLESMC_ST_NEW_CMD | APPLESMC_ST_ACK;
+            trace_applesmc_cmd_accepted((uint8_t)val);
         } else {
             smc_debug("ERROR: previous command interrupted!\n");
             s->status = APPLESMC_ST_NEW_CMD;
@@ -140,6 +143,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
         smc_debug("UNEXPECTED CMD 0x%02x\n", (uint8_t)val);
         s->status = APPLESMC_ST_NEW_CMD;
         s->status_1e = APPLESMC_ST_1E_BAD_CMD;
+        trace_applesmc_cmd_rejected((uint8_t)val, s->status_1e);
     }
     s->read_pos = 0;
     s->data_pos = 0;
@@ -164,6 +168,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
     const struct AppleSMCData *d;
 
     smc_debug("DATA received: 0x%02x\n", (uint8_t)val);
+    trace_applesmc_data_write(s->cmd, s->read_pos, (uint8_t)val);
     switch (s->cmd) {
     case APPLESMC_READ_CMD:
         if ((s->status & 0x0f) == APPLESMC_ST_CMD_DONE) {
@@ -172,6 +177,10 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
         if (s->read_pos < 4) {
             s->key[s->read_pos] = val;
             s->status = APPLESMC_ST_ACK;
+            if (s->read_pos == 3) {
+                trace_applesmc_key_selected(s->key[0], s->key[1],
+                                            s->key[2], s->key[3]);
+            }
         } else if (s->read_pos == 4) {
             d = applesmc_find_key(s);
             if (d != NULL) {
@@ -183,6 +192,8 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
             } else {
                 smc_debug("READ_CMD: key '%c%c%c%c' not found!\n",
                           s->key[0], s->key[1], s->key[2], s->key[3]);
+                trace_applesmc_key_not_found(s->key[0], s->key[1],
+                                             s->key[2], s->key[3]);
                 s->status = APPLESMC_ST_CMD_DONE;
                 s->status_1e = APPLESMC_ST_1E_NOEXIST;
             }
@@ -213,6 +224,8 @@ static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
         }
         if (s->data_pos < s->data_len) {
             s->last_ret = s->data[s->data_pos];
+            trace_applesmc_data_read(s->key[0], s->key[1], s->key[2],
+                                     s->key[3], s->data_pos, s->last_ret);
             smc_debug("READ '%c%c%c%c'[%d] = %02x\n",
                       s->key[0], s->key[1], s->key[2], s->key[3],
                       s->data_pos, s->last_ret);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3ef..b924b4398e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -37,6 +37,15 @@ allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%"
 allwinner_sramc_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_sramc_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 
+# applesmc.c
+applesmc_cmd_write(uint8_t cmd, uint8_t status) "cmd 0x%02x (status 0x%02x)"
+applesmc_cmd_accepted(uint8_t cmd) "cmd 0x%02x accepted"
+applesmc_cmd_rejected(uint8_t cmd, uint8_t status_1e) "cmd 0x%02x rejected (status_1e 0x%02x)"
+applesmc_data_write(uint8_t cmd, uint8_t pos, uint8_t val) "cmd 0x%02x pos %u data 0x%02x"
+applesmc_key_selected(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c"
+applesmc_key_not_found(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c not found"
+applesmc_data_read(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "read key %c%c%c%c [%u] 0x%02x"
+
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
 avr_power_write(uint8_t value) "power_reduc write value:%u"
-- 
2.55.0

