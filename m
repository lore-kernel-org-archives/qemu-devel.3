Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D90C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDq-0007RE-CF; Thu, 01 Feb 2024 11:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB2-0002us-Mv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:36 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAt-0002Ry-Tq
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=u6cMnsKwi3z8moyI4Kw4dqIt2PvtJGq8iMY86X2p0ns=; b=ovNQ70sgxrUUBnq+i/DROTGyDi
 +GxbAbreDZI8QeXtBx6dicKXbIaK8YZ3juKxwptsGBsIGpjDmqB241rTJv9tiqN0mQloKZz2keoBm
 ZIOb5zVBaYuyfuCFETD025vuUWBlBnvO4owcnZhOocXC69xXPewxfBk6SS8d6uA1qRWmNM2cYfycF
 NG1zqU0zpitaex5/U809RFJZ3Ov6SoB5aQxeX1Eo3Dp+ia9GJuknsTpezdGK7JlVM+rKeRxGdRYCD
 BvLUhff6P9s6knbIYltmSduAUgNOJ6WE1+NgElTAXULjrLloNoohyiF7von+GIqjBFfNAZudkGegy
 83IpDbzQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdJ-0hOi for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INQ-0nN4 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/47] hw/arm/fsl: use qemu_configure_nic_device()
Date: Thu,  1 Feb 2024 16:43:49 +0000
Message-ID: <20240201164412.785520-25-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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
 hw/arm/fsl-imx25.c  | 2 +-
 hw/arm/fsl-imx6.c   | 2 +-
 hw/arm/fsl-imx6ul.c | 2 +-
 hw/arm/fsl-imx7.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 4a49507ef1..5ed87edfe4 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -171,7 +171,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num,
                              &error_abort);
-    qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
+    qemu_configure_nic_device(DEVICE(&s->fec), true, NULL);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
         return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b7f93d8d9c..85748cb233 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -388,7 +388,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
                              &error_abort);
-    qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
+    qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
     }
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 343bd65d1b..19f443570b 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -473,7 +473,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                  s->phy_num[i], &error_abort);
         object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
                                  FSL_IMX6UL_ETH_NUM_TX_RINGS, &error_abort);
-        qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
+        qemu_configure_nic_device(DEVICE(&s->eth[i]), true, NULL);
         sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 5728109491..9f2ef34555 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -447,7 +447,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                  s->phy_num[i], &error_abort);
         object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
                                  FSL_IMX7_ETH_NUM_TX_RINGS, &error_abort);
-        qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
+        qemu_configure_nic_device(DEVICE(&s->eth[i]), true, NULL);
         sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0, FSL_IMX7_ENETn_ADDR[i]);
-- 
2.43.0


