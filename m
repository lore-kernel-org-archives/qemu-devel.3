Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6BE83062
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCA4-00051n-Oi; Tue, 03 Feb 2026 03:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9l-0004rh-Rq; Tue, 03 Feb 2026 03:53:10 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9k-0002qU-FB; Tue, 03 Feb 2026 03:53:09 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:34 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:34 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Patrick Venture <venture@google.com>, Hao Wu
 <wuhaotsh@google.com>
Subject: [PATCH v2 11/20] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Date: Tue, 3 Feb 2026 16:52:11 +0800
Message-ID: <20260203085229.1543287-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 9dc71aa3d8..bda8ab5d51 100644
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
2.43.0


