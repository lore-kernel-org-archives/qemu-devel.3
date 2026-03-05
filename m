Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61EF47CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyF-0000pb-0a; Thu, 05 Mar 2026 12:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxZ-0007uW-M8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxV-0003dA-6K
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVEiLOdGDPNHRwZDNO82s6pqTz6mXa9i/G3X+jt04ng=;
 b=FYlCFBR2DCOx1CAynveqaUWaH/JLeaW7ergP7AXZfUk41i2tyrLaKVGZ09/O900JbqigVX
 5OAKXYyech/kq5mv6h+D4we4FPCQN0IeHT87/9rlucwGOb0gxOrNRHPIMgoQ//e7y0fx78
 Cg5hdCKnhFeyKZoUCHhwbNFHkJJz8Kc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-Uc9tyuarMXOU7xW469-OMw-1; Thu,
 05 Mar 2026 12:57:54 -0500
X-MC-Unique: Uc9tyuarMXOU7xW469-OMw-1
X-Mimecast-MFC-AGG-ID: Uc9tyuarMXOU7xW469-OMw_1772733471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6937518005BD; Thu,  5 Mar 2026 17:57:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E62873003E9E; Thu,  5 Mar 2026 17:57:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/38] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Date: Thu,  5 Mar 2026 18:56:46 +0100
Message-ID: <20260305175711.1119025-14-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 7ca99fb87e44..0b99c7edfbfd 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/core/irq.h"
 
 REG32(DEVICE_CTRL,                  0x00)
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static void dw_i3c_update_irq(DWI3C *s)
+{
+    bool level = !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);
+    qemu_set_irq(s->irq, level);
+}
+
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)
+{
+    /* Only return the status whose corresponding EN bits are set. */
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];
+}
+
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)
+{
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */
+    val &= 0x3fe0;
+    s->regs[R_INTR_STATUS] &= ~val;
+
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)
+{
+    s->regs[R_INTR_STATUS_EN] = val;
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)
+{
+    s->regs[R_INTR_SIGNAL_EN] = val;
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)
+{
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */
+    s->regs[R_INTR_STATUS] = val;
+    dw_i3c_update_irq(s);
+}
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     case R_INTR_FORCE:
         value = 0;
         break;
+    case R_INTR_STATUS:
+        value = dw_i3c_intr_status_r(s);
+        break;
     default:
         value = s->regs[addr];
         break;
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case R_RESET_CTRL:
         break;
+    case R_INTR_STATUS:
+        dw_i3c_intr_status_w(s, val32);
+        break;
+    case R_INTR_STATUS_EN:
+        dw_i3c_intr_status_en_w(s, val32);
+        break;
+    case R_INTR_SIGNAL_EN:
+        dw_i3c_intr_signal_en_w(s, val32);
+        break;
+    case R_INTR_FORCE:
+        dw_i3c_intr_force_w(s, val32);
+        break;
     default:
         s->regs[addr] = val32;
         break;
-- 
2.53.0


