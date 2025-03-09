Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91EEC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH6d-0005MA-Rv; Sun, 09 Mar 2025 09:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5o-0002b6-LN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5m-0003yq-Gc
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XFVMEsDVvAnz0URmuQOT1tjq0N2mPD0Z70hirP5P5Q=;
 b=M+UsKIXuU8cyeJRjAE9TTNXqeqyso+rXaEQewItpnUn8bPHNYh2Tj4yZiW3dV4/LjmgdBi
 nM4cy4aTBgtcNYjtGmAxXB7iSdhpHIzj1ESuTWD2awPzmEzDKDN3SJ5GBOmYEXJu0SUPz6
 KEtdbWrlD4BlfmKok3i5goz+HQ5uXJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-gtQ2Ok0OOoiJ8BTW5gGFvw-1; Sun,
 09 Mar 2025 09:53:18 -0400
X-MC-Unique: gtQ2Ok0OOoiJ8BTW5gGFvw-1
X-Mimecast-MFC-AGG-ID: gtQ2Ok0OOoiJ8BTW5gGFvw_1741528397
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67E40180035C; Sun,  9 Mar 2025 13:53:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBC6C1956094; Sun,  9 Mar 2025 13:53:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 41/46] hw/arm/aspeed_ast27x0: Sort the memmap table by mapping
 address
Date: Sun,  9 Mar 2025 14:51:25 +0100
Message-ID: <20250309135130.545764-42-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

To improve readability, sort the memmap table by mapping address

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-25-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 682ab9bf8a38..dce7255a2c0d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -24,16 +24,40 @@
 #include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
-    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SRAM]      =  0x10000000,
+    [ASPEED_DEV_HACE]      =  0x12070000,
+    [ASPEED_DEV_EMMC]      =  0x12090000,
+    [ASPEED_DEV_INTC]      =  0x12100000,
+    [ASPEED_GIC_DIST]      =  0x12200000,
+    [ASPEED_GIC_REDIST]    =  0x12280000,
     [ASPEED_DEV_SDMC]      =  0x12C00000,
     [ASPEED_DEV_SCU]       =  0x12C02000,
+    [ASPEED_DEV_RTC]       =  0x12C0F000,
+    [ASPEED_DEV_TIMER1]    =  0x12C10000,
+    [ASPEED_DEV_SLI]       =  0x12C17000,
+    [ASPEED_DEV_UART4]     =  0X12C1A000,
+    [ASPEED_DEV_FMC]       =  0x14000000,
+    [ASPEED_DEV_SPI0]      =  0x14010000,
+    [ASPEED_DEV_SPI1]      =  0x14020000,
+    [ASPEED_DEV_SPI2]      =  0x14030000,
+    [ASPEED_DEV_MII1]      =  0x14040000,
+    [ASPEED_DEV_MII2]      =  0x14040008,
+    [ASPEED_DEV_MII3]      =  0x14040010,
+    [ASPEED_DEV_ETH1]      =  0x14050000,
+    [ASPEED_DEV_ETH2]      =  0x14060000,
+    [ASPEED_DEV_ETH3]      =  0x14070000,
+    [ASPEED_DEV_SDHCI]     =  0x14080000,
+    [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
+    [ASPEED_DEV_GPIO]      =  0x14C0B000,
+    [ASPEED_DEV_I2C]       =  0x14C0F000,
+    [ASPEED_DEV_INTCIO]    =  0x14C18000,
+    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
+    [ASPEED_DEV_VUART]     =  0X14C30000,
     [ASPEED_DEV_UART0]     =  0X14C33000,
     [ASPEED_DEV_UART1]     =  0X14C33100,
     [ASPEED_DEV_UART2]     =  0X14C33200,
     [ASPEED_DEV_UART3]     =  0X14C33300,
-    [ASPEED_DEV_UART4]     =  0X12C1A000,
     [ASPEED_DEV_UART5]     =  0X14C33400,
     [ASPEED_DEV_UART6]     =  0X14C33500,
     [ASPEED_DEV_UART7]     =  0X14C33600,
@@ -43,32 +67,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART11]    =  0X14C33A00,
     [ASPEED_DEV_UART12]    =  0X14C33B00,
     [ASPEED_DEV_WDT]       =  0x14C37000,
-    [ASPEED_DEV_VUART]     =  0X14C30000,
-    [ASPEED_DEV_FMC]       =  0x14000000,
-    [ASPEED_DEV_SPI0]      =  0x14010000,
-    [ASPEED_DEV_SPI1]      =  0x14020000,
-    [ASPEED_DEV_SPI2]      =  0x14030000,
+    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
-    [ASPEED_DEV_MII1]      =  0x14040000,
-    [ASPEED_DEV_MII2]      =  0x14040008,
-    [ASPEED_DEV_MII3]      =  0x14040010,
-    [ASPEED_DEV_ETH1]      =  0x14050000,
-    [ASPEED_DEV_ETH2]      =  0x14060000,
-    [ASPEED_DEV_ETH3]      =  0x14070000,
-    [ASPEED_DEV_EMMC]      =  0x12090000,
-    [ASPEED_DEV_INTC]      =  0x12100000,
-    [ASPEED_DEV_INTCIO]    =  0x14C18000,
-    [ASPEED_DEV_SLI]       =  0x12C17000,
-    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
-    [ASPEED_GIC_DIST]      =  0x12200000,
-    [ASPEED_GIC_REDIST]    =  0x12280000,
-    [ASPEED_DEV_ADC]       =  0x14C00000,
-    [ASPEED_DEV_I2C]       =  0x14C0F000,
-    [ASPEED_DEV_GPIO]      =  0x14C0B000,
-    [ASPEED_DEV_RTC]       =  0x12C0F000,
-    [ASPEED_DEV_SDHCI]     =  0x14080000,
-    [ASPEED_DEV_TIMER1]    =  0x12C10000,
-    [ASPEED_DEV_HACE]      =  0x12070000,
 };
 
 #define AST2700_MAX_IRQ 256
-- 
2.48.1


