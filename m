Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45776C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59v-00071D-4l; Tue, 07 Jul 2026 08:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59t-0006uT-2T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59r-0005Ih-9H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4+nTTT8csQUrVkdCM4+/5omZAcEP1KMFzkJpfqvbJM=;
 b=DllzbfNbAPjXDJ73OiQGPwoCQzvMi5YLvy/z2UE7838i7rsKTKn+1ArUAxbzp7gaVxXJ3V
 RF1XwJ0o+ZJCrLFpQRK2eYwvsRvRWIZhbQrjCp8pf8HGDGCGb3aBJKxgd9BeFS+nnwNDh+
 drPhflobuQDZ06C1s5qkCmsfF8n1ZXE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-3R5hALIrMsSWxYKHCLq4Dw-1; Tue,
 07 Jul 2026 08:44:13 -0400
X-MC-Unique: 3R5hALIrMsSWxYKHCLq4Dw-1
X-Mimecast-MFC-AGG-ID: 3R5hALIrMsSWxYKHCLq4Dw_1783428250
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E3C1808964; Tue,  7 Jul 2026 12:44:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E40793692A; Tue,  7 Jul 2026 12:44:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 8/8] hw/arm/aspeed_ast27x0: Add unimplemented OTP controller
 MMIO regions for SSP/TSP
Date: Tue,  7 Jul 2026 14:43:49 +0200
Message-ID: <20260707124349.662198-9-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The AST2700 SSP/TSP firmware accesses OTP MMIO regions that
are not yet implemented in QEMU.

This change adds unimplemented MMIO devices for the OTP and maps them to
their corresponding physical addresses in the SSP/TSP address space.
These stub devices allow QEMU to safely handle firmware
accesses and prevent spurious exceptions, while accurately reflecting
the hardware memory map.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260706052701.1141740-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h | 1 +
 include/hw/arm/aspeed_soc.h         | 1 +
 hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++
 hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++
 4 files changed, 14 insertions(+)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 700cbfb4bb19..ac58a5f424ff 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -49,6 +49,7 @@ struct Aspeed27x0CoprocessorState {
     UnimplementedDeviceState ipc[2];
     UnimplementedDeviceState scuio;
     UnimplementedDeviceState pric[2];
+    UnimplementedDeviceState otp;
 
     ARMv7MState armv7m;
 };
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a0d2432620e0..41dc04e2930f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -297,6 +297,7 @@ enum {
     ASPEED_DEV_IOEXP1_I3C,
     ASPEED_DEV_PRIC0,
     ASPEED_DEV_PRIC1,
+    ASPEED_DEV_OTP,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index e35c0c9a5a56..68a8ab26f7ac 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -29,6 +29,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_IPC0]      =  0x72C1C000,
     [ASPEED_DEV_PRIC1]     =  0x74100000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_OTP]       =  0x74C07000,
     [ASPEED_DEV_INTCIO]    =  0x74C18000,
     [ASPEED_DEV_UART0]     =  0x74C33000,
     [ASPEED_DEV_UART1]     =  0x74C33100,
@@ -147,6 +148,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric1", &a->pric[1],
                             TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "otp", &a->otp,
+                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
@@ -267,6 +270,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
                                   "aspeed.pric1",
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),
+                                  "aspeed.otp",
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);
 }
 
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index fdc279cbf654..b8a4f7c91d60 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -29,6 +29,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_IPC0]      =  0x72C1C000,
     [ASPEED_DEV_PRIC1]     =  0x74100000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_OTP]       =  0x74C07000,
     [ASPEED_DEV_INTCIO]    =  0x74C18000,
     [ASPEED_DEV_UART0]     =  0x74C33000,
     [ASPEED_DEV_UART1]     =  0x74C33100,
@@ -147,6 +148,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "pric1", &a->pric[1],
                             TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "otp", &a->otp,
+                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
@@ -267,6 +270,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),
                                   "aspeed.pric1",
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),
+                                  "aspeed.otp",
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);
 }
 
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
-- 
2.54.0


