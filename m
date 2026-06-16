Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5A0CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ8j-0004sp-Fd; Tue, 16 Jun 2026 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7W-0004T3-Pt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7U-0000qi-ID
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso2636345f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636803; x=1782241603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8h8osnRLiH8j4IL2dsHuh3ADZfsc9tApZMqf6knJ0K4=;
 b=NhnbSb8Q4bwyExAbDA9TB79jU4GDncZ9McLlAtEP6pd/Wwl1ZOAgPkGEUipXGm22FV
 3G0DlSHN3PeZsrx/k8mpljiLEZuGKHvZbHpnJ29gtDJgOJSkzsEp+LFkVGqhUAgYz0z1
 0wzQ05M9wc4YdhEoFqvSIOMN5m/uz++TVCj9nnFpU1e74arNk5hcq3uuB1W94MUx4ZOt
 g2BDCmOr1bkv+lwbqmU0UqtWJh/3mTT/Ci4vLwAzJWRA62vKniT4io+gCH4hpq4J28Ao
 U2gfiv+SucUUKxaJ1In6npyee+8NvviPVtXc7C4uin1PPWrjj8jowSv36cQBooF63u1h
 jlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636803; x=1782241603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8h8osnRLiH8j4IL2dsHuh3ADZfsc9tApZMqf6knJ0K4=;
 b=F5/f3L7zLeR/18HB8NAKHzZLCPquOG7j7dfYtD79mz8HEXpWxdEXLPOGKhSSq6/xUS
 zHnISFU8V2ApOofvqdtFRQXar4YOW/HvQ7sTvBWYb3vE0/sf1RuR2BBwjJTvoG7Uw1II
 QdrpIYAeS9KWO8f8yascE5zdcGm87N7jEqz7MgikxWEnSNUYW9Fs+jgmsfcp4q0rSHTu
 0kJav0uUSuiMJfJy/Gs76hxKK6Fl/nmsObPQU6dA+PNT1SXa2Ey721jkg/2QFX/OLXR6
 Mrx9mG8HC11mH6psluflXXBhR8Gsrju94dNeAakfPWNn86yqJPd1lDdw1Hsox6N3VDPE
 raVw==
X-Gm-Message-State: AOJu0YyQ6GLPcunOM/CnPpAeUCJrDClru6jlFBbtJqQDqDggfMhSan5D
 iIqZE30+kIv5eStKtMns+nQZAdYeUoRtHseh2upt0aFMNJ4x6HVH+xtaPAh6J9sQ8OfBgnUd+Wf
 jg8ll
X-Gm-Gg: Acq92OFCZq5ZMYZXVp2InTwabjYIgvzXeVOSqdkdrPNNVGLHYviSdo78gaEhzYv3fSj
 Un0ors8onqoo02ouIfVeO1S+aSg1m6Cp/lL4y1zF08pL9rbMkZ3UuWh+vobTkhtBEgY4gaC25KR
 6BV2SjbQuzIqDlNH9LLDTUIDKHycDYhts1f4+X7u4e7Nw1vEDRwDPt/HwF7b3RJXW1HExvH4aLG
 HTXzgeb1YZbLAGpcOuFUsJm5xZBw4RR1E8DOV/mmn4/6V9LYgCjA7eaL8U/2vifnSQsHycpGvbP
 P9lwnrhCNlExghBQVWN2/Es6ZTgF3pETrI6kRROVkgVSgOTZdnIHQ87raSJa4ivFX7xgpC7f0MV
 6rm1jELw78x9dpSMleP7m+bBXzZoNtebyXNr57e1hySvRSfKa2fjln8VRl8n1qy0KDfdZ3cLRDA
 38b2FNXZHuVlcfqbU0RFhNoj4tiM8QnTGUZ3R34NzjrJ4gypZbeYsT8eS65o3vjBoGDzANnh/5r
 yyWPywu1M3pmKpGAftP1gaxg8h4vsvr
X-Received: by 2002:a05:600c:608f:b0:490:c0d8:d517 with SMTP id
 5b1f17b1804b1-492333ba2cdmr15020135e9.3.1781636803003; 
 Tue, 16 Jun 2026 12:06:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/61] hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
Date: Tue, 16 Jun 2026 20:05:39 +0100
Message-ID: <20260616190639.3462006-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Add a statement to clarify that the host SMMUv3 must support HW-accelerated
vfio-pci device assignment when setting accel=on.

Reported-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260608174900.2227340-3-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0c65dc8c91..6b5035e11f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
 
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
-        "configured in nested mode for vfio-pci dev assignment");
+        "configured in nested mode for vfio-pci dev assignment. Please "
+        "ensure the host SMMUv3 supports nested translation before "
+        "enabling.");
     object_class_property_set_description(klass, "ril",
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
-- 
2.43.0


