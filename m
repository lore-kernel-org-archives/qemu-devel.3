Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF566D5E36C
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kLv-0006ti-Cb; Sat, 09 Nov 2024 07:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kLl-0005xl-9O; Sat, 09 Nov 2024 07:13:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kLj-0004fm-Ip; Sat, 09 Nov 2024 07:13:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAF2DA161A;
 Sat,  9 Nov 2024 15:07:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 93CAA167FA8;
 Sat,  9 Nov 2024 15:08:04 +0300 (MSK)
Received: (nullmailer pid 3295407 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 50/57] ppc/xive: Fix ESB length overflow on 32-bit hosts
Date: Sat,  9 Nov 2024 15:07:52 +0300
Message-Id: <20241109120801.3295120-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The length of this region can be > 32-bits, which overflows size_t on
32-bit hosts. Change to uint64_t.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit 07f2770503e24889720028ddf9ef54788ddf3b6d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 5789062379..7a86197fc9 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -720,7 +720,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc = &xive->source;
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
     size_t tima_len = 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
@@ -824,7 +824,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc;
-    size_t esb_len;
+    uint64_t esb_len;
 
     assert(xive->fd != -1);
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 057b308ae9..38cb98b0f7 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1238,7 +1238,7 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc = XIVE_SOURCE(dev);
-    size_t esb_len = xive_source_esb_len(xsrc);
+    uint64_t esb_len = xive_source_esb_len(xsrc);
 
     assert(xsrc->xive);
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f120874e0f..00023c0233 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -218,7 +218,7 @@ static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
         xsrc->esb_shift == XIVE_ESB_4K_2PAGE;
 }
 
-static inline size_t xive_source_esb_len(XiveSource *xsrc)
+static inline uint64_t xive_source_esb_len(XiveSource *xsrc)
 {
     return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
 }
-- 
2.39.5


