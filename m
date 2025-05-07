Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B91C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ3-0000Yb-DX; Wed, 07 May 2025 19:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPl-0008O4-3j
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPj-0002Vb-FA
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e6880d106so3269035ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661378; x=1747266178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfHS+52V3f05Qs2m5d7Nh2wTK+yUmoJBcA8DI59GOAc=;
 b=fEZ9s1AVvoLCHCvDi9LfsoCRaK4fwaICEaKeFRVtMxPWdUlVP9ixUtTc49DbZ/clGO
 NEzfRq5MFSUMjf0Uw89IsOiEQdnLebxIV5ZuQ1Xq6S86ZsJuhKSW0/huat59/H2/2aDC
 ZOCFnLXyV50EG2+uuKUIeF/39PWeQsVwS9wXg47mVqxzrZnPBLXRcfZdt4PHdhxYPNDA
 JA98aFpWkHqLDeCzSXIbqFK+vTywxmeyhAuq7lfEgfc3BRpwPqwpjcHEqRl6V7FRUYOr
 sI0NPMbigY1dP3YPId9yRz7ek04UXCYN1Hjg8J18OseJN/FX3KwzqlvY2z/FPIA6IPKL
 k+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661378; x=1747266178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfHS+52V3f05Qs2m5d7Nh2wTK+yUmoJBcA8DI59GOAc=;
 b=nlzaNIU6PRrbHp1ZZR08+VUcB1OCkzC+Jt5ZVQOif+M/wvuQKSBFohenL1kmLQmJUV
 Jdc+iwBYV4eHhB2SyJrZG1EhRMDooWjeLxjUPy0MXWpvmLWIjM+EPe6nBcYg9YMIaPy8
 A9Uq9mKFiNjKbVJ5XRtp0LhrSkSlA3jOSif2WdWeiLqg6a7Q7bc1XB85wsB0iokxJeNt
 RwOH3ebbZ3xRNYkehQEjnlWbE9L5L+IsYgUVUUMJjYUblNLDZO8AIApCr5PqFyX0UJ4h
 TEjVlyURLF/o+lb46Co42sQ49YfpaB13LBK1u32eqpiKzy8NU++xZOaLTg/1ikzEKQGX
 gYYQ==
X-Gm-Message-State: AOJu0Yx1C2Ytr8J4z9y6xhZCQQOBp5JK5nGSzE1aX89zmE4pQ5CIXZt/
 8Qzs6j/8tGId4pONsgFVNxKpAp2Ez+25yXsgTr9Z8DfDsYhfRtPQbCTaHndbHI08UZOcdPK9YFd
 PVjKgcA==
X-Gm-Gg: ASbGncuihGT60m3KZyVWyWWBxu3/06pCMiekYVZJCVSq2tlTrDuZgH7BBVGb67s+r8L
 MiENkPLUy28sINgmnoRhRlyRh0+oiUfGmeixu3uIG3APINf64b9lqWxoz0XiQz3RgNHZnwdFq/E
 mpOiy6aITIGIzwIDvhxQRPFNJ5TYPWVNLJk5kNty8X6W2QMKZi7Fd7pO1xVxfHGKs2B9IZlg/J7
 7eYVTrDroFfPor+erSXN1M4MX8cAm6jtabo2qOJnsA7vdMGVDOzf4UCXUWmyRfy1QV5jOeOI7LR
 Ixr8s4uLNqa3HYepTwmiFCSAOYzKDdgjXnHjkhs7
X-Google-Smtp-Source: AGHT+IF5WHMO+sfOiJN417KLtIfjhMlhi0917mmBZyVSE98LhaqjrSLXneiDiqyGA1xeA3w742aXrQ==
X-Received: by 2002:a17:903:40cf:b0:229:1717:882a with SMTP id
 d9443c01a7336-22e798bc50emr38640465ad.4.1746661378306; 
 Wed, 07 May 2025 16:42:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 17/49] target/arm/debug_helper: only include common helpers
Date: Wed,  7 May 2025 16:42:08 -0700
Message-ID: <20250507234241.957746-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index de7999f6a94..cad0a5db707 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,10 +11,12 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


