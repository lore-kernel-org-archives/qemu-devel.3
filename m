Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB09C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TL-0004ho-1Z; Wed, 17 Jul 2024 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SP-0000be-Ma
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SN-0006zq-Dw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:25 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 40836379637; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 16/26] hw/display/apple-gfx: Asynchronous MMIO writes on x86-64
Date: Mon, 15 Jul 2024 23:06:55 +0200
Message-Id: <20240715210705.32365-17-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

This change ensures that the MMIO write calls into the PVG
framework are performed asynchronously on a background dispatch
queue. Without this, we rapidly run into re-entrant MMIO issues.

This problem only seems to exist on x86-64 hosts. Conversely,
doing it async on arm64/vmapple causes other issues, so we're
left with 2 different implementations.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 806feb58fa..48463e5a1f 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -67,15 +67,28 @@ static uint64_t apple_gfx_read(void *opaque, hwaddr offset, unsigned size)
     return res;
 }
 
-static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val,
+                            unsigned size)
 {
     AppleGFXState *s = opaque;
 
     trace_apple_gfx_write(offset, val);
 
+#ifdef __x86_64__
+    id<PGDevice> dev = s->pgdev;
+    dispatch_queue_t bg_queue = NULL;
+
+    bg_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
+    [dev retain];
+    dispatch_async(bg_queue, ^{
+        [dev mmioWriteAtOffset:offset value:val];
+        [dev release];
+    });
+#else
     bql_unlock();
     [s->pgdev mmioWriteAtOffset:offset value:val];
     bql_lock();
+#endif
 }
 
 static const MemoryRegionOps apple_gfx_ops = {
-- 
2.39.3 (Apple Git-146)


