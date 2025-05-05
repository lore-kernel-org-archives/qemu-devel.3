Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6468AC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrpj-0001hh-5n; Mon, 05 May 2025 05:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrnC-0007Im-OX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrn9-0006Ih-Ia
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMvixnTeIGRPnX6DPfiITJ+OozTCTJDp1tYcr2ncX7g=;
 b=Zb9qgX3/5M91jemjGI/dxXvymkbOSs8SiFgh11FPTuTdNjRf6oLU+KslTSVrKYUh/YHJTx
 bPUMUZiCvbDq9/+xlTEzlfPwxx80XGn8TPwEZUu4ka7VeM0wIfPraG6DNqIBS1YQ+JanUD
 nqDZjjazXN9n5vFmetgjR6H7xkj6oPg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373--GQyOjMTM8KaNvMSBDEv5Q-1; Mon,
 05 May 2025 05:07:11 -0400
X-MC-Unique: -GQyOjMTM8KaNvMSBDEv5Q-1
X-Mimecast-MFC-AGG-ID: -GQyOjMTM8KaNvMSBDEv5Q_1746436030
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A645E1800446; Mon,  5 May 2025 09:07:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C01AB30001A2; Mon,  5 May 2025 09:07:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/23] hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
Date: Mon,  5 May 2025 11:06:22 +0200
Message-ID: <20250505090635.778785-11-clg@redhat.com>
In-Reply-To: <20250505090635.778785-1-clg@redhat.com>
References: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Introduce a new vbootrom memory region. The region is mapped at address
"0x00000000" and has a size of 128KB, identical to the SRAM region size.
This memory region is intended for loading a vbootrom image file as part of the
boot process.

The vbootrom registered in the SoC's address space using the ASPEED_DEV_VBOOTROM
index.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250424075135.3715128-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 2 ++
 hw/arm/aspeed_ast27x0.c     | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index c1e80c8908b3..4dcb1010dc28 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -59,6 +59,7 @@ struct AspeedSoCState {
     MemoryRegion sram;
     MemoryRegion spi_boot_container;
     MemoryRegion spi_boot;
+    MemoryRegion vbootrom;
     AddressSpace dram_as;
     AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
@@ -169,6 +170,7 @@ struct AspeedSoCClass {
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
 
 enum {
+    ASPEED_DEV_VBOOTROM,
     ASPEED_DEV_SPI_BOOT,
     ASPEED_DEV_IOMEM,
     ASPEED_DEV_UART0,
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2e21c3a98fa0..a289e65e495d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -24,6 +24,7 @@
 #include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
+    [ASPEED_DEV_VBOOTROM]  =  0x00000000,
     [ASPEED_DEV_SRAM]      =  0x10000000,
     [ASPEED_DEV_EHCI1]     =  0x12061000,
     [ASPEED_DEV_EHCI2]     =  0x12063000,
@@ -672,6 +673,14 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM], &s->sram);
 
+    /* VBOOTROM */
+    if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), "aspeed.vbootrom",
+                                0x20000, errp)) {
+        return;
+    }
+    memory_region_add_subregion(s->memory,
+                                sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
-- 
2.49.0


