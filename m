Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8A4C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdf-0008Ms-6t; Fri, 24 Jan 2025 11:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-0005xw-Rq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZL-0005oz-0f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15095175e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736200; x=1738341000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KmmHXd9GrblPYO2aSGw968FOMap5vznRkrI2AiqmE4w=;
 b=qH0oYMqU9o5s4wwVzSBwco7pfy6QZEBDInydO3B+qlZlFJzfGBPphsw0Aav4g+NhBQ
 gKMmC+LEmKOL3YZYgJWVB1VR+eJisiaIWFyzi/ugbvFUPiUmi9gFHtxbMR/SnbCaIxQg
 vbRebeyYaJFsBhjp1fKthowYILp8YJp2EiJ+JtqhvnOZJTTcd8vgtkNbLxNX0cVr/G0H
 LgugBfE0o691UHx3MpVrfTaVlY/MgZ2bO9F7QlTFTfZzg74UJB8fo1u/URMlUSfqvduu
 a0wcSdtvCxvlJs1EgOjWOiTnsiYAsA89KiILTnkd6qYETINPX/Vzwe2krNv6ISzlJTQe
 9Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736200; x=1738341000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmmHXd9GrblPYO2aSGw968FOMap5vznRkrI2AiqmE4w=;
 b=ZuFWL2aJ43anHGloSIgUJbRj51CLwMze9B19UdcclwaWJWrCJtP1zLqMRMR91zvH3r
 zlzeeOX5ZyybuBoJ7BueknIHcyEgpd9G7lczMuyHifz6SsEm0ofNeNs/MZyqfFsK0vlQ
 sPe7sa7IFZISEVHqNKFTTyuLLwocf0hiHnqZBd1vU55rCqnxKDyEQkwL6APFLDNnS+A6
 PV75pig7m252LwLavMezSfq52aZ85XiGwO/Neg/XH82aD9OpLjtLHV5vz/6hjSNoUBRT
 4c3F37mI+zaE27G5BjSblPeLcRJoFOPU6xGSpPXdAfSjOiR4R1GAzDuRlN1zkQcVXeSx
 J+6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvsCH0Q6bM+iWGQloXuOVuHY97yyx8TMV2ZjCimleSMGeHEoEBhQdIaNHOPjncY6b9r1NJyHk018mp@nongnu.org
X-Gm-Message-State: AOJu0Yyz5QTqOVcWw9IPUzqWIz67AjxAT2byLHza26c3YLbMpEibyun1
 hveXUjhWctQzPOZFFPZjsngY4eIhtyfnbqPxhTWCgQtqvqQqzZNnVFI+gdbKSqVlgRWA0RPKrRF
 6
X-Gm-Gg: ASbGnculgst2f/y9819EIc+y4bqsmysl7i0wmlRFmc/aI9AeoUMZVSSOgriUvHkyzQ8
 iPxPWQ37O5hxm9BJUXyAVI5bW+pMVXEmM0bXnasyaRPeTLuOqsmyQe0TZPaZ8Tbp8obIhxSHWV1
 tnO/obwfy0FYfBtweiRUR5jgD2gLsteD66eGNEIzEWHncGeg1HDIBjV8n0dN5eqJ7bo5Lrp+2pm
 D0jsnN6QOPitX607+E6ER0l147kZlZt7AU6A49phQXGYWOCsboowkN6Igc0DLoRYi0gzc42vlO2
 v1wNYowPiDs=
X-Google-Smtp-Source: AGHT+IFgrOTfbmvYUDRThRL2Q/7/7+dsOaAZEs2mOoPtpsAnEiQsXDQzZ8eb3R1TXc1K9/bfz3Ablw==
X-Received: by 2002:a05:600c:4e08:b0:434:a4a6:51f8 with SMTP id
 5b1f17b1804b1-438912d4a3bmr316757715e9.0.1737736200464; 
 Fri, 24 Jan 2025 08:30:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 65/76] target/arm: Handle FPCR.AH in negation step in SVE FMLS
 (vector)
Date: Fri, 24 Jan 2025 16:28:25 +0000
Message-Id: <20250124162836.2332150-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics fro the
SVE FMLS (vector) insns, by providing new helpers for the AH=1 case
which end up passing fpcr_ah = true to the do_fmla_zpzzz_* functions
that do the work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  21 ++++++
 target/arm/tcg/sve_helper.c    | 114 +++++++++++++++++++++++++++------
 target/arm/tcg/translate-sve.c |  18 ++++--
 3 files changed, 126 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index a2e96a498dd..0b1b5887834 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1475,6 +1475,27 @@ DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index dc5a35b46ef..90bcf680fa4 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4802,7 +4802,7 @@ DO_ZPZ_FP(flogb_d, float64, H1_8, do_float64_logb_as_int)
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint16_t neg1, uint16_t neg3)
+                            uint16_t neg1, uint16_t neg3, bool fpcr_ah)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4814,9 +4814,15 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float16 e1, e2, e3, r;
 
-                e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
+                e1 = *(uint16_t *)(vn + H1_2(i));
                 e2 = *(uint16_t *)(vm + H1_2(i));
-                e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
+                e3 = *(uint16_t *)(va + H1_2(i));
+                if (neg1 && !(fpcr_ah && float16_is_any_nan(e1))) {
+                    e1 ^= neg1;
+                }
+                if (neg3 && !(fpcr_ah && float16_is_any_nan(e3))) {
+                    e3 ^= neg3;
+                }
                 r = float16_muladd(e1, e2, e3, 0, status);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
@@ -4827,30 +4833,48 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, false);
 }
 
 void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, false);
 }
 
 void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, false);
 }
 
 void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, false);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, true);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, true);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, true);
 }
 
 static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint32_t neg1, uint32_t neg3)
+                            uint32_t neg1, uint32_t neg3, bool fpcr_ah)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4862,9 +4886,15 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float32 e1, e2, e3, r;
 
-                e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
+                e1 = *(uint32_t *)(vn + H1_4(i));
                 e2 = *(uint32_t *)(vm + H1_4(i));
-                e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
+                e3 = *(uint32_t *)(va + H1_4(i));
+                if (neg1 && !(fpcr_ah && float32_is_any_nan(e1))) {
+                    e1 ^= neg1;
+                }
+                if (neg3 && !(fpcr_ah && float32_is_any_nan(e3))) {
+                    e3 ^= neg3;
+                }
                 r = float32_muladd(e1, e2, e3, 0, status);
                 *(uint32_t *)(vd + H1_4(i)) = r;
             }
@@ -4875,30 +4905,48 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, false);
 }
 
 void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, false);
 }
 
 void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, false);
 }
 
 void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, false);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, true);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, true);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, true);
 }
 
 static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint64_t neg1, uint64_t neg3)
+                            uint64_t neg1, uint64_t neg3, bool fpcr_ah)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4910,9 +4958,15 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float64 e1, e2, e3, r;
 
-                e1 = *(uint64_t *)(vn + i) ^ neg1;
+                e1 = *(uint64_t *)(vn + i);
                 e2 = *(uint64_t *)(vm + i);
-                e3 = *(uint64_t *)(va + i) ^ neg3;
+                e3 = *(uint64_t *)(va + i);
+                if (neg1 && !(fpcr_ah && float64_is_any_nan(e1))) {
+                    e1 ^= neg1;
+                }
+                if (neg3 && !(fpcr_ah && float64_is_any_nan(e3))) {
+                    e3 ^= neg3;
+                }
                 r = float64_muladd(e1, e2, e3, 0, status);
                 *(uint64_t *)(vd + i) = r;
             }
@@ -4923,25 +4977,43 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, false);
 }
 
 void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, false);
 }
 
 void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, false);
 }
 
 void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, false);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, true);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, true);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, true);
 }
 
 /* Two operand floating-point comparison controlled by a predicate.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a7033fe93ab..663634e3a39 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3924,19 +3924,25 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
-#define DO_FMLA(NAME, name) \
+#define DO_FMLA(NAME, name, ah_name)                                    \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
         NULL, gen_helper_sve_##name##_h,                                \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d            \
     };                                                                  \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp, name##_fns[a->esz], \
+    static gen_helper_gvec_5_ptr * const name##_ah_fns[4] = {           \
+        NULL, gen_helper_sve_##ah_name##_h,                             \
+        gen_helper_sve_##ah_name##_s, gen_helper_sve_##ah_name##_d      \
+    };                                                                  \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp,                     \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
                a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
-DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
-DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
-DO_FMLA(FNMLA_zpzzz, fnmla_zpzzz)
-DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
+/* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
+DO_FMLA(FMLA_zpzzz, fmla_zpzzz, fmla_zpzzz)
+DO_FMLA(FMLS_zpzzz, fmls_zpzzz, ah_fmls_zpzzz)
+DO_FMLA(FNMLA_zpzzz, fnmla_zpzzz, ah_fnmla_zpzzz)
+DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz, ah_fnmls_zpzzz)
 
 #undef DO_FMLA
 
-- 
2.34.1


