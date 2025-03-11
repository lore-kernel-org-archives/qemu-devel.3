Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C64BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzGR-000802-MB; Tue, 11 Mar 2025 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDl-0004tI-6D; Tue, 11 Mar 2025 09:00:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDi-0008Un-E5; Tue, 11 Mar 2025 09:00:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224100e9a5cso100846765ad.2; 
 Tue, 11 Mar 2025 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698028; x=1742302828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3BmDWJaQxO3ga2r+rH3p0NW/4tv9mRzlMcun1D9rBI=;
 b=Bb5Vh8Lg6CUG+QuEXCtK7740+jGENUxDPxEya1jOaUlOJ1LMXZcQP/642zz5O5YGGD
 yT/9jEiI5CvVaURBwbxtbRUnQSk9o1tglqvE4/BlnVkBYZy9NlJKQ1wp7/2RYLaRurJm
 K692Sx1/dD2KOUolC3nSC5qWxGK1g9RgZvucc4Ss5Mlt65ds1Ms5YHui5qfiXGARenWZ
 IGVM9I04zB+uOxLOs6g1Kg1mgI0pjjxy/JwgAeFgDVQVZZkwQ9en07/rsTlLV2Arr5BP
 l2Dxeene0wzmQPKUrE9Rw5RKU4jQ63pCu7uOCveqC6Dl+wD3kb823QYj6CjlRpHodx6j
 87Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698028; x=1742302828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3BmDWJaQxO3ga2r+rH3p0NW/4tv9mRzlMcun1D9rBI=;
 b=OaLIpyNN6PrO/UH170pxjxkWF2Kq5Ul3SKqop0FqXg2prs+qwALWFODEkcsexhyMDG
 8oBROczBB8e2jJ7wo0chozToKp+mplDD2uMXER16TwM+PBuq2GKLEh6tqANxLNVmGI3p
 upmfjCLW7VibZ8PhJfShD+L9PeMi0iNqHQy5QK/ZSkyf7bK5etpoj+5feE3fcXC6ZhUa
 ztsUb+Y/7E+RDUlRey4SNuaqwuOYRoK4GuvsgQjtgJ3lTNBL96B0jVFjQdpd9UwSuq7a
 6jT0Ot18k51rEn2tJzTgtWhQNseVkO3+9OtvrsEkRBUUkAU9aQqjbh+rJkqL7HUHMhMs
 FRjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWusDzGsR1TW+JCm9bcUATuLJ7AYwJah5WjjzUwjWdc6+H2YA6TfXjKogDh5pO48BoXIta4paDx1g==@nongnu.org
X-Gm-Message-State: AOJu0YxzO3/tecyboolXxS3xD2d+BCyHwc9KsvkfPzMOSx9saywVgvYb
 s7v4W+ticmHOCDzgZvUI8Xv3S96F2A5zErxSLk/e97b2+Jdw+wYSFxGTig==
X-Gm-Gg: ASbGnctX3p52xKT45XGYYFmahtIvQp7+fZHUzSMdBbw1KdEbwaupwA/69EAxpdtobws
 N1EeDNHZ3oKW8v9m0aJS3P3skboKwT1IxqOAw9ktQfm/ANTyMmQK+W4v4rXRipsK+GD827mMzn5
 JZCPzEeLxDVl/7qNBU5fmPVHHCw8gG3tUBIkPL1ilfUp/NSoGLiJkyexQcq4MjMmuSmzA8untFY
 d9T43JP52UASLM/+I67N+Lw5Eaj3jx+jmG2raDbyNUXX2w3VxhFUBjKz52E76XtiIVvvsSEI16T
 3cvjP6+xT/XoljRErPU1JlsPWvcsKs9DQAowg4ooE0bWfgzZaGA=
X-Google-Smtp-Source: AGHT+IHb56irBhoKneJKzVkcTWD2cD2JK+WC3OxKBGYfFbR7a0+WmGbvRRsobRKDte3B6loA6Ja/6Q==
X-Received: by 2002:a17:903:298b:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22428c221dbmr291023675ad.49.1741698027290; 
 Tue, 11 Mar 2025 06:00:27 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 39/72] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
Date: Tue, 11 Mar 2025 22:57:33 +1000
Message-ID: <20250311125815.903177-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

Create a spi buses with distinct names on each socket so that responders
are attached to correct SPI controllers.

Change the bus name to chipX.spi.<busnum> where X = 0..<num_sockets>

QOM tree on a 2 socket machine:
(qemu) info qom-tree
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip0.spi.0 (SSI)
      /xscom-spi[0] (memory-region)
  /chip[1] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip1.spi.0 (SSI)
      /xscom-spi[0] (memory-region)

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Message-ID: <20250303141328.23991-4-chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c                       | 2 ++
 hw/ssi/pnv_spi.c                   | 5 +++--
 include/hw/ssi/pnv_spi.h           | 3 ++-
 tests/qtest/pnv-spi-seeprom-test.c | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d60574d601..59365370c3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2252,6 +2252,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
         object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
                                 (i == 2) ? 1 : 4, &error_fatal);
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
+                                chip->chip_id, &error_fatal);
         if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
                                         (&chip10->pib_spic[i])), errp)) {
             return;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index de33542c35..83221607c9 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1147,14 +1147,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
 
 static const Property pnv_spi_properties[] = {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
     DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
 };
 
 static void pnv_spi_realize(DeviceState *dev, Error **errp)
 {
     PnvSpi *s = PNV_SPI(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
-                    s->spic_num);
+    g_autofree char *name = g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS ".%d",
+                    s->chip_id, s->spic_num);
     s->ssi_bus = ssi_create_bus(dev, name);
     s->cs_line = g_new0(qemu_irq, 1);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 9878d9a25f..6adb72dbb2 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
 #define PNV_SPI_REG_SIZE 8
 #define PNV_SPI_REGS 7
 
-#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
+#define TYPE_PNV_SPI_BUS "spi"
 typedef struct PnvSpi {
     SysBusDevice parent_obj;
 
@@ -42,6 +42,7 @@ typedef struct PnvSpi {
     Fifo8 rx_fifo;
     /* SPI object number */
     uint32_t        spic_num;
+    uint32_t        chip_id;
     uint8_t         transfer_len;
     uint8_t         responder_select;
     /* To verify if shift_n1 happens prior to shift_n2 */
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 57f20af76e..600493c425 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
     qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
                       "threads=1 -accel tcg,thread=single -nographic "
                       "-blockdev node-name=pib_spic2,driver=file,"
-                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+                      "filename=%s -device 25csm04,bus=chip0.spi.2,cs=0,"
                       "drive=pib_spic2", tmp_path);
     spi_seeprom_transaction(qts, chip);
     qtest_quit(qts);
-- 
2.47.1


