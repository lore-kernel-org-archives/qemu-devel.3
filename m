Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A28C61CE8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 01:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOnnW-0006If-9B; Mon, 09 Jun 2025 21:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uOnnP-0006Hb-6F; Mon, 09 Jun 2025 21:28:59 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uOnnN-0000vF-0N; Mon, 09 Jun 2025 21:28:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1fde81de05so2517194a12.1; 
 Mon, 09 Jun 2025 18:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749518934; x=1750123734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=T9SthefEJFHd7s87DbKziowNRxFrFx5qSbcsBCc4yBk=;
 b=GQaf67U/KXB1CYs9Sy5XQT2NbrXRVQThmNDuAv6ZwBhKyKVddXQUu4a9L3u5lmpihI
 lRimuANESdye3E3hL00NjPNq/G7k16SMKHN5GnAVPtXP0zlzVYcaZF61LmvQq/Tpoumx
 uW7B5Rm4+SAOqmvgTfhX+BGpBjdbAPRin3hnHoX1XCQx/3QegEISp+m5pTRvHnVt+m+n
 ZnD6OYOWnxXAaJlBucUT4wavj7C9E+Tpi9bwOuTOZHA6z+1RPZruIBjpeGhc0Qjno1Ee
 hlYtloIVFbaORHObmke/Kxtb3p+KL6Vl2ixyBZvTPYsdxaVF4Llw6z6WBHUsQGqQSxC0
 1e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749518934; x=1750123734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9SthefEJFHd7s87DbKziowNRxFrFx5qSbcsBCc4yBk=;
 b=Rxem4mR0fjx72xvGW8P9iXUG5ox+GX+RvMlT3yOjXcsvaoK7K7FRUD5oim/lhAnRvJ
 Vmmm44ZoDPHQVL2eRh2pFI+F6sLb2quX3Dzd2SyFlHEr38q5TIoB+Ktggvn2FRljmiWf
 qRzzquG6qqUPBqKp71M5nvOUUbt3qs/LxfMx9hdZb2iHq5NWJBlb3hGRs7xEsFpZ8MJB
 jvsPHCMxpBTZrgNEBzXM9+HyUoWz+qNK83iU5l4RGIBpQ5WfvqcfOpk0jD+Xx1Kgp9dU
 1FzngpEubss8XpILzFmcBGa/51lgrebmrMII1RQA4+R1CWZrl07v+da1htXuAmi+bO+U
 Q3NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSQDzmTV7KWklfbiY9Mtl3YR4kLB0b4BnJTHs/L6dat+jdhgfx00Ecz/gs0Dx6QWjcXSTRZIXF8w==@nongnu.org,
 AJvYcCXd5KGUlYl/CAdSWJtDeMYT3V+hT57La/lMsEssaLbDCS67cykTvKWd42TK3oQHD+TZX2BL4JosFzSVhw==@nongnu.org
X-Gm-Message-State: AOJu0Ywu2tGF6Qa1hTXA8uFBK8TFllKPPMBiUZrwMn6UemLeb/fI72dU
 iGbeBkjNxlOtbUAIcwhWhJKuUiiIWBY4Un8+rVBX2gP3xGM0hpHKIgTI
X-Gm-Gg: ASbGncsvyZq+pWTuE50dqpsHjOQ7wqKWOWP2lfCiW+ywFtYdSdaaIrJaa0RheCepwuK
 XJkoma23aUQg/nkB4D/uVV/6PAyn5bUHd+Lp3alkikHKrGlgPnc3UqGJ9jIpoz2+BCDdD0bxvCY
 HThkAY/AkEIaBVgwRGLRVDr10WE1QEbi8TrLaGEUcUaPoV9bA7TmFvORW0e1pgTvT++VpqZB18G
 Li6a87ubAlqLn14R0/PfL9rwBwk+P7gxpR2foiFkUdNvWSSmz654O/O/7psC/Xu+1PPQvb8hjYl
 zNgGvk2ImvyTEshlegmDDOue8ky9Nw0ykEdtlfZgKVtHXvNFS5BzLCdNxIKAveksGySx77227t4
 =
X-Google-Smtp-Source: AGHT+IFsvRdfBGxzI2MA9x7SDJEj8zKFFYzlnqnznt7E2UWXpjQOgq3lipRMyx9PlGDnTeS3H92lLw==
X-Received: by 2002:a17:90b:5383:b0:313:220c:b63b with SMTP id
 98e67ed59e1d1-3134769f727mr21043945a91.35.1749518934522; 
 Mon, 09 Jun 2025 18:28:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603078007sm60998795ad.44.2025.06.09.18.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 18:28:53 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Tyrone Ting <kfting@nuvoton.com>
Cc: Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hw/arm/npcm7xx_boards: Add support for specifying SPI flash
 model
Date: Mon,  9 Jun 2025 18:28:51 -0700
Message-ID: <20250610012851.1627715-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.097, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In some situations it is desirable to be able to specify the flash type
connected to a board. For example, the target operating system may not
support the default flash type, its support may be broken, or the qemu
emulation is insufficient and the default flash is not detected.
On top of that, the ability to test various flash types improves
testability since a single emulated board can be used to test a variety
of flash chips with the controller supported by that board.

The aspeed emulation supports an option to specify the flash type. Use
the same mechanism to configure the flash type for Nuvoton 7xx boards.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I don't know if there is interest in this, but I figured I should at least
submit it. Background is that Macronix flash support is broken when running
upstream Linux v6.16-rc1, thanks to upstream Linux commit 947c86e481a027e
("mtd: spi-nor: macronix: Drop the redundant flash info fields"). I needed
a workaround, and using a different flash model was the easiest solution. 

 hw/arm/npcm7xx_boards.c  | 49 +++++++++++++++++++++++++++++++++-------
 include/hw/arm/npcm7xx.h |  1 +
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 465a0e5ace..88b9aeddd4 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -363,6 +363,7 @@ static void kudo_bmc_i2c_init(NPCM7xxState *soc)
 
 static void npcm750_evb_init(MachineState *machine)
 {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(machine);
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
@@ -370,14 +371,16 @@ static void npcm750_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
+    npcm7xx_connect_flash(&soc->fiu[0], 0, ms->spi_model ? : "w25q256",
+                          drive_get(IF_MTD, 0, 0));
     npcm750_evb_i2c_init(soc);
-    npcm750_evb_fan_init(NPCM7XX_MACHINE(machine), soc);
+    npcm750_evb_fan_init(ms, soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
 static void quanta_gsj_init(MachineState *machine)
 {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(machine);
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
@@ -385,15 +388,16 @@ static void quanta_gsj_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+    npcm7xx_connect_flash(&soc->fiu[0], 0, ms->spi_model ? : "mx25l25635e",
                           drive_get(IF_MTD, 0, 0));
     quanta_gsj_i2c_init(soc);
-    quanta_gsj_fan_init(NPCM7XX_MACHINE(machine), soc);
+    quanta_gsj_fan_init(ms, soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
 static void quanta_gbs_init(MachineState *machine)
 {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(machine);
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, QUANTA_GBS_POWER_ON_STRAPS);
@@ -402,7 +406,7 @@ static void quanta_gbs_init(MachineState *machine)
 
     npcm7xx_load_bootrom(machine, soc);
 
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx66u51235f",
+    npcm7xx_connect_flash(&soc->fiu[0], 0, ms->spi_model ? : "mx66u51235f",
                           drive_get(IF_MTD, 0, 0));
 
     quanta_gbs_i2c_init(soc);
@@ -412,6 +416,7 @@ static void quanta_gbs_init(MachineState *machine)
 
 static void kudo_bmc_init(MachineState *machine)
 {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(machine);
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, KUDO_BMC_POWER_ON_STRAPS);
@@ -419,9 +424,9 @@ static void kudo_bmc_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx66u51235f",
+    npcm7xx_connect_flash(&soc->fiu[0], 0, ms->spi_model ? : "mx66u51235f",
                           drive_get(IF_MTD, 0, 0));
-    npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
+    npcm7xx_connect_flash(&soc->fiu[1], 0, ms->spi_model ? : "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
     kudo_bmc_i2c_init(soc);
@@ -431,6 +436,7 @@ static void kudo_bmc_init(MachineState *machine)
 
 static void mori_bmc_init(MachineState *machine)
 {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(machine);
     NPCM7xxState *soc;
 
     soc = npcm7xx_create_soc(machine, MORI_BMC_POWER_ON_STRAPS);
@@ -438,7 +444,7 @@ static void mori_bmc_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm7xx_load_bootrom(machine, soc);
-    npcm7xx_connect_flash(&soc->fiu[1], 0, "mx66u51235f",
+    npcm7xx_connect_flash(&soc->fiu[1], 0, ms->spi_model ? : "mx66u51235f",
                           drive_get(IF_MTD, 3, 0));
 
     npcm7xx_load_kernel(machine, soc);
@@ -453,6 +459,27 @@ static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type)
     mc->default_cpus = mc->min_cpus = mc->max_cpus = sc->num_cpus;
 }
 
+static char *npcm7xx_get_spi_model(Object *obj, Error **errp)
+ {
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(obj);
+    return g_strdup(ms->spi_model);
+}
+
+static void npcm7xx_set_spi_model(Object *obj, const char *value, Error **errp)
+{
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(obj);
+
+    g_free(ms->spi_model);
+    ms->spi_model = g_strdup(value);
+}
+
+static void npcm7xx_machine_finalize(Object *obj)
+{
+    NPCM7xxMachine *ms = NPCM7XX_MACHINE(obj);
+
+    g_free(ms->spi_model);
+}
+
 static void npcm7xx_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -466,6 +493,11 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, const void *data)
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
     mc->valid_cpu_types = valid_cpu_types;
+
+    object_class_property_add_str(oc, "spi-model", npcm7xx_get_spi_model,
+                                  npcm7xx_set_spi_model);
+    object_class_property_set_description(oc, "spi-model",
+                                          "Change the SPI Flash model");
 }
 
 /*
@@ -542,6 +574,7 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = TYPE_NPCM7XX_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(NPCM7xxMachine),
+        .instance_finalize = npcm7xx_machine_finalize,
         .class_size     = sizeof(NPCM7xxMachineClass),
         .class_init     = npcm7xx_machine_class_init,
         .abstract       = true,
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 56536565b7..e8844956db 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -62,6 +62,7 @@ struct NPCM7xxMachine {
      */
     SplitIRQ            fan_splitter[NPCM7XX_NR_PWM_MODULES *
                                      NPCM7XX_PWM_PER_MODULE];
+    char *spi_model;
 };
 
 #define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
-- 
2.45.2


