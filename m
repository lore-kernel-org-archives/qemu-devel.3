Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E121AC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmg-0005Ap-W6; Wed, 23 Apr 2025 20:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-00058C-E5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmZ-0004IE-UX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso385075b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455777; x=1746060577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3Pmx2FLEZ9kjbt+cSL6Q/1nXndHvzQCpATDx6amJMg=;
 b=Xa+C12CUcKKHh+5ijwXnHNyy5Mkn12/7Gf/9Vn/+AZP68dlQ5Ydj8DH607S8syoSLk
 6uEE8U3fnxMEz0ra2nVKNQ9nGMq8K1q7ik0C4uaIlrZmVCRmU2Jq1l60y9HZpgYNTV7N
 Ocl3wLQtG6+SPkjMTfBQqMF8BAosMa1kZGHn4HxUozyFPaSlnk9CcI7sbtDfm1yjoHf6
 qqB6MMK0yKlyOoutbEaPcu7o8PHtoVOvXHaaxCivvhimCZx0ASof9U2hFV6X3WF8R3OW
 Io5FOUh53ttZZgA0quDO1xlBx/zmKwhN8nFeay8osWiYbM/3mUVeCF1B6OUo0hpyk0VC
 G+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455777; x=1746060577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3Pmx2FLEZ9kjbt+cSL6Q/1nXndHvzQCpATDx6amJMg=;
 b=TURsMg/tIogb5+2qS1U0mDht0vjsKdpdoxlOEurEKjRYyXbj37y021qWQUbAR+H9Tk
 VCQuOCFqdbPfx9aLbdl4xNwhS41/7s45h40dsvtPHSKIoMAT0wo575i0l0J7pPHezszC
 /YvNa7JWBuo1balYfIvyQtGS2y1om+Xm/qWl/YkuL/bE+iAbGeGr4bRjhfRuSjTQp5vO
 dLU7y7igYjYR/JD1rnFeeJD/iVNF1KRKzZNFJ8FNzxjMiFaTb1H9E0DicDNSSmp/hySR
 5uiMYMJDjJFJNZ349qfFPMtcR/V/vrkJVQF1cOELY/6hy/wW9dp0flQ1J+3svLHI7dKU
 21vQ==
X-Gm-Message-State: AOJu0YxT6zJk9r5oCLg0gwkXXVNS2bgx89J4SybxKsjoRER0qpcrTiuy
 mTGD9YW6R6BiT7UHgDYizTxaDzbdoQRtMMQdelr6lnU50pxyfSeWUdt4urOLcMqdqJPuyGsVFcX
 3
X-Gm-Gg: ASbGnctdEPdUyKD/5gew9Ismaa9NoU1pUW8y7755k0MQBbbgVLzvcfyH3vBddN8vZD5
 eE69afJMiVeFU81UCfmFhaqENrDe3Y6aa+EXCWiPD+HKrmYysf05x2QF0U+VgPL9IUZQI4Rbnwr
 +vxFE6Urq44+mxUVlszqZgIGkvl0N2BVlTC5nvE25JyTWiPLJmwVXVslNrAuo9LuNO5XPubwpF8
 +Xbsxlo445DcPbVJ+4QRT+cL0FCYTDzB7Y6GdxEZpbAEMQ1imvY0HqlXjcQ7koWagZiwlgWI0oG
 Y6AEAGbdCmq5ZfTK8OEI7csVH7Pn9kaC31M++oV/B/Ixw/oU6/qeUL6xHjQeoFk8ZObPBHpq/om
 Pitrbz9EvUA==
X-Google-Smtp-Source: AGHT+IExTz8Uuwa87C5Xcy6hJCjmiOrX7A8e7ByZ7z1A0kka7nR6VGK8/Fo/VIp/14LMs5xuej8bLQ==
X-Received: by 2002:a05:6a00:2d21:b0:736:a4ca:62e1 with SMTP id
 d2e1a72fcca58-73e2460543dmr1098954b3a.6.1745455777349; 
 Wed, 23 Apr 2025 17:49:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 003/148] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
Date: Wed, 23 Apr 2025 17:47:08 -0700
Message-ID: <20250424004934.598783-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


