Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9FAC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX39-0001Di-MK; Tue, 01 Apr 2025 04:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX34-00019E-C7
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX32-00011l-L4
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso49705035e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496358; x=1744101158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS0/MV5U2fkQq7CgKOLpKd+Dfbe6P48Fmqa21p93QGc=;
 b=F54sy2eBBjeT9X/vSxM6qwm845q/lA1bc7T9ewGyTyhcPVeMVgqJ3R7FkCgmaE3ZTa
 +TEEBzIwsSXAuRaXXg3NiKjklq3hlEiQ4pnDbRnW5APnPVQ6ayQCC+pbUvPn4suqS5Vz
 B7Kp3e5wL0aShudB/Ybex6MpvqQPFGtHnruviK0okmepDMD4joPVSXvTuWja/ZNfK5th
 Mju9rj4SMfujCBJO0oF5s4h0yC2RB0VwTRyEG+CUPaw3WEv2M7QptMqpVDHfvGebezIU
 iZ16Y/Blil1dNa10Sl0NjahtAupvugA1gb/EuRDNjaCycw+hY+WzQcUkOumvPdvHASoN
 IRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496358; x=1744101158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XS0/MV5U2fkQq7CgKOLpKd+Dfbe6P48Fmqa21p93QGc=;
 b=guf32UoxD1q9wRst4/vlZyhueNq3/mBe44Si+ubPbcowL2/oqqtrQ+VvBc1TJn4I1I
 0boqmenVY1pJduSxtq7+uEvLtyvvPMG7M2qFBgCMpfK4AU+849rQOqcACHRA2pP/TRPd
 LP+X4LPy1qcXgfAHgfd1leEIbd0Xy+t110lvK0CBjLLhhBr0qXxej/qIJgyZ1z9EysQv
 2Xfs7uyp4OTmwcjGtsWpSVmHSQ7CKCZBCZ0R59jbv9cNdrrP2RYizB9bDjF8nP94PIow
 1K2oN0DHeC7OoahIznlLaiHegJ2ro234KCgRRunA5nUnwBssNg4yIaP1skWaZAlO4six
 M43A==
X-Gm-Message-State: AOJu0YxF4q7K8vLJLW7I36+kSEzLf+X7NFwOUfFly0xrc5q53GvoG775
 QgXCqAd2g2yVqOsWwz6L8uXQ1H8KFd3dpp87ECXr1ID3XHAdylUbFb9fviIN2eeUFYkQq2Rb79w
 F
X-Gm-Gg: ASbGncvz1HPfbmSViWxJ5aV61+RTicMfY/zY/uFi0XwMCRCKObUPN3SiluY32g0egm4
 fHkkKs0tZxcGkQaB9N57egLjb92udS4ldq3xASKd21/bU/H81wZfsZkHkpBhqNs41G/We6ngCtD
 7YEkT27rp5iKhMt0ZQvGT4hvvdoS3EwEZE2+gUMHadTFzcZ68DXNfA5xXiGQuGnooANj5k719yg
 ozeGgSQwQvnb6cbEG2rMfgCOF8m6zpO+9klqg2Ltrg/v1iHHMAn0YT0iKzCMtjoysp5JU/yKqXV
 iA61OZAFLXH9ixiX8/pcA6BYvBXJeDg0gkhnbzbSQ4mk93DhlsNyvPVKc4Hlvi+TDDiNnzqhFhh
 6NMpnoqhNuU6uYniZqwg=
X-Google-Smtp-Source: AGHT+IG/rT0h+fH/XKSZjJkcakb49KbMAaDZzoxtSvAbjub2aMmS/TZApebIsgR+dQ5C9bMMOhHVbA==
X-Received: by 2002:a05:6000:2910:b0:391:3d12:9afa with SMTP id
 ffacd0b85a97d-39c120dc50emr9963334f8f.21.1743496358204; 
 Tue, 01 Apr 2025 01:32:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658a1csm13821863f8f.17.2025.04.01.01.32.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:32:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/3] exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
Date: Tue,  1 Apr 2025 10:32:30 +0200
Message-ID: <20250401083232.33773-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401083232.33773-1-philmd@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index c46a6ade5db..8bf17c2fab0 100644
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
index 63847f6e618..74761ba5f30 100644
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
index c53bbdef99f..034f2f359ef 100644
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
2.47.1


