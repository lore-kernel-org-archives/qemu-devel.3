Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A9CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKT-00070Y-1Z; Sun, 04 Oct 2026 08:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKO-0006u2-RR
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:29 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKK-0007FZ-Qr
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:27 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c4f4daso739706f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116902; x=1791721702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ShmZlMLtAd5Z9Q1ycLaZQawGdta9Ni09P1BVye6CeFA=;
 b=lmIqhZp07NOTldyN1yDj/3PZ/reD/0GHMSiX17XzhBdslhDF9J6pZYurcoTS3Jdv7b
 a53ZvmrzIeMFJh4URPH4hTmX6T2nCmDDBRbo61GuEi6EQ9n6FZ9/SWFNOxvusnTTG1ja
 MrEDjEUaNVNg3s3W5OziI11HkSiu+q9q3E4qoifkBDnKWDeHCLtru8I/iHLta+lfCAnV
 vaAID7aqCUJtOpEZQPy20ht4da0QOCdg+C+0EZckQHmAlOaJmj7/3I+dbS/ZERbW/K15
 ZeHmIZ9J0pjMtCL2A8/7s6IJ3yqpkCktysp54cOXPqHcINe/mdaE7Jo2sWTk/6AsA4W6
 4kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116902; x=1791721702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ShmZlMLtAd5Z9Q1ycLaZQawGdta9Ni09P1BVye6CeFA=;
 b=ia45nkIzGAjHhT8AoOCknRBK4e1gohx26bRJ/VflDjc2IxIqne94ubaevL+etTOvIo
 iRz9oP27m7v9dOYh37bYEdx9jyIdzPTfbOmhQyNxPThiglSfdikIQxnOIPZrGbdFaHmv
 Peg470DeNo1gvlpPW6DFDmuRZ2ra7pMKjsxKPh1y/CQasK9CFqbCxrSgGoTzssc6OuSn
 9Tki1PXEMb0rlYuRd13eYdfUykpTSJvs7/RjbClW4son2LA7FbZ+WUFSltfaCkHqGqid
 MZVnXSVROSEqCRC2IpYpfclV7DVSCVmpibXOVwnbXobgd8FgplrOgdIAc9Vg+h1VkZHO
 ptDA==
X-Gm-Message-State: AFuF++mEeBDjd9TJdMqZbrQBmxeu4Psext59EJiXbiZahGCcWLXb9Y4V
 5yiYmv6ldyO6rKV3ifFCU0qBWvSCGO59rzFggqHlako3OW73utOl88f+kKF+WQ==
X-Gm-Gg: AYBFou3ogA74Z3evQ6wlMNYT2pKCVNuM+DPO/08tbVl7asfmxdT5RmigKwuIIF5WWPN
 QYaJFIkyJl5hGE5dmGuStO49axe+acGOb9myOZwrDRH+RiUhaBdY35FCQIdOr0w5nbnrf4pRf5N
 OKm8U1Kc0+qO5hxxOwBE03Jggju2s5Yf7Omq4qtMg3yZ5p9TT84GHRhtoSg5Dq0Qe22aE+43sJp
 tZBf8jd0GZRFZ3p3e+w0L6BRzshhqSaDYgPiVlZ2Onf1hw/2/tP7hy9SOMMmGdXqeLCY1hoEPf7
 ayEBH/bsRQYSP5j0VxLl/SGthbs8YfrQVcwy5a12FOImvIBlQ5N5BVmwI9YCmyu9qmmTXKNcyZj
 wRzRi32i5nWU/PriHmDWWfcUyTrXIZNBz65s6ApQ9rYX6I/g7n/U0GZUW5oSuh34jkKpOoOv8ct
 0rQLxIWC82+JeRbDzfzuQoTySTlBDJJ32C78S6OtkfuXeoZqz8RjdURrlzHDngp0Zfh9LQu7uv8
 CfuyfDab/qTHla/E+1lNryhnlMuSYWFpd1IiA==
X-Received: by 2002:a05:600c:4592:b0:4a0:bc9:28c6 with SMTP id
 5b1f17b1804b1-4a0276b6860mr122119175e9.34.1791116901600; 
 Sun, 04 Oct 2026 05:28:21 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 30/30] hw/arm/fsl-imx8m: Fix typo
Date: Sun,  4 Oct 2026 14:26:46 +0200
Message-ID: <20261004122647.3913-31-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0e.google.com
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
index 875e92bb34..dd79188e0c 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -589,7 +589,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9..0b46a4971f 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -619,7 +619,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
-- 
2.56.0


