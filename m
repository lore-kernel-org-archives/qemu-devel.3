Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465A4CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11K-0003UX-Ml; Thu, 07 May 2026 11:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11B-0003PB-Vw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11A-0003lv-2E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d75312379so1493606f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169121; x=1778773921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wbux916U6XlS/bYu86AQohdEy9iAPtgneA9MemaZ2OA=;
 b=SxgF5OUIo/4aLV2rPtBCAvXS/6WAKf2BU7fUX0IvX6TBRU96Rt65yfU44BUvQhaZOG
 OEeDa5c+L4R2HusHg+fd4MwPMZRAJnH0MuwSXWg7tO+WnrTGaLH0VVn1f0XpZDVX7Tm6
 2OixwbyKoM6E1z1caZbXmcIMvfnkmhzpBoInLwieI3/vSfG9WBCIFG/JY2y1tHWkkd/H
 70UtorovzlXaQnTs55qstEf8CUDlROFrI2auBxiEsryE4hJFKl50BYXGKGzLoBQosW82
 MvuEHx5SLCaW6KV53mnX+9X8s0mAKqSzYhUAqkejka8Esa33kxvC3WcBM6mxXFj7aSSq
 azWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169121; x=1778773921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wbux916U6XlS/bYu86AQohdEy9iAPtgneA9MemaZ2OA=;
 b=b/9ibFLjKeXFlnWB8HdBbtNQLWz4JaDVV8JdHC6T0sed+wolcEAqpLRWudaighcSlF
 AiMYZFD4jFojElCX4or3nH6Nnk+5fKmlUhgb8hmYri9VzrpKFGDheVDyXCnoYqC2w85l
 1rOlHT6LqBVYdKK/6+O54NOV0pfJVs0APnLZjBNO4lkEdMq2LG+4ebRCs2pJuxm/MvB9
 ly1MKGIILW/qO3qSTDowmZ+YWD3jU92QW+sRBxxTJTFsgIbljyJoWIWCAXfRC3SbJnZP
 Q0ifkWgaIMGzxBdjPQyPk0j9aK35zZVdOk25PsfrY+5bay70V71b2a5SV9qIWDu8o1lo
 D6rg==
X-Gm-Message-State: AOJu0Yy2CqmlbYuN1kz84UG7vqch9CRn8rbP6sZDuu94m6v2YJ1R/bZM
 FAkBwhuFY3kq0S3mK56WEGTU3TLWMCq86eKFDBib9xyn8rilDe+GZiWozOP5Koe5Z8JAjc3mIq1
 gb20R
X-Gm-Gg: AeBDieur4m25R8Pk1pPRaO1EKGBOJ2WVfJL2j0+vGdj0yYs5NDVnZe1NMIWfq+qEfN0
 BblfuQmdS1/pEQotxh5KiIjCKrjXrL0i070gxsu0pNagGMt9FuBqFdETYuaJpWndH8U/AOKY3Q+
 ClWvjuXxgqNh6ooU5PXdtFuKraZOMTGz/t70zf9p74N7CuKxNgypf3bAYwRh/qF+yJNmOF0B+sJ
 Z23Y5rwbt3b8YQdUf+jrtHTQbp28/UreOY/vegnJbTIU2ATgNiMjb68CFo5jXH240jdK+qJLx4H
 IuqMmfjg8pucq0sDdMjlwfmcMfwRab2jr9XK+p2WmXttH3Es2i4r8yQUpB5FeL119RNHXjq0JY0
 yzhNNPS1aa/gVM2J9V9KftcRNLKaxrrXYemOwh3GguYrITujLqfRpbhVHmGLQUOnceSW5hXhoqI
 eak0XxGd+wLMN8TIWaOIdKx3lfvQtt82Mg3UIcIiw46OQNUjz8jG60LBrLT8mvQKAJJ7mV2fUld
 dIsUA7efTJAvlzp4jJtiBQeQWje1Q7bre7phIPhpA==
X-Received: by 2002:a05:600c:4f08:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48e6391c7e4mr5238075e9.7.1778169121313; 
 Thu, 07 May 2026 08:52:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/67] hw/intc/arm_gicv5: Add migration blocker
Date: Thu,  7 May 2026 16:50:53 +0100
Message-ID: <20260507155154.1886557-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
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

This initial version of the GICv5 will not support migration:

 * the spec is still only at EAC level, so the data to be
   migrated might in theory change before it is finalised
 * when we add support for missing features like EL2/EL3/Realm
   we might find we want to refactor the data structures we use
 * I still need to check against the proposed KVM GICv5
   handling to see if there are any awkward mismatches
   that might affect how we want to store the data
 * it's experimental, so for pragmatic reasons I'm skipping
   it to get the initial version done faster

Install a migration blocker to enforce this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-7-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3a9d566924..64bec16bdd 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "migration/blocker.h"
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
@@ -173,6 +174,7 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(dev);
     GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
+    Error *migration_blocker = NULL;
 
     ERRP_GUARD();
 
@@ -181,6 +183,12 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    error_setg(&migration_blocker,
+               "Live migration disabled: not yet supported by GICv5");
+    if (migrate_add_blocker(&migration_blocker, errp)) {
+        return;
+    }
+
     /*
      * When we implement support for more than one interrupt domain,
      * we will provide some QOM properties so the board can configure
-- 
2.43.0


