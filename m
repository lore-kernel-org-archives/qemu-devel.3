Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DEDC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSa-0004mD-5j; Tue, 22 Apr 2025 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSE-00044C-L5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSC-0007Lb-PT
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:50 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fd89d036so69494855ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350727; x=1745955527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mp9J9qjnxFI/eYHYBGLU+fFqwqKgFBMYv+K6pTDgibE=;
 b=BiZwl4FYd7hsM5uy08ZZxY0HZTWI/FAFcSsJ6QBigafNvsA4zPZLjJeZ4AI8+hwgOh
 a+oS/0HJ/pbK0O1/XXX5qUh26OlikLuivVS1V3mZk+sj4dtR7TaSA5AyIEXPgJ2NQJzt
 G8wVcrmXRorhR3EpEzqYrRTDy80VYR2fP1iEZKUHdJbJXCROvFrjCrnQwX1UnD19UAyb
 cGqhLYas+yL69hj921U8HC2O2x/Ov5hLhsjGGU4Zwe5X055NeoHxZzgy/W1Cfh5ETCvy
 Ym2VT6QkIWjFm+k3elKRF01MWzUtQm1e2Mx9SqgsUQAn7ik+zzroT35FtnIn/1jqo1W0
 UwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350727; x=1745955527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mp9J9qjnxFI/eYHYBGLU+fFqwqKgFBMYv+K6pTDgibE=;
 b=PMbyiOuPH2tMXiXOsuZVzORZCC8qGSQhxDSmSH6zc/RtyI98BGyTjMvnH3ZcLOQLwC
 +ZnjYHaVp3ojXJrxI0cdbnHH9jVH5lkaNn+UaOk+JJljrIwp3lzSj2blrINSgMCxbt/o
 Hs6qIX2gJWo6QnfREKuD58ApiM++x9uPE+h5AEdnISfxwSg2i33N/E0yJeoYatFCPmy2
 MsIfjzs6+AOL2rjp9wqNhMCHvKPbM/zpKfH7o9LD1Duv1QgShJ81DhbxIu2TkPIGF8AS
 ZqU9pwHurULZvVGlZtVy/cXT2mAzCYZ/NZFR/BnuuVhhoUD/Ru6+V3D8zycFwD4MGYyY
 IWYA==
X-Gm-Message-State: AOJu0YykezJAOw6YKqyo5vQ4TQbsCiOOthCct4zJHToOJ97h1k4FFhj7
 MnddX0AGA6fjPcUDbL2czOYX7fPcQ6UX9aUfGsvNzHinBG08Fjc63JPOUMzEdjAyDZuA3Mjm9ah
 q
X-Gm-Gg: ASbGncsVpcrIs4gI+UeDABbq6YR7ll4BsFd1++q1WweghBp0CIDMFh4ZR5OHkYJLBhb
 uwE/M75gy9lMpf9W3fWyjgYCjBPChG8nc1IBdg9ZEANUjBVTeBkpM/XbUQO5gsr+nUvzjD0UbCs
 1BUUZh+p3XMXPMGhthLRvWun1JKlW6seIVX9/YP8HB7bBlKLYcArEKY2uzwPtww8xe+yvPBU0A9
 t4rsWqiYr2Axwns0UIys9DnOVIyz5iFYoQUz6y173S4BD4w+1jTit5E7ZlQZRYzqqSUWIb+hnRV
 RVHNx9+dNxMHOJCffXqV3oGxS+0Yj7C8xjad2kt7H1DOeyPXWCuF7H2b3eYO4nQSK896gTPbJVc
 =
X-Google-Smtp-Source: AGHT+IEVtFwmYVmzmeZka3uQAiZlV1DKqH0Jkz9T02LZXy3gmN+xhKVwrT4phWPiHLEzZcoe9+Brww==
X-Received: by 2002:a17:902:f78c:b0:215:9bc2:42ec with SMTP id
 d9443c01a7336-22c5361fcedmr220695565ad.47.1745350727040; 
 Tue, 22 Apr 2025 12:38:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 131/147] exec: Do not include 'accel/tcg/cpu-ldst.h' in
 'exec-all.h'
Date: Tue, 22 Apr 2025 12:28:00 -0700
Message-ID: <20250422192819.302784-132-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Only 2 files requiring "accel/tcg/cpu-ldst.h" API do not
include it:
- accel/tcg/cpu-exec.c
- target/arm/tcg/sve_helper.c
Include it there and remove it from "exec/exec-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     | 3 ---
 accel/tcg/cpu-exec.c        | 1 +
 target/arm/tcg/sve_helper.c | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 70608a11b6..944b579d91 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,9 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#if defined(CONFIG_USER_ONLY)
-#include "accel/tcg/cpu-ldst.h"
-#endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5ced3879ac..b00f046b29 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b0d40c9e1..87b6b4b3e6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
-- 
2.43.0


