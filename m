Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D90C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPZ-0006eB-BD; Tue, 22 Apr 2025 15:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOy-0005AQ-Oa
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOw-00074O-MZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so59119215ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350525; x=1745955325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WoakTEoTh5W+Edqv/m7cqa7TN4j7HTie5YrJRYbIMU=;
 b=CX+RGNphhqJ8AHWCwBqGlOhZ1suuubvGlDYDLZu5NjwfdOWDownPUc2JScikSfCn/K
 Ezbi8TKR/PZnrS2fDpX3XZjHD1YFnurBXzqJQsS8QARYJHIZYmKH/ymy8DBbw+CaoOD2
 OGdySFlv4+WmTAVgVxPhvjsmNljYrk25EuYc1rKQjcY7CqTczqd71I4ePQleLlfCLiIT
 KtLWtBMbubLvoEiA7O7Bkdp4IT97olrB/RRLAYGco5qfZoXmluFJuH9+67r7YR0U2Wdz
 AvP8ilCcPcgOxJ3FsfiRI+YWuuMOrLuNm+/QBQIQNtxgJZw7dsX2WQpeQb8RjKs65xrb
 l34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350525; x=1745955325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WoakTEoTh5W+Edqv/m7cqa7TN4j7HTie5YrJRYbIMU=;
 b=sa1nJHCU8fZlp11/dIzFtbHsHMruvbLoIZ855e9E8V80dusHzIJHuzjcltOLtxujCu
 Ucg2/rPCp/H92mgyzY9f3MBbZSGxtoaAI0wUsCtLpSOayKyO/I2LM7yxSK4DPoQgu2RG
 fHR7blkx4CBEpRhSVwAvMPHXt512bhp1Qdx6NuFqj6b0/ACFPxNfG0j41s+XKRZAv8Se
 MqUzZFfmTF2XY26zC8bxWbbXME/t/b9XSQgMK3jfGkBQJBMTD1vvWEQyqYsXrj7ShWvp
 rex71XLfIHGYH3Xl8jXJFhLxmIUYQO0+ZtJRrqrnkknG64qspZAgYMTVqLdms30NNMuG
 1tew==
X-Gm-Message-State: AOJu0YwExeeN17RP0CSAiWkubW+PfYB/uX4YsUMRAtOYbZHcR3Sb/r97
 67n6fBAIdpCsAxr+oXCzCICySlde4NIyA8Szh1aNXQ7WHS1p1B2Ywoi/XFD7JodBDkUhTdfboiN
 C
X-Gm-Gg: ASbGnctNvsiQy70DJCt9OLLelCyCB6qvE/4a6Qzjl9yU6mxEKUXooXBfh/mvmBQvrQY
 q0e2ZaKGKpj8UAzg8f5dXxO+5L+9R1OfwhXmhhhKdlofqxV91dVvJsW6RR1NUdTlVOr2fSJBbfF
 FP0ccoODwm1l/jd8uhE+rXQARulcPVBQ1GW/DLOGjeo2wHXS/iByYg7hS0yIW38OGPrjHseDsnw
 0gWywyjcB53VrKhOg7slMym7NQl/MeCwfHL7q4oAlb1kLkAoHFHhtklpNmGRWE2PB1MNZtga8Z6
 9UNQpo5/Fc/Qb+OK5O+S3ePbr+OHQIHoXCjn/7P0PmpLM+u8wtPmuIRJF2cTs+gUxjKtXyV9Ie0
 =
X-Google-Smtp-Source: AGHT+IHiq5c+Jgc1MaQGq2iVWsxlcznD0hNaGcc9YATWMePpBp6h5ERo/3Ie8NGm4tvoEE+RCzaYuA==
X-Received: by 2002:a17:902:dac5:b0:224:826:279e with SMTP id
 d9443c01a7336-22c53630377mr225992365ad.50.1745350525406; 
 Tue, 22 Apr 2025 12:35:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 099/147] page-vary: Move and rename qemu_target_page_bits_min
Date: Tue, 22 Apr 2025 12:27:28 -0700
Message-ID: <20250422192819.302784-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Rename to migration_legacy_page_bits, to make it clear that
we cannot change the value without causing a migration break.
Move to page-vary.h and page-vary-target.c.
Define via TARGET_PAGE_BITS if not TARGET_PAGE_BITS_VARY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/page-vary.h   | 9 +++++++++
 include/exec/target_page.h | 1 -
 migration/savevm.c         | 6 +++---
 page-target.c              | 5 -----
 page-vary-target.c         | 9 +++++++++
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 54ddde308a..101c25911c 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -49,4 +49,13 @@ bool set_preferred_target_page_bits(int bits);
  */
 void finalize_target_page_bits(void);
 
+/**
+ * migration_legacy_page_bits
+ *
+ * For migration compatibility with qemu v2.9, prior to the introduction
+ * of the configuration/target-page-bits section, return the value of
+ * TARGET_PAGE_BITS that the target had then.
+ */
+int migration_legacy_page_bits(void);
+
 #endif /* EXEC_PAGE_VARY_H */
diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 8e89e5cbe6..e4bd7f7767 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -63,7 +63,6 @@ static inline int qemu_target_page_bits(void)
     return TARGET_PAGE_BITS;
 }
 
-int qemu_target_page_bits_min(void);
 size_t qemu_target_pages_to_MiB(size_t pages);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index c33200a33f..0c12e373b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -50,6 +50,7 @@
 #include "system/cpus.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
+#include "exec/page-vary.h"
 #include "trace.h"
 #include "qemu/iov.h"
 #include "qemu/job.h"
@@ -339,7 +340,7 @@ static int configuration_pre_load(void *opaque)
      * predates the variable-target-page-bits support and is using the
      * minimum possible value for this CPU.
      */
-    state->target_page_bits = qemu_target_page_bits_min();
+    state->target_page_bits = migration_legacy_page_bits();
     return 0;
 }
 
@@ -462,8 +463,7 @@ static const VMStateInfo vmstate_info_capability = {
  */
 static bool vmstate_target_page_bits_needed(void *opaque)
 {
-    return qemu_target_page_bits()
-        > qemu_target_page_bits_min();
+    return qemu_target_page_bits() > migration_legacy_page_bits();
 }
 
 static const VMStateDescription vmstate_target_page_bits = {
diff --git a/page-target.c b/page-target.c
index 321e43d06f..8fcd5443b5 100644
--- a/page-target.c
+++ b/page-target.c
@@ -9,11 +9,6 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 
-int qemu_target_page_bits_min(void)
-{
-    return TARGET_PAGE_BITS_MIN;
-}
-
 /* Convert target pages to MiB (2**20). */
 size_t qemu_target_pages_to_MiB(size_t pages)
 {
diff --git a/page-vary-target.c b/page-vary-target.c
index 84ddeb7c26..6251d948cf 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -23,6 +23,15 @@
 #include "exec/page-vary.h"
 #include "exec/target_page.h"
 
+int migration_legacy_page_bits(void)
+{
+#ifdef TARGET_PAGE_BITS_VARY
+    return TARGET_PAGE_BITS_MIN;
+#else
+    return TARGET_PAGE_BITS;
+#endif
+}
+
 bool set_preferred_target_page_bits(int bits)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-- 
2.43.0


