Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C32CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMjZz-0008K3-7z; Tue, 12 May 2026 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZx-0008J1-9O
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZv-0004oI-51
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so4804646f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578741; x=1779183541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mMiEiZELjpk4cjktkRPxm3pXmOfuJINIuLF6ke/BYnY=;
 b=Ww6nj7r+t875hB1Md7FTtM8s6SFSrCKPQEELMSHmSudUj6y2sKyq5SaYFQQK+ge+yJ
 jYS3g2821zIOnDRWgO7aKU3YZLY+Rj1L3T2yZfiHXPfIpZ3BSUm7FjpE5hFTwovxeYXs
 E86J8SeNa2qW4pOGqfhsHvl0SgyjVFZwTATjz/7SIsczGtUJHzWx0teiV067BbrpAr5Z
 SO41G04MWdXC04bPHzCSXvkDF8crIhhwAWckNTnZHoZFg+LfUiD/5S7IuYmDhTHL4REs
 XM90O5+32Xa1SeelmArQjhJrOcaj2UiEnS0XgjjlBPD13BowlV1McGgST7Vc6eE8QX7W
 jJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578741; x=1779183541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mMiEiZELjpk4cjktkRPxm3pXmOfuJINIuLF6ke/BYnY=;
 b=YV7/VItNTO3m51BVTMUS+DWF+A4CPfuDM/oz8GtuNBPfO0stQ13IkHHa7QBemGhL6R
 hLFTPRSg1bIMiPRXdR8ZVeH3LEBOjjkJ/En8C0TKO7Jc/FXqGAcuMaRE+CDB9FoahSwK
 h8RP4W7jj/XVRFzSDGxBOQWNTvWVpzFjEwP93HHHj/VSf3a+qaVzTkCPqniHeTCt3kOv
 0JBUDqDmSADlU1sNAJn1B12KCqJ509w3duO+YKn2Urt0vWG2b0pHp9dZUhm6dX/xP7qq
 8nMPl05BtnwkjeWpO2U7m6dvGgiV45shDThm7um2ZZrzwx3fgmG9OUJxp5dCSX4obo22
 nD+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QPDgSKxC1xQkLXtjX4kg043kRLSh8GKLRWrac4/kLNCctfyjKtIsCMlYtQ3GR46VoN+Y4xpqH7vja@nongnu.org
X-Gm-Message-State: AOJu0YySzdEhntDuGVPrW/vsqHPuWB8MrZJn+dlJsnouD3lSVxaUrEUm
 4Hp3ARD6S10GcF9wuvC44zj7Qr4zBYs1vdZg8aFrl7/rfxNJqi0XImlgYTJNhZ86yEs=
X-Gm-Gg: Acq92OGtVeBuWK3ypqrFJahF+ZzDYEK4sYiXjRYLwS5jnQrTQzNUeTTvDJTM7+gtCFO
 1NRgsSavNa5AQT5eyqWu+JtNpDm+VttsPBN6rLZSPaY/dSGLFs7u2PD2QYhJC1fqxypDM3hd8J4
 +AalRfY+UECd2TBGJca9o7bQ//i56WtPzMGX7X2mlH2XY+FTuuUoRtL02lmXCkODhmdj2Tkq5QG
 7dHxb1URgz+6iJkuGnS2SmPkD64ctHlgJh0+PIA7972m4AfNBGvjcm2le7bWkyDPw15oV+e+7ve
 iv602SpcSx1xf93s/t8vGmpWzHC79WvefOwBKOT2NkL0FnsfG7/nJAKaUyPoKcdSyR8U+jD2EUA
 ZkISzYhbp6RUYXCi61DowmlNZ3ljnJaRm8T5CvvnNNCV424oMBxNmpJeQNpgdA2wnA6U75PScRG
 roKzh2Wjivmvh4VN+cm7+ewQU6uRpbLvdHYaUBMI5nNKlw/D3A5lthtDT9NnyhaIe0h0+rH4ORT
 gGO32ykFMb6zXDw+KBhwWI8uDm2drw=
X-Received: by 2002:a05:6000:1868:b0:44f:da54:da6c with SMTP id
 ffacd0b85a97d-4515ce1c84emr47414188f8f.26.1778578741504; 
 Tue, 12 May 2026 02:39:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm32805208f8f.6.2026.05.12.02.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:39:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/intc/arm_gicv5: Avoid NULL dereference in trace line
Date: Tue, 12 May 2026 10:38:55 +0100
Message-ID: <20260512093856.3197700-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512093856.3197700-1-peter.maydell@linaro.org>
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In the handling of writes to the IRS_SPI_RESAMPLER register,
we call a trace function, passing it information about the SPI
being resampled. However, spi could be NULL if the guest tried
to resample a nonexistent SPI or one configured for a different
domain. Move the trace statement inside the "if (spi)" block,
as it's only interesting trace if we actually did a resample
and potentially changed the state of the SPI.

CID: 1959593
Fixes: 33185e1d64e ("hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 493d664625..7ad274e369 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1643,8 +1643,8 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         if (spi) {
             spi_sample(spi);
             irs_recalc_hppi(s, spi->domain, spi->iaffid);
+            trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
         }
-        trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
         return true;
     }
     case A_IRS_CR0:
-- 
2.43.0


