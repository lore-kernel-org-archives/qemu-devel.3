Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC968C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kme-00058N-9q; Wed, 23 Apr 2025 20:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmc-00057s-3j
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmZ-0004IJ-Ui
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso304575b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455778; x=1746060578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWWqDQpkYSHDISmeC6TzU4TbRuBzp7ZNAHRWv+UuIFE=;
 b=vBnMsAj5R4RfYFMFgQEXz8/FROUSUeRRwOFL5JNf/Go2Q/rj9TsJFtxnd0XuqTcRp4
 EMZ8bie7Vk6BCedMnnnmlSEDnT7Lj7CJ/Jw8MHfU+4ZGrhGC5dGWur9lwXowhH0dMkdv
 LDd9tFAyENbyCX0AkEO6kE4UE0iBs11Ozfwes8b2x1WwEr/HwCRc9PI62qznIGwVAFuo
 tyMahI8IjSOsbl7M0ehCk/LS5bhNJC6IqgL7+IsNX0MHYrAHj8zA6CVQlH6tWS8afASQ
 DfNQzumTTQOfJSyTYnvoG8keJDfogxN4xbPP61qjj/1J/Y3drrCUDvFaAbIlWvn0oqPK
 axjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455778; x=1746060578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWWqDQpkYSHDISmeC6TzU4TbRuBzp7ZNAHRWv+UuIFE=;
 b=XxI6EdtPM82qBj82qY+wC2uj/rH5gmxE5f/0tjzBtS3yp5mukRlW0ZKtRVONLt0iZ4
 WKDo8cuEfXD8hsXgYmaxZD6/ezyUElnfsI53RvGQcMRMN6yVGh3zcCERPcmhw+ybFLnA
 4AbHfunccjsmNF/KxS9N6ndCzoMfDXq4pT1LHHQZU0H7IIdyCfoQR9H8rf5pXQ108JO3
 1adlJvzAtyLFj4Z6hZTwYzMWLWSQ7Z+tUPdsAIdQ/kcopnecAGs2lrbX3VtTC7vBvugP
 ecvf01HTjtraG3QjebcBW0FZ8Mfw4b3u0XmTevf+EJ83HcQFpBFOTqI37/uf7g9wPRPO
 /Qrw==
X-Gm-Message-State: AOJu0YyoKe6xZB/Rzm2DD7kWWc5otKMSX8wusF1pGIOgUovEXZ6Q7nUq
 ZSi6Z7rzrUzxRlWE47DZFRAww19+17SWSPKx4Ti1f1FptdTpk84okIruD6IcntxfuHs9CCFjWj4
 4
X-Gm-Gg: ASbGncujyMPf9L5SL56QgjZwivfYxJR8xEZqKKvzi4120hCP+vlnMcGWk/WSqcR1Itx
 271e8kRITY9iz/Vx0wgen2mP89knT+h9bmhbRi70uFtWp+NX2mKUybLZkew1xVTAJKMY+/GYA42
 5sT+hkfZxX4MeyPV9aV85zn6+eS/kNk1c8XBB7XDSxcG03PHELV5Ux3v7mPVPkUsz0t2JSgSNOs
 PuyVqih/e77r0+r4UCbXqgKhxBKAP7YzLS3VZVXSPG8g/nmnB1Ro0tah5P3E4E1IYoFJ1i+I+zx
 40cj0yl07FtsZ/2TJ2Fjhj9lZRLWkhzZocfrPOW3WzMmyY0D7NC0wU6Y8plpNqTP/Dmeq//g0JY
 =
X-Google-Smtp-Source: AGHT+IGH3XDi6AuupI2vqBNLiS/k4ueJE+m4mF+fE09sJfCKgwZ0Utbk9uQpyBxhq3eeYKH+cElzww==
X-Received: by 2002:a05:6a20:9f4f:b0:1f3:3690:bf32 with SMTP id
 adf61e73a8af0-20444e9ca83mr894158637.18.1745455777985; 
 Wed, 23 Apr 2025 17:49:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 004/148] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
Date: Wed, 23 Apr 2025 17:47:09 -0700
Message-ID: <20250424004934.598783-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

They are now accessible through exec/memory.h instead, and we make sure
all variants are available for common or target dependent code.

Move stl_phys_notdirty function as well.
Cached endianness agnostic version rely on st/ld*_p, which is available
through tswap.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-5-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h              | 31 -----------------------------
 include/exec/memory.h               | 10 ++++++++++
 include/exec/memory_ldst_phys.h.inc |  5 +----
 3 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7e8d66de31..66a4252269 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -25,37 +25,6 @@
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
-
-/* MMU memory access macros */
-
-#if !defined(CONFIG_USER_ONLY)
-
-#include "exec/hwaddr.h"
-
-static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
-{
-    address_space_stl_notdirty(as, addr, val,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-#define SUFFIX
-#define ARG1         as
-#define ARG1_DECL    AddressSpace *as
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.h.inc"
-
-/* Inline fast path for direct RAM access.  */
-#define ENDIANNESS
-#include "exec/memory_ldst_cached.h.inc"
-
-#define SUFFIX       _cached
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.h.inc"
-#endif
-
-/* page related stuff */
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e1c196a0c2..cc5915033c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -21,6 +21,7 @@
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "exec/ramlist.h"
+#include "exec/tswap.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
@@ -2732,6 +2733,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst.h.inc"
 
+static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
+{
+    address_space_stl_notdirty(as, addr, val,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
@@ -2798,6 +2805,9 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#define ENDIANNESS
+#include "exec/memory_ldst_cached.h.inc"
+
 #define ENDIANNESS   _le
 #include "exec/memory_ldst_cached.h.inc"
 
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index ecd678610d..db67de7525 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -19,7 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifdef TARGET_ENDIANNESS
 static inline uint16_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_lduw, SUFFIX)(ARG1, addr,
@@ -55,7 +54,7 @@ static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
     glue(address_space_stq, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
-#else
+
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
@@ -139,9 +138,7 @@ static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t va
     glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
-#endif
 
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-#undef TARGET_ENDIANNESS
-- 
2.43.0


