Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1586DFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeb-0003Su-3g; Fri, 06 Mar 2026 09:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeZ-0003RU-Hl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeY-0002IB-3r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so107212345e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809185; x=1773413985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BbwoDl8zktcPH1pK65Fdey58LvopgakU7g1LQRQm7qc=;
 b=FmIvhBNYiPzDvd7vcCzdHQSc9SGqorG0dGUhNs2t0DMeq7bKXAN4eppY8YLsY66rTa
 ynr49j0OrL2D8FEfSveUu+Dh2oTWi51CdHGJHeHsiJzTMi7IRl2u6qkTJDD8qUdeNkpF
 axqnCUCGKI5xAkH/XESLomDI70Ygc+cf7L2k5DIvtLotyDO+FmPmV25ckVY6nB4jXiB4
 t5B2kM1oDAvctoCoEAjWM1TZcf5mjkup5onaFdh37XMTCWKz9I1BJ5zTeipPRtnr+ioo
 BalQNlpLH8z4cP3fNBQCYyZFZdPaHzjQKtRQWkdCGRU/mMpVdT0LoHNFgvkhX1tndySJ
 EG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809185; x=1773413985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BbwoDl8zktcPH1pK65Fdey58LvopgakU7g1LQRQm7qc=;
 b=pFnMtTX/WmI4/9WHF3lV+cCM7akdNGb/SSQrndfMKtBi7GGpG6TRLuRXNE/W01mYND
 P5ayVs/a64ifQXzWIb51A2Kzd0hZNvNSSQX0fYWhI8KFradINhVBh+bC1oCj8BVHTC2o
 FetXprDpH9bUEWmIBZrKN3aK/yrtMhD6Bcx8EU6rwto9ZvwUM6GvT6sffHmyYTRXWrlx
 uhj4uv3q8ngnSxXOfJbvnwPhOw4dDfCotC1O17S73hv3FxScoDqiWIScsLc5ncABCTCT
 x/5uZovUuDndRvfUe7WQw83WI/nK0EjzHm8VO+7undzOdj776zeVtItSnxIdNEbORCpo
 HkQg==
X-Gm-Message-State: AOJu0Ywp77Zmh3s+6Hk9aMhu478t+xOI8gKR/uQVsq/npldTyY+28GqV
 fTOrf0sJ290/LVtd/qESvsAXSgaRzht7Wqr3ire0O7JgIPbu+2Z6L0RQkj/lur9gkHfAROKUgqE
 HVTdt
X-Gm-Gg: ATEYQzxHUUVYRI/k/7xzHHc49bmY/DEF8DeTtKAZU4zysLccRrcfh/nThkE5IYItZK7
 hZMCue8ivkIivAGqrKpyRCKCUPbvT6ubanrwlQeLEal3z3TVYPKK8ZxBLPjJqSTLjof4RBwbB+2
 q4gG0Aue41jYmNsG3IClMXe8ZWSn8fHYabcWHlkN1FwSLgb8O1TIa2i8P4pxy4mVOIJM0KzjK+K
 LFMuSxhPBC7BMq/IkVdteUaQ0rumpZ7Brs1NRH0oSMTdOCVr3WXIB3/69EI0wwiVAm8getSvTP9
 g8PMbFT/sAjj9sigS4W6U0QQSFXbufICtGHPqzTU9aIyqyXNglgaFReSAS1YX+MRG7qw940PAI4
 CaGxAfHfI/hK39JupyPsQmpXzG3z7sbM37aXZNQKY76l+CuKq8OeUmQcB1W7oZgYlcYhFQV0GVa
 MGDLOalo4eKViSdv5iphvK5oh2FjH8eD9qhfb7t2ajpG9jTqy+EU6Io6vBbOVupMppsLYPRFzzX
 o0Ueog6ql/C0bSHF+6Z7Lmi7hsf0II=
X-Received: by 2002:a05:600c:c491:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4852695880emr41903375e9.21.1772809184617; 
 Fri, 06 Mar 2026 06:59:44 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/49] hw/arm: Add missing dependencies for STM32F405 SoC
Date: Fri,  6 Mar 2026 14:58:53 +0000
Message-ID: <20260306145939.2162189-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Chisheng Chen <johnny1001s000602@gmail.com>

The STM32F405 SoC relies on STM32F2xx peripherals (ADC, SPI, TIMER,
USART) and the unimplemented device (UNIMP). However, they are not
selected in Kconfig. This added these dependencies.

Signed-off-by: Chisheng Chen <johnny1001s000602@gmail.com>
Message-id: 20260228070622.2195836-1-johnny1001s000602@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 45fe8575fb..8bc23b61df 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -387,8 +387,13 @@ config STM32F405_SOC
     select ARM_V7M
     select OR_IRQ
     select STM32_RCC
+    select STM32F2XX_ADC
+    select STM32F2XX_SPI
+    select STM32F2XX_TIMER
+    select STM32F2XX_USART
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
+    select UNIMP
 
 config B_L475E_IOT01A
     bool
-- 
2.43.0


