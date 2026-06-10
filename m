Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39094CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXv-0008Jc-AL; Wed, 10 Jun 2026 12:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXj-00081y-1G
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXg-0005YR-W4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so3608296f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107955; x=1781712755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BoKYvhpRM62DBTZyJs1LhrLuI01hIhiG3D16LBlIpes=;
 b=a2SRE5QOakm84GzawcYFGZN7HTcpIeBF7CEitKuntxk5Qwt2sVNHXLY7gz5u/J87qQ
 jOsFgJWf1WyGOYhKpR3hzvA+mdhUzEPS9Li59Ebbc/382eYZ6DYJrji8V992f2q41Uye
 6INQeXr1AvvTZC+PLxuE1iiSRW4//lAvsHOTOfuxzewN1chL153QhPfg+LXQDUabvznC
 Jm4kC0VI/j/iWBsCVrzr4dZ6Ze8jP1683tLxpnt5Oy+zk7LIWw4LVZyOa+rmYLfE/QTg
 mDY0oT8RnHoK/L2XYiww1cYwenp9IfJrm+EHT0780vWmM4r/7vUJg4ruJMWAIZp9urCb
 pLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107955; x=1781712755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BoKYvhpRM62DBTZyJs1LhrLuI01hIhiG3D16LBlIpes=;
 b=jLX1gmNdhPeR1UQO5ngn3iC6QAoCwqdgtCbWCIX/H+0CA6stenKHMaqV37TDFLxDJD
 JTfvomsNjx3s9iRoQfsUm4ykU+k/6x6I/hfX2t9Xbrb28YBpBLhQcZ0v5D/0HhuRBKUc
 MU7voBUFv91sc9LcWyPYxxhVKDRDEG4Zw+j+/A/2pTLyTaI8dKQfV5BZUjZ9c1tL1E96
 9KTuFilG9I/xPH0NxZqSiUt/IXyriVsTCdtS33H4uaGUevM93lvN6hKF/MiOZvMhqgMt
 5R8hbhNNhcpwI90VZarkxKQiA28vdQXV8VTvuFkCdWbCRJFFwXoaOL1AG3gJz5tAgJtt
 EL9A==
X-Gm-Message-State: AOJu0YzcR8745wa68IINc1emo9RGOcKvhRyICfsgJGxec5KAIl5DMZBn
 FqdYvGo5fEUKruuh1TQ13D8I2csODKlOvSloT+113fh3DQ2L/VJO3rcprWeOIA4zk86+gjXhrhl
 PhPE3
X-Gm-Gg: Acq92OGDa48G5zIdhJ5AJdwwTm4U2YmeYy8iJL+c2qv4kZEo8G6nPskJ2FYc7NpDVsM
 k71CoEW5idsbATdtuMnHtY+7I5hHBKYG+xR/gx6+mN0ELEqINv4bh8zUR+O7QWETp+AWiHTrb/A
 AIHQku9Wmfynal9iFSNSccmfNtHy2MO4Vij3glhSxSrqeaTycv7GLM3GOr5ni2FClWdeZI0Pc5K
 +zimHirluqpYTN91QJQKThoIDrcmggnlIwXqLvOYeltnt6r4aB8NwOzoGHU179Sr4H4UBNdFOM8
 E3uOjOM2b5tO/kvFAcdgq7sfDhtzCHVIZeQk1i79QnIH7p7PeGyt7Gbi0POYQa1W+Nstias9Mpb
 TiVi+DEbd1xGX+WjvyhSepzZBSL+qqnbkmuWGiPoG31hPw88guzaipkmaiA3q7q/pfIUFEbJFJh
 anoV8eH+cmSD033+1KCCGP0DBmxbkcHL77BS+KNFPGkL8jVYMul7dkWDO/fxkLOjo5TUBzVyXQ6
 2qwneeuuDSgVwGaAmxlhC1Msu6CEfEZR2LBbOFf+rE=
X-Received: by 2002:a05:6000:1889:b0:460:1987:7bb9 with SMTP id
 ffacd0b85a97d-46030753534mr40205194f8f.29.1781107955130; 
 Wed, 10 Jun 2026 09:12:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/71] hw/intc/exynos4210_combiner: Avoid hw_error for guest
 errors
Date: Wed, 10 Jun 2026 17:11:14 +0100
Message-ID: <20260610161202.2235298-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In the exynos4210_combiner device, several cases of bad register
offsets passed by the guest are handled by calling hw_error().  This
causes QEMU to abort with a guest register dump.  These days we
prefer to handle "guest does something wrong" by logging it and
continuing.

Update the hw_error() calls to qemu_log_mask(LOG_GUEST_ERROR).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3396
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260529143624.158935-2-peter.maydell@linaro.org
---
 hw/intc/exynos4210_combiner.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index e8cac331e4..dbbdee4d31 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -28,12 +28,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/intc/exynos4210_combiner.h"
 #include "hw/arm/exynos4210.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
@@ -119,8 +119,10 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
         break;
     default:
         if (offset >> 2 >= IIC_REGSET_SIZE) {
-            hw_error("exynos4210.combiner: overflow of reg_set by 0x"
-                    HWADDR_FMT_plx "offset\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "exynos4210.combiner: overflow of reg_set by 0x"
+                          HWADDR_FMT_plx "offset\n", offset);
+            return 0;
         }
         val = s->reg_set[offset >> 2];
     }
@@ -183,20 +185,24 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
     if (req_quad_base_n >= IIC_NGRP) {
-        hw_error("exynos4210.combiner: unallowed write access at offset 0x"
-                HWADDR_FMT_plx "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.combiner: unallowed write access at offset 0x"
+                      HWADDR_FMT_plx "\n", offset);
         return;
     }
 
     if (reg_n > 1) {
-        hw_error("exynos4210.combiner: unallowed write access at offset 0x"
-                HWADDR_FMT_plx "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.combiner: unallowed write access at offset 0x"
+                      HWADDR_FMT_plx "\n", offset);
         return;
     }
 
     if (offset >> 2 >= IIC_REGSET_SIZE) {
-        hw_error("exynos4210.combiner: overflow of reg_set by 0x"
-                HWADDR_FMT_plx "offset\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.combiner: overflow of reg_set by 0x"
+                      HWADDR_FMT_plx "offset\n", offset);
+        return;
     }
     s->reg_set[offset >> 2] = val;
 
@@ -245,8 +251,9 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
         exynos4210_combiner_update(s, grp_quad_base_n + 3);
         break;
     default:
-        hw_error("exynos4210.combiner: unallowed write access at offset 0x"
-                HWADDR_FMT_plx "\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.combiner: unallowed write access at offset 0x"
+                      HWADDR_FMT_plx "\n", offset);
         break;
     }
 }
-- 
2.43.0


