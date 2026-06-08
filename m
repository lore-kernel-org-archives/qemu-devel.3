Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44E0CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSr9-0001Mz-Lx; Mon, 08 Jun 2026 01:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSr2-0001Jr-Jd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSr0-0000Ok-MV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4o4YBPTqaZF9lJc3VWqXAsXMM/8Ov8RoJmuGnAl/CU=;
 b=hDk43XGdy14c2orFTypgrtJMC5VABvzfqtUXZEUVFfUr/yE1z4VG+HZVEpDmj3TBA/lzd9
 MmaD1ob7ngW7Wlz0q/RbmlB62lMsfHsMMmuRwso0ITSYJjBQE6DP6uzCCpkGoPqMs+jUKf
 9v2PUXxupcpdhdWsomGUfq05ArCbTA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-gYWmfbGXN0avUA1pDkzQLQ-1; Mon,
 08 Jun 2026 01:48:52 -0400
X-MC-Unique: gYWmfbGXN0avUA1pDkzQLQ-1
X-Mimecast-MFC-AGG-ID: gYWmfbGXN0avUA1pDkzQLQ_1780897731
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06F07180034C; Mon,  8 Jun 2026 05:48:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88F18765; Mon,  8 Jun 2026 05:48:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/37] hw/adc/aspeed_adc: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:59 +0200
Message-ID: <20260608054826.346488-11-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the legacy type_register_static()/type_init() registration
pattern with the modern DEFINE_TYPES() macro.

Inline 7 standalone TypeInfo variables (aspeed_adc_engine_info,
aspeed_adc_info as abstract base, aspeed_2400_adc_info,
aspeed_2500_adc_info, aspeed_2600_adc_info, aspeed_1030_adc_info,
aspeed_2700_adc_info) directly into the 'aspeed_adc_types[]' array,
removing the need for separate declarations. Note that aspeed_2400 and
aspeed_2500 variants carry only .name and .parent with no class_init.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/adc/aspeed_adc.c | 95 +++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 18b74898e16b..70655800a4d4 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -304,13 +304,6 @@ static void aspeed_adc_engine_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_aspeed_adc_engine;
 }
 
-static const TypeInfo aspeed_adc_engine_info = {
-    .name = TYPE_ASPEED_ADC_ENGINE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedADCEngineState),
-    .class_init = aspeed_adc_engine_class_init,
-};
-
 static void aspeed_adc_instance_init(Object *obj)
 {
     AspeedADCState *s = ASPEED_ADC(obj);
@@ -408,53 +401,45 @@ static void aspeed_2700_adc_class_init(ObjectClass *klass, const void *data)
     aac->nr_engines = 2;
 }
 
-static const TypeInfo aspeed_adc_info = {
-    .name = TYPE_ASPEED_ADC,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_init = aspeed_adc_instance_init,
-    .instance_size = sizeof(AspeedADCState),
-    .class_init = aspeed_adc_class_init,
-    .class_size = sizeof(AspeedADCClass),
-    .abstract   = true,
-};
-
-static const TypeInfo aspeed_2400_adc_info = {
-    .name = TYPE_ASPEED_2400_ADC,
-    .parent = TYPE_ASPEED_ADC,
-};
-
-static const TypeInfo aspeed_2500_adc_info = {
-    .name = TYPE_ASPEED_2500_ADC,
-    .parent = TYPE_ASPEED_ADC,
-};
-
-static const TypeInfo aspeed_2600_adc_info = {
-    .name = TYPE_ASPEED_2600_ADC,
-    .parent = TYPE_ASPEED_ADC,
-    .class_init = aspeed_2600_adc_class_init,
-};
-
-static const TypeInfo aspeed_1030_adc_info = {
-    .name = TYPE_ASPEED_1030_ADC,
-    .parent = TYPE_ASPEED_ADC,
-    .class_init = aspeed_1030_adc_class_init, /* No change since AST2600 */
-};
-
-static const TypeInfo aspeed_2700_adc_info = {
-    .name = TYPE_ASPEED_2700_ADC,
-    .parent = TYPE_ASPEED_ADC,
-    .class_init = aspeed_2700_adc_class_init,
+static const TypeInfo aspeed_adc_types[] = {
+    {
+        .name = TYPE_ASPEED_ADC_ENGINE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedADCEngineState),
+        .class_init = aspeed_adc_engine_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_ADC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_init = aspeed_adc_instance_init,
+        .instance_size = sizeof(AspeedADCState),
+        .class_init = aspeed_adc_class_init,
+        .class_size = sizeof(AspeedADCClass),
+        .abstract   = true,
+    },
+    {
+        .name = TYPE_ASPEED_1030_ADC,
+        .parent = TYPE_ASPEED_ADC,
+        .class_init = aspeed_1030_adc_class_init, /* No change since AST2600 */
+    },
+    {
+        .name = TYPE_ASPEED_2400_ADC,
+        .parent = TYPE_ASPEED_ADC,
+    },
+    {
+        .name = TYPE_ASPEED_2500_ADC,
+        .parent = TYPE_ASPEED_ADC,
+    },
+    {
+        .name = TYPE_ASPEED_2600_ADC,
+        .parent = TYPE_ASPEED_ADC,
+        .class_init = aspeed_2600_adc_class_init,
+    },
+    {
+        .name = TYPE_ASPEED_2700_ADC,
+        .parent = TYPE_ASPEED_ADC,
+        .class_init = aspeed_2700_adc_class_init,
+    }
 };
 
-static void aspeed_adc_register_types(void)
-{
-    type_register_static(&aspeed_adc_engine_info);
-    type_register_static(&aspeed_adc_info);
-    type_register_static(&aspeed_2400_adc_info);
-    type_register_static(&aspeed_2500_adc_info);
-    type_register_static(&aspeed_2600_adc_info);
-    type_register_static(&aspeed_1030_adc_info);
-    type_register_static(&aspeed_2700_adc_info);
-}
-
-type_init(aspeed_adc_register_types);
+DEFINE_TYPES(aspeed_adc_types)
-- 
2.54.0


