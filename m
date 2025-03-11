Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19791C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5kb-0001cb-Hu; Tue, 11 Mar 2025 15:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k5-0000x0-V5
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k1-0008V9-IO
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so113519875ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723094; x=1742327894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcP4MFj0H7Fu3AxOxTbJlPG2KgbdJwiBtz5sSPdKZDU=;
 b=iws8qo3UagKBsqqcvBdMZILd8sTU8/0hPnSqw57kQtJ+HwyOIqKs68fcbPusKltir/
 iCT5gmNEriSOgmopllPjTpBIXw2GRaHNp3le5USWZgIpJXLrjOV0CP6jeOmRaBIqPdQM
 PniY74PQRvq3E5pVv0Pduf56D4iNYqSb0ynshPiSRmNxyyGdIlQyce3nMVHSIbSS2i58
 k+FnFyx0jbgWYuhuLMv7QUPvSKKyIKiIBFT6drPwiDZYLhwolj42rnTv5rRILdCaUchT
 iEELVMtRYjzvrwzU4Uo9FKNEtBM/imuHGMniiaW14m+AtU/ve3TlcIorPxooZS7Qy1vv
 zJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723094; x=1742327894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcP4MFj0H7Fu3AxOxTbJlPG2KgbdJwiBtz5sSPdKZDU=;
 b=C75L3l/9hapBrzMOlVRk2skWjivcLXIpV77nizHLzREjvbQf7FeBagvjE5asUxNLxr
 geCn3Xi1sZiJvMXcZgNvV+6HGF7bzwDjKQ46EhNNND2m5l4S3O+ANyFf3sryYn3Osry5
 pGi4pGf4RhSd4STHmDTaiHQiNHLSgpgkXGwfeOHDssGGQPxkV5AwIArU93TSbrDMbcqj
 5DMdWf7sSQYUUn/c8HYUnrT9SU4XcXF+W9v3zV9ofK6MvNrNDJQs90hZ+8VVjIweUwtd
 7lvT891anQPaZihqB9wGOgada9517MNmnI98J9iNV8BB9DXKvImf68TegEHTWLMBG4sA
 yI7w==
X-Gm-Message-State: AOJu0YxOWqIa6Z3ovMUI7YY0bVRrOz7UaBsn0MK5017bVwpCfRDzWg7L
 upGHy6ywz7Un8FTripcx8ab6qRxDeY4MxkTcwZ4QLT74IiWi5oHcZZyD9v4AuRRR4EA9OdXQAbj
 c3SQ=
X-Gm-Gg: ASbGncsrAhwCTvOdiJcrazueQIJx6V2bouZMf5MHoAvTA220P0D+uwFA+ktYJyI5HFc
 o0by8fSS1xMs08uE84i4h4KyAzJhNWczsZkki/4hmmzTAXEOY7isijnvuIv/P41QtB1hrLTHwcG
 lMziYDCMuYnvx7QF8ns9hr/BFLw6PeGFApvYE50BJ9SrtisvsJeJoWaQL42lhPUC01MwBBjHdfp
 n+WKzQDwPbnNYdEFQreQz1h4YT/EgHarCh1RGIoSScp39c7Sq1zJRJg2z5humP6VkM9gg+9X3y1
 Mzod6Ot5CGxUD7czCeTEPPUMCNxWoICQ4ag+9oln03oq
X-Google-Smtp-Source: AGHT+IHtn3wjueX80hXlhR3WWJLzlWQ/GjOadBaAC9ISUpU84/t/abdjw/+6bEkcmiHY0rapbw+ALA==
X-Received: by 2002:a05:6a00:189b:b0:736:755b:8317 with SMTP id
 d2e1a72fcca58-736eb8a15femr7017121b3a.21.1741723094173; 
 Tue, 11 Mar 2025 12:58:14 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 03/17] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
Date: Tue, 11 Mar 2025 12:57:49 -0700
Message-Id: <20250311195803.4115788-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h         | 12 ------------
 include/exec/memory_ldst.h.inc |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e56c064d46f..0e8205818a4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -44,18 +44,6 @@
 
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
index 92ad74e9560..7270235c600 100644
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
2.39.5


