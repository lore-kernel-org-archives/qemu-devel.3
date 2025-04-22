Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC48C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JID-0002NB-0G; Tue, 22 Apr 2025 15:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIA-0002MJ-ED
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI7-000694-93
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:26 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af59c920d32so3797969a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350102; x=1745954902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uAMrxInIp+C0jH/wHKgggSAeCetsGjpX7/pWD8kiro=;
 b=y9D5gy0dDTn+N2sI5/VTQFDkq2Hf9UuEf45+Cxe8ZUCQwPIGZBUKHeEsJ/0/bpVZ7b
 cR2GkLcyu/uznmkMILGwCqByqzfzEiLcs8Y/ReV5LxdN9+7CTdwSRPsIfVJeeUtoLuOG
 DcA2ciL5M9Phuls+7Vy2qKTche4KelmgOfMFWPPnRa+IaeK+35An2iZ6Gg3TGU019V33
 z8UEgocmKQStHB9I9eMoz0DN+Sdt6K3Jjl6EDgBJ8lPS80fTtPYHuNO8+J12bDqy59aG
 G9q60XczcKcoelMztPfetC5UEoVb4eKj/l3NqI+P6V361KrvD5POUPfVaIB8D7GUaayl
 xaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350102; x=1745954902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uAMrxInIp+C0jH/wHKgggSAeCetsGjpX7/pWD8kiro=;
 b=EHyQIEL7YB3AqpSQi/oR8MOs6r+TCaeVej6lwOukQq0YNMa7s7fJxa+uJg2LSud3kr
 S4uO1OGQX8NcqIgMq2ILC6yPXAupXJsyoycpgGHkF8MGSDn0tr86i0nIE0nPQyRCyD9L
 peD/HP2PZyoK623Edufq7E2BlzSEupMv/eHLLhGmhzIQUY70eduC0mJgql2CrQkGxKw6
 IUtjmmqA/dJbuVtNN/D+TnXakqS7zRgCp+UlSu9X3HEgk5qR/JhobPVSyFSTvwwRvFew
 kX9L9+I9DaqMYqvsWMjYuc3mheAxQCnR1h1maov4aaIZ++gwv9k67C40m01N6vBY+0Ul
 OE/g==
X-Gm-Message-State: AOJu0YwsRf04g4CIOZzRgZk+h3q/DNUPqNxN+52rA0CMb/9uTCLvmuDv
 EFz5AUzD6x/UEECtC4ac2YqQEuG1YEcFWB7ZbZg2DvoI7KcNIzoFKtZiSZsDLzrDZApu28ZcqGC
 t
X-Gm-Gg: ASbGncs1SS3pDdqFHI49NwZi+AstSjsNHya2om7AhH54cfZAFKGs5+rTB3UKJkr57hf
 S79QjOuImUoQLlq9nytRQg6tv/Evd+KEYlsPmMODWRcWzpy+WLTCC+VAYgqYVjFA2GOBDE+ngLW
 PhTSjEpEIMOSc2F9ikZOb04ikYJL7/LLaSEDJtGH/MOGKprfU2hLdqUh5UoCDLfa/n7bNVSZWe5
 IYwOS78sjX6IkSBRSBsQjUAIfquxWOkqqZGXCYWbGhYTnIPe8WXU0ObGhTg/5eI8x81gDDwh2Pi
 LGnNwz51QyeiihTzNU/h4rZdRfhsDkp9KCM+18eMbUc++dJxUeRhNKordldstUjlmy/pWQU0zwo
 =
X-Google-Smtp-Source: AGHT+IFZ1QdC+BGWztzMsPshQ6NV1rtCruXr5mh/Sc/PPv499dYasfpvM5NOWL6Yw5SGPw4CNvr9yA==
X-Received: by 2002:a17:90b:2807:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-3087bb4d0bbmr26115087a91.13.1745350101704; 
 Tue, 22 Apr 2025 12:28:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 002/147] exec/tswap: implement {ld,
 st}.*_p as functions instead of macros
Date: Tue, 22 Apr 2025 12:25:51 -0700
Message-ID: <20250422192819.302784-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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


