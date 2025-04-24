Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6852C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ky0-0007CK-8A; Wed, 23 Apr 2025 21:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0004zX-Gp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwl-0005U4-Im
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so6724645ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456410; x=1746061210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9hCTYp5xbc1UwKRhEJl2katxrg6RoRKPLw5poUutPU=;
 b=qgMs8IKiHumsykUlPLix9o3KrOO9jNjvLnl6ggiBOyakab43hwLWxJwKfgsD+639pI
 3B4WpHppZYVEPhpNS6t90+c2c410zCd8BUby9VGtSiWFxt5W6L1FW9+VVqMDhMZBk5en
 wdTqJKPJdMLpkgvQykhDA9wHqMdPJVN5tgaxCy3aqAdNNc9hV5xaMPtKTh9l67GulLul
 AgBkKpFv5XA3RtZg8KL5bw7GG+vvZm5Or1lD6HiMj6VYufnZu2nvwCVxo6oin/MHMXyE
 2w8njCmP4Yc/s6t9Q6Qu/t1c4b6tYFR0Ctp9PNoXRFqQTv+2djupQc+kiaOObHDV4n9W
 3p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456410; x=1746061210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9hCTYp5xbc1UwKRhEJl2katxrg6RoRKPLw5poUutPU=;
 b=B9s4fTAs7CrDB+bZyprTSyljRlzsptlPXGE2Sp+3vFR1awuJfJM1bMsg2sr6EFBeOT
 G2igQa/oaEirwbW3qih09qjUTMGx1BcuBsv8W6PiTL9HtAVSplR3NKDVt2mg250bsET2
 /tuv8FyNka+6AFj4fLX8YhkfGzQrz2oqWIJIXU84+Mnio9CLNcsodk1mGhF8+rpB+yCO
 0EaNWCdEepyqRnXJqJUAvnkMt8cP58vELWltE+PqSugJFItJzjXiIIuiAvORQr5trMEF
 Lqee047357/lu+vz05eIEySnPShcml60Ku8LTZTYYWhsDhTm8KebFsDE68XqXYEeMBnV
 3XhA==
X-Gm-Message-State: AOJu0Yw/LoZE3x5lHsOc/R0HI9SahGv/wZOg34TZ93BmGVO34E181RQk
 KSZDcLjPJLxsXtDR7EYdZcSKAsK9vC0qF7uZvkbIZVVPPxj/WHhYaX+pECLPNwWIh/blo0chVA9
 F
X-Gm-Gg: ASbGncvLjI5UjJ5sVSNFh6K1ZRi6U57+AztOTjVg1VfwM+3fuDGvvwmA2VvjV6fGvtF
 VeSiLoR6BNJACaSfIMxAJ26k8a9ayADy0d46Y2Oe/hyGOLAcRG6Sjr6ABfkSZJq/8M2ietMWO7P
 MwmwpZlwYDtfoeZOag43Ofk3eg5V/Ba5Nzr97ZfykdAQ4H2M2sqzcAYVz9Nf9bGCzYQFJzuTgxI
 V0dzuq9hzc/aYsujX2mZo5nRkoYfk1vctehJbSJxCAy7qP8YoRCyRIZm2Y2XDu8w5r9R2RxNHoH
 ggN3vKUCxBisKoaSfHuKA4YwIEzMJzpihT5l/tQoskWpPJy6buOi5kW/OCX4Px1n4hTmO32Hg5g
 =
X-Google-Smtp-Source: AGHT+IGhhOY25NqNFNJkBdw7YKpDGtbS/q+aWmjYW44p88cYy85giG2/C9flJpMjKsPY9OajRNNmJQ==
X-Received: by 2002:a17:902:d489:b0:220:ff3f:6cba with SMTP id
 d9443c01a7336-22db3d71b30mr8849455ad.38.1745456410008; 
 Wed, 23 Apr 2025 18:00:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 130/148] exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
Date: Wed, 23 Apr 2025 17:49:15 -0700
Message-ID: <20250424004934.598783-131-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{exec => accel/tcg}/cpu-ldst-common.h | 6 +++---
 include/exec/cpu_ldst.h                       | 2 +-
 accel/tcg/translator.c                        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)

diff --git a/include/exec/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
similarity index 97%
rename from include/exec/cpu-ldst-common.h
rename to include/accel/tcg/cpu-ldst-common.h
index c46a6ade5d..8bf17c2fab 100644
--- a/include/exec/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef CPU_LDST_COMMON_H
-#define CPU_LDST_COMMON_H
+#ifndef ACCEL_TCG_CPU_LDST_COMMON_H
+#define ACCEL_TCG_CPU_LDST_COMMON_H
 
 #ifndef CONFIG_TCG
 #error Can only include this header with TCG
@@ -119,4 +119,4 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
-#endif /* CPU_LDST_COMMON_H */
+#endif /* ACCEL_TCG_CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 63847f6e61..74761ba5f3 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,7 +67,7 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c53bbdef99..034f2f359e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,7 +11,7 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
-- 
2.43.0


