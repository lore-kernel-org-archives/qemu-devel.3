Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B956CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 20:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utXIq-0008E0-6S; Tue, 02 Sep 2025 16:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utXIn-0008Ce-OP; Tue, 02 Sep 2025 16:08:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utXIl-0003it-Rh; Tue, 02 Sep 2025 16:08:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-619487c8865so436790a12.1; 
 Tue, 02 Sep 2025 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756843702; x=1757448502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKd1XHDV2EvXhIOSy5Pt7wF/kR7LXei0Yk0zA6T493o=;
 b=LDMDh2MwN/gIKgcGZ5BcH6DfuPrNgWinTzg0xJ8xUyTsL53Rw2/d1AwiGq+a++5Lyu
 yW0xArWut6JK6jZOStp81+szfAOYtwjBiEKvJnW3e4A3c7MybrPLBn9ZA1usbvqkQz/A
 1Ikt/NDaEqbamdjLbgUQB6+K2g8PKqHCCIY12iKuDNjZ8q6uJSzSL6YlJlF3oqw8t4Nk
 /Bzih9FMTsDmvu6DDFpb4D1bwEZHGBFDASO5U1YmHIgxM0yQWNTP2u1noVdNmbrsfeMh
 5Ykg9XiiMZa+ewXj9I3KhEpAL5FXJI2bLSO2bmRow6sDPuzpQk0sdy9L7vw1pbqwCaby
 HAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756843702; x=1757448502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKd1XHDV2EvXhIOSy5Pt7wF/kR7LXei0Yk0zA6T493o=;
 b=u9ArjWqOfdDEwo+sEdwzmzBw8kK1HfhX9/hDy6a51mZM2eF9FUWOa1kz4BPgTx+i2z
 drAiml8TxcPV93kxFbixYySKEGqo0abqQ5WL1LpwHG/ZE7RL/DsIk//C1+0kHZpzFDFl
 dsX5hmuXUH3hMaLITgg/IKMni689JuQxPPFnPSICUQybUctIv4OjazKK1d+eAQYPNuv2
 l1CHQ1Vdsw2QPfYLr1Ug9/ULKKQvgHKAbDJs2uSnFo9m2bMdS712uskfQ66FuDA1+nll
 vQXbMKVTBXkyjOp+wScU5ZuJDwUfOOY7MO1VTB6ZBH6vJGxofB/YlFbJNBCnrB7vB87Q
 SiMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvViUoyM4TxYBFivoI8Iwa5hFnPGrpK6SZEMdUS8PYolvywkTaYIXNByE5ucM3BfwELFrW233VrQzN@nongnu.org
X-Gm-Message-State: AOJu0Yw+Cu2/xNaqDXHGuGfn4T7HOwkeqZ9X93BqBxb0rgpIy7ZEezXb
 QF33G4p+Wxb4WLy90NpHh3RKBdB3r3SO6jKQOO9cmXOcHBtrFWlwSCXJ
X-Gm-Gg: ASbGncsBqbBw3FqvFnN3ll1Evw8VXRonxqccuv1/+KDdL5qRuTzwvcBx8eIktuSo2Ut
 j+GnVpnFH4/k6C6+vkPpthVAW05+O/l6Bx1HZn5f7w+ibfcK+HpWP8iuUM+Cw2tpaWBhoOV4ix7
 PHDfy7nbFI2dbkozrNXtrOaVFM/KzB6hRBKYKs7RqkDgo0n7tRZ+d4eVtwtWCchAwP3gdMW0ytg
 FsfKUBjPzMc/mwi5n17M/jja0ZhY5BenrA/WhT1YdxYLV0jKI4Wh0DLV7iFcnJHOyD8yfv7d/PM
 3S+jtFcIJqQt+sE+JaI3qwGaOzcUTBkBt16mfUEJWC678Sm/p+R5J2t2UafN3p01Z7TSrTUXM0a
 K8/yReTEfHPWkrCqPOoJ7Kljgc6RB1CEK3xHyp/FUpoAPec6paRCBDJhnELc4vE7S4tsRv3SNdk
 jFv3YHed7EOQFII+I5I/ZsoZmkRYMb
X-Google-Smtp-Source: AGHT+IGMSFkHldteP02jEBzIDQMvnblPr99tuzzeHLRlEO1QOh31lcKlOvP5Wm+TnXjYIqLvUOjzRw==
X-Received: by 2002:a17:907:807:b0:afe:d4b0:c0bf with SMTP id
 a640c23a62f3a-b01082b1481mr1424612866b.17.1756843701703; 
 Tue, 02 Sep 2025 13:08:21 -0700 (PDT)
Received: from osama.. ([2a02:908:1b0:afe0:b388:5893:2f33:1927])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b02152cc1b8sm895699666b.36.2025.09.02.13.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 13:08:21 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: peter.maydell@linaro.org,
	alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/arm/raspi4b: remove redundant check in
 raspi_add_memory_node
Date: Tue,  2 Sep 2025 22:08:18 +0200
Message-ID: <20250902200818.43305-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ed1-x532.google.com
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

The if (acells == 0 || scells == 0) check is redundant in
raspi_add_memory_node, since it is already checked in the call
chain, arm_load_dtb. Also the return value of the function is
not checked/used so it's removed.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/arm/raspi4b.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 20082d5266..4df951a0d8 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -36,9 +36,8 @@ struct Raspi4bMachineState {
  * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
  * 1.2 Address Map)
  */
-static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
+static void raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
 {
-    int ret;
     uint32_t acells, scells;
     char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
 
@@ -46,19 +45,16 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
                                    NULL, &error_fatal);
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
-    if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
-        ret = -1;
-    } else {
-        qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                           acells, mem_base,
-                                           scells, mem_len);
-    }
+    /* validated by arm_load_dtb */
+    g_assert(acells && scells);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                        acells, mem_base,
+                                        scells, mem_len);
 
     g_free(nodename);
-    return ret;
 }
 
 static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
-- 
2.43.0


