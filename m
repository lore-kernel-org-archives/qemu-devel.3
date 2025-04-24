Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06E2C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ks2-0007Wp-4d; Wed, 23 Apr 2025 20:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015b-TU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqF-0004js-Cg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so252104a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456006; x=1746060806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlaPgaqu+RlzrqR3gxsyz4cZtfxx2Xq8XD/b6ALmxlQ=;
 b=ioD6t+8oNLjmL/6xIxjXBN+YYBI8qE4O+EqS/CAN1NN0U0Mqn0ZHkdut70Re5dp2d8
 9CTdNY4WS93LFEad+JrHpNj5CJcOsioHEm98sQ4YkTT/P+b00mhiX6Tlep7y832ZTYRm
 p0k9mjubImw6jIdFU+Q2OBYM3WI3fEhQ2xI21fqr88uG9wp2rk+1Loe5oTI7JWM76x5a
 3yXopKFD/r/RPIQGvyDtmS3W3QFPuYlg7wRsa0HnzjyUSOOgAmdoKTWmgQP3hTwPTJQT
 xvN91UnX6kEAjrWoZlXlnZ1SOtJqTkNfGPOqVXBibnWGa1wf5vVGapRWWW81v8QhoGLO
 s7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456006; x=1746060806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlaPgaqu+RlzrqR3gxsyz4cZtfxx2Xq8XD/b6ALmxlQ=;
 b=I7G5yTaRM2O/q5/S+uPfXCXQz2oZDaf/0jLZrj37BYzHylrXlzOlEKlHM1Gs9lEP2J
 MiGiOxS9y83BjamHK4ZIs/p7Fme2cSmeJQ9AdmgpCkDnGVuE12eYLmL0rpG8bLcVYVcL
 DXYsN8HTscXJtHKPAI5IAmpSZOVcMQAa9MQogOWuwGmUl0h8ZXZc3MGv6SuAukek42yH
 EX3p0nqXaRkmbhznYOmvPlYTtgmu4NmgdbmpLw3QgMQeBUCSMWUCVV6wtwVIxcO4cqa0
 5xg6PwHg11wCZJQIhxyeEviVbZY1vop+GuJB+X98MS2YcJQ4smp0c7eiPfBWHxrlHT/C
 eb7A==
X-Gm-Message-State: AOJu0YwarnA/Jve5A4ZKFW6aDFHawTi0UFxvxPxMC6600NPhKpkSCiPd
 zDweS/SooNMbn1mwSbpQlEddD6e79K8Kg5T8zqxsRdjr8wUftdJXNj6obwAN27+WeaJa00gcNES
 J
X-Gm-Gg: ASbGncu1Z1IWl601Au6+XjENA5AdUyif159FC0Cdw8/V9RsibEj4nlD1/ZJizwf2KLj
 0hZF+c6U+QBJPKzTiSFSXKm3uiZ7xH5kyFEQHjMv5Hm8vZWBGZ6l3zN+tKpGoyol9+AL9CsQdW1
 O7KC4Jsj8U6tw7Jy1V1AqB8c2BHy6pHr4oTrI/bdbJ4SS8Wv/dww/4Hcr5HbxcZrmHGdKCcrGQd
 BvICP7UqAZ+bJMRkiKgKktXKFxZLOGr0RfeEmZh3C5O8BFsjlm2zQ16+i9RZ7FmNrxyPAuNmp3g
 cxxGAtr7v8f/Ys6LaPVuxhFY3aBnDgI906de0eQkPbksa9GwcHGDz/oPnAri0q2O31phYP+nerF
 SFkRtONtfmQ==
X-Google-Smtp-Source: AGHT+IH8zRPzQII+4f4BfIMcy4HECB/2TMFTDPPp1qw5cACcv77FmqNVNShxkIs4UptLhqzr4ZDCsg==
X-Received: by 2002:a05:6a21:3e0a:b0:204:4573:d855 with SMTP id
 adf61e73a8af0-2044573d9d4mr546203637.9.1745456005880; 
 Wed, 23 Apr 2025 17:53:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 067/148] include/exec: Move tb_{,
 set_}page_addr[01] to translation-block.h
Date: Wed, 23 Apr 2025 17:48:12 -0700
Message-ID: <20250424004934.598783-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


