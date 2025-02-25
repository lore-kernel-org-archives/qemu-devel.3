Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F99EC021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpoJ-00015z-E0; Tue, 25 Feb 2025 02:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmpoE-00013d-Gp; Tue, 25 Feb 2025 02:56:55 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmpoC-0001jo-OS; Tue, 25 Feb 2025 02:56:54 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 25 Feb
 2025 15:56:23 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 25 Feb 2025 15:56:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 4/4] hw/misc/aspeed_hace: Fix boot issue in the Crypto
 Manager Self Test
Date: Tue, 25 Feb 2025 15:56:21 +0800
Message-ID: <20250225075622.305515-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225075622.305515-1-jamin_lin@aspeedtech.com>
References: <20250225075622.305515-1-jamin_lin@aspeedtech.com>
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, it does not support the CRYPT command. Instead, it only sends an
interrupt to notify the firmware that the crypt command has completed.
It is a temporary workaround to resolve the boot issue in the Crypto Manager
Self Test.

Introduce a new "use_crypt_workaround" class attribute and set it to true in
the AST2700 HACE model to enable this workaround by default for AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_hace.h |  1 +
 hw/misc/aspeed_hace.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index d13fd3da07..5d4aa19cfe 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -50,6 +50,7 @@ struct AspeedHACEClass {
     uint32_t dest_mask;
     uint32_t key_mask;
     uint32_t hash_mask;
+    bool raise_crypt_interrupt_workaround;
 };
 
 #endif /* ASPEED_HACE_H */
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 86422cb3be..32a5dbded3 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -59,6 +59,7 @@
 /* Other cmd bits */
 #define  HASH_IRQ_EN                    BIT(9)
 #define  HASH_SG_EN                     BIT(18)
+#define  CRYPT_IRQ_EN                   BIT(12)
 /* Scatter-gather data list */
 #define SG_LIST_LEN_SIZE                4
 #define SG_LIST_LEN_MASK                0x0FFFFFFF
@@ -343,6 +344,15 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
                 qemu_irq_lower(s->irq);
             }
         }
+        if (ahc->raise_crypt_interrupt_workaround) {
+            if (data & CRYPT_IRQ) {
+                data &= ~CRYPT_IRQ;
+
+                if (s->regs[addr] & CRYPT_IRQ) {
+                    qemu_irq_lower(s->irq);
+                }
+            }
+        }
         break;
     case R_HASH_SRC:
         data &= ahc->src_mask;
@@ -388,6 +398,12 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
     case R_CRYPT_CMD:
         qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",
                        __func__);
+        if (ahc->raise_crypt_interrupt_workaround) {
+            s->regs[R_STATUS] |= CRYPT_IRQ;
+            if (data & CRYPT_IRQ_EN) {
+                qemu_irq_raise(s->irq);
+            }
+        }
         break;
     default:
         break;
@@ -563,6 +579,13 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, void *data)
     ahc->dest_mask = 0x7FFFFFF8;
     ahc->key_mask = 0x7FFFFFF8;
     ahc->hash_mask = 0x00147FFF;
+
+    /*
+     * Currently, it does not support the CRYPT command. Instead, it only
+     * sends an interrupt to notify the firmware that the crypt command
+     * has completed. It is a temporary workaround.
+     */
+    ahc->raise_crypt_interrupt_workaround = true;
 }
 
 static const TypeInfo aspeed_ast2700_hace_info = {
-- 
2.34.1


