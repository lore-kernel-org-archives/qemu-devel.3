Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40053C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkDi-0005CN-Ra; Wed, 19 Aug 2026 13:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDh-0005CC-EX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:36:57 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDe-0001Ug-R1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:36:57 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwkDY-000000005lZ-3ZS9; Wed, 19 Aug 2026 17:36:48 +0000
Date: Wed, 19 Aug 2026 18:36:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Matthew Jackson <matthew@pq.io>, Alexander Graf <agraf@csgraf.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/misc/applesmc: Add trace events
Message-ID: <ad4aef2117b475e474833fb76b4c95d5bc1259c5.1787150842.git.daniel@makrotopia.org>
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

Add trace events for the command dispatch and for the read, write,
get-key-type and get-key-by-index handlers, so the sequence of commands
and keys a guest issues can be observed with

  -trace 'applesmc*'

This is how the exact set of commands and keys a macOS guest relies on
was determined, and it stays useful for debugging future guests and key
probes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 14 ++++++++++++++
 hw/misc/trace-events | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index d2f292f10e..4a82a36a2a 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -40,6 +40,7 @@
 #include "qemu/timer.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "trace.h"
 
 /* #define DEBUG_SMC */
 
@@ -138,6 +139,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
         if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
             s->cmd = val;
             s->status = APPLESMC_ST_NEW_CMD | APPLESMC_ST_ACK;
+            trace_applesmc_cmd(val);
         } else {
             smc_debug("ERROR: previous command interrupted!\n");
             s->status = APPLESMC_ST_NEW_CMD;
@@ -147,6 +149,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "applesmc: unexpected CMD 0x%02x\n", (uint8_t)val);
+        trace_applesmc_cmd_bad(val);
         s->status = APPLESMC_ST_NEW_CMD;
         s->status_1e = APPLESMC_ST_1E_BAD_CMD;
     }
@@ -189,6 +192,8 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                 s->data_pos = 0;
                 s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
                 s->status_1e = APPLESMC_ST_CMD_DONE;
+                trace_applesmc_read(s->key[0], s->key[1], s->key[2], s->key[3],
+                                    d->len);
             } else {
                 /*
                  * Return zeros for unknown keys instead of NOEXIST. Early
@@ -200,6 +205,8 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                               "applesmc: READ unknown key '%c%c%c%c' len=%d\n",
                               s->key[0], s->key[1], s->key[2], s->key[3],
                               (uint8_t)val);
+                trace_applesmc_read_unknown(s->key[0], s->key[1],
+                                            s->key[2], s->key[3]);
                 memset(s->data, 0, APPLESMC_MAX_DATA_LENGTH);
                 s->data_len = (uint8_t)val;
                 s->data_pos = 0;
@@ -234,6 +241,8 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                   "applesmc: WRITE key '%c%c%c%c' len=%d\n",
                                   s->key[0], s->key[1], s->key[2], s->key[3],
                                   s->data_len);
+                    trace_applesmc_write(s->key[0], s->key[1], s->key[2],
+                                         s->key[3], s->data_len);
                     s->status = APPLESMC_ST_CMD_DONE;
                     s->status_1e = APPLESMC_ST_CMD_DONE;
                 } else {
@@ -298,6 +307,8 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
             s->data_pos = 0;
             s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
             s->status_1e = APPLESMC_ST_CMD_DONE;
+            trace_applesmc_key_type(s->key[0], s->key[1], s->key[2],
+                                    s->key[3], s->data[4]);
         }
         s->read_pos++;
         break;
@@ -341,9 +352,12 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                 s->data_len = 0;
                 s->status_1e = APPLESMC_ST_1E_BAD_INDEX;
                 s->status = APPLESMC_ST_CMD_DONE;
+                trace_applesmc_key_by_index_end(idx);
                 s->read_pos++;
                 break;
             }
+            trace_applesmc_key_by_index(idx, def->key[0], def->key[1],
+                                        def->key[2], def->key[3]);
             s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
             s->status_1e = APPLESMC_ST_CMD_DONE;
         }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3ef..5b823182c9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -37,6 +37,16 @@ allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%"
 allwinner_sramc_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_sramc_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 
+# applesmc.c
+applesmc_cmd(uint8_t cmd) "cmd 0x%02x"
+applesmc_cmd_bad(uint8_t cmd) "unsupported cmd 0x%02x"
+applesmc_read(char k0, char k1, char k2, char k3, uint8_t len) "READ '%c%c%c%c' len %u"
+applesmc_read_unknown(char k0, char k1, char k2, char k3) "READ unknown key '%c%c%c%c'"
+applesmc_write(char k0, char k1, char k2, char k3, uint8_t len) "WRITE '%c%c%c%c' len %u"
+applesmc_key_type(char k0, char k1, char k2, char k3, uint8_t len) "GET_KEY_TYPE '%c%c%c%c' size %u"
+applesmc_key_by_index(uint32_t idx, char k0, char k1, char k2, char k3) "GET_KEY_BY_INDEX %u -> '%c%c%c%c'"
+applesmc_key_by_index_end(uint32_t idx) "GET_KEY_BY_INDEX %u past end"
+
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
 avr_power_write(uint8_t value) "power_reduc write value:%u"
-- 
2.55.0

