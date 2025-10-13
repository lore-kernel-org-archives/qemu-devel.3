Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F1CCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hw5-0005Nz-HF; Mon, 13 Oct 2025 08:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hvn-000503-26
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvW-0008Dv-6L
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFF38vbJCcqoZ0VZSxZGGvoYn4TrbGzQbFCWQwTPafY=;
 b=bW/xyD+cshS4u+DXB89x3ftvYh/uryic8RCG/wGU7VrwKQW2w2wr4fcKdj3XQa4RCVU7Uz
 oBU+pA5Ej5yLNUrwjKzIeUJBdSEyJ9xsOMQLVa6eJUnMlPrpXBc9jgGlp6SQrLLJuyORcD
 iKm54B41/PGmg4xo3KBLYWPAjoD+3ao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-lfSNv7ogMjSCSs_8G8Yxmw-1; Mon,
 13 Oct 2025 08:45:15 -0400
X-MC-Unique: lfSNv7ogMjSCSs_8G8Yxmw-1
X-Mimecast-MFC-AGG-ID: lfSNv7ogMjSCSs_8G8Yxmw_1760359514
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C41691956095; Mon, 13 Oct 2025 12:45:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27D9A180047F; Mon, 13 Oct 2025 12:45:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/29] hw/arm/aspeed_ast27x0-ssp: Change to use
 Aspeed27x0CoprocessorState
Date: Mon, 13 Oct 2025 14:44:16 +0200
Message-ID: <20251013124421.71977-26-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Refactor the AST27x0 SSP implementation to use the unified
Aspeed27x0CoprocessorState structure shared between SSP and TSP.
Previously, SSP and TSP each defined separate state structures
(Aspeed27x0SSPSoCState and Aspeed27x0TSPSoCState), which contained
identical members and caused unnecessary code duplication.

This change removes Aspeed27x0SSPSoCState and replaces it with
Aspeed27x0CoprocessorState, consolidating shared coprocessor state fields
into a single definition in aspeed_coprocessor.h.

This refactor unifies SSP and TSP under the same coprocessor state type,
improving code maintainability and consistency across Aspeed coprocessor
implementations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h | 4 ++--
 hw/arm/aspeed_ast27x0-fc.c          | 2 +-
 hw/arm/aspeed_ast27x0-ssp.c         | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index f09c2ed267b2..d799726635df 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -41,7 +41,7 @@ struct AspeedCoprocessorClass {
     int uarts_num;
 };
 
-struct Aspeed27x0SSPSoCState {
+struct Aspeed27x0CoprocessorState {
     AspeedCoprocessorState parent;
     AspeedINTCState intc[2];
     UnimplementedDeviceState ipc[2];
@@ -51,7 +51,7 @@ struct Aspeed27x0SSPSoCState {
 };
 
 #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState, ASPEED27X0SSP_SOC)
 
 struct Aspeed27x0TSPSoCState {
     AspeedCoprocessorState parent;
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index b34cd54e4e7f..cd09a2dcf0b9 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -42,7 +42,7 @@ struct Ast2700FCState {
     Clock *tsp_sysclk;
 
     Aspeed27x0SoCState ca35;
-    Aspeed27x0SSPSoCState ssp;
+    Aspeed27x0CoprocessorState ssp;
     Aspeed27x0TSPSoCState tsp;
 
     bool mmio_exec;
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 1ebf06299ebe..f8319c95fd41 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
 
 static void aspeed_soc_ast27x0ssp_init(Object *obj)
 {
-    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
 
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -288,7 +288,7 @@ static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
     {
         .name           = TYPE_ASPEED27X0SSP_SOC,
         .parent         = TYPE_ASPEED_COPROCESSOR,
-        .instance_size  = sizeof(Aspeed27x0SSPSoCState),
+        .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0ssp_init,
         .class_init     = aspeed_soc_ast27x0ssp_class_init,
     },
-- 
2.51.0


