Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E92CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7T-0000le-UP; Fri, 15 May 2026 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7F-0000dE-TD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7E-0001IU-9a
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so106123495e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842198; x=1779446998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HIg4fufyA27oyV+iWJOXXBAtZGXMl6lrHdN7+OMOMDI=;
 b=Z/Xm6qGAUaa8P29E4sXBKflpk9ZVYVIXOGKquJ0v9cyrtfy5biPnP31A+js4YKlUv7
 CeVIJdGx5HVmSxTSDaKnK1IDQ73qcXI3Hz8kHo+G3FmoTIuew3CBEzZiy2/LQbQu0qNw
 pzdQxLE7raIvXzkNnOVBjS4BDgUNWmtUvEbG2eCbwN09i+sJkoXu92AvaRAH1Z8S/gk6
 Y4+L8eIPJ4L4xNPK90B8OvYOgWuaOSJUqhl/Kk9qZfOM8oxfsMJZTTmwoty6CsGd1ZD5
 SgeM4KipF+jUuBJF4y5myhKhc56jMPedCtPpjPVX4KK7NpSrKHAFQ+Am2HQ2CoOO0zdc
 sg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842198; x=1779446998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HIg4fufyA27oyV+iWJOXXBAtZGXMl6lrHdN7+OMOMDI=;
 b=SKEPIVnwovw4GIeUcKAfOIn45jmm3elGPgikd5HKBJtea2SMJMJs1UjyxuxWhtI+GT
 AXlyoI6Uhg+slTXrOviBylUcHhpRydlhPp1PF4fJM2S0lYVYSmiPoiEdVfEszAV2rDzv
 MSO9obNh+lH5m2rQ29XaxJrCKyMwvkWBob1+0H8qr2r5YHZx6LPxhYgUOWpFVOddZUnX
 0wXouW56TeRbQZpJAoCTY+LrNbyn7LvoetFTtZtryCyHPHZSUM7UM7Rc2pyayYZPMDW0
 wR1REbC3xX1jW6EteYHvItQr3bCq0bHOvQTIeOrI7yPTZwW3Acdpww7Ye10e2kqmtaEL
 y+Ng==
X-Gm-Message-State: AOJu0YwEKqFsgMGS2sdqji+z2rclms1ttFGQhsxc1OEOIL+aVWqyWjgW
 MHxvosYpUCC5tZ4cNgWAaB5coth7DQ3v/+Y6a3AQC1JoO587pCTppjEx4+OZqLgSiFgmD0aJ8wc
 j4CwR
X-Gm-Gg: Acq92OGD32Km1MnHRTzbijxH4mYsD/Jz5FcGilr2VbN+rFiu9Qhr0v8YeB3kRDG3Osu
 rGY5x27iG3H91g9WBndsWgukR3ecchs5tmiud45DJahJX8uKqxLEs+rbk8tHJTPO/jV1u7xdtr7
 L5lI/+3hJqlDBJ/SkiZVTkausTU1nZ/bUR8VwoZhM1arWikTxDOAO5kdcgSue+8PeFw4mBzgpQ+
 eskFEu52pUkhUEVYkhhNBbu/lXY/MpDXLtsUpgToDcQg7MkZUj1HDM10uIshMsIVUuSYPLA19j/
 MhspMOw6QtT1XubwiPM043Mx1pIH2mGkKQPqDtz27+neZtKDHF7v+ABFbvOR0aJyqzRoTR47HXc
 DLNTlV9i2hvqxGEIcqKCg6iTbmt1AY9oQgrmHT27UL2j9vL0IsGy87oMFVG6zW3DPlP2BnGNlVC
 +MYpeXEyjYL86dUVk7xSK9+tbYYpCEpbap216gW3t7U5PLUlLUD7WCNzIIOc/QRUJkYvBD0CHUS
 Bo5onGLkpZttewvo+uByd6xZ6T+H9c=
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48fe60e13d1mr47269685e9.3.1778842198441; 
 Fri, 15 May 2026 03:49:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] hw/intc/arm_gicv5: Avoid NULL dereference in trace line
Date: Fri, 15 May 2026 11:49:31 +0100
Message-ID: <20260515104945.4145203-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260512093856.3197700-4-peter.maydell@linaro.org
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


