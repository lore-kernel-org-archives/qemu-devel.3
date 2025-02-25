Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D66BC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzML-0008TW-Eq; Tue, 25 Feb 2025 13:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJr-0000Ow-Ft
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJk-0002Ou-Tk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso37493035e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506761; x=1741111561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NR+zcHQnCsYl/JswP9hc5n95WylqnjqY5XYs4m7vvOk=;
 b=isEtxvTGjOQWn8pkaKr/Y8itN0PclKnqVzi18teEIxtZY03lSI6qKjNPJ35G20HUzF
 vyGJx6mHTrQabets2BWvyv9qpQeWcT8BBSZsZf7C47dbMypAVo+Y1NuVGi0j2cTX3uu8
 tkk8XwYYGF1biwpSiYZOHL9qV/XkZ89+0BFSMlGu5tgKmyk13ystY3xrX+rpcKEPkKY/
 eNi9kJ9V3LS7sqTtqzf8eSycDLEPYfYq7izvnH2lcpgs9KgSoFvSctI2gdwOa3ZA2D8U
 EIKh7QY5rhzzLNJJLZKjZ8M05AltEYTAyKOHDAhvNcKgj711MN6QMS7EPOHQnYy6P+Hv
 4FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506761; x=1741111561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NR+zcHQnCsYl/JswP9hc5n95WylqnjqY5XYs4m7vvOk=;
 b=Me0wIj7A9XaveoaefHP1tNpySXjQrvBwtC48wkEx8U914cWHAzgOInhFQoajf0qwLy
 3FvE+xRIAQRDTpSkRgkuX+ll6MCUa+BAAdDK1Q6qtBkgXjSyS7uTOJBHZyOmOjIdYaJ4
 EvJ8tadim4lre9eP1dTYGJpzcRZQs5Gaq164kX0a2tAEsIv5nWJFzzFLWzdoVbdZ9vPM
 U8DbnF4uaroilhpUHi/VoW46Q4gWU28VooKRcFqNuc0DffHThedu3jttqPd+qpqn7+EC
 C2mWg16C6CakhPzEsei0YqKLy+50nyY9YvDQazx+8ih5TPl1YgWXihexmnTmeVMIwnpW
 qplw==
X-Gm-Message-State: AOJu0YzAKEC3pM57Cyme12nPl/cLnNDkewZ9z3UBtNXI9Ypw7HR66OXF
 hBTpWL2LOYAggodpslSDyLGlyLEaORYkanyymvN+dLMjfVQwsM8GHr4mpo+NyGFR0sBtrHRmptJ
 Q
X-Gm-Gg: ASbGncvYAlS8sjM7MWL8WhJGeHbisrg2a6v1zKOexWtPHgzrzcgnfBSqDnk8hG4bySG
 QWJ5y0m9iqzHLfDV/OndyeT6OTNwmRw/nniRA06rnN2ryk/Q7pxFAVBBCqqtgyVG+2CeIrTdlhG
 W7NpuZXwtqEmd/vbXMdQqRpbJToRw3XQl3dW4m9H43w6XlYq21zO/qMd0kbjLCQ9W2ji1NhaLMl
 +8qLFwg62s2g/hybZSiqt7GDeAVYuU21OxIyp3NBMzckKnblEgEqxUZB1t0PKLRwX1hDR1DHHM3
 o8NnRgE/1dGzctPMhO7tk7OGEt2cjQ6q
X-Google-Smtp-Source: AGHT+IHD34OKqxoXLyxovtnIkDQ8sbFCJLJakexaBo2VtNQc9UMsGIbEOi3kSEcMuXx3OIFz9xna8g==
X-Received: by 2002:a05:600c:3ba8:b0:439:a138:20 with SMTP id
 5b1f17b1804b1-43ab0f65faemr34538115e9.20.1740506760966; 
 Tue, 25 Feb 2025 10:06:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:06:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] hw/arm/fsl-imx8mp: Add on-chip RAM
Date: Tue, 25 Feb 2025 18:05:09 +0000
Message-ID: <20250225180510.1318207-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-18-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx8mp.h |  1 +
 hw/arm/fsl-imx8mp.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 5247e972b88..bc97fc416eb 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -68,6 +68,7 @@ struct FslImx8mpState {
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
+    MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 0880f0c7244..1ea98e14635 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -644,6 +644,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* On-Chip RAM */
+    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
+                                fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].addr,
+                                &s->ocram);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -655,6 +665,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
+        case FSL_IMX8MP_OCRAM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
-- 
2.43.0


