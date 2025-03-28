Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE85C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFx8-0002v4-8I; Fri, 28 Mar 2025 16:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFx0-0002sw-RA
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:10 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwy-0007oM-Q5
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:10 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3feaedb6670so1502691b6e.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192307; x=1743797107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGhoY6BYqtu06nSyGAEKOAb5PFFvnmUxpNglBsInFeg=;
 b=BlVYescgQ1fqkHZs1HJPPQVSQ6EQhoKadYbviGywVhBJGS54FUicuXGF8t1ktZmNaN
 F6Rn67pPhczdu7KcwoO6cUIou1i9UmsEtJXeWPiAegkTCR/81yMs8cdSmbbvBey0ZF08
 Zc9JKJflxG5FE4YPnAnNnAcun253R1Sm7WffBcjcqNK1hSCX2f4BRB9Bqo3u0N2Iqi74
 QOED+6Hfst/NxaFfspjGirZj8t8QYAylQjPiV+MgayhTvpylttG8Prm4g9xWYTNmmWyz
 r9Jie/081YG24JG7MiiiwRRvQ1ZYhw60jUIoavUTbfh8SG/1hh0/Sy9psRzADxpTzqSb
 9DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192307; x=1743797107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGhoY6BYqtu06nSyGAEKOAb5PFFvnmUxpNglBsInFeg=;
 b=U5kQp08SAz27iMxMfc/VIDf4sgOXZTRDX8YYX+wd8T51DGdsMfrSirgikhNYYAIFHf
 PUdeGVnVYYEdp8G+XiD/0DnxRVysxm1wo1CJt7MfAm0W6yIO/uY4NWov8nOO8j7HrKS3
 XAiPRYpfS7kXgTy6P/Cw95lT1ZW7etEC7LiEHVBEsu+DyKcm+1YqJplEJcqzv5cIuozD
 KIRZzdquWKuLWrhDjcCKa6iwzPvKYDA2P6gKZ8s2uBX9QpCsPWp71E9QPFul1pQPoDRN
 bpiGmjlVqqAh4IWHyCboIyk6kGZyj2aQmI91G/hB5mkAcTeqBj5UXlz66KVeaJjCRmz1
 hqLA==
X-Gm-Message-State: AOJu0Yx4OCITwPV7dM2l22vhHxuwHSFGFLY/9ItWWzOEQCdNX74fdflQ
 UnwAbIaE+yLeyNBN/UeEbNOeufyo13YIn5TFrmjRYeOE6QiQAy4eXNA+bm/RQXrNDEXJjp89D4U
 a
X-Gm-Gg: ASbGnctmUmup2z+mtv6crUwQfM2P9wFQQX4d/Nm0Ow6fgpcBO3jnayMnfqI2YmKAXg9
 VVz3BMbEtVXyMjZU7ndc366P/fZ7N4D/FLXtBIjqjaRgnWoSIwvrtixyJa9KRT0QfwDvwnof02G
 Af1mcAdpLjmN1NR5kDSD09+3ExWCX4ZJdfTG4RiWHqj2oyA55lKyknriUAn4VCUGjEeuccqv2hq
 uQ9TcX7U8WHlVWAYzQ0CC+ECRfr80eCUKjmZdOtDqIflBy1JjXtNBhYus71KErlsIddRgaJ+fm5
 ntshv9YQaaxhTlDuG7jxlzzVBOHsDUmR2IuWLgJ4/O4qFZ1sqsLPoV0j9PKu/uY8li6Bvf4P/c/
 /dwMQzCDi1oE=
X-Google-Smtp-Source: AGHT+IGZ9womr7pxwp6oiaADgSVpsQ45UQRmjTALzu4Vuu6snojiP0S69zp+txPkDKtqqJNwdhCe6g==
X-Received: by 2002:a05:6808:3846:b0:3f3:d802:14f1 with SMTP id
 5614622812f47-3ff0f502f80mr489239b6e.12.1743192302510; 
 Fri, 28 Mar 2025 13:05:02 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 1/9] include/exec: Move tb_{,
 set_}page_addr[01] to translation-block.h
Date: Fri, 28 Mar 2025 15:04:51 -0500
Message-ID: <20250328200459.483089-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Move the accessor functions for TranslationBlock
into the header related to the structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h          | 49 -------------------------------
 include/exec/translation-block.h | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 19b0eda44a..fcad3446fe 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -123,55 +123,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
 
-static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
-{
-#ifdef CONFIG_USER_ONLY
-    return tb->itree.start;
-#else
-    return tb->page_addr[0];
-#endif
-}
-
-static inline tb_page_addr_t tb_page_addr1(const TranslationBlock *tb)
-{
-#ifdef CONFIG_USER_ONLY
-    tb_page_addr_t next = tb->itree.last & TARGET_PAGE_MASK;
-    return next == (tb->itree.start & TARGET_PAGE_MASK) ? -1 : next;
-#else
-    return tb->page_addr[1];
-#endif
-}
-
-static inline void tb_set_page_addr0(TranslationBlock *tb,
-                                     tb_page_addr_t addr)
-{
-#ifdef CONFIG_USER_ONLY
-    tb->itree.start = addr;
-    /*
-     * To begin, we record an interval of one byte.  When the translation
-     * loop encounters a second page, the interval will be extended to
-     * include the first byte of the second page, which is sufficient to
-     * allow tb_page_addr1() above to work properly.  The final corrected
-     * interval will be set by tb_page_add() from tb->size before the
-     * node is added to the interval tree.
-     */
-    tb->itree.last = addr;
-#else
-    tb->page_addr[0] = addr;
-#endif
-}
-
-static inline void tb_set_page_addr1(TranslationBlock *tb,
-                                     tb_page_addr_t addr)
-{
-#ifdef CONFIG_USER_ONLY
-    /* Extend the interval to the first byte of the second page.  See above. */
-    tb->itree.last = addr;
-#else
-    tb->page_addr[1] = addr;
-#endif
-}
-
 /* TranslationBlock invalidate API */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 3c69bc71a9..8b8e730561 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -13,6 +13,7 @@
 #include "exec/vaddr.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu/interval-tree.h"
+#include "exec/target_page.h"
 #endif
 
 /*
@@ -157,4 +158,53 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
 
+static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
+{
+#ifdef CONFIG_USER_ONLY
+    return tb->itree.start;
+#else
+    return tb->page_addr[0];
+#endif
+}
+
+static inline tb_page_addr_t tb_page_addr1(const TranslationBlock *tb)
+{
+#ifdef CONFIG_USER_ONLY
+    tb_page_addr_t next = tb->itree.last & TARGET_PAGE_MASK;
+    return next == (tb->itree.start & TARGET_PAGE_MASK) ? -1 : next;
+#else
+    return tb->page_addr[1];
+#endif
+}
+
+static inline void tb_set_page_addr0(TranslationBlock *tb,
+                                     tb_page_addr_t addr)
+{
+#ifdef CONFIG_USER_ONLY
+    tb->itree.start = addr;
+    /*
+     * To begin, we record an interval of one byte.  When the translation
+     * loop encounters a second page, the interval will be extended to
+     * include the first byte of the second page, which is sufficient to
+     * allow tb_page_addr1() above to work properly.  The final corrected
+     * interval will be set by tb_page_add() from tb->size before the
+     * node is added to the interval tree.
+     */
+    tb->itree.last = addr;
+#else
+    tb->page_addr[0] = addr;
+#endif
+}
+
+static inline void tb_set_page_addr1(TranslationBlock *tb,
+                                     tb_page_addr_t addr)
+{
+#ifdef CONFIG_USER_ONLY
+    /* Extend the interval to the first byte of the second page.  See above. */
+    tb->itree.last = addr;
+#else
+    tb->page_addr[1] = addr;
+#endif
+}
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.43.0


