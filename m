Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECEAC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ls9-0006f8-Av; Mon, 21 Sep 2026 17:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls6-0006ag-IY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls3-0000OB-OX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:22 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso30463605e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027288; x=1790632088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=imqiRpU85vU6dmrKz13Da6e6SOocmKKh70jW2acixJE=;
 b=QLxAeDtYiSA4Vr0yWFtJA1zj3A14d/00CRDXh6kBq1tAQPV/pe6X+0cKiGl0pmRkHG
 +iFYayCz+Vz6kl8a5qjxHdwdEyvJwsv122Y6kcKpMXPEkbNEoV8wgnrXFfCykaWIzr5X
 tNbeRZKsEdVaprx9UQUoeK4de2hArp3whxFLTEGtag3OFionwxNFXwYIW7KRdEPrNrVx
 2upHUm+knLzylQh9gUDnoxTYf2IU1lgVvBGCZt/ANf6VsqxCAVgnJgqGp/QaPmhrZHcH
 X5AQUebwt6vx96a0UVog/DdcJXsmfUyCFiXFdXae4f6vXI006NlfVBT50zKEM4jTlPJA
 mXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027288; x=1790632088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=imqiRpU85vU6dmrKz13Da6e6SOocmKKh70jW2acixJE=;
 b=P7dbrZa+uCIVxq5pdCh9U5/hiyvpe3aVQuxO7rfHjZy57r8o2b4p/CZwjGi22uTwAD
 xPP2otZH6YowkFcwmSYNDS55JslV5JXuKjNl6BqNuE0ktIcGoGh65ZOY+mbFDZHNaF/G
 QTe4bgEK2f7MYawOLk36BpSHxQGnvlpw1ltIevm97YSdpptno3NeI5fhwSFrtJWjO9KH
 7VwhB6Pt6EGELE3ZxrTzYctuqWmxBMEJpdNARti7FAkMzH3LNtw+WQH6LjxQWGpgjsE4
 vTIibczaqq4q/zIc7Ur6+cDDrELzaNGT7W6TecDRs5S1XoR7CgLq/fLLOQPvPI9crevt
 UCpQ==
X-Gm-Message-State: AFuF++nrEFNCU33qrTuJn9bgPa88q5ZJebHEs3Y+BrwsfkASxG3hWdqg
 dcuTwTcmhLkD5LXc/Gg7zeai3lw4ipIyrdBxaCVzb9qb17m3DlH4YYtuCNggXA==
X-Gm-Gg: AYBFou0RHBkkKhuZ0WvR9UwAn8GP3jjDRwE/ieHiCE+3zasczlP4MOTyDqq+KCQCXrS
 GWFkwqoW/245VKgHR9WlG4IgURm/0e8QS/+9yPhF6/m4nCulOGGzXUvGFEVWFOycrmyf/1US1B8
 SlTziP08Fa5pJ2TvgPBmYGT0IMGbGQ37jVNmEtxdEFFwQcxLgHweAvpZ2EyGDwIU8zwnMwNFfGa
 zdYl36CAZpjhXk/2euNsjAalJwNKbjH8qCHJ2Bc8aRKIjq3wKVYgzQJ8yKAUFPIlnElUtKba8N4
 ItOWHmhsTgLXQ7hSnMzit+txIJYKNqMq9AVoejTLwuJqAlqwBwZvqMu3dBrt/wGKmDV++gzVNK+
 vpZfKMvKdNgpu/UndCLSbZp8OhDR0kBvJjkrQr3U+c5VxzeqsQtaq3W/HMtEQvhvBp9hAFzmFbl
 /Q3pfcuO/eIdpTASr143AlwVL7fciMp1683umBdvNmhEhsRl2Y42orJ26ATC6LzGHhEN0z5xFU3
 wkNkk7qlhakbU8oazK34mpp8tQoRDGFnB27gAoZ5cGG52AHMJ/B+RhZxWZoji2bqS4q9OpDSAQK
 bVQ=
X-Received: by 2002:a05:600c:34c3:b0:49c:fa21:e74a with SMTP id
 5b1f17b1804b1-49fc5757f73mr173076395e9.32.1790027288390; 
 Mon, 21 Sep 2026 14:48:08 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:06 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 31/42] Kconfig: Extract config IMX_SERIAL from config IMX
Date: Mon, 21 Sep 2026 23:46:59 +0200
Message-ID: <20260921214710.29422-32-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_SERIAL to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/char/Kconfig     | 3 +++
 hw/char/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3510e4a6d4..13b29475d9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -487,6 +487,7 @@ config FSL_IMX25
     select IMX_GPT
     select IMX_I2C
     select IMX_RNG
+    select IMX_SERIAL
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
@@ -504,6 +505,7 @@ config FSL_IMX31
     select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select WDT_IMX2
     select LAN9118
 
@@ -521,6 +523,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -604,6 +607,7 @@ config FSL_IMX7
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -626,6 +630,7 @@ config FSL_IMX8MP
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -655,6 +660,7 @@ config FSL_IMX8MM
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select OR_IRQ
     select SDHCI
@@ -701,6 +707,7 @@ config FSL_IMX6UL
     select IMX_GPCV2
     select IMX_GPT
     select IMX_I2C
+    select IMX_SERIAL
     select IMX_SPI
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..54f9936534 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config IMX_SERIAL
+    bool
+
 config MAX78000_UART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..65351c39de 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -3,7 +3,7 @@ system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+system_ss.add(when: 'CONFIG_IMX_SERIAL', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
-- 
2.55.0


