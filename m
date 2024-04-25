Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA846C19F53
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWY-00023h-Tc; Thu, 25 Apr 2024 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWQ-0001zp-QU
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0007BB-SG
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so669892f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041607; x=1714646407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uNspTAtU5EEDrEwByNRMRLu3g41/4uLvJCYO3m3A7Lk=;
 b=J68u941rXX9MnpxzrrzYI3EpxyLXe7AvTIRvfitpcDzO0GvXY7N43rr3S/ZzjdSvPm
 473iqos/YUvF2j4g5m5lMPd4TeKOWkxal3v/dGnpGkpuqACFFxB9O6WRYdWYne5UPXOz
 gsCw4peL0POsRuRDh1KOy0+wMj3IMStjAVqXog8nCHJJbrBKjiW5Ywasf8Rx8xgS95Xn
 OI040NRzBDeRNBeFZBlW80ziTtNnGpnSlAtl/6kbsMI9MAc3vmbP9Z/WDc0b3S20My2A
 xhJltiaJTEpGdwRx4VaxGn+cPGHos+OyG39d+/A2APAOEJIV14omkdx8tZmvdC4qOX6M
 XQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041607; x=1714646407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNspTAtU5EEDrEwByNRMRLu3g41/4uLvJCYO3m3A7Lk=;
 b=qfLgt4SJpiHpC9fjxB2IZnMW8JBWdIRnsY6vn9jqGOKz3No8fI7hfTVCNKQSVJINOu
 zXhxei/f7quELqhc1RLms+p775O/acpxYN9w35l/OaEhJvKp6rc8B+IXoiiL+/LWEbKe
 F5yATSFpNNyO3x99q/jFC0YpXyrmgZWJ5X8BbnZOuOaOn253MNTDse38WO5PdpI2yza3
 tFJEpEJrDunBFsi782yIGoaYKzkoEwiZKX8c20bLpM8g/KPk6C8pg/Ix2T7WIEEvm0n5
 /+MowfuBgkx59tdPpXD3eWzwqt+cDeAiYMv1eUNyYHIfmcGpFDSw43nZpm5VZzFYNRgs
 TC0g==
X-Gm-Message-State: AOJu0Yyqoa+FOJuVmaJ2zid7mcNxXNpSVHRZ4tsXWixqPSKcG/q672/k
 dNp0RfZSbBZx+xyEBO3k3wuCPddhT2HSU+DoY/Fez7Lg4TzoyUXZHHVyfGzXSWHvt44uIaF2N7t
 G
X-Google-Smtp-Source: AGHT+IETpKrHhN5BW/MZiS2IsgPcpdYDlnFnjzES2iyzJQZkN4lnxZG9giIGeJCySc+4y7alUmxjkg==
X-Received: by 2002:a05:6000:d92:b0:343:b295:4d99 with SMTP id
 dv18-20020a0560000d9200b00343b2954d99mr3907998wrb.56.1714041607424; 
 Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] hw/intc/arm_gicv3: Add has-nmi property to GICv3 device
Date: Thu, 25 Apr 2024 11:39:34 +0100
Message-Id: <20240425103958.3237225-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add a property has-nmi to the GICv3 device, and use this to set
the NMI bit in the GICD_TYPER register. This isn't visible to
guests yet because the property defaults to false and we won't
set it in the board code until we've landed all of the changes
needed to implement FEAT_GICV3_NMI.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-14-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gicv3_internal.h           | 1 +
 include/hw/intc/arm_gicv3_common.h | 1 +
 hw/intc/arm_gicv3_common.c         | 1 +
 hw/intc/arm_gicv3_dist.c           | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 29d5cdc1b69..8f4ebed2f42 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -68,6 +68,7 @@
 #define GICD_CTLR_E1NWF             (1U << 7)
 #define GICD_CTLR_RWP               (1U << 31)
 
+#define GICD_TYPER_NMI_SHIFT           9
 #define GICD_TYPER_LPIS_SHIFT          17
 
 /* 16 bits EventId */
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 7324c7d983f..4358c5319c1 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -249,6 +249,7 @@ struct GICv3State {
     uint32_t num_irq;
     uint32_t revision;
     bool lpi_enable;
+    bool nmi_support;
     bool security_extn;
     bool force_8bit_prio;
     bool irq_reset_nonsecure;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index c52f060026a..2d2cea6858a 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -569,6 +569,7 @@ static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
+    DEFINE_PROP_BOOL("has-nmi", GICv3State, nmi_support, 0),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
     /*
      * Compatibility property: force 8 bits of physical priority, even
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 35e850685c0..22ddc0d6661 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -389,6 +389,7 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
          *                      by GICD_TYPER.IDbits)
          * MBIS == 0 (message-based SPIs not supported)
          * SecurityExtn == 1 if security extns supported
+         * NMI = 1 if Non-maskable interrupt property is supported
          * CPUNumber == 0 since for us ARE is always 1
          * ITLinesNumber == (((max SPI IntID + 1) / 32) - 1)
          */
@@ -402,6 +403,7 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
         bool dvis = s->revision >= 4;
 
         *data = (1 << 25) | (1 << 24) | (dvis << 18) | (sec_extn << 10) |
+            (s->nmi_support << GICD_TYPER_NMI_SHIFT) |
             (s->lpi_enable << GICD_TYPER_LPIS_SHIFT) |
             (0xf << 19) | itlinesnumber;
         return true;
-- 
2.34.1


