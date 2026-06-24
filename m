Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078DCCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNom-0003d2-O1; Wed, 24 Jun 2026 09:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNoO-00022V-LR; Wed, 24 Jun 2026 09:38:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNoK-0001DL-Tx; Wed, 24 Jun 2026 09:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307999; bh=tJ4gE78HIFs63Hs5+QVQwFGrGNIdLjjoMVKTIA667Hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZccXV7MfpIc2A38/qtyZMOsfzOoy6BzA9cmaW/Spi84SwnaVhIjqOo/DnFYa3nDat
 TwdZNRLfYuLgRaHOzdhvWlzQbh1/dEBNWkctCu/ElqhOjHjxnro9kQ9Eje5liAQngs
 v+n3i96FpCvvmq65jAqCU5Zcv4X9yHQG+SMHDCZ13WOYbeQEd8AliJOrHr2XM2bXHk
 gxUD5jV/ULd0ZYhNRaE2ArVaGN3JiAuD/IYXeoNxa8G3Z8GkoS9XCZ1beYFfQJQEY8
 fga0YEjgQ3QKm8QQLm3KAKA1IslWoKitXFV8P6VkMwQH32qJOcMZ6mQIyoRLQPqiA3
 nNOz/hfilDCIA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45CB81BA9EC;
 Wed, 24 Jun 2026 16:33:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4E563DEA3B;
 Wed, 24 Jun 2026 16:33:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 058/107] hw/i3c: fix CMD/data FIFO depth reset values
 to match real silicon
Date: Wed, 24 Jun 2026 16:31:03 +0300
Message-ID: <20260624133301.403266-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>

The Linux DW-I3C master driver infers controller queue depths at probe
by reading two status registers that report free queue slots, which at
probe (queues empty) equals the full depth.  It then uses those values
to gate every I3C transfer -- any batch whose word count exceeds the
advertised depth is rejected with -EOPNOTSUPP.

  QUEUE_STATUS_LEVEL        (0x4c) [7:0] -> cmdfifodepth  (cmd slots)
  DATA_BUFFER_STATUS_LEVEL  (0x50) [7:0] -> datafifodepth (32-bit words)

Per the AST2600 datasheet the reset values are 0x10 and 0x40 (16 cmd
slots, 64 words = 256 B).  QEMU was advertising 0x02 and 0x10, making
the kernel believe the controller can only do 64-byte transfers.  The
visible symptom was -EOPNOTSUPP on any I3C transfer whose payload
exceeded 64 B (datafifodepth = 0x10 = 16 words = 64 B).

The underlying FIFOs in QEMU were already allocated at the right size
(fifo32_create takes word counts; the existing defaults give 16 cmd
slots and 64 data words).  Only the advertised reset values were wrong.

Correct the reset values in dw_i3c_resets[], and additionally drive the
advertised depths from the queue-capacity configs in the reset handlers
(as is already done for the device/char table pointers), so a configured
override is reflected in what the guest reads instead of being silently
ignored.  The advertised fields are 8-bit, so the depth saturates at 255
regardless of the wider capacity configs.

With this fix the guest sees datafifodepth=64 words and accepts
transfers up to 256 B.

Fixes: e974c6957576 ("hw/i3c/dw-i3c: Add more reset values")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260604142207.2118098-2-jithu.joseph@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 2d3dc20d9d716729e06093311f678dc739affe5b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index d87d42be89..402c8f1922 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -282,8 +282,8 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_QUEUE_THLD_CTRL]             = 0x01000101,
     [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
     [R_SLV_EVENT_CTRL]              = 0x0000000b,
-    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
-    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
+    [R_QUEUE_STATUS_LEVEL]          = 0x00000010,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000040,
     [R_PRESENT_STATE]               = 0x00000003,
     [R_I3C_VER_ID]                  = 0x3130302a,
     [R_I3C_VER_TYPE]                = 0x6c633033,
@@ -947,6 +947,10 @@ static void dw_i3c_reset(DeviceState *dev)
                      s->cfg.dev_char_table_pointer);
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     s->cfg.cmd_resp_queue_capacity_bytes);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     s->cfg.tx_rx_queue_capacity_bytes);
 
     dw_i3c_cmd_queue_reset(s);
     dw_i3c_resp_queue_reset(s);
@@ -1795,6 +1799,10 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
                      s->cfg.dev_char_table_pointer);
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     s->cfg.cmd_resp_queue_capacity_bytes);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     s->cfg.tx_rx_queue_capacity_bytes);
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
-- 
2.47.3


