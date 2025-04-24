Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8FAC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kp9-0008CP-CV; Wed, 23 Apr 2025 20:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn0-0005b4-GF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmu-0004NG-8L
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso358855b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455799; x=1746060599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RZv4stV/SvG8IKjkEcJ2d9gwvNpfIIefKf42fhrHvc=;
 b=dXGFWDD94EiCU9mtFKhhnFB43DVQHLooSvV/PKWqTd4ZZu3yd/5XkVH3eDi6ZhfC1H
 vPHNuGgu2yBC1QzNaMtkWZeoLwMYnGzxB2M7gzpex7qhxIlOqeQHV9/4apVbd9nc1sFE
 TcUOsM3olSx0k4IJ448CBrrcVB/bkRrg138HSgwh/5AgbDf60LTQNFtW0GMUm1bZZEe1
 wgy0tiFiRKWgg/3bmPsOHFac91U9Ec1eSiN7XIyHV1SKFoauGIxCfgahgVix4r/QfoWK
 0dOujTrKn6GnK8ZW5QPOVYxkk3VzyPVqMgxxnmdPYV/paP/mw1iAztY+NBSi3J39gzuJ
 erwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455799; x=1746060599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RZv4stV/SvG8IKjkEcJ2d9gwvNpfIIefKf42fhrHvc=;
 b=QICLVipMwpS8xmmViGAfKunU/2bJW8bh0e7tJgDUj6N9u5gUOGUzxP7cp3lq9NunPZ
 z8EcSNVobSW9bLbw+JSCwqZPpFSfyD6R+nsgm4oUhK/7uys6fJ3giwgz8kz/6WXO1ZSZ
 /tSOwUMBH1yoDFNxi8G6wclYOP9jjIYiPemTferA13ubc0QDM8nK3dh3sNQYu51l2r9e
 4s880fDXR+oFq6Y78EoVrK3OfLebtbBiidHc+foynogDL+SNC0Qh3RZRlA9DfnhaFfi2
 jD3vbyjZYc9BN5B57UHj5WMrAAfNJK2yK000FOhZCy01jCd0vMLfTwDLsqJ0ZkH9K9dH
 ELpw==
X-Gm-Message-State: AOJu0YxAiiV58je3AaX9O+tfS8dcQCESGAWWYrkusNnJFg8xyOYJrn1/
 YeAhd8lX7cIhI25/ZjPdjcCVoqAtXEHoym01Kb7BuZ1OPi5vw3nsSC+vX9LX/4KLDR5CfoqPZOv
 Y
X-Gm-Gg: ASbGncvFkwxcMkKYNCce2ql45nXIeJTlY+vzDje2rHFieYXLz55io/pNBEVjCETi/D6
 UZOblzeTN2ZnzQQo10hOEmxJVF65ia49yoG05SmVWhHgattPGceb8l+5cr/CciVe/rXZMy4misM
 BoWXK3i0oKvfwkhaF9PlfWdybWG3NMys2bX1+o1UzIHM+q05kh4hL0Au/v87AwqnobgD3OGXvtR
 WiJ9JgkqwgCZmx4yqxWTJj2oW9wMmEpatP6xT4kUByw3tIORx1w6q4u4etsTm2CgfrUS+/nl7HT
 LykW8L6x4qNT94Tv6oSUf18FKjFCSiYzechuD8CRk64wODrycmgvpjFKhkwVODlFQxf/6tyPPdU
 =
X-Google-Smtp-Source: AGHT+IHiDqmHRpgEKuiEKr4rUc+soxoeMLfonKSMpfFPK1OXdpnKNsINki1ftCo3M8wWD3KlXkc5lA==
X-Received: by 2002:a05:6a00:3213:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-73e2689e0f1mr451239b3a.9.1745455798655; 
 Wed, 23 Apr 2025 17:49:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 031/148] accel/tcg: Implement translator_ld*_end
Date: Wed, 23 Apr 2025 17:47:36 -0700
Message-ID: <20250424004934.598783-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 4c320ab9c3..2ab081b95f 100644
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
 #include "accel/tcg/cpu-mmu-index.h"
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


