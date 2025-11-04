Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A48FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCUQ-0002hA-8I; Tue, 04 Nov 2025 03:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTA-0001Bg-8B
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT7-0003b2-QW
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTctBV+Hm2wIlHFFLKRwxqt9V/P4J88g4cqcpG/RzOA=;
 b=X9fHdtHJz7j+T11On+500yXImfnSrGX/WtVwegcOtZYbUui/0DfHMICrtVUa2jSySuGyz1
 voP0/E8nt5RToQDlfkCU+5phUMZP2+0mxGFSODHsf4Tzg4oT8uwMu11TNqmk1E9ajlmG85
 4KviMR71Mus2pwWn9eU7sL8/GVkZ9YM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-69e1BZBIPAig3DGh7On8EA-1; Tue,
 04 Nov 2025 03:32:42 -0500
X-MC-Unique: 69e1BZBIPAig3DGh7On8EA-1
X-Mimecast-MFC-AGG-ID: 69e1BZBIPAig3DGh7On8EA_1762245162
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4E918001D1; Tue,  4 Nov 2025 08:32:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43F5C19560A2; Tue,  4 Nov 2025 08:32:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/30] hw/arm/aspeed: Make
 aspeed_machine_ast2600_class_emmc_init() a common API for eMMC boot setup
Date: Tue,  4 Nov 2025 09:31:37 +0100
Message-ID: <20251104083144.187806-24-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This commit exposes the function aspeed_machine_ast2600_class_emmc_init() as
a common API so that other AST2600-based machine implementations can reuse it
to enable the "boot-emmc" property.

Previously, this function was defined as a static helper within aspeed.c,
limiting its visibility to that file. By making it global and declaring it in
aspeed.h, other machine definition files (e.g., for specific AST2600 boards)
can now easily call this API to register eMMC boot configuration support.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-24-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 10 ++++++++++
 hw/arm/aspeed.c         |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 84620f49ed2d..87dcadab264f 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -101,4 +101,14 @@ void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr);
  */
 I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr);
 
+/*
+ * aspeed_machine_ast2600_class_emmc_init:
+ * @oc: the #ObjectClass to initialize.
+ *
+ * Initialize eMMC-related properties for the AST2600 Aspeed machine class.
+ * This function is typically invoked during class initialization to set up
+ * default configuration or attach eMMC-specific devices for AST2600 platforms.
+ */
+void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 89a463242567..2f385290a419 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -755,7 +755,7 @@ static void aspeed_machine_ast2600_set_boot_from_emmc(Object *obj, bool value,
     }
 }
 
-static void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
+void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc)
 {
     object_class_property_add_bool(oc, "boot-emmc",
                                    aspeed_machine_ast2600_get_boot_from_emmc,
-- 
2.51.1


