Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95711090221
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvq-0005Vy-KF; Thu, 19 Mar 2026 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tJ-0003I4-5g
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:05 -0400
Received: from exmail.andestech.com ([60.248.187.195]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ycliang@andestech.com>)
 id 1w38tF-0001Vu-Vo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:38:04 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bIe9017662;
 Thu, 19 Mar 2026 16:37:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 5/6] net: ftmac100: Add noncached memory support for DMA
 descriptors
Date: Thu, 19 Mar 2026 16:37:12 +0800
Message-ID: <20260319083713.3456894-3-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083713.3456894-1-ycliang@andestech.com>
References: <20260319083713.3456894-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bIe9017662
Received-SPF: pass client-ip=60.248.187.195;
 envelope-from=ycliang@andestech.com; helo=Atcsqr.andestech.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Mar 2026 08:56:52 -0400
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
Reply-to:  Leo Yu-Chi Liang <ycliang@andestech.com>
From:  Leo Yu-Chi Liang via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change TX and RX DMA descriptors from inline arrays embedded in
struct ftmac100_data to dynamically allocated pointers. When
CONFIG_SYS_NONCACHED_MEMORY is enabled, allocate descriptors from
the noncached memory region using noncached_alloc(); otherwise
fall back to memalign().

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/net/ftmac100.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index fa0b3dbb6d1..f7f7db56130 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -30,8 +30,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define FTMAC100_MDIO_TIMEOUT_USEC     10000
 
 struct ftmac100_data {
-	struct ftmac100_txdes txdes[1];
-	struct ftmac100_rxdes rxdes[PKTBUFSRX];
+	struct ftmac100_txdes *txdes;
+	struct ftmac100_rxdes *rxdes;
 	int rx_index;
 	const char *name;
 	struct ftmac100 *ftmac100;
@@ -403,12 +403,35 @@ static int ftmac100_mdio_init(struct udevice *dev)
 	return 0;
 }
 
+static void *ftmac100_alloc_descs(unsigned int num, unsigned int size)
+{
+#ifdef CONFIG_SYS_NONCACHED_MEMORY
+	return (void *)noncached_alloc(num * size,
+				       ARCH_DMA_MINALIGN);
+#else
+	return memalign(ARCH_DMA_MINALIGN, num * size);
+#endif
+}
+
 static int ftmac100_probe(struct udevice *dev)
 {
 	struct ftmac100_data *priv = dev_get_priv(dev);
 	priv->name = dev->name;
 	int ret = 0;
 
+	priv->txdes = ftmac100_alloc_descs(1, sizeof(struct ftmac100_txdes));
+	if (!priv->txdes) {
+		dev_err(dev, "Failed to allocate tx descriptors\n");
+		return -ENOMEM;
+	}
+
+	priv->rxdes = ftmac100_alloc_descs(PKTBUFSRX,
+					   sizeof(struct ftmac100_rxdes));
+	if (!priv->rxdes) {
+		dev_err(dev, "Failed to allocate rx descriptors\n");
+		return -ENOMEM;
+	}
+
 	ret = ftmac100_mdio_init(dev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize mdiobus: %d\n", ret);
-- 
2.34.1


