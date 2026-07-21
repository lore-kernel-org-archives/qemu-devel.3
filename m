Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C20C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bt-0005QI-Nr; Tue, 21 Jul 2026 04:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Br-0005PP-Cn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bp-0005gt-OB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso16147405e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623860; x=1785228660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWtBag4wvA9vYOnCp1HwRngJudddkIzftxnQ5jssfsI=;
 b=TVW7DS7ap9o9O64AVZ9HnxbzQ4YH7hEtO3lnD9lioE2Dxu1TPt8iKUKMv6UG8xj3QG
 B0lrX74YfekAaHclCM7tmeM9S7SVevlTyuwFb7r6xgK7RTtycey9xH33INocUr0s0iHc
 9BW4zaOhLjDNB3/t5YknqyiPkc05tNYE1O3VR/KpD8Bw0Mt3jQBK/48ShLf+GM3/F9Fv
 WRVt2ulN/l6+RMRwD1wXaWR0m3mXBOQzpkTZ93i/iw1OVQ2DZ4/At4JzLv4koGErmUqH
 +3pUKHPXndxWfknFyPH19u6nNz9PlUNT3tlNS/JNxfZpyfe4lUjNJCg5vQs16BfLUxkJ
 etxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623860; x=1785228660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWtBag4wvA9vYOnCp1HwRngJudddkIzftxnQ5jssfsI=;
 b=em6RlCbKXOUf6fJJRC9z1+0IcjiFii4YwAJ2gDGq2RGa1nkAQRi3K77UtTAYCQJsn1
 A5gOvl9/xJoqjhAye63sg9yN0J5nHRwhJnbhVZn3OfF5Xw2V8vTs8x8ynY4/FnYgh6hK
 8Wyp/4+bC20jko4Pfl5sm19DnUlUa5z6tSY1PUSYkvl1cXOc5WsnGm+vsuReCRWOqKk/
 ejoKVm8zuh/MMg8Rof+8/z0wnCdk3EwDDLAJo78H7Lu9zclLQC08H6ezBJP2BqOOo1QJ
 m/Okn2iGpV5vs/EaBnTgIcRM6KL/prAx01P4gXoel5fBrFVAMxMjAIA/G/nQVBqEqR1w
 bY7A==
X-Gm-Message-State: AOJu0Yx0wrpxBIPSJjaBOT3GXePq7VRSru+/X4iO+euGDj+RCz3bdF82
 EKM6N1MxMjVAKPaB7djRoFkxlxzT22/KByM+8BCHNB8pvCxRykwtjK+9onH7BLqndFd0zjHHqjd
 RfPsUW94akQ==
X-Gm-Gg: AfdE7cnpwM2JKGPriHWmeaKwq1L4uBSNZY9IY6w2uHuUIlJafUJox8B5nL+HikEsvL9
 cgD9dpsZM7tccOQ6ZBxHHWoS3ofjx3jUK2+PJHpWvLGzHr+HLsGDu6IOH+2FUYuyr1gSkVmd13q
 Hyzj21zIsb+GrMoisJFkLgOQt3JTMoxsc3OK1AOI1VidyWomtGwV5ghqZhVvs8sJzSUw9dlJNNx
 YKbdVSsuhvEXHqPSinmyatv3ENdZH9S9byRAnEPmEvnjl3+3IgyZXj3QcJ92CLT5WxuvvGf/1VB
 byz8EAOEyoIwmLD5LbU4ga/YPvQt6dtJ+PETIRrkBENpW4tUMFPjTzLbaV+ra7tO7U7sg37ab8b
 oh8QJFwuVMOY3RatmZej19Ul0qSq7nOM5EouLfYg/0GLq1tvV5bgRT1rek4HmV7wUvuXea4+phb
 MfhJFczz5FSV6lhtxFchGr8eAwTEp0j4MAVeY+kpJglACVqLV6blEiD0+/xo2GSBdQmMxgzHgRi
 cRCbckureM=
X-Received: by 2002:a05:600c:8b37:b0:493:e4ce:acd0 with SMTP id
 5b1f17b1804b1-4954a3d0967mr196037115e9.1.1784623859986; 
 Tue, 21 Jul 2026 01:50:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] target/arm: Fix testing of raw mtx value
Date: Tue, 21 Jul 2026 09:50:40 +0100
Message-ID: <20260721085050.421257-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

MTX is always a pair of bits, one for each half of the address space.
Testing it like a boolean is incorrect.

Introduce raw_mte_check, a mirror of the similar mte_check function
that applies when MTX is passed in MTEDESC.

Fixes: 8912ceced815 ("target/arm: load on canonical tag loads ext bits")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260717161430.37264-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mte_helper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dca4ef5a942..ad4ad5b4ccb 100644
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


