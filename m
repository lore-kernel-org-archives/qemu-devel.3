Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB33F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqul-00005h-5a; Thu, 23 Apr 2026 06:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquH-0006eI-KH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:38 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquF-0002T8-76
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:36 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so888632466b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938613; x=1777543413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k71EiA698awn8baW17i5bs+rUZgHTCfmiS8BNMUGwMs=;
 b=EzUeFvniqkXI16p3YDaPH3j4KbSKnBmZoE1ZbeDQWdehg01jWlPQrsNib1apX2xsKx
 boQfzWXQorBNbcxVWSnMBnlzEfEZCmVNslsxy4F9O2BG/p1GT4655WSQW6n9jTd833Tg
 5BDeiasPUEBhW6M48RUedwzkIuW36OXawnH2c+CQTD3f6jYQh1+0grMB56uRV9My1WNf
 obIRSt9CYQezS5i602ZKkl7/dzbbmH494uh2v4b1UtG39u7v4UvV+gJByBeafW19jpvI
 EFKEptnkAlb14gbf8ene/YHC4douY5sFhl1Lf5OSQPqOOaaEuPQeRszjKvN60vnPHgTU
 c4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938613; x=1777543413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k71EiA698awn8baW17i5bs+rUZgHTCfmiS8BNMUGwMs=;
 b=L8BlaGqxYBT/jp2BeOGMDK45yg9Tw9IhRMY4xG+KTMbXjkL+gBSIPS7LvJgpopnVcR
 vlf5PYvNDh+8rj2YGvBYjmSuliVfqL5ITBUzSzu6JRfxf9Em3tsgFufR7iPatJvPf4oU
 i92a5zLLY/SbmsvBRLNn2DoQ9mKdBBYzKnO8K5vAvp5pPcK7ZwijrM7PJNrsdnnN7L3R
 FpANBl6wKwFVLv4FrecFxdXWnirQjr2MxVVt7MwYoje/qpD6KHuvrCwJvFBCldJtODqh
 kaBjX0Vyr0jHCCy9oWvdq3kbej07IOcI2MpM747lHvGx4yC3Qcbpl/pl24BY3RFNdHoP
 QEew==
X-Gm-Message-State: AOJu0YwqR7MCE3A/A3y2l6+tue1/atjG7bAobNsaafkYsNHpBaOpBDNK
 aTZmNUeUotbVUAvayBKmVq13oxvfi5EozPa9MLqGGdSkZkiA4ueY8YEU6BKigi+RoCjgxYRpDLQ
 2OOiE
X-Gm-Gg: AeBDiesl6wzkxPD3pFEUdnkHwbB+wQM1/3O5qtuNg/UvI+OWSquIWAqATVGw01SYRcd
 agmihtxVTE6uCTAhZhNLgEfVl9NyvQzyUyNLhrOOdiQ+GcgbC7U5GaJA2VecKmgsQ1bFrw/sR5M
 fQwC0y93rp8obzztfMFfvszzPhaOP5ymRiRyToCGFN4ScVOMB1U+6UCtSsZmX44SHVmB6tYjQ+R
 pTkMHXN6iTOSF/alFUqaUDUTI8XRGtcXLd4Sc4LrIhAJ8MglKIYPUwNNMtxB4XZXcHzcjbz+jMQ
 qZhNFneT8O6jqxzWdjzZhojzRXmuzTPWeeNG8ReY43YFZuhhlHf8RzwaWk/rUrUDzMh105jhG5g
 vga0oelm1bg1Yjrm9a2wWA3JCdlJlhtdMeGFD0kzdL+KoErPDW4rUPmaxJw1pjR6mwDzLtdwYaO
 HyuOK/EBqQSjNdJRgmwwmA9/TeMiqJAxSXa+/8ya1PmFFt7ovN9YNGZ5zHe+qFTfkFqMFrolLO4
 Ml5tWHMZX+gNnyz6UnSFBO4GBrHIL8ngoEX6h1UMPFx1W19a8YV
X-Received: by 2002:a17:907:9618:b0:bab:d8e9:53a7 with SMTP id
 a640c23a62f3a-babd8e955d1mr216483266b.29.1776938612349; 
 Thu, 23 Apr 2026 03:03:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/59] MAINTAINERS: Remove Vijai Kumar K
Date: Thu, 23 Apr 2026 11:02:25 +0100
Message-ID: <20260423100229.2941820-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

Vijai Kumar K has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Shakti C class RISC-V SoC orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-25-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02696f46f2..f1577e6c5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1733,9 +1733,8 @@ F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 
 Shakti C class SoC
-M: Vijai Kumar K <vijai@behindbytes.com>
 L: qemu-riscv@nongnu.org
-S: Supported
+S: Orphan
 F: docs/system/riscv/shakti-c.rst
 F: hw/riscv/shakti_c.c
 F: hw/char/shakti_uart.c
-- 
2.43.0


