Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A011FCCA46F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9A-0005xT-Gb; Mon, 29 Sep 2025 12:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H80-00038i-AN
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7v-0002sF-Jz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tU65x/pMgXbaDsPgkCXEeRX4++z2QbVo+jvUR3wp6JU=;
 b=NbR8Umx8PB19QtDm6IB8Gc2hfPcrxbuO1cVfKtXVSC3ywV1Vsri1rnWJ954VtwfXmQ/n+D
 VOuh7O9P0bDpLu6mu+AXE8zAupop/GmXdVq2OdoBVK6yPccjpWn0B1gPVuAPpXnQlV8fTx
 871nqqQk97u0nbN5474Zl5+xLmj4dwk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-gpoJQmRfNoSTj8CLKy6iRw-1; Mon,
 29 Sep 2025 12:53:22 -0400
X-MC-Unique: gpoJQmRfNoSTj8CLKy6iRw-1
X-Mimecast-MFC-AGG-ID: gpoJQmRfNoSTj8CLKy6iRw_1759164801
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B45D18004D8; Mon, 29 Sep 2025 16:53:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 020B81800577; Mon, 29 Sep 2025 16:53:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/32] hw/arm/aspeed: Wire up PCIe devices in SoC model
Date: Mon, 29 Sep 2025 18:52:18 +0200
Message-ID: <20250929165230.797471-21-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add PCIe controller and PHY instances to the Aspeed SoC state and device
enum. This prepares the SoC model to host PCIe Root Complexes and their
associated PHYs.

Although the AST2600 supports only a single Root Complex, the AST2700
provides three Root Complexes. For this reason, the model defines arrays
of three PCIe config/PHY objects and enumerates three PCIe device IDs so
that both SoCs can be represented consistently.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 217ef0eafd6c..79fe353f83b0 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -37,6 +37,7 @@
 #include "qom/object.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/unimp.h"
+#include "hw/pci-host/aspeed_pcie.h"
 #include "hw/misc/aspeed_peci.h"
 #include "hw/fsi/aspeed_apb2opb.h"
 #include "hw/char/serial-mm.h"
@@ -49,6 +50,7 @@
 #define ASPEED_MACS_NUM  4
 #define ASPEED_UARTS_NUM 13
 #define ASPEED_JTAG_NUM  2
+#define ASPEED_PCIE_NUM  3
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -87,6 +89,8 @@ struct AspeedSoCState {
     AspeedSDHCIState sdhci;
     AspeedSDHCIState emmc;
     AspeedLPCState lpc;
+    AspeedPCIECfgState pcie[ASPEED_PCIE_NUM];
+    AspeedPCIEPhyState pcie_phy[ASPEED_PCIE_NUM];
     AspeedPECIState peci;
     SerialMM uart[ASPEED_UARTS_NUM];
     Clock *sysclk;
@@ -254,6 +258,15 @@ enum {
     ASPEED_DEV_LPC,
     ASPEED_DEV_IBT,
     ASPEED_DEV_I2C,
+    ASPEED_DEV_PCIE0,
+    ASPEED_DEV_PCIE1,
+    ASPEED_DEV_PCIE2,
+    ASPEED_DEV_PCIE_PHY0,
+    ASPEED_DEV_PCIE_PHY1,
+    ASPEED_DEV_PCIE_PHY2,
+    ASPEED_DEV_PCIE_MMIO0,
+    ASPEED_DEV_PCIE_MMIO1,
+    ASPEED_DEV_PCIE_MMIO2,
     ASPEED_DEV_PECI,
     ASPEED_DEV_ETH1,
     ASPEED_DEV_ETH2,
-- 
2.51.0


