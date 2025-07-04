Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E73C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWY-0007JH-2h; Fri, 04 Jul 2025 10:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPd-0003ao-AC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:14 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPY-0001wk-PK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:12 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so211519fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639344; x=1752244144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeNVKwtvSWzfTAd3k1fcKH4xf4XoDEBrDb3NZwoYAzA=;
 b=PGpVAOYoqUiM3x5uc2SYkrzfl1GY8Y0gEJVylh9QobPZzqQdHCF3N4cYnTUKPuwYwH
 57pP6gJ2EH0JT+eyYnaf8eoIP+bzopTqM/k5VbDnJ55C5KQ0uQcZTqPOemovThJmr974
 Jhfsf/u2QdRgEZDQt4XX5JLjci25SMLqQgPf5W1mxCPpgJ2t33oXarOPl5tuLl6StfmX
 9/LEkbaKGXuYBzcJT3mY9dwb2+p2qfXX+o8ZcyUDFVZ6qR1vG5BEpIWqmtchM4CKJOB2
 pHq/qG6V6xgqhTXKWBhVEOv6ndrB6t93ZxTfb3cw1+2w/zixZyU2onN/cFXMciLxLWsE
 /RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639344; x=1752244144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeNVKwtvSWzfTAd3k1fcKH4xf4XoDEBrDb3NZwoYAzA=;
 b=kB2xAVEimgzf4KI+bUiN6NYo4y/41cCqL4GMwCBIyt7EulyHV8Zaa5oybRn3j4G00g
 4x3ffKmLjOlPkokGnqV8KOMpmQPIQo5WSdtTlfVEOS6bprlloA7nreMcraBb7iVWjKSE
 MIKq/XhXABofq1DxfXKuMVg/n9/JhJ8Ryg5gEOXuGUu1fpq+hFCooEl3Q+LZ7p+N8eXA
 r97i6N6YVtq4FKvFlR60dz1jHch3HFSwiNkDy798tdVlhUXyFNYiRhbK43omsuD8Uak0
 l6Zzcof9ad9b1m3ftFBXYQnEH21IZpnJnWP3E/A5FcraPF4Fuk8azp/hYQGM0fB6Gxwe
 bBYQ==
X-Gm-Message-State: AOJu0Yz7gGuwLsJPgyAxTXTwvXT2tkOLZsz/CBejmP0AZdBTQmF2LXAu
 mQ3M3inBYXqesdCaUCDIiR1F6SLKMZHLS/pcgg7vrm89OdhsC+Q3SXC+T6XD1Vydu4DYFBcHV0E
 czPJkM4o=
X-Gm-Gg: ASbGncsH6wBaa4SSCEPGQZkJc7HV/Ny8z5uT6g5SehJnEPUKywpR+75jXoo70PB4FoG
 BDXOiLT+NlZsVOBVtrXKrTmb6qhmrc5WXJxbTkgsYINFV3hw/WTBUiA1+WXfQO0yq6QRvzFkOlC
 BEbILj5MuJpio4Pq8NIrtOR5hb93D9L6LCXSDQ1vpzIGeC1wHVwnPKebEfNI9Nji7VpZADwlzZ/
 E5hIqq5QNwsbpb7geMDLeTeoJv4s4NYV9mjkS8ipHpcv8ct+pwKlZrOL5fd9ccNDKzI7uA9nV10
 eyM9btVu5VOPgQggI1Yfvs3T5ZxBCz+mfOr8RZpNT/2AqkEwfvooZLedocSNwJePuIpsdKiSufu
 xm3kpLV+kgO1v+k6RSsi83SErvJAubmFjgyyo8yRoAYbPWS4C
X-Google-Smtp-Source: AGHT+IEx6Ze62pDKfPs7wG4Dytn88pewLs7GfpWSvSLL6gQ7c5zPCFQPNjiHyX1nKV+kVkAHIpdeYw==
X-Received: by 2002:a05:6870:1484:b0:2d6:2a40:fbe7 with SMTP id
 586e51a60fabf-2f796a56f59mr1899344fac.6.1751639343963; 
 Fri, 04 Jul 2025 07:29:03 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:29:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 104/108] target/arm: Implement FMOPA (non-widening) for fp16
Date: Fri,  4 Jul 2025 08:21:07 -0600
Message-ID: <20250704142112.1018902-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  6 ++++
 target/arm/tcg/sme_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  4 +++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 63 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 2b22c6aee5..fac70a82b9 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -137,6 +137,8 @@ DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
@@ -146,6 +148,8 @@ DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmops_d, TCG_CALL_NO_RWG,
@@ -155,6 +159,8 @@ DEF_HELPER_FLAGS_7(sme_bfmops_w, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_7(sme_ah_fmops_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_ah_fmops_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_ah_fmops_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index eff0ce7480..d23d9f08d2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1002,6 +1002,57 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
     }
 }
 
+static void do_fmopa_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
+                       uint16_t *pm, float_status *fpst, uint32_t desc,
+                       uint16_t negx, int negf)
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
+                            *a = float16_muladd(n, *m, *a, negf, fpst);
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
+void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0, 0);
+}
+
+void HELPER(sme_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                         void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 1u << 15, 0);
+}
+
+void HELPER(sme_ah_fmops_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                            void *vpm, float_status *fpst, uint32_t desc)
+{
+    do_fmopa_h(vza, vzn, vzm, vpn, vpm, fpst, desc, 0,
+               float_muladd_negate_product);
+}
+
 static void do_fmopa_s(void *vza, void *vzn, void *vzm, uint16_t *pn,
                        uint16_t *pm, float_status *fpst, uint32_t desc,
                        uint32_t negx, int negf)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 782f408061..119a5665e6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -569,6 +569,10 @@ TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a, MO_32,
            !a->sub ? gen_helper_sme_fmopa_w_h
            : !s->fpcr_ah ? gen_helper_sme_fmops_w_h
            : gen_helper_sme_ah_fmops_w_h)
+TRANS_FEAT(FMOPA_h, aa64_sme_f16f16, do_outprod_fpst, a, MO_16, FPST_ZA_F16,
+           !a->sub ? gen_helper_sme_fmopa_h
+           : !s->fpcr_ah ? gen_helper_sme_fmops_h
+           : gen_helper_sme_ah_fmops_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, FPST_ZA,
            !a->sub ? gen_helper_sme_fmopa_s
            : !s->fpcr_ah ? gen_helper_sme_fmops_s
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8ad86f707e..3c58fdd2a0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -183,9 +183,11 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 ### SME Outer Product
 
 &op             zad zn zm pm pn sub:bool
+@op_16          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 ... zad:1 &op
 @op_32          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .. zad:2 &op
 @op_64          ........ ... zm:5 pm:3 pn:3 zn:5 sub:1 .  zad:3 &op
 
+FMOPA_h         10000001 100 ..... ... ... ..... . 100 .        @op_16
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
-- 
2.43.0


