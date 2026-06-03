Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D6FCD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcLS-000269-9C; Tue, 02 Jun 2026 23:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLI-0001XQ-MX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLF-0004ci-Jq
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36b7b7b7a80so119023a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457548; x=1781062348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcUdpMLyTWJf5Zy34vFVIdzyaHCSAKrz+Dcw2eeWrsQ=;
 b=QqtjciZzJ6Q5g++z3ectYaJ01+FYZNUDMH4n1llYRXrYPTuN2LnY40xFAS5A28ecGQ
 ouSqF/qENkOFiMZqdvJFiaP4fsHmjNR/Nd8y8Stv3LDym8vJ/hoPTWU33T22YUSe/9Ph
 jYdYOXwI5v/+al5eAD1tZVW86jSin+OHBln80A5Las0EgM13HNxx6+r3+3zPaQGhidOF
 /09iKYyK2/NrAUpO+sNhIFUDFI4AbART6FUs3KpRAerWzL+jw/CzBc0VWnh+OofzXGVd
 RruTYjj41CRiANQetCsTdLPuhyM7wKvrXJxyy6cqq2rmrPlppEJAvZbU8Tn5rOKAed8M
 wZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457548; x=1781062348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jcUdpMLyTWJf5Zy34vFVIdzyaHCSAKrz+Dcw2eeWrsQ=;
 b=TJZ9Z9vTjSH8IsL1IYrLLpuNoIqYag5dxGS4cdApFkw5VvNDeX+hEEV30bQskwpKYy
 xkcD2zGi3GTYqQvaVzUCdXyIGj3L5WRve4Wd8l9Lc6XIOKL5aw7THXOb/ML1X6PB5RyZ
 zp4NleaEbOJNRvJMNYuZfY+6HsNz/Bj2HhTjQ3ErRzigFN+vnILV5jHTVVF+rAewFHKH
 oOoMtkVI1g6MtnOH60Pq9f9JK3320aOwf8/oXZVXtA7hgR7bcseTboLOc2fiYE2pFK1M
 Ls4quk1U9NbmeEIqE8WDzHcmCnaurFB9T8xLHITd1k5ElDWD5JihHjRpRST6Ew4zK5w7
 ps6w==
X-Gm-Message-State: AOJu0YwQOqTXS/ldMhQ10oTGi/zaHokIR/+Ix9ny3FpsO/SijGlT6r7H
 xXeWsXgoNtwrEjckQ9W1H9IWim3EGiBNX6zZ/ptXo9D4i+93KGCWvjCdVY3taXbbHhsHQFDPlRY
 Zg50bbjI=
X-Gm-Gg: Acq92OEkPNnKLEzoC1XwEX5atqK/mjL5ZTG0ruVAIQYp5vWjXhgA6epbD28p1CdZQFw
 zHecm5dAlfRoOT6kTP4pKCWWSohJkYU7nHjwCqxxD7hbutvPmC4OC15LFF2G88RPX9BUKTZyMxI
 vRFPnvPTMQDv8FUXh8fiVwnAtNjcFyP7TxHbhI4Lo3bJbkVUI/rRSr1iZZ3242vmK8atubCViue
 89KJX5pNOaXXjr6CeogE24kUFaAfRtm6vPjjcyevD9dg4zqdSrviT/m60f3LBLbG6WH1dXgsNoc
 zCALH8X3etdpvJwwFy+WrskbIMNRxWzb0/EHnH9XARWIvBGUs0nUAorcty9St9TeraZeOvmNbvl
 3DD2O9iJi6/U0EkGzn9W2dg8mhy/iFpBYnlJc31Wb8oLLZ/IW6EAz9MV6a1WzuYQu2QyGKMKuoy
 xuWrSQHtZkt6qzeGJplC9EPr45Qx1Em4FWBk3XA+VoNjlxtx0drA==
X-Received: by 2002:a17:903:1786:b0:2b9:6cde:c34b with SMTP id
 d9443c01a7336-2c164b2adeemr11286295ad.15.1780457547766; 
 Tue, 02 Jun 2026 20:32:27 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm7785685ad.33.2026.06.02.20.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 43/45] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Tue,  2 Jun 2026 20:28:52 -0700
Message-ID: <20260603032855.106930-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2b1d1034c0..6d65706186 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1635,6 +1635,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 9db4ff4c2f..8365da9893 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -831,3 +831,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 8;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[H4(0)], m[H4(0)], 4, d[H2(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[H4(0)], m[H4(1)], 4, d[H2(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[H4(1)], m[H4(0)], 4, d[H2(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[H4(1)], m[H4(1)], 4, d[H2(3)], &ctx);
+
+        d[H2(0)] = d0;
+        d[H2(1)] = d1;
+        d[H2(2)] = d2;
+        d[H2(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 367f87f05d..126b7b44b8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7502,6 +7502,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6922e91010..28cd1faf61 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1228,6 +1228,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


