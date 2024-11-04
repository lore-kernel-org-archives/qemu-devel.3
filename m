Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550FED132A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7u7m-0000rC-9A; Mon, 04 Nov 2024 05:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7S-0000mX-Qa
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7N-0006c9-VR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730715329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZdvH/GfNWMkDbJPcCePcYhrbzcwgt3JfPMq8q8/Fw4=;
 b=VrNlEtaO5asGWdHTMKRJExEUYsqutRvlyfxCBTO7Q/KaTyGmkzqDZC1qko7LiSh/WYxQE5
 m7M5+zsENQoN7PnLLmBPBx6a6Th2G+zm1kQqWB4BJ+ISoiEzderj2jeLJSjN7wD+tyC23a
 Y3BhF4/tfsjuaeDcl/eWW1bft4r6w4o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-YpOLog55PROVv3s6QsUvaQ-1; Mon,
 04 Nov 2024 05:15:26 -0500
X-MC-Unique: YpOLog55PROVv3s6QsUvaQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FD7F1953941; Mon,  4 Nov 2024 10:15:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.67])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4FF91956052; Mon,  4 Nov 2024 10:15:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/10] hw/sd/aspeed_sdhci: Introduce Capabilities Register 2
 for SD slot 0 and 1
Date: Mon,  4 Nov 2024 11:14:59 +0100
Message-ID: <20241104101501.2487001-9-clg@redhat.com>
In-Reply-To: <20241104101501.2487001-1-clg@redhat.com>
References: <20241104101501.2487001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The size of SDHCI capabilities register is 64bits, so introduces new
Capabilities Register 2 for SD slot 0 (0x144) and SD slot1 (0x244).

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
[ clg: Fixed code alignment ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/aspeed_sdhci.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 427e5336a8fb..98d5460905df 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -24,8 +24,10 @@
 #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
 #define ASPEED_SDHCI_BUS             0x08
 #define ASPEED_SDHCI_SDIO_140        0x10
+#define ASPEED_SDHCI_SDIO_144        0x14
 #define ASPEED_SDHCI_SDIO_148        0x18
 #define ASPEED_SDHCI_SDIO_240        0x20
+#define ASPEED_SDHCI_SDIO_244        0x24
 #define ASPEED_SDHCI_SDIO_248        0x28
 #define ASPEED_SDHCI_WP_POL          0xec
 #define ASPEED_SDHCI_CARD_DET        0xf0
@@ -35,21 +37,27 @@
 
 static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    uint32_t val = 0;
+    uint64_t val = 0;
     AspeedSDHCIState *sdhci = opaque;
 
     switch (addr) {
     case ASPEED_SDHCI_SDIO_140:
-        val = (uint32_t)sdhci->slots[0].capareg;
+        val = extract64(sdhci->slots[0].capareg, 0, 32);
+        break;
+    case ASPEED_SDHCI_SDIO_144:
+        val = extract64(sdhci->slots[0].capareg, 32, 32);
         break;
     case ASPEED_SDHCI_SDIO_148:
-        val = (uint32_t)sdhci->slots[0].maxcurr;
+        val = extract64(sdhci->slots[0].maxcurr, 0, 32);
         break;
     case ASPEED_SDHCI_SDIO_240:
-        val = (uint32_t)sdhci->slots[1].capareg;
+        val = extract64(sdhci->slots[1].capareg, 0, 32);
+        break;
+    case ASPEED_SDHCI_SDIO_244:
+        val = extract64(sdhci->slots[1].capareg, 32, 32);
         break;
     case ASPEED_SDHCI_SDIO_248:
-        val = (uint32_t)sdhci->slots[1].maxcurr;
+        val = extract64(sdhci->slots[1].maxcurr, 0, 32);
         break;
     default:
         if (addr < ASPEED_SDHCI_REG_SIZE) {
@@ -61,9 +69,9 @@ static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
         }
     }
 
-    trace_aspeed_sdhci_read(addr, size, (uint64_t) val);
+    trace_aspeed_sdhci_read(addr, size, val);
 
-    return (uint64_t)val;
+    return val;
 }
 
 static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
@@ -79,16 +87,26 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
         sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
         break;
     case ASPEED_SDHCI_SDIO_140:
-        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
+        sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 0, 32, val);
+        break;
+    case ASPEED_SDHCI_SDIO_144:
+        sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 32, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_148:
-        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
+        sdhci->slots[0].maxcurr = deposit64(sdhci->slots[0].maxcurr,
+                                            0, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_240:
-        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
+        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
+                                            0, 32, val);
+        break;
+    case ASPEED_SDHCI_SDIO_244:
+        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
+                                            32, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_248:
-        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
+        sdhci->slots[1].maxcurr = deposit64(sdhci->slots[0].maxcurr,
+                                            0, 32, val);
         break;
     default:
         if (addr < ASPEED_SDHCI_REG_SIZE) {
-- 
2.47.0


