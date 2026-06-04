Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A256CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoJ-0006tt-Rw; Thu, 04 Jun 2026 19:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoG-0006pq-UJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoE-0007yh-Dh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso12820745ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616949; x=1781221749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0FW3DsjEZddqvM23thQ90y+i9n6EfT233NwS1iXpUQ=;
 b=dm5FnQAIFU1poQBOyAb5/Sa7DajX8mMcOu1GObUHhZ0+qjVqkgW5kE17Eqq7h7Il88
 N658XT5nMSli6XbQRKcjDIoS4/61m86mK2VlfAadRf8XJt0qiRGioMhs/iSvL3TUGcH7
 3QE0Q02aFiDsaKoMCI2DmZb4ha358j2sZ8jfzW9n/OakhCLrGprotJyuzaCA2yONjZEm
 mw2+4ZTf6+ojxmxnPuiqxjfnQZSImtD4+Sfde0/EK0X/7ddemtrT4dJoHqPfJCO3n72b
 eOKWVdvADVEHPuz4evULIREFTvFbZDvPOj3Oxg2BWq1Kj4HTRJIE6A3i0Pnw6RlBYxqx
 7mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616949; x=1781221749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L0FW3DsjEZddqvM23thQ90y+i9n6EfT233NwS1iXpUQ=;
 b=MVZQB+CBSH59BbAwGaVgpn1Tm0JjCovnCQeMHjOXBftjdJFObytNh56vJAwxO6i+0p
 aeQonRKl3llkpjmhH6VxuUzOlQHXvxEIeTbLGdFeVC96NR9YnFZd7oSd6zFsVIFNWdCO
 dMEWsWlnSMnZOsMM0d88KQI6WXR3UB4h2C8MdgfLyxKiNETQYHm6U4QDgQ3L2ReRQtJG
 YBr9gPHAiq4ZLEHaMbO2rklz+UPUbhGO435yqtGIo68Th085lO4kJxAx2fDARLagkxKe
 w7BdCHKK+5bxdIjfmoKnylkF6UXx3QqabudV91aBcM+yHooqldZSaZDr2XKLTcWQi2xC
 NgoQ==
X-Gm-Message-State: AOJu0YxsnEN2ALA5q8vrlLOffqC0L9wsre64fs7z2A+wrLC/6Z0Q9Jxg
 llw74tcF0nFXhRCgM+r9gKsSbfBnoOlaRLQ+Grob3OFIbjoT3/PcKRhGBtyfj8l0JnKt5GBuM+d
 QUUKPxy8=
X-Gm-Gg: Acq92OHCy3ZYrOPYu8N/MxEnZvVzBMPlQtxvhtM1E+L5vplfN49XAxGZXiVXDowRUm7
 0Z5sqFwU26lfV0irR49RSD+jMq4b/vBmdA/diRchNTdgeWQ80+8iJ5t88yBzFi/N5XeEBdA18Gt
 UnkCOR/prNE6qGBwEzlpNbhN6maFeE/PxxoGwgnGvwxU8ijOTPmy6wKXJgJTn94C0/7GZ5ubEIB
 /sECemxv8f/JNvUoBsW5DM1Xmr2RIfMVa4my5HOsl/fKnbZk8/nHbX8CHbNqXEAJooQu7TiUFs7
 OlpSn5Zt7Ew2LABmbsIN5nyGsBWB9C4R/OZWOwqhEevBzZfBWm00O/V3VCaRigMmJyUcV9X3RFm
 NbY6aV6BXt9nSYtaA02Dd7oACdyy3iNcU7uX49b5I7waxOdiHxwRKgcxCewpkYWsmATxJ64NaJu
 HAD4hRDZ4y8gfimYRRfNbYS36w4MF50vJbYRMnlM0=
X-Received: by 2002:a17:903:3504:b0:2c0:c37d:dfc3 with SMTP id
 d9443c01a7336-2c1e820e96emr6903765ad.15.1780616949027; 
 Thu, 04 Jun 2026 16:49:09 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/25] target/arm: Implement COMPACT for byte/halfword
Date: Thu,  4 Jun 2026 16:48:48 -0700
Message-ID: <20260604234852.573178-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  2 ++
 target/arm/tcg/sve_helper.c      |  2 ++
 target/arm/tcg/translate-sve.c   | 22 +++++++++++++++++-----
 target/arm/tcg/sve.decode        |  1 -
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 75c0fc919d..11342e1e59 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -733,6 +733,8 @@ DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_trn_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p2_compact_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p2_compact_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 40cf567b0d..3f99a362c3 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3657,6 +3657,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
     }                                                                 \
 }
 
+DO_COMPACT(sve2p2_compact_b, uint8_t, H1)
+DO_COMPACT(sve2p2_compact_h, uint16_t, H1_2)
 DO_COMPACT(sve_compact_s, uint32_t, H1_4)
 DO_COMPACT(sve_compact_d, uint64_t, H1_8)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3101f572fa..325fc28fb3 100644
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
+        gen_helper_sve2p2_compact_b, gen_helper_sve2p2_compact_h,
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
-- 
2.43.0


