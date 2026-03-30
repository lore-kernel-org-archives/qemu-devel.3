Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C12E1061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0u-0000o4-0c; Mon, 30 Mar 2026 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0r-0000mj-WD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:10 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0q-0003k8-E2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 66BC360141;
 Mon, 30 Mar 2026 21:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F857C2BCB5;
 Mon, 30 Mar 2026 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905547;
 bh=9KHv+oggX6kZex2cOE1Y3qpglSe7tZsjJxsxtmMZ4wc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YDZcU4p9xyDpNMLTpbifsvFGRQ7ZykXnm4cemk5s+RFuYDHMkKi2pfEVIgCYyyIv5
 n9ha7V/jJ+D3rMLxQ3FA4/D8GJcPt2VajbOuj2Y6Yuf/Afj2tmI7mzn9jIXclLbYqC
 U4goNfyDREwg7bAr/LUlvYFBoj8vNtjmTB5RPHewBpwfGdSWVL7vxV2VKFqsZmpArY
 gd7OrvNIOq9ieTs+SMNASqLb9HJyc2I9PnR7g0DmYVz8rSW042wVs7lp3ZTAYTEISR
 S5kOIS5DiPIOo83xtixoL3PzJzaSIlC+cs23tuBo+wnW98eU4zdjYBgtihpIaxwhRo
 3VE9ylTrBRU+w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/11] hw/pci-host/astro: Fix initial addresses in IOC
Date: Mon, 30 Mar 2026 23:18:51 +0200
Message-ID: <20260330211859.19317-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

F-Extend the LMMIO and IOS distributed addresses.
Use the 44-bit address for the IOS distributed address.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c         | 6 +++---
 include/hw/pci-host/astro.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 6a09dc15e7..87bc98f553 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -804,13 +804,13 @@ static void astro_reset(DeviceState *dev)
      * The LBA BASE/MASK registers control IO -> System routing (in Elroy)
      */
     memset(&s->ioc_ranges, 0, sizeof(s->ioc_ranges));
-    s->ioc_ranges[(0x360 - 0x300) / 8] = LMMIO_DIST_BASE_ADDR | 0x01; /* LMMIO_DIST_BASE (SBA) */
+    s->ioc_ranges[(0x360 - 0x300) / 8] = F_EXTEND(LMMIO_DIST_BASE_ADDR) | 0x01;
     s->ioc_ranges[(0x368 - 0x300) / 8] = 0xfc000000;          /* LMMIO_DIST_MASK */
     s->ioc_ranges[(0x370 - 0x300) / 8] = 0;                   /* LMMIO_DIST_ROUTE */
-    s->ioc_ranges[(0x390 - 0x300) / 8] = IOS_DIST_BASE_ADDR | 0x01; /* IOS_DIST_BASE */
+    s->ioc_ranges[(0x390 - 0x300) / 8] = F_EXTEND(IOS_DIST_BASE_ADDR) | 0x01;
     s->ioc_ranges[(0x398 - 0x300) / 8] = 0xffffff0000;        /* IOS_DIST_MASK    */
     s->ioc_ranges[(0x3a0 - 0x300) / 8] = 0x3400000000000000ULL; /* IOS_DIST_ROUTE */
-    s->ioc_ranges[(0x3c0 - 0x300) / 8] = 0xfffee00000;        /* IOS_DIRECT_BASE  */
+    s->ioc_ranges[(0x3c0 - 0x300) / 8] = IOS_DIST_BASE_ADDR;  /* IOS_DIRECT_BASE  */
     s->ioc_ranges[(0x3c8 - 0x300) / 8] = 0xffffff0000;        /* IOS_DIRECT_MASK  */
     s->ioc_ranges[(0x3d0 - 0x300) / 8] = 0x0;                 /* IOS_DIRECT_ROUTE */
 
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index fce052c9f8..5eb1fa57c1 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -26,8 +26,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ElroyState, ELROY_PCI_HOST_BRIDGE)
 
 #define LMMIO_DIRECT_RANGES     4
 
-#define IOS_DIST_BASE_ADDR      0xfffee00000ULL
-#define IOS_DIST_BASE_SIZE           0x10000ULL
+#define IOS_DIST_BASE_ADDR      0xffffee00000ULL
+#define IOS_DIST_BASE_SIZE            0x10000ULL
 
 #define HF_ENABLE       0x40    /* enable HF mode (default is -1 mode) */
 
-- 
2.53.0


