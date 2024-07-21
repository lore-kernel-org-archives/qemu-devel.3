Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 08:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVRiW-0001Mw-DQ; Sun, 21 Jul 2024 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRiD-0000pj-Rm
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVRiC-0001Qw-HI
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 04:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721549672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBczWv8OU+Ht6azEoj1D6vXUlchhp2XhO4LmUdx+/5Y=;
 b=dSXKMEJQdiZrGwkRl9IlQMAKqErEp3c6qD4wvgtrhI1EpUISRt9xtIGS5+64OCKLUzbZ7G
 ycbFCDC7INPFx6OkqJO7UbBoxK5sjSgSg3s0k7g2fh+1YPNtunOsMQEUsSwlqC6Fsq9qHk
 4Co/YwI9Gg04jMNZ1NvRRFQAmEC/pCs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-iTADQesoNJm-0MeaNuIXKg-1; Sun,
 21 Jul 2024 04:14:26 -0400
X-MC-Unique: iTADQesoNJm-0MeaNuIXKg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C926919560AA; Sun, 21 Jul 2024 08:14:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0163B1955D47; Sun, 21 Jul 2024 08:14:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/15] aspeed: Introduce a 'hw_strap1' machine attribute
Date: Sun, 21 Jul 2024 10:13:54 +0200
Message-ID: <20240721081401.425588-9-clg@redhat.com>
In-Reply-To: <20240721081401.425588-1-clg@redhat.com>
References: <20240721081401.425588-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


