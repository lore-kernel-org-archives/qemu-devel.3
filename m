Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03A9CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9V-00074P-Sw; Mon, 29 Sep 2025 12:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8S-0003p0-8V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8L-0002xe-92
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFV8yzChiwwaTru2ixwd6NCKrifkFsnekzGPSSMFVv8=;
 b=a4cuMyHwAXyOq83ElFzT7RgzHnSsjLNHOs2KYX6MPkdHvfEmBZacOcmdGeaJmpWQB9e0JH
 OL1oHIvK8cHHeRYzOxf7BL/dFHJcP6HvyNF2/tTZXQacckDEuMOsmd2eDDZx1AOYTAHD4s
 VLSk5S7WRh8nP5aGgtX7he3gvWzSScA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-2aAQz_MFMHqnGivpEkWmkA-1; Mon,
 29 Sep 2025 12:53:46 -0400
X-MC-Unique: 2aAQz_MFMHqnGivpEkWmkA-1
X-Mimecast-MFC-AGG-ID: 2aAQz_MFMHqnGivpEkWmkA_1759164825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D9E19560B5; Mon, 29 Sep 2025 16:53:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 277211800452; Mon, 29 Sep 2025 16:53:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/32] hw/arm/aspeed_ast27x0-fc: Drop dead return checks
Date: Mon, 29 Sep 2025 18:52:29 +0200
Message-ID: <20250929165230.797471-32-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

1. object_property_set_link() can return false only when it fails, and it
sets an error when it fails. Since passing &error_abort causes an abort,
the function never returns false, and the return statement is effectively
dead code.
2. object_property_set_int() is considered as a routine which shouldn't fail.
So the common practice in models is to pass &error_abort and ignore the returned value.
https://patchwork.kernel.org/project/qemu-devel/patch/20250717034054.1903991-3-jamin_lin@aspeedtech.com/#26540626

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 43 +++++++++++++-------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 7087be4288bb..ebf3784df588 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -74,19 +74,12 @@ static void ast2700fc_ca35_init(MachineState *machine)
                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
         return;
     }
-    if (!object_property_set_link(OBJECT(&s->ca35), "memory",
-                                  OBJECT(&s->ca35_memory),
-                                  &error_abort)) {
-        return;
-    };
-    if (!object_property_set_link(OBJECT(&s->ca35), "dram",
-                                  OBJECT(&s->ca35_dram), &error_abort)) {
-        return;
-    }
-    if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
-                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
-        return;
-    }
+    object_property_set_link(OBJECT(&s->ca35), "memory",
+                             OBJECT(&s->ca35_memory), &error_abort);
+    object_property_set_link(OBJECT(&s->ca35), "dram", OBJECT(&s->ca35_dram),
+                             &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "ram-size",
+                            AST2700FC_BMC_RAM_SIZE, &error_abort);
 
     for (int i = 0; i < sc->macs_num; i++) {
         if (!qemu_configure_nic_device(DEVICE(&soc->ftgmac100[i]),
@@ -94,14 +87,10 @@ static void ast2700fc_ca35_init(MachineState *machine)
             break;
         }
     }
-    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
-                                 AST2700FC_HW_STRAP1, &error_abort)) {
-        return;
-    }
-    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
-                                 AST2700FC_HW_STRAP2, &error_abort)) {
-        return;
-    }
+    object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
+                            AST2700FC_HW_STRAP1, &error_abort);
+    object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
+                            AST2700FC_HW_STRAP2, &error_abort);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
         return;
@@ -133,10 +122,8 @@ static void ast2700fc_ssp_init(MachineState *machine)
                        UINT64_MAX);
 
     qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
-    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
-                                  OBJECT(&s->ssp_memory), &error_abort)) {
-        return;
-    }
+    object_property_set_link(OBJECT(&s->ssp), "memory",
+                             OBJECT(&s->ssp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->ssp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
@@ -157,10 +144,8 @@ static void ast2700fc_tsp_init(MachineState *machine)
                        UINT64_MAX);
 
     qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
-    if (!object_property_set_link(OBJECT(&s->tsp), "memory",
-                                  OBJECT(&s->tsp_memory), &error_abort)) {
-        return;
-    }
+    object_property_set_link(OBJECT(&s->tsp), "memory",
+                             OBJECT(&s->tsp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->tsp);
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
-- 
2.51.0


