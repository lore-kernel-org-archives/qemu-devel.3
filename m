Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28D4FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjm-0005ig-VJ; Wed, 22 Apr 2026 15:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjj-0005h9-7S
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjh-0001AB-Hn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0046078so53076905e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887987; x=1777492787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s3VV/CxB1aoNb5HqYi4Oo5q/7UC0rEptFV7BBd3/evg=;
 b=J4GBvlgLYNWeo45X0YGdbjOb2y1CMxFTGcK1W9JWxJ4a0weDoxKbDTlaMfLKJLMPdT
 8+ZW9V5f0Zhyb/vxzX/f7gQUazSLdX0mD+t9xEYub5Q8/e+mBHfu5rZGSOOR+LeGd8UA
 wvIOuDZbFAM6NJ+b6BNrKjKKRYZvctKFkcjrxN+zjmNGG7lB2LcLpFn63gB/+9bGWwFd
 OMP5zUPWp2zIoehra7+dZw6TSJ9gnnVXedjjCajB8G9i2FCQ6MdWKzPcfmSlT/7fu0dk
 YhtdWh5Bi889WM5MSnZoQ2JmUlYFJZGfee2wLpUbM4pgouzyXBpMtyX0yjEnUbvQFwwl
 hSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887987; x=1777492787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s3VV/CxB1aoNb5HqYi4Oo5q/7UC0rEptFV7BBd3/evg=;
 b=slG0cVteP+OEmCTpyYjzNixbUgvrbvH/FY1JjKDdIk/hNz4ld8WDnHFf59YhrAoooF
 4IbiNX21+Igj39+KBBufMS3osRzoEEOBRqv3NZ4CzuDubi3K+EiV/CXFVgMctKDvmR6s
 sAXVjyJx+DI29mGEJyCAJVkaAQOjomxJw9k53gEayYr2fgSCnFYK+Ai+ebjsjkKEFqGE
 8k75Ahd/sUuioOwkkkjUQo7yuayhHrdWMDS9eKiQ2fYRob7qm17LEP+O3nLx+IGY0hiJ
 r6Y3sFSSZulAYgrwwSAqpjk2ye9JP4CGmOO37+iTqox0kqECKFGhVlVe//TMOqJ4CJms
 L3YQ==
X-Gm-Message-State: AOJu0YzCb4KMS/9sOPpb91LyhBs/ewPweq1cysy8XqJedTTbAeE4nWjo
 81ZcX11rD04R8wZcyQp+Jy/7fd8Wc9Rw7Cn5kQ0Eq4IGfUHtJNym+13LHEpNDJtchqWlB6740bp
 k42rg4jY=
X-Gm-Gg: AeBDiesmGgm7NOL8gDRvsArm5lVA/UzqKLHRydTfniBkptnwWqOpWYM40n/oSyVoPjR
 qj/B0g5yHoLY31iYHPow8VOy4qStFlQmxv0XbyZWYk4U/Gkrd8kp3ARYZ++ibPPLiaEexYM1/rv
 Btuaka20pMbGKzxu69oqMbh877AT86XpXGj63mBD3B6yXgHFO2x5qBSdB1kvv7JYDgrNYhI82nX
 HpyfKVCnh7+VAlqRyup+SizPuVEZsKu5ibvfibtB3iNrBxMsJhZl7n038MqS9vIvmMCmXRn4zq9
 gUxwuN0d7tlFZPr4vsGqGW/+iGEw6YN/Tupqi7v5qFEfaPGvK/ieJS4Kz7Z+95Z3y0GHmFrbduI
 jpUuJQhVnDwnkV8n8D+OEZ4xH+04k6hBcA7SFvntsOr5C8WeEC7mIukhNhoFcKFfhFN2eBGYdK0
 agAQF5YxsGcsG/aR26+v85IWD03ySzlP2risaPt/O2gXFqsJFqd4FU8PcgVB+QtG2TGqGdd1blW
 TnbMgO8AtU=
X-Received: by 2002:a05:600c:4f49:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-4891ff176bamr206907115e9.1.1776887987447; 
 Wed, 22 Apr 2026 12:59:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4896c2a1804sm111811825e9.4.2026.04.22.12.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/48] hw/tricore: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:15 +0200
Message-ID: <20260422195746.88865-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-35-philmd@linaro.org>
---
 hw/tricore/tricore_testboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 60772d4f1d7..d5d796c8eec 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/tricore/cpu.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-- 
2.53.0


