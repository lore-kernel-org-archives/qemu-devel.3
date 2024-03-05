Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC7FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEd-0001DR-Cd; Tue, 05 Mar 2024 08:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE6-0000yE-O7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDs-0005yP-Lt
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso3056064f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646767; x=1710251567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FaUm8MeteGmR0lHrGgjk4UbknhXCWtTITJeZHOGMnnU=;
 b=DhRrq0+4jSKsPcmaWx3cjUh+RKWaXqDW34dU87662cmRxcrBqcKVBrzxJA3HsiDets
 4P0d4kDWnj+A88qN3oOIUOwgR71XQZ2Q3KBtrdqco6rn0OF9rc4SXSrc2vs1AB6TEJej
 w21/2mQlTqt6sbDOv+ulT8Lhk7dNrUbjPOeXq61ncvB1oy1M/0ITsmR3SL2cZFdISgPQ
 pLP/jThwMKk5q7iJLFjD5lPPrIK3/tfQ75FmfPm5QMfhxgLiayilE8JuadvVlru3cPDP
 UYmyxDn60hMIFXc44GPxz/80sau0GTF0cRt/qIdMM/cpmrqZ4CGvdnUHA80wrxTQNuVg
 tSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646767; x=1710251567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaUm8MeteGmR0lHrGgjk4UbknhXCWtTITJeZHOGMnnU=;
 b=M0SvjVHZpOl3nfSgBVEMGVziUb9bTeQ/KGr2H7wpvAKPNAHWJDWImhue04M1Els1G0
 mOp06HCpSFZpLMmjJPzUjH3u0YBA4pYOs9zHRl2959z1o41/HJlq70qzHlTsoCZk6ft1
 K97TFIxjVzO7Zuishi8IUGV5FqLy0ak7+Fj8g6kFG4/txGCu9o+KluDp68Tgjt/lg7JW
 amK9bgNJigJ1cWtM32aW8tJBTjOpv2tP8ySvKl6PSy/2jqKx1v0HBkv7WZInW4MS0XJr
 mvTNJqdEHvN3ItzhwkpCyJ8pVwt8PgURuBLTmgBSvGrhJU9Wvj4J7+O47/awJxnR925V
 Z2oQ==
X-Gm-Message-State: AOJu0Yw67cEg+chzKXKQyLMkVn/PjxqYRDCmao/fqcD+g1H2NX2xftSB
 R49Ds0dZCBpik3CwuI7jgKJAuc85tStpSZVwSMhytorF5exwjaLQ2/NxABY03r12HlsidwOu3av
 V
X-Google-Smtp-Source: AGHT+IH7aoXJuuPvzFeSkf98aDpIc41+MTlwd0Y/juVVpfI1Ng6E832KWTH1qS/wr8OmdzO/03Hh8w==
X-Received: by 2002:adf:b509:0:b0:33e:2d7b:c5a8 with SMTP id
 a9-20020adfb509000000b0033e2d7bc5a8mr2200239wrd.17.1709646766891; 
 Tue, 05 Mar 2024 05:52:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] accel/tcg: Add TLB_CHECK_ALIGNED
Date: Tue,  5 Mar 2024 13:52:33 +0000
Message-Id: <20240305135237.3111642-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This creates a per-page method for checking of alignment.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/cpu-all.h |  4 +++-
 accel/tcg/cputlb.c     | 30 +++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index bc05dce7abe..1a6510fd3bf 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -357,8 +357,10 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 #define TLB_BSWAP            (1 << 0)
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT       (1 << 1)
+/* Set if TLB entry requires aligned accesses.  */
+#define TLB_CHECK_ALIGNED    (1 << 2)
 
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT)
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ac986cb8ea5..93b1ca810bf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1453,9 +1453,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
-    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
-        ||
-        (access_type != MMU_INST_FETCH && force_mmio)) {
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
+        || (access_type != MMU_INST_FETCH && force_mmio)) {
         *phost = NULL;
         return TLB_MMIO;
     }
@@ -1836,6 +1835,31 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         tcg_debug_assert((flags & TLB_BSWAP) == 0);
     }
 
+    /*
+     * This alignment check differs from the one above, in that this is
+     * based on the atomicity of the operation. The intended use case is
+     * the ARM memory type field of each PTE, where access to pages with
+     * Device memory type require alignment.
+     */
+    if (unlikely(flags & TLB_CHECK_ALIGNED)) {
+        MemOp size = l->memop & MO_SIZE;
+
+        switch (l->memop & MO_ATOM_MASK) {
+        case MO_ATOM_NONE:
+            size = MO_8;
+            break;
+        case MO_ATOM_IFALIGN_PAIR:
+        case MO_ATOM_WITHIN16_PAIR:
+            size = size ? size - 1 : 0;
+            break;
+        default:
+            break;
+        }
+        if (addr & ((1 << size) - 1)) {
+            cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
+        }
+    }
+
     return crosspage;
 }
 
-- 
2.34.1


