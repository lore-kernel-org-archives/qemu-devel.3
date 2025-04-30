Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A014C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGVq-0001lx-4G; Wed, 30 Apr 2025 19:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVi-0001hr-W0
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVh-0007VJ-2W
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso498582b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054395; x=1746659195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3WaB8ulU2dMi9YjFSsDNWzjp+rLier7nhupyaS/o3ZU=;
 b=A9dnc9a6aTOfWAbOOOYSg1iJw4la47mmKfzKMhwcyYurHXYVeugoWWzEbD/figgU+7
 c69TsquA9ZrFsTljDW+KosEmSu0hp897VUSv42DW0CD9/sxI3Ka+75Mbn1IX6r1akjJI
 ONi/uxoRBsrC/yDDNha6QMq+hgopegsMqX0bumOPDh5C6MQjpCcMaeROEjacEtT3AT5K
 9mui7d3LL8rfWcq9gDfD/FUSnYOTrUJf36kEd3Bf8z6Vla6AlBrJPTcbm4CvqgP34sbk
 w/R910hi/Xz0zAcgO/ryIxZ7TOoHS7F0oMaNJur4Mj92/ZjXWnl0ydqzg3N4vlSIDWjm
 caTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054395; x=1746659195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WaB8ulU2dMi9YjFSsDNWzjp+rLier7nhupyaS/o3ZU=;
 b=C99KOMXV36/w9ebwqHoe4DwW5rkkl2gsoIOK/3HRNJXR+uUqg40W2p78629WG7Argb
 uFrhkMkjNfIw4d/hBRqBvD+tQQSw6H6J2rMQch4HZ+MG+0Tt99eNTm+uDYuZZgzaJwAe
 L2ZgKIXGNuFffzPyxDcoQNLK7wtcatQxDX88UKvQpbyj/j+B9qJ3q2erpATWAfyAcgJf
 S6YwVIOqVibjZGq30+GIMUTwRePqvze1STTw4RY68hBSiEERYTFlvXoZcgQfULKIfMMZ
 qzwp63N+ApSO+Cju7OWW53OYpL9jXftlY0SrsWPPgQEXclaWs5mLObFxB3jweiO2Cb/i
 r2Iw==
X-Gm-Message-State: AOJu0YxwJvOzI2UcmfuyXVT+tcTDDC4t6D6mbAnVLVLF4ny52jEpSBd3
 4DMz/ucX7Sb93wWuUZROIsEaSxAI7VxEt5XykgVCj05UFNWsre1O2gpxpSeH6WHXfsmhilQ6DzL
 A
X-Gm-Gg: ASbGnctcJwNZFgSwxIA0eY/+IN8ZmpXDmJ18MYCJBq/UKZ34rFK6/oG2kSYWd8xGYOV
 NHTVjlV9NH5nNzpY5z13yGT6dSsfCTqPuYj+i5kXM7KHWNE7kKEFqwwG/LO7e+KUBVi106ooYvu
 ZaSrpLABNYMwkgS0hofu7l1qfjnzSLDl2puFD1Bl1LfTsinU2sQ3fX8X3QtMxOYlN5UACmE9ZCX
 ve36c9GfntBZUZMSNAsf8lG+cOhIY9EQE2GFmWvhv53DPiFZEv36zICxrdyOEchr8ibTDOjk+ia
 +EtmULWl+VYafO4Z3e94rymblSc2FHvJ24sQ0Mn6VHulQh8DY0oIgt09kbeXe4jJY893EfXgIlc
 =
X-Google-Smtp-Source: AGHT+IEdwwZ/PLAShXUYr1ptjiSI/d99uVOwW7OupHtEy2NwZi0N2eOujhyLOnVVDLtXN5jIC+7QYw==
X-Received: by 2002:a05:6a20:1588:b0:1f5:8e94:2e81 with SMTP id
 adf61e73a8af0-20ba6a20782mr1378674637.9.1746054395110; 
 Wed, 30 Apr 2025 16:06:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] accel/tcg: Use target_long_bits() in translate-all.c
Date: Wed, 30 Apr 2025 16:06:28 -0700
Message-ID: <20250430230631.2571291-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430230631.2571291-1-richard.henderson@linaro.org>
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index acf32e6c08..6b6e10be9d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -54,6 +54,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/main-loop.h"
 #include "qemu/cacheinfo.h"
+#include "qemu/target-info.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
 #include "exec/icount.h"
@@ -343,7 +344,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
+    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
 #ifdef CONFIG_SOFTMMU
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
-- 
2.43.0


