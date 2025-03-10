Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D78DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEO-0002rE-1U; Mon, 10 Mar 2025 00:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE9-0002et-04
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE5-00089l-Ni
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so68330205ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582732; x=1742187532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OIqebmv6TCVHIjcnbRR2ASx6yOnmt3f1dkycngreo0=;
 b=jcPE9O9P8Fc95FdoQn4698mHWysM37eBDw4J3oDl+/Xyb8dPUdsJVD/WwiEfk9zAzd
 5iZmLs1u++gqW2JsYog+YYLxwZfv5Nv84MD5raFcUVtk4/gxUoXZb5qGrJ21OS5BaOEq
 C4tCEBtxji6s65G46WiSD2tduxPi4TeyYzNpCzvaAisn2LRJpyZ9bg+1Og9Yb3y8vOM1
 fntk3UjG/kVH8XwOSSUnNlkWTzceTd5Uima1pyJx5VgF7+bGNWGg+MUcXAHTkYP7bkvJ
 OtJWFpD+iSY1+xkQVpTgySDz/W9tFFDYMVdDktH+jJJTNd33HATg/F6zZtNAGS8vwetl
 Zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582732; x=1742187532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OIqebmv6TCVHIjcnbRR2ASx6yOnmt3f1dkycngreo0=;
 b=ipVAPGx+nzLs56YohfuGawn6v2Y5xNvgud/Vl9/ID0E6YSqkiNQs8H7sDHgvb6Q64q
 yY+CtAZC7QIk8VIRM4OZcM3v6eNcu7dikM4u8xn+Qz1hCsTcRCHYr2b5qKHYJM2Z4AFt
 J4NKNWYoPOWkAUQgfQMJb5jYRFcznJlFERvQZqw3GFl/pb3tW7iGN269Pw7SOO405SN3
 NIChmzqPxV/iO+7dIi6JoQog8TifYukB7CPBsqIltN1cP6YWxb4RigzDhCYNUXMVwdqH
 SSXnYMa84Cmjl8u0+tRFXklwSs/j3ggG1uHANwOFLLdkoJjhQ5x3V4PDLsaFy7REst3e
 A2aw==
X-Gm-Message-State: AOJu0YxOMdPv2YMX+OgTvRgEpgK19XkKYJaNm9SzDKrZ98GDzla4DEhm
 qWE7NDILQbIJ9cGjbkV8rRQd6hjWEdOxa5s5GNiZeTTGtDu7NFvD2wPAONSHAbjW2etdi1rEQXb
 UXrw=
X-Gm-Gg: ASbGncvVwFFj5CNeIriqG8AHwWnPzPfr4pOcLnVsbepKgahOzh4hEdf9rGqWhyMa7E6
 UbPGOLofKn9JEafG4Q5R770RSWCQXOcMmjVeNMlNlJosejc2IcPzq13neUFvRrql0oEw0weOQov
 8C98A3obINWfNFbwAKugK4Pw6Dh+Cf7L9pJlZ2FtRzehvzps4SjZq36jBbHTEBlPiXkRlByAECR
 LzfyrdLHwgeAUL07gtt2WNKQQ+WYdqJjPnjpdTDvgR+L/gYPuXreN1PFbiLDuwW7zofKbWrhChN
 gbOSPlc9IL3DaxT4dRbpkVjq26uGIU7LxZLz4pDhMGQ9
X-Google-Smtp-Source: AGHT+IFiauNE3phtYbHOElNurEea3KFBOmPJM6YIEsLLcuetadtqaCJcJRoQf8PU7u5dj3ax/cwksA==
X-Received: by 2002:a05:6a00:17a7:b0:736:47a5:e268 with SMTP id
 d2e1a72fcca58-736aa9bc787mr17756988b3a.1.1741582732211; 
 Sun, 09 Mar 2025 21:58:52 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/16] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
Date: Sun,  9 Mar 2025 21:58:28 -0700
Message-Id: <20250310045842.2650784-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

They are now accessible through exec/memory.h instead, and we make sure
all variants are available for common or target dependent code.

To allow this, we need to implement address_space_st{*}_cached, simply
forwarding the calls to _cached_slow variants.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h              | 15 ------------
 include/exec/memory.h               | 36 +++++++++++++++++++++++++++++
 include/exec/memory_ldst_phys.h.inc |  5 +---
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 17ea82518a0..1c2e18f492b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -75,21 +75,6 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
                                MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
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
 #endif
 
 /* page related stuff */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 78c4e0aec8d..7c20f36a312 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2798,6 +2798,42 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+static inline uint16_t address_space_lduw_cached(MemoryRegionCache *cache,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_lduw_cached_slow(cache, addr, attrs, result);
+}
+
+static inline void address_space_stw_cached(MemoryRegionCache *cache,
+    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    address_space_stw_cached_slow(cache, addr, val, attrs, result);
+}
+
+static inline uint32_t address_space_ldl_cached(MemoryRegionCache *cache,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldl_cached_slow(cache, addr, attrs, result);
+}
+
+static inline void address_space_stl_cached(MemoryRegionCache *cache,
+    hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    address_space_stl_cached_slow(cache, addr, val, attrs, result);
+}
+
+static inline uint64_t address_space_ldq_cached(MemoryRegionCache *cache,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
+{
+    return address_space_ldq_cached_slow(cache, addr, attrs, result);
+}
+
+static inline void address_space_stq_cached(MemoryRegionCache *cache,
+    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
+{
+    address_space_stq_cached_slow(cache, addr, val, attrs, result);
+}
+
 #define ENDIANNESS   _le
 #include "exec/memory_ldst_cached.h.inc"
 
diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index ecd678610d1..db67de75251 100644
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
2.39.5


