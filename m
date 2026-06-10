Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D84CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXZ-0007jg-Pf; Wed, 10 Jun 2026 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXP-0007bk-Jk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXN-0005Tm-Ua
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so77596765e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107936; x=1781712736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=deRXAksXVwlWKJu5tBvZTAm1qNWC42H6x4YL1/I4Jis=;
 b=OhSN8fqIBqI0d2qe/rn9jZHo+1oOFQPYyb0dA67/12GcKKgRn63J+L81nsoZcE/N5b
 ZzepFQ0VcfHeQZ4MyymYwL7Sa0Er63KuBYW0BVPbGbw1nGqqe/HtQa9kKzef8gW9+aor
 jEahrhRG17aVAYRJ+Pgok2/XyrWin1GJQZUj3RSIrLfi2TVD9JEhqMoBuo79yknIMXdz
 2n0zTPEzNLg1Spq1YG660QVujdTgCIqVg840YIKMCU+1TYcKbjp6RfEzjShXhHadUSCj
 1OUfZa/KTSmY1gOdlP1ihDgWLHsJUnBGRpnn2uqxM6gSsg+3wvjeT16LHCoDJMLY8vrp
 iQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107936; x=1781712736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=deRXAksXVwlWKJu5tBvZTAm1qNWC42H6x4YL1/I4Jis=;
 b=kawigH2Kzi/VS71l1o0trghWhJvOhjCPK4Qtz8ONH5g9Nyrf4arDpbscPGMagF80W1
 YbwrG+UbmtYkdZHEFvJ2362ItO95LINBUNNaRNFGb2Gp7kxZJf1Q7TAwKS/w2z4tCCk0
 FrqTZLQvY28soto3vjwQtfYsBi17mfg1RCeIOUdgH9mHEh/ZBacwXkjsVZdqWVKAjZ32
 rwxd3bdnvpch3EDVbp1A8nczsEMwZ2OxcpLkiN57T0zFSoCttwtOfwqPXEPVlM+U0l8u
 5OtRay6smxciId58TJEd5KAJETkejYcGCM14m+UAhNC89eisKVWwZ13VUEQSkb5knCqi
 8m0g==
X-Gm-Message-State: AOJu0YxjbGK6SLIEFUXdRUMbUu8r1Ax52NcUzbyctlk9Oxw8nriz27YX
 w4d8VODGGfKVwYoyFOQTeIbicNcYWrx2NxiTC+NzhM6HsnoEE9khcgnFY/w4kIrarB1qlDA1QeI
 +SIDY
X-Gm-Gg: Acq92OEWGZmKKwRo7xyepD3j+2ZrwMgjPfx2MO6V9rID+daTWNIjah3ZQbFexLBNuzV
 87pHFJzb5YU1I5Yq2RtPlFAJ9NidmWh2Rar5QWQ30dewdNMGSkjNyXrVtQwV7j1AnZvVtc4SJJ4
 oXOOkuUgFlSyw06yzmJo6kbp3QV22yTdKCzf564XdQjHuwLrdkxDB1R7nW3AIOOF6yZZBgbE/D7
 sS1csvnzzJDwjmD5zPuP2QjuFk+URKuqXnocu7huaH5XU7VAJwmJ0JiyoPNVWOofEy2pnSf1jSc
 LD+9LEFX2cAD/YvTv/AIjk7Jckz54VGEdKRqeLHWZfAqd0SIvx7Lyfmq7dRo/z1MUkpwUVe1rFQ
 DGrbI0wwoRzOK5H8wqE5AhARUFlsi87Pf3mJHkvusRv5INZrVn6vKYbDC1c+bPvZS8fz4oz6Um6
 jv4I3d71Kj4se62srrTpGGJL8bBHWCFodCHK4JpKs9nnJ72FBEp/EhqVMkUYmlk8FbNEjANFenE
 Z4Y8cjT7dGxUJXtbYXuN251j6owTz+f8HqXC4/I6iJaGX0LCP9c7A==
X-Received: by 2002:a05:600c:3510:b0:490:ab8b:1bb3 with SMTP id
 5b1f17b1804b1-490c25dd857mr408612435e9.18.1781107936249; 
 Wed, 10 Jun 2026 09:12:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/71] target/arm: add canonical MTE check logic
Date: Wed, 10 Jun 2026 17:11:00 +0100
Message-ID: <20260610161202.2235298-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gabriel Brookman <brookmangabriel@gmail.com>

With MTX active, address tag bits are checked for canonicity if the
corresponding memory regions are not allocation tagged. See
AArch64_CheckTag.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-8-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h      |  6 ++++++
 target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b91cde1795..f8cbefec7a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1658,6 +1658,12 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
     return deposit64(ptr, 56, 4, rtag);
 }
 
+/* Return true if mtx bits mean that the access is canonically checked.  */
+static inline bool mtx_check(uint32_t desc, int bit55)
+{
+    return (desc >> (R_MTEDESC_MTX_SHIFT + bit55)) & 1;
+}
+
 /* Return true if tbi or mtx bits mean that the access is tag checked.  */
 static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
 {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 61cdf92c54..d35e3ef04d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -858,6 +858,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
                                   MMU_DATA_LOAD, ra);
         if (!mem1) {
+            /*
+             * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+             * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+             * AArch64.S1DisabledOutput.
+             */
+            if (mtx_check(desc, bit55)) {
+                return tag_is_canonical(ptr_tag, bit55);
+            }
             return 1;
         }
         /* Perform all of the comparisons. */
@@ -873,18 +881,24 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
 
         /*
          * Perform all of the comparisons.
-         * Note the possible but unlikely case of the operation spanning
-         * two pages that do not both have tagging enabled.
+         * Note the possible but unlikely case of the operation spanning two
+         * pages that do not both have allocation tagging enabled. This can
+         * happen with or without mtx (canonical tagging) enabled.
          */
         n = c = (next_page - tag_first) / TAG_GRANULE;
         if (mem1) {
             n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, c);
+        } else if (mtx_check(desc, bit55) &&
+                   !tag_is_canonical(ptr_tag, bit55)) {
+            return 0;
         }
         if (n == c) {
-            if (!mem2) {
+            if (mem2) {
+                n += checkN(mem2, 0, ptr_tag, tag_count - c);
+            } else if (!mtx_check(desc, bit55) ||
+                       tag_is_canonical(ptr_tag, bit55)) {
                 return 1;
             }
-            n += checkN(mem2, 0, ptr_tag, tag_count - c);
         }
     }
 
@@ -999,6 +1013,14 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
                              dcz_bytes, MMU_DATA_LOAD, ra);
     if (!mem) {
+        /*
+         * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+         * otherwise it is Untagged. See AArch64.S1DecodeMemAttrs and
+         * AArch64.S1DisabledOutput.
+         */
+        if (mtx_check(desc, bit55) && !tag_is_canonical(ptr_tag, bit55)) {
+            mte_check_fail(env, desc, ptr, ra);
+        }
         goto done;
     }
 
-- 
2.43.0


