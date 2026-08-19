Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F83C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdp-000849-MZ; Wed, 19 Aug 2026 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzY-0005Q6-QT
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:40 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzX-0000Li-8V
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:40 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzS-000000002R6-3ZgM; Wed, 19 Aug 2026 06:41:34 +0000
Date: Wed, 19 Aug 2026 07:41:32 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/misc/applesmc: Implement the write command
Message-ID: <b56bb032dbfd1d188e054f7a457724f63fe7bad8.1787114994.git.daniel@makrotopia.org>
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

The device implemented only the SMC read command (0x10). The write
command (0x11) fell through to the default case and returned
kSMCBadCommand, so every SMC key write a guest performs failed.

A macOS guest writes keys through this command in normal operation: at
boot it writes "NTOK", "MSDW", "QENA" and "HE0N", and retrying those
failed writes delays boot; at shutdown it writes "OSWD". All of them
showed up as a stream of kSMCBadCommand errors.

Accept the write command, collect the key, the declared length and the
payload, and return success. The payload is not interpreted yet, so the
writes are accepted and discarded, which is enough to remove the boot
delay and the shutdown errors; the following patch gives the watchdog
keys meaning.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 39 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 6f9d0a590d..bc44b0f1d8 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -128,6 +128,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     smc_debug("CMD received: 0x%02x\n", (uint8_t)val);
     switch (val) {
     case APPLESMC_READ_CMD:
+    case APPLESMC_WRITE_CMD:
         /* did last command run through OK? */
         if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
             s->cmd = val;
@@ -200,6 +201,44 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
         }
         s->read_pos++;
         break;
+    case APPLESMC_WRITE_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = APPLESMC_ST_ACK;
+            if (s->read_pos == 3) {
+                trace_applesmc_key_selected(s->key[0], s->key[1],
+                                            s->key[2], s->key[3]);
+            }
+            s->read_pos++;
+        } else if (s->read_pos == 4) {
+            s->data_len = val;
+            s->data_pos = 0;
+            s->read_pos++;
+            s->status = APPLESMC_ST_ACK;
+            trace_applesmc_write_len(s->key[0], s->key[1], s->key[2],
+                                     s->key[3], s->data_len);
+            if (s->data_len == 0) {
+                s->status = APPLESMC_ST_CMD_DONE;
+                s->status_1e = APPLESMC_ST_CMD_DONE;
+            }
+        } else {
+            if (s->data_pos < s->data_len) {
+                s->data[s->data_pos] = val;
+                trace_applesmc_write_data(s->key[0], s->key[1], s->key[2],
+                                          s->key[3], s->data_pos, (uint8_t)val);
+                s->data_pos++;
+            }
+            if (s->data_pos >= s->data_len) {
+                trace_applesmc_write_complete(s->key[0], s->key[1],
+                                              s->key[2], s->key[3],
+                                              s->data_len);
+                s->status = APPLESMC_ST_CMD_DONE;
+                s->status_1e = APPLESMC_ST_CMD_DONE;
+            } else {
+                s->status = APPLESMC_ST_ACK;
+            }
+        }
+        break;
     default:
         s->status = APPLESMC_ST_CMD_DONE;
         s->status_1e = APPLESMC_ST_1E_STILL_BAD_CMD;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b924b4398e..fc01cc9b7d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -45,6 +45,9 @@ applesmc_data_write(uint8_t cmd, uint8_t pos, uint8_t val) "cmd 0x%02x pos %u da
 applesmc_key_selected(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c"
 applesmc_key_not_found(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c not found"
 applesmc_data_read(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "read key %c%c%c%c [%u] 0x%02x"
+applesmc_write_len(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t len) "write key %c%c%c%c len %u"
+applesmc_write_data(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "write key %c%c%c%c [%u] 0x%02x"
+applesmc_write_complete(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t len) "write key %c%c%c%c complete (%u bytes)"
 
 # avr_power.c
 avr_power_read(uint8_t value) "power_reduc read value:%u"
-- 
2.55.0

