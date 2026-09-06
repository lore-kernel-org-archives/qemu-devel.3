Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B2C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GO7-0003Lg-Eq; Sun, 06 Sep 2026 13:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GO5-0003Kv-Kc
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GO4-0008Ui-1t
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQh+8ZfpNozyO1aj2bVk69j3M1F7AU3cPvjZPZrSyGo=;
 b=duJdYE9Ek8NZG8Srq77EPGIBQQuKI/+Crd+G/HOaacaal1SqAFxv+fUNyuAAwzW6kU8Nay
 HVmE67Ql9GXz+TXjo2dhdYNDi1957XXl4mp7ASdp0/N4tccdKbNfHP5nnAHmQiPAwny75J
 R2NFgSCrydE+O07PAZbkHuPfILGyRno=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-6OIVR9puOuSu6cbqptTXRg-1; Sun,
 06 Sep 2026 13:10:32 -0400
X-MC-Unique: 6OIVR9puOuSu6cbqptTXRg-1
X-Mimecast-MFC-AGG-ID: 6OIVR9puOuSu6cbqptTXRg_1788714631
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57E8E195411F; Sun,  6 Sep 2026 17:10:30 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 338C91955F06; Sun,  6 Sep 2026 17:10:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/40] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
Date: Sun,  6 Sep 2026 19:09:42 +0200
Message-ID: <20260906171021.26568-2-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Andrew Jeffery <andrew@codeconstruct.com.au>

Currently, booting Linux on the ast2600-evb machine via -kernel results
in a lot of warnings about failing to apply pinmux configuration when
binding drivers:

    [    7.339307][    T1] Creating 5 MTD partitions on "bmc":
    [    7.340402][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
    [    7.513755][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
    [    7.664219][    T1] 0x000000100000-0x000000a00000 : "kernel"
    [    7.826974][    T1] 0x000000a00000-0x000002a00000 : "rofs"
    [    8.026666][    T1] 0x000002a00000-0x000004000000 : "rwfs"
    [    8.201612][    T1] spi-aspeed-smc 1e630000.spi: error -EPERM: Error applying setting, reverse things back
    [    8.370835][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
    [    8.371131][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
    [    8.371500][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
    [    8.766797][    T1] mdio-aspeed 1e650000.mdio: error -EPERM: Error applying setting, reverse things back
    [    8.906008][    T1] mdio-aspeed 1e650008.mdio: error -EPERM: Error applying setting, reverse things back
    [    9.039240][    T1] mdio-aspeed 1e650010.mdio: error -EPERM: Error applying setting, reverse things back
    [    9.147942][    T1] mdio-aspeed 1e650018.mdio: error -EPERM: Error applying setting, reverse things back

The pinmux configuration fails because the SCU is not unlocked.

Set both SCU protection keys for the AST2600. Further, set them
such that they behave accordance with the read value documented
by the datasheet. The new arrangement now upholds the comment in
hw/arm/aspeed.c regarding passing -kernel on the qemu command-line.

    [    7.568170][    T1] Creating 5 MTD partitions on "bmc":
    [    7.569330][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
    [    7.740372][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
    [    7.883570][    T1] 0x000000100000-0x000000a00000 : "kernel"
    [    8.041004][    T1] 0x000000a00000-0x000002a00000 : "rofs"
    [    8.196824][    T1] 0x000002a00000-0x000004000000 : "rwfs"
    [    8.547037][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
    [    8.547320][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
    [    8.547642][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
    [    9.494235][    T1] ftgmac100 1e660000.ethernet: Read MAC address 52:54:00:12:34:56 from chip
    [    9.531186][    T1] RTL8211E Gigabit Ethernet 1e650000.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650000.mdio-1:00,

Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index ca93c3699d81..1e3db6d03f91 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -821,7 +821,8 @@ static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)
     s->regs[AST2600_SILICON_REV2] = s->silicon_rev;
     s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
     s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
-    s->regs[PROT_KEY] = s->hw_prot_key;
+    s->regs[AST2600_PROT_KEY] = s->hw_prot_key == ASPEED_SCU_PROT_KEY;
+    s->regs[AST2600_PROT_KEY2] = s->hw_prot_key == ASPEED_SCU_PROT_KEY;
 }
 
 static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0


