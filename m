Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCC5C28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQi7-0004sV-7z; Sun, 09 Mar 2025 20:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQgJ-0002Oa-4l
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQgF-0007X5-Mj
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso3630415e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565257; x=1742170057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Py9KY+fnraissHmshv8b8vP/Jh1xZMVT/AazakuO3Zc=;
 b=nRfKj3jJK0n+ktgfvCysL+fqGjlXEFaUR6XIbHhc47agQACnwWCwSOt7MYQv3CNQQQ
 gvk0xf5EPdhlda7pOAAA6RUM6GhfVFyBB+46CaO7B0z6McMCfaomBhYiF2XDMMPSlJgy
 pvmpG9DInqygAfxO/EUmGe/TNmg47+H21v+yDe2Vzx/g6J6UmZOMvIbgfSBQFuq7LDli
 eN++sM2HE16GptmpojUeNl70IPyHeVODf9DXybn69BhlE8veC3x08HMK8R9tHLa0/i8P
 MLHzzIlVI1cH7c3uwrmCXxrh4iy09AN0Gr3o5awa8RILJy7iOsLu4ifv//ebU8HJ/ZHZ
 /RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565257; x=1742170057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Py9KY+fnraissHmshv8b8vP/Jh1xZMVT/AazakuO3Zc=;
 b=A8K93kTXtQ93EpN1kf0YJYYi3eizmde4WsdM8BNUhAHv/u/Bj0Ln3BLxfWusxA2o3/
 hRbw/5D4msGK1x/O1D4SO3/99+0JlaRPWItLT5TAOE8D//4QNBt49wDEQ3il4gpir7Pi
 /iwJtqoggNaOcghpz5pfDZkXUVCZzkJKygHQRpwHmgJWI+70yihqt2PRrLHV3QqsLhvS
 kmXnb/SxNuQMf2ywWewjekIz6h/wCj3aQapylyse8EngfTddftgCNtjs1GkfEL2+g6he
 m162vgHExP/XFfKI49qk3es8YJMyYep5NP4DHg8dKzX0qKiY4bjLyDR1dx+tfqbO1rTs
 OQxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzcwq6jQABexm2jseVqlW1tqDxDQ4V1QHqeGim4NA/KYcUg85rrVG/j3KbBIKYyEEwwapmbuJoV8pz@nongnu.org
X-Gm-Message-State: AOJu0YzuBYmL1ebIX8I39VviCli7lQrbdLlVSKyKg1zHqaDFw6L+81/D
 rqHW4b7jfrQH2y364uk+PYvO4vu0R6rvVkxsb0qOklQYeqnFhbdnREqxISl3Jg0=
X-Gm-Gg: ASbGnctO0Ypo1y4rjrcocO9wesukCQMUJ5uL9r0TqmivzXLjY9H9/KnSWNc46WlvGLE
 rLjoQeYALjkxzwo6MDt+BOZ3tbV9qhc1QqR1mBrQVwMyOXoz/qZf0T7oeSN8JPFG3VGOmgvXyiy
 Z8K50Zu1fKG6Vt6oxa070yA96BTfHtKXXv0t1bhHp/HjlrruReGgrxXfVRnSJsudLzrvsCNCud8
 +rLM+a9WnquZLu0xSghJh1nd5ETqzb/sDGIYsypAqVAIqi9YkjiYtfg+elJz7evRK3Zxd8ax5yH
 IE3ItWI+Vtfv5NhrUn33/QVfdUVFLt7V7edzSg/dRLDIpROikQJ07E+Jucu62zazecJExHE2P93
 Fr/pblnQFzzaiQxXumi9YCEH5KZT1YQ==
X-Google-Smtp-Source: AGHT+IEItIfxzl3m4SKynVlq9NpNJdY49F2pe6LmX0OxCG097zihsyT8lcfeqIEt+LuyIUuyLajvSw==
X-Received: by 2002:a05:600c:1c04:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-43cf62969f2mr14732705e9.0.1741565257265; 
 Sun, 09 Mar 2025 17:07:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcfbsm12872089f8f.28.2025.03.09.17.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 14/14] hw/sd/sdhci: Remove unnecessary 'endianness' property
Date: Mon, 10 Mar 2025 01:06:20 +0100
Message-ID: <20250310000620.70120-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous commit removed the single use of instance
setting the "endianness" property.

Since classes can register their io_ops with correct
endianness, no need to support different ones.

Remove the code related to SDHCIState::endianess field.

Remove the now unused SDHCIState::io_ops field, since we
directly use the class one.

Suggested-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h |  1 -
 include/hw/sd/sdhci.h  |  2 --
 hw/sd/sdhci.c          | 33 +++------------------------------
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index d99a8493db2..e4da6c831d1 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -308,7 +308,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
     \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index e8fced5eedc..1016a5b5b77 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -54,7 +54,6 @@ struct SDHCIState {
     AddressSpace sysbus_dma_as;
     AddressSpace *dma_as;
     MemoryRegion *dma_mr;
-    const MemoryRegionOps *io_ops;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
@@ -105,7 +104,6 @@ struct SDHCIState {
 
     /* Configurable properties */
     uint32_t quirks;
-    uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
 };
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 47e4bd1a610..cbb9f4ae8c0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1391,17 +1391,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps sdhci_mmio_le_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps sdhci_mmio_be_ops = {
     .read = sdhci_read,
     .write = sdhci_write,
     .impl = {
@@ -1413,7 +1402,7 @@ static const MemoryRegionOps sdhci_mmio_be_ops = {
         .max_access_size = 4,
         .unaligned = false
     },
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
@@ -1467,23 +1456,6 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     SDHCIClass *sc = s->sc;
     const char *class_name = object_get_typename(OBJECT(s));
 
-    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
-    switch (s->endianness) {
-    case DEVICE_LITTLE_ENDIAN:
-        /* s->io_ops is little endian by default */
-        break;
-    case DEVICE_BIG_ENDIAN:
-        if (s->io_ops != &sdhci_mmio_le_ops) {
-            error_setg(errp, "SD controller doesn't support big endianness");
-            return;
-        }
-        s->io_ops = &sdhci_mmio_be_ops;
-        break;
-    default:
-        error_setg(errp, "Incorrect endianness");
-        return;
-    }
-
     sdhci_init_readonly_registers(s, errp);
     if (*errp) {
         return;
@@ -1493,7 +1465,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
     assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, class_name,
+    memory_region_init_io(&s->iomem, OBJECT(s), sc->io_ops, s, class_name,
                           sc->iomem_size);
 }
 
@@ -1578,6 +1550,7 @@ void sdhci_common_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &sdhci_vmstate;
     device_class_set_legacy_reset(dc, sdhci_poweron_reset);
 
+    sc->io_ops = &sdhci_mmio_le_ops;
     sc->iomem_size = SDHC_REGISTERS_MAP_SIZE;
 }
 
-- 
2.47.1


