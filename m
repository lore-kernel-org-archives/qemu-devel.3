Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB7ACD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsN-0002x2-IC; Mon, 08 Jun 2026 01:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrs-0001w6-J3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrq-0000lc-DB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/5HFTRLDPkHsIdT2BYat17qb86KTE+d98kCJwLRRjE=;
 b=XmIXcMzcNDCh4h6fU8AJGpoGyWcMiEcZiNv6CaO+KpYPfAWrvoJDqtGg1+pVEcxTEP295F
 IB+7doP0qStRjrL2IXyeZUko2zkoW71CYwqpjjemIqU3U9C0rZm2Ib8ed+Pryms458L4nI
 Hb3hz+d9U81Tc1l4vQ9BvFsgaFIA5VY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-1jSkFZF5Ms2-5CMle0vByA-1; Mon,
 08 Jun 2026 01:49:42 -0400
X-MC-Unique: 1jSkFZF5Ms2-5CMle0vByA-1
X-Mimecast-MFC-AGG-ID: 1jSkFZF5Ms2-5CMle0vByA_1780897781
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06CE5195608A; Mon,  8 Jun 2026 05:49:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EDCB27A; Mon,  8 Jun 2026 05:49:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, qemu-stable@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/37] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
Date: Mon,  8 Jun 2026 07:48:24 +0200
Message-ID: <20260608054826.346488-36-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
---
 hw/i3c/dw-i3c.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 17ff484c5df1..06c2d55f5958 100644
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
@@ -1793,6 +1797,10 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
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
2.54.0


