Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8733710F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCU-0000Bm-5C; Tue, 31 Mar 2026 14:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCS-0000BA-KF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:28 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCR-0001Wy-0a
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB2F360130;
 Tue, 31 Mar 2026 18:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A338C2BCB0;
 Tue, 31 Mar 2026 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983145;
 bh=WXwwiiQA5g98onWOG+Xi7+ximkdweZ5ocFkvgOuFOeg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p6JfauP5n5q3iKSGQfCBj6v3myf6v+J5hnFzZzWYKwLZOT5xm4gT8Z6rPwRQ5mELj
 9QFvHZN0OOuSXGVKDEjYbYKjgtdgqpSDrZtuX4yYXR05ygjjXJQVmqhMSr0ddMAvcE
 PC5KT6oZwswFJTaz1LZjBWjlF6WQKA+fKJoQ+qTzHq+3tcbEuqz4nP2gQU1tcNam2o
 ATHTXyXmDTU3EKFH2DSFKnlxwThrMpdO+UsD8JmKuGSFADxl1h98IgxACONulT2NmB
 GBu82EW/7S1cA7Y/NotL4cYXR0D29ZIEXEfG/KpNwyUR+5BRCCIUKYxo5z+DizkA/t
 1WpjP6pgHV8Uw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/8] hw/pci-host/astro: Fix initial addresses in IOC
Date: Tue, 31 Mar 2026 20:52:13 +0200
Message-ID: <20260331185219.12187-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
References: <20260331185219.12187-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 46d8530538..b3eec4a291 100644
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


