Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E76C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnat-000172-Js; Tue, 11 Aug 2026 10:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaU-0000Ju-Pv
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:21 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaS-0001va-Bf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:18 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-90a6b298887so1159506d6.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458975; x=1787063775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qLQTI3zH2lnSRnuugMAOGuO5ULK1Vo14gVKj4dalpTw=;
 b=mIuv+cuewt9UzZJHUArPxbhGl5C8bO1ZMVBmzabgWhxpBlrIt+kxloK0/BqnHZshNI
 bq/6NRP0NihGZRpFOmHf2KDa1CoI7BuUTR50UUX/m+WeZGXV6MkjhhYUYR9xESMv+jO3
 /F+/aSgJdlhnbPmHSpGr6HFzoun9e9FjwZzPtNLCSnbPpE09XCtLWkiPSA56Idmp5gPX
 yGVq08GuLN9r4uVYmGcTnyvdRnjg8okDe4WxyQPzr9kY2+GPjnmWP1GZbVV5nKp8U594
 h8eHujfIy+790IOjDS6kJBmL7dUdaeTY0P+qbjEJhuUCUlPJd7pFm1wacNwbqgJsLgbI
 5NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458975; x=1787063775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qLQTI3zH2lnSRnuugMAOGuO5ULK1Vo14gVKj4dalpTw=;
 b=SjydVq0R1PrOXfoYxEFpYZ3g2Am9itoV5trE1Kn6TVpug+eBr2ZZxGphZUJLZvfWfM
 BoTodZ28yfEz8xOWzNg/uSKvzLelrcZIKU1zrgMbgjt+0d4sgvYzgY0fQIInhYtWbbLF
 SLWWlbGBGWXdSBQm8Ys7CGHYmDwpCZjmkA5ee4tqaDm+NGKIREb/ldExaWLawMI678kH
 fUgkX5tKWuCBk13KXhVx4oZIbA7uwnL/E2B+nWH+ZV3kZbAMyxTv8SGIruubfZxBJqq9
 Rbl7+tGM8el3su0rCfPqbIl2SXqmY1IrVLrx0FNUSo5ipmJmrSWvC1TNIAAa9/OXbz/V
 PlTA==
X-Gm-Message-State: AOJu0YxHV8LcD+LCDA1P04Lc4w2U0ZEG9se8m4G+hrasbb1NGep2zb6x
 QPn/rskAVBv2ccFDlS7LbIeV8ydF8bwshW5jEu7ULwasO9wCwL32RP+HEVgbIA==
X-Gm-Gg: AR+sD13Gb68IFqpicTCVlYhrjRDGi2RT9iPVjkOuQCAefj7SziEO6xcCuZW1XQVDbo5
 ZuHdvUwBauMeINykLLGnJBsiyU7jAbZv6PWr08u91w2Z7PGhIdhXMXR5ZNey/PvGKc5NWOpXYDK
 4NRE+/LxmtUnKMcEeWce2X+hNwbe8+/CW0wMPx/iY950MTaN2XD23V8SuR0lXOCcgKVvAeYxvoB
 XBB2nFBA0zyTYG3wlt4ku64S8WxuzJfR4vIld/bGbLUsZT7Cuodgf0Spo5pbgaxHNogynwlK0Th
 B06k8U/EZAoVdJnBEZaj24Xmdeoutr0MASFM7Ixlwjyny38cA2YTY9j1Op1AKlPXQrHRIwWa5cP
 enQQGsYZaKUoi26TIXCJeEHXSvFf/seoIC41EzJFjOVDrtZXzF8eHowNfFzQPgHPzl3nO7NMZ0V
 lIb4AQPpOkVTur3/e3M5MdvywOh/EoU1PIyN/gaRVUVv7LkC/WARSuyty+Ers/1NivS+x49qMZT
 j7mbmvv9Qfy6Hj0SRbXu86mIEYmNw==
X-Received: by 2002:a05:6214:2b8e:b0:907:c31d:dfad with SMTP id
 6a1803df08f44-90a66e01a7dmr31392396d6.9.1786458975340; 
 Tue, 11 Aug 2026 07:36:15 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:36:15 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 15/19] hw/net/bcm2838_genet: fix PHY
 autonegotiation-restart deadlock
Date: Tue, 11 Aug 2026 10:35:52 -0400
Message-ID: <20260811143557.7862-16-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The guest PHY driver requests an autonegotiation restart by setting
BMCR.ANRESTART, then polls BMCR waiting for the hardware to clear
that bit as an acknowledgment. bcm2838_genet_mdio_cmd() called
FIELD_DP16() to clear ANRESTART in phy_reg_data but discarded its
return value -- FIELD_DP16() does not modify its argument in place,
it returns a new value -- so the bit was never actually cleared in
the register the guest reads back. The guest driver then spun
forever waiting for an acknowledgment that would never come,
appearing to hang the whole boot.

Assign the FIELD_DP16() result back to phy_reg_data, and also call
bcm2838_genet_phy_update_link() once the restart is handled so link
status actually gets refreshed, matching the surrounding code's own
comment ("Initiate auto-negotiation once it has been restarted").

Found by booting a real guest against this series and tracing the
MDIO command register with targeted debug prints: the guest was
observed polling BMCR indefinitely, always reading back the
ANRESTART bit still set. Confirmed fixed across repeated boots: link
comes up and autonegotiation completes every time.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 746e416e53..dfdc5ac728 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,8 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
+
 /* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
@@ -392,10 +394,15 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
                 if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
                     /* Initiate auto-negotiation once it has been restarted */
                     if (anrestart == 1) {
-                        FIELD_DP16(phy_reg_data, GENET_PHY_BMCR, ANRESTART, 0);
+                        phy_reg_data = FIELD_DP16(phy_reg_data,
+                                                  GENET_PHY_BMCR,
+                                                  ANRESTART, 0);
                     }
                 }
                 *phy_reg = phy_reg_data;
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR && anrestart == 1) {
+                    bcm2838_genet_phy_update_link(s);
+                }
             }
         }
     }
-- 
2.47.1


