Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72299C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHN-0002TE-0d; Fri, 26 Jan 2024 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHK-0002Or-LM
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0007yf-UV
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33922d2cb92so651068f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279635; x=1706884435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZpEnAeJf53ixh3kz2oebZYqrcVt+0YUC5baVJx1ZCE=;
 b=MOPEiymwOLR5akSKbdgGs9zAfxR9UWsfclcrQbx3U5rKA0x2ci4TOCC0/nwJNDDN2o
 Odj4U2HofMgj0eG15Z0Q/nHUjRY+mSMyfBjQJ47t42hEafqnwlvzBwsAWSZxRtdIkrkQ
 uh+zyxzw6GkyPAxfCojzXcnTnJ35lS9RPVvg0X6Xloedh6wtORCZNS3mBWq5d7cUvlBn
 pUGV2Mi20N6lszQ/KZ2BTWZrhN+Nbj1XoL51DrZw+7JAZV0dcatbJ9FSpxu0bBkxX7mZ
 aihAyR0/Bd0BRbtW8eR+VNXv1uPOm+gTQaC/COwDJt8bUE5623mA7WRd3DUw+5tm+q+F
 YKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279635; x=1706884435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZpEnAeJf53ixh3kz2oebZYqrcVt+0YUC5baVJx1ZCE=;
 b=aaO4f1jArDiju1Ey65vjHar7KXyp5RufypUMod3sjL9ArpVLH9RWEK4kzJhEZEaUFt
 sig92g/i0noQfgcOkzU9uXwvZP76lXd9jFXbtWnx818BVPTXSjmYktPsJ0lCbG1ofLOz
 DH3JVptvM5009sosBU1nsT0rypjEi0ZHqXd3x0Qv/L258Y5oFxI1hvp/JaFdwpo2hiLo
 0lF5Lk7EEQ16iRXSq/WRDhwb3d9XljmNM3ge29ZZ3ZHS3bBmBNs90H8s6O/R8XVV/cMO
 +lVSNH62obhb5khRBDlzBZxJzx5RP4qIu4h4X3hg2PRgvDtRWc5lH/ENZqrPiYPABKMZ
 gHhw==
X-Gm-Message-State: AOJu0YyM9Bu2j4BN1qGXjj09LvyE7h6Wy2IvpjGAWL1is6ktrH4KRV3r
 hpG3BkOuTts2wQiTK6EdbAR9PsjoTv2rxrS+EVg2SNhOj7BQznYn0R3VvItVjsG06i064GUS5ch
 x
X-Google-Smtp-Source: AGHT+IGgDeqPPldGOCcki9hFSfUDRsMg3C+p1Xn8qdFb3ej5mHljqC7bqWR9gmq8R96xe39bTfImmQ==
X-Received: by 2002:adf:a486:0:b0:337:abfd:6058 with SMTP id
 g6-20020adfa486000000b00337abfd6058mr682127wrb.74.1706279635690; 
 Fri, 26 Jan 2024 06:33:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/36] fsl-imx6ul: Add various missing unimplemented devices
Date: Fri, 26 Jan 2024 14:33:35 +0000
Message-Id: <20240126143341.2101237-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Add MMDC, OCOTP, SQPI, CAAM, and USBMISC as unimplemented devices.

This allows operating systems such as Linux to run emulations such as
mcimx6ul-evk.

Before commit 0cd4926b85 ("Refactor i.MX6UL processor code"), the affected
memory ranges were covered by the unimplemented DAP device. The commit
reduced the DAP address range from 0x100000 to 4kB, and the emulation
thus no longer covered the various unimplemented devices in the affected
address range.

Fixes: 0cd4926b85 ("Refactor i.MX6UL processor code")
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240120005356.2599547-1-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h |  2 ++
 hw/arm/fsl-imx6ul.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 14390f60144..8277b0e8b2c 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -182,6 +182,8 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_ENET1_ADDR           = 0x02188000,
 
     FSL_IMX6UL_USBO2_USBMISC_ADDR   = 0x02184800,
+    FSL_IMX6UL_USBO2_USBMISC_SIZE   = 0x200,
+
     FSL_IMX6UL_USBO2_USB1_ADDR      = 0x02184000,
     FSL_IMX6UL_USBO2_USB2_ADDR      = 0x02184200,
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 486a009deb8..343bd65d1b2 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -193,6 +193,36 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
+    /*
+     * MMDC
+     */
+    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
+                                FSL_IMX6UL_MMDC_CFG_SIZE);
+
+    /*
+     * OCOTP
+     */
+    create_unimplemented_device("a7mpcore-ocotp", FSL_IMX6UL_OCOTP_CTRL_ADDR,
+                                FSL_IMX6UL_OCOTP_CTRL_SIZE);
+
+    /*
+     * QSPI
+     */
+    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_QSPI_ADDR,
+                                FSL_IMX6UL_QSPI_SIZE);
+
+    /*
+     * CAAM
+     */
+    create_unimplemented_device("a7mpcore-qspi", FSL_IMX6UL_CAAM_ADDR,
+                                FSL_IMX6UL_CAAM_SIZE);
+
+    /*
+     * USBMISC
+     */
+    create_unimplemented_device("a7mpcore-usbmisc", FSL_IMX6UL_USBO2_USBMISC_ADDR,
+                                FSL_IMX6UL_USBO2_USBMISC_SIZE);
+
     /*
      * GPTs
      */
-- 
2.34.1


