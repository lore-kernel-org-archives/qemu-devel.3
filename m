Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED9DC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsF-0006lC-0P; Mon, 21 Sep 2026 17:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls9-0006fS-MX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:25 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls8-0000PF-1a
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:25 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so26353435e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027293; x=1790632093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0CSy0xMqZIb4P6bNwkb1VnPTSf9A/yfJ/dDXW/NabSk=;
 b=TiAJfHsnTdJYJ0B/IdNY5yG/xkty/kZBAE/6mO979PKCQaujbVl6t2zpny7dIlRQca
 27Mm+w8XAFe2tO9hxQRwsnUtbtaGYb3xjtjbfQZhjwkbjTXGZ/LzAuOYNu3mVXQCcBkm
 VytsPeFYtiBbI2aRdwoezhnvKEZtkWmrhv/xGWJzKJC9zszBRMAeCOCW+1jM9AC2iAcC
 vZuf11x5riy6zKsLgagLYtuMQY7bMneEcysafXqfy9lzr0/ykt2sr1+b/WzJ6G+r3aSh
 0gaRL6f87KHTWix+DWmW5M91HhhRjnCwKJU5KPsSlSHY0AAxo4Xo9I/DmSIIvu2q/1LK
 B4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027293; x=1790632093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0CSy0xMqZIb4P6bNwkb1VnPTSf9A/yfJ/dDXW/NabSk=;
 b=dGGrKTVf17DSnL4XFpUA/DezpmX6Q/kjJoO9F5KNU7viN2wG7L3hBlRp8u+cTOPRKO
 02QphqniCMCAdLRWKNV2ONVkIz6LTicLs6eZEGASqe43ENKc/xDLI0ZwhP7JhlxnuSQ9
 SXvV8CiTgs0Pto+AaQ/SEacQ4hVMvKzar2QWQPBFWXPpO/8wj23+tt/6/7ka2Hvkqq1G
 gkFwSkAuuj16WsLqSPlFSSVewkJtKdLUvhAmy0XwLqacNGefSDrFqKssmqPn0IBS9PHI
 p1yrdGuTlrwrPrz0KblkKqJAxXy/hbPmZBcpFuuyf13v+KwjkljuTIXBPMsaQD+UHJoH
 m/XQ==
X-Gm-Message-State: AFuF++nic+86ATwhkb/PpUthnwzeSy3/yqjvuDK906Fe7/LSvt6XTijE
 PH5Kjc1OxGYx0eA3oQVSWl47viHGXReFvmrL7l1NLBO15yTv2o6xDq4OqjR8Ig==
X-Gm-Gg: AYBFou22dXpx1fuL+6dI4X6GgnMbQGb0kRycWfUI28ZNxVM2MTh56epYYnvOSsmO8LF
 LnSMpcDQsO7r14ytGR0iAdJ2N8Cu7lwnpHIbV32QSr1OtwB6cBv1S/3l33v2Iky8Dn2e/5q3qYp
 ++abj0kNXASb0GvvDpbWHp48kIKfcqXPke63WH1A9PZt1hAHVFHpwNZ9J4x3JG134TB6aFdQ85m
 v2cma1RxxeFvzl51r6tqe3SpTbEZJlp0G7H5rJVcj5igehU89IhhMBvXOKbvRksYEOjC8i3vQAn
 DwRV4eeCV3I9GIwgLcT1TiQ0gSEwlyL5kmnFl/EcFw3P9DjgCmIn62tOp9Bc/n5yKOrbcgXRJ0j
 2fhzWzo2zMDuGNhPcFz8x31OgCm5wSmrkgGbiJ3r/GsjXBiETP7sTdc6qL0hSnZFcOidG0KGnGZ
 AuTYDWKuG8XL5YQWQWx6cN7QZRRuYFNkFz8/OgOrwUO+BLZXc3n0CS7xt3jIIZkSgv+3gHcZlIz
 l7Z373d9Q/g3Eb1h3SKQRqOl4VhCXgExjrL34vYabVbi7QIUvz3zTDBJaVn7xDE8WXavG2ukk/A
 E7ax9HUTx2ZsnQ==
X-Received: by 2002:a05:600c:354e:b0:49c:fc6e:a3d8 with SMTP id
 5b1f17b1804b1-49fc584f854mr165207835e9.23.1790027292607; 
 Mon, 21 Sep 2026 14:48:12 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 34/42] hw/arm/fsl-imx8m: Fix typo
Date: Mon, 21 Sep 2026 23:47:02 +0200
Message-ID: <20260921214710.29422-35-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is IMX8MP and IMX8MM, not IMX6.

Fixes: 0c105b261551 ("hw/arm/fsl-imx8mp: Add Ethernet controller")
Fixes: 857670200c51 ("hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mm.h | 4 ++--
 include/hw/arm/fsl-imx8mp.h | 4 ++--
 hw/arm/fsl-imx8mm.c         | 2 +-
 hw/arm/fsl-imx8mp.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 60d79a6e3c..1966fa505f 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -229,8 +229,8 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_WDOG2_IRQ    = 79,
     FSL_IMX8MM_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MM_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MM_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MM_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2be3c51af5..3acfffd30f 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -276,8 +276,8 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_WDOG2_IRQ    = 79,
     FSL_IMX8MP_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MP_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MP_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MP_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 37934d2951..90c1673461 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -590,7 +590,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index f855378dff..fbc094b7db 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -620,7 +620,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
-- 
2.55.0


