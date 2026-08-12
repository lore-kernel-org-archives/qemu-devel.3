Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC3FC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t9-0004iK-KC; Wed, 12 Aug 2026 08:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t3-0004Pu-CM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t1-0008WJ-Ij
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so6516295e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537006; x=1787141806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tkXuodvBhvgTHSiWMS4cHbyjpWJV4c1pD//lScFO3VY=;
 b=Zt2ZDaYZiEBxeEqv8vuoAKn6Qu43lUax63ToVfM3xuuR5+HSRyA3B5EiJFkJIOwSSn
 yYnrjKMNQAP52/gtkE0NIWyohZyAGNdCPcig4hFVYHeXc8NLbbqqZH2xy+nJDDEeq0dR
 QK14TfVGDn8U1GN+9RJ4jUz1rAjPuvSgYUXFLhCQKyNHZU7l+ow5huIP3vAh6wk9eTqr
 avW6Wn5BoiB6g+6Ac+6eQ1wGMday6DgWXvJYpCwu+bvc4fGPvJTu/z/PN++kUvYIvrgK
 KLZ2yID/nvWijm6KD1hFYDuN0LR5MMGdcuKCYWXcoOeOGV73G3qM+OSJPDmLryBs0mEC
 i5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537006; x=1787141806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tkXuodvBhvgTHSiWMS4cHbyjpWJV4c1pD//lScFO3VY=;
 b=ULEJChBKDb2fVC+ci2eWabXVKLwCEyNSnPqeyU2XLBv7l9Oj3Cf6SxAe6dGANPfGzc
 I0BqREgC33up0I2seCSJ3RoIfQR5WNrcrOf54YeeyZEGRs9TmmjO0tSwaXmDmyED6y1Q
 KMWVNsOdQguhcR27ESByfX51P3meCozxbPlhKGKtPFhVRuHkUZj+HbD7uCTuFdZB6JH0
 M1Qy3gxx5VI/jIDK4W/CZ2XfqozbLaqA0C5NzWxLwW05/c6xh5xbxvLpnTxS1PWQMsdc
 uQIEAo6uOwjU8WbE/gMDd32/bJAVFK2nd7WkAJduiXRx0jy/GM0sl8UsJX5RQgsA3pWw
 UC2Q==
X-Gm-Message-State: AOJu0YwEhJZaTh+EF/gEuDODY+6M86z0/XCBSiY6mbd1dLVHyggVGPOA
 WA3JLyoKZUG6/tSN7ORC6g+0hdQfn3R8WJTlPw3hknPIspBVXMHQpYteeKs/kxpD7/pYdFI2UjH
 Pu+PZ
X-Gm-Gg: AR+sD11ikRPtbdeXyvdYLrSxmviTj8no6/sRKTWNK7O4EQ3CRD1FWPY88rwkq4Sfj32
 meSYyVvRo9nj5Iau01j0RmF3k42LuVT5OAi3xiBcR34Lhmf2rUnpJxwQAoG3f2MsRNFMKqfJkmZ
 nkM+lwXG/YnX6uRcr4YLbT24DfDqOYn/g27QQo3yxuBFjmfmajl7bNuZ85HRj+94OqngcQxkWCn
 oqG9Nu3iHhyUIdozP/F/HDkFASD2nWrJ8f6tYEkk5h720JN094l5d9FpS5Oxg0xCPrZY3Zp8HNR
 BGSLG8bQ/HOs01Ap3tHWSq+hU8sK1NimMBqQDlE1f/yN0KCCc42H4zU/jN2M/9DrNNjP//U/zbK
 F7hShO9sJgWInItFWYMfUFHVPg4WTP2+nOh9HF2SEZ3UL2P8zUix0QD49BOn82Ll+cmoyy21FAD
 UZEC5n9w1bLs2HeZaqwyX7T0MzFAkTj25Tn0WUKglSzqGj/Pt9Ytmil5qkOtt+G5DQhrOdzTTIo
 GLK/z5AmBqoOwnVHo2d/QQrlbfHOYXwAVnr405HHY9IEfcyKUlbCjeIdrhUOmlnRUG6mg==
X-Received: by 2002:a05:600c:6305:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-4997c0d7658mr51764725e9.4.1786537005917; 
 Wed, 12 Aug 2026 05:16:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/26] hw/arm: ax3000-soc: Enable Ax3000 clock control
Date: Wed, 12 Aug 2026 13:16:09 +0100
Message-ID: <20260812121622.649730-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Message-id: 20260713073033.3883619-4-kchiu@axiado.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              | 1 +
 hw/arm/ax3000-soc.c         | 8 ++++++++
 include/hw/arm/ax3000-soc.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2ed2c2c6e8..69161a439c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -730,4 +730,5 @@ config AXIADO_SOC
     bool
     select ARM_GIC
     select CADENCE # UART
+    select AXIADO_CLK
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index b528f8af53..aaeae11074 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -33,6 +33,8 @@ static void ax3000_init(Object *obj)
         g_autofree char *name = g_strdup_printf("uart%d", i);
         object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
     }
+
+    object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -157,6 +159,12 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
 
     /* Timer control */
     create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
+
+    /* Clock control */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ax3000_clk), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, AX3000_PLL_BASE);
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index b984d7a8ec..329aa4e769 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/misc/axiado_clk.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -49,6 +50,7 @@ typedef struct Ax3000SoCState {
     ARMCPU              cpu[AX3000_NUM_CPUS];
     GICv3State          gic;
     MemoryRegion        dram[AX3000_NUM_BANKS];
+    Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
 } Ax3000SoCState;
 
-- 
2.43.0


