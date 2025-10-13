Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8558CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4D-0006EY-53; Mon, 13 Oct 2025 15:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O49-00068x-Hl
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:41 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O47-0001rA-4t
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-421851bca51so2998910f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383117; x=1760987917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nq/c7G5HIzcDKU2UT+Bof9qbKyw2ITQMkRJlo4USl5w=;
 b=K2OJwcgqGtkYztEdJiiNp1ikgRGcLr5963S6y3RsLTHxRanx4QzEk0lVy0qMTscdug
 Fm30YD09ysDc5o5v7FlZVYk/JHCsuCY2SbrtBMUQH2PbVF9NlhhPRPWyQmI/IXIF45Iv
 2UF1Zsu+PyCBVPTlbYyW1VEEKYcr2WPqH6uOqZEwlHLz7R5EXNdrAzPUTdFZQQvUelDQ
 Ta3hFlm8BmOwy3pGFVjg14PGLcY2GsgPWWeie75KPnqJCsH7I62uUqMZUQdVM7c4F3ZS
 A+CbPOqQeFDJCqPFBBdnBaycJlaHs5zEajq5xpfRaaT0MoOF8mz4/jPK0QtTsnYSmFCB
 CU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383117; x=1760987917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nq/c7G5HIzcDKU2UT+Bof9qbKyw2ITQMkRJlo4USl5w=;
 b=Xw0ygcCOTBMQpG3d50JivDJQOvHYDDfzN8aOegxvhr3BQaUt+vyFbDz4AWZuCPvBD/
 0viyDB06Iqq91T/WrjV/Rn/2JFltElhTt7R4xVwpmaKvgB5YNQfEUkBo8WDVt7JFvdTc
 TlNK5xRhw7veqI3o4j0wwaqjR/6hoFtrpeFk943J9s2l0opcYhnPS/dk3wQcA3tmvpoD
 f3b52fYhaxUsjtHLrB1BXwkYsKWCdLBCTEI8TjIL1GoHiocsGeFaks2bZPbkVqQp+tyY
 iOGPOWYdQhDcoxR1c5qmlL7W+AJtVlzAusErSgJ15lnPFa7UbjrnRd2lp8fUoA/tFxgM
 74tA==
X-Gm-Message-State: AOJu0YweHosqvn8msEGkSl5c05lqJICTitscHU6qTOcst+IYBCEiJf1d
 l/1nB/7Q9qRDxOjdzRRlTYxs6lx+dvZeUjj2BUrgFlue0JH1MbYTFB8oLR7sqCOFlGcq/orXNCx
 dgH/Cy5RumQ==
X-Gm-Gg: ASbGncuAzeeXKo69ASQ/cNUqMqrjJLCV6Cuzh7KbuxehbVI+2j3nl248qB2wyZqkAGe
 J8Z+V9jkbfnpjRnAOY84EHpMna4UMb3KwOL231F02mc/FcAxe46G47Fay4RGCtpLqwX08Xu2ypm
 B1N8aZKhJgV7suPV1N7vMWcyuIc405QkLoADCheDvTJaa1Aif3C6isNY2ZooIfXrlsOoC6R0MIw
 8bepCBIBbwhuZr9wvlQsNBBG1lhJhx3nWQ87c5pQpkrtcjBv9a/OOTry4IIzWKt77c4VYnnl8sb
 3aFh2wvRDOXDhidakjnGTVyoXVivJw2t3kp4YTC4JKbyyxdBTlid7x89yAoerkTjvtdEs85BZJf
 ti6DualjZQE9LOUVDOX/MXS2aSg++8PO9FaKoWg/8gc99zzkypQ2vTP+rvuB61mub3+a+FMQV3k
 uqfAQ8Y35GV5oaeGP8+pU=
X-Google-Smtp-Source: AGHT+IEkRxSWhBPjU1LbjMsiqBXSTz2QHi5OOJpiE57vfS6uD2yJoS8YJ82efimZGlCrIarbJXeFFg==
X-Received: by 2002:a05:6000:2509:b0:426:da6d:ca6e with SMTP id
 ffacd0b85a97d-426da6dcaa6mr5703176f8f.58.1760383116540; 
 Mon, 13 Oct 2025 12:18:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49be017sm197361095e9.13.2025.10.13.12.18.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] hw/arm/aspeed: Don't set 'auto_create_sdcard'
Date: Mon, 13 Oct 2025 21:18:01 +0200
Message-ID: <20251013191807.84550-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Cédric Le Goater <clg@redhat.com>

The Aspeed machines inherited from a 'no_sdcard' attribute when first
introduced in QEMU. This attribute was later renamed to
'auto_create_sdcard' by commit cdc8d7cadaac ("hw/boards: Rename
no_sdcard -> auto_create_sdcard") and set to 'true'. This has the
indesirable efect to automatically create SD cards at init time.

Remove 'auto_create_sdcard' to avoid creating a SD card device.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251003103024.1863551-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6046ec0bb2a..58cfbc71379 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1418,7 +1418,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1436,7 +1435,6 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1455,7 +1453,6 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1474,7 +1471,6 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1492,7 +1488,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1511,7 +1506,6 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1529,7 +1523,6 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1548,7 +1541,6 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1566,7 +1558,6 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1584,7 +1575,6 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1606,7 +1596,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1625,7 +1614,6 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1644,7 +1632,6 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1663,7 +1650,6 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1686,7 +1672,6 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1708,7 +1693,6 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1728,7 +1712,6 @@ static void aspeed_machine_catalina_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = catalina_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = CATALINA_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1796,7 +1779,6 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, const void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
-    mc->auto_create_sdcard = true;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1909,7 +1891,6 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1932,7 +1913,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
     amc->vbootrom = true;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1953,7 +1933,6 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1973,7 +1952,6 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
-- 
2.51.0


