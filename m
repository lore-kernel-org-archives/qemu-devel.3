Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA325F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrn-0006DF-5B; Thu, 16 Apr 2026 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqd-0005Gm-FX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqa-0007mi-OS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso72777755e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331034; x=1776935834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+97XIhxR1ToNi49p2N5uzwSnGsg3GkHauvAVxiinyEM=;
 b=ua47hD+IxYcDxedb3+1PL5/FyvNc4Lp/eT2GX8WD73RNDH0Fik+f0VEr2bFQIZEXt8
 LtvwHSoFG2HJ9N4jI24VvP0mCCKw0TGOJ1zBlfR/WwKWlg10RXek9XTQN+H1nfAFVjdv
 YdMWDHAYifo/UmYhO/xW42KzZKYhHGwRmGK5/fYZHnWa3YavcKR2lJDLwZxSAgjNAIBq
 fBPsBGajIVHB70Mq3HXsbTADWGfVY5VdbccuxckwODm1BfK/uP8jCbLVCaMBx/6Su0mj
 qrhSGbS1WatRXPN6EsUywj0IgyHP5XCs38Wdj0TDSeliAax2Z3eo5S5gCwauR0fQdXLd
 dyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331034; x=1776935834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+97XIhxR1ToNi49p2N5uzwSnGsg3GkHauvAVxiinyEM=;
 b=EvHGfRgvXq1aNnoIXwkG7GBqGd52dDIgdNRODP8r3dmCX8ICqFXpH/syjA4dcEnbBP
 8MxB3+fCuLUMi6RVG7M+8cWVkmJCt67Bm3Kfmr8AZX6XxaLJH59f7MYoX2Hu8A75eCx/
 7eWFSVK6Gcu2ATwAkVEYK5vZSiQs4JV/ip1fXcBQls/rErhEvT+PbZPP5yHwdbmjZ4Ck
 gDFjXgXCyHtaomYR49/gsr8IQ0rkp0CB1rHRjqRmhGuCilYBrX9WpX60TIUFV7uPlLnN
 nw8AXIwtONTyQAPF7CP1Vi2UKbj/WW7ly5BHSRy/qLcsvmfCmdvLt0RpPkMW7qiM1sHi
 BY6A==
X-Gm-Message-State: AOJu0YwC1lmHi85b5+sy697FuyqnDzk4ClIBz+XOO8vZQAk5yhOuFfsx
 SynWhV27+OzdAPAFAiOFYgcmUpmzcSr/QfnwPyD0omxhw8Wa1f90AlTFe6ip/qpohmFp/wxnPZ5
 HbDDTvYo=
X-Gm-Gg: AeBDievbLxlH1yeVvlMMc9m86xvG5nNc7+wiC0C5NsoWx7WHQ91eCUHx5VCyF10a1Gw
 j8mPo8hAclFcqZuvqsPt9sj7yOYa1oLsI8XOUZLskegsAPvqwSqognzUi1fqVBxOnOr4/aci53q
 oQJVGj9kDkl1qIgaybBLY6PkR7W6psrLQPhCtChPKFc2BDbi84XTRgoChMl/KvakvQdEjChF2ft
 HsRFxPNzSYGD3YW8A22b2K/MRfUGaUUyHSSbFux5l9WgghAdbHxUkxtxoSyfrxKFZyT1SBJss68
 BkqfcnsdqnHRY5KLMzqEJK+L93SiHgO7I14A3qq3dcO5F2g47+n2V2E6MK/B6LxrIaxaO1om3wE
 imIwTgszPCR3oiQwXft9xPXfIt3KQGfwu2nDDNNXB6DKoKB+RW8N+5/JZmrrV0tfdK4ulleMFLF
 aABuHXUTWAlrQPVefd6BIMKncm3lZzzjrQe8quJvUaGX+OBklqQTHStabiVhfF7uRXQM/n06new
 z2PDEmBicHMp4e0/Z0ccynT4UYA3DDn8he7CgHDHg==
X-Received: by 2002:a05:600c:474c:b0:487:219e:42d with SMTP id
 5b1f17b1804b1-488d67e72b7mr321348515e9.11.1776331033756; 
 Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/28] MAINTAINERS: Remove Jia Liu
Date: Thu, 16 Apr 2026 10:16:43 +0100
Message-ID: <20260416091654.316158-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Jia Liu has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the or1k-sim OpenRISC machine orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7a345c514..c16a726cde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,8 +1496,7 @@ F: include/hw/pci-host/xilinx-pcie.h
 OpenRISC Machines
 -----------------
 or1k-sim
-M: Jia Liu <proljc@gmail.com>
-S: Maintained
+S: Orphan
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
-- 
2.43.0


