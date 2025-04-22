Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807CAC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JID-0002NW-0v; Tue, 22 Apr 2025 15:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIA-0002MU-OU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI8-000698-DW
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so219927a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350102; x=1745954902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3Pmx2FLEZ9kjbt+cSL6Q/1nXndHvzQCpATDx6amJMg=;
 b=s7ZfK3hwLZl+LA55jW4RO4i8KWsGOnotfmEWADQovEvXcj1hiV7utepQGjsl7Ue01o
 FPMSMVXD8PgvKvc3hlnhTRmzizscK2g+X988WuL2kqniwYRU/rwoHFVgAFJfdyHOjHF4
 vccCWKo971b9IafxmAzHnxb3X33mItfKtNj5SnOxUcN5+S42obo5qbnJhtUnrwfwL5p6
 ST3nf2j5F2v3hbR8HXQo5mCl+iWHWCt5njWRz5/UrwvDqY1T7pp286GtkhfYpBDD3Qen
 aA8Os7pS840i4pF94nIAblmutO56wGuwvO/nO75IGahgtMlHLfcj4MMEbbqL4Hp2Lnum
 r6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350102; x=1745954902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3Pmx2FLEZ9kjbt+cSL6Q/1nXndHvzQCpATDx6amJMg=;
 b=vNetFSFXcc+CFS3q0y5O8D+qhXGZG8grje757S01ZGTUuQKwOW3VCRaka6nge6pvcP
 aRoS2Kl50L40J1HDOq8Dgl0Ag8aMHvrM5mCMLgOw1QGBHnd/cZMTgUMxWV80CUpip2Bx
 cTlZpR2RoH0ziUwG//SAsRcxbB7iEopBouEQwUXjg9B/DrtzTNfVEn3tTpesdEj0BaFT
 nKNn4gkcSjHWtz4tnJFwQ1LFQbRGlyyt5dCGDXrcoYsWPz5/AdLFSN17HUE4wtJb6yrG
 h3BJz2bsLINrb4pMSWsYTeCMrAEqqzLS2gDLHxG+PdhN/C4On4TfKAkY6s+2ng4dLFO0
 9KnA==
X-Gm-Message-State: AOJu0YzWi4RZe5PNDabECKlfLTpkW1u6w9sqUnxyP/E22GqH6KsjHNL7
 88zS8FsDYFp2uFe/wOWAyTpWFijq6LfjXhgOM8DIy/p6elJxkgyfHKWtYHZGyjGjGv8uyAL8kbx
 o
X-Gm-Gg: ASbGncspKEEqgcg+bn2DsEKgYM5Yj9DEL0yFuXzEaWuC/qi48s469alf4NI9s5JLVL2
 JuCuoCVbHXnOXGS3WTi46xU2NeBetQX+y9ZgxTBzMWe2YtMmr0P9PkwgbjMz7K+fcfsV25/crb0
 2Lu628Oja33IgMPOShlipZb83kUPpliQWCjaF0TV02BMJKqWzW2iaNP3dmQIgaVtcfUeMdhO8/n
 NYmb0HstTSOU6qFKMPo+R/Et2MRX5Q83gXNBEm2Nrxv9OclFcl3jSXsYRW5pTXI3MUBgylbvzDk
 PGtCB5TMFd0FFTI7y8bT/4IKATjF/jiJWX0UPQJiA2WzHdVFMz/6SiPuqm5eUto2E7Bp2X4pc08
 =
X-Google-Smtp-Source: AGHT+IHyiBOi3NRLf4QBAXSg4pfZlKe1+JGNmVfHG6XvMzJGDIYOKIBKWl64Z+qaWVw8z+0NF8NV6A==
X-Received: by 2002:a17:90b:3a44:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-309df0f2f8fmr255863a91.9.1745350102502; 
 Tue, 22 Apr 2025 12:28:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 003/147] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
Date: Tue, 22 Apr 2025 12:25:52 -0700
Message-ID: <20250422192819.302784-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-4-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h         | 12 ------------
 include/exec/memory_ldst.h.inc |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d000fe4871..7e8d66de31 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -32,18 +32,6 @@
 
 #include "exec/hwaddr.h"
 
-#define SUFFIX
-#define ARG1         as
-#define ARG1_DECL    AddressSpace *as
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
-#define SUFFIX       _cached_slow
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
 static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
 {
     address_space_stl_notdirty(as, addr, val,
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 92ad74e956..7270235c60 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -19,7 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifdef TARGET_ENDIANNESS
 uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
@@ -34,7 +33,6 @@ void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#else
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
@@ -63,9 +61,7 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#endif
 
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-#undef TARGET_ENDIANNESS
-- 
2.43.0


