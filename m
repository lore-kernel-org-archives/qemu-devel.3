Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A04C79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckAt-00065K-27; Mon, 05 Jan 2026 07:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9X-0004kW-Ij
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9K-00088B-NU
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BA3dxywMHeGUNlWZ2F4hoO7u7Gjqb4ptsqFeYGCOu54=;
 b=AYUj6G0MDgr/4/ky8qjuqhRnw8tpGUwbF22+UqmEdyprXRDgRGm1IYLnmXfydA9FGxqyiW
 wHkAtIpu729pCp0Bf9dODv9n7DLOczuHN4rF1zINaHeBRdLkeJYO+Pk6GonZbvZW4GcbVo
 K6ZLHWzuhVC2SDS3gWsJMlie2OSh/QA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-yA46j9crMyWU-GP6cLdWSw-1; Mon,
 05 Jan 2026 07:57:28 -0500
X-MC-Unique: yA46j9crMyWU-GP6cLdWSw-1
X-Mimecast-MFC-AGG-ID: yA46j9crMyWU-GP6cLdWSw_1767617847
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF07E1800365; Mon,  5 Jan 2026 12:57:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8C519560A7; Mon,  5 Jan 2026 12:57:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/36] hw/intc/aspeed: Remove SSP 128 - 138
Date: Mon,  5 Jan 2026 13:56:11 +0100
Message-ID: <20260105125613.622667-35-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The SSP interrupts 128 - 138 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260102090746.1130033-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 13 ++-------
 hw/intc/aspeed_intc.c       | 55 ++-----------------------------------
 2 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 04d37056596a..cee937b37e9b 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -62,7 +62,7 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
 };
 
 /* SSPINT 164 */
-static const int ast2700_ssp132_ssp164_intcmap[] = {
+static const int ast2700_ssp164_intcmap[] = {
     [ASPEED_DEV_UART0]     = 7,
     [ASPEED_DEV_UART1]     = 8,
     [ASPEED_DEV_UART2]     = 9,
@@ -89,21 +89,12 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
     {161, 1, 1, NULL},
     {162, 1, 2, NULL},
     {163, 1, 3, NULL},
-    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
+    {164, 1, 4, ast2700_ssp164_intcmap},
     {165, 1, 5, NULL},
     {166, 1, 6, NULL},
     {167, 1, 7, NULL},
     {168, 1, 8, NULL},
     {169, 1, 9, NULL},
-    {128, 0, 1, NULL},
-    {129, 0, 2, NULL},
-    {130, 0, 3, NULL},
-    {131, 0, 4, NULL},
-    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
-    {133, 0, 6, NULL},
-    {134, 0, 7, NULL},
-    {135, 0, 8, NULL},
-    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index ad95d76543f3..9542df1c952d 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -47,28 +47,6 @@ REG32(GICINT197_STATUS,     0x54)
 /*
  * SSP INTC Registers
  */
-REG32(SSPINT128_EN,             0x2000)
-REG32(SSPINT128_STATUS,         0x2004)
-REG32(SSPINT129_EN,             0x2100)
-REG32(SSPINT129_STATUS,         0x2104)
-REG32(SSPINT130_EN,             0x2200)
-REG32(SSPINT130_STATUS,         0x2204)
-REG32(SSPINT131_EN,             0x2300)
-REG32(SSPINT131_STATUS,         0x2304)
-REG32(SSPINT132_EN,             0x2400)
-REG32(SSPINT132_STATUS,         0x2404)
-REG32(SSPINT133_EN,             0x2500)
-REG32(SSPINT133_STATUS,         0x2504)
-REG32(SSPINT134_EN,             0x2600)
-REG32(SSPINT134_STATUS,         0x2604)
-REG32(SSPINT135_EN,             0x2700)
-REG32(SSPINT135_STATUS,         0x2704)
-REG32(SSPINT136_EN,             0x2800)
-REG32(SSPINT136_STATUS,         0x2804)
-REG32(SSPINT137_EN,             0x2900)
-REG32(SSPINT137_STATUS,         0x2904)
-REG32(SSPINT138_EN,             0x2A00)
-REG32(SSPINT138_STATUS,         0x2A04)
 REG32(SSPINT160_169_EN,         0x2B00)
 REG32(SSPINT160_169_STATUS,     0x2B04)
 
@@ -511,29 +489,9 @@ static void aspeed_ssp_intc_write(void *opaque, hwaddr offset, uint64_t data,
     trace_aspeed_intc_write(name, offset, size, data);
 
     switch (reg) {
-    case R_SSPINT128_EN:
-    case R_SSPINT129_EN:
-    case R_SSPINT130_EN:
-    case R_SSPINT131_EN:
-    case R_SSPINT132_EN:
-    case R_SSPINT133_EN:
-    case R_SSPINT134_EN:
-    case R_SSPINT135_EN:
-    case R_SSPINT136_EN:
     case R_SSPINT160_169_EN:
         aspeed_intc_enable_handler(s, offset, data);
         break;
-    case R_SSPINT128_STATUS:
-    case R_SSPINT129_STATUS:
-    case R_SSPINT130_STATUS:
-    case R_SSPINT131_STATUS:
-    case R_SSPINT132_STATUS:
-    case R_SSPINT133_STATUS:
-    case R_SSPINT134_STATUS:
-    case R_SSPINT135_STATUS:
-    case R_SSPINT136_STATUS:
-        aspeed_intc_status_handler(s, offset, data);
-        break;
     case R_SSPINT160_169_STATUS:
         aspeed_intc_status_handler_multi_outpins(s, offset, data);
         break;
@@ -911,15 +869,6 @@ static const TypeInfo aspeed_2700_intcio_info = {
 
 static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},
-    {1, 10, 1, R_SSPINT128_EN, R_SSPINT128_STATUS},
-    {2, 11, 1, R_SSPINT129_EN, R_SSPINT129_STATUS},
-    {3, 12, 1, R_SSPINT130_EN, R_SSPINT130_STATUS},
-    {4, 13, 1, R_SSPINT131_EN, R_SSPINT131_STATUS},
-    {5, 14, 1, R_SSPINT132_EN, R_SSPINT132_STATUS},
-    {6, 15, 1, R_SSPINT133_EN, R_SSPINT133_STATUS},
-    {7, 16, 1, R_SSPINT134_EN, R_SSPINT134_STATUS},
-    {8, 17, 1, R_SSPINT135_EN, R_SSPINT135_STATUS},
-    {9, 18, 1, R_SSPINT136_EN, R_SSPINT136_STATUS},
 };
 
 static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
@@ -929,8 +878,8 @@ static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "ASPEED 2700 SSP INTC Controller";
     aic->num_lines = 32;
-    aic->num_inpins = 10;
-    aic->num_outpins = 19;
+    aic->num_inpins = 1;
+    aic->num_outpins = 10;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x2B08 >> 2;
     aic->reg_offset = 0x0;
-- 
2.52.0


