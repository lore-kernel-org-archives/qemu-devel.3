Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF86C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtl-0001T2-Q4; Fri, 17 Jul 2026 19:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrth-0001Qk-RN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:13 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtg-0006xA-2O
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:13 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso8331325a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330591; x=1784935391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vt3DiaqW5qG2P2oPwNInNzI8OWYzGcBaBG9ClXHUZ0A=;
 b=xD9q541/6ZQljVILJODX8YwKqDL72ro0GByGEzQmF17jWMi+v6RHfnn7D4FgrryUNM
 gqIXhaKmgRK0PFJ+g+1TG98I+BpFc5MeYxzQLq0+mdCyJedQbh6/YrtISflEKaeW+356
 6lAyX7d9MgDrVbnqDLp26paiMKsLRLIjAu4ABACbAa+10sRgCPezcDYhdVONkiregUcl
 P3OVhyA9EFoqyqGZYT738jdPcXoj4E/ZzgNzg8L0uwt7mpKq4ZIbJRCnUcS6DIgp8IVe
 FSZpAmuJ/vv+DqWUJroCG4DYuJrefsPiK5EzwMVCg8LjK82W4qWwRJVxzwhBvSP4CHEd
 PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330591; x=1784935391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vt3DiaqW5qG2P2oPwNInNzI8OWYzGcBaBG9ClXHUZ0A=;
 b=SuxvhPDkzQtqRDvc/3pb51TboGWEgcxzRx7I2c4X1X0zK7uzd4ip+Mv9dDNX67bbRX
 Fohs/MIztiGZiZfoX9RzxN6x/aepLcSuudsslpVErrhxCohwf8yNxIsBvnosr1WzUyZm
 5TrpJ1g0vN96r9wUx+nht71MOaFXLqweVvS1HJhDYxSusCRCGvGoaRpnkO08R+zWns7U
 iy+idKK4l/7RbBMdFlzKZ18344YZ9apTPnC2CSFR2WoRfEBg3Kd3BGCTgAQSFnehxu2H
 eWeU6JFySJbBHAm1MVXkh0wouL1ASwjUOAofTUuCicEewjIX4dM+KC1sA7RXUwa9EWHC
 XyKQ==
X-Gm-Message-State: AOJu0YxngUoX849dJ76QolkDCE1mDqpDmMEIWV9er9n6a3USP0xHESYR
 tmt+h+7bFdeDnC5dBOt/fQD8qy2VqfmZbPf0N10V5WGSDsOc2wUmooq8M7PSG/fJdQ7pty0YWlG
 WUqUy
X-Gm-Gg: AfdE7clqS9Tm261UduhyY0RlEAuLYKzQX7W1cf6a6xlXTTp9OVCQGq2kgWr8fStuHRH
 dlC2dwzJWeHFCcyjgz7RFwvAeH/Hmo5UgV+bHfSPrUj9xAU5tkgfRxw+dibDTIgfHO1SYNQII8h
 55y2QrYHa76/M32J5XFcE4WbBG7ZV0D8Q4Bs2DGhbL+kKV9KM+6TOy5h4EhiLkFriHQjmNKrJT/
 ke8sZRNnNvZHP2FTIkn0Qr65go8cqt+tn2AO2ZS+2oGCOgGbRIVhL03ab57hFKRg8/6a9ahIfKs
 TlRDycNe6z3oLquM0cXHfEmhAHMQoi7noLbkcnKhR8NTVhqmApmH5uKxyshNn8RT9yXPP+VM44j
 llhcvF3IGdR5/u2Dq9OsMVRXjKaMLyC6ShL2uCQs/2xGT44PPyeJk+x740Fi5L7iA8Ji5ZRlyOX
 2TVX4ROjU=
X-Received: by 2002:a17:90b:1804:b0:38d:ecfe:41ac with SMTP id
 98e67ed59e1d1-38e4b2948admr4575340a91.0.1784330590589; 
 Fri, 17 Jul 2026 16:23:10 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-11.1] target/arm: Fix testing of raw mtx value
Date: Fri, 17 Jul 2026 16:22:49 -0700
Message-ID: <20260717232306.378988-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index 04c637a9e2..616c395cb3 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -374,6 +374,12 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
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
@@ -387,9 +393,11 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
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
@@ -444,7 +452,7 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
     /* Store if page supports tags. */
     if (mem) {
         store1(ptr, mem, allocation_tag_from_addr(xt));
-    } else if (mtx) {
+    } else if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
         canonical_tag_write_fail(env, ptr, ra);
     }
 }
@@ -477,6 +485,7 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
     uint8_t *mem1, *mem2;
 
     check_tag_aligned(env, ptr, ra);
+    mtx = raw_mtx_check(mtx, extract64(ptr, 55, 1));
 
     /*
      * Trap if accessing an invalid page(s).
@@ -561,8 +570,8 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
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
@@ -630,7 +639,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val, uint32_t mtx)
      */
     if (!tag_mem) {
         /* Storing tags to canonically tagged region: fault. */
-        if (mtx) {
+        if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
             canonical_tag_write_fail(env, ptr, ra);
         }
         return;
@@ -687,7 +696,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val,
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


