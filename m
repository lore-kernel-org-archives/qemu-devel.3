Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222ECC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tven0-0000jJ-KB; Fri, 21 Mar 2025 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemZ-0000Yf-Qc
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemX-0004Qd-Vu
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so1765832f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572776; x=1743177576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxKob2DIbt9NOZ+ogfI82gfyEiacJHXPNgMa/OVurRU=;
 b=OsHLmAXPg4/m51ZleFwJg6V6i2TaDSfwRx2kwP2HJXqoLu2SXBNJJI2BQMYsSiShxH
 4rMj00szFD4O5fJU4bY5f6dvYuFc6SHSRuMhXzqa/jB40OZcZllhXZnyMrt6UabWpbHX
 1mIy9sl5LQNrvjyP0BRxG9vrliZZhPRqV0nyTfxGt4iw6mTd6rABD9JTpjONy5RvVfwY
 tS5z8xG7uihfqq3lnQdX7DOkPkCJQ13Z9uCWi0Jr/hrCqOfhZ8xHDYROMy8l/m1I78IJ
 +8DEUIJbtlBBRlg8tsdym1Ocqs76TLAcDzGKhm7ywdjOywqlc4gErbNUp5OKAPm8LGwL
 9NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572776; x=1743177576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxKob2DIbt9NOZ+ogfI82gfyEiacJHXPNgMa/OVurRU=;
 b=fYzsFZx1OgoXLPoWEZv8+QCCQYxfOdlcabWO1vWsdY6jbaeR8HQ3qKC89SpybbBzBK
 pSgP+x6mrmsRUqeE2UXCL0RbQypQuF+WkeutqSeh/OcTbr2KBJAG7vxK2koQcyEhcN/T
 GO6LBN9mKmbbD59x5rK6dVaxWbtw4L9GTQMueyxbLPrwilnYFbC/s3vb67urxL33qGKd
 7xK0Xnnr5AvCX0JRFKpCMiOjMO925rN3JOEnIWGztp68VkqOAssZpYciI/g+XIoMt3kC
 hAIa7yUGG6yLokjeLJos1QEFqvpb6AQBi93mcfQUOZSi1MjL6kLbyrvlX5J2BhNWF9ps
 ST6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO4R/4SLFoNCm0XphFzFFQTiYeDx+AadG1WvRP9ULWpZBcHAdDspnfWXgDC4NM8OfmlAPeon9SKyBy@nongnu.org
X-Gm-Message-State: AOJu0YxDxZngbJXtN2Cy7DFh+TvUsnJlthte9NmwB1lTpcfyX8HQxCgn
 nCvzJY+mRUsDfpc8OeYQyhjCiMImL/Of+Jo/1NF7cn6inMnDR8ezx3Oo42zBnMw=
X-Gm-Gg: ASbGncseo9lRa/pE6/lgmbUZRu+PA9/K3NkuvyadznYWYP08tJxye+vwKt/c7rj4lwv
 wZAPF+aESHv4FchK7c4jrQuH81cGWchGlvfhOQ5ZyTE6pnrUUQ1JpZJcqlYGAGIJSMVDxp2N9qO
 yY0WNKNBrwJVvyEuIm3jyv4/fXaqxeV2goPU5sOH6xnfGM7FREtP/BIqTouG5iIA/M1iLJTwfV8
 aMV8Z5MLa3ygP0aOFKBrdKM2029bp0ehil2ZPPQylOSbCev825++jppTZPI2Q4H+AG3RrpMMwA7
 ZpZdhT9Gac0k0Bdxp2rlRBCNZWAhkxsNqSpu/5BiqPEHbkBTkud1K2vMYbmPbsN5MTypMxO6c+j
 uyk0hhAdBuuXTxYiQh5Q=
X-Google-Smtp-Source: AGHT+IE4p9vasf/iYUWv/c+rlijQe7X+UF0bcDtluSrlCKJu+UdsEOWlDGDc6IYkFJLQ8O06+JTo4Q==
X-Received: by 2002:a05:6000:2b0a:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-3997f941223mr3371706f8f.53.1742572776090; 
 Fri, 21 Mar 2025 08:59:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef063sm2652299f8f.83.2025.03.21.08.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 08:59:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/4] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Fri, 21 Mar 2025 16:59:22 +0100
Message-ID: <20250321155925.96626-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321155925.96626-1-philmd@linaro.org>
References: <20250321155925.96626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
2/ system emulation. Move the prototype declaration
to "system/tcg.h", reducing 'mttcg_enabled' variable
scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 11 ++++++++++-
 target/riscv/tcg/tcg-cpu.c |  1 +
 tcg/region.c               |  4 +++-
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..54570d21aea 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -597,15 +597,6 @@ extern CPUTailQ cpus_queue;
 
 extern __thread CPUState *current_cpu;
 
-/**
- * qemu_tcg_mttcg_enabled:
- * Check whether we are running MultiThread TCG or not.
- *
- * Returns: %true if we are in MTTCG mode %false otherwise.
- */
-extern bool mttcg_enabled;
-#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
-
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 73229648c63..7622dcea302 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,4 +17,12 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/**
+ * qemu_tcg_mttcg_enabled:
+ * Check whether we are running MultiThread TCG or not.
+ *
+ * Returns: %true if we are in MTTCG mode %false otherwise.
+ */
+bool qemu_tcg_mttcg_enabled(void);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index cb632cc8cc7..d75ecf531b6 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,7 @@
 #include "hw/qdev-core.h"
 #else
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 #include "internal-common.h"
 #include "cpu-param.h"
@@ -58,6 +59,15 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
+static bool mttcg_enabled;
+
+#ifndef CONFIG_USER_ONLY
+bool qemu_tcg_mttcg_enabled(void)
+{
+    return mttcg_enabled;
+}
+#endif
+
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -97,7 +107,6 @@ static void tcg_accel_instance_init(Object *obj)
 #endif
 }
 
-bool mttcg_enabled;
 bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 60a26acc503..5ccd7b9dc07 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -35,6 +35,7 @@
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 
 /* Hash that stores user set extensions */
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4b..56d2e988719 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -34,7 +34,9 @@
 #include "exec/translation-block.h"
 #include "tcg-internal.h"
 #include "host/cpuinfo.h"
-
+#ifndef CONFIG_USER_ONLY
+#include "system/tcg.h"
+#endif
 
 /*
  * Local source-level compatibility with Unix.
-- 
2.47.1


