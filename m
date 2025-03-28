Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC39C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFxA-0002vD-7Z; Fri, 28 Mar 2025 16:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx2-0002tu-JF
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:13 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx0-0007p4-GJ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:12 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c27166ab3so1491967a34.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192309; x=1743797109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gHs8eWFpnWN3yMoh+lxCbsbSFzac6+W/s5SOrn3Ec8=;
 b=m/IDPQH3D2oH2Xgsu3By4sI8EJp1aHWCR5ghMd5a3EWdwP5y3PERLnW9N7702Obu5O
 hLIh+9xcSX+7I2QJSp/jmK5zfAqPC6rHDRMlMica8u9pqS5L9XZ8QjPSLXKHUyhhWcHa
 goxqIFkjz6PL7lBqVxMNX4anOgYntkapmzelayjYsEnfRY+aZ051+JH9EmBZ7LHy/Mir
 XBbro2qqv33t7d4k4v4C/SRrPi0sC9Gp1X4wpSnALXmloxw8zo5ET1v+Q++uNQ2yqlW3
 BF59zof3M+bGt4JEBlRUMI6GN8w9USLRmlrvDHWy5u56iClpldKvG4146js3msJ8kQqn
 gEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192309; x=1743797109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gHs8eWFpnWN3yMoh+lxCbsbSFzac6+W/s5SOrn3Ec8=;
 b=CLnA1aAHES3E4EwVYR1L+vy1qOEZRJWnskd/G1+Zy+JzIRcfr19nWNhy/mPC3Gu+w0
 o/ck91bPnl5+owSL8CHxtjoZXaG+d8EmsGNT5+U11+4q8OVISb62wGFXR4qMz38ym19E
 YtO6fmifEy3GkCTJirE62vnqxGjjehvYB2DYwN8xWWnMwqnign91yw9aPgQ3+AdXv6kd
 yAdRSdUk28ogaiCRAXZPF8CjQSX7aitjlwlaM2ZcHe/6spKXY9OxJ9AtBRrF2Cl+qI/0
 2dlGqW+cyTk+8ROfOKUvaHpWhAQy6Hb2MS3RHvaVC0eOjhRfGdXzCo7CLutaYHJy4v9k
 Q2Jg==
X-Gm-Message-State: AOJu0Yxz5LJiBhadAMtFecZXNe+YmB/Qu9B9FrjCAsAXO7Cu8fzj1chP
 W9+rlPB85gE4TFjbiMfANYz7VkVOXzg0yb0nYkebS3bqrWFEAFS1kSmIz5nVHtaxBpeOJzU03Yq
 +
X-Gm-Gg: ASbGncuZPjGgHBP4mdaWTsObO4GA4lj69xDhpAPZnOf4RGi1U3D6QQkhr8BoXVtZtfO
 ho7tULnualo6JKfjkhpCAPfYz5AOAKJjuv1qzNXiSvUtfLg+PQtrewIQ/4NkEOKOPlZTcQIuVV4
 mmWIHEUHCFE+9UgkHNtnw7HE5L4iK8N7SPFojEWgmy40FW2RAAOw5pg6hwVrotO6A3isl9Un48n
 NOzCm0YWZp1dJPq5whdY2qIaKvHcLal2ZWAj2IMZZnjN6cK+5O3cxmwe/Zg5amDS/YEM7BKrBVE
 cG5F/yYPmh5McKrYXcT0zTbREZC2B9pKCVSZGvx8qXTbVAprfo5egNbTlHG314/Oktbz8NwRqYR
 nXpGmzsxoB48=
X-Google-Smtp-Source: AGHT+IHghG/wEczC9QMQtmkN8bq9NllHLuUryQ3lmO3RTJCVqLCbQQgm5qBRpAWRSnQ2FYyviLauOA==
X-Received: by 2002:a05:6808:11d0:b0:3fa:7909:2716 with SMTP id
 5614622812f47-3ff0f5fa01fmr370720b6e.39.1743192308522; 
 Fri, 28 Mar 2025 13:05:08 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 8/9] page-vary: Move and rename qemu_target_page_bits_min
Date: Fri, 28 Mar 2025 15:04:58 -0500
Message-ID: <20250328200459.483089-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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


