Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01774C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kw6-0003GO-I1; Wed, 23 Apr 2025 20:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktX-0005uL-Fi
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktV-00056Y-JF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:51 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so465128b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456208; x=1746061008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WoakTEoTh5W+Edqv/m7cqa7TN4j7HTie5YrJRYbIMU=;
 b=seyH1gVKy5vzE/OlWmJxQ8KRoUIVeDACDqtjeD5YeekRsaAi3mnNAiSXkB4i6rVbU6
 jo8m7cdAB/iX44ZFIjKmmjWPmoz451tVHHs9b8CTAvSDYUMTJpE/G8akULl6uFemOhc+
 nFsugiV9/T8rPTKY9OJRzkb9UptavdolwYvMMTfOHW89980ohmGYRcOSZ+3L09AOCfy9
 mMqnQFKk98fEMgepAWIIlwhHOFv27llkOwp62it2YorpTVfxhXFg0gzggDsoHbldohig
 07e1BzqKHiW7FmXfTOYQleMHKuT44gE1UwJJaZefxR8/zyYS5r0ZQoOxLlwUjvvbbdVW
 JCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456208; x=1746061008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WoakTEoTh5W+Edqv/m7cqa7TN4j7HTie5YrJRYbIMU=;
 b=I7TTekuts1kttTzI0oMDZADL95y8D2kEQl5EOTMpECulrd4SJz7I08+NZuhBA4dOLk
 lKx0auLQNHgH4XhB3Wjkm9+C98F6szICc+b7E+lIJGS4bKabuQ8MlXbuaLP+kXCD7NrM
 KNTeMU1fuDpod2ZMFP5+96t1B1i8I99kKh4U4iSx9EOcP+RT7YgIvkNeWHWo9Bm68SEP
 6EbiFYcfiTAsG3gxQ8soW9DzP3IUR5NiJh4DZRq5qM/1vuQgmQt6WY1KkHG0msvwXyr9
 H8r3nZr+uByYyoY4dfBLkxHN5O4+GQbTM0qoVZ6vTMEegnFAvYiw1zoN7BRg5QhglqB1
 JgJQ==
X-Gm-Message-State: AOJu0YwptTCkdC0t44qfl1+5xpZ8HFTlQNqHX+tb4xDWvuZ+x9TuAKKP
 eumlf59+xcFiXyw3eFLNP/OOlsW71kfEhEoOlRaggkaBQLAB4ZwYFLJV0SNHZ8fPeL7AqPdfXfy
 +
X-Gm-Gg: ASbGncvBSnQsRbU4pmLOlfQO4EpefmzGrTMSwgt+qaozc5LHgk+JopyGMfedr6gqEiW
 7+HLJTlqkCXCiZ41nytJd+s3iHkHaI4+oU0DgPH3rCY1KRPEawpgAl6YWn4DH4VmEF7173Xm7Hh
 z6szdkPsfOVqywnjB53x1vdjxe/DEv/YtIC5K+Nb/elCfQpm2V7Ho2VW+8JVfj+bdDf1HBN/yjW
 PTU8XyuLSOAa8ed+ivKJOqRA5M14QkPYgNLw542PBeyCLp/+4HMrjud1XX+6cBwYq+P+F90PV0L
 0uNZjOLkZpRZ5NCwylh6BsDprr9xp7s7FgWxNytdvU3kiwhht3TtBZ4UgaZfqLkQ4qo2qjIjOdU
 0MR2guazHbg==
X-Google-Smtp-Source: AGHT+IE2dpOp7GxtEeMH4fe2lu+qKwfBunALNGa/lbVM8NCSuCjrauP8TbYg08V/2gjMwPmDUa4iLg==
X-Received: by 2002:a05:6a21:6d8d:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-20444d275ccmr1038104637.0.1745456207751; 
 Wed, 23 Apr 2025 17:56:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 099/148] page-vary: Move and rename qemu_target_page_bits_min
Date: Wed, 23 Apr 2025 17:48:44 -0700
Message-ID: <20250424004934.598783-100-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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


