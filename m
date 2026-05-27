Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635A5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZh-0007NL-2a; Wed, 27 May 2026 06:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZY-0006rW-4p
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZW-0001Bv-EC
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so41364855e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877988; x=1780482788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S4ewCtYoMbKHGyJuOEflHcyrRInXBm1KDdL1u93WBFI=;
 b=XKpoAJxNuoJJPBew9+Euy2B2xWRmY9DX6xY4c/xyYfPcobl5P2OBWlhxYmcu5Fuj1a
 sj7MVl5Jhlm63D3BetW2DdjzzXDhOVy0nbFZIUieToKEVYGlaT6ECYN5FrTXtVZlQ1Nu
 S1hAtZFOkwgQCTXPgsr3/O/aOixMYSU2Z2QxA1of8Lvqyqh0IQ1YvG7z/fFzGDM2Nauj
 DxhG+qvTuY6ljQ5jJ4GnnP1Ss1UpE2tCmWFhos8CvDxiA8N7C23WN/GCuNMd872xqLt6
 BGdjboRAXRIv31s2D6BBIzIPRYo/Aa9dadKnxjYFnsWxRBGFqx2rTkjOhLXBEvCu6ehG
 4V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877988; x=1780482788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S4ewCtYoMbKHGyJuOEflHcyrRInXBm1KDdL1u93WBFI=;
 b=bMysFpf8YFH5Ba+AkrXeJ4chvj4kvaIry7RGLfln+L/HfMnC8PDytzKeb6gP3bBh/B
 VgehxbzamQH1pXK0SXjcGa3PURxOL5fBmBX3YKNzjx8Z4gcATWeK97k0goqWZpURPMNZ
 PhivEI7vJAUWxoQoD+RBG90FcoVH65GJ8LpH2cjrM4tH0wGjYhYHxX/rtsUB8sSZ0wM8
 zc5RJ9MB280u4WjjSYiCEOIgCfEeBTCiCZmDeXAxC6rW9FT7cs07fIgIw86nVavjjduZ
 Kj+AI//61eopue5pk8pkpO1/0aRvd2n6CSUMxTWyZRjDImhCWbS0Or4XnZLk1so5G28U
 3hgA==
X-Gm-Message-State: AOJu0YxF55xk28z4qcHwS1lVcC8ly1q8+yon+ss0wOXAIzgmo4Lvbmpt
 D41rCYv+s97wgeZatTnkMda98CKY8WCa0nxT7VGEBiMyYkCsG5jVMcdyQNhiGsA2kHNH9U6MwHA
 jubxjVE4YOA==
X-Gm-Gg: Acq92OHoSlq3oeW1T1gJI6eAZ82pElLyA1P9YPnI90uFn4+XY3MXprIbqa1RkKG/jqL
 K8AB+XFSbNHryn6nUgJeE/AnK4TeVsuAwlL56NrS+eHd86JsVRkVRf60+jc9UG3P1xn0HBcz9LH
 Fqqr6ugIijPLxA+4LlNIS/iLukMNbWpcJ6fhivZQe3CbUAz9NpNlnd6J0guNTuQtVfWnBsL51aY
 vRmBQ3vrgULY+rI2z4jHo5sRdFxo4CmyT+ZQ3CKdDBLX/csxxelhC5gjV/m9QayCRGYmqR85suX
 0iauJ3D8xBK3nbZ11fnWLCaIzapiQJ/UFvmRQBp0zGMgfhgRTcRUaijdaQJ8iILUbSpmXifvqsF
 rIhQ1VgODI2v7H+fn8PrFzGJjGH5+pddkWrOkdXTS0ujoIsweZXEHz/gglfrsXNJ6UlJ4Q9sZEd
 JJyImdE8d9NbvH6Gn/jOPvy5i+C1OfDvyR5Dn0skfK10eAv0KCi+3cVHLij9SX+wcYJw==
X-Received: by 2002:a05:600c:6383:b0:490:4717:970f with SMTP id
 5b1f17b1804b1-4904717984dmr368181705e9.14.1779877988415; 
 Wed, 27 May 2026 03:33:08 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490838ffe14sm16439365e9.2.2026.05.27.03.33.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] target/arm: Implement DBGDEVID* registers in max AArch32
 CPU
Date: Wed, 27 May 2026 12:30:26 +0200
Message-ID: <20260527103037.4461-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

32-bit ARM max CPU is a 'Cortex-A57 advertising none of the AArch64
features'. Keep it as close as possible as the A57, by implementing
the debug ID registers, following the changes in aarch64_a57_initfn
added by commits 48eb3ae64b3 ("target-arm: Adjust debug ID registers
per-CPU") and 09754ca867f ("target/arm: Implement AArch32 DBGDEVID,
DBGDEVID1, DBGDEVID2").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-12-philmd@linaro.org>
---
 target/arm/tcg/cpu32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index cf643ce43b1..2e8afc28602 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -755,6 +755,9 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
+    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.dbgdevid = 0x01110f13;
+    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-- 
2.53.0


