Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CA9C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38q-0004ip-Hv; Sat, 08 Mar 2025 17:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38O-0004WD-NU
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:09 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38M-0005KF-T4
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea8d8c322so6293473a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474745; x=1742079545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRheBWdAI7lwff+VJqeL2sbgSyjsFMzMB4+nkPr95RE=;
 b=WtnCssfAzGq9IsKFZMd2edyn1neeod47pCxGcGXDvHgXFVecHfm3/aAP8DxFcVUA9b
 sOLKWlZQQ4zlaK4UV02NI/BwZa+1YY1Gpb4eStZePbRESM9MZxHLjfjuYY5xnBUAORcW
 CIr6DECDp/v0xVOR4HQ/2mrvanZEjoYndQUUU1qZwHtXDTl/jeUz+UU4WxO1fxXId2PW
 A/Nb65L0XX7PJd/Ak1kzQFNhx8hW1rw+x1kJdl3Sr7Z1+JS8NSzrJ4N7hqGSfBTHnRb1
 Nw0n37vmzI8QMqpZAPcS0t5yh7ok9G1ieYkZr837+1khMgDJP0cUC94G6BBkpUnrbt15
 hBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474745; x=1742079545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRheBWdAI7lwff+VJqeL2sbgSyjsFMzMB4+nkPr95RE=;
 b=JiwoH1pl3Ep4f93sFwePSwQopIFEo1CpkO8gn8fV9jStPXtnKHOu5Qf4FZsRV4hcS7
 WgsogXrV2PsYpF6nm+syXgU9tOa1JzcPMegkQ8LcaN2AdbYZcKstajbBD7ZjppENj38v
 7exxR27OpCkYPVQ7OVvX1hSmRijI9prXBU+9ADSGGvkFLGTPO8meJcVXtOkve5lLavvq
 yrufZDsAOiMCA9JQli7pNBmEugqMobThAbfpxLH+Ew8fz9C/PuhfIDVcI7ib4qYTzOi9
 DJMYXq+cI1c+YQHbe6pp4M7WHVDj8m3qRNCyU9UaBORfaKxJFyzq8Nq/THPvF1wGrD7R
 LPUA==
X-Gm-Message-State: AOJu0YwhJBkMhR5DtSSW6aDGez9R2QOOYZAYtJzZpVKP6XwXGFXNpxci
 5LXUpr631cye1mZirus+2V6mhXYt11eEDXIiEdO8MjKDaMBUiDWXZYw9dGHAZ3F46yUjua3IhsW
 M
X-Gm-Gg: ASbGncv9t8G79qmQPuQyHFzFxA9uTAYGlNObSvv6CkfngaBhfpK/UD8uJShjwtRX502
 soiYDjTtEEjEsQUjMxAf63sk4JltmDlQSn+w5+lJRr5A9JrPvAqSemuw20Npr/pYJtiuQwztWih
 dUQw1dhozu9chcxuPYRd1OwUB6ghzpwUETBLoJWbhJouDxRqfvinRaFs8ohYHqelaR7LGIG/yFs
 lDDzj5YhXL8OLZoU9VVBADnlbohVPFy+TIjToVgKH4jVhiPgE36VOtF5hyxKnlobCEVsSVdi8Rf
 NGnjOYdljjmJaChULfGnfzo3bUyiZg9HJDXWAkYLPNn4Pl83ZictyKwEoU1ghBQ8xV/1gqD9p7d
 9
X-Google-Smtp-Source: AGHT+IEGFA2ZF4SLd9ZHly/2BfabaiNb1U0XGhjt+njYfgnwMxgWHoxAOoVumc6t3IsajdUiaSdBpw==
X-Received: by 2002:a17:90b:3ec2:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-2ff7ce904d1mr15557926a91.17.1741474745404; 
 Sat, 08 Mar 2025 14:59:05 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/23] accel/tcg: Restrict CPU_TLB_DYN_*_BITS definitions to
 accel/tcg/
Date: Sat,  8 Mar 2025 14:58:41 -0800
Message-ID: <20250308225902.1208237-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

CPU_TLB_DYN_*_BITS definitions are only used by accel/tcg/cputlb.c
and accel/tcg/translate-all.c. Move them to accel/tcg/tb-internal.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250305191859.71608-1-philmd@linaro.org>
---
 accel/tcg/tb-internal.h | 27 +++++++++++++++++++++++++++
 include/exec/cpu-defs.h | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 90be61f296..abd423fcf5 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -13,6 +13,33 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
+#ifdef CONFIG_SOFTMMU
+
+#define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_DEFAULT_BITS 8
+
+# if HOST_LONG_BITS == 32
+/* Make sure we do not require a double-word shift for the TLB load */
+#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
+# else /* HOST_LONG_BITS == 64 */
+/*
+ * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
+ * 2**34 == 16G of address space. This is roughly what one would expect a
+ * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
+ * Skylake's Level-2 STLB has 16 1G entries.
+ * Also, make sure we do not size the TLB past the guest's address space.
+ */
+#  ifdef TARGET_PAGE_BITS_VARY
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  else
+#   define CPU_TLB_DYN_MAX_BITS                                  \
+    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
+#  endif
+# endif
+
+#endif /* CONFIG_SOFTMMU */
+
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 /*
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index ae18398fa9..9f955f53fd 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -46,30 +46,4 @@
 
 #include "exec/target_long.h"
 
-#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
-#define CPU_TLB_DYN_MIN_BITS 6
-#define CPU_TLB_DYN_DEFAULT_BITS 8
-
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
-#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
-
 #endif
-- 
2.43.0


