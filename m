Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4035AC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIa-0002Yj-UT; Tue, 22 Apr 2025 15:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIW-0002WM-UZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006Dq-7l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so7499115a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350121; x=1745954921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RZv4stV/SvG8IKjkEcJ2d9gwvNpfIIefKf42fhrHvc=;
 b=FpeiSF9Ij8bCgDyiHyQNeUdRY2pEORXgaEc+rNLNnkrxv7ZJqQgrrn5cr+JKjAtYsP
 4MevcwMoPhvNVMiSeaH46w+XxwoOvQCMUbEUneh3AxG2qUYwZBjF8XKCibN4viqi10zH
 24npOtMT1voxpngwaHadyKvFZ1lxI31p3f61XH0XzGTi5/Lahwp2YFtWBZVz9f9PEvRt
 7JNM/m0nHiKMkelV/7V+CnWCUlg9v7CXLm2tGz1C0jzQ7kDi05EzUPHMU5ZKagMfJtQv
 Z34gVxRCmONmZ3e8fVKBnQKreIwfuxMB8/afYFUQbpIO32V3uXpivG8PHsMnTBXr6gj5
 suoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350121; x=1745954921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RZv4stV/SvG8IKjkEcJ2d9gwvNpfIIefKf42fhrHvc=;
 b=D0lU1x6nxosrWdbHbBn+ZujurTNIoqBqZfUbEcyp+nat2tNFEwEGXXGG0lVihbEIci
 LTPFavxz0neLIy8cdVz8J/uo1W/jcCRAW2Ippzmz9+7bz039XL2IaJurU+tpI0BxzE+v
 tNLl5T5ZuKSQZb+mznfIGqSnj/4oKHBXA0BA7iUj9D+awn+pTqQTIWmnD5bj9YMmGGJ/
 dENJDko6IbA4WaBy4cZiiMYG3YB0PR2AbpdwP3NVPoi38mYEEp6Yyy+1RhL10UGKnUcZ
 umCV7Bj5bXPkm/u7yYHWFM65hKYZLV65xJgJUyOsGZGPSdC/pOHJYiQKDjdqbOGdNK3U
 dfIg==
X-Gm-Message-State: AOJu0YyJjYBA+bVaABPAuz30mE/VA2N+baG41VWzDjf2dtWSSBHU+vGz
 GBCX1bJ2NYlYlWW/pV6kAhzC6Fw9Y0az5k5lGUl8gLk5udo2dqaM0/BUlYE6PvSLyanEcAzvHjG
 6
X-Gm-Gg: ASbGnctNx+Ti/dgwARmluGdY60GZw8btbHuI3g0NtdVDEMGTqmc7s7Z4JKQOTBnAA7I
 oJ3EhYs02F5tGYV/8yfBYzAHQwiUktK/OGTZJl+fLhiRn2sVOyHqcLyifLAP45bkPAtH6MsCBRF
 Lts81hH/WD4K1rztnukOtlHHHTyCweuniSFG/XnDIIj+U/HjCfbPuSMSvXpsPAFX/uz2o0wITz7
 AqVn7a2vHPMCVsDR6qNr458AVD2xOI8POYoHmhadXr5iAzGPjXPNbD5J4lMjn31pzazL3fFnt1+
 J4uUakLYqXTUOtHVCof/36ZqThByV02QT2DzKeqQcLnweorKmvXldwssZPzlqnYA/miM45bl/D8
 =
X-Google-Smtp-Source: AGHT+IEWk7L3ccoCC5sgJ9kxTNjMsWtg9MSvxa0w0caogTbuZI4rSRxifq2fifQPHEma9CNg3xbweg==
X-Received: by 2002:a17:90b:37c3:b0:305:5f33:980f with SMTP id
 98e67ed59e1d1-3087bcc3a75mr22991045a91.27.1745350120963; 
 Tue, 22 Apr 2025 12:28:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 031/147] accel/tcg: Implement translator_ld*_end
Date: Tue, 22 Apr 2025 12:26:20 -0700
Message-ID: <20250422192819.302784-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


