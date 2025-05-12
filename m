Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D65C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYR-0004od-5P; Mon, 12 May 2025 14:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWv-0002VC-HQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:42 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWs-00005t-Dz
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:33 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b2325c56ebdso3605608a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073129; x=1747677929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oL0UJx+tg40cChK3kdl5R9FcbD/FZXeuaJQlLcp8OEc=;
 b=KVSHMYV/z/SZydAxRll8PK7l1ntAWLyhFwzS6OO+MCKc6zvuSH/O7qiLkJIptEmP/h
 Gb+8jzx8O36msTKA0m1VfKksxlPEaAAuFkEerSsnpkXpXv8Z6bWVIecDpjX5Zh00OZHi
 X4E6T6vbPWmWlx4moKQeuofZMvEM4F3ThUhGF7yIt1wK2s5lbQOxQf1lJfwsmJWrtg3n
 gWc/U4TyayfM0S5Skma2GiKVs3RQNliNsZepoF6ZAQxku6w2HQg4IKwVlR7S6Doz7Ksg
 q+DofJ7AUxqxnSiaIZF0HUsRhlQD8HuUyWzpjxm1XppUEj9TToVjxyM4LG0N+kptNxzl
 q76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073129; x=1747677929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oL0UJx+tg40cChK3kdl5R9FcbD/FZXeuaJQlLcp8OEc=;
 b=ohNozmENaXiWf8kqrRXjIzYBBoFOl0yp+sQQcL2gm0ykCnyKAQvHRapAzQ6zYhQciH
 99v0xEaNfB4JuMDZis9Xs7q+/paMCqi5uk+OD7zcYkmYgl+ZVtW1ldG/kX64VSNdsoYl
 VeLZ5rGyrtEFW6KRllsvGhIMn5cJOX6QzVap7GwqEP53vjdYnlMgXsdpSyhRRXCjWQuD
 iAYOQGnVK3mvC8/7dG7FhOC7/U0q7d7wBQuSlTJ5r+3OeXCjICwFRtdiIpDrz0aJxaEk
 uvPqL1c2e70IDBIMt4trG9yKrYhKCTd7BNqV7JCcFu6mAC76BUXaUszrrCfGbis15aFL
 MlPg==
X-Gm-Message-State: AOJu0YxxGG+afE3MhTSEbwzzKbdkLYpOyC+GAkGO7dzIfX+YIToQ4I48
 JlduJq9fvVswOqeIR2nQAUghb3qS7feNtEM9VK1k4NQz0dYxkP/K9gYq7fLABt2zyomsmqbLqvn
 y
X-Gm-Gg: ASbGncsJriFkgVLKkO7zTAXASKf/jVPegSAASQ7b77yKZhPzZ10zeFOAnG59kENX9EF
 9eNy2Du6xoTwpVOr4imJLwDi1evGUeQSiFH+1Hp3IVOW5FQHXjDL4XWc8s2ssjRrhZPir32Z1sX
 8H7mgEr5GgiV7fyIB6nK6Id1iw6qzjPgnvBEvIfpA9JjP856AtTotmBC4MHeVktSXCb77fzYKRK
 aOr48jb2jNPBaER74JQhVDJrsI/jQJgFTDKsE8CaJ1/DJZw2ICEfSzYRYE14S8KWg9dyuAPuGSz
 7K3mafYxTdimtyxIboDynORChwXLPy8nkNB4TRTOYYyBf2Gq+C8=
X-Google-Smtp-Source: AGHT+IH7qLvgpx/Cb/Pp3+k1HYQ0qX7j8tIRYiuCyLgrVakJqFp3QIBAFvYBptkwZOaClTHq6p5RBw==
X-Received: by 2002:a17:903:244b:b0:22c:336f:cb54 with SMTP id
 d9443c01a7336-22fc8b5976amr194066245ad.29.1747073128951; 
 Mon, 12 May 2025 11:05:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 19/48] target/arm/helper: restrict include to common helpers
Date: Mon, 12 May 2025 11:04:33 -0700
Message-ID: <20250512180502.2395029-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4a2d1ecbfee..3795dccd16b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,9 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


