Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3158C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8x3-0006bU-Gv; Fri, 10 Jul 2026 06:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wz-0006U5-28
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wx-0001Pw-Fl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so2878265e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681158; x=1784285958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PzHxCXsIOILaIZXbiZCOtU/tN9ewAfAvcdvjSx7fAwY=;
 b=Oz9p/VZ7GEk7IZcAViytVng484dusrcF27axUwgHcA2YjbOdumOGMUe2dEBe1U3FdT
 rNhhMvrqPcE+0rqySJMqhPcUqVwmWUDv30s8FY8jLVAPPq0/2D9w7E3JqpCGLpZ7nOv9
 adveexRBGA2SciDjbYa+4z3u3giZ/22/fhNXlApMAV1tFqDIrBq4f1lAbIWGrnoIuJzn
 5fM0l8zImqpq9uAcBYVZ9prEAM/1iJOAPHbpoAYG0oz8E2EhamZGEhVkETRCsUJk4+cE
 Gg09f44+21wl7/1cA61Mi24FGbaRcLDZJtTjRZNJJX1CHM3G7DudJpAm1/P4zF2lC75U
 3KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681158; x=1784285958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PzHxCXsIOILaIZXbiZCOtU/tN9ewAfAvcdvjSx7fAwY=;
 b=jeAJ1d4tRDYEoPecFDUCE39qURIgjopG3U4i2ROr2AyZ6Nwu5P6J5Fv09noYKcQkDm
 haoj8rKJOrAtV6r2Cr23dRSZmC8gSXK5+kE9h7WE5eJoHuJqNkJ8L4yyNpXWJjDDYadV
 nePNC8sDCvjTu4wrZPBtGwOV6DDE1efGKCLkop4fqqIkcbZu5GTDd446j3O132tm3I6t
 mKWeqMuRrvq6YmZw5peoE/ziG7UEfFqVWgDlMJNohKHIj2nQHqga0qEu8zjsJZQRfMPT
 GYodvlyu4+DisY6HD3K56lZoSapPw6QGDwl1bjG9zkl3KSpiInUYof+yO719rbWYNnP7
 GFjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLpnxg0y5+aJXcfxzp6so1b9BzsORwuPt3JljvsgK317HN4QIrCAtfuwXd3qVXz1FjTOu7C+OLfS25@nongnu.org
X-Gm-Message-State: AOJu0Yz2iYSD5BPAfzspfyneeM4rU8O/xi69dbZ9eeipu9UBHLYuO7hC
 bwdads6zT+qBz91rb7FvKgSL1Julbvw+tY8o7VPeqoFAWwjLn3HZVpLjpJmUJ2vhmcg=
X-Gm-Gg: AfdE7cnTKs+T9H/sjwICerzpbMGXYetXmTZdIG5ITTeu+oldgr6NfpsInauB5xam+dt
 ILzZKkwoOT0FErHUsewbz/F8q1i0WFftNB1+6+9r+xQCp7vN4V2cHQz/GrR1o7gT0nJ1WyNNKOg
 xYAUm1L+NDWnJgHUU58u+gbCnLdUiXA+eUJ6x6S1/+INMCjdKLnT6FcXzLoKd2EHNfJpTR4+E9a
 I/V+D2Vyzqt/cvlI81A5wj13PNTCcAdo0uF83wxocZd1MSykGOxVvpojcuxGCzibuLDIkbt5LdS
 SKsfbLHN2PeUrl9kiwC7XnMvQ6Pi9A+fihMGuEcDaTLlniEAQcAYatNqiToKFXWpj+T1lGs3nEq
 tWIiszYx+blgcl01WTMq/sMD/b16vsijZFdTreNFdhjwG1ouxJtEdVR14WBsZ7iK/JAQfWh3R3V
 M7O6R4c7gOL94Ctx3pdKOtf+Vl8MKBQ8+JxxyXamFlShtu+3tPD2VZPH6OcAKxdOnmJt38/3O81
 bnImXdzPzdJX/vb0c6xMQ==
X-Received: by 2002:a05:600c:3b26:b0:493:e3e9:85fb with SMTP id
 5b1f17b1804b1-493e685f1f6mr113555855e9.20.1783681157419; 
 Fri, 10 Jul 2026 03:59:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm51946175e9.1.2026.07.10.03.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:59:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 8/9] include/hw/arm/omap_dma.h: Move to include/hw/dma
Date: Fri, 10 Jul 2026 11:59:06 +0100
Message-ID: <20260710105907.2570621-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710105907.2570621-1-peter.maydell@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

omap_dma.h is the header file for hw/dma/omap_dma.c; it fits better
to put it in include/hw/dma/ to match where we have the .c file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c                    | 2 +-
 hw/dma/omap_dma.c                 | 2 +-
 hw/dma/soc_dma.c                  | 2 +-
 include/hw/{arm => dma}/soc_dma.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/hw/{arm => dma}/soc_dma.h (100%)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 9e739a0712..0f78cbd410 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -32,7 +32,7 @@
 #include "hw/sd/sd.h"
 #include "system/blockdev.h"
 #include "system/system.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 1a3ae74726..16575e73b7 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
 #include "hw/core/irq.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 #include "system/physmem.h"
 
 struct omap_dma_channel_s {
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index ff890149ee..4feb22e6ea 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "system/physmem.h"
-#include "hw/arm/soc_dma.h"
+#include "hw/dma/soc_dma.h"
 
 static void transfer_mem2mem(struct soc_dma_ch_s *ch)
 {
diff --git a/include/hw/arm/soc_dma.h b/include/hw/dma/soc_dma.h
similarity index 100%
rename from include/hw/arm/soc_dma.h
rename to include/hw/dma/soc_dma.h
-- 
2.43.0


