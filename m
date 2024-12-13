Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0D6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9I-0001lb-Fj; Fri, 13 Dec 2024 14:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7R-0007Xo-4D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:33 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7M-0007cO-3q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:31 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2a0206590a7so935341fac.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117266; x=1734722066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcaNS/gxnqi2fcS2Nr3KkJaxwBrXTBr+IuvckqUS1nY=;
 b=ik2eKMeE9ydojWDyHu41qTyvEkbA+sPhBIOG4YCHgph40TD4jQonZb9deJSDeTqo7t
 1bYfhNS3wUnqZUL5hmsoSzQL6GhaGfQWAV1HaVJmF0q1DkG6oSSlyRZBs7j0WRj8Ltj8
 E2ExWOs0kGjd8uFo75Y7rZhJWKg28YdHLn2sMLus//kCL7tZdo+GqYCxRafH+1CvixlD
 BgKhcehpCha2+KDN3kefZEjOse9ja5e2C3O/4rY4QUXDvTbd7D7eM9LXZVyA/MOfHMUU
 LPRrWoFbuOPkcCeQ0JvnTQmjGaUSTGVeXgfdPdQnbSXgOS+SpAuB/Gl4Z3z8rlx8R85u
 XJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117266; x=1734722066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcaNS/gxnqi2fcS2Nr3KkJaxwBrXTBr+IuvckqUS1nY=;
 b=ePM/A8OqbEdMZhDETr41jgsrTolWcJ7B1nDBM6+isNf7D2enl6ZkbSbmxW3sE6jwKJ
 1w28lHyMWRjz4oKbDbhT1zT5oD1mh6CpaDa+8jGFAviLx5tp/KKlSNhU7vp2xL5kqaJy
 2/BvWCjePF+B0QrG6p0ZrEfSPMr6nx/TTPOKIJnRrJhSdD+Ldqih8DctTW7KraH1qi/d
 99kvKs5Wk1VwsKSzTCoNDdlcT2jDqxlBLq8ljYTRF08WS8rw7Rt31oGXWq2yQS7ucnBT
 NWirgZsPHntWwqJ+P/XZN7tJ5S2hWK/50DwJ2J6Cwt6/+rtlUWGk4MgHxOzZ4k06XOM+
 g8MA==
X-Gm-Message-State: AOJu0YzMVY/2UNmW+aKu6XZlLa0yZ3pM2W3bU1SCsX50NmADluKH0SlO
 mhQddjm7eNbjlOP0bMGdn502jeIvcX2kz/EaC7uw7KPOM9l9XOewKUVMLzTfEURqHfmtYkA5Pi0
 2fMTLrG7g
X-Gm-Gg: ASbGncvTCEphAW8TkdaR9Pqgon0XpAjZbWBk+0Bfhp4PcwsAVF/6coDaG9tRTuGY9Td
 vDInDfDJrCJMh13rfbqPSs3OadnWWZAbpmEzHVU9QenOp8YDYF4d3amU9beo4On2uUvw16ya++m
 mxOC6YH3z6wnPlczinNJ0b/hzvZpQd9tGSs/BSAJ1s3Xx3BH1tAGCYQ5q3kwddd6aoQu5X16Zys
 elfNLH68wCN5cu01f95VtsC5ZjQCFWy3pw73CBLNnExB2u7KEH4QA3ox7Mlw/x/
X-Google-Smtp-Source: AGHT+IEZQOzM8KT/fK5jdnLzpoF2HQUPsIExdGbu7vSU3jXS/UJrRkvC/I406ZLiiB8rMccolcNhWA==
X-Received: by 2002:a05:6808:14c5:b0:3e7:edd9:8eb1 with SMTP id
 5614622812f47-3eba6815da8mr2506800b6e.1.1734117266034; 
 Fri, 13 Dec 2024 11:14:26 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org (open list:Allwinner-a10),
 qemu-block@nongnu.org (open list:SD (Secure Card))
Subject: [PATCH 56/71] hw/sd: Constify all Property
Date: Fri, 13 Dec 2024 13:07:30 -0600
Message-ID: <20241213190750.2513964-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sd/allwinner-sdhost.c | 2 +-
 hw/sd/aspeed_sdhci.c     | 2 +-
 hw/sd/sd.c               | 6 +++---
 hw/sd/sdhci-pci.c        | 2 +-
 hw/sd/sdhci.c            | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index bcfb4c1322..be39ec2e71 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -808,7 +808,7 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
     }
 };
 
-static Property allwinner_sdhost_properties[] = {
+static const Property allwinner_sdhost_properties[] = {
     DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index f82b05397e..99703f1842 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -204,7 +204,7 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
     },
 };
 
-static Property aspeed_sdhci_properties[] = {
+static const Property aspeed_sdhci_properties[] = {
     DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f9bd03f3fd..b994ef581e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2798,18 +2798,18 @@ static void emmc_realize(DeviceState *dev, Error **errp)
     sd_realize(dev, errp);
 }
 
-static Property sdmmc_common_properties[] = {
+static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property sd_properties[] = {
+static const Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static Property emmc_properties[] = {
+static const Property emmc_properties[] = {
     DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 9b7bee8b3f..83892a7a15 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -22,7 +22,7 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 
-static Property sdhci_pci_properties[] = {
+static const Property sdhci_pci_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 37875c02c3..e697ee05b3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1544,7 +1544,7 @@ void sdhci_common_class_init(ObjectClass *klass, void *data)
 
 /* --- qdev SysBus --- */
 
-static Property sdhci_sysbus_properties[] = {
+static const Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.43.0


