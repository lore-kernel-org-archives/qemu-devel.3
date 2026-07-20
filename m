Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122BC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrBW-0007kN-Og; Mon, 20 Jul 2026 12:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBV-0007iQ-P7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:41 -0400
Received: from mail-106111.protonmail.ch ([79.135.106.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlrBS-0004Qj-8t
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784566174; x=1784825374;
 bh=0pt1fs68WkyI/yQZxMhQRFpk06sDUCgdAhwL2ZmvHGQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Pe4+PMatk9/EP9s996s2biIuguMUrJdszRUstdlM/FXaBqj1oxqZXxHZrv14H/f+U
 6xlXSyAZVrdw62kfqsDlnTdk3h5/kQmW3rVRdIDjuO1jRgeHdrx4jqOcKYEi5buymN
 FPDJbsAXZejvs1Shg67US9B58614S+TTokPLJ4fTW/v+Qjbj5VYIi2VC9zK0luEAGU
 nv7rkpaJ2r+0gXexx7XQuH2ZEszYetx9BeZejQhZx4Fij4xdCEgLS5UXWo7mNVPt4b
 6TxnYt1qB1HmFF9ZFL/k5Jac32aHpacxcOZy9mmbiyr9D/5wa5RxQIRWdfTUzVM7KT
 tqO7OE6h1v9Yg==
X-Pm-Submission-Id: 4h3mhD4v3Pz2Scsh
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org
Subject: [PATCH v4 1/2] hw/misc/applesmc: implement GET_KEY_BY_INDEX,
 WRITE and TYPE commands
Date: Mon, 20 Jul 2026 09:49:29 -0700
Message-ID: <20260720164930.68383-2-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260720164930.68383-1-matthew@pq.io>
References: <20260719152343.69536-1-matthew@pq.io>
 <20260720164930.68383-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=79.135.106.111; envelope-from=matthew@pq.io;
 helo=mail-106111.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

The applesmc device implements just enough of the Apple SMC PMIO
protocol to satisfy the OSK boot check on older macOS versions. On
modern macOS guests (x86 10.14+, all 15.x), the AppleSMC kext
enumerates the SMC key space at boot via APPLESMC_GET_KEY_BY_INDEX_CMD
(0x12). The current device only acknowledges APPLESMC_READ_CMD (0x10)
at the command port; every other command falls through to the default
arm of the switch and sets ST_1E_BAD_CMD.

The macOS driver interprets the resulting 0x82 reply as "spurious
data" and enters a retry loop that floods the kernel log with
kSMCSpuriousData (0x81) / kSMCKeyNotFound errors at roughly 1800
events per second, pegging kernel_task at ~70% CPU and WindowServer
at ~509% CPU. This reproduces reliably on any recent macOS 15 guest
booted with -device isa-applesmc,osk=<valid-OSK>.

This patch:

  * Accepts APPLESMC_WRITE_CMD, APPLESMC_GET_KEY_BY_INDEX_CMD and
    APPLESMC_GET_KEY_TYPE_CMD at the command port, in addition to the
    existing READ_CMD path.

  * Implements GET_KEY_BY_INDEX by walking s->data_def and returning
    the 4-byte ASCII key name at the requested index; returns
    APPLESMC_ST_1E_BAD_INDEX (0xb8) once the index is past the end of
    the list so the guest stops iterating.

  * Implements GET_KEY_TYPE by looking up the key in s->data_def and
    returning a 6-byte response (type[4] + size[1] + attr[1]),
    matching VirtualSMC's kern_pmio.cpp behaviour.

  * Implements WRITE by accepting the key name, length and payload and
    logging at LOG_UNIMP. macOS writes SMC keys during normal power
    management; silent acceptance avoids BAD_CMD on every write.

  * Replaces the unknown-key NOEXIST (0x84) reply on READ with a
    zeroed payload of the requested length, logged at LOG_UNIMP.
    Early-boot probes hit hundreds of undocumented keys per second;
    NOEXIST triggers retry storms while a zeroed payload satisfies the
    probe semantics without asserting a particular value.

  * Routes the BAD_CMD path through qemu_log_mask(LOG_GUEST_ERROR)
    instead of the smc_debug() printf.

  * Fixes a typo in the MSSD key initialiser ("\0x3" -> "\x03"). The
    original literal was three bytes ('\0', 'x', '3') truncated to one
    ('\0') by the size argument, so MSSD has silently returned 0 since
    introduction; the corrected value matches what a real iMac20,1 SMC
    reports.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/misc/applesmc.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245..2b5ef3c6e0 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties.h"
 #include "ui/console.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
@@ -126,7 +127,14 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     smc_debug("CMD received: 0x%02x\n", (uint8_t)val);
     switch (val) {
     case APPLESMC_READ_CMD:
-        /* did last command run through OK? */
+    case APPLESMC_WRITE_CMD:
+    case APPLESMC_GET_KEY_BY_INDEX_CMD:
+    case APPLESMC_GET_KEY_TYPE_CMD:
+        /*
+         * Accept all standard SMC commands. Pre-existing code only handled
+         * READ_CMD; macOS boots hang if WRITE/TYPE/GET_KEY_BY_INDEX commands
+         * return BAD_CMD during early AppleSMC driver init.
+         */
         if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
             s->cmd = val;
             s->status = APPLESMC_ST_NEW_CMD | APPLESMC_ST_ACK;
@@ -137,7 +145,8 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
         }
         break;
     default:
-        smc_debug("UNEXPECTED CMD 0x%02x\n", (uint8_t)val);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "applesmc: unexpected CMD 0x%02x\n", (uint8_t)val);
         s->status = APPLESMC_ST_NEW_CMD;
         s->status_1e = APPLESMC_ST_1E_BAD_CMD;
     }
@@ -179,17 +188,170 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                 s->data_len = d->len;
                 s->data_pos = 0;
                 s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
-                s->status_1e = APPLESMC_ST_CMD_DONE;  /* clear on valid key */
+                s->status_1e = APPLESMC_ST_CMD_DONE;
             } else {
-                smc_debug("READ_CMD: key '%c%c%c%c' not found!\n",
-                          s->key[0], s->key[1], s->key[2], s->key[3]);
+                /*
+                 * Return zeros for unknown keys instead of NOEXIST. Early
+                 * macOS boot probes many undocumented keys; responding
+                 * NOEXIST triggers retry storms. A zeroed payload satisfies
+                 * the probe without asserting a particular value.
+                 */
+                qemu_log_mask(LOG_UNIMP,
+                              "applesmc: READ unknown key '%c%c%c%c' len=%d\n",
+                              s->key[0], s->key[1], s->key[2], s->key[3],
+                              (uint8_t)val);
+                memset(s->data, 0, APPLESMC_MAX_DATA_LENGTH);
+                s->data_len = (uint8_t)val;
+                s->data_pos = 0;
+                s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
+                s->status_1e = APPLESMC_ST_CMD_DONE;
+            }
+        }
+        s->read_pos++;
+        break;
+    case APPLESMC_WRITE_CMD:
+        /*
+         * Accept writes silently. macOS writes SMC keys during power
+         * management, fan control, etc. Log at LOG_UNIMP for visibility
+         * without treating the write as an error.
+         */
+        if ((s->status & 0x0f) == APPLESMC_ST_CMD_DONE) {
+            break;
+        }
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = APPLESMC_ST_ACK;
+        } else if (s->read_pos == 4) {
+            s->data_len = (uint8_t)val;
+            s->data_pos = 0;
+            s->status = APPLESMC_ST_ACK;
+        } else {
+            if (s->data_pos < s->data_len) {
+                s->data[s->data_pos] = (uint8_t)val;
+                s->data_pos++;
+                if (s->data_pos == s->data_len) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "applesmc: WRITE key '%c%c%c%c' len=%d\n",
+                                  s->key[0], s->key[1], s->key[2], s->key[3],
+                                  s->data_len);
+                    s->status = APPLESMC_ST_CMD_DONE;
+                    s->status_1e = APPLESMC_ST_CMD_DONE;
+                } else {
+                    s->status = APPLESMC_ST_ACK;
+                }
+            }
+        }
+        s->read_pos++;
+        break;
+    case APPLESMC_GET_KEY_TYPE_CMD:
+        /*
+         * Return key type info. Protocol (matches VirtualSMC):
+         * - Receive 4 bytes of key name.
+         * - After the 4th byte, immediately set DATA_READY with response.
+         * - Response is 6 bytes: type[4] + size[1] + attr[1].
+         * Unlike READ_CMD there is no length byte between key name and
+         * response.
+         */
+        if ((s->status & 0x0f) == APPLESMC_ST_CMD_DONE) {
+            break;
+        }
+        if (s->read_pos < 3) {
+            s->key[s->read_pos] = val;
+            s->status = APPLESMC_ST_ACK;
+        } else if (s->read_pos == 3) {
+            /* 4th and final key byte. Unlike READ_CMD which has a 5th byte
+             * for data length, GET_KEY_TYPE responds immediately after the
+             * 4-byte key name (matching VirtualSMC kern_pmio.cpp behavior). */
+            s->key[3] = val;
+            d = applesmc_find_key(s);
+            if (d != NULL) {
+                switch (d->len) {
+                case 1:
+                    s->data[0] = 'u'; s->data[1] = 'i';
+                    s->data[2] = '8'; s->data[3] = ' ';
+                    break;
+                case 2:
+                    s->data[0] = 'u'; s->data[1] = 'i';
+                    s->data[2] = '1'; s->data[3] = '6';
+                    break;
+                case 4:
+                    s->data[0] = 'u'; s->data[1] = 'i';
+                    s->data[2] = '3'; s->data[3] = '2';
+                    break;
+                default:
+                    s->data[0] = 'c'; s->data[1] = 'h';
+                    s->data[2] = '8'; s->data[3] = '*';
+                    break;
+                }
+                s->data[4] = d->len;
+                s->data[5] = 0xD0;
+            } else {
+                qemu_log_mask(LOG_UNIMP,
+                              "applesmc: GET_KEY_TYPE unknown '%c%c%c%c'\n",
+                              s->key[0], s->key[1], s->key[2], s->key[3]);
+                s->data[0] = 'u'; s->data[1] = 'i';
+                s->data[2] = '8'; s->data[3] = ' ';
+                s->data[4] = 1;
+                s->data[5] = 0xD0;
+            }
+            s->data_len = 6;
+            s->data_pos = 0;
+            s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
+            s->status_1e = APPLESMC_ST_CMD_DONE;
+        }
+        s->read_pos++;
+        break;
+    case APPLESMC_GET_KEY_BY_INDEX_CMD:
+        /*
+         * Return key name by index. macOS sends a 4-byte big-endian index
+         * and expects the 4-byte ASCII key name at that position. The
+         * previous implementation returned 4 zero bytes, which macOS
+         * treated as kSMCSpuriousData (0x81) and retried indefinitely,
+         * flooding the kernel log at ~1800 errors/sec. Walk the keys list
+         * to return the actual key name, or APPLESMC_ST_1E_BAD_INDEX
+         * (0xb8) once the index is past the end of the list so the guest
+         * stops iterating.
+         */
+        if ((s->status & 0x0f) == APPLESMC_ST_CMD_DONE) {
+            break;
+        }
+        if (s->read_pos < 3) {
+            s->key[s->read_pos] = val;
+            s->status = APPLESMC_ST_ACK;
+        } else if (s->read_pos == 3) {
+            s->key[3] = val;
+            uint32_t idx = ((uint8_t)s->key[0] << 24)
+                         | ((uint8_t)s->key[1] << 16)
+                         | ((uint8_t)s->key[2] << 8)
+                         |  (uint8_t)s->key[3];
+            struct AppleSMCData *def;
+            uint32_t i = 0;
+            bool found = false;
+            QLIST_FOREACH(def, &s->data_def, node) {
+                if (i == idx) {
+                    memcpy(s->data, def->key, 4);
+                    s->data_len = 4;
+                    s->data_pos = 0;
+                    found = true;
+                    break;
+                }
+                i++;
+            }
+            if (!found) {
+                s->data_len = 0;
+                s->status_1e = APPLESMC_ST_1E_BAD_INDEX;
                 s->status = APPLESMC_ST_CMD_DONE;
-                s->status_1e = APPLESMC_ST_1E_NOEXIST;
+                s->read_pos++;
+                break;
             }
+            s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
+            s->status_1e = APPLESMC_ST_CMD_DONE;
         }
         s->read_pos++;
         break;
     default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "applesmc: unhandled data for cmd 0x%02x\n", s->cmd);
         s->status = APPLESMC_ST_CMD_DONE;
         s->status_1e = APPLESMC_ST_1E_STILL_BAD_CMD;
     }
@@ -330,12 +492,13 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
+
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
     applesmc_add_key(s, "NATJ", 1, "\0");
     applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
+    applesmc_add_key(s, "MSSD", 1, "\x03");
 }
 
 static void applesmc_unrealize(DeviceState *dev)
-- 
2.50.1 (Apple Git-155)


