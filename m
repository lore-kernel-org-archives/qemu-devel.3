Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D195BC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtp-0001UF-6x; Fri, 17 Jul 2026 19:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtj-0001Ru-8T
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrth-0006xS-Cn
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so8057085a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330592; x=1784935392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DLlDGxtFFW3g2iYlBDYJu83t+bys0fFHlAOwYxW5TVQ=;
 b=xD/8HEMX6QCkkdbQ7teHj7vv/S//pXo0xcSAYvvTOXD5fQTGn6y8x/Jl6AMnGrEwNb
 HxavYc5xE3eojJ8qWDllxp5R2aNdQV5vs92vPyfihtUcUzNgh19ViyZejHcRStLMducO
 RRIREbr00kftYGPsgLvoH3riQYk5v1FohZe0umVA0Ofc3VdDN8jqeWSElP2Kltb7KxgX
 AVh0gqN3h9seGmeVwdP1ySfVjZMl8weo3tzQkVhDjHvvudFGzU009ERRk3RrjKMh995t
 jz1FQLpr5LWHKeGh4MfvmSW2VU37uoByc1DOUboCmbO2jHsQgLtCNZNP5+ZTLi8y1MJh
 GU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330592; x=1784935392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DLlDGxtFFW3g2iYlBDYJu83t+bys0fFHlAOwYxW5TVQ=;
 b=r4+qxHlDMohTTP/sfgUPCgfBGh5PZq1fpwWSzRF9JL6MxgJlfClC5mnYy+WawCC1fE
 /QoSJZlABHyFap+OgvPcmOHTNoSSYek6nStyZQqGnjWPPjyxMp+hD89hhG2a9QSQc193
 oAkpI5x7+Ymd8EvbE9nE5An8AeL+GYOzJOnlBn/SLLOHGTAlvNGBvSfkVs7+I4SkgAT0
 waUA5U7VHkO0iLmFPJ4N9AYx2C+N1K5aPnVbALAFH28gTWNTSqAP/aGYnxKoU/x9t1DM
 5ReAeLCoWeb2eyr9gBgQwo7KXIXRmQq+H7lWU4Lkf5u57matLDZXtFHjAfsc666vPa4S
 K/QA==
X-Gm-Message-State: AOJu0YzL/bwd31oIsTgNg1dLcgs1jDycb962EmCBGgwBcg6vwTehqbs7
 zho0uA7CyfB5m/0ryGwN4AUqrlTGqiHMoc7RO+5DpIf1YIxwiK3+BdY44Ebbg0KjNpCld5YGXjQ
 rI9+K
X-Gm-Gg: AfdE7clUPLA0hv5bkCXYtC9SHzCGJcSl3JKHOzMM6RoMkESlzqfr8HnrTMlRJavjM2i
 ojenz5Zz9gvtiJ4o80juHYhtDYbT8U/B8mvNQNSifG3rzHoflmSnpSsVsWOi2VviI7lRDg1Rf75
 fh5cQViHke3oVNPVL9m6VKN2SzcZ6zBFMVvHqusLziQeuHAtvILCrPAy5qj3r5FGr0g+tk7eB3n
 yueZrewYXudS9nGFCZlKZzS4/65ahkbaSfiXpOd549GeM7Fqdr0GwxWLl/Q9jRpSEeqorr3u31j
 lO1HZ377kqns0o7QxJ6PorOfrf/rxubeRCUxg67k8mWTIanCTz6y5mnfbgJ/YdUUEyYVZ+WjSgB
 DINKFzhCWGzP61/kteKATk7xDCJxcOT4rVsRkkXDf0LUvqcnEb9BglP7HRQ7ZqAouQuEyCA2LqA
 /UOVseaQ0=
X-Received: by 2002:a17:90b:1a90:b0:38d:c834:24cf with SMTP id
 98e67ed59e1d1-38e4b53433bmr4965963a91.23.1784330591800; 
 Fri, 17 Jul 2026 16:23:11 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/17] target/arm: Fix testing of raw mtx value
Date: Fri, 17 Jul 2026 16:22:50 -0700
Message-ID: <20260717232306.378988-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

MTX is always a pair of bits, one for each half of the address space.
Testing it like a boolean is incorrect.

Introduce raw_mte_check, a mirror of the similar mte_check function
that applies when MTX is passed in MTEDESC.

Fixes: 8912ceced815 ("target/arm: load on canonical tag loads ext bits")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dca4ef5a94..ad4ad5b4cc 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -317,6 +317,12 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
     return extract32(*mem, ofs, 4);
 }
 
+/* Like mtx_check, but simple mtx bit pair instead of MTEDESC. */
+static bool raw_mtx_check(unsigned mtx, unsigned bit55)
+{
+    return (mtx >> bit55) & 1;
+}
+
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
@@ -330,9 +336,11 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
     /* Load if page supports tags. */
     if (mem) {
         rtag = load_tag1(ptr, mem);
-    } else if (mtx) {
-        uint64_t bit55 = extract64(ptr, 55, 1);
-        rtag = 0xF * bit55;
+    } else {
+        bool bit55 = extract64(ptr, 55, 1);
+        if (raw_mtx_check(mtx, bit55)) {
+            rtag = 0xF * bit55;
+        }
     }
 
     return address_with_allocation_tag(xt, rtag);
@@ -387,7 +395,7 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
     /* Store if page supports tags. */
     if (mem) {
         store1(ptr, mem, allocation_tag_from_addr(xt));
-    } else if (mtx) {
+    } else if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
         canonical_tag_write_fail(env, ptr, ra);
     }
 }
@@ -420,6 +428,7 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
     uint8_t *mem1, *mem2;
 
     check_tag_aligned(env, ptr, ra);
+    mtx = raw_mtx_check(mtx, extract64(ptr, 55, 1));
 
     /*
      * Trap if accessing an invalid page(s).
@@ -504,8 +513,8 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
         /* Load canonical value if mtx is set (untagged memory region) */
-        if (mtx) {
-            bool bit55 = extract64(ptr, 55, 1);
+        bool bit55 = extract64(ptr, 55, 1);
+        if (raw_mtx_check(mtx, bit55)) {
             ret = extract64(-bit55, 0, 1 << gm_bs);
             shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
             return ret << shift;
@@ -573,7 +582,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val, uint32_t mtx)
      */
     if (!tag_mem) {
         /* Storing tags to canonically tagged region: fault. */
-        if (mtx) {
+        if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
             canonical_tag_write_fail(env, ptr, ra);
         }
         return;
@@ -630,7 +639,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val,
     if (mem) {
         int tag_pair = (val & 0xf) * 0x11;
         memset(mem, tag_pair, tag_bytes);
-    } else if (mtx) {
+    } else if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
         canonical_tag_write_fail(env, ptr, ra);
     }
 }
-- 
2.43.0


