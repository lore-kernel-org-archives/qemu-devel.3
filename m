Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BD0C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsIJ-0003LH-Rc; Sun, 18 Feb 2024 20:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIH-0003K7-G4; Sun, 18 Feb 2024 20:18:06 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIF-0004GC-QF; Sun, 18 Feb 2024 20:18:05 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-60821136c5aso3790267b3.1; 
 Sun, 18 Feb 2024 17:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305482; x=1708910282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgvAf3Bny28gbzls8qX3hW1W5UZnJ79IBUeZtScB5YE=;
 b=freXttGzS8UBciBIB89f0ptv64aY7d/9w6olA13uV7CWLqAZeveqXGy9Y/KnYw1Q5l
 VvF2f0L3hTpWQDHvxCJVQvKcXxVNra4Br9iKSsRhlB9hGO2+P2uEw0HPTnyHCfVf6orD
 L0iQpc5K8Ts7Umdb2iioLumI55sm48wBfnYGkJEElUSYebu/oEGU/ZBGCpUEmcaaHCZ3
 Xj8EpnLyQkxDXWpS1v/Vw2RwvRo2KAOfo/Qo1DtZoGAVMdnfxa9/xP+4KPlXU5zyV0NB
 l7cnO2jBbIZiL1k+qfYJXuCjw01zyuaTzKFCok3NM451qkkxYWrtASJBGRBj+CzCgOaU
 hwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305482; x=1708910282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgvAf3Bny28gbzls8qX3hW1W5UZnJ79IBUeZtScB5YE=;
 b=D7QZhVzRD4R2woXuW++EigzMlMr3o+QDhdyogJpOXLzEnc7TItFTnCFio37rzEn33m
 HAcGHPSzebg7bIHfZvR+PbzKUN3X1jLIFOjSCRAdvN2G6XoHs+83U5MrV4O5lk0zqnhB
 lAR5C1hJgGqiWKuNjgjd5PkhbL6lecKSGp5kvnNx80/FyPjOnS7LPQ59Se0iR0Dpf00z
 yPPKSD2vpWkxw7Oz95/Gv0wUmNY/TvbgzcacCeYnjMAtwfX2q5yOWnri+Zc2BJGBIL0s
 W4ToOHLBFDTmlHpFoGid5kNNdM9tR9TVoNVZgKZQYqYlcxUOBw9dB1gq3CEtOBBKL6KO
 p21g==
X-Gm-Message-State: AOJu0YzOQmti3i69vtLtdnbjNk1Pdlu8UkK1B2EvNv0RMHu76OJowrct
 9I/CybUQ+4/EJP0OKfNty/VgZnnQKHe3GuDjD+qAFY6oiFX4RowDOyfGTPBp2Xw=
X-Google-Smtp-Source: AGHT+IEUainKH0IeWBPBPrZvLMGgXm74aWBnj976gDgiNPe6L2oW/ptcmpXgt6AZ+g/zVbJFwjLDtQ==
X-Received: by 2002:a0d:d5d7:0:b0:607:d285:4d7a with SMTP id
 x206-20020a0dd5d7000000b00607d2854d7amr9762550ywd.52.1708305482194; 
 Sun, 18 Feb 2024 17:18:02 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:01 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 12/41] Add memory region for BCM2837 RPiVid ASB
Date: Sun, 18 Feb 2024 19:17:10 -0600
Message-Id: <20240219011739.2316619-13-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 3 +++
 include/hw/arm/bcm2838_peripherals.h | 2 ++
 include/hw/arm/raspi_platform.h      | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 55ae56733f..ca2f37b260 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -185,6 +185,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
+
+    /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
+    create_unimp(s_base, &s->asb, "bcm2838-asb", BRDG_OFFSET, 0x24);
 }
 
 static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 86b0d96944..af085934c9 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -69,6 +69,8 @@ struct BCM2838PeripheralState {
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
     OrIRQState dma_9_10_irq_orgate;
+
+    UnimplementedDeviceState asb;
 };
 
 struct BCM2838PeripheralClass {
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 0db146e592..7bc4807fa5 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -73,7 +73,7 @@ uint64_t board_ram_size(uint32_t board_rev);
 #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
 #define ARBA_OFFSET             0x9000
-#define BRDG_OFFSET             0xa000
+#define BRDG_OFFSET             0xa000   /* RPiVid ASB for BCM2838 (BCM2711) */
 #define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
-- 
2.34.1


