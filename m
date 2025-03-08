Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304EBC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38u-0004jM-0y; Sat, 08 Mar 2025 17:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38c-0004fA-In
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:23 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38X-0005NY-JH
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:22 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22113560c57so56984475ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474756; x=1742079556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svzUK2bXhs+AmT8lF2QtHzM82zox0Nlbc/AZRsQwWac=;
 b=KuirUA343UmB2asjx8QJh4Jg3UnIfH0I5ec1HWZeDCfNAnLOmme9KnEe7WGXoO5uqA
 xYXSKVswylvYCNQu4QR6tm4OoFbcNQAAZxonBDHkM59IX2w0bRuzWjsV60AcUuVj/jc6
 DEl6f/6CA8kpRwQAAvayxD0zDYBp6P2iNpV7xw0n4QGmq3BL/VZ8l3DHwaI7hxkDqK94
 tiCyrE8P9w40uUvT+lYKo0P0j9LC2t2GQxs84uNcIb3/v6GkDRYqS8ugRHr2tP1Sj1la
 h7UR3X9mkE+DP3QIwrk2kjoEEHbCdjAxZy/lOU0L5spBgpqrYCyR7+Wcqk1IFlu4b5UZ
 bWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474756; x=1742079556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svzUK2bXhs+AmT8lF2QtHzM82zox0Nlbc/AZRsQwWac=;
 b=tw9Nym6o/DRIlJhV776uWzBFNYw1kC4mlxwpncYiO4p+Rhdat4apm+sbIAER47OxBG
 D8UK/D3eHPIIfoOZSnDXIX7SE993vTP0HNnoBtAw+aXQAr/CZwEyMlbvTKTtAAFVRr/l
 59dvPKkxYit+NWmcv4r12G8yWsgJbJJZ2uvZvMNJpF1oPkzt2MloBmd7f2kLdS6AoQYf
 nXYFmtIysCkK/wTmZliHvLzHdlgwHh0bv3Rg0mCd9ARxwiOtBgRPOpzdAu5YtYhnqwM8
 WhTMswd0w6c7HxjTfyyziy8kSyE4rSrHm/egMguZzAOLvZM1+IDuvImrOVyQODYLbDJz
 EE9g==
X-Gm-Message-State: AOJu0YyY9JENxqi77MHlvCmTYrZhyNO7vktH5i4l7098GkdtdzyoLHNy
 cCvPJQ8zZRMcM7dZCwz6g3macnMS6ouXgqlgCnULA6pCjoiCin2VSetWy21jL202Vi9zHSgZITI
 U
X-Gm-Gg: ASbGncuxyuVRwNTYHIMKYG/cl51HdjMtSmh/r6gPEZ7k5i6oGFuZpq2S2TMLlC5YJkt
 0THv29s55aBSOWNpFfL+SVZzZRC0ZqqRnKWdyGJTR2Drf0zTY+duDeOOy8AaiWXxwP7pPWjJin1
 v1rrYWx2D9k4nmkyvGDuy0snuIhIyg6RbeF1CvgwtU6YM3jAkM9Ps0Y++rJ26lZ1JQ87YKzCpHa
 BQElvsNASa61S8+7RwkfDGOrWU2IY2JodZCZ1hF28LAiwDUiqM8VhbEC4wnqICtJO2S5nPOvq/Z
 uimbKRYLDOlt4ccxNd3+tUSYc6KlsSPzz2bd85G97DbQ09mIEOPkTdHxIyt+bA4/taPs9fWgBOj
 o
X-Google-Smtp-Source: AGHT+IGg0tyL+QhYxEOtKPYKY+ZZEziEW3uRceSjy36AlfbHF1GPcevxGjWdvuJFc9J/7aZ9G9xyKg==
X-Received: by 2002:a17:903:22c8:b0:224:256e:5e3f with SMTP id
 d9443c01a7336-22428993846mr139577155ad.25.1741474756248; 
 Sat, 08 Mar 2025 14:59:16 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/23] accel/tcg: Split out getpc.h
Date: Sat,  8 Mar 2025 14:58:57 -0800
Message-ID: <20250308225902.1208237-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Split out GETPC to a target-independent header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250308072348.65723-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/getpc.h | 24 ++++++++++++++++++++++++
 include/exec/exec-all.h   | 10 +---------
 2 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 include/accel/tcg/getpc.h

diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
new file mode 100644
index 0000000000..8a97ce34e7
--- /dev/null
+++ b/include/accel/tcg/getpc.h
@@ -0,0 +1,24 @@
+/*
+ * Get host pc for helper unwinding.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_GETPC_H
+#define ACCEL_TCG_GETPC_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+/* GETPC is the true target of the return instruction that we'll execute.  */
+#ifdef CONFIG_TCG_INTERPRETER
+extern __thread uintptr_t tci_tb_ptr;
+# define GETPC() tci_tb_ptr
+#else
+# define GETPC() \
+    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
+#endif
+
+#endif /* ACCEL_TCG_GETPC_H */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2ac98e56c4..dd5c40f223 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -28,6 +28,7 @@
 #include "exec/translation-block.h"
 
 #if defined(CONFIG_TCG)
+#include "accel/tcg/getpc.h"
 
 /**
  * probe_access:
@@ -177,15 +178,6 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-/* GETPC is the true target of the return instruction that we'll execute.  */
-#if defined(CONFIG_TCG_INTERPRETER)
-extern __thread uintptr_t tci_tb_ptr;
-# define GETPC() tci_tb_ptr
-#else
-# define GETPC() \
-    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
-#endif
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
-- 
2.43.0


