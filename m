Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E181E95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBa-00014Z-9G; Wed, 04 Feb 2026 05:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBO-0000dQ-NL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBK-00042P-Nr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aIFsJq4fxjK2zsLjP9AZqyBXPKDlgKw+hKT0M8eZDA=;
 b=aCWYu/qmUIJaIIoaxoQebYobpp+8/W9Y7dgn/2hfVMQVnMZO4GqDRempCqZVnJcHiR+Imh
 iheu+OJqpYOI5QNmBr7VHfIqVhE+sQyxk+RJUVORmwfp9HaTq4n+fWJq64Vm0VbHVtZNv4
 iu/NHF5ZBzF8oCxOTB2eFS/fwaApCV4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-xb4JpSqiNRaSCCl60rFiyw-1; Wed,
 04 Feb 2026 05:32:17 -0500
X-MC-Unique: xb4JpSqiNRaSCCl60rFiyw-1
X-Mimecast-MFC-AGG-ID: xb4JpSqiNRaSCCl60rFiyw_1770201137
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1CF51800266; Wed,  4 Feb 2026 10:32:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FC0A18003F6; Wed,  4 Feb 2026 10:32:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/45] hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables by
 address
Date: Wed,  4 Feb 2026 11:31:08 +0100
Message-ID: <20260204103136.1795455-18-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Sort the SSP and TSP memmap tables to improve readability and
make the definitions easier to maintain.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 10 +++++-----
 hw/arm/aspeed_ast27x0-tsp.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index cee937b37e9b..e4bcf0fa2ae9 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -23,15 +23,15 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+    [ASPEED_DEV_UART4]     =  0x72C1A000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_INTCIO]    =  0x74C18000,
     [ASPEED_DEV_UART0]     =  0x74C33000,
     [ASPEED_DEV_UART1]     =  0x74C33100,
     [ASPEED_DEV_UART2]     =  0x74C33200,
     [ASPEED_DEV_UART3]     =  0x74C33300,
-    [ASPEED_DEV_UART4]     =  0x72C1A000,
-    [ASPEED_DEV_INTCIO]    =  0x74C18000,
-    [ASPEED_DEV_IPC0]      =  0x72C1C000,
-    [ASPEED_DEV_IPC1]      =  0x74C39000,
     [ASPEED_DEV_UART5]     =  0x74C33400,
     [ASPEED_DEV_UART6]     =  0x74C33500,
     [ASPEED_DEV_UART7]     =  0x74C33600,
@@ -40,7 +40,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_UART10]    =  0x74C33900,
     [ASPEED_DEV_UART11]    =  0x74C33A00,
     [ASPEED_DEV_UART12]    =  0x74C33B00,
-    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+    [ASPEED_DEV_IPC1]      =  0x74C39000,
 };
 
 static const int aspeed_soc_ast27x0ssp_irqmap[] = {
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 9c11c016ca4b..68683a15d8b6 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -23,15 +23,15 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+    [ASPEED_DEV_UART4]     =  0x72C1A000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_INTCIO]    =  0x74C18000,
     [ASPEED_DEV_UART0]     =  0x74C33000,
     [ASPEED_DEV_UART1]     =  0x74C33100,
     [ASPEED_DEV_UART2]     =  0x74C33200,
     [ASPEED_DEV_UART3]     =  0x74C33300,
-    [ASPEED_DEV_UART4]     =  0x72C1A000,
-    [ASPEED_DEV_INTCIO]    =  0x74C18000,
-    [ASPEED_DEV_IPC0]      =  0x72C1C000,
-    [ASPEED_DEV_IPC1]      =  0x74C39000,
     [ASPEED_DEV_UART5]     =  0x74C33400,
     [ASPEED_DEV_UART6]     =  0x74C33500,
     [ASPEED_DEV_UART7]     =  0x74C33600,
@@ -40,7 +40,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_UART10]    =  0x74C33900,
     [ASPEED_DEV_UART11]    =  0x74C33A00,
     [ASPEED_DEV_UART12]    =  0x74C33B00,
-    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+    [ASPEED_DEV_IPC1]      =  0x74C39000,
 };
 
 static const int aspeed_soc_ast27x0tsp_irqmap[] = {
-- 
2.52.0


