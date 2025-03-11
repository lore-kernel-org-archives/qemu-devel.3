Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF57EC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqvX-0003MV-WC; Tue, 11 Mar 2025 00:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvT-0003JA-24
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvP-0006QM-Nb
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so94536135ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666142; x=1742270942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZg0/as8vJD+8Um7sy7JKxAjMVLEtPUz9ZnXYeX+5Ko=;
 b=tlVX2CDQ5mh+81V3E23t5f9+hEaQu8mxlHmT4z8uDT87K65bhDW8etuCveUYDHqCFV
 hXUIhXIsCve9Eo5JlTOrvR/i597rhVPjgwMzDtDeVi97EqVJ201B1IQetKml4r79LZdJ
 wbeKcrnIyhmX7siAbOJPCGTjn5ctZai6nSdc3Qytcz26NOzDZAlfFy9HGNLy1SnDfOiv
 B+drfOoC/EnhjDfYFz4W6A1WSFfh357NX6Et+Bt3l1DwSVoMHB8AwrnY0XV5sKt4PeQ2
 aUhHMsnjRoEtFeH9z9sjAJEKI/YLOrybrD16yto8X9UVe3PFTnRzx/BGkMAkjk5g01mt
 VCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666142; x=1742270942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZg0/as8vJD+8Um7sy7JKxAjMVLEtPUz9ZnXYeX+5Ko=;
 b=ZsMhP6L+z9H89QgAZk+eiFx1+vkq6QfVtOjI6yHxY6sQf97y5bADMNfZhww+KmUYCH
 6aqxr2qPSSKATKpwfNLqHA4kd6kio5Vo1p2Ffq1rnfyLKdEo7Co2nFkVqVtEMprWM+xc
 AdCNNSx3R9d9lX8grza3aCtqo8MhtIpXN+/Vt36HtkMzZ+8V2bmBYXrdnejzUJTEUjOa
 TFPkDyrD+qXW3GKMgwaIWngCttrdvPKaiLzG9XdBiEapC2gcNEpomfGAD/jrdh8X4GMR
 9My81EdA0dulnCqUQc72B0iJ9jPYyGSxmyhLqVSqSyrp9KhgK6W5AK+V4MX23SRpceNw
 CThA==
X-Gm-Message-State: AOJu0Yyi3aQd5QWunPSp6YvrLsfUubLphCf3QgpUdoyEqXvJqKNiAS7x
 UHrnDYTgqsVjkGUYp/95ObnmXM2dprDK1j7IUqoHHHfO14i7BV836Qyn15nV8SmsE8rwqEUagPv
 QlFI=
X-Gm-Gg: ASbGnctaiB+F9Dn+K/JLiTw6m70LtktOl8AS28zVSMi+B+C/UM8q6ndeTyug1BBbqNT
 6gVcTzVbdbj+pvCpSyU1HcZoWSyISfPLuVXTp+AVFCdSALCJ8i6J/qYTwRFK9/AgE3tU8e59mXf
 KdnIOvu8UesiTgUYwWlBQ3/PbHZUMh+vTiL7kUg0UJ9G3u0nw7PVn53NYfvpPBm0+S0BhXAgSE8
 UblIq78/GxCNCSbuQ/gmUdNTnDsq82TlvNUa7VleaCqVurKhk5WbqumdRubzL+sFdrj2LHpjO3Q
 FEewi1VDFvhLhF4FXe2Ji2GzBGE/FcJ7r/qc3JsFNQut
X-Google-Smtp-Source: AGHT+IEv6pfYhMlZcVFtUT8KTCc1zYGaqiUcLOn7dx2sPDPFPmpFWZtYBaUHHMwx5Ykg9mMF6L42zQ==
X-Received: by 2002:a05:6a21:7002:b0:1f5:7fcb:397d with SMTP id
 adf61e73a8af0-1f58cb1bea7mr3411754637.16.1741666141836; 
 Mon, 10 Mar 2025 21:09:01 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/16] exec/memory_ldst_phys: extract memory_ldst_phys
 declarations from cpu-all.h
Date: Mon, 10 Mar 2025 21:08:26 -0700
Message-Id: <20250311040838.3937136-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Move stl_phys_notdirty function as well.
Cached endianness agnostic version rely on st/ld*_p, which is available
through tswap.h.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h              | 29 -----------------------------
 include/exec/memory.h               | 10 ++++++++++
 include/exec/memory_ldst_phys.h.inc |  5 +----
 3 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 0e8205818a4..902ca1f3c7b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -38,35 +38,6 @@
 #define BSWAP_NEEDED
 #endif
 
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
 /* page related stuff */
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 78c4e0aec8d..ff3a06e6ced 100644
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


