Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE09E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBd-0001Ir-3q; Wed, 04 Feb 2026 05:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBO-0000dN-LD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBM-00042X-DY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmyp4iT0pCOzkBsWA4evBMPFT15MiEOiU8XJuxzxPl0=;
 b=P/vObjjJBWvCtXfRt/Lpve0h4uP4ru8Ay2BrLd3lxSUcB+UHKhn2lQusEfTY7dyMKXS/8z
 S2tY0N8KJJSFngNPS8QmeqbPiA22vGBpkneoYhSa0X6bPLFkgVxBqvaA9VkmIRIR/jFJYF
 2/gc5e1bqv23D+w5xqt+n8GCWwum/sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-Ezs0JVvmPzazwBcQVu843A-1; Wed,
 04 Feb 2026 05:32:19 -0500
X-MC-Unique: Ezs0JVvmPzazwBcQVu843A-1
X-Mimecast-MFC-AGG-ID: Ezs0JVvmPzazwBcQVu843A_1770201138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B6C18005AD; Wed,  4 Feb 2026 10:32:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F5F518003F6; Wed,  4 Feb 2026 10:32:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/45] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Date: Wed,  4 Feb 2026 11:31:09 +0100
Message-ID: <20260204103136.1795455-19-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Sort the SSP and TSP IRQ map tables to improve readability and make the
definitions easier to maintain.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 4 ++--
 hw/arm/aspeed_ast27x0-tsp.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index e4bcf0fa2ae9..9b12ba67430f 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
 };
 
 static const int aspeed_soc_ast27x0ssp_irqmap[] = {
+    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_UART0]     = 164,
     [ASPEED_DEV_UART1]     = 164,
     [ASPEED_DEV_UART2]     = 164,
     [ASPEED_DEV_UART3]     = 164,
-    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_UART5]     = 164,
     [ASPEED_DEV_UART6]     = 164,
     [ASPEED_DEV_UART7]     = 164,
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
     [ASPEED_DEV_UART10]    = 164,
     [ASPEED_DEV_UART11]    = 164,
     [ASPEED_DEV_UART12]    = 164,
-    [ASPEED_DEV_TIMER1]    = 16,
 };
 
 /* SSPINT 164 */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 68683a15d8b6..e39d1dc17125 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
 };
 
 static const int aspeed_soc_ast27x0tsp_irqmap[] = {
+    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_UART0]     = 164,
     [ASPEED_DEV_UART1]     = 164,
     [ASPEED_DEV_UART2]     = 164,
     [ASPEED_DEV_UART3]     = 164,
-    [ASPEED_DEV_UART4]     = 8,
     [ASPEED_DEV_UART5]     = 164,
     [ASPEED_DEV_UART6]     = 164,
     [ASPEED_DEV_UART7]     = 164,
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] = {
     [ASPEED_DEV_UART10]    = 164,
     [ASPEED_DEV_UART11]    = 164,
     [ASPEED_DEV_UART12]    = 164,
-    [ASPEED_DEV_TIMER1]    = 16,
 };
 
 /* TSPINT 164 */
-- 
2.52.0


