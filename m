Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16329C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTyCF-0000YT-Lm; Wed, 17 Jul 2024 02:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyCD-0000QE-HW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTyCC-00033Z-1l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721197882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9clbyjDOn00YOAzPCTfJCWH3c4J9HrQVmDKgoi/2IAI=;
 b=IZB5EnYs4ToazuXP2QfLOx7pbNXhvL7a8BbGBf77K5AVv/OZQgvtbajAHIwHerh3JfAss5
 VDSRJGO6bM+AA7LA6nxRmtbE/3m47trTb1jfilwuWwIhANLDLhOQeiUlcwjj0jHIff0DfA
 236KZ8f4wy0IlB+hxQBe/8/SFTPquEI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-UWncD72ZOu2GpoMvZZQpMg-1; Wed,
 17 Jul 2024 02:31:09 -0400
X-MC-Unique: UWncD72ZOu2GpoMvZZQpMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D0C19560B0; Wed, 17 Jul 2024 06:31:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DC4F1955F68; Wed, 17 Jul 2024 06:31:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 7/8] aspeed: Introduce a 'hw_strap1' machine attribute
Date: Wed, 17 Jul 2024 08:30:21 +0200
Message-ID: <20240717063022.549849-8-clg@redhat.com>
In-Reply-To: <20240717063022.549849-1-clg@redhat.com>
References: <20240717063022.549849-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

To change default behavior of a machine and boot from eMMC, future
changes will add a machine option to let the user configure the
boot-from-eMMC HW strapping bit. Add a new machine attribute first.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/arm/aspeed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a8f5c14ae535..9939559f6dd0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -46,6 +46,7 @@ struct AspeedMachineState {
     uint32_t uart_chosen;
     char *fmc_model;
     char *spi_model;
+    uint32_t hw_strap1;
 };
 
 /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
@@ -393,7 +394,7 @@ static void aspeed_machine_init(MachineState *machine)
         }
     }
 
-    object_property_set_int(OBJECT(bmc->soc), "hw-strap1", amc->hw_strap1,
+    object_property_set_int(OBJECT(bmc->soc), "hw-strap1", bmc->hw_strap1,
                             &error_abort);
     object_property_set_int(OBJECT(bmc->soc), "hw-strap2", amc->hw_strap2,
                             &error_abort);
@@ -1077,7 +1078,10 @@ static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
 
 static void aspeed_machine_instance_init(Object *obj)
 {
+    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(obj);
+
     ASPEED_MACHINE(obj)->mmio_exec = false;
+    ASPEED_MACHINE(obj)->hw_strap1 = amc->hw_strap1;
 }
 
 static char *aspeed_get_fmc_model(Object *obj, Error **errp)
-- 
2.45.2


