Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA5C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXT-00041S-Sv; Mon, 20 Jan 2025 15:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXS-00040q-NK; Mon, 20 Jan 2025 15:38:26 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXR-0002Zo-5n; Mon, 20 Jan 2025 15:38:26 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso7382817a12.3; 
 Mon, 20 Jan 2025 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405503; x=1738010303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98ku84vcnPVXCm+Wkpqkoy2ntxeeyCGaHE4mQ+9ylwA=;
 b=NTSm4TNDpDt2WK7/L/KQSDcQMVRLPcTZrCV9ddE66wNpSd4GVLxy6pfrasDa2aXLeF
 zXN8Cd3N15SU1V5VbybgEuJNFDWvv3f0U9Y8iEheTbSuarvuRAcKVcdVvyTieUn5M8I6
 915gYQYvahqFeY1wtP8MH7SnSvyvHTTsWUTgf5TIxKKUK4onSn0Yt2CBMSYnkAxw+Sds
 8i/Wp6wyQouBib150x2RA88Meq6sise0XfsQRpPH67nvOCzvBf4BHmJ3wDGrzbjY2zI2
 PnR1mCrQ1/4f5wOtRlb6GX+oA9hcBGwvzKFld5bVnkUbmOpJsnZP13QZ972LunXsX3oL
 awBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405503; x=1738010303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98ku84vcnPVXCm+Wkpqkoy2ntxeeyCGaHE4mQ+9ylwA=;
 b=k8UJW6tTvQZ5VTgWZRIcPnqco2BQ25DRdwxY+sVyQ7hd4dOyLq6/RVWYOino7Xvmdq
 RRobSTyApFxV5VK4/2DebWRjZzpXppw285hY2Oz3fg9SGG9yovSkf2WJxWuldBoGMp0r
 GEVu/Rj/6jHr0tvIiRuFLWjhXyo8CADoYdWY0hnfYQJ+FWtYdAS+hxPhs5TZqfhjUrfo
 q+7hHWzM/jCyh/fCa0w6jntC31wd+XKb20qjRSEt8KSHeT19OSn+QyQAPXS2jILevIHa
 z0tkSKlfQDWZZyiNSycWJ7sBs1GJygJvCfpyFiYxfOTu+hcZzaW0sdn5BQqMM5BT0dsX
 cJIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgV8iI3GQlssA1VHxGW19+zvsgmQcVrWH+HBMj2vuTMHsAUzH1h/OrQzAJtdtCR10h1Jl58wlAOg==@nongnu.org
X-Gm-Message-State: AOJu0YxdN9PqQ/h2rqnqhkpfDLu6o4+CBNfrY90UqaRqeB06+G5HOhgc
 lwQIkZXo6WszQfH9FK7Yblqrx6dlAvQ9MLkylpRfuD4n6Xi1jUVay5+8ak9l
X-Gm-Gg: ASbGncsjUvt7eUxKS/JnicO9euVbZ9Ol4s2NbKukWITj8z0LMgDbNfKLiTx2ZSksPVa
 JVkFVr2yiJSAUvitxlvm0EWaj8LYEfOuuJfJWooNpFz4+qxFRZbzCWbZR/5bwSO9VdKviyJXN9O
 RYrDEV6gegoYwVRR871ieRFxV1SI259kLi4MJGPq3fLtxcIkJd2pV+W8v5RdTTr50lqNyGvitKY
 2P48nppIByXdCwOQ5VGZiEMCbMRu+Q/wGRZjDaaHpNbA/g8Jz6qNPFfheEylg/SV4xNxY8+/Ziy
 SFeeFEcuE4rRQzWp4LiKKsvVgfkFAyRwnLXQoTU98vfmvCgZP3aZt8N+8kmT
X-Google-Smtp-Source: AGHT+IGkn3AblOxdZM4HkhpNcOg6YZiPvxPDjNuDvoL6VCQuKSmef8pYrMLpWOS9uXAYlpctws6O7A==
X-Received: by 2002:a05:6402:26c2:b0:5d2:7199:ae5 with SMTP id
 4fb4d7f45d1cf-5db7d2e3014mr14020891a12.5.1737405503008; 
 Mon, 20 Jan 2025 12:38:23 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 18/21] hw/arm/fsl-imx8mp: Add on-chip RAM
Date: Mon, 20 Jan 2025 21:37:45 +0100
Message-ID: <20250120203748.4687-19-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mp.h |  1 +
 hw/arm/fsl-imx8mp.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 326c4ddf69..e0442665fc 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -68,6 +68,7 @@ struct FslImx8mpState {
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       boot_rom;
+    MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 9688e2e962..cb4b0ae5bb 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -665,6 +665,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM].addr,
                                 &s->boot_rom);
 
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
@@ -677,6 +687,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
+        case FSL_IMX8MP_OCRAM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
-- 
2.48.1


