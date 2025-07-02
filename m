Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C86C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwso-0000s2-Lx; Wed, 02 Jul 2025 08:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnJ-0000Eq-EB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:34 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn5-0003GH-Mb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:31 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ea65f5a0easo3853779fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460136; x=1752064936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvihNMiHBBdfaD3xvWfBuWdD9CPgOGtvc7SRDhNV2pY=;
 b=L9lc3rXeTDB8ghhsATlltjP6RYxmrdM3PoVnrX0vEkU4RIniCLidwzFDH8HnKeboKh
 7Rj7XIeEt7M5PaYjdlXrLGZzVGL/LkeO+4p7DYsMSury/6vHdRsuTNqyuI/RuQZIVU2q
 HNNdeNozGxVq9EwAxGKrRdqc8Vq5e/ZfrNWBIoUc4P5P0UC7Ob2rIFjO+HCnAeH4FWHV
 U1zB2G1+qE3mG2N9tHqvg6uoit90I30uUWi0YBbvymLuY3T9AsQfTcLjVAiHFW278exm
 VtMn4oY1rJoHWx34rTROsrwOgR8TWeZUqMCgm0gB3Onc6ARnlreWP12z9el79nBn8Elj
 N5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460136; x=1752064936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvihNMiHBBdfaD3xvWfBuWdD9CPgOGtvc7SRDhNV2pY=;
 b=diC8DdWZNY77O2NoF0rQYcXaD6FXp4xVoxY11dfQr3CxnKMKA5N7z7u8X+nZevk1yD
 JFVNubRP+hBzt07NFLDKYpbC7nm8Gi8oNMEYvxo6kALRJq3CbAM2vGdAXgbEa+bMPMhK
 7H14Lr2WY2CBWQ3JODqidhWEPEoZe0zoy74JxFzndC7chUR2Ep5nuUHRC5rGXA0WPSlR
 QH9alRp2j1//MfUwN5kQ3iiShgmyK92iyOC34Z0er+8vFoUUnf87EC4BFWbkPa0LzHrQ
 hTNewEm20lhXgwtkiOysmwcxLVqKP8IbTKf+QQcV4d5lnabDEV/H/c4kfUEtWYayQzMI
 T1lA==
X-Gm-Message-State: AOJu0YxkYJAWF/vAfpn3MbcE6/n8/kP6HULOWVOtwFxQJWPg12ydABuD
 z3lbBGlZLyfwZ/l75AY1+25naZyXel66k21zOylOclv6aHHwOd6O84pXifkRgq+Ek+1vHclIAwj
 q90mOI70=
X-Gm-Gg: ASbGnctamWJ67Nc521/97antEPFP8RP3ffEjjoHjIFYBnZQNpxiJtSHkPvOrUNtY0HT
 RvWGrJKFRdaI9SSOIjsAKyhNqUY/qwz+tvESZTuRvtXT+/UUVZoSY3x8uW1e9pxUFKGa4TxUTyk
 6QurfUWTJe5jYspIepZYKs4DAmZOXHQGDvvaGG1O3IAG0J5ssRUDZ8klp+BNactN5dIK+seYLFE
 SGR1Muw+hdtxddBNt/AQO9Q9VoC8eqj1pWs72hm5draah0uhrPUm6U0VUi2D55dkFoxc8b4vAlY
 dH2/778JnkovB0vO7r87s0r7IqoPiC24KJrNG0xbeERj2zP07epo9EpCqArzfs8+iRHTag==
X-Google-Smtp-Source: AGHT+IHOsZmhncaAQjpYnF8okyFECuhnceSHHqhJpO1Uo8p4dhvc+fIvDeltH4qc1rQduno2IMEGtg==
X-Received: by 2002:a05:6870:469f:b0:2da:b440:5b1 with SMTP id
 586e51a60fabf-2f6472a5f71mr1797010fac.5.1751460135785; 
 Wed, 02 Jul 2025 05:42:15 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 94/97] target/arm: Implement SME2 BFMOPA (non-widening)
Date: Wed,  2 Jul 2025 06:34:07 -0600
Message-ID: <20250702123410.761208-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 ++++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 64 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index fac70a82b9..1fc756bec6 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -145,6 +145,8 @@ DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
@@ -156,6 +158,8 @@ DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_bfmops, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
@@ -167,6 +171,8 @@ DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_bfmops_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_bfmops, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3420685198..fb2b3d9321 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1137,6 +1137,57 @@ void HELPER(sme_ah_fmops_d)(void *vza, void *vzn, void *vzm, void *vpn,
                float_muladd_negate_product);
 }
 
+static void do_bfmopa(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                      uint16_t *pm, float_status *fpst, uint32_t desc,
+                      uint16_t negx, int negf)
+{
+    intptr_t row, col, oprsz = simd_maxsz(desc);
+
+    for (row = 0; row < oprsz; ) {
+        uint16_t pa = pn[H2(row >> 4)];
+        do {
+            if (pa & 1) {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint16_t n = *(uint32_t *)(vzn + H1_2(row)) ^ negx;
+
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pb = pm[H2(col >> 4)];
+                    do {
+                        if (pb & 1) {
+                            uint16_t *a = vza_row + H1_2(col);
+                            uint16_t *m = vzm + H1_2(col);
+                            *a = bfloat16_muladd(n, *m, *a, negf, fpst);
+                        }
+                        col += 2;
+                        pb >>= 2;
+                    } while (col & 15);
+                }
+            }
+            row += 2;
+            pa >>= 2;
+        } while (row & 15);
+    }
+}
+
+void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
+                        void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_bfmops)(void *vza, void *vzn, void *vzm, void *vpn,
+                        void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 15, 0);
+}
+
+void HELPER(sme_ah_bfmops)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_bfmopa(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+              float_muladd_negate_product);
+}
+
 /*
  * Alter PAIR as needed for controlling predicates being false,
  * and for NEG on an enabled row element.
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 119a5665e6..65fc8bc9b2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -582,6 +582,11 @@ TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a, MO_64, FPST_ZA,
            : !s->fpcr_ah ? gen_helper_sme_fmops_d
            : gen_helper_sme_ah_fmops_d)
 
+TRANS_FEAT(BFMOPA, aa64_sme_b16b16, do_outprod_fpst, a, MO_16, FPST_ZA,
+           !a->sub ? gen_helper_sme_bfmopa
+           : !s->fpcr_ah ? gen_helper_sme_bfmops
+           : gen_helper_sme_ah_bfmops)
+
 TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            !a->sub ? gen_helper_sme_bfmopa_w
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3c58fdd2a0..6bb9aa2a90 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -191,6 +191,8 @@ FMOPA_h         10000001 100 ..... ... ... ..... . 100 .        @op_16
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
+BFMOPA          10000001 101 ..... ... ... ..... . 100 .        @op_16
+
 BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
-- 
2.43.0


