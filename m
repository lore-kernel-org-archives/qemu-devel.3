Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoU-0002Vm-Kr; Tue, 12 May 2026 16:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMtoC-0002NV-Kz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto6-0002M0-BC
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so63386565e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618060; x=1779222860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3NAiTAfegLCQ/OLLPB4B+cxnXyrpZH2JxyUa0rKHhWk=;
 b=Fr0YW/BAXEA79YpL93NUyiE02u5a4ReC8pPZN8CxJT9LEFD6OrUBw3ak5RTyyhCqRt
 +ZG+Ps2oGfvzltXpMpoRMoNo2Hjhw+9pqG4Duo35zELVxoBUC0Vgrvc7eKautS86v3Ar
 arqec3odCKbM5W4tOaTezT5/fFFNyYRWQ2pi1ZeX6Yt4DaonROy/zFmw+HnbfxwUPRxg
 paZ74pwybMmLz5LYXxdP67JfKKT4VOTBIykbUBtIZmsXX76+GJDPmneXv0w+n9dAMh1v
 DP1v1DEnn0hV2etW2JY2K4X5aZ0tZ7hGqcHBgJY84KNf+LeYtdLBoeswAhweMvXMDbc3
 pnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618060; x=1779222860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3NAiTAfegLCQ/OLLPB4B+cxnXyrpZH2JxyUa0rKHhWk=;
 b=AGw8cOUFnihY64N1ipcHF0fR7RcWhAVWlseTTOUv1ifUmBs9WgrQxj/+ak0tLz7paw
 JrjX1CG30B6xhwarJFrQb5MHL1S8dcZnbkqNMrLTuCYepsd0JCic4v5kiW6ZrnydRI0/
 8EOHGZr1z0aYVAT2jajdo/pRNtRA4rPnms3saDFdE4afPxgGZmgUpuRV9q5XllEeKEmp
 2CnavGpSW2rmQBLPpS65W7rYOViEVFIUh4YrD47DoDEQHCXSHqYv9HNthXjRIst7EXBY
 hlVEM6w4MeHkia4kCr4uuFNUjUWfbMk2kaQ+OZvAGhM2iZE08pu+6L6iLtdEVZTp1nBT
 JSdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oN4qG56Xh5VRUXuWVfx3oiFKo32oDGXwFwsfvJa4QbbM07U/Jk738nOFNGI2WHHm1UCyRcnWXtnA2@nongnu.org
X-Gm-Message-State: AOJu0YzBLuBOMFIY+Ywq9aT+W/IlcFmwywLvwArTrbDNTDkLLfcIwUuF
 q3Bzpc6RybMK14YnsfImhXvwmdtksXBWGxR4EKpszJzhR8KQSg+h8+NpObK9fqTc0sI=
X-Gm-Gg: Acq92OELXRdFOYuBywQj8v8bYBzZPqnJrp/A3cpnUkFs6+3nOP+/qt/YPd7tJt9D1Yz
 TlAVUc2BWpyE610CWBqNNlMRooSVKzkwBudkem7+CuDOpeknBFy2ATlKrfqtwaMZR9cTARIH1td
 6iFvqosZ6S+6KxJcUlhy/b1vBRJpIIa6pxYo0Hm7IkKRm4a3HPYTk9/IUXfLorDRbdN58hq4SfI
 yevxEhHzypIHRUQr1QGeuejE4D4pG5taTmg3fbLXMQ325m1vVvqI49b7PyQFoky+Nkk2oJgh7Sp
 3kY2P54JHC8Hwv1iaS7X9QYUeOBSZ8V2o5p/sSsOpWVRYxwFTDvjmJ5p6hOOti4v7/9timE3/Dm
 M62JPvpPUtmqdT87PMR0SWQ6IFrLfBeQR3sENCW0lC2mBGBpoLLCm55IwKjqtZf6onMdlY/K1CE
 /LBwyKQmhFDWBNercDnSyDDNKwzudcCger67WIcXZUfZi1akgyi8yAm86DmdokSV+RgJf7gKG65
 G0AwE88i/8AOD6QbP3BPoOLRrCQ/jo=
X-Received: by 2002:a05:600c:3107:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48fc9a09fedmr5720155e9.11.1778618059875; 
 Tue, 12 May 2026 13:34:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/12] hw/arm/omap: Remove unused omap_mpuio functions
Date: Tue, 12 May 2026 21:34:04 +0100
Message-ID: <20260512203414.3633237-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The omap1.c file includes some functions which used to be used by the
other OMAP SoC variants which we removed a while ago, but which we
missed when doing that removal.  They have no callers, so we can
delete them.

This code was the last user of hw_error() in this file, so we
can also remove the hw-error.h include.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c        | 26 --------------------------
 include/hw/arm/omap.h |  3 ---
 2 files changed, 29 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index c9f9c3ef40..15087ba03e 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -25,7 +25,6 @@
 #include "target/arm/cpu.h"
 #include "system/address-spaces.h"
 #include "exec/cpu-common.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
@@ -2095,31 +2094,6 @@ static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
     return s;
 }
 
-qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s)
-{
-    return s->in;
-}
-
-void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler)
-{
-    if (line >= 16 || line < 0)
-        hw_error("%s: No GPIO line %i\n", __func__, line);
-    s->handler[line] = handler;
-}
-
-void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down)
-{
-    if (row >= 5 || row < 0)
-        hw_error("%s: No key %i-%i\n", __func__, col, row);
-
-    if (down)
-        s->buttons[row] |= 1 << col;
-    else
-        s->buttons[row] &= ~(1 << col);
-
-    omap_mpuio_kbd_update(s);
-}
-
 /* MicroWire Interface */
 struct omap_uwire_s {
     MemoryRegion iomem;
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 6ea47293a6..dc63323210 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -486,9 +486,6 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
 void omap_uart_reset(struct omap_uart_s *s);
 
 struct omap_mpuio_s;
-qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
-void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler);
-void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
 
 struct omap_uwire_s;
 
-- 
2.43.0


