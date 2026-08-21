Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4DC5DF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN02-0005zi-7d; Fri, 21 Aug 2026 07:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN01-0005z8-6x
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMzz-0007D7-QF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so509807f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310082; x=1787914882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QE965lMr/HTaAiZq82NVo2yDpUktkO6jaARbdLF3It8=;
 b=yeALE+Zv8G+0ixQ73k++cm9gpClnsYG7H6mkwC5DM7aKLPUF4ghGgOFRBTW9TA5BEI
 zL/bCW2XpV8VL7fMf0qzN7hXdPIpAkKcQYlDTp8KFxQ28Zl8eiDenEplVpHL31pieEva
 sD/Sh8uurR8GYJbU8w1E/KP4aLfbaAqF5jIj0zyNZkSon2EGOGO8xU4WjTb9fZL0/9N+
 W1yTd9ggjK7jayxhZT7pQLd1dPXJch33iU/4OEznsmdeE349iR6ZR0njGJd4dKjBRkqv
 NgRtbFsN1eEhnpd4aCbMEdvKzl2m8yU50876N98TYu8Rx0SUd6OteSFE5tNvrf92V7JL
 dWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310082; x=1787914882;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QE965lMr/HTaAiZq82NVo2yDpUktkO6jaARbdLF3It8=;
 b=DBM6VO4+Epz0/+IPjUHOft2CUvSwD4vUd0/nAzbjgmRckcfrx66TQUgKnvBuGbmKY+
 4B6bhHipiQit8XIiKN05EFZC70ivH6hnJsWBQWu+YTf19VR6BbJWG9x89k3iosUB304o
 xZnyLq3POIoN1fyDJ9mrNUxnolGHOD4YqEBeknXH9LcYCe5dC0ubRuNL6mcNa1C9WAak
 0cG9aR0b7cQ5+uYR6vkn7jac4wrgihd40Z3KePpdbRDLKXRlCoXZp8ZLU/0J5MngD7RU
 jb729v3N63obWD4bPrE75OqOUiYVK1DKLeyLy4AspTDcwlpxP7TeO0MYat2RvDOT9o9G
 7xsw==
X-Gm-Message-State: AOJu0Yz8Cvap8r82NTkj0h/qgn9J9rQuKCyKIQFV1GKoceWfGp33oPRp
 m+leIH875OmTkNqsLAhCTXL8tS+VNkXWOdT85vju6PEWBeYjv++EeUA89ebB0Zh3dCJDLrnaGSP
 zI/kB
X-Gm-Gg: AR+sD10GhixjhoJ48xI9fZVwRVHdOyKQv3oKprszI1leq+0dHsNwWOkUm0lbaK0dMcD
 Rz1mgv6az6LdSTCLhxoSoEZtKriZ9pXiLlJKTmMNjKVPnonzPRiv3VxN+mGswNVXdVlhTHuvncX
 3jZFSUA/l5MBIR9KqYUUOAS5nDzumNOJWkcvq2b+xTqjMO46i4ebkO+fUJNqrMeIr7F/HETKf/c
 EfOrbZ5B8YgDRgCuWT5ZEghKO7rZxYzQGAU6JCotULGTwStGgyWHCWc1uA6l1PQ7t15iF390Wcq
 D60pC+3unY12xG3TgllamknDEyB9xVKGWig+m8+HGS6NPCEu2G5yC5ot3F1hq4JAT5ljLrldwGX
 kMo0qpOAi15ElfaQ6jX/xhDxy0M88ErAsMhBeJLJ56hXm5We7jpXN2w3DmS6u/B5GvYnSYKlK1e
 pDA3KblvpbudFNPmNDPBniNU1WhyDF93I59l7Vjbma48ITNRLJ1CoBY4bLa0kKaOXXGqEEWO2cr
 zOc03lQNz9uAM44EzJGaUW5b5reKF53P/r3SYAVzxpTwAE/pdd9v+RNjl1M/yY08DEsQziGJaYs
 ZEE6
X-Received: by 2002:a05:600c:c16f:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-499b82e894emr82738655e9.10.1787310082219; 
 Fri, 21 Aug 2026 04:01:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/43] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF
 and WHPX
Date: Fri, 21 Aug 2026 12:00:21 +0100
Message-ID: <20260821110101.3971391-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

While trying to fix the GICv3 dependency on KVM and WHPX in
commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
selects GICv3 for TCG, not HVF and WHPX. Fix that.

Cc: qemu-stable@nongnu.org
Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260812220816.94034-1-philmd@oss.qualcomm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 097de4efc5d..05e697967d0 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -26,7 +26,7 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if TCG || HVF || WHPX
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-- 
2.43.0


