Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D286C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdr-0008CG-BZ; Wed, 19 Aug 2026 08:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzn-0005Uh-H9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:55 -0400
Received: from pidgin.makrotopia.org ([2a07:2ec0:3002::65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzl-0000QC-Pr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 02:41:55 -0400
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wwZzh-000000002Ru-19Ui; Wed, 19 Aug 2026 06:41:49 +0000
Date: Wed, 19 Aug 2026 07:41:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 jack wang <163wangjack@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/misc/applesmc: Implement the get-key-type command
Message-ID: <1a56c5b024ebf2c0c80dda7ac9b106e1b3b87ec4.1787114994.git.daniel@makrotopia.org>
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

macOS probes the type of many keys through the SMC get-key-type command
(0x13), dozens of times during boot. The device did not implement it, so
each probe fell through to the default case and returned kSMCBadCommand.

Implement it. Give each key a four-character SMC type ("ui8 ", "ui16",
"ch8*", "{rev", ...) and answer the command with the standard key
information structure: the one-byte data size, the four-byte type and a
one-byte attributes field (reported as zero, as the device does not model
key attributes). Unknown keys return kSMCKeyNotFound, consistent with a
read of a missing key. macOS tolerates the probe failing, so this is not
a functional fix, but it replies to the queries the guest makes instead
of rejecting them.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 hw/misc/applesmc.c   | 52 ++++++++++++++++++++++++++++++++++++--------
 hw/misc/trace-events |  1 +
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 8d5bf74373..47e7e3f4be 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -104,6 +104,7 @@ static char default_osk[64] = "This is a dummy key. Enter the real key "
 struct AppleSMCData {
     uint8_t len;
     const char *key;
+    const char *type;
     const char *data;
     QLIST_ENTRY(AppleSMCData) node;
 };
@@ -145,6 +146,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     switch (val) {
     case APPLESMC_READ_CMD:
     case APPLESMC_WRITE_CMD:
+    case APPLESMC_GET_KEY_TYPE_CMD:
         /* did last command run through OK? */
         if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
             s->cmd = val;
@@ -299,6 +301,36 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
             }
         }
         break;
+    case APPLESMC_GET_KEY_TYPE_CMD:
+        /* Unlike a read, the guest sends only the 4 key bytes, no length. */
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = APPLESMC_ST_ACK;
+            if (++s->read_pos == 4) {
+                trace_applesmc_key_selected(s->key[0], s->key[1],
+                                            s->key[2], s->key[3]);
+                d = applesmc_find_key(s);
+                if (d != NULL) {
+                    /* key info: 1-byte size, 4-byte type, 1-byte attributes */
+                    s->data[0] = d->len;
+                    memcpy(&s->data[1], d->type, 4);
+                    s->data[5] = 0;
+                    s->data_len = 6;
+                    s->data_pos = 0;
+                    s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
+                    s->status_1e = APPLESMC_ST_CMD_DONE;
+                    trace_applesmc_key_type(s->key[0], s->key[1], s->key[2],
+                                            s->key[3], d->type[0], d->type[1],
+                                            d->type[2], d->type[3], d->len);
+                } else {
+                    trace_applesmc_key_not_found(s->key[0], s->key[1],
+                                                 s->key[2], s->key[3]);
+                    s->status = APPLESMC_ST_CMD_DONE;
+                    s->status_1e = APPLESMC_ST_1E_NOEXIST;
+                }
+            }
+        }
+        break;
     default:
         s->status = APPLESMC_ST_CMD_DONE;
         s->status_1e = APPLESMC_ST_1E_STILL_BAD_CMD;
@@ -318,6 +350,7 @@ static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
 
     switch (s->cmd) {
     case APPLESMC_READ_CMD:
+    case APPLESMC_GET_KEY_TYPE_CMD:
         if (!(s->status & APPLESMC_ST_DATA_READY)) {
             break;
         }
@@ -366,12 +399,13 @@ static uint64_t applesmc_io_err_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 static void applesmc_add_key(AppleSMCState *s, const char *key,
-                             int len, const char *data)
+                             const char *type, int len, const char *data)
 {
     struct AppleSMCData *def;
 
     def = g_new0(struct AppleSMCData, 1);
     def->key = key;
+    def->type = type;
     def->len = len;
     def->data = data;
 
@@ -448,14 +482,14 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
-    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
-    applesmc_add_key(s, "OSK0", 32, s->osk);
-    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\x00");
-    applesmc_add_key(s, "MSSP", 1, "\x00");
-    applesmc_add_key(s, "MSSD", 1, "\x03");
-    applesmc_add_key(s, "NATi", 2, "\x00\x00");
-    applesmc_add_key(s, "OSWD", 2, "\x00\x00");
+    applesmc_add_key(s, "REV ", "{rev", 6, "\x01\x13\x0f\x00\x00\x03");
+    applesmc_add_key(s, "OSK0", "ch8*", 32, s->osk);
+    applesmc_add_key(s, "OSK1", "ch8*", 32, s->osk + 32);
+    applesmc_add_key(s, "NATJ", "ui8 ", 1, "\x00");
+    applesmc_add_key(s, "MSSP", "ui8 ", 1, "\x00");
+    applesmc_add_key(s, "MSSD", "si8 ", 1, "\x03");
+    applesmc_add_key(s, "NATi", "ui16", 2, "\x00\x00");
+    applesmc_add_key(s, "OSWD", "ui16", 2, "\x00\x00");
 
     s->wdt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, applesmc_wdt_expired, s);
 }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index d94a5fba8a..bd79fa45e1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -44,6 +44,7 @@ applesmc_cmd_rejected(uint8_t cmd, uint8_t status_1e) "cmd 0x%02x rejected (stat
 applesmc_data_write(uint8_t cmd, uint8_t pos, uint8_t val) "cmd 0x%02x pos %u data 0x%02x"
 applesmc_key_selected(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c"
 applesmc_key_not_found(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3) "key %c%c%c%c not found"
+applesmc_key_type(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t t0, uint8_t t1, uint8_t t2, uint8_t t3, uint8_t len) "type key %c%c%c%c = %c%c%c%c[%u]"
 applesmc_data_read(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "read key %c%c%c%c [%u] 0x%02x"
 applesmc_write_len(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t len) "write key %c%c%c%c len %u"
 applesmc_write_data(uint8_t c0, uint8_t c1, uint8_t c2, uint8_t c3, uint8_t pos, uint8_t val) "write key %c%c%c%c [%u] 0x%02x"
-- 
2.55.0

