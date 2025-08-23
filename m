Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980BECA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uppmG-00083R-MD; Sat, 23 Aug 2025 11:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1uppmF-000836-Mm; Sat, 23 Aug 2025 11:03:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1uppmD-0001oT-SM; Sat, 23 Aug 2025 11:03:31 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6188b793d21so4458932a12.3; 
 Sat, 23 Aug 2025 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755961408; x=1756566208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K19s5V0xXJ2VOusRN6qnztbZhcszJzpGVXtdaGk9hRY=;
 b=fMUo65XyTUqy7sHchD9ILbHKCuhdW1E7u6wOoGgh7AKzljE2qsOimbtFKF7r8pXQQn
 lPe0GuC152GTHAg5ng3VZBMcjGbCrjUVXzHa2+0I3Eq4v3L+NFAyCF7wSnABKPLVw4jV
 yc6z1arhqmOV4C+KGurFAdkkR/21mKY8NeE1wh8B+5SVIQAjCi9kOcThkGw74NZXll2Z
 M2zuhMm3V2eTeOOenXJikoAMiRMy6sp6z8N1+recWbk6gIogHHHbTcVKZ9LbYchiKrA6
 sOA+vczknP7GAUJj05KIMUACvl19seQ6tNhk2oZLSPk+hgvns2JirrbhkC7HPx6P2Dsy
 TgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755961408; x=1756566208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K19s5V0xXJ2VOusRN6qnztbZhcszJzpGVXtdaGk9hRY=;
 b=XOndvUocY/RGz/iJJK42CazbghxosOIE4c2evHR2K77a5H6NicVpOl16H/sW8sbMrC
 3IkuWouUGQKWKGj2Gyk7+bpD119RVOzyiFGOMOqiuNRiVTuRQdQwovJe6YtONGOKScSF
 FtfPBdCMgbcRSxY1SZF47mAvjYUwHWGuY1n5nhgY8XTXVqIC4hPah0nAAjiY1mujnIEs
 JzNMxPBrz7IjSput2+dWohdfS1zG8Tgsoo50OFYZsZeCe1z6HtH8vWcPf5hgmf5Gu9RM
 /UnhUiCO2LnQbdg+vat1VXe2J2KNJ4qd0gAu5v/Ug8vRw6IajRloridBmXBMAXa21Zfx
 I0FA==
X-Gm-Message-State: AOJu0YzeZppwxInroQDlBPIhjTlXflUmqgOHmNLtIKXdbvM5SVjMpD7Y
 20vnB8ZbsB7qrnYOe0K9gcygTdzIcBXvTAxHs9GEXp+4/xGvBkjfHJOYiD5d3J4c8wY=
X-Gm-Gg: ASbGnctXCrVAdn+S1kj58r/6joqUFKsJwKyJ3bxANEhJXRkbB6NLANoUyiraBoA8nNg
 Ii8mj9h0oU+jJq7Mlfdct6R5r8/zpzBUCGPWFiEjMwytGKQ8NhMDqKmAaRyn1zlOPvDnsp4Gkjp
 aoo/tJx4vJRCAA3RQl8Y8oTEKfE8UlH39MWebPWBkPZ+3+fArWR7LanazL7aYAY82zmIqJ+m3Ek
 kLjHD853elHGXsL6wIAyLMrpqosU9a72OfSKHryZFHqj5GZzndsODwnH0DiuV4r3NnEeRRyzh7d
 Hywo2HVsuBAue/d0Pkk7eqqIkawCjGas9+VyO7ouKUwjJMIP8/sFFFa0G1Nxb519aukSdB1XfmA
 XXMfFEEKC8SK8nzyeZ5OC5/Rd6ToT+v/tQWBL+4q8zd13iIETv3hVZPI5xUI0PMfDRIS8FrV4O2
 OwGvk=
X-Google-Smtp-Source: AGHT+IE2CSBNHWh0boRax4nI2w1pfz0xLf+5/jvO7ae+tzUUOoQOChEamnS0xMEwCNq30ul3hmO7Cg==
X-Received: by 2002:a05:6402:2708:b0:61c:4338:29be with SMTP id
 4fb4d7f45d1cf-61c43382f8amr969520a12.26.1755961407381; 
 Sat, 23 Aug 2025 08:03:27 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:2cf0:7750:e21:c9b7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61c312aeb15sm1627848a12.19.2025.08.23.08.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 08:03:25 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/arm/boot: replace fprintf with error_report
Date: Sat, 23 Aug 2025 17:03:21 +0200
Message-ID: <20250823150321.135527-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ed1-x52e.google.com
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

Replace direct fprintf(stderr, …) with QEMU's error_report() API,
which ensures consistent formatting and integrates with QEMU's
logging infrastructure.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/arm/boot.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb..17c744762f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -531,13 +531,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
+            error_report("Couldn't open dtb file %s", binfo->dtb_filename);
             goto fail;
         }
 
         fdt = load_device_tree(filename, &size);
         if (!fdt) {
-            fprintf(stderr, "Couldn't open dtb file %s\n", filename);
+            error_report("Couldn't open dtb file %s", filename);
             g_free(filename);
             goto fail;
         }
@@ -545,7 +545,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     } else {
         fdt = binfo->get_dtb(binfo, &size);
         if (!fdt) {
-            fprintf(stderr, "Board was unable to create a dtb blob\n");
+            error_report("Board was unable to create a dtb blob");
             goto fail;
         }
     }
@@ -564,7 +564,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
     if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        error_report("dtb file invalid (#address-cells or #size-cells 0)");
         goto fail;
     }
 
@@ -572,8 +572,8 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         /* This is user error so deserves a friendlier error message
          * than the failure of setprop_sized_cells would provide
          */
-        fprintf(stderr, "qemu: dtb file not compatible with "
-                "RAM size > 4GB\n");
+        error_report("qemu: dtb file not compatible with "
+                "RAM size > 4GB");
         goto fail;
     }
 
@@ -611,7 +611,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
             rc = fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
             if (rc < 0) {
-                fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
+                error_report("couldn't add /memory@%"PRIx64" node",
                         mem_base);
                 goto fail;
             }
@@ -622,7 +622,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
                                  scells, binfo->ram_size, -1);
         if (rc < 0) {
-            fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
+            error_report("couldn't add /memory@%"PRIx64" node",
                     binfo->loader_start);
             goto fail;
         }
@@ -637,7 +637,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                                      ms->kernel_cmdline);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+            error_report("couldn't set /chosen/bootargs");
             goto fail;
         }
     }
@@ -646,7 +646,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         rc = qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-start",
                                           acells, binfo->initrd_start);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n");
+            error_report("couldn't set /chosen/linux,initrd-start");
             goto fail;
         }
 
@@ -655,7 +655,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                                           binfo->initrd_start +
                                           binfo->initrd_size);
         if (rc < 0) {
-            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
+            error_report("couldn't set /chosen/linux,initrd-end");
             goto fail;
         }
     }
-- 
2.43.0


