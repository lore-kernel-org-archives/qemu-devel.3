Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C73C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYE-0001PC-PD; Tue, 18 Mar 2025 17:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXv-0001Fp-Ko
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:26 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXt-0000kz-3u
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:23 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso3441563a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333539; x=1742938339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSPoYWWiP5ut+52NUoRVWLIF418rfs9djKfkXcCgaag=;
 b=eqKXfg2WSle9OL1zMNHev4P18E/mpByniryqQirI9umBowgE4X6+gK9TxQnPOmBEAX
 Dx2f2KsxQSZnWaisj9oUWNuwt/qQJkC1CgeSS5NjAI+3uhH6PU5Dgz3AMKTZUudg3jFc
 HIm0vmhBAX+/2Fg1wrADe0aqx53yZv40u9sJX607KZed6cmvJYwZLOBQp9Sb9L1blLcm
 4k+zaofNOnJXbumt9TxQBtGNSP1G+5qfllXnViGs+lILbTwp4HXsrnhHnnZp6dgtdo7T
 OuNYmC6rT22EmKebvoH3AAEn0VYMMWAqx7tQK7Wvom6igcOTMx4aNQyR48wWWTynorfj
 PYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333539; x=1742938339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSPoYWWiP5ut+52NUoRVWLIF418rfs9djKfkXcCgaag=;
 b=eTApn9EAIcCGni+1Ick83a8Pgw4gKxugbeq8WrgQ/pFZNWUsFoTjMo9958x2eG0NKq
 TpOHWelyPq5pF+5lssTCHjLTntJ3VKqlzMF/ERCJ/PHaMgSKcC8+0cL7w5YPNoelklgG
 Ca495y9pp8W53vilbRZGuk8ocEqO9e8ipvphxuHIRlgOd0iw2tvpY/oi3CGRStJqqYH5
 dQ5ZGbscEq7Rmmj0m9F2zYrV1+yKwYwfvylsr5W4dRE4VX1xjrejAQ6m6xka2ozYbQY8
 sd3ujp229OVpr+rZnD7YvaaUk9pjBq7oI9X10jPiv+MGQrIPUbff6hMptO5skQG+b0Nf
 nYfA==
X-Gm-Message-State: AOJu0YzQWvXfBZOn2hQL992VQ6u+6iLQyCsJc+9YN9goaHLsTJ2WacKj
 E1US+cWVeZeCy7glTyQDokNnQNkQjGPBSGB9jDLSss/1dUYzrS48iutnBz2xsjCtftI66sl0zNQ
 0
X-Gm-Gg: ASbGncvuQVgpb/Ely8nQOEcL3YhE0ilUEAvOo2//z5LQAq+syNfJK6ZnT/H5bCTKAa+
 K6iJHCayj8VfMItl7sbOHht+RPtU4nrIhu+7/4xJB8S7UTza6MzQmLiZnpnzCEWgPGobTENGvVG
 PiKQa49uJt0zEYwG7jjFlzLKLttIISLijKpJMckU9Y76e6qjSU9hGTQHcwv1X0pQOhb6Dvjf2Aa
 FSdT8Yy9LlqY3XWhun2QTWesQHgmJdHq5rbTPCNG3PjoDtBKmxvqrliL3egR9ZhsE/D1aMn4HRy
 Xk9osMS2h11/wiKQ0iRtZG+kar0bSUJ81EiX7uMwXDFP5PvRKU3aYBI820dp+PkTUGhHLZptCuv
 k
X-Google-Smtp-Source: AGHT+IEmNcszrC64cDJ8mCR1pfHpnUx1h/rX5L+xGiX+FBXPGXb8SsaYoeeijMFe6Yv4OmFSHNIgtA==
X-Received: by 2002:a17:90b:2f4d:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-301bde35951mr377430a91.4.1742333539508; 
 Tue, 18 Mar 2025 14:32:19 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 13/42] accel/tcg: Implement translator_ld*_end
Date: Tue, 18 Mar 2025 14:31:38 -0700
Message-ID: <20250318213209.2579218-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 6fd9237298..7ef04fc597 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
@@ -15,7 +16,6 @@
 #include "exec/cpu-mmu-index.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
-#include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
@@ -468,7 +468,8 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return val;
 }
 
-uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
+uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
+                             vaddr pc, MemOp endian)
 {
     uint16_t val;
 
@@ -477,10 +478,14 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
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
 
@@ -489,10 +494,14 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
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
 
@@ -501,7 +510,10 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
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


