Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB51CF47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyI-0001EI-DL; Thu, 05 Mar 2026 12:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxd-00087Y-I4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxZ-0003dq-Ey
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2W12cIWz9SwPNQLpZTUeZxEZf69KJDpkh29wT9b0gc=;
 b=GB5Ib2NGk9dL16FbZRmPkdzPG106s5K//3uO8QEEr3PhEvdtKEg6sNwClizkG/9n4mEYSH
 EvevXl9+TbL0vdkQzxvSOf5fGb1b7oJZq+rwUBnYXZtnvql3SNMwh3yLlIPE98+Sjg9s0m
 AHO//LpxP8CvaLuR9rzXdD/OdZDe2g4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-u1Qknx6UP6-8AIdJQmPhBA-1; Thu,
 05 Mar 2026 12:58:02 -0500
X-MC-Unique: u1Qknx6UP6-8AIdJQmPhBA-1
X-Mimecast-MFC-AGG-ID: u1Qknx6UP6-8AIdJQmPhBA_1772733480
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E05B195609E; Thu,  5 Mar 2026 17:58:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 125A73003E9E; Thu,  5 Mar 2026 17:57:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Titus Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/38] hw/i3c/dw-i3c: Add ctrl MMIO handling
Date: Thu,  5 Mar 2026 18:56:49 +0100
Message-ID: <20260305175711.1119025-17-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Adds functionality to the CTRL register.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-16-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 832fcf326a95..b6ec0d957936 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static void dw_i3c_cmd_queue_execute(DWI3C *s);
+
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)
 {
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
     return ret;
 }
 
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)
+{
+    /*
+     * If the user is setting I3C_RESUME, the controller was halted.
+     * Try and resume execution and leave the bit cleared.
+     */
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {
+        dw_i3c_cmd_queue_execute(s);
+        val = FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);
+    }
+    /*
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP is
+     * sent.
+     */
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {
+        dw_i3c_end_transfer(s, /*is_i2c=*/true);
+        dw_i3c_end_transfer(s, /*is_i2c=*/false);
+        val = FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);
+        dw_i3c_update_irq(s);
+    }
+    /* Update present state. */
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                     DW_I3C_TRANSFER_STATUS_IDLE);
+
+    s->regs[R_DEVICE_CTRL] = val;
+}
+
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)
 {
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                       "] = 0x%08" PRIx64 "\n",
                       __func__, offset, value);
         break;
+    case R_DEVICE_CTRL:
+        dw_i3c_ctrl_w(s, val32);
+        break;
     case R_RX_TX_DATA_PORT:
         dw_i3c_push_tx(s, val32);
         break;
-- 
2.53.0


