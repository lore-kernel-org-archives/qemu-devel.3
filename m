Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF64CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNw7-0001Mc-Np; Fri, 08 May 2026 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw6-0001Lh-Ix
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw4-0000xO-QG
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1299855f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257218; x=1778862018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaU3MPZPkbJoZGqSP8BLpDOjdtgxC4ERc/Yo5Hf9mI0=;
 b=Vt9FRWifByWBTqsDttJkPLRfT9W/JlkFjr5VOzvDfb73m7OjJsTmLF/iDitJmpqame
 v6vYGEvTO7RYo/QUUXSHWRBvdXEMqZV761CmDwZke00rftnHIrvO2rQNFb/9kJO5H6cb
 EeBqiYaOFCAPA5cvkJpDZQvBemUDQrv5nn+bki9GlJ3wt31qIhD8PcRTnXJVohggMt5x
 kUuCnZN/Qe3WZBqhhyKBIa+BVamIUS/nZ4U1cu1P1bznRCSL11Cl+2MK9Jjdqm7UEtLN
 yFFPGHoz0/0wUZSs29g4O08LWqxbCU6pLQnk5B8xv7lYhqalJQDSkMJPOO9lkSIrMFuW
 cyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257218; x=1778862018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OaU3MPZPkbJoZGqSP8BLpDOjdtgxC4ERc/Yo5Hf9mI0=;
 b=du5iQVVp3sCI48RKnHcwAAGllnj3DJoCwTEtCpiZqe6gcMXvB4L78mnRePBKomKs27
 tnB7bnQL9dJZZuj+2x+1/Uri+jEVXIiwdoLLjG60rJBRrIfF214mD3jyZsoF3B23Zsot
 +JRr0CI0M6hLN2nDbnyXxdW/M4CgCArlvKw7LsUZyiimuOUhVo/jlM4OOs15Nka4RCFQ
 98fbuJ8OZtxh4wTupP/x0WbtVSzwimdhRPHELKmP7SOyUiTpIVkcvcTwWNJqpFK+6v5w
 9JBllwyk9b2AuQEqQIRN5FEclmhfgHOINvCl0sVfhFCMZR3FsBG4lJbRrbLzJ3V0mmcJ
 XN6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/66nw0H5GR/lVOPmlZwFHuYU/QYEZJA0FukdTplpmdSUXsLWfQODbr2O59M47EfYCD8Xkb7GRkjetB@nongnu.org
X-Gm-Message-State: AOJu0Ywq1mgYHJCMoFwKsZw0A0pp5JHs1e65Nkqh8emNMct8fAiDpWxr
 keBZ7ynRcoCBAmTLTBQR7bUC/CiTXUNLmAAm7C5bhkZdDEklcOAW74x6qUNxc+80rX0=
X-Gm-Gg: Acq92OFXt2rgalc+ivz/BrDLRCrSflq5xIa2KQQHx48onQTGKDehbd3zK68pDAJvmhW
 BGz2dXdHXlJFg5aDEWNxmHd+3VtL0S5tZbhelKl9SZkRpqUHHdQb0UWI+h7xI57Cr/KYDN72Rol
 CM6nYD4Gl8ri4UXpkGo+jsGBYOH41E1gGwKLrUF7qu9KqfbCeYUfWokjoRfZCRJpjvIB97nlVTN
 CEDxaNJFAlqHqDT4eLPHnORxjeynZfGWy3kQazvjhYBYUB5R13EeYVBIU6+Q91/WGYVr806Urhm
 Y66cmPK3nfyHTeBvrqrVrtYaMmDrcO5pdED+apwyEQEodmkuK38S5KeAK21vt5TEqqG1+qSzqI3
 feaWyKqO0HvqR3Ta0OBnMwLttKjV1uZDw5uo/bhQvSg5m+znvfi7vFTvH66cWEeerBNXy+qKqa+
 cH/gFolZYhwq+eRj1UPzpSGWxgbkvChHIe5x39h2ifWaAKktJ1vxZAhyAGRfGAp/76IgRuAoa2k
 H1w/u8wf9sZLBTqfPHnQqlD5zZHexY=
X-Received: by 2002:a05:6000:400d:b0:446:96b1:f5f with SMTP id
 ffacd0b85a97d-4515b05717bmr19014283f8f.8.1778257217860; 
 Fri, 08 May 2026 09:20:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm6226998f8f.10.2026.05.08.09.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:20:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/arm/integratorcp: Use LOG_UNIMP rather than hw_error()
Date: Fri,  8 May 2026 17:20:11 +0100
Message-ID: <20260508162013.2751001-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508162013.2751001-1-peter.maydell@linaro.org>
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

The integratorcp board has some onboard registers which can be used
to raise IRQ and FIQ to the CPU; these outputs are supposed to be
ORed together with the main ones from the PIC.  We've never
implemented this obscure bit of functionality, and instead call
hw_error() if the guest does try to raise an interrupt this way.

Replace the hw_error() call with the more modern way to note
unimplemented QEMU behaviour, a LOG_UNIMP log.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3406
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 164af03f7b..c25bbf3c82 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
@@ -178,10 +177,17 @@ static void integratorcm_set_ctrl(IntegratorCMState *s, uint32_t value)
 
 static void integratorcm_update(IntegratorCMState *s)
 {
-    /* ??? The CPU irq/fiq is raised when either the core module or base PIC
-       are active.  */
-    if (s->int_level & (s->irq_enabled | s->fiq_enabled))
-        hw_error("Core module interrupt\n");
+    /*
+     * ??? The CPU irq/fiq is raised when either the core module or base PIC
+     * are active. To implement this we would need to run these signals
+     * through an OR gate with the PIC outputs. In practice guests don't
+     * use this, which is intended for an external debugger.
+     */
+    if (s->int_level & (s->irq_enabled | s->fiq_enabled)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: raising IRQ/FIQ via core module registers is not implemented\n",
+                      __func__);
+    }
 }
 
 static void integratorcm_write(void *opaque, hwaddr offset,
-- 
2.43.0


