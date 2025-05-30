Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432AC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBk-00028j-3I; Fri, 30 May 2025 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBi-00026b-CK
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBg-0001sm-O9
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so12417575e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609415; x=1749214215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aQl7yHd6lm3vT/NrnuTHJKuoDnW7/oV4bL5kIQbydng=;
 b=CjRRgSO+DrtWtyNzbDpYZYyIaZTgi4MTvOM3s4zBvXXo83TmJDVc4ysHNtSHH0EPrv
 BsbLAY73SuGYFXryviTqdtR/tkMt9N4yvvkW1xjOEAXLLbOEDobfsS4txlY4SUyAwEQq
 yw6vNGW9uNfgwqEMfH8qVLudgnEgL5nu1rwiqXETtPsjfoAcNbDS6bg21Wz1gfOo9v36
 43TyDVjtIlyGwWnoZfipWz/u4Xq2BwzKNZ6eN3AEl/OjrfVJ2hoNJW3D/m4Leb1MOkhG
 fOlN7OU16cJRSVJ7L13cMsr2/Pt0TKCzSh23H2dJqRKMniAHTP0O3E/VJefBBUqf/XvC
 RMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609415; x=1749214215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQl7yHd6lm3vT/NrnuTHJKuoDnW7/oV4bL5kIQbydng=;
 b=lhgjyn2OycHOzSve/1+eKHITfi9zaMSgj8DRg8Osd6RFiNweYnHD+q6U87N6YydRWO
 a5vbCbwqL09MV1fq1GeRt2rOpc9GC4TrHhJAc2RB8YLUNrxdHYRoADZrtLwudFueJPDc
 5r42kbYwoLCdv6macAcP2x1z+RAlmg2JIvKey5YR8Xtdz7Fti/yt31bUhj3PLr6+5Jl+
 2Cd3aJbf82aiAj5bPiknnBpsn1u4DT2hOOfNKLzdqe8N5Zo3cjDrPnMgibiZCJVUmIr7
 ZXZTHS5Rwwrgp0pGMY98OPy4I+b2M5VZG/aji0ldo5xk+JDKt5xOaDmWuKhiadezYez5
 rWPQ==
X-Gm-Message-State: AOJu0YzYjuoCXdIrBzgd0SsFafBOha9DNUS+F1TsiNM20Ki8eH/cDTmx
 88hc9trDqsJDpJdZkiDMTUGXOJJa3vRe3kAqsF7aJYNkw9xUIyDjBKanTQ7f5FCIKQ4D2mC5Vct
 bW7x3
X-Gm-Gg: ASbGncukI4Ib1wqOp5AIv5ayylXoClu/3j/noZHSyYjfM73vmUbERTn+dXqUMUuDB4U
 J475/GgjctWWVKWGS20gcChbmpPxQ+09E1TbfmMM0w83KKLHLkJxYUwC12coehCNafP7X4/2vga
 dsVq5SbDmt1gvpk7We93hbGXkHnhDoJxCZPARXKKgLOKCtVY3QlQVGs7+lKXAGqlL4FeeUEJJGU
 2fp2GGQjCKdxFc8XRD3pp7skbn54i4O5xhxAngmKQqNXbsa0X8p2KYDmA6s3ymMf5EUylD2cLrk
 xDtJERsKyxZfc16Sj6AgoSlyus3cYL4VTGMwqm/tYOlog4LlXHPteWj/2Q==
X-Google-Smtp-Source: AGHT+IHcVr4sqz7FBgRXyj9ljHZB/XR1C9pF8SyGRVmC1rn44W9ToucOQaODJsJbHrluiyV8vUq21Q==
X-Received: by 2002:a05:6000:4020:b0:3a4:d0fe:429f with SMTP id
 ffacd0b85a97d-3a4f7a492b4mr2464429f8f.14.1748609415034; 
 Fri, 30 May 2025 05:50:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] target/arm/hvf: Include missing 'cpu-qom.h' header
Date: Fri, 30 May 2025 13:49:50 +0100
Message-ID: <20250530124953.383687-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/hvf_arm.h:23:41: error: unknown type name 'ARMCPU'
     23 | void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
        |                                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250513173928.77376-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 7a44e092620..ea82f2691df 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 /**
  * hvf_arm_init_debug() - initialize guest debug capabilities
-- 
2.43.0


