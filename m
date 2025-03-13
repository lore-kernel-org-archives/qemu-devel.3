Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D45C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW4-0004eL-F0; Wed, 12 Mar 2025 23:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW1-0004dR-LB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0007lt-RU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2243803b776so14221855ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837535; x=1742442335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHOuaDzblm6IWMn28KfbT02hmJPGWcvE7rOoUCYqoEA=;
 b=E1vEPyQd0aXmrsnp3W/KZPWWiU9acz8dVSmDw1VbpU/deQnx671GN+X3u3107zzJre
 5M66RDRUh0XSnX5s65SFqVdYvVIFZn93Ch8AaEzRpp5Rz/oRw3V0kWD7aTFm0QQpt7YP
 osl0b/LAUhUJeUOkiH0fXaqKdRNKEyzbxIvdTQ+qqrMUi7ILxPlW4fKkjGeJR5jkr5PW
 F5q1TvE/3/hkFK2Vo4FnU98InPl+8c0nSPRVPakZNiNZnm3ceJ5AMaZ0dT7V3GxKc2W8
 bZhto3OGFPNkjwYoVWrBte0FUKy421eEcxtqIqJ1KH5DwS6oIt4xKPOpzTEKjpoz/phm
 2wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837535; x=1742442335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHOuaDzblm6IWMn28KfbT02hmJPGWcvE7rOoUCYqoEA=;
 b=dRydTKyklrbRuHYA6Tlt4v9TRAjfoKJ89MHvmmuaHhegiXGiOEnxNvU/HJWJTWMQrt
 Be+BU3YfvMtf7DBVyMgSzk5mRMk/UkBU+ohbi8Eeleh8tg0mcbYPkznpz2Zga+5zfwYk
 phxvRIt2UpVqA923MP8z2JC/Z3pvVqtVFdE6rWSWgG8bylJEbcXkqSwsXRX/LL0657M4
 iDSsBNBDrHjem46M9BZtk0bXXU1G2+cT+igOQkQcaj6Vrfhjbgn625eNagzBkvH1vRA1
 5NR/ln11pj6/9C+LE1CuH/79jGguaCCcJpflLGHdp3/yG9LFZ6BUaqLeiwMrmYYtTu3O
 LnMA==
X-Gm-Message-State: AOJu0YyNZ6wXypAxK9+CekMcHYmWYUK0XQOX2WZcojevgddKJcsxHUF9
 98uUxPmwJ45yAOCU/Fhf0TEmsewysK5MQm7xWhD1ra5o4EiMUy2NIMpOr5fto7fJ2G6uUOK564J
 n
X-Gm-Gg: ASbGnctj8glBNwA7mPFW6j1mfwHOYAP4ZLrOr2Xixn5DOVdKDLuPOeHsGXdZ3AxnmqX
 uHABST7zMPp6aqXj3S4b0VeJXG2y9rHiNR4/wootfJPBVSRTSpfHNzBzM3H1Rr44xMDES/pdc3f
 3kBLmMaWubGCAgqZllQFyAklbJOB27Jrqoeya1GVouXcxFk+YPkSTSwVstJz6nwZV4ZcPwGa7YU
 10CbbKMttdGPTL0bCrYJuCrf1r5rntEXtDc7pulliB+91gOXMS/LgSrfjTfwsH7pm5TG3BxkW+F
 vYzmhwBGVz2rf7I8U+rOlwbV3IRGat8JvndftP/13y4yuAUn1vcJqmVHuvj2xzhj0ZlWgmoOZ8j
 v
X-Google-Smtp-Source: AGHT+IERKW2jpsurh4jAdKMRxzpi3gWgKKRfrw3DBjWUi4jgDm+zSBzaoNVWur9GZ6YzK9u9rM/+QA==
X-Received: by 2002:a17:903:19cf:b0:215:94eb:adb6 with SMTP id
 d9443c01a7336-22428ab75cdmr430133215ad.40.1741837534940; 
 Wed, 12 Mar 2025 20:45:34 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 11/37] accel/tcg: Implement translator_ld*_end
Date: Wed, 12 Mar 2025 20:44:51 -0700
Message-ID: <20250313034524.3069690-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Add a new family of translator load functions which take
an absolute endianness value in the form of MO_BE/MO_LE.
Expand the other translator_ld* functions on top of this.
Remove exec/tswap.h from translator.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 49 ++++++++++++++++++++++++---------------
 accel/tcg/translator.c    | 26 +++++++++++++++------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 205dd85bba..3c32655569 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -18,7 +18,7 @@
  * member in your target-specific DisasContext.
  */
 
-#include "qemu/bswap.h"
+#include "exec/memop.h"
 #include "exec/vaddr.h"
 
 /**
@@ -181,42 +181,53 @@ bool translator_io_start(DisasContextBase *db);
  */
 
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc);
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc);
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc);
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc);
+uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
+                             vaddr pc, MemOp endian);
+uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
+                            vaddr pc, MemOp endian);
+uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
+                            vaddr pc, MemOp endian);
+
+#ifdef COMPILING_PER_TARGET
+static inline uint16_t
+translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
+{
+    return translator_lduw_end(env, db, pc, MO_TE);
+}
+
+static inline uint32_t
+translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
+{
+    return translator_ldl_end(env, db, pc, MO_TE);
+}
+
+static inline uint64_t
+translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
+{
+    return translator_ldq_end(env, db, pc, MO_TE);
+}
 
 static inline uint16_t
 translator_lduw_swap(CPUArchState *env, DisasContextBase *db,
                      vaddr pc, bool do_swap)
 {
-    uint16_t ret = translator_lduw(env, db, pc);
-    if (do_swap) {
-        ret = bswap16(ret);
-    }
-    return ret;
+    return translator_lduw_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
 
 static inline uint32_t
 translator_ldl_swap(CPUArchState *env, DisasContextBase *db,
                     vaddr pc, bool do_swap)
 {
-    uint32_t ret = translator_ldl(env, db, pc);
-    if (do_swap) {
-        ret = bswap32(ret);
-    }
-    return ret;
+    return translator_ldl_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
 
 static inline uint64_t
 translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
                     vaddr pc, bool do_swap)
 {
-    uint64_t ret = translator_ldq(env, db, pc);
-    if (do_swap) {
-        ret = bswap64(ret);
-    }
-    return ret;
+    return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
+#endif /* COMPILING_PER_TARGET */
 
 /**
  * translator_fake_ld - fake instruction load
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 64fa069b51..405e0b44c4 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,13 +8,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/cpu-ldst-common.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
-#include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
@@ -467,7 +467,8 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return val;
 }
 
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
+uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
+                             vaddr pc, MemOp endian)
 {
     uint16_t val;
 
@@ -476,10 +477,14 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
         val = cpu_ldw_code_mmu(env, pc, oi, 0);
         record_save(db, pc, &val, sizeof(val));
     }
-    return tswap16(val);
+    if (endian & MO_BSWAP) {
+        val = bswap16(val);
+    }
+    return val;
 }
 
-uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
+uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
+                            vaddr pc, MemOp endian)
 {
     uint32_t val;
 
@@ -488,10 +493,14 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
         val = cpu_ldl_code_mmu(env, pc, oi, 0);
         record_save(db, pc, &val, sizeof(val));
     }
-    return tswap32(val);
+    if (endian & MO_BSWAP) {
+        val = bswap32(val);
+    }
+    return val;
 }
 
-uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
+uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
+                            vaddr pc, MemOp endian)
 {
     uint64_t val;
 
@@ -500,7 +509,10 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
         val = cpu_ldq_code_mmu(env, pc, oi, 0);
         record_save(db, pc, &val, sizeof(val));
     }
-    return tswap64(val);
+    if (endian & MO_BSWAP) {
+        val = bswap64(val);
+    }
+    return val;
 }
 
 void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
-- 
2.43.0


