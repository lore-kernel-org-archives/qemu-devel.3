Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBE9D715C7
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 06:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjWZP-0001E3-IJ; Sat, 24 Jan 2026 00:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <orion@orions-MacBook-Air.local>)
 id 1vjUPH-0006ts-Rb
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 22:33:51 -0500
Received: from [115.206.96.218] (helo=orions-MacBook-Air.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <orion@orions-MacBook-Air.local>) id 1vjUPF-0000c0-NL
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 22:33:51 -0500
Received: by orions-MacBook-Air.local (Postfix, from userid 501)
 id BB51747D39A; Sat, 24 Jan 2026 11:33:45 +0800 (CST)
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer
Message-Id: <20260124033346.BB51747D39A@orions-MacBook-Air.local>
Date: Sat, 24 Jan 2026 11:33:45 +0800 (CST)
From: orion@orions-MacBook-Air.local (orion cai)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.206.96.218 (failed)
Received-SPF: none client-ip=115.206.96.218;
 envelope-from=orion@orions-MacBook-Air.local; helo=orions-MacBook-Air.local
X-Spam_score_int: 31
X-Spam_score: 3.1
X-Spam_bar: +++
X-Spam_report: (3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Jan 2026 00:52:24 -0500
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

From d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 2001
From: orion cai <orion@orions-MacBook-Air.local>
Date: Sat, 24 Jan 2026 11:19:17 +0800
Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer

Fix integer overflow vulnerability in rtl8139_write_buffer() that could allow
a malicious guest to bypass DMA bounds checks and write to arbitrary memory
locations.

The vulnerability occurs when:
- RxBufAddr is near UINT_MAX (e.g., 0xFFFF0000)
- size is a moderate value (e.g., 0x20000)
- The addition RxBufAddr + size overflows and wraps to a small value
- This bypasses the bounds check (s->RxBufAddr + size > s->RxBufferSize)

Fix uses subtraction instead of addition for the bounds check and applies
modulo to each term individually before computing the wrapped position to
prevent overflow in all code paths.

Signed-off-by: orionhubble@163.com
---
 hw/net/rtl8139.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 9fd00574d2..41b8407acc 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -745,9 +745,16 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
 {
     PCIDevice *d = PCI_DEVICE(s);
 
-    if (s->RxBufAddr + size > s->RxBufferSize)
+    if (size < 0 || s->RxBufAddr > s->RxBufferSize - (uint32_t)size)
     {
-        int wrapped = MOD2(s->RxBufAddr + size, s->RxBufferSize);
+        /* Calculate wrapped position safely without overflow.
+         * Use modulo on each term to prevent overflow.
+         * RxBufferSize is always a power of 2, so MOD2 is safe. */
+        int wrapped = MOD2((uint32_t)s->RxBufAddr, s->RxBufferSize) +
+                    MOD2((uint32_t)size, s->RxBufferSize);
+        if (wrapped >= s->RxBufferSize) {
+            wrapped -= s->RxBufferSize;
+        }
 
         /* write packet data */
         if (wrapped && !(s->RxBufferSize < 65536 && rtl8139_RxWrap(s)))
-- 
2.50.1 (Apple Git-155)


