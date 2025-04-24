Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479D0C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmf-00059T-NX; Wed, 23 Apr 2025 20:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-00058E-Gq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmZ-0004IC-UZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so342991b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455777; x=1746060577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uAMrxInIp+C0jH/wHKgggSAeCetsGjpX7/pWD8kiro=;
 b=sl1aHJy2iBl/Deyz9KU2wZUTokpRG13cXSIlsowy8nzqqAXwJPz9sLSXQe6S99vrbC
 o2sXmK2VU3srBjyq21AIOE0bXffBYrC2YqfXDDCH1IOUmvWVww9aGIF0/Dy0yrl1QJYe
 GEet3kSp0t08I/qjw7UVY2RSva2mSAY6Uy4SeGHaV9fc1XdHEStcBW3BxqS9cWH/hFY6
 H9Xd4qDz+RgwYdqTBDWmJXsujUDe+o7ndY0v+2XBKfiJ0dXQx+uZGloyXn36t3enDShB
 bs4Y7T+csewoBSx9m+kRoeuqgF4Jya4U0hjyhO2LG/W3SUwjt9IondrfPpIaMoOwvPk0
 nhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455777; x=1746060577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uAMrxInIp+C0jH/wHKgggSAeCetsGjpX7/pWD8kiro=;
 b=sFf1msKRJc8UNsa2r4HAdf4qBpJ3nfc1rfWCRtPcLar3WdJRS6XRKRQhGrZT15Ul8G
 Ma5dfH8Ij/r4clC3zkK6GnJcIBvwdqLmdHyHDY051XiWLlQIQbC93BDlSpw038sPv96r
 RS9xx4Oe6nHPUp3bKyIOkmKtO5cQXivpcdughO7b0rEDKJPE5CVmUrkgiIiY9psY/eCd
 fg9s7aqiBgDUSRMdKi8NT4C+IFQ2x2PtY85/VGxQ1kB2UsK+zUQN8QQjAe0NzLLO34al
 u1fpJX5oWfXVwTmyCJMCuCrbf3TANGPq0GMy73UHHagRZEsVPyrV1E07ucniaPQ4Ww+z
 AzIg==
X-Gm-Message-State: AOJu0Yw9HAmYAizjqfjq1nnbTa0k70PfijF+KvcCymFSPf3fGUF8SkI5
 xy089eRtCd0iF4M+tK7TXDv8QayM+mLnl8wwqc/ZJxlYu/S21nJg4lJtq+jcGtD4CoZUURLFvWq
 t
X-Gm-Gg: ASbGncvvxtNewMlZjsF1J8qYhi3i9roKF7j1PcW4QmRX5LtK09p6BCFMT6C8FHbS5WK
 LoeBVLuOrehTFUN2AJ4he5w2gzH+X0o+zSgQtzwksf+0njk8zq+JN6jLVjNp8BoMSoWp95Y4psA
 RR2DDosFY1XdI27LUQQo4SyQSsUODbzUms8eRyrBoriicU8gNoM5/CS06fjcRrKP6TQ2EFUEtWo
 nEB/8jvdceiDXcOyTPa+60iuSQ8lABSJ0dWPd0SnMFUK8vK5Kzgs4tOSQhadS1/9yR7xsh6o5HW
 JmqdpZtrnqS26jm0DJePI34EpPYyVw1agUsXunfbmlBJ1PdpFead1gTQSrmy5RFxVUMXzLp/acQ
 =
X-Google-Smtp-Source: AGHT+IGfUKo/MNWUcXpotYXOFgT7Ana1qCsQmHxrIwRUZ2eSvIKNf8G0bwYfaSLQ9H4j1UmHcpEwYg==
X-Received: by 2002:a05:6a00:acb:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-73e24af4b04mr1089043b3a.20.1745455776765; 
 Wed, 23 Apr 2025 17:49:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 002/148] exec/tswap: implement {ld,
 st}.*_p as functions instead of macros
Date: Wed, 23 Apr 2025 17:47:07 -0700
Message-ID: <20250424004934.598783-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Defining functions allows to use them from common code, by not depending
on TARGET_BIG_ENDIAN.
Remove previous macros from exec/cpu-all.h.
By moving them out of cpu-all.h, we'll be able to break dependency on
cpu.h for memory related functions coming in next commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-3-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 25 ---------------
 include/exec/tswap.h   | 70 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 47b14446b8..d000fe4871 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,31 +26,6 @@
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
-/* Target-endianness CPU memory access functions. These fit into the
- * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
- */
-#if TARGET_BIG_ENDIAN
-#define lduw_p(p) lduw_be_p(p)
-#define ldsw_p(p) ldsw_be_p(p)
-#define ldl_p(p) ldl_be_p(p)
-#define ldq_p(p) ldq_be_p(p)
-#define stw_p(p, v) stw_be_p(p, v)
-#define stl_p(p, v) stl_be_p(p, v)
-#define stq_p(p, v) stq_be_p(p, v)
-#define ldn_p(p, sz) ldn_be_p(p, sz)
-#define stn_p(p, sz, v) stn_be_p(p, sz, v)
-#else
-#define lduw_p(p) lduw_le_p(p)
-#define ldsw_p(p) ldsw_le_p(p)
-#define ldl_p(p) ldl_le_p(p)
-#define ldq_p(p) ldq_le_p(p)
-#define stw_p(p, v) stw_le_p(p, v)
-#define stl_p(p, v) stl_le_p(p, v)
-#define stq_p(p, v) stq_le_p(p, v)
-#define ldn_p(p, sz) ldn_le_p(p, sz)
-#define stn_p(p, sz, v) stn_le_p(p, sz, v)
-#endif
-
 /* MMU memory access macros */
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 2683da0adb..84060a4999 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -80,4 +80,74 @@ static inline void tswap64s(uint64_t *s)
     }
 }
 
+/* Return ld{word}_{le,be}_p following target endianness. */
+#define LOAD_IMPL(word, args...)                    \
+do {                                                \
+    if (target_words_bigendian()) {                 \
+        return glue(glue(ld, word), _be_p)(args);   \
+    } else {                                        \
+        return glue(glue(ld, word), _le_p)(args);   \
+    }                                               \
+} while (0)
+
+static inline int lduw_p(const void *ptr)
+{
+    LOAD_IMPL(uw, ptr);
+}
+
+static inline int ldsw_p(const void *ptr)
+{
+    LOAD_IMPL(sw, ptr);
+}
+
+static inline int ldl_p(const void *ptr)
+{
+    LOAD_IMPL(l, ptr);
+}
+
+static inline uint64_t ldq_p(const void *ptr)
+{
+    LOAD_IMPL(q, ptr);
+}
+
+static inline uint64_t ldn_p(const void *ptr, int sz)
+{
+    LOAD_IMPL(n, ptr, sz);
+}
+
+#undef LOAD_IMPL
+
+/* Call st{word}_{le,be}_p following target endianness. */
+#define STORE_IMPL(word, args...)           \
+do {                                        \
+    if (target_words_bigendian()) {         \
+        glue(glue(st, word), _be_p)(args);  \
+    } else {                                \
+        glue(glue(st, word), _le_p)(args);  \
+    }                                       \
+} while (0)
+
+
+static inline void stw_p(void *ptr, uint16_t v)
+{
+    STORE_IMPL(w, ptr, v);
+}
+
+static inline void stl_p(void *ptr, uint32_t v)
+{
+    STORE_IMPL(l, ptr, v);
+}
+
+static inline void stq_p(void *ptr, uint64_t v)
+{
+    STORE_IMPL(q, ptr, v);
+}
+
+static inline void stn_p(void *ptr, int sz, uint64_t v)
+{
+    STORE_IMPL(n, ptr, sz, v);
+}
+
+#undef STORE_IMPL
+
 #endif  /* TSWAP_H */
-- 
2.43.0


