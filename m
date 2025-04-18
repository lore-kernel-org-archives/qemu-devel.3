Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE7C369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zx9-0001p3-1o; Thu, 17 Apr 2025 20:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zx6-0001om-LJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zx2-0005t5-JQ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso925190f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937487; x=1745542287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV8KJV0xXZ4TO2mnmTIb3sgdLgRIDuDlODWFeGQ6aQY=;
 b=N3vxloPYlS9q6zujsh44qcMV28WR/m3o5noKHEThaQcK3ve0WNJahOftyvmT3r7wmL
 aVJ0zgCJugF/5Ez1CznMk0jbhyVzMtdupuNvxTu/WETrEgACzAgStFKMqRvFwrYu2Vv3
 rONRFcdeRfgX0n9MTnm1q3YpNfzErPVMgslNZasGVStV+RCre4TcVxkX4VpGpEeFYwDU
 xULuM+h3BN6G+WXSyHpJ6VpF12V/N8Ie4UMJVBdQ79mTC6VyvSNwbQ+JDwcp7vu/DmeC
 zQbArAdV8Hzl1eNy5PTDY4sHYf0ZCbdrcmjQMzF3JFx6m8eHoGq+Q1anZ/85oLshSpl7
 3gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937487; x=1745542287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV8KJV0xXZ4TO2mnmTIb3sgdLgRIDuDlODWFeGQ6aQY=;
 b=YS2c7EFpLiqk962d5ArOfBCwHX5XO5CzydAg8fxILSOuMCoRz1xds6Bdm4lX97TFv7
 citF4aI2XAAFDlUvrY4FPWnMHne7PYjB9MgA+SZHynanDHPyxVv8Bb2x+eqw4B5pEeoW
 VFz/dxCPjnvxCGjdOJE+4S3syaX52siUnYA0FHjjFa6m7QLpRIXRbQSfIxiuibP9qifs
 MJRMAKSPLfYqnex7nx15DLycIpvTSqb/EsQgInrfY/UHX4iQNRpVMY2YTUYkzndm+BGS
 CXqA3jsL3ZMhQvpqRKStI7jTf/0cf+H35tNTJvhCvN9i9vxl+17Xt0t63XWVQSzRJ8Pv
 /gtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvpUtsL19p9Ro+QaUeRTcVpo+rk7MiOKjegyofWsNC9dzaiA1ArV9TWuN5cOljeAeKkhhy3rcj8SM5@nongnu.org
X-Gm-Message-State: AOJu0Yy5YyOWg7cWeFduoGqUNLC9vpTFgG7ZVVLMTDmWbZI4nR63tfwn
 d9oHJYVBl8VloVE12h2ODvtIyXud/u5d6ju9eTD1Oh9TDfPLuJ1jyX40r6+Cc+8=
X-Gm-Gg: ASbGnctQL9MDuAl6xTuiB5T9WesL1Y37dvtrX6bE5+UKBTSj+5pK+bPOMlo0/kfU0VO
 ryepj/C+xCYpEWGU+b/t2FiXIlcLVY4LOO0ugQ06PD8bBpMqSy7FfkOJuzRfzeDrq015P125+fT
 VlG5MR0ndwHbuV5cq9UeNkmkD+E10r4kfWvKwp7eMQ/knna1D61WPeELDatEGsCVnEL9b8iL+uQ
 wcJAiiW6QGV2y9KosknEDg2yg8BjKfLrD83aPISXR6KW17K1F3HWt/MprARHp4aDR4/y6CQ8a5A
 eQ0PlTV2r3+4Azfqj44qRwB8krymKzxm7Yaw9tDOlQCCZ4mYCGpP4o+j8WgMH0+2qIVgfJsNny8
 XoF2vr3Pf56wi3wYl8Q4nHbSbfJBbcVY=
X-Google-Smtp-Source: AGHT+IHs0+NWwgo4AVBXY3+lcgi4oCbOvjVDwdDAOmLbf6mkEx6YSDTr1UVUyVPZJqIIS4D7MCT42w==
X-Received: by 2002:a5d:5c84:0:b0:397:8ef9:9963 with SMTP id
 ffacd0b85a97d-39efbb092e4mr604035f8f.55.1744937486746; 
 Thu, 17 Apr 2025 17:51:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d22esm1183287f8f.52.2025.04.17.17.51.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 05/11] hw/arm: Filter machine types for
 qemu-system-aarch64 binary
Date: Fri, 18 Apr 2025 02:50:53 +0200
Message-ID: <20250418005059.4436-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since the qemu-system-aarch64 binary is able to run
all machines indistinctly, simply register the
TYPE_TARGET_AARCH64_MACHINE interface for all
existing machines under the hw/arm/ directory.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c            | 88 ++++++++++++++++++++++++++++++++++++++
 hw/arm/b-l475e-iot01a.c    |  4 ++
 hw/arm/bananapi_m2u.c      |  4 ++
 hw/arm/collie.c            |  4 ++
 hw/arm/cubieboard.c        |  4 ++
 hw/arm/digic_boards.c      |  4 ++
 hw/arm/exynos4_boards.c    |  8 ++++
 hw/arm/fby35.c             |  4 ++
 hw/arm/highbank.c          |  8 ++++
 hw/arm/imx25_pdk.c         |  4 ++
 hw/arm/imx8mp-evk.c        |  4 ++
 hw/arm/integratorcp.c      |  4 ++
 hw/arm/kzm.c               |  4 ++
 hw/arm/mcimx6ul-evk.c      |  4 ++
 hw/arm/mcimx7d-sabre.c     |  4 ++
 hw/arm/microbit.c          |  4 ++
 hw/arm/mps2-tz.c           | 16 +++++++
 hw/arm/mps2.c              | 16 +++++++
 hw/arm/mps3r.c             |  4 ++
 hw/arm/msf2-som.c          |  4 ++
 hw/arm/musca.c             |  8 ++++
 hw/arm/musicpal.c          |  4 ++
 hw/arm/netduino2.c         |  4 ++
 hw/arm/netduinoplus2.c     |  4 ++
 hw/arm/npcm7xx_boards.c    | 20 +++++++++
 hw/arm/npcm8xx_boards.c    |  4 ++
 hw/arm/olimex-stm32-h405.c |  4 ++
 hw/arm/omap_sx1.c          |  8 ++++
 hw/arm/orangepi.c          |  4 ++
 hw/arm/raspi.c             | 20 +++++++++
 hw/arm/raspi4b.c           |  4 ++
 hw/arm/realview.c          | 16 +++++++
 hw/arm/sabrelite.c         |  4 ++
 hw/arm/sbsa-ref.c          |  4 ++
 hw/arm/stellaris.c         |  8 ++++
 hw/arm/stm32vldiscovery.c  |  4 ++
 hw/arm/versatilepb.c       |  8 ++++
 hw/arm/vexpress.c          |  8 ++++
 hw/arm/virt.c              |  4 ++
 hw/arm/xilinx_zynq.c       |  4 ++
 hw/arm/xlnx-versal-virt.c  |  4 ++
 hw/arm/xlnx-zcu102.c       |  4 ++
 42 files changed, 348 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 82f42582fa3..ca7004c335a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1760,91 +1760,179 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fp5280g2_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a0_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
         }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c9a5209216c..cc4b9d6c3b5 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -131,6 +131,10 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 724ee4b05e5..d9871a796bb 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -150,6 +150,10 @@ static const TypeInfo bananapi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("bpim2u"),
         .parent         = TYPE_MACHINE,
         .class_init     = bpim2u_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index e83aee58c6b..16e862e15b6 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -86,6 +86,10 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 36062ac7037..dd40d65554d 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -131,6 +131,10 @@ static const TypeInfo cubieboard_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("cubieboard"),
         .parent         = TYPE_MACHINE,
         .class_init     = cubieboard_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 3c0cc6e4370..f55309082ac 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -152,6 +152,10 @@ static const TypeInfo digic_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("canon-a1100"),
         .parent         = TYPE_MACHINE,
         .class_init     = digic_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2d8f2d73265..b55e364d962 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -172,6 +172,10 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void smdkc210_class_init(ObjectClass *oc, void *data)
@@ -192,6 +196,10 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 6d3663f14a1..de6b32ce532 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -187,6 +187,10 @@ static const TypeInfo fby35_types[] = {
         .class_init = fby35_class_init,
         .instance_size = sizeof(Fby35State),
         .instance_init = fby35_instance_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 0f3c207d548..e517cf3c7f6 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -363,6 +363,10 @@ static const TypeInfo highbank_type = {
     .name = MACHINE_TYPE_NAME("highbank"),
     .parent = TYPE_MACHINE,
     .class_init = highbank_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void midway_class_init(ObjectClass *oc, void *data)
@@ -387,6 +391,10 @@ static const TypeInfo midway_type = {
     .name = MACHINE_TYPE_NAME("midway"),
     .parent = TYPE_MACHINE,
     .class_init = midway_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void calxeda_machines_init(void)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a90def7f1a2..da8479ca608 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -157,6 +157,10 @@ static const TypeInfo imx25_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("imx25-pdk"),
         .parent         = TYPE_MACHINE,
         .class_init     = imx25_pdk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index c7d87d99230..bc8a3abd04a 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -79,6 +79,10 @@ static const TypeInfo imx8_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("imx8mp-evk"),
         .parent         = TYPE_MACHINE,
         .class_init     = imx8mp_evk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f95916b517d..5599cf60707 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -760,6 +760,10 @@ static const TypeInfo integratorcp_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("integratorcp"),
         .parent         = TYPE_MACHINE,
         .class_init     = integratorcp_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b56cabe9f94..208546205be 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -146,6 +146,10 @@ static const TypeInfo kzm_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("kzm"),
         .parent         = TYPE_MACHINE,
         .class_init     = kzm_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index d947836d2be..65e6134862e 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -84,6 +84,10 @@ static const TypeInfo imx6_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("mcimx6ul-evk"),
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx6ul_evk_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index f5dc9c211dd..1f88dc03915 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -84,6 +84,10 @@ static const TypeInfo imx7_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("mcimx7d-sabre"),
         .parent         = TYPE_MACHINE,
         .class_init     = mcimx7d_sabre_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index ade363daaa4..e537735e247 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -74,6 +74,10 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index b0633a5a69e..6cd36ee4037 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1463,24 +1463,40 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 6958485a668..709d7d0a08e 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -563,24 +563,40 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4dd1e8a7180..d1a72c7775b 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -634,6 +634,10 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 6ce47eaa27a..11988b6aa6d 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -114,6 +114,10 @@ static const TypeInfo msf2_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("emcraft-sf2"),
         .parent         = TYPE_MACHINE,
         .class_init     = emcraft_sf2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index a4f43f1992b..3a11b3d1cd6 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -657,12 +657,20 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f7c488cd1d6..9cf8eec8b13 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1381,6 +1381,10 @@ static const TypeInfo musicpal_types[] = {
         .name           = MACHINE_TYPE_NAME("musicpal"),
         .parent         = TYPE_MACHINE,
         .class_init     = musicpal_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 52c30055d44..e6e140ed6bf 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -71,6 +71,10 @@ static const TypeInfo netduino_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("netduino2"),
         .parent         = TYPE_MACHINE,
         .class_init     = netduino2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 2735d3a0e2b..b54e990b5bd 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -71,6 +71,10 @@ static const TypeInfo netduino_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("netduinoplus2"),
         .parent         = TYPE_MACHINE,
         .class_init     = netduinoplus2_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index eb28b97ad83..4d2c52f3422 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -549,22 +549,42 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 3fb8478e72e..1b5a3080436 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -248,6 +248,10 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+                { TYPE_TARGET_AARCH64_MACHINE },
+                { },
+        },
     },
 };
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 795218c93cf..4344bef4db1 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -77,6 +77,10 @@ static const TypeInfo olimex_stm32_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("olimex-stm32-h405"),
         .parent         = TYPE_MACHINE,
         .class_init     = olimex_stm32_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index aa1e96b3ad7..9f90f95b9ee 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -219,6 +219,10 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
@@ -238,6 +242,10 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 6821033bfd7..f539b2fc3a4 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -130,6 +130,10 @@ static const TypeInfo orangepi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("orangepi-pc"),
         .parent         = TYPE_MACHINE,
         .class_init     = orangepi_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dce35ca11aa..b8b947bc29e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -394,23 +394,43 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index f6de103a3e1..8074cd80b4d 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -127,6 +127,10 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .interfaces     = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 008eeaf049a..2ccee583117 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -431,6 +431,10 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
@@ -452,6 +456,10 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
@@ -471,6 +479,10 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
@@ -491,6 +503,10 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ea59ba301e7..a4c1dd7edc1 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -120,6 +120,10 @@ static const TypeInfo sabrelite_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("sabrelite"),
         .parent         = TYPE_MACHINE,
         .class_init     = sabrelite_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index aa09d7a0917..138b8a4bf7f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -920,6 +920,10 @@ static const TypeInfo sbsa_ref_info = {
     .instance_init = sbsa_ref_instance_init,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index cbe914c93e9..1e696e25c42 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1427,6 +1427,10 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 /*
@@ -1448,6 +1452,10 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 3a9728ca719..7c267fd880b 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -74,6 +74,10 @@ static const TypeInfo stm32vldiscovery_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("stm32vldiscovery"),
         .parent         = TYPE_MACHINE,
         .class_init     = stm32vldiscovery_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 35766445fa4..4c71a73b3b1 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -431,6 +431,10 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versatileab_class_init(ObjectClass *oc, void *data)
@@ -452,6 +456,10 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 76c6107766c..fad4a9b8cfa 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -850,6 +850,10 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -857,6 +861,10 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a4..41918eb760b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -123,6 +123,10 @@ static void arm_virt_compat_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .interfaces = (InterfaceInfo[]) { \
+            { TYPE_TARGET_AARCH64_MACHINE }, \
+            { }, \
+        }, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index b8916665ed6..efcbddffda0 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -480,6 +480,10 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0c6f0359e3d..89fd79f81e3 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -833,6 +833,10 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
     .instance_finalize = versal_virt_machine_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4fdb153e4d8..1ca4ac6a675 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -303,6 +303,10 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { },
+    },
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.47.1


