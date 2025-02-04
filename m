Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650AEC02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7d-0004nH-UT; Tue, 04 Feb 2025 04:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7c-0004ml-M8; Tue, 04 Feb 2025 04:21:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7a-00053l-Sg; Tue, 04 Feb 2025 04:21:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43635796b48so32681335e9.0; 
 Tue, 04 Feb 2025 01:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660888; x=1739265688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tANkBi6sQeQ6AT/ajHf/OcJmWhoX7n1olSXdynh3fXk=;
 b=LBf5Ex4MUiEeiB1RX0DnCA8sDBtWY3m27X/IJyW3WCwVDaloSLF9DAaDTnn/OPHwuK
 HuOPpCFhZQyEXmapWKh3B9/492y43bBExqij5RLGkiQv9i/A8/Zeo3G4+8x4W2rePgGF
 IVwLLuUkCXIr+9qe00w7T0iUVpXR0gHVxbmNbtZn9gNL5eIr4xHFxySJKWHxCNog7ZH2
 QlunYHiZJjwjsU4j++/KAJXmAJSA9MTt66vvSycQLPUK0OdLbQenAdITQtRy4UAdlsv1
 XAmWNSstaI6tfUbSwj2ui7P3W5N/7FirWSVJZYZZEHgN0U6jKZ7vogHOwf3QWRCYonym
 UIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660888; x=1739265688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tANkBi6sQeQ6AT/ajHf/OcJmWhoX7n1olSXdynh3fXk=;
 b=GQxoguvFydfnoYO1LapDWYNIW6UagkyiQSFK1YFkwY3UyFsM6j/M8DF8aehGF9Unsh
 kk5hMfUckTxepx/WO1jgyAV4W57Jbf+rOGBOnvi0VnkjbIK2HSBsTBjx8IBE41ybd8qQ
 5KISLzyPOTG+sj4Oph3jm6QGNKGPDq+1qoLL8quRRxIBl4bqUg32rYYsvYI3m1Zp9EMQ
 jqm1aOT76IRUJ/IDRP9icfgFdcrfLYZJXmgJa54NcEMHyzPBY/HtPk6Db8/u6ukgmJB7
 MzqNXt9XGfZbQ+u8FBymjPLShWea1TJvAC5aQcX089BcGwKuO1jN9mCIPyXtNooKtcU0
 xQCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzb9Zao73qP9PocFAZiWYSYnlFcb5YinpjMA/UAIPErDOxlWxJ4C3NxU1vBylKgJ1LKATvRA6Miw==@nongnu.org
X-Gm-Message-State: AOJu0YzJNZvFGekfNuHPAjI26h1eEOFREnfqDCD05nYIcZ3Ae/UMTVgT
 tC2cYpmPkopRxjdGT6Xn2UtLB/rERCQ+DOXlEyDOQqHXWL3RwAIcFXXugw==
X-Gm-Gg: ASbGnctiFwWP7RPD5y9y2Gl2715GioGkD1f2oTRvH1ktqx7Q9msvIIooEqqy7d7i/ao
 /Wnw33nG405O/NR1sRFapNwhKr6LfoWRyUAO7Pv9THAFcbol7qwGQynqJX9u9hYwO7zBkjxNi8A
 gCCLxE++GCo3D6AbJReVQcr94XkFOZxhCn3WSf8q5O9K0oacMQPzfnCqzDKoagSggbEJXWvbenb
 QXztH1+Rkcu6+qYglXgOST8MlV8KRUT+ZYdtJQEQEH86uj1A08ckyeklms+IC5cDbLpZk0bAjOI
 P6Unl/P04u612B5wEwmt9gi3TTw6wV7SYqqs8DbjQ58Xns05wM7TGA65Cr+zhiG2m32+0koVYz2
 W6a/T7WH/nw==
X-Google-Smtp-Source: AGHT+IFf/sxVEWMwe35o7megJ+cwKxfjY13H0PjjI2gTJnfpzDLNEHodIxpwKdaOe2uQbMrumFTzMQ==
X-Received: by 2002:a05:600c:4d98:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-43905f844d1mr17928905e9.11.1738660888391; 
 Tue, 04 Feb 2025 01:21:28 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:26 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/18] hw/arm/fsl-imx8mp: Add SNVS
Date: Tue,  4 Feb 2025 10:21:00 +0100
Message-ID: <20250204092112.26957-7-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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

SNVS contains an RTC which allows Linux to deal correctly with time. This is
particularly useful when handling persistent storage which will be done in the
next patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  2 ++
 hw/arm/fsl-imx8mp.c            | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index e5039fc8c4..8f1237c74e 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 Cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
 Boot options
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index ce5188e7f2..26e24e99a1 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
@@ -36,6 +37,7 @@ struct FslImx8mpState {
     GICv3State         gic;
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index a1a8843b3b..32ca76c671 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -204,6 +204,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -348,6 +350,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -356,6 +365,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
+        case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
             /* device implemented and treated above */
             break;
-- 
2.48.1


