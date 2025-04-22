Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A263C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JP7-0005MI-HA; Tue, 22 Apr 2025 15:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLo-0000vk-KQ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLj-0006el-QN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2260c91576aso48793155ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350325; x=1745955125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlaPgaqu+RlzrqR3gxsyz4cZtfxx2Xq8XD/b6ALmxlQ=;
 b=So8RjdNCEuhDHGV0jbz9Xe2lVdTC7ANH7d20hpebGNL5lH8j9HL004xeFK/H+weJQB
 nAIe7vsBvJTvLLmffz17KEMfNo8FYTe7RhJxkpMUsA90QgcSlwtvIOD7VdjEVNOybYlR
 QdsXyiUX1K+55fb2kRDET+j10AxnjJhVZPlAKgi+VBEtQ0+ecbvnHWdYztGEzC8wq/67
 ES3NLJEX3OHm9VHWzo+SNzaKxwIGZvWMpaZnVYw0V1pq+eFRljCL3sO3jgylhKIipGfm
 ckfMgV2zNL1nz7NiTHQ0hqY1ThkGQdWAOLGAbRXiQZm23ssFmb08pbKICEcza6a2X/xs
 azbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350325; x=1745955125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlaPgaqu+RlzrqR3gxsyz4cZtfxx2Xq8XD/b6ALmxlQ=;
 b=QF9hsso117gerLquWdR5H9oQaQ73iinE0wc2tnFmTtxmcPSw89VmqQzWVH0EU0D02m
 3qYoPiQKdfMUMPIsDCWHBCwediMlokoN1JjSIQM16k91rrE4lIf1RmVxgKSwNz7GJMLI
 7ubj7d0a+gZ13AmYGyKCxccxBIo+FbzWOQcmeGQ0khzl03EZ6vFxrRstWt5vA53YMGXZ
 5nKO7h5BIBUQbj0c1qag18o+LftDcPDZ/FEQJUgtuNkon9awAm7KHwExbY5JJeNtZnXM
 9WYGP9EkbuauAGg49CrHJasAnswZuMTuaVuGPrYG0NCvE+Cg5mDowqYeMvSZ3b7gZU11
 SzgQ==
X-Gm-Message-State: AOJu0YwjYhfNjzKR+2EWF6AwvEnfctGt88e42UO+RGw2iqmqYNXW7QvM
 0HgHUMhDhE4sphXpCnyovgfL6qdQUDVCa/weOmJkSYg5AIGgU7P3o9K/x3VtkdZyAnrVle9PqsL
 j
X-Gm-Gg: ASbGncupy2opdbGXniWOuVuNlpodBnhcEB05+QoZzQOBhlwNMhPrj+/yYmLuwKWZpql
 9wpf708PyxCOxYlaoAl/Ce53sCHcKMBIuKnL/DS0YKL5ljv5SZP8c6FwxTfqqwyzTbRQCnKN/9D
 GuuWXroqw+yzbTGdMZOdc6LTaXvLa4q1gpjYp0vQJ8WCgsCT9T6c4bareUh386bM3mvOJijpzpw
 iE/8ewGbeJJzcS/pvxuzBiIpw6sJrVsXaGIu1VMo7ik42GeD1iGkFthbKuLejECm9voyRBuzgHc
 2fAQGwFLRMBjamfsqEp7pSg0XIx4WPu6+aBVEabPX34TbrSK23/x6Xosh4LfsEzIBrP+OGZ3HXE
 =
X-Google-Smtp-Source: AGHT+IE4EXj8VIYNumDC8LF3F/EdCzynvTTR5LbiwZlRM+e8P/bKy1FV2/YFZfAGh5NXfwufIR1Orw==
X-Received: by 2002:a17:903:98c:b0:224:1780:c1ec with SMTP id
 d9443c01a7336-22c5360dc12mr294007565ad.35.1745350324702; 
 Tue, 22 Apr 2025 12:32:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 067/147] include/exec: Move tb_{,
 set_}page_addr[01] to translation-block.h
Date: Tue, 22 Apr 2025 12:26:56 -0700
Message-ID: <20250422192819.302784-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


