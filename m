Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B920EEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKI-0001OV-EF; Mon, 23 Feb 2026 12:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKH-0001N4-1D
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKF-00006Y-CY
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so28241815e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866146; x=1772470946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG7OK00yaSbdKOgQYurB1+UoGEZISqkbJe1azzpynuk=;
 b=XCbJIREdifcX9r5hWOoB373TZ7ktgJAnuIexGVnHVcP0U3v/KFOzwQXZYDbi6HPqsZ
 6E+9hzcGRGWJ1Ng8Al2e6tAj7jYmPhONKop4ujfSvVfjw0IMriYOzHYlp0Alo1nLN2kM
 +JlCz3U6mG2JcjsQNBJc1BVXDsDNIOZX0aPxDGrSMYFsAwuiiHGrriwS1Wm9+FONRwl6
 aTFoayPVFNddgw+o28xGdFX5T2BRlNC2/rrHueC8mwt0dDmf+6kAoVLabJSmJsUyXrOp
 8MRByTAqkkNgXnkx6HbcqvVEEYP8AKvuRPUvXCJhHbTtSET95Qib2IpmWuSfssNQ8EZm
 VCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866146; x=1772470946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eG7OK00yaSbdKOgQYurB1+UoGEZISqkbJe1azzpynuk=;
 b=XKuKesW2mlqEDI0Sb/yo2SFL0dlVYMKpWGZ9wHUHYVfb+7/00I3izqrWTH0DN1qWB6
 Gt+AnfpyhPF36NJOyKTGSGES3v+3bModu+K33KN0AqM/cSLktDFdADXiFHVyCsSrKlsf
 dOflSSo9Mmh/noWwh7nRcy8Daf6z4UNVaFyiTOrOnos6IjPznwIO7WXGYxiFPmdvFN8w
 N3pk262f50y1pqkfKLcEQxBVfkMxPP5m9kdvYAg8COfeK6Bp6adOQ9gN7orHzsoc5cKM
 Xg9tbHraQOLaYhMOhS/FOFK4kNvwf9k61HFWDxakd2UrCueS7oFmeazQN7qAZtqkp/Vo
 RRSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXCRPpioYBghz8wuIFA9bT6tHHmPyTI86MO3ryrI2DElEi4K55EVTM338AWF/iN51TPIfXE63XlcC@nongnu.org
X-Gm-Message-State: AOJu0Yzc6iUHkrs74tEsp8WOxAO5vLrqZbZRwiKPlG1lvYamx7XLGyfR
 nf5JYh3wkZ0gXKVhSKp1bsaPYPfGtxhRRImvTjAT9lCRTWj/Jze/TCcTwBfdx72TbAGJ00DhHSM
 saL+3
X-Gm-Gg: AZuq6aLceiyw4rn/E0mQvZYBQCHKwNKHfaW3u6c9AtAKY1WrgHTyS4jxEU0xpb4+ble
 h8BsGb7ITpjsMK8q+CbtSeP3nnmMNqTFiuWmPLxmOtdR6gydKsApEfLXVujhos2/q8gCPVWpeON
 +Eazw324CGvg08PD3Y9AacfFI9eyAvzAAHWzukS/ykuvHRmfMGVzR9K1YiQY6FAhBJavamvC1lX
 u1xzyVEQJvVd7DwlcV94XR6gaL4rw8x1dv2CuajAjX7HMfP/MDZNyWMSrzRbTk8/vTrN748Ts3/
 LH3Obtm9V21+YOGJSs5S8OpbyIebQjyDm0EuirbpWgBQ/wL+1f2MrVEiudvgUkQl/BcCrJ1IFXd
 ahCU14/dN+k05rC1Z+57/dBaqEmoDQ/1WdRxyFS8KRngeMyxy2KECdTbndzNDKnEBpHlRi/PN0U
 LNVcz5RFKELQTl6fwhOpNskwVce1VO6Gnf3TIUBdzEOVEmhx/y/WW3GkH6vvq/qa0m/+zfiBkO4
 cnjM+5M36dCeJiXdrGei1ZClw1PT9c=
X-Received: by 2002:a05:600c:c104:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-483a96076a5mr126421315e9.13.1771866145874; 
 Mon, 23 Feb 2026 09:02:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/65] hw/intc/arm_gicv5: Add link property for MemoryRegion
 for DMA
Date: Mon, 23 Feb 2026 17:01:17 +0000
Message-ID: <20260223170212.441276-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The GICv5 IRS keeps data structures in system memory.  (Notably, it
stores per-interrupt configuration information like the interrupt
priority and its active and pending state in an in-memory data
structure.) Add a link property so that the board or SoC can wire up
a MemoryRegion that we will do DMA to.  We name this property
"sysmem" to match the GICv3's equivalent property.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         | 8 ++++++++
 include/hw/intc/arm_gicv5_common.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 0f966dfd1b..274d8cd255 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -122,6 +122,12 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
                    cs->spi_base, cs->spi_irs_range, cs->spi_range);
         return;
     }
+    if (!cs->dma) {
+        error_setg(errp, "sysmem link property not set");
+        return;
+    }
+
+    address_space_init(&cs->dma_as, cs->dma, "gicv5-sysmem");
 
     trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
                                cs->spi_base, cs->spi_irs_range, cs->spi_range);
@@ -137,6 +143,8 @@ static const Property arm_gicv5_common_properties[] = {
     DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
     DEFINE_PROP_UINT32("spi-irs-range", GICv5Common, spi_irs_range,
                        GICV5_SPI_IRS_RANGE_NOT_SET),
+    DEFINE_PROP_LINK("sysmem", GICv5Common, dma, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
 };
 
 static void gicv5_common_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index bcf7cd4239..3bffa2cb1d 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -83,6 +83,10 @@ struct GICv5Common {
     uint32_t num_cpu_iaffids;
     uint32_t *cpu_iaffids;
 
+    /* MemoryRegion and AS to DMA to/from for in-memory data structures */
+    MemoryRegion *dma;
+    AddressSpace dma_as;
+
     uint32_t irsid;
     uint32_t spi_base;
     uint32_t spi_irs_range;
-- 
2.43.0


