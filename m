Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9656CC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF83-0005V8-TW; Tue, 04 Feb 2025 04:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7n-00055M-CJ; Tue, 04 Feb 2025 04:21:43 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7l-00056Q-Im; Tue, 04 Feb 2025 04:21:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38daf156e97so127333f8f.0; 
 Tue, 04 Feb 2025 01:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660899; x=1739265699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEASFFo5LT5KQx7hc6rH0of6npLqn1pGunpDBSPvkfg=;
 b=GvxtDhGE8B4D6ZJ6T8E7kfjYc7kXb4kAoet/viJWag47/MvQzbqNknZVLxAsI1fcEE
 culpwCtqp1m7XACOvwujO5+7rib0zbTm8ZnIOhvGYLfDNR0Thd4vn0O0egggvmiA2+5C
 jMbTut2/I+S+prxtVeDhOLt4hTATML8tQbjkjsbyeFLJyzGlJPL+M3z6YTfZ3JW8UZ6l
 Q9ao5sNPBupojx1pDnL1Mvj1Ry0QArOYhyeSpn3aBTzPTxB5HdvTee5+ybNlijiE/XU0
 zSNtQxNnFI6VDl1lL8ys8FDZntNWb/vIIw1/of9PfhxYBHBjHqRqf/5yU143b2Ww3rBy
 1IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660899; x=1739265699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEASFFo5LT5KQx7hc6rH0of6npLqn1pGunpDBSPvkfg=;
 b=XchEIdFN7PMkyrcwLTGKJFXlASMofYFG4Qtj3/2fT5WLI89w2RML4PG/Wa0kBkoZEG
 FAmaLDHMPpmtMDktazPeQK1AbUJZ869zvh0+trm21+7KsUoSryGHZWYjqiEfuma9zEnX
 NhaPR/3gz8ud1W+Et2yhrAfTA5l9+vECPKXqHp60PRZGX2tyfgdnk+F8GHg9CQ5EOmW7
 WZN7Xw74sQ8NJwcz8OYmvIWrdMnZ+TEemIG33+E5WUbicGPcYcJ8bp/QJ/TEXVUpSFhW
 4x/OAYsfRyPR2nyJRC3u19PeBpdyBgD0oXRZzV1PBxts+YhA+YOk6vaOv5TJI+bCllvO
 18Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrghrij5JZKNcdGH8tNmiItnh3uwYjRyW9w7hkBYOY7b1PYKvSbOkSejyV7t5NjiQb5mZ+XemOjQ==@nongnu.org
X-Gm-Message-State: AOJu0YwH+W9ZBbkRjDnbwDQ7CHZHEuOOcyYi9HTdvYtd278b01MU9i7K
 +lINDuW7dt4lXcdKYZYgtGymRuO1Vlm1BllwTEg/q28SRDJLSHEEiC6MqA==
X-Gm-Gg: ASbGncsRibIGa9Tz6WYcVyxlnTVWiiQkA2F/qmohw+2jAPrxdrRxJPJKha+8qWnsoEV
 CO4HTSd2zWRdHG18Nzrnd+MvGzdStGkcaeDPKBsfH0GrrXxd/fsYWkIqVXffez28btn5zbwynm6
 PtwJ5PPcREjVTC+SFKCXfSht+26x2w+MixIqoQ5WSt6EpS+8AmJOMCdIXJENbELFlFXKBXS3CDW
 2r4Fr+t8SkAVU1GhtnxQbMbKqxoxUn9Xuru5fhTKgpPcA1hRQveq9PnhV6b3w97Sy9tMXyZGTVL
 iE8MpvXJB2Or9Y/q0ynLfZVfyfvfLp1KzpNHWCdzjBhDN4bpZx1fV4a3glHsbecSZWVlMsXYJiE
 B3t58nnt53Q==
X-Google-Smtp-Source: AGHT+IFw2Hr7BEiRBHNTzlrUrsYFALZtpiYL+/raLcs9sjZ+w42oRTd1hwVz49wcIyvO85QrRsvv5g==
X-Received: by 2002:a5d:4348:0:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-38c51e91b5emr18543431f8f.35.1738660899201; 
 Tue, 04 Feb 2025 01:21:39 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:38 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 17/18] hw/arm/fsl-imx8mp: Add on-chip RAM
Date: Tue,  4 Feb 2025 10:21:11 +0100
Message-ID: <20250204092112.26957-18-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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
index 4dbe30f524..03f057c7db 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -69,6 +69,7 @@ struct FslImx8mpState {
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       boot_rom;
+    MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 6439639110..e0dfe06e15 100644
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


