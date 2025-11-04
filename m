Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0A2CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCSR-0000Ka-Jq; Tue, 04 Nov 2025 03:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSO-0000HQ-L2
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSM-0003PI-DQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WHl+0hcLS2vCwWcOCyf46ZiCQpNT73fp1xS0RoIud4=;
 b=ZPTDV3JBwg+6UZd1Wck9bG1eN1J5QOt/UXxeXIBclFT2Cd64CjNA6qDP7IYXJVleHCAOHR
 7BP4kCMJ/LtUElNvxXDEsOn5AKavP5RRv0JfOY3R42x9DNAMVOzgFANzhmc+Jl4+vDiiH7
 JdBH6Ycg9B0bhYYvXly8w/KNHY4dTpg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-8cWgDoN7NgCJb8Z4WlBglQ-1; Tue,
 04 Nov 2025 03:31:54 -0500
X-MC-Unique: 8cWgDoN7NgCJb8Z4WlBglQ-1
X-Mimecast-MFC-AGG-ID: 8cWgDoN7NgCJb8Z4WlBglQ_1762245114
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE4B719560B3; Tue,  4 Nov 2025 08:31:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2270819560A2; Tue,  4 Nov 2025 08:31:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/30] hw/arm/aspeed: Make
 aspeed_machine_class_init_cpus_defaults() globally accessible
Date: Tue,  4 Nov 2025 09:31:16 +0100
Message-ID: <20251104083144.187806-3-clg@redhat.com>
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

The function aspeed_machine_class_init_cpus_defaults() is now made
globally visible so that it can be used by other Aspeed machine C files.

Previously, this function was declared as static, restricting its
visibility to aspeed.c. Since future machine split files will also
need to call this helper to initialize default CPU settings, its
declaration has been moved to the common header aspeed.h and the
static keyword has been removed.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed.h | 10 ++++++++++
 hw/arm/aspeed.c         |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 9d34be68b2b3..712014497e90 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -57,5 +57,15 @@ struct AspeedMachineClass {
     bool vbootrom;
 };
 
+/*
+ * aspeed_machine_class_init_cpus_defaults:
+ * @mc: the #MachineClass to be initialized.
+ *
+ * Initialize the default CPU configuration for an Aspeed machine class.
+ * This function sets the default, minimum, and maximum CPU counts
+ * to match the number of CPUs defined in the associated SoC class,
+ * and copies its list of valid CPU types.
+ */
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc);
 
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 4c92f1e1d953..f23af5bf8c39 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1339,7 +1339,7 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                           "Change the SPI Flash model");
 }
 
-static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
+void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(mc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
-- 
2.51.1


