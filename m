Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13507C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6DvV-0007ag-Cy; Mon, 14 Sep 2026 17:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vpyr@vpyr.dev>) id 1x6DvS-0007aP-Qk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:09:18 -0400
Received: from mail-106111.protonmail.ch ([79.135.106.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vpyr@vpyr.dev>) id 1x6DvP-0000y4-SY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpyr.dev;
 s=protonmail; t=1789420151; x=1789679351;
 bh=vCIJw2b07F4mY/AUFg485WuxCdC9hdR9WZ0rjWQVYv0=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Ogo235WVNjYfNyaQiqbzylC8qkFkcBJbN2lyAesnbZ6kDNg6omZ6zsrziDgwHhTQs
 V9vcvENKN55GiO0PBXtA4D/rfKTnk6XlSFLcz4NROuJPaf9p7VALM8eZ8JnQBiwmZb
 AQgi1Zt3QsOe12v5Kyi2yOZsM13WXWmA5/cth9rGnzPr2/zlDHx5oVoa+D/BtBgxIZ
 vHcxNOiAaYhxLUk6PvM1WIZk8rDXDmzyN5XjETb3GTNRuvLhXG9bY2J5wkS7vIN4TC
 zQnEd14a6IoZ7TMf2TrSwv50nrDBfRigQYZEamNP5zJG6pzw2T1/5pVkMu90tmmHiF
 /tajN06hBpPyA==
X-Pm-Submission-Id: 4hkHnx0Ypgz1DDs3
From: vpyr <vpyr@vpyr.dev>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	vpyr <vpyr@vpyr.dev>
Subject: [PATCH] i2c-echo: avoid echoes on empty probes
Date: Mon, 14 Sep 2026 18:08:16 -0300
Message-ID: <20260914210816.55476-1-vpyr@vpyr.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=79.135.106.111; envelope-from=vpyr@vpyr.dev;
 helo=mail-106111.protonmail.ch
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=1.499, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The device schedules an asynchronous echo on every FINISH event,
including address-only SMBus Quick probes and reads. This can send
zero-initialized or previously stored data instead of a new message.

Schedule an echo only after a write phase with accepted bytes, and
limit transmission to the accepted message length. Use a separate
transmit cursor and reject writes while an echo is pending so that
intervening input cannot overwrite the queued message.

Validated with four Linux guest cases and sequential model tests
covering intervening probes, reads, writes, short messages, overflow
and delivery in both ASPEED modes.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4457
Signed-off-by: Felipe Junger <vpyr@vpyr.dev>
---
 hw/misc/i2c-echo.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 54d07db6fa..4560150dac 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -32,6 +32,9 @@ typedef struct I2CEchoState {
     QEMUBH *bh;
 
     unsigned int pos;
+    unsigned int len;
+    unsigned int tx_pos;
+    bool receiving;
     uint8_t data[3];
 } I2CEchoState;
 
@@ -48,16 +51,16 @@ static void i2c_echo_bh(void *opaque)
             goto release_bus;
         }
 
-        state->pos++;
+        state->tx_pos = 1;
         state->state = I2C_ECHO_STATE_ACK;
         return;
 
     case I2C_ECHO_STATE_ACK:
-        if (state->pos > 2) {
+        if (state->tx_pos >= state->len) {
             break;
         }
 
-        if (i2c_send_async(state->bus, state->data[state->pos++])) {
+        if (i2c_send_async(state->bus, state->data[state->tx_pos++])) {
             break;
         }
 
@@ -90,9 +93,12 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
         break;
 
     case I2C_FINISH:
+        if (state->receiving && state->pos &&
+            state->state == I2C_ECHO_STATE_IDLE) {
+            state->state = I2C_ECHO_STATE_START_SEND;
+            i2c_bus_master(state->bus, state->bh);
+        }
         state->pos = 0;
-        state->state = I2C_ECHO_STATE_START_SEND;
-        i2c_bus_master(state->bus, state->bh);
 
         trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_FINISH");
         break;
@@ -103,9 +109,11 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
 
     default:
         trace_i2c_echo_event(DEVICE(s)->canonical_path, "UNHANDLED");
+        state->receiving = false;
         return -1;
     }
 
+    state->receiving = event == I2C_START_SEND;
     return 0;
 }
 
@@ -126,11 +134,16 @@ static int i2c_echo_send(I2CSlave *s, uint8_t data)
     I2CEchoState *state = I2C_ECHO(s);
 
     trace_i2c_echo_send(DEVICE(s)->canonical_path, data);
+    if (!state->receiving || state->state != I2C_ECHO_STATE_IDLE) {
+        state->receiving = false;
+        return -1;
+    }
     if (state->pos > 2) {
         return -1;
     }
 
     state->data[state->pos++] = data;
+    state->len = state->pos;
 
     return 0;
 }
-- 
2.55.0


