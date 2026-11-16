Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC05606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=x6uQQ/+a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IE-0007qO-Kx; Mon, 16 Nov 2026 15:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Hx-0007Nx-4Q; Mon, 16 Nov 2026 15:26:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Hv-0000Ri-5y; Mon, 16 Nov 2026 15:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=/B3RGNgzJY3FR0UGENEgNI0YcCnK3/XicyQWNPycH5k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x6uQQ/+al6yE8zLBnMs4rYWsug8iGRjjB4OAEoEfPNLiVNP/G0tb8IJO6DlPgfwEI
 gD51/UEkW0RYO+4sl6PCjsMwB596qaYKx3gqfJGK0JgPUtC77poRitmhJdtisufgzZ
 6cCawj7mIYpAAQv09Zk1HPofHtAXRKNQCtbzbPTPBJWoD9V58yfCNN7py+7mUFBi9J
 QvpqBGZYRs9AsmVHJt/t2B2nkC3rx7SPsJluS81X/9gfxYB7rsnCQeANbULhwrhqnL
 6UkFacH//tqtzZzUZwvkKC1S7m5booBhG7LOX0642fjP+xRxz0Yx71N0so6DQaIx0A
 BrT/76qmTJqMQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E5D7D1E71A3;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E0E9A45FBCF;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 91AA6B8E62; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 14/63] hw/pci-host/aspeed_pcie: Fix global MSI setting
 during class initialization
Date: Mon, 16 Nov 2026 23:24:53 +0300
Message-ID: <20261116202554.535325-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

The ASPEED PCIe class may be registered for machines that do not
instantiate a PCIe root complex. Updating the global msi_nonbroken
flag from class_init() therefore affects unrelated machines.

Defer the update to the per-device realize handler, so the flag
changes only when an ASPEED PCIe root complex is actually
instantiated.

Cc: qemu-stable@nongnu.org
Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge")
Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Marcelo Manzo <marcelomanzo@gmail.com>
Tested-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-ID: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 8cc795376e954818dce06cfc640efdea721d6061)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index b46eb74234b..ceb010f2133 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
     g_autofree char *dram_alias_name = NULL;
     g_autofree char *root_bus_name = NULL;
 
+    msi_nonbroken = true;
+
     /* PCI configuration space */
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
     sysbus_init_mmio(sbd, &pex->mmio);
@@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
 
     hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
     device_class_set_props(dc, aspeed_pcie_rc_props);
-
-    msi_nonbroken = true;
 }
 
 /*
-- 
2.47.3


