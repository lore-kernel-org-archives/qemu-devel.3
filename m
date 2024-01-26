Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C454BC48286
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHE-0002Gm-NO; Fri, 26 Jan 2024 09:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHD-0002Ff-Pj
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHC-0007tU-2c
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-337d5480a6aso487966f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279628; x=1706884428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JzJ/7eGoWRxiuO78ttkuN8WfwtChGDxYPbjZXcNs7S0=;
 b=B0ACAv7fT12PNpCMol0VcOYaw+vLXgio5Ym1tZIexynC/5l4hEdfCa+NcSHU0oDilf
 hrKfDrwd76Pr2d0nEMarAEJFK3M0cgXrNGGuUiA6wMJCxK+FJzX1xz4fn9zVEzzUU6sT
 DUjV3DBgCeRNgfcMJWKk+Ycvst7xGr8ijH8xhm2OHrQ+N+oRxM3TYkBhD1ylBubj/HQ/
 3uraNNMcgiWsIC9IUcRuUzOuO78JiyS/Vb/awO+gf76b1J2k+7vv/u4G7fGpSy2Fn3V7
 /9id/jQQev8jDOM/mIlUTY95npSQzRouZD9rMxuobDJqi0Q4MKUiUqsU7Ua+SB3gFOEn
 xMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279628; x=1706884428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzJ/7eGoWRxiuO78ttkuN8WfwtChGDxYPbjZXcNs7S0=;
 b=GDhzP7Ez9anL/rzbZNLWwe5+u/rgpeZyzExUcyKshpWKK6T48OqcIQtyhCtAGx/xgm
 5nmT8zUAPQKAZUQCvlFBK3pikrP/f5RS4u4LqPoMHiPiwq8yNoF9a+cfgEVoR0gkkp8y
 qlRHIz6Ke4l/XX/Q6EGJxv37IAv72WFW13sfBHExHiVrMpBA2Q6ThnNo6gsJAEyG2H6P
 kGYfJtXlfz+/mgm4gCMvYklCZEfQZfLVtUA2qZzB+aARkUw7VfRIpBkgYlqtCKHdPdzr
 XQeEa/EVN8WIdvP3AlOCj6oG+V3VfL6AVkbyJPHVryHG3TqU0KZD87fXe1ZsegFckZdx
 R+RA==
X-Gm-Message-State: AOJu0Yw9aaImmhRAKBaeyqYD1cNw484Y7PpTfgDo1bD3tmf7Ux0T2ZdO
 BxgvVxsJeohxraJSfch7oR8OkUFjlbfzK1u0CqA7RlgiuCz+EBRvSyszoq+fXu4r+qN2NQE2LdU
 h
X-Google-Smtp-Source: AGHT+IEYW/XKEx7QEZnUd75HtYetV1ZW2Zruh+zRCuGXnT2aG2ImJ6qEEdLTySM8rfpvDWu4hH9B7A==
X-Received: by 2002:a5d:60c6:0:b0:33a:de66:49f7 with SMTP id
 x6-20020a5d60c6000000b0033ade6649f7mr226593wrt.51.1706279628740; 
 Fri, 26 Jan 2024 06:33:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] target/arm/cpregs: Include missing 'hw/registerfields.h'
 header
Date: Fri, 26 Jan 2024 14:33:20 +0000
Message-Id: <20240126143341.2101237-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

target/arm/cpregs.h uses the FIELD() macro defined in
"hw/registerfields.h". Include it in order to avoid when
refactoring unrelated headers:

  target/arm/cpregs.h:347:30: error: expected identifier
  FIELD(HFGRTR_EL2, AFSR0_EL1, 0, 1)
                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b6fdd0f3eb4..ca2d6006ceb 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -21,6 +21,8 @@
 #ifndef TARGET_ARM_CPREGS_H
 #define TARGET_ARM_CPREGS_H
 
+#include "hw/registerfields.h"
+
 /*
  * ARMCPRegInfo type field bits:
  */
-- 
2.34.1


