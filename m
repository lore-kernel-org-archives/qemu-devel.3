Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD17FC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wklCz-0001Zt-SY; Fri, 17 Jul 2026 12:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wklCx-0001ZC-7y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 12:14:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wklCv-0005Zb-CZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 12:14:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so6093951a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784304876; x=1784909676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vt3DiaqW5qG2P2oPwNInNzI8OWYzGcBaBG9ClXHUZ0A=;
 b=rxCe9/kmRR9nwr2783bLki0Y/+Dxrlr8eHJlLEGD4aw3FGJX6hDqe3YuUTKs0gGdNU
 UjxKOuZByNH5/DCH8yV4z4wrAfm2auqopSmdo7WZsj96n6HsOkufK5jtE2Emrrc5+WHm
 UGvowXS8VgiXQou042S+qXjIVdtLP+A/FaDDbiUNW4E+k+2PnG9xhVzBbFG1D14RbJoT
 AOzxhMFwwybepPWcueOuaPKuctezTMo3PPPLgjQfeGQu/FzAGwGyEWT1BXj3NfOJ5kHP
 Z5y7/v0I34sJyOWGO8Q7QUj1dy8azUpk43NHoTKFTPhHFjl5+ZeIHLuTnIRZE4l5WHeT
 x96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784304876; x=1784909676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vt3DiaqW5qG2P2oPwNInNzI8OWYzGcBaBG9ClXHUZ0A=;
 b=FiKvYC53DMZn2p6pVMQJtEGcz+b30POK93jfwnP1aVN6b5WExAvKjtBjVlgQVUgsfU
 1Y6Z/z1SHIB7m/75pnUdDgP0QQGX1ypY4e3sabQT+dpfuYUAzUkw60NVp7PN5EcUQTyK
 EGk4tz11C2EToV1/XpD+N4XmmPbTOFxGDwFcNswRHkDQ9u1qiRD1qiUgsuE/lQvtmso2
 x1xQdTbSEZ9DTKrDI8A1Mb50FadwAUpNhY2+m6vvFJ/6uqB3NGGQftjU5z60e3zj954Z
 LUx2dIT6sx3ulN9EakwUIDQFoWhjk6Urcs9Ok1AFel3aGF80dAGjxxOl+5HunR9nNCEC
 Pp9A==
X-Gm-Message-State: AOJu0Yx7FIBoDIehbx51Q0YwfpYAROqclD2Ms+Ju9Eg0pPTHDWQgh0hK
 Jv2o2tya7TC938DxLwVdgI1MWZ8K8nvy3oxzYZzxqlbw59fdaHI3EX7PGd+MD/aTc1RSzqQNtr0
 DIrJD
X-Gm-Gg: AfdE7cnYNg6RmEGwkYOrSYogbzmOEBntpQ5UP/pG71MWLWIU7kFlYyHordx7p6gI3ET
 wYDkRYYe/sxcORdgMb2Tnz+Ib/Jbd9OpaUKeUnu/Uo+9UKldjBFleyTVblKZ1KI3uym9MuKoWpA
 cG9fY0tjxRYK3+MV+V+wUHNLxqRNNQy9P7QZRwLlRQWHA/YcDlFNBVXfEADqqTI346BVbp+ceGG
 L/CT3EYDZBh8Y2aK6GzRqeDCIPCae81tHZ8KCEw0zVeLDl983sZO8WPhuOSKiqpMQ7RfXEO7998
 a7SUsLdemxpd1KVTaZfxr1jo8lfb+EpuUzTJRUAmX67ajCU4J/D5XmQiYoYbRGXPAm3cchvY1iX
 Gfii7LyFjWuyJHA9krykP5BWq6h1QhywxC1lRPV64TxMmRYOmnXecCCtoaiHmkoZmqanJAOoJZo
 mF9+ZnOfU=
X-Received: by 2002:a17:90b:4c48:b0:387:e0cb:7f0 with SMTP id
 98e67ed59e1d1-38e4b585ed3mr3276716a91.36.1784304875576; 
 Fri, 17 Jul 2026 09:14:35 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20cfe3sm8989724eec.30.2026.07.17.09.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:14:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	brookmangabriel@gmail.com
Subject: [PATCH for-11.1] target/arm: Fix testing of raw mtx value
Date: Fri, 17 Jul 2026 09:14:29 -0700
Message-ID: <20260717161430.37264-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


