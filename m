Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594B7CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11I-0003T3-4l; Thu, 07 May 2026 11:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11G-0003RW-2X
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11D-0003oE-P8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488d2079582so11434355e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169126; x=1778773926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bdclcwp984Qp8KEWvGCiLv82TgfwbWNN6N3cLZYfQZY=;
 b=IdEB4g+067hpBRREuK5Qx8o8JGmJqB5mtXikKr64rCkBneOkSTgM4aG04NP0Byq3kV
 MnSraFuB0VzYjMIi49nyXF2cO/wwgeVCmGYSXN2Y79j4qYY0/W07lFux10xN4AO6Zpiy
 oY1eDfUSm6fQOSr92bADIMi8W0lROPGBf/WERkkJfl2oBuB95z/5b9vq3L+JhaZgVKld
 Lrl6kKfTE5lY/chhKswee4CPONIcw/d+DLIGMBzprLKi6wewBTIqChZTZxyM00j3Kk1V
 WBdz+sDQ3LREhzNgEPlOMIjFxku0bWkGbHBKzYMHXxQIT21bAySnwqtDC1PUeGxTRjwf
 itgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169126; x=1778773926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bdclcwp984Qp8KEWvGCiLv82TgfwbWNN6N3cLZYfQZY=;
 b=VSlQK7oTUMou3a9feouKlVeUVgslz1o0qiwIIXHrisah8xNvguYqlIpFUZRpKLj5iR
 vRZ//xXBgW6sqKzYe+m03v2ndJ7jYLsqH7Mg3wtDRqKrL0I5Bg3WAdgMwKahOvtoysyP
 TWVy78uXKNG0Rbbd/lvWYBaq2F+METYlXIONI61C/0p13S1giv+YeJ9Yn5PPXwuO9J41
 q/s3dqmK7K0u84ILji1D2UP53FPJyBZ8e+pQF4kiEHVHDDaJX/FnXVsFNJrkRp3PmJL1
 D0577obOL/7MwOuh1NF4A78N18MzyLuH5HhhR4GTkTvCYfjc3R2Xd+2+Ql5KRcGNSmrs
 1ORw==
X-Gm-Message-State: AOJu0YzTjTIl/ttQKihL/+KtA9cRTsQlmlXYJ9VL71ylKCivaafSR+Pl
 mrW85yl16f5EY4aAvNOKxwc47TdXdYCd18natI598mjfzKIrM9PVD+ESaQEiFhsWiIDuRLRU4it
 T1D+k
X-Gm-Gg: AeBDievP6jgTWHxow1drQRcl24BPkuhv6oMHr7lPY6mpj+Sj/RZYpeAGhj/AxphMBZZ
 GQimtCsJAzXxZi5mqfy/FYquITjaLM0RalwjvKJ0Zx96z7CCZn4ManEl8Lu/amAOA/2gIcc6G5g
 n0DaohjvvrFtrjmmhD7TaTyyO/5661FVRTyyTZVogNXPuq92qsExz2clJ00Nom4yErtUc2umBoH
 Zooa8uz6LkLkv1zEz3zQoQcRb6oMzP8qR8poTwtCIapBgjWMjx7ozmN307yQhoF7oFi4tu2pd9w
 8vSLRlzg5l+OnwH0y7qzDeDH59uxuxJj0sWsCGTe53Mh9nclE+tdl5eJJdaX4o+3iFvQ5ugG785
 95lyOPYH1tlrIZEQBciqBCPh+0jKg+U7l1vNmos6PYphJwjtb0XGku1umCu9j5epezGjDY3QNI4
 a1VEDh5FcaWpQTAvuxM6absM0B4miKNSHpbvQukVDj7D43lEqcMv1Xv1/iRgOzUr/e3mFd61zwZ
 vFjPxlPKLSwC5dTSt5bp7SaeqVIPWM=
X-Received: by 2002:a05:600c:c11c:b0:489:1e8a:90b4 with SMTP id
 5b1f17b1804b1-48e51f37212mr100787275e9.21.1778169125706; 
 Thu, 07 May 2026 08:52:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/67] hw/intc/arm_gicv5: Add link property for MemoryRegion
 for DMA
Date: Thu,  7 May 2026 16:50:58 +0100
Message-ID: <20260507155154.1886557-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-12-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5_common.c         | 8 ++++++++
 include/hw/intc/arm_gicv5_common.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b58913b970..29cc96917e 100644
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
index 21e1d7a21d..233233bc3e 100644
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


