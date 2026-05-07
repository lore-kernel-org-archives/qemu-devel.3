Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8569CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2PP-0000su-LP; Thu, 07 May 2026 13:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wL0Wq-0004AN-5X
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:20:44 -0400
Received: from mail-244107.protonmail.ch ([109.224.244.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wL0Wm-00046S-NX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1778167236; x=1778426436;
 bh=QoT6ZV0zp2yCk/oaO3p5EzNmYDCXteG6Q8NREGInOLI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NteZ6GXvVcD2fAX01t/eyJ3rvh6JcDGTrHsfz+g9Gj+ys0Xfb+MtoE3Asw77xsIDG
 hnS3m97IHIw3HJxMVlIytbKQmMdaZW0g/LuSVDIumrvsAdsWiqo9spw8yaFxPP2qkI
 WJ1GAkudqktVC2JIA5HytSBCNdIuH86I0idyBV/qnq5dg3IvX4BEHEFzHZiWckU4YH
 ckv8tFO5eHNFaQ6oyPuPfJC35qZg2ZSUI7yNSuNzPTkHgmddszQQbKZH9siqgq+VOa
 /QJv8yqyB4aoia1RAqEPW3EkDu57n/mnnHQxY8byLzFay2oO4vHJBY0sc7zsw2pkYN
 x1yCsQO3izChg==
X-Pm-Submission-Id: 4gBGCj2DxZz2Scpx
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/2] hw/misc/applesmc: fix GET_KEY_BY_INDEX to return real
 keys, accept WRITE/TYPE commands
Date: Thu,  7 May 2026 08:20:29 -0700
Message-ID: <20260507152030.48753-2-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507040153.14565-1-matthew@pq.io>
References: <20260507040153.14565-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=109.224.244.107; envelope-from=matthew@pq.io;
 helo=mail-244107.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 May 2026 13:21:05 -0400
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
protocol to satisfy the OSK boot check on older macOS versions.
On modern macOS guests (x86 10.14+, all 15.x), the AppleSMC kext
enumerates the SMC key space at boot via APPLESMC_GET_KEY_BY_INDEX_CMD
(0x12). The current device only acknowledges APPLESMC_READ_CMD
(0x10) at the command port; every other command falls through to
the default arm of the switch and sets ST_1E_BAD_CMD.

The macOS driver interprets the resulting 0x82 reply as
"spurious data" and enters a retry loop that floods the kernel
log with kSMCSpuriousData (0x81) / kSMCKeyNotFound errors at
roughly 1800 events per second, pegging kernel_task at ~70%
CPU and WindowServer at ~509% CPU. This reproduces reliably
on any recent macOS 15 guest booted with -device
isa-applesmc,osk=<valid-OSK>.

This patch:

  * Accepts APPLESMC_WRITE_CMD, APPLESMC_GET_KEY_BY_INDEX_CMD,
    and APPLESMC_GET_KEY_TYPE_CMD at the command port (in
    addition to the existing READ_CMD path).

  * Implements GET_KEY_BY_INDEX by walking s->data_def and
    returning the 4-byte ASCII key name at the requested index;
    returns APPLESMC_ST_1E_BAD_INDEX (0xb8) once the index is
    past the end of the list so the guest stops iterating.

  * Implements GET_KEY_TYPE by looking up the key in s->data_def
    and returning a 6-byte response (type[4] + size[1] + attr[1])
    matching VirtualSMC's kern_pmio.cpp behaviour.

  * Implements WRITE by accepting the key name, length, and
    payload and logging at LOG_UNIMP. macOS writes SMC keys
    during normal power management; silent acceptance avoids
    BAD_CMD on every write.

  * Replaces the unknown-key NOEXIST (0x84) reply on READ with
    a zeroed payload of the requested length, logged at
    LOG_UNIMP. Early-boot probes hit hundreds of undocumented
    keys per second; NOEXIST triggers retry storms while a
    zeroed payload satisfies the probe semantics without
    asserting a particular value.

  * Routes the BAD_CMD path through qemu_log_mask
    (LOG_GUEST_ERROR) instead of the smc_debug printf.

  * Fixes a typo in the MSSD key initialiser ("\0x3" -> "\x03").
    The original literal was three bytes ('\\0', 'x', '3')
    truncated to one ('\\0') by the size argument, so MSSD has
    been silently returning 0 since introduction; the corrected
    value matches what a real iMac20,1 SMC reports.

Reported-by: macOS guests booted with -device isa-applesmc since 10.14.
Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/misc/applesmc.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f..2b5ef3c 100644
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


