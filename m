Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E8C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDJ-0006Dv-D6; Thu, 01 Feb 2024 11:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaB6-0002wi-1i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:40 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAv-0002Ut-1X
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=TVv/AOdOYH5a2U0HTHi4RTU6DjGrYfL4+2ys8pUR+jg=; b=hYyP0bZDziJB2oS/CGESKD4WTk
 RwR9kSD9znQ9kBzCwimL9ljPeNsgQVBs4bt3741MJlp6kv/Q0FAXZtr4OaEVXcgJPQmu5ty/YNkuN
 +Gj8sCUnhaEyv/BQ1ja5FE4svojwMl4VB4OSdGkbbDDSHHEXTb98uE/OXNR8E23ibGGti6dUiRBCP
 r7J3t1GcA4obnzhPttU/+ArwQxpWERwOqu4RjsdOQ3x8LekL36G4z6QJPTCcbLTEHB0nCGyNOw8yK
 8VHE8ygZvHYNrETRy43v855H06a2I9JFVt78hBG7ORl5FzuitI4BdsJCgUJ+68d+mD8bmNfMOlK/T
 6ASqmJgg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAh-00000009cME-1xFD for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IOG-2hTV for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/47] hw/mips/jazz: use qemu_find_nic_info()
Date: Thu,  1 Feb 2024 16:44:01 +0000
Message-ID: <20240201164412.785520-37-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/jazz.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0d2348aa5a..5bf3e328db 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -119,15 +119,19 @@ static const MemoryRegionOps dma_dummy_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mips_jazz_init_net(NICInfo *nd, IOMMUMemoryRegion *rc4030_dma_mr,
+static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
                                DeviceState *rc4030, MemoryRegion *dp8393x_prom)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
     int checksum, i;
     uint8_t *prom;
+    NICInfo *nd;
 
-    qemu_check_nic_model(nd, "dp83932");
+    nd = qemu_find_nic_info("dp8393x", true, "dp82932");
+    if (!nd) {
+        return;
+    }
 
     dev = qdev_new("dp8393x");
     qdev_set_nic_properties(dev, nd);
@@ -324,12 +328,7 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* Network controller */
-    if (nb_nics == 1) {
-        mips_jazz_init_net(&nd_table[0], rc4030_dma_mr, rc4030, dp8393x_prom);
-    } else if (nb_nics > 1) {
-        error_report("This machine only supports one NIC");
-        exit(1);
-    }
+    mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom);
 
     /* SCSI adapter */
     dev = qdev_new(TYPE_SYSBUS_ESP);
-- 
2.43.0


