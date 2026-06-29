Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93876C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfm-0006yS-FS; Mon, 29 Jun 2026 08:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfL-0006pe-Hg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfJ-0007JR-E6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so839662f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734440; x=1783339240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GcrC4AtoY+vXqBjgHK/kJhXaOE665auUSmXZjlmsf0s=;
 b=LcV7wmENLGEkhww8uNpv+wX56iuYkDjnWDnNsOZNqDyXxeCX63j7fmLM57Au91UBuo
 nsN000KGyYgeE9kz1bqMapDvB4r2/F3aYoTAxPeIyvtLvXPyvIMziatsNXrkag4V9X9x
 FN7LbDwhsE4cLKfp7dacEmwuRCg5hHa7THDGSJomAt7yjj/nfIk/6u3gNTEvcnS+iZB7
 sgViEJgpd93HqXUXTQVsArAKcBHtP2GoeeweR2cbcBu0PuMGG95b9wexmuaDePPmx4Kz
 jHS0BK8X4tw5EqNUzq+ATa6rnJcIOjliFYMGrMTjdp098BcSLZN6oDtwX/raMXSi7ze4
 NRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734440; x=1783339240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GcrC4AtoY+vXqBjgHK/kJhXaOE665auUSmXZjlmsf0s=;
 b=P3obE+2kbOVGCbpi8RxWEvYjDAesxHI8LELw5MBCOlGE4zWFSyb4BT3S8Bx4pSZdes
 8ZCln6m9+KHMzkN5PzToNn4U3QoEBBxmNcaHyjDLP7BHHMh3h41Fd+Di3wy2UDCMP2U/
 5YrrkUDdaU4x8DWE+GjSBnQjbq5rJhJBh4cX9u9cZJ9oIBrakV/wFqf6ilI9HKeOpM2N
 RI18aJGBVG1pHXYciLggRD0fZ+sHRnA0IRUk38Vl5edMb38OYrvMCe/6O20CmoXwcXVf
 ZtcJY/RcN+eU3nMBrsefmL7dHPbPkkVf1pIto/4O2ZH7KGQU+QEGQEYJQv0518KFSgBC
 bXuQ==
X-Gm-Message-State: AOJu0YxYEwaJIVltdKfDDd3lkAktxY8un8ZOt70zPXy9zY64gSDhrIBQ
 oJFM1lK3fBqdSPGPnCgCjzRHr6TKSnoIQ4SryTTEYDPGTLPFDkZw5p//rABS/IASaPGjYD0YfJl
 i948q
X-Gm-Gg: AfdE7cl19nc3Dr+vl/N3Oe3ov0AkX9wE2yQS+g7TFOTPMH7WR4Diwm6X7SYOMLuhDnk
 8OWre1Pnn0q7qxq2x65101mWnrXc8sLdlIJVBmFSzHJ+a/0bTdz+xMPzicYtLFTJkr9SF2I51bF
 rQZHE/8gwaQd4wVYcYaQszT2QWJfvPav3Smeg8GhI30uvcLBRikbokPMoxwP5cx7uOjMzaO7pF+
 WWO3Vf6dvwX2a4kHzVBGialhF/x2E6/1GafcYvpW8r8LrvPvFrkwf5v28lJcHht9AX/A3S1K4LF
 iNRXwMnQfTe6bHwUKlzdl5dIMC22+H9m47OpfySPEeVNRhkkjtZfuIzkdKqQdyk9pIOyCcjffcy
 uiv/yGMApiWx9ujpE+YRfvUkvlL1i3l5ClDVCD+dIWtMCgaqr/czH/sjcdwT2B0ENz+vyVHFRZC
 sOyKHBcpz3S8p6hcE9sUvcFSzUr/y4ri/Lyg/W5GwnHpiVdwnWkIm2tWMoPqPMKkfjHb9TTOmqR
 bmj/0HaedqBj37nNb1P0g==
X-Received: by 2002:a5d:618b:0:b0:46b:cab9:f697 with SMTP id
 ffacd0b85a97d-46fb87d3abfmr13551919f8f.24.1782734439762; 
 Mon, 29 Jun 2026 05:00:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/54] target/arm: Implement COMPACT for byte/halfword
Date: Mon, 29 Jun 2026 12:59:43 +0100
Message-ID: <20260629120032.1645265-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618040718.572950-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  2 ++
 target/arm/tcg/sve.decode        |  1 -
 target/arm/tcg/sve_helper.c      |  2 ++
 target/arm/tcg/translate-sve.c   | 22 +++++++++++++++++-----
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 1d9066dcbb..b64a0faa19 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -733,6 +733,8 @@ DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_trn_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_compact_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_compact_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5ec1d420c2..a3eefd60e5 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -693,7 +693,6 @@ TBXQ            00000101 .. 1 ..... 001 101 ..... .....         @rd_rn_rm
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
-# Note esz >= 2
 COMPACT         00000101 .. 100001 100 ... ..... .....          @rd_pg_rn
 
 # SVE conditionally broadcast element to vector
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b45b0d331..bd8fa2da7e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3657,6 +3657,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
     }                                                                 \
 }
 
+DO_COMPACT(sve_compact_b, uint8_t, H1)
+DO_COMPACT(sve_compact_h, uint16_t, H1_2)
 DO_COMPACT(sve_compact_s, uint32_t, H1_4)
 DO_COMPACT(sve_compact_d, uint64_t, H1_8)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 57c21a13e8..01199dbd78 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2769,11 +2769,23 @@ TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
  *** SVE Permute Vector - Predicated Group
  */
 
-static gen_helper_gvec_3 * const compact_fns[4] = {
-    NULL, NULL, gen_helper_sve_compact_s, gen_helper_sve_compact_d
-};
-TRANS_FEAT_NONSTREAMING(COMPACT, aa64_sve, gen_gvec_ool_arg_zpz,
-                        compact_fns[a->esz], a, 0)
+static bool trans_COMPACT(DisasContext *s, arg_COMPACT *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_compact_b, gen_helper_sve_compact_h,
+        gen_helper_sve_compact_s, gen_helper_sve_compact_d
+    };
+
+    if (!dc_isar_feature(aa64_sme2p2, s)) {
+        if (!(a->esz >= MO_32
+              ? dc_isar_feature(aa64_sve, s)
+              : dc_isar_feature(aa64_sve2p2, s))) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_ool_arg_zpz(s, fns[a->esz], a, 0);
+}
 
 /* Call the helper that computes the ARM LastActiveElement pseudocode
  * function, scaled by the element size.  This includes the not found
-- 
2.43.0


