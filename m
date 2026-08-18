Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E741C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 01:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww8sM-0000FF-Hv; Mon, 17 Aug 2026 21:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1ww8sF-0000EM-U3; Mon, 17 Aug 2026 21:44:21 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1ww8sD-0003pR-HD; Mon, 17 Aug 2026 21:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1787017446;
 bh=8dxXqQ6I72A+75xFqd5jLysNahv3qlFu/aiRTg8/g1I=;
 h=From:Date:Subject:To:Cc;
 b=T1Yt6K8dVeXbgnm1ZUYU4XHPrERrWbIympkRo4uF80eWeRKV58aPB9GIjBt3aF35F
 1h4IOY/qHAgBhHSh5kvH4hGztB5wmhZedk0lS3wV+cVPxKxG6NoXiAzOHyH8p/yu7e
 yxAIqAX9iYGH7iZM+ToLoQYt6lZHnAJrwZTKerQMEg6rOFLtxP+DTIvW58u0RCHbG9
 NGP43Z/DD2G/QGr+bh1I4D6oDei3jYB5qlMOGIdb0cl04RSwoGNiiX2/hdvqDYWbeI
 P9gVQD4gq38tT3J75u8HImel47sjt5Nl+d+JjnSVLJYXaFf8IdWLEEjBz4TkS+SwPE
 Hi9oS35cpw4eA==
Received: from [127.0.1.1] (unknown [180.150.113.112])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 75BD9608C3;
 Tue, 18 Aug 2026 09:44:03 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 18 Aug 2026 11:13:42 +0930
Subject: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAM24g2oC/yXMTQ6CQAwG0KuQrm0yEENmvIpxwc8HFBIg7Ygaw
 t0dZfk2byeDCoxu2U6KTUyWOSG/ZNQM1dyDpU2mwhWl87nnFhtXFpMcDy9edYk84cMKQ2SUHnX
 orgEIlI5V0cn7/98fp+1Zj2jiL6Xj+AKeP8MtgQAAAA==
X-Change-ID: 20260818-dev-ast2600-hw-prot-key-reset-e68eb9f49ee9
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
I ran into this issue while improving test coverage in my patch review
process.
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

---
base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
change-id: 20260818-dev-ast2600-hw-prot-key-reset-e68eb9f49ee9

Best regards,
--  
Andrew Jeffery <andrew@codeconstruct.com.au>


