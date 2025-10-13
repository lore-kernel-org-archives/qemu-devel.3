Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F158DCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvv-0005Bg-2m; Mon, 13 Oct 2025 08:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvp-00052N-9g
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvW-0008E5-Hp
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Or6ZwxCzNCRqQiPHosNcpwXZ04PMuqaCvZzLOBokGJ8=;
 b=FK5sOYCCEtDy97vWLTxYQ7r7HGPbVbWS5QtQfQsF8ZEfujW0YNVOytb57SFHFBbLWI6IFI
 Ouq2xJ4fDqktUzmCq6Spk+2I8zl3cmRpNb1Q3MIM39MafzIolXux2EOl9boZqTjKXviEcc
 d9iSpfNOHCwY1i8M6GBYv4oqnaeDlPk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-hjhl3ucfPNWRHP3_WLVZgA-1; Mon,
 13 Oct 2025 08:45:17 -0400
X-MC-Unique: hjhl3ucfPNWRHP3_WLVZgA-1
X-Mimecast-MFC-AGG-ID: hjhl3ucfPNWRHP3_WLVZgA_1760359516
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1566195608A; Mon, 13 Oct 2025 12:45:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E742180047F; Mon, 13 Oct 2025 12:45:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/29] hw/arm/aspeed_ast27x0-tsp: Change to use
 Aspeed27x0CoprocessorState
Date: Mon, 13 Oct 2025 14:44:17 +0200
Message-ID: <20251013124421.71977-27-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Refactor the AST27x0 TSP implementation to use the unified
Aspeed27x0CoprocessorState, matching the prior SSP change and removing the
duplicated Aspeed27x0TSPSoCState.

Key updates:
- Delete Aspeed27x0TSPSoCState and reuse Aspeed27x0CoprocessorState.

Update Ast2700FCState to declare tsp as Aspeed27x0CoprocessorState.
This aligns TSP with SSP on a single coprocessor state type, reducing code
duplication and simplifying maintenance.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-14-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h | 12 ++----------
 hw/arm/aspeed_ast27x0-fc.c          |  2 +-
 hw/arm/aspeed_ast27x0-tsp.c         |  8 ++++----
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d799726635df..110e776c6202 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -53,16 +53,8 @@ struct Aspeed27x0CoprocessorState {
 #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState, ASPEED27X0SSP_SOC)
 
-struct Aspeed27x0TSPSoCState {
-    AspeedCoprocessorState parent;
-    AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
-
-    ARMv7MState armv7m;
-};
-
 #define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
+DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
+                     ASPEED27X0TSP_SOC, TYPE_ASPEED27X0TSP_SOC)
 
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index cd09a2dcf0b9..c2fa8df33ce4 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -43,7 +43,7 @@ struct Ast2700FCState {
 
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
-    Aspeed27x0TSPSoCState tsp;
+    Aspeed27x0CoprocessorState tsp;
 
     bool mmio_exec;
 };
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index b77c5291a6d5..e18c624361e2 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
 
 static void aspeed_soc_ast27x0tsp_init(Object *obj)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
 
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_SOC(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -288,7 +288,7 @@ static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
     {
         .name           = TYPE_ASPEED27X0TSP_SOC,
         .parent         = TYPE_ASPEED_COPROCESSOR,
-        .instance_size  = sizeof(Aspeed27x0TSPSoCState),
+        .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0tsp_init,
         .class_init     = aspeed_soc_ast27x0tsp_class_init,
     },
-- 
2.51.0


