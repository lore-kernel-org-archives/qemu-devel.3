Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0CFC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHN-0002Tt-LI; Fri, 26 Jan 2024 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0002LU-LY
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHG-0007xj-UX
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ee418e7edso6502205e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279633; x=1706884433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VXXpoqeWUrMcxrn/dztG+5/UTCdvQjyp/SkalnZboFI=;
 b=aMprNKQvN3rlL2x9qwwvKNbnR7OBp9Yqk5vXrIesirQgAC7ZWTrQ2H8M2YkmPvG3qz
 kmQSJ7K7aTopR34FifU+N3ThHpOO7e5W+xSikExzPz3o+rVQxiAdQSNSXivyv8vJYeT5
 6H6YxYU2+hkXiNQzmb/EusSNFYI5OGckqVeRhP4aSs8ERjkbRWGwXJoMcmuPt61msCLv
 oryLmKsa0z9R6gBxxnTpFa1nYP98uvHyrSFc80EwI2MmWNJ5qBbGtSl1ti6/EEqKecC1
 uvPqNM3WaNKoqp1MQC4Ag04ZRjstSqr6BrgFqQ0cD5XKnU4AGlyqEDPlA8umtEHmXScV
 HIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279633; x=1706884433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXXpoqeWUrMcxrn/dztG+5/UTCdvQjyp/SkalnZboFI=;
 b=AKOdMqlKoTI6EYW9yI+L5apMVh97aLHlFb6VEKVGRHzYnSDlx5jYp8vCjecq58qWTm
 98NaHnmgd8PfQFufbrUVbjvOjUwSUc/I/NP0OxmuBquCW4zxP3pXfQ595RVimxH2nCK8
 3eMn3cmBChZSvHMChl2W/WY4K5Ubr7clDWneHKV3RWpxAqoP28FlqyzEXVxUAhYrXNi4
 5ZLtRDjDSIBz7Q6mQziOre/h0dHhPewqKaDLoawe4l2WOUhy1yJaoXODOw0pagBf9KE/
 rLGqPc4jf9gqBBhDBaw5TfAmOAm0O0fvHY8shJR+8odbCtVCB+pYHcOmHRApQrKxQCxr
 52Fg==
X-Gm-Message-State: AOJu0YwMcwDhCWwKBVt+sfnHE0Vaan8diWoWyk4nZWcSD9JfHu095SJ7
 +djbxW7zJ6TKRF1xH4xmG79DHuEuiSjnyjjRNhDW/U9AywMHgmUchnLtWcD5mHGgz7imJoJ9NDz
 R
X-Google-Smtp-Source: AGHT+IFs4lSQsnfz/Sf5JbJSQsXCraaIgQARnUoxerCbfPQ4yreYxVnujAwx/RArxqACMI4FtWH7jQ==
X-Received: by 2002:a05:600c:21da:b0:40e:8550:4240 with SMTP id
 x26-20020a05600c21da00b0040e85504240mr1042789wmj.138.1706279633378; 
 Fri, 26 Jan 2024 06:33:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] hw/arm/armv7m: Make 'hw/intc/armv7m_nvic.h' a target
 agnostic header
Date: Fri, 26 Jan 2024 14:33:30 +0000
Message-Id: <20240126143341.2101237-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Now than we can access the M-profile bank index
definitions from the target-agnostic "cpu-qom.h"
header, we don't need the huge "cpu.h" anymore
(except in hw/arm/armv7m.c). Reduce its inclusion
to the source unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-17-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 2 +-
 hw/arm/armv7m.c               | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 6b4ae566c9a..89fe8aedaa9 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -10,7 +10,7 @@
 #ifndef HW_ARM_ARMV7M_NVIC_H
 #define HW_ARM_ARMV7M_NVIC_H
 
-#include "target/arm/cpu.h"
+#include "target/arm/cpu-qom.h"
 #include "hw/sysbus.h"
 #include "hw/timer/armv7m_systick.h"
 #include "qom/object.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 1f218277734..edcd8adc748 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -21,6 +21,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "target/arm/idau.h"
+#include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
 #include "migration/vmstate.h"
 
-- 
2.34.1


