Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA33EC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOf-0004HP-4L; Tue, 22 Apr 2025 15:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-00010q-D8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:13 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLj-0006ex-Uv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2295d78b45cso88962875ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350325; x=1745955125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mym6I21VutfSQahS1cIV8VVwJqeJPoQQbXrANWwquXs=;
 b=Iw/hVEvOmqyJJQshqXecZe2kQHvTtnM0mKg1j27hkzQuM8uy0tBUpz/dI9mjXeDpPb
 23qZuaSK2WWHz2XGf5ebJiwyEScNzT3RpcZpt/5p3xpZ2kBnHMX7HCpdJcOxTvQhmN6x
 uUT8KaawqcnfTSPweJpvuZA8NE4XVSJyUV9jRkt+DfcXNc8GWw1fhA/5Y9JRYifG41YD
 XVA8g/UwEbPvbVDRH17wD9hmo4q8iQTmaeyiQiP5rW+ViXpiIos2AEHbhn+xDjqXW4d4
 tczgvqnvhsaGNjXGsfsfVZmbZtcC2YBV2Xshm5zLpxgwU9c0byBrbxpY2wsJkxHdsn2l
 8kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350325; x=1745955125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mym6I21VutfSQahS1cIV8VVwJqeJPoQQbXrANWwquXs=;
 b=wrPK0C8nSMO4Tm1WDnN9Yly6G4s+jhXdDz2FzS63L66j8DoeHO8GLhIbiZ2jitePB4
 3H8AS4D+tddxjVizYNzF+Ad4LdoT3MiHTTnz2wnzHGpHDNOeY9s+2Wxbr3KtnPDeQ4SC
 DX9m+OtgEAlXC27Hm80PA0g7L1aGyUPTyEHIufsa0DgVDPe/wi0yWz5JpYU4/3LP+mz5
 8bOHB86atjgKMvKgQwqNCPD5NIFgp3v5CH0pRKxa6HdmKWm1PQVbIpX3+D5X/XXAlLOE
 usOqnjls6atafDJBOStAQU1pZivZfndugPx2TjwDFNshOVujGuU6hVmctaLb3TtJK1hL
 hL0g==
X-Gm-Message-State: AOJu0Yz54BX9xz5m5o7cKtTzSgm+GWnr4af7mc4X236nlfFKejjORw8I
 /KrwYSQ5JqyENXYhfXFSI1A7Nbvhln6ZtMK/7831E+7ywFDhnM8V3jQkg9cLMl7rG7YhaT1Cmam
 x
X-Gm-Gg: ASbGncvnAg3VT3N1RgxwlSNFwfSBrkT3PooFzfeeiWL3OR+l7ruOMuiBvIOiWT4aD6r
 OjMSdsqMoFouX4BPpsTk1dHmxlA6+hVVjXE9j33rDEQiJ1ntg/rhUSOtdog3Ev/qFVFHOmcUvro
 k+c7TVlP7xOxDAy9x3Ql1cvq8dB+3pEEz0tjk6sjZh1jgMzPE75Jtu1kejF//NR3vKZlORkKQ2S
 R8PsH2zvnQggftcnX0NbQz4SXyNjgJ/yCeZQYO5EbQxiHJr1UeQ07im+3IQjq7UtV9FXeGH9i9q
 zZLpTLPncTBuJP1gIMvqwFnXS6fJ9Omi4+NqlfWRUBOLSpq+Nl9T3RgwIJSrSBRj2xW43b7RCoI
 =
X-Google-Smtp-Source: AGHT+IG478TXFH3/5dMzncHLz7g1If1T6fQN2MZsl69pFDsvUVA74ZGLRQW9yt3TVNCqCma2nYFvPQ==
X-Received: by 2002:a17:902:e2ca:b0:227:e74a:a063 with SMTP id
 d9443c01a7336-22c53605110mr193726305ad.37.1745350325296; 
 Tue, 22 Apr 2025 12:32:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 068/147] accel/tcg: Move get_page_addr_code* declarations
Date: Tue, 22 Apr 2025 12:26:57 -0700
Message-ID: <20250422192819.302784-69-richard.henderson@linaro.org>
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

Move the declarations from exec/exec-all.h to the
private accel/tcg/internal-common.h.

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


