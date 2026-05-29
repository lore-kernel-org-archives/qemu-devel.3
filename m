Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B83CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gm-0005hN-Sk; Fri, 29 May 2026 15:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GX-00050J-KK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:11 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GV-0005Zo-Vn
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:09 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4856128f670so5547506b6e.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084386; x=1780689186; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=takdfyWiXXVLrnGTHIjqt065rtU2KRdDbRfE40YLLNU=;
 b=gU4pPh0eJsUu5cUmBWXd8dCu0PqwZW1e0xyHwQn1lJMjlH9pUYGcFc30NqjHt/tQV6
 pg5n9SXv4QmUKn+Y0m2SmRjdacGJDs0dSVeQ40LhRFddmM48Co15T9pGFt/kZpfhJD7I
 3+joSxsFQGoiM3N2bwD5xXlkuiSHUWHxq4uWxyrjRC1VLVugLHY8tW4IGK6xdwEUze0W
 uitr46361T3xgvyjKYB3tbXk6xuE9DOEUUId7alHVOcFmXEE8cBvBBKV0EndzYgkeNBy
 Ze5jfbbGoWpd9oehIDubT4HEkfbYPFIGRiJDSY0LjrqUjaywUC5g3LU1ZuJv1wbiVS3/
 w25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084386; x=1780689186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=takdfyWiXXVLrnGTHIjqt065rtU2KRdDbRfE40YLLNU=;
 b=Yu4HfUGCoihVth0g4ImgwJr2M97EeTzJJyoNQwJSYUPFdw/8FU4bL5MBlSO8U3CkPi
 MnyZU2FcwVR8PinY0hjHeztJkM3RJYivmED/nU3sK09DOnqc2L/cv4+8qMialuDenia4
 nkpn96ofAykJgJCxC46FoU22vB8jGCTAt6NMSjHN9cd3LoH2BUh5Wiw2zQd+Kevz7bbY
 JOVTL26IGD2b0OZWwiSt3Qea/2BTQziN9gKFHKMnegkmc/OFrcxrfupIvkjxC6m8bBhx
 3EQ30bfgKKJEF7gbG/LuVw5UpW6i5zoA9sb8VXLy8UY0PiNwWjzMHvb28hR9EwwLbNJq
 c4Bw==
X-Gm-Message-State: AOJu0Yyhvj+e03eUgudxwtjsEjNq/putsV3h7GK0JZsEwQKOKZquHp3p
 l+01rDGmFoI2I25yJZm+KyuYNI0XCBqoomo+qc+4XYhkj+GdjZah1TiQ
X-Gm-Gg: Acq92OG0PIMxLCoCPz2ZhH56kPNardcQ0GzVQFBPphRGx2ZNX4BBDN/uUTBYyrVGK0W
 9FgxVpaozD8cS8IXdlMZMxVL5r2cbnr8WiZqqFJP3f8Stg8H25MXt0JcuDpQLMJjxazKIC25Tad
 UtSYvEdhFVaatT0cH9BSVysX0a0yV2jK3jTfx6/spQ5nV098T95D5CgYt9HAVezgfXU+4z3G4fl
 ZjtwsiY2vFTC6VLs5d/73RiPx0Rf3Esv43Pk3PaRG5Y1nmEsI7wQE+7SUM7piTFcX3RrmL7VOek
 DIyWvFa/Y9SVcZ7uv0U0CONYfg3rlwoL8taiDQHdVyZY/TxUY8gzNtKvTMJed0KjDw7H5vslYoO
 1kqADafSLzdi/cl/KI60VNPKiUpurAftca14XXz8GXOWJFYi9X63Nb9a6Tb/K5ZkXp4MzceTtk4
 Yji8A4OUEW0ToCrpU52R6HDRn5DV3Xk7CYB6eOLQDbVlxPjrosMPeFPA==
X-Received: by 2002:a05:6820:198c:b0:69d:fe0f:6a62 with SMTP id
 006d021491bc7-69e103b6236mr417221eaf.41.1780084386537; 
 Fri, 29 May 2026 12:53:06 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:06 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:48 -0700
Subject: [PATCH v7 08/15] target/arm: add canonical MTE check logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-8-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=3812;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=TQrho9CGEIkIuNRZMkdpuKAfRMf5fhwXjihR0xKAi0M=;
 b=+abtpZUcw8kdvptbuA9lHj8868oWKUCGZnIlqFKC8x/JQ11pxtWZRM8ALhQBvGrCNmKDkOq5z
 X44mGu5ftx/BMhhlzEGylkC+zcd9ShkfDCPTIHkSM4I8FclBnuyLsmT
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

With MTX active, address tag bits are checked for canonicity if the
corresponding memory regions are not allocation tagged. See
AArch64_CheckTag.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  6 ++++++
 target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 92941a3ac6..51d7f09889 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1648,6 +1648,12 @@ static inline uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
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
2.54.0


