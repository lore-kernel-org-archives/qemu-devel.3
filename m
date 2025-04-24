Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A7C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksa-0000W9-1f; Wed, 23 Apr 2025 20:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015c-TQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqG-0004k7-1D
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so477926b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456006; x=1746060806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmSekyJdLD+byQ4wK17YzPBAZbfCl98xaVqmrAmqTEQ=;
 b=kYmeMnuMuHWVt0X5D93In7IbP4dcUuRRlCqVuNY61iMlfysxZxbySpe+U/RdJ3B8A2
 6t+D8uB+fqO41pazOsBo4UaPKU7B1dXoWJ2X/Mar5LGxePHnDCki9X2f11vyet/0MSkq
 zNTHjmbfcReMLPURAwaSDtISVsfotB/oBRYCdQ2QqKUG8JsuAK9WDCWyOzpgn4A7QNFK
 SebVZfegynE90oNXTVw9TrfI4o235obZ10hKnpzOf/aqMRYz8/UXWEEhnsUJNaTcawQc
 A2dB8uUxmL+/WgtjA9vxy13NZmlSSG3bgUhYkQ6Ohgq4UbsEgh1cLtgTjuERaB0ANM33
 Qs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456006; x=1746060806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmSekyJdLD+byQ4wK17YzPBAZbfCl98xaVqmrAmqTEQ=;
 b=jIaUjWQb3KYca8C6YhdzorMwOyrxdspM0tZvcfgbthvLl9fymVrjOBxD7JQDRja65U
 BAr7lm2TVmVAdn0Bs7cQbuM5RxDbtsQBiFaP98kXci9u+K0wOUpZjOmf9GnuJC1GzD3/
 NVsrW9Cu9jMIHqsng5ISZgUdp237MhrYoiik5L7U0nXJLl+MVdTktj+rF+3w7fm4MSJv
 UzJ0Ox/78viWoRNK3cwWywjDTCuZprhvOHQWzJZ3RcGu9s+JIPOl/pWWGOdU1JdLMd6h
 VPIVKqUWj3ak4i9iYtKrf9hOG+VWKuXqdaUsr5WqJ+55yWbIQc8l2CKJSU2adJ41Wxxp
 g1Qg==
X-Gm-Message-State: AOJu0Ywa9Xwhmf+q8fAsDW+5ZLC8HmjO0qEyMQzJE2AmfFlz7fsE+U7A
 AdRgy3YZM8QxmnfFCnQPd+WFGf6kUIZ2nwHj0+hLK0FsyAje+9rLNw/AkAbHH9epYnnjduvL77v
 w
X-Gm-Gg: ASbGncv2LSFs1rlkhqywGIAKOR4mxQ6DceWOKxTCEn5X/N/JWZPSH+Qdl1X4DaFft3V
 gMbR+daWBDbIZX2s2cLdEr7Q3e7uPqXIvsFVDQq3ZKNmERG462o+Rwgep1ZW2FNUoUleT5sOcqk
 ScDVRVsO6NMLcmWcwJGHfSUTLEYt8hmzHlDgZFTmjjX8jBMdQiEvnj9kd/T5tEupMWyuqrtvmQL
 IgnChvjBqNfvWbKyiImvBVsPKigfqyxjaIctxHlY/GtgZp+SLupJFJScr3NbWKiKz1no8+dH5fO
 M+YBdYxIfbDjNHg6p6WzDT2YwRwwO5xZzPByoREPPIOFUdOfw44mnD4JR7YZIgM+bfnfQpOp/Xw
 =
X-Google-Smtp-Source: AGHT+IGlG3BDDwrJZT2AMB7tw8b0V0nW1FDgt8ljXlp+tv9WB8YxSkUwk8l15UqPiZOVO1uHn5ZAAA==
X-Received: by 2002:a05:6a20:d48b:b0:1f5:7d57:830f with SMTP id
 adf61e73a8af0-20444f8a679mr824547637.33.1745456006463; 
 Wed, 23 Apr 2025 17:53:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 068/148] accel/tcg: Move get_page_addr_code* declarations
Date: Wed, 23 Apr 2025 17:48:13 -0700
Message-ID: <20250424004934.598783-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Move the declarations from exec/exec-all.h to the
private accel/tcg/internal-common.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 34 ++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h     | 34 ----------------------------------
 accel/tcg/translator.c      |  1 +
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 9b6ab3a8cc..2f00560d10 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -74,4 +74,38 @@ uint32_t curr_cflags(CPUState *cpu);
 
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
+/**
+ * get_page_addr_code_hostp()
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * See get_page_addr_code() (full-system version) for documentation on the
+ * return value.
+ *
+ * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
+ * to the host address where @addr's content is kept.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
+                                        void **hostp);
+
+/**
+ * get_page_addr_code()
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                vaddr addr)
+{
+    return get_page_addr_code_hostp(env, addr, NULL);
+}
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index fcad3446fe..f52a680f42 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -143,40 +143,6 @@ struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                              hwaddr index, MemTxAttrs attrs);
 #endif
 
-/**
- * get_page_addr_code_hostp()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * See get_page_addr_code() (full-system version) for documentation on the
- * return value.
- *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
- * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
- * to the host address where @addr's content is kept.
- *
- * Note: this function can trigger an exception.
- */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
-                                        void **hostp);
-
-/**
- * get_page_addr_code()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * If we cannot translate and execute from the entire RAM page, or if
- * the region is not backed by RAM, returns -1. Otherwise, returns the
- * ram_addr_t corresponding to the guest code at @addr.
- *
- * Note: this function can trigger an exception.
- */
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
-                                                vaddr addr)
-{
-    return get_page_addr_code_hostp(env, addr, NULL);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 
 MemoryRegionSection *
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 2ab081b95f..5f0aa9d56a 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
 #include "tb-internal.h"
-- 
2.43.0


