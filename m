Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9491C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg8-00075d-4y; Mon, 29 Jun 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006vt-1K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0007Om-Dv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-470174001a0so1361328f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734455; x=1783339255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2jGVng5hkuTjGzBl0GQQyq5EosBoiD4hMICnM+T1qsU=;
 b=J4UqL9jUBJktvDTWTV7K3csc5P3RHv9w05WH60lCLKr0U5IDylhJ8ZdVjOJ1OwIh70
 MRA/nI80su6YaCXknfeuoZEAzMXA9JwmRa3Woi0r9f7LXpYk3uXsf2q99oC/CkR+ealt
 RzI42w+UrQbNd0QrWY6XLJ4c57wXeEPc8Js00C++LVJFaPGNIzA6+2YEoYLwXO9RaLxH
 SJNEKjkF1E5i7tTvrfrBfE4SoUp5J75fX2xMAYQ9lVJObCWI8QCy5Wit5LKYKwt5rToT
 ZlQzQlEU0oIaGKmIMMQSUrnkiSgSOYmra8KU9Prie7rTkH09DgQim6EO3RvnbXp6jDkn
 6P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734455; x=1783339255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2jGVng5hkuTjGzBl0GQQyq5EosBoiD4hMICnM+T1qsU=;
 b=d3G+QwHYFwFZ+E3Qkjazg0mAfzEpnnKhapEzLAj5D55Mhkpla8W3JYDhqryG5Ul8b3
 of2JiuJRLdI+9Wq51UkFWTxCZECPqzku27iP9XZOjoEq9Ivglpy2jGVuaLg1zqbpF0z6
 esXReXdW+zpvtDZkT1khAVfmlR01FYLv61ZnPkoG/rzqiFT2k7Psbrd2gcZJzzwSAjx4
 RrHz7v9Kl123lCb/F/DV0cm46ieBs3PJgEXq+6DelRVc12r+0kf+n4E4sbbs5u2VP9UJ
 EPIgmBb6Aa0YYcTgBWANz51hrtKHWXw/hdxsmgaZ2FeUn4VVNSFAPZwuO8G629vWZ3oO
 Zppg==
X-Gm-Message-State: AOJu0Yz4ERowtrK72nIWntAJwaPNi+pYDbhCQ1/FA9dJIRfzPq1gDlhl
 nDdVtHMwmnC5XlRdC4kamV0psqL65GXnBtp8E7qojLPQFrZPw5H3pxEM4wn3RPRjRMM13osjZiX
 KTZBJ
X-Gm-Gg: AfdE7clw0bgbEo4BIe1RLkGneOUHJb/oo7JLl+19RjJG/nDVSGn1dSvHvBzd4nz5SRl
 wEMa5LjWclxVITb47cupWH7SbcI9eYH+Gn1C4N0aBZjZSYw3m1Z6FPTy0PEiduvT1isglxxEQx4
 EGuCI0fhOO5j7TnFP61ztCX1f//bQGv3dPpF/mBYbg8oetPGLTYw4MIWShKjrSS6lXI8bL3j/dI
 9luA5/s6ivEO0Rn3WQBGnOZ8LOQjCcTJ2LcxcR1ZRmFG5qSr0ctYXtaMsy8hunzzJ0f0vBbAd0E
 +4dJge1aBJfLcqCjT9lIYyJzY2JvwVe2VNwQ1kZYMcGM3/zE6SCD2WznlJuOKwJ+ELwcRojCAf8
 fKsmI+Vh6ce3GSyDvvD08biA3ZhK/CSeaAGg429g7i9mjWJHZ6f5a21ORoLu/BrxOkQoEdcGqRK
 SXWfBx8iSMmvq4/u0Qe8NeZwwH8GeRfCLdIF/p+Q9G4nZ4FbsvRytgYrKP1Sn2VOtEzpgkxjWS5
 z90hKOcqioFFCQa/xfFIQ==
X-Received: by 2002:a5d:588b:0:b0:45d:4a00:b927 with SMTP id
 ffacd0b85a97d-46dc12df9eemr26459636f8f.31.1782734455328; 
 Mon, 29 Jun 2026 05:00:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/54] arm/gicv5: Add URL to GICv5 specification
Date: Mon, 29 Jun 2026 12:59:58 +0100
Message-ID: <20260629120032.1645265-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

The GICv5 specification has now been assigned its final document ID
for a rev A.a spec version.  This seems like a good point to add a
pointer to the spec to the main source files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260615105029.2898872-2-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c          | 5 +++++
 target/arm/tcg/gicv5-cpuif.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 6b1dd04991..0fa3d6b601 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -4,6 +4,11 @@
  * Copyright (c) 2025 Linaro Limited
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The IRS is defined in IHI 111701
+ * (ARM Generic Interrupt Controller Architecture Specification,
+ * GIC architecture version 5):
+ * https://developer.arm.com/documentation/111701/latest
  */
 
 #include "qemu/osdep.h"
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index dd2f696511..891cb2d3b7 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -4,6 +4,11 @@
  * Copyright (c) 2025 Linaro Limited
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The cpu interface is defined in IHI 111701
+ * (ARM Generic Interrupt Controller Architecture Specification,
+ * GIC architecture version 5):
+ * https://developer.arm.com/documentation/111701/latest
  */
 
 #include "qemu/osdep.h"
-- 
2.43.0


