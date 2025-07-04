Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F3C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhaA-00066z-9N; Fri, 04 Jul 2025 10:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPd-0003bT-Lf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:14 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPY-00020j-QM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:13 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2edec6c5511so332974fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639345; x=1752244145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaetWJ15cQFkPEfdWC9a2/JW2VrVNcRjZFn2m3OFvj0=;
 b=F/G6SL/Vmdca6TIx1iahwF6uBq+1rqg5M1x/COUmDKO9Tb9Ngl5bO8ekNo7aQaPPsM
 arAgtVBNZdngHr+l1SgscRDF/7UroQ0KLjY6eXB4IjdhnBfOqB3CIFHlxubPK4NaFLJK
 saRHTO+BWc07+DoToRkAYQZYQEbseExOClZ3SRfU6/V8brZu0eJQ3gpYJewpu97oURfJ
 kXO81z8nZca5ydRxARtAJoQCBDnbuvtEjhfAyfNMh0PZm22LJJ1Ta3OpV4cjas/1lYnU
 CztM/yp8LWH0HfKBjIVQMjgCgPBOZmVKBR0XXD0V085oY1qQdFUXhS/DkWtWIt1utEwr
 yewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639345; x=1752244145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaetWJ15cQFkPEfdWC9a2/JW2VrVNcRjZFn2m3OFvj0=;
 b=tcGgUTx55bhR+XcxiwsWAH/Q2qI3QRmfWZQ7LkcGUtYwLU9G692EZwq2njKZsnxTtA
 6yVjqFJMmGYvVdYYbe6Uv9LIth5M1cKeWK5ZdqSM5qRsWlafCUJ0e5xs3Kfu8SSbtLmS
 C9UkPT9nE4EMtoiBrW+BqIR00EO5QzB9UaCfMrrnt9nfyVptCG3kqNwoI6AsHjl0bzkr
 iL4mRf2kMBtgsiOWQVHXp0GjCNmlVlWDVI0pCMeHUPZ4nz4DRBw5vAmoEPlHaxtnQ21n
 xPYjtDI2dxfUL27L6nPpQF0zwczJRpH5sDkYuJnXZz+6JJpZNUIobgt56Vncq2PP9oIV
 Atcg==
X-Gm-Message-State: AOJu0Yw0/oHwcZ2KfeTkyOEvwSnedesENQG01ojbWn+H9VnkeFlILalw
 wG8QTstyVp5yL8qsOUgyJE944QNOGSSM66jWyoGSu55NeuMurhie1Xh+b5z+hliZMlPSuIy1ZF0
 ll4PVp+g=
X-Gm-Gg: ASbGnctL4RRCL7MIUW0BF8uqlrS1aqekYxPu7h2+LQbKufAW9hCMyPjhFIbEF+J9FAk
 miCNmzNgGWvXHyZIqbBfpnn15GqVMR8Y2g95ATyox6bBDTjw2/4YzLX6p34v/B4E3+Y7pjGTKER
 ihSVjU2R72KYf5fyYi9OHTmYUWyeBTE0POH0O6eJZHZBDGWP/3CFIb5BKo6AnYb1+Iu8qofQfbH
 70wcaMQaGDQSlhsf4W5i7BYzVdkEWHdDNzPo59nXOGFLgKBwyPYDgB8avmGfIWOXts+wBRgvJZ+
 rXbJEfHuOWAZJ2pjjEg21C1J09nAioQpfp9KQrTPvgsjg8pwgTHQGRaaxhRqOMfBAjj1QAEB74b
 KfrXYsartgtwKQQm5QthraNEZlPpvmlZqmBKI+df5FZ1Bn6OJBPsKeZCUJ4E=
X-Google-Smtp-Source: AGHT+IGMbTk9W4e8KVhe79U4OAAQza0G/YxGPNomyCJMoJuLfAvYlNv7HNrF0PGX3UkXG/5BaV9UYQ==
X-Received: by 2002:a05:6870:4686:b0:2c2:4d76:f1ad with SMTP id
 586e51a60fabf-2f796a09a7amr1635362fac.16.1751639345416; 
 Fri, 04 Jul 2025 07:29:05 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:29:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 105/108] target/arm: Implement SME2 BFMOPA (non-widening)
Date: Fri,  4 Jul 2025 08:21:08 -0600
Message-ID: <20250704142112.1018902-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index d23d9f08d2..bb8ed1ed0e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1144,6 +1144,57 @@ void HELPER(sme_ah_fmops_d)(void *vza, void *vzn, void *vzm, void *vpn,
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


