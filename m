Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEAFC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGHo-0001P2-Ht; Wed, 28 Feb 2024 04:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHO-00012e-AA; Wed, 28 Feb 2024 04:31:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHK-0001ey-7R; Wed, 28 Feb 2024 04:31:08 -0500
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tl8Dh33FrzvW7q;
 Wed, 28 Feb 2024 17:28:52 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 4E3F51404F8;
 Wed, 28 Feb 2024 17:31:02 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 17:31:01 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v4 14/22] hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
Date: Wed, 28 Feb 2024 09:29:38 +0000
Message-ID: <20240228092946.1768728-15-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228092946.1768728-1-ruanjinjie@huawei.com>
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add GICR_INMIR0 register and support access GICR_INMIR0.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Make the GICR_INMIR0 implementation more clearer.
---
 hw/intc/arm_gicv3_redist.c | 19 +++++++++++++++++++
 hw/intc/gicv3_internal.h   |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8153525849..7a16a058b1 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -35,6 +35,15 @@ static int gicr_ns_access(GICv3CPUState *cs, int irq)
     return extract32(cs->gicr_nsacr, irq * 2, 2);
 }
 
+static void gicr_write_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
+                                  uint32_t *reg, uint32_t val)
+{
+    /* Helper routine to implement writing to a "set" register */
+    val &= mask_group(cs, attrs);
+    *reg = val;
+    gicv3_redist_update(cs);
+}
+
 static void gicr_write_set_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
                                       uint32_t *reg, uint32_t val)
 {
@@ -406,6 +415,10 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         *data = value;
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        *data = cs->gic->nmi_support ?
+                gicr_read_bitmap_reg(cs, attrs, cs->gicr_isuperprio) : 0;
+        return MEMTX_OK;
     case GICR_ICFGR0:
     case GICR_ICFGR1:
     {
@@ -555,6 +568,12 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         gicv3_redist_update(cs);
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        if (cs->gic->nmi_support) {
+            gicr_write_bitmap_reg(cs, attrs, &cs->gicr_isuperprio, value);
+        }
+        return MEMTX_OK;
+
     case GICR_ICFGR0:
         /* Register is all RAZ/WI or RAO/WI bits */
         return MEMTX_OK;
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 29d5cdc1b6..f35b7d2f03 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -109,6 +109,7 @@
 #define GICR_ICFGR1           (GICR_SGI_OFFSET + 0x0C04)
 #define GICR_IGRPMODR0        (GICR_SGI_OFFSET + 0x0D00)
 #define GICR_NSACR            (GICR_SGI_OFFSET + 0x0E00)
+#define GICR_INMIR0           (GICR_SGI_OFFSET + 0x0F80)
 
 /* VLPI redistributor registers, offsets from VLPI_base */
 #define GICR_VPROPBASER       (GICR_VLPI_OFFSET + 0x70)
-- 
2.34.1


